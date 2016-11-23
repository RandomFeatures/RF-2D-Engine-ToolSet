{*****************************************************************************
 Digital Tome Game Design Utility

 Copyright ©1999-2000 Digital Tome L.P. Texas USA
 Not for public release/use.

 // INSERT SHORT DESCRIPTION OF THIS UNIT HERE

*****************************************************************************}
unit DFX;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, digifx,
  StdCtrls, ExtCtrls, GIFCode;

const
  pixelformats: array[0..2] of DWORD = (PIXFMT_555, PIXFMT_565, PIXFMT_888);
  POXHEADER = $41584F50;

var
  dfx_pixelformat: DWORD = 0;
  dfx_hnd: DFXHND = 0;
  pf_index: Integer = 0;
  Angle: integer;

type
  TRLESprite = class(TObject)
  private
    PicCnt: DWORD;
    lpSpr: PRLEHDR;
    FMemSize: LongWord;
    function GetImage(Index: DWORD): PRLEHDR;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromRLE(FileName: string);
    procedure SaveToRLE(FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromBitmap(BITMAP: TBitmap; FrameWidth, FrameHeight: Integer; Color: TColor);
    procedure LoadFromGIF(GIF: TGIF; Color: TColor);
    procedure Draw(Index: LongWord; X, Y: Integer; Bits: PBITPLANE);
    procedure DrawBlend(Index: LongWord; X, Y: Integer; Bits: PBITPLANE; SrcBlend, DstBlend: DWORD);
    procedure DrawMono(Index: LongWord; X, Y: Integer; Bits: PBITPLANE; Color: TColor);
    procedure DrawColorize(Index: longword; X, Y: integer; Bits: PBITPLANE; R,G,B,SrcBlend,DstBlend: integer);
    property Frames: DWORD read PicCnt;
    property Image[Index: DWORD]: PRLEHDR read GetImage;
    property MemSize: LongWord read FMemSize;
  end;

  TBitPlane = class(TObject)
  private
    FKeyColor: TColor;
    FKeyIndex: LongWord;
    R, G, B: Byte;
    function GetBits: PBITPLANE;
    function GetHeight: LongWord;
    function GetWidth: LongWord;
    procedure SetKeyColor(const Value: TColor);
  public
    FBits: BITPLANE;
    constructor Create(Width, Height: Integer);
    destructor Destroy; override;
    procedure DrawToDC(DC: HDC; X, Y: Integer);
    procedure StretchDrawToDC(DC: HDC; X, Y, W, H: Integer);
    procedure Clear;
    procedure Fill(Color: TColor);
    procedure Draw(X, Y: Integer; Bits: PBITPLANE);
    procedure DrawMono(X, Y: Integer; Bits: PBITPLANE; Color: TColor);
    procedure DrawBlend(X, Y: Integer; Bits: PBITPLANE; SrcBlend, DstBlend: DWORD);
    procedure DrawOutline(X,Y: integer; Bits: PBITPLANE; Color: TColor; Copy: boolean);
    procedure DrawColorize(X, Y: integer; Bits: PBITPLANE; R,G,B,SrcBlend,DstBlend: integer);
    procedure DrawShadow(X, Y: Integer; Bits: PBITPLANE; SrcBlend, DstBlend: DWORD);
    property Bits: PBITPLANE read GetBits;
    property Width: LongWord read GetWidth;
    property Height: LongWord read GetHeight;
    property KeyColor: TColor read FKeyColor write SetKeyColor;
  end;

function DFXInit(Path: string): BOOL;
procedure DFXShutdown;
procedure DFXClearBitPlane(Plane: BITPLANE; Color: DWORD);

implementation

procedure DFXClearBitPlane(Plane: BITPLANE; Color: DWORD);
begin
  asm
    mov  ecx, Plane.bitsHgh
    mov  eax, Plane.bitsWdh
    mul  ecx
    mov  ecx, eax
    mov  eax, Color
    mov  edi, Plane.bitsPtr
    rep  stosw
  end;
end;

function DFXCheckSupport: BOOL;
var
  dfx_blitfx: BLITFX;
  rlehdr_temp: RLEHDR;
  bitplane_temp: BITPLANE;
  my_bitplane: BITPLANE;
begin
  my_bitplane.bitsFmt := dfx_pixelformat;
  dfx_blitfx.FXType := BLITFX_BLEND;
  dfx_blitfx.BlendSrcFactor := 0;
  dfx_blitfx.BlendDstFactor := 0;

  rlehdr_temp.PixFmt := dfx_pixelformat;
  rlehdr_temp.DataPtr := nil;
  bitplane_temp.bitsFmt := dfx_pixelformat;
  bitplane_temp.bitsPtr := nil;

  Result := False;

  if (not digifxCheckSupport(dfx_hnd, DFX_DRAWRLE, @dfx_blitfx, @rlehdr_temp, @my_bitplane)) then Exit;
  if (not digifxCheckSupport(dfx_hnd, DFX_DRAWBITPLANE, @dfx_blitfx, @bitplane_temp, @my_bitplane)) then Exit;

  dfx_blitfx.FXType := BLITFX_TEXTURED;
  rlehdr_temp.PixFmt := dfx_pixelformat;
  rlehdr_temp.DataPtr := nil;

  if (not digifxCheckSupport(dfx_hnd, DFX_DRAWRLE, @dfx_blitfx, @rlehdr_temp, @my_bitplane)) then Exit;
  dfx_blitfx.FXType := BLITFX_MONO;
  if (not digifxCheckSupport(dfx_hnd, DFX_DRAWRECT, @dfx_blitfx, @rlehdr_temp, @my_bitplane)) then Exit;
  if (not digifxCheckSupport(dfx_hnd, DFX_DRAWLINE, @dfx_blitfx, @rlehdr_temp, @my_bitplane)) then Exit;

  Result := True;
end;

function DFXEnumProc(driverinfo: PChar): BOOL;
begin
  Result := False;

  dfx_hnd := digifxLoadDriver(driverinfo, dfx_pixelformat);
  if (dfx_hnd <> 0) then begin
{$IFDEF DirectX}
    if dfx_pixelformat=PIXFMT_555 then begin
      if DDColorMatch(lpDDSBack,clWhite)<=32767 then exit;
    end
    else if dfx_pixelformat=PIXFMT_565 then begin
      if DDColorMatch(lpDDSBack,clWhite)>32767 then exit;
    end
{$ENDIF}
{$IFNDEF DirectX}
//    if (DFXCheckSupport()) then begin
    if dfx_pixelformat=PIXFMT_565 then begin
      Exit;
    end;
{$ENDIF}
  end;

  digifxFreeDriver(dfx_hnd);
  dfx_hnd := 0;

  Result := True;
end;

function DFXInit(Path: string): BOOL;
begin
  Result := False;

  if not digifxInit(PChar(Path)) then Exit;

  repeat
    dfx_pixelformat := pixelformats[pf_index];
    Inc(pf_index);
    digifxEnumDrivers(@DFXEnumProc);
  until (dfx_hnd <> 0) or (pf_index = High(pixelformats));

  Result := (dfx_hnd <> 0);
end;

procedure DFXShutdown;
begin
  digifxFreeDriver(dfx_hnd);
  digifxDone();
end;

{ TRLESprite }

procedure TRLESprite.LoadFromRLE(FileName: string);
var
  TmpFile: THandle;
  Size, BuffSize, BytesCnt, i: DWORD;
  lpRLE: PChar;
  RelocOffset: Longword;
  p: PRLEHDR;
begin
  if Assigned(lpSpr) then begin
    FreeMem(lpSpr.DataPtr);
    FreeMem(lpSpr);
    lpSpr := nil;
  end;

  TmpFile := CreateFile(PChar(FileName), GENERIC_READ, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (TmpFile = INVALID_HANDLE_VALUE) then
    raise Exception.CreateFmt('Could not load file %s.', [FileName]);

  ReadFile(TmpFile, PicCnt, SizeOf(PicCnt), BytesCnt, nil);
  ReadFile(TmpFile, BuffSize, SizeOf(BuffSize), BytesCnt, nil);
  Size := PicCnt * SizeOf(RLEHDR);
  GetMem(lpSpr, Size);
  ReadFile(TmpFile, lpSpr^, Size, BytesCnt, nil);
  GetMem(lpRLE, BuffSize);
  ReadFile(TmpFile, lpRLE^, BuffSize, BytesCnt, nil);
  CloseHandle(TmpFile);

  FMemSize := BuffSize;

  RelocOffset := lpRLE - lpSpr.DataPtr;
  p := lpSpr;
  for i := 1 to PicCnt do begin
    p.DataPtr := PChar(p.DataPtr + RelocOffset);
    digifxConvertRLE(dfx_hnd, p);
    Inc(p);
  end;
end;

procedure TRLESprite.LoadFromGIF(GIF: TGIF; Color: TColor);
var
  i, k: Integer;
  BuffSize: DWORD;
  lpRLE: PRLEHDR;
  Bits: BITPLANE;
  TempBitmap: TBitmap;
  ImageSize: Cardinal;
  p: ^Byte;
  C: LongWord;
  R, G, B: Byte;
  Sizes, PSize: ^LongWord;
begin
  if Assigned(lpSpr) then begin
    FreeMem(lpSpr.DataPtr);
    FreeMem(lpSpr);
    lpSpr := nil;
  end;

  PicCnt := GIF.Frames;
  BuffSize := PicCnt * SizeOf(RLEHDR);
  GetMem(lpSpr, BuffSize);
  ZeroMemory(lpSpr, BuffSize);
  lpRLE := lpSpr;
  GetMem(Sizes, PicCnt * SizeOf(LongWord));

  C := Color;
  R := (C and $FF);
  G := (C and $FF00) shr 8;
  B := (C and $FF0000) shr 16;
  C := digiFXConvertColor(dfx_hnd, R, G, B);

  PSize := Sizes;
  FMemSize := 0;
  for i := 0 to PicCnt - 1 do begin
    TempBitmap := GIF.GetFrame(i+1);
    try
      TempBitmap.PixelFormat := pf16bit;

      Bits.bitsWdh := TempBitmap.Width;
      Bits.bitsPitch := Bits.bitsWdh * 2;
      Bits.bitsHgh := TempBitmap.Height;
      Bits.bitsFmt := PIXFMT_565;
      GetMem(Bits.bitsPtr, Bits.bitsPitch * Bits.bitsHgh);

      p := Pointer(Bits.bitsPtr);
      for k := 0 to TempBitmap.Height - 1 do begin
        CopyMemory(p, TempBitmap.ScanLine[k], Bits.bitsPitch);
        Inc(p, Bits.bitsPitch);
      end;

    finally
      TempBitmap.Free;
    end;

    ImageSize := digifxCreateRLE(dfx_hnd, @Bits, C, lpRLE, nil, lpSpr);
    PSize^ := ImageSize;
    Inc(FMemSize, ImageSize);

    GetMem(p, ImageSize);
    digifxCreateRLE(dfx_hnd, @Bits, C, lpRLE, p, lpSpr);
    lpRLE.AdjX := lpRLE.SrcX;
    lpRLE.AdjY := lpRLE.SrcY;

    Inc(lpRLE);
    FreeMem(Bits.bitsPtr);
    Inc(PSize);
  end;

  lpRLE := lpSpr;
  PSize := Sizes;
  GetMem(p, FMemSize);
  for i := 1 to PicCnt do begin
    CopyMemory(p, lpRLE.DataPtr, PSize^);
    FreeMem(lpRLE.DataPtr);
    lpRLE.DataPtr := Pointer(p);
    Inc(p, PSize^);
    Inc(lpRLE);
    Inc(PSize);
  end;

  FreeMem(Sizes);
end;

procedure TRLESprite.LoadFromBitmap(BITMAP: TBitmap; FrameWidth, FrameHeight: Integer; Color: TColor);
var
  i, j, k, W, H: Integer;
  BuffSize: DWORD;
  lpRLE: PRLEHDR;
  Bits: BITPLANE;
  TempBitmap: TBitmap;
  ImageSize: Cardinal;
  p: ^Byte;
  C: LongWord;
  R, G, B: Byte;
  Sizes, PSize: ^LongWord;
begin
  if Assigned(lpSpr) then begin
    FreeMem(lpSpr.DataPtr);
    FreeMem(lpSpr);
    lpSpr := nil;
  end;

  W := BITMAP.width div FrameWidth;
  H := BITMAP.Height div FrameHeight;
  PicCnt := W * H;
  BuffSize := PicCnt * SizeOf(RLEHDR);
  GetMem(lpSpr, BuffSize);
  ZeroMemory(lpSpr, BuffSize);
  lpRLE := lpSpr;
  GetMem(Sizes, PicCnt * SizeOf(LongWord));

  C := ColorToRGB(Color);
  R := (C and $FF);
  G := (C and $FF00) shr 8;
  B := (C and $FF0000) shr 16;
  C := digiFXConvertColor(dfx_hnd, R, G, B);

  PSize := Sizes;
  FMemSize := 0;
  for j := 0 to H - 1 do begin
    for i := 0 to W - 1 do begin
      TempBitmap := TBitmap.Create;
      TempBitmap.width := FrameWidth;
      TempBitmap.Height := FrameHeight;

      BitBlt(TempBitmap.Canvas.Handle, 0, 0, FrameWidth, FrameHeight,
        BITMAP.Canvas.Handle, i * FrameWidth, j * FrameHeight, SRCCOPY);
      TempBitmap.PixelFormat := pf16bit;

      Bits.bitsWdh := FrameWidth;
      Bits.bitsPitch := Bits.bitsWdh * 2;
      Bits.bitsHgh := FrameHeight;
      Bits.bitsFmt := PIXFMT_565;
      GetMem(Bits.bitsPtr, Bits.bitsPitch * Bits.bitsHgh);

      p := Pointer(Bits.bitsPtr);
      for k := 0 to FrameHeight - 1 do begin
        CopyMemory(p, TempBitmap.ScanLine[k], Bits.bitsPitch);
        Inc(p, Bits.bitsPitch);
      end;

      TempBitmap.Free;

      ImageSize := digifxCreateRLE(dfx_hnd, @Bits, C, lpRLE, nil, lpSpr);
      PSize^ := ImageSize;
      Inc(FMemSize, ImageSize);

      GetMem(p, ImageSize);
      digifxCreateRLE(dfx_hnd, @Bits, C, lpRLE, p, lpSpr);
      lpRLE.AdjX := lpRLE.SrcX;
      lpRLE.AdjY := lpRLE.SrcY;

      Inc(lpRLE);
      FreeMem(Bits.bitsPtr);
      Inc(PSize);
    end;
  end;

  lpRLE := lpSpr;
  PSize := Sizes;
  GetMem(p, FMemSize);
  for i := 1 to PicCnt do begin
    CopyMemory(p, lpRLE.DataPtr, PSize^);
    FreeMem(lpRLE.DataPtr);
    lpRLE.DataPtr := Pointer(p);
    Inc(p, PSize^);
    Inc(lpRLE);
    Inc(PSize);
  end;

  FreeMem(Sizes);
end;

procedure TRLESprite.SaveToRLE(FileName: string);
var
  TmpFile: THandle;
  BuffSize, BytesCnt: DWORD;
begin
  TmpFile := CreateFile(PChar(FileName), GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if (TmpFile = INVALID_HANDLE_VALUE) then Exit;

  BuffSize := FMemSize;

  WriteFile(TmpFile, PicCnt, SizeOf(PicCnt), BytesCnt, nil);
  WriteFile(TmpFile, BuffSize, SizeOf(BuffSize), BytesCnt, nil);
  WriteFile(TmpFile, lpSpr^, PicCnt * SizeOf(RLEHDR), BytesCnt, nil);
  WriteFile(TmpFile, lpSpr.DataPtr^, BuffSize, BytesCnt, nil);
  CloseHandle(TmpFile);
end;

constructor TRLESprite.Create;
begin
  inherited;
end;

destructor TRLESprite.Destroy;
begin
  FreeMem(lpSpr.DataPtr);
  FreeMem(lpSpr);
  inherited;
end;

function TRLESprite.GetImage(Index: DWORD): PRLEHDR;
begin
  if (Index < PicCnt) then begin
    Result := lpSpr;
    Inc(Result, Index);
  end
  else begin
    Result := nil;
  end;
end;

procedure TRLESprite.Draw(Index: LongWord; X, Y: Integer; Bits: PBITPLANE);
var
  dfx_blitfx: BLITFX;
begin
  dfx_blitfx.FXType := BLITFX_NONE;
  try
    digifxDrawRLE(dfx_hnd, Image[Index], X, Y, @dfx_blitfx, Bits);
  except
  end;
end;

procedure TRLESprite.DrawBlend(Index: LongWord; X, Y: Integer;
  Bits: PBITPLANE; SrcBlend, DstBlend: DWORD);
var
  dfx_blitfx: BLITFX;
begin
  dfx_blitfx.FXType := BLITFX_BLEND;
  dfx_blitfx.BlendSrcFactor := SrcBlend;
  dfx_blitfx.BlendDstFactor := DstBlend;
  digifxDrawRLE(dfx_hnd, Image[Index], X, Y, @dfx_blitfx, Bits);
end;

procedure TRLESprite.DrawMono(Index: LongWord; X, Y: Integer;
  Bits: PBITPLANE; Color: TColor);
var
  dfx_blitfx: BLITFX;
  C: Longint;
begin
  C := ColorToRGB(Color);
  dfx_blitfx.FXType := BLITFX_MONO;
  dfx_blitfx.Color.R := (C and $FF);
  dfx_blitfx.Color.G := (C and $FF00) shr 8;
  dfx_blitfx.Color.B := (C and $FF0000) shr 16;
  digifxDrawRLE(dfx_hnd, Image[Index], X, Y, @dfx_blitfx, Bits);
end;

procedure TRLESprite.DrawColorize(Index: longword; X, Y: integer; Bits: PBITPLANE; R,G,B,SrcBlend,DstBlend: integer);
var
  dfx_blitfx : BLITFX;
begin
  dfx_blitfx.SrcRFactor:=round(SrcBlend*R/100);
  dfx_blitfx.SrcGFactor:=round(SrcBlend*G/100);
  dfx_blitfx.SrcBFactor:=round(SrcBlend*B/100);
  dfx_blitfx.DstRFactor:=DstBlend;
  dfx_blitfx.DstGFactor:=DstBlend;
  dfx_blitfx.DstBFactor:=DstBlend;
  dfx_blitfx.FXType:=BLITFX_COLORIZE;
  digifxDrawRLE(dfx_hnd,Image[Index],X,Y,@dfx_blitfx,Bits);
end;

procedure TRLESprite.LoadFromStream(Stream: TStream);
var
  Size, BuffSize, i: DWORD;
  lpRLE: PChar;
  RelocOffset: longword;
  p: PRLEHDR;
begin
  if Assigned(lpSpr) then begin
    FreeMem(lpSpr.DataPtr);
    FreeMem(lpSpr);
    lpSpr := nil;
  end;

  Stream.Read(PicCnt, SizeOf(PicCnt));
  Stream.Read(BuffSize, SizeOf(BuffSize));
  Size := PicCnt * SizeOf(RLEHDR);
  GetMem(lpSpr, Size);
  Stream.Read(lpSpr^, Size);
  GetMem(lpRLE, BuffSize);
  Stream.Read(lpRLE^, BuffSize);

  FMemSize := BuffSize;

  RelocOffset := lpRLE - lpSpr.DataPtr;
  p := lpSpr;
  for i := 1 to PicCnt do begin
    p.DataPtr := PChar(p.DataPtr + RelocOffset);
    digifxConvertRLE(dfx_hnd, p);
    Inc(p);
  end;
end;

procedure TRLESprite.SaveToStream(Stream: TStream);
var
  BuffSize: DWORD;
  RLEHeader: RLEHDR;
  p: PRLEHDR;
  i: integer;
begin
  BuffSize := FMemSize;

  Stream.Write(PicCnt, SizeOf(PicCnt));
  Stream.Write(BuffSize, SizeOf(BuffSize));

  p:=lpSpr;
  for i:=1 to PicCnt do begin
    RLEHeader:=p^;
    dec(RLEHeader.DataPtr,longword(lpSpr^.DataPtr));
    Stream.Write(RLEHeader, SizeOf(RLEHDR));
    inc(p);
  end;

  Stream.Write(lpSpr.DataPtr^, BuffSize);
end;
{ TBitPlane }

procedure TBitPlane.Clear;
begin
  DFXClearBitPlane(FBits, FKeyIndex);
end;

procedure TBitPlane.Fill(Color: TColor);
var
  C: LongWord;
  R, G, B: Byte;
begin
  C := ColorToRGB(Color);
  R := (C and $FF);
  G := (C and $FF00) shr 8;
  B := (C and $FF0000) shr 16;
  C := digiFXConvertColor(dfx_hnd, R, G, B);
  DFXClearBitPlane(FBits, C);
end;

constructor TBitPlane.Create(Width, Height: Integer);
begin
  inherited Create;
  ZeroMemory(@FBits, SizeOf(BITPLANE));
  FBits.bitsWdh := Width;
  FBits.bitsPitch := FBits.bitsWdh * 2;
  FBits.bitsHgh := Height;
  FBits.bitsFmt := dfx_pixelformat;
  GetMem(FBits.bitsPtr, FBits.bitsPitch * FBits.bitsHgh);
end;

destructor TBitPlane.Destroy;
begin
  FreeMem(FBits.bitsPtr);
  inherited;
end;

procedure TBitPlane.DrawToDC(DC: HDC; X, Y: Integer);
var
  BITMAPINFO: PBitmapInfo;
  biSize: Integer;
  p: ^longword;
begin
  biSize := SizeOf(TBitmapInfoHeader);
  GetMem(BITMAPINFO, biSize + 12);
  ZeroMemory(@BITMAPINFO.bmiHeader, biSize);
  BITMAPINFO.bmiHeader.biSize := biSize;
  BITMAPINFO.bmiHeader.biWidth := FBits.bitsWdh;
  BITMAPINFO.bmiHeader.biHeight := FBits.bitsHgh;
  BITMAPINFO.bmiHeader.biHeight := -BITMAPINFO.bmiHeader.biHeight;
  BITMAPINFO.bmiHeader.biPlanes := 1;
  if dfx_pixelformat=PIXFMT_555 then begin
    BITMAPINFO.bmiHeader.biBitCount := 16;
    BITMAPINFO.bmiHeader.biCompression := BI_RGB;
  end
  else if dfx_pixelformat=PIXFMT_565 then begin
    BITMAPINFO.bmiHeader.biBitCount := 16;
    BITMAPINFO.bmiHeader.biCompression := BI_BITFIELDS;
    p:=@BITMAPINFO.bmiColors[0];
    p^:=$F800; inc(p);
    p^:=$07E0; inc(p);
    p^:=$001F;
  end
  else if dfx_pixelformat=PIXFMT_888 then begin
    BITMAPINFO.bmiHeader.biBitCount := 24;
    BITMAPINFO.bmiHeader.biCompression := BI_RGB;
  end;
  SetDIBitsToDevice(DC, X, Y, FBits.bitsWdh, FBits.bitsHgh,
    0, 0, 0, FBits.bitsHgh, FBits.bitsPtr, BITMAPINFO^, DIB_RGB_COLORS);
  FreeMem(BITMAPINFO);
end;

procedure TBitPlane.StretchDrawToDC(DC: HDC; X, Y, W, H: Integer);
var
  BITMAPINFO: PBitmapInfo;
  biSize: Integer;
  p: ^longword;
begin
  biSize := SizeOf(TBitmapInfoHeader);
  GetMem(BITMAPINFO, biSize + 12);
  ZeroMemory(@BITMAPINFO.bmiHeader, biSize);
  BITMAPINFO.bmiHeader.biSize := biSize;
  BITMAPINFO.bmiHeader.biWidth := FBits.bitsWdh;
  BITMAPINFO.bmiHeader.biHeight := FBits.bitsHgh;
  BITMAPINFO.bmiHeader.biHeight := -BITMAPINFO.bmiHeader.biHeight;
  BITMAPINFO.bmiHeader.biPlanes := 1;
  if dfx_pixelformat=PIXFMT_555 then begin
    BITMAPINFO.bmiHeader.biBitCount := 16;
    BITMAPINFO.bmiHeader.biCompression := BI_RGB;
  end
  else if dfx_pixelformat=PIXFMT_565 then begin
    BITMAPINFO.bmiHeader.biBitCount := 16;
    BITMAPINFO.bmiHeader.biCompression := BI_BITFIELDS;
    p:=@BITMAPINFO.bmiColors[0];
    p^:=$F800; inc(p);
    p^:=$07E0; inc(p);
    p^:=$001F;
  end
  else if dfx_pixelformat=PIXFMT_888 then begin
    BITMAPINFO.bmiHeader.biBitCount := 24;
    BITMAPINFO.bmiHeader.biCompression := BI_RGB;
  end;

  StretchDIBits(DC, X, Y, W, H, 0,0, FBits.bitsWdh, FBits.bitsHgh,
     FBits.bitsPtr, BITMAPINFO^, DIB_RGB_COLORS, SRCCOPY);

  FreeMem(BITMAPINFO);
end;


procedure TBitPlane.Draw(X, Y: Integer; Bits: PBITPLANE);
var
  dfx_blitfx: BLITFX;
begin
  dfx_blitfx.FXType := BLITFX_NONE;
  digifxDrawBitPlane(dfx_hnd, @FBits, X, Y, FKeyIndex, @dfx_blitfx, Bits);
end;

function TBitPlane.GetBits: PBITPLANE;
begin
  Result := @FBits;
end;

function TBitPlane.GetHeight: LongWord;
begin
  Result := FBits.bitsWdh;
end;

function TBitPlane.GetWidth: LongWord;
begin
  Result := FBits.bitsHgh;
end;

procedure TBitPlane.SetKeyColor(const Value: TColor);
var
  C: LongWord;
begin
  FKeyColor := Value;
  C := ColorToRGB(Value);
  R := (C and $FF);
  G := (C and $FF00) shr 8;
  B := (C and $FF0000) shr 16;
  FKeyIndex := digiFXConvertColor(dfx_hnd, R, G, B);
end;

procedure TBitPlane.DrawMono(X, Y: Integer; Bits: PBITPLANE; Color: TColor);
var
  dfx_blitfx: BLITFX;
  C: DWORD;
begin
  C := ColorToRGB(Color);
  dfx_blitfx.Color.R := (C and $FF);
  dfx_blitfx.Color.G := (C and $FF00) shr 8;
  dfx_blitfx.Color.B := (C and $FF0000) shr 16;
  dfx_blitfx.FXType := BLITFX_MONO;
  digifxDrawBitPlane(dfx_hnd, @FBits, X, Y, FKeyIndex, @dfx_blitfx, Bits);
end;

procedure TBitPlane.DrawBlend(X, Y: Integer; Bits: PBITPLANE; SrcBlend,
  DstBlend: DWORD);
var
  dfx_blitfx: BLITFX;
begin
  dfx_blitfx.FXType := BLITFX_BLEND;
  dfx_blitfx.BlendSrcFactor := SrcBlend;
  dfx_blitfx.BlendDstFactor := DstBlend;
  digifxDrawBitPlane(dfx_hnd, @FBits, X, Y, FKeyIndex, @dfx_blitfx, Bits);
end;

procedure TBitPlane.DrawOutline(X, Y: integer; Bits: PBITPLANE;
  Color: TColor; Copy: boolean);
var
  dfx_blitfx : BLITFX;
  C: DWORD;
begin
  C:=ColorToRGB(Color);
  dfx_blitfx.Color.R:=(C and $FF);
  dfx_blitfx.Color.G:=(C and $FF00) shr 8;
  dfx_blitfx.Color.B:=(C and $FF0000) shr 16;
  dfx_blitfx.FXType:=BLITFX_OUTLINE;
  if not Copy then inc(dfx_blitfx.FXType,BLITFX_MONO);
  digifxDrawBitPlane(dfx_hnd,@FBits,X,Y,FKeyIndex,@dfx_blitfx,Bits);
end;

procedure TBitPlane.DrawColorize(X, Y: integer; Bits: PBITPLANE;
  R, G, B, SrcBlend, DstBlend: integer);
var
  dfx_blitfx : BLITFX;
begin
  dfx_blitfx.SrcRFactor:=round(SrcBlend*R/100);
  dfx_blitfx.SrcGFactor:=round(SrcBlend*G/100);
  dfx_blitfx.SrcBFactor:=round(SrcBlend*B/100);
  dfx_blitfx.DstRFactor:=DstBlend;
  dfx_blitfx.DstGFactor:=DstBlend;
  dfx_blitfx.DstBFactor:=DstBlend;
  dfx_blitfx.FXType:=BLITFX_COLORIZE;
  digifxDrawBitPlane(dfx_hnd,@FBits,X,Y,FKeyIndex,@dfx_blitfx,Bits);
end;

procedure TBitPlane.DrawShadow(X, Y: integer; Bits: PBITPLANE;
  SrcBlend, DstBlend: DWORD);
var
  dfx_blitfx : BLITFX;
begin
  dfx_blitfx.FXType:=BLITFX_ROTATE+BLITFX_ZOOM+BLITFX_BLEND;
  dfx_blitfx.BlendSrcFactor := SrcBlend;
  dfx_blitfx.BlendDstFactor := DstBlend;
  dfx_blitfx.Angle := 15;
  dfx_blitfx.ZoomX := 100;
  dfx_blitfx.ZoomY := 50;
  digifxDrawBitPlane(dfx_hnd,@FBits,X,Y,FKeyIndex,@dfx_blitfx,Bits);
//  inc(Angle);
//  if Angle>=360 then Angle:=0;
end;

end.

