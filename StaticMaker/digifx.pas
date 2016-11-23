unit digifx;
//
// DigitalFX Delphi Interface Unit
// by Dariusz "De JET" Zolna
// Copyright (c) 1998 F.A.S.T Projects
//
// email: digifx@fastprojects.com
// http://www.fastprojects.com
//

interface
uses Windows, SysUtils;

const

  BLITFX_NONE = 0;
  BLITFX_LUT = 1;
  BLITFX_MONO = 2;
  BLITFX_BLEND = 4;
  BLITFX_SOFTEN = 8;
  BLITFX_TEXTURED = 16;
  BLITFX_ZOOM = 32;
  BLITFX_ROTATE = 64;
  BLITFX_SKIN = 128;
  BLITFX_MASK = 256;
  BLITFX_HENDS = 512;
  BLITFX_SUCKPIX = 1024;
  BLITFX_COLORIZE = 2048;
  BLITFX_COLORMASK = 4096;
  BLITFX_OUTLINE = 8192;
  BLITFX_CREATERLE = $80000000;

  PIXFMT_8 = 0;
  PIXFMT_555 = 1;
  PIXFMT_565 = 2;
  PIXFMT_888 = 3;
  PIXFMT_BGR = 128;

  DFX_DRAWRLE = 0;
  DFX_DRAWBITPLANE = 1;
  DFX_DRAWPIXELS = 2;
  DFX_DRAWRECT = 3;
  DFX_DRAWLINE = 4;

  NOKEYCOLOR = $FFFFFFFF;

type
  PRLEHDR = ^RLEHDR;
  RLEHDR = record
    SrcX: Integer;
    SrcY: Integer;
    Wdh: DWORD;
    Hgh: DWORD;
    AdjX: Integer;
    AdjY: Integer;
    PixFmt: DWORD;
    DataPtr: PChar;
  end;

  RGB = record
    B: Byte;
    G: Byte;
    R: Byte;
    Unused: Byte;
  end;

  PBITPLANE = ^BITPLANE;
  BITPLANE = record
    bitsPtr: PByte;
    bitsWdh: DWORD;
    bitsHgh: DWORD;
    bitsFmt: DWORD;
    bitsPitch: DWORD;
    BaseX: Integer;
    BaseY: Integer;
  end;

  PBLITFX = ^BLITFX;
  BLITFX = record
    FXType: DWORD;
    BlendSrcFactor: DWORD;
    BlendDstFactor: DWORD;
    LUTPtr: Pointer;
    Color: RGB;
    TexturePtr: PBITPLANE;
    SrcRFactor: DWORD;
    SrcGFactor: DWORD;
    SrcBFactor: DWORD;
    DstRFactor: DWORD;
    DstGFactor: DWORD;
    DstBFactor: DWORD;
    ColorMaskSet: RGB;
    ColorMaskClr: RGB;
    Angle: DWORD;
    ZoomX: DWORD;
    ZoomY: DWORD;
  end;

  PPIXEL = ^PIXEL;
  PIXEL = record
    StructSize: DWORD;
    X: Integer;
    Y: Integer;
    Color: DWORD;
  end;

type
  DFXHND = DWORD;
  DFXENUMCALLBACK = function(const s: PChar): Boolean;

function digifxInit(const s: PChar): BOOL;
function digifxDone: BOOL;
function digifxEnumDrivers(lpEnumProc: DFXENUMCALLBACK): BOOL;
function digifxLoadDriver(lpDrvNamePtr: PChar; dwPixFmt: DWORD): DFXHND;
function digifxFreeDriver(hDFX: DFXHND): BOOL;
function digifxCreateRLE(hDFX: DFXHND; SrcBitsPtr: PBITPLANE; KeyColor: DWORD; RLEHDRPtr: PRLEHDR; BuffPtr: Pointer; FirstPtr: PRLEHDR): DWORD;
function digifxConvertRLE(hDFX: DFXHND; RLEHDRPtr: PRLEHDR): BOOL;
function digifxConvertBitplane(hDFX: DFXHND; BitplanePtr: PBITPLANE): BOOL;
function digifxDrawRLE(hDFX: DFXHND; RLEHDRPtr: PRLEHDR; XPos: Integer; YPos: Integer; FXPtr: PBLITFX; DstBitsPtr: PBITPLANE): BOOL;
function digifxRLEConvertToPixels(hDFX: DFXHND; RLEHDRPtr: PRLEHDR; PixTabPtr: PPIXEL; PixCnt: DWORD; PixSize: DWORD): DWORD;
function digifxDrawPixels(hDFX: DFXHND; PixTabPtr: PPIXEL; PixCnt: DWORD; XPos: Integer; YPos: Integer; FXPtr: PBLITFX; DstBitsPtr: PBITPLANE): BOOL;
function digifxDrawBitplane(hDFX: DFXHND; SrcBitsPtr: PBITPLANE; XPos: Integer; YPos: Integer; KeyColor: DWORD; FXPtr: PBLITFX; DstBitsPtr: PBITPLANE): BOOL;
function digifxDrawRect(hDFX: DFXHND; RectPtr: PRect; XPos: Integer; YPos: Integer; FXPtr: PBLITFX; DstBitsPtr: PBITPLANE): BOOL;
function digifxDrawLine(hDFX: DFXHND; XBgn: Integer; YBgn: Integer; XEnd: Integer; YEnd: Integer; FXPtr: PBLITFX; DstBitsPtr: PBITPLANE): BOOL;
function digifxConvertColor(hDFX: DFXHND; R: Byte; G: Byte; B: Byte): DWORD;
function digifxCheckSupport(hDFX: DFXHND; ProcNo: DWORD; FXPtr: PBLITFX; SrcPtr: Pointer; DstPtr: PBITPLANE): BOOL;
function digifxGetErrorText: PChar;

implementation

type
  DFXSTARTUPLIB = function: PDWORD; stdcall;

const
  // Due to the fact that Delphi ignores the case of identifiers I had
  // to change these consts from DFX_??? to DLL_???
  DLL_GetInfo = 0;
  DLL_Init = 1;
  DLL_Done = 2;
  DLL_CreateRLE = 3;
  DLL_ConvertRLE = 4;
  DLL_ConvertBitplane = 5;
  DLL_DrawRLE = 6;
  DLL_RLEConvertToPixels = 7;
  DLL_DrawPixels = 8;
  DLL_DrawBitplane = 9;
  DLL_DrawRect = 10;
  DLL_DrawLine = 11;
  DLL_ConvertColor = 12;
  DLL_CheckSupport = 13;

type
  DRVFILE = record
    Info: array[0..64] of AnsiChar;
    FName: array[0..MAX_PATH - 1] of AnsiChar;
    Handle: HMODULE;
    RefCnt: DWORD;
    DFX: PDWORD;
    TabPtr: Pointer;
  end;

const
  DF_ID = 17478;                        // 'DF'

var
  DrvFilesTab: array[0..32] of DRVFILE;
  DriversCnt: DWORD;
  ErrPtr: PChar;
  RegEAX, RegEBX, RegECX, RegEDX, RegESI, RegEDI: DWORD;

function digifxInit(const s: PChar): BOOL;
var
  StrPtr: PChar;
  WorkDir: array[0..MAX_PATH - 1] of AnsiChar;
  TmpFname: array[0..MAX_PATH - 1] of AnsiChar;
  FindHnd: THandle;
  FindData: TWin32FindData;
  hmod: HMODULE;
  DFX: PDWORD;
  StartupLib: DFXSTARTUPLIB;
begin
  Result := False;
  try
    StrCopy(WorkDir, PChar(s));
    if (WorkDir[Length(s) - 1] <> '\') then
      StrCat(WorkDir, '\');
    DriversCnt := 0;
    StrCopy(TmpFname, WorkDir);
    StrCat(TmpFname, 'dfx_*.dll');

    FindHnd := Windows.FindFirstFile(TmpFname, FindData);
    while (FindHnd <> INVALID_HANDLE_VALUE) do begin
      StrCopy(TmpFname, WorkDir);
      StrCat(TmpFname, FindData.cFileName);
      hmod := LoadLibrary(TmpFname);
      if (hmod <> 0) then begin
        @StartupLib := GetProcAddress(hmod, 'StartupLibrary');
        if (@StartupLib <> nil) then begin
          DFX := StartupLib();
          asm
          mov eax, FindHnd;
          mov eax, DFX;
          call dword ptr [eax + DLL_GetInfo*4];
          mov StrPtr, esi;
          end;
          if (StrLComp(StrPtr, 'DigitalFX', 9) = 0) then begin
            StrCopy(DrvFilesTab[DriversCnt].Info, StrPtr);
            StrCopy(DrvFilesTab[DriversCnt].FName, TmpFname);
            DrvFilesTab[DriversCnt].RefCnt := 0;
            Inc(DriversCnt);
          end;
        end;
        FreeLibrary(hmod);
      end;
      if (not Windows.FindNextFile(FindHnd, FindData)) then
        Break;
    end;
    Windows.FindClose(FindHnd);

    Result := True;
  except
  end;

end;

function digifxDone: BOOL;
var
  i: DWORD;
begin
  Result := False;
  try
    for i := 0 to DriversCnt - 1 do begin
      if (DrvFilesTab[i].RefCnt > 0) then begin
        FreeMem(DrvFilesTab[i].TabPtr);
        FreeLibrary(DrvFilesTab[i].Handle);
        DrvFilesTab[i].RefCnt := 0;
      end;
    end;
    Result := False;
  except
  end;
end;

function digifxEnumDrivers(lpEnumProc: DFXENUMCALLBACK): BOOL;
var
  i: DWORD;
begin
  Result := False;
  try
    for i := 0 to DriversCnt - 1 do begin
      if (not lpEnumProc(DrvFilesTab[i].Info)) then
        Break;
    end;
    Result := True;
  except
  end;
end;

function CallDFX(hDFX: DFXHND; ProcNo: DWORD; REAX: DWORD; REBX: DWORD; RECX: DWORD; REDX: DWORD; RESI: DWORD; REDI: DWORD): BOOL;
var
  i: DWORD;
  TmpProcPtr: DWORD;
begin
  Result := False;
  try
    if ((hDFX and $FFFF0000) = (DF_ID shl 16)) then begin
      i := (hDFX and $0000FFFF);
      if ((DrvFilesTab[i].RefCnt > 0) and (i < DriversCnt)) then begin
        TmpProcPtr := DWORD(DrvFilesTab[i].DFX);
        asm
            pushad
            mov     eax, ProcNo
            mov     ebx, TmpProcPtr
            mov     eax, [ebx+eax*4]
            mov     TmpProcPtr, eax
            mov     eax, REAX
            mov     ebx, REBX
            mov     ecx, RECX
            mov     edx, REDX
            mov     esi, RESI
            mov     edi, REDI
            push    ebp
        // Changed from "call [TmpProcPtr]"
            call    dword ptr [TmpProcPtr]
            pop     ebp
            mov     RegEAX, eax
            mov     RegEBX, ebx
            mov     RegECX, ecx
            mov     RegEDX, edx
            mov     RegESI, esi
            mov     RegEDI, edi
            jnc     @NoErr
            mov     ErrPtr, esi
            jmp     @Exit
            @NoErr:
                    mov     ErrPtr, 0
            @Exit:
            popad
        end;
        if (ErrPtr <> nil) then begin
          Result := False;
          Exit;
        end
        else begin
          Result := True;
          Exit;
        end;
      end;
    end;
    ErrPtr := 'Bad DigitalFX driver handle.';
    Result := False;
  except
  end;

end;

function digifxLoadDriver(lpDrvNamePtr: PChar; dwPixFmt: DWORD): DFXHND;
var
  i: DWORD;
  hDFX: DFXHND;
  hmod: HMODULE;
  StartupLib: DFXSTARTUPLIB;
begin
  Result := 0;
  try
    for i := 0 to DriversCnt - 1 do begin
      if (StrComp(lpDrvNamePtr, DrvFilesTab[i].Info) = 0) then begin
        hDFX := i or (DF_ID shl 16);
        if (DrvFilesTab[i].RefCnt = 0) then begin
          hmod := LoadLibrary(DrvFilesTab[i].FName);
          if (hmod = 0) then
            Exit;
          @StartupLib := GetProcAddress(hmod, 'StartupLibrary');
          if (@StartupLib = nil) then
            Exit;
          DrvFilesTab[i].Handle := hmod;
          DrvFilesTab[i].DFX := StartupLib();
          GetMem(DrvFilesTab[i].TabPtr, 96000);
        end;
        Inc(DrvFilesTab[i].RefCnt);
        if (not CallDFX(hDFX, DLL_Init, dwPixFmt, DWORD(DrvFilesTab[i].TabPtr), 1, 0, 0, 0)) then
          Exit
        else
          Result := hDFX;
        Exit;
      end;
    end;
  except
  end;
end;

function digifxFreeDriver(hDFX: DFXHND): BOOL;
var
  i: DWORD;
begin
  Result := False;
  try
    if (not CallDFX(hDFX, DLL_Done, 0, 0, 0, 0, 0, 0)) then
      Exit;
    i := hDFX and $0000FFFF;
    Dec(DrvFilesTab[i].RefCnt);
    if (DrvFilesTab[i].RefCnt = 0) then begin
      FreeMem(DrvFilesTab[i].TabPtr);
      Result := FreeLibrary(DrvFilesTab[i].Handle);
    end
    else
      Result := True;
  except
  end;
end;

function digifxGetErrorText: PChar;
begin
  Result := ErrPtr;
end;

function digifxCreateRLE(hDFX: DFXHND; SrcBitsPtr: PBITPLANE; KeyColor: DWORD; RLEHDRPtr: PRLEHDR; BuffPtr: Pointer; FirstPtr: PRLEHDR): DWORD;
begin
  Result := 0;
  try
    if (CallDFX(hDFX, DLL_CreateRLE, KeyColor, DWORD(BuffPtr), 0, DWORD(FirstPtr), DWORD(SrcBitsPtr), DWORD(RLEHDRPtr))) then
      Result := RegEAX;
  except
  end;
end;

// Return type mismatch: changed DWORD -> BOOL
// Moved NewBuffPtr inside the proc. Is this ptr a dummy ptr?

function digifxConvertRLE(hDFX: DFXHND; RLEHDRPtr: PRLEHDR): BOOL;
var
  NewBuffPtr: Pointer;
begin
  Result := False;
  try
    NewBuffPtr := nil;
    Result := CallDFX(hDFX, DLL_ConvertRLE, 0, 0, 0, 0, DWORD(RLEHDRPtr), DWORD(NewBuffPtr));
  except
  end;
end;

// Return type mismatch: changed DWORD -> BOOL
// Moved NewBuffPtr inside the proc. Is this ptr a dummy ptr?

function digifxConvertBitplane(hDFX: DFXHND; BitplanePtr: PBITPLANE): BOOL;
var
  NewBuffPtr: Pointer;
begin
  Result := False;
  try
    NewBuffPtr := nil;
    Result := CallDFX(hDFX, DLL_ConvertBitplane, 0, 0, 0, 0, DWORD(BitplanePtr), DWORD(NewBuffPtr));
  except
  end;
end;

function digifxDrawRLE(hDFX: DFXHND; RLEHDRPtr: PRLEHDR; XPos: Integer; YPos: Integer; FXPtr: PBLITFX; DstBitsPtr: PBITPLANE): BOOL;
begin
  Result := False;
  try
    Result := CallDFX(hDFX, DLL_DrawRLE, DWORD(XPos), DWORD(YPos), 0, DWORD(FXPtr), DWORD(RLEHDRPtr), DWORD(DstBitsPtr));
  except
  end;
end;

function digifxRLEConvertToPixels(hDFX: DFXHND; RLEHDRPtr: PRLEHDR; PixTabPtr: PPIXEL; PixCnt: DWORD; PixSize: DWORD): DWORD;
begin
  if (CallDFX(hDFX, DLL_RLEConvertToPixels, DWORD(PixSize), 0, DWORD(PixCnt), 0, DWORD(RLEHDRPtr), DWORD(PixTabPtr))) then
    Result := RegEAX
  else
    Result := 0;
end;

function digifxDrawPixels(hDFX: DFXHND; PixTabPtr: PPIXEL; PixCnt: DWORD; XPos: Integer; YPos: Integer; FXPtr: PBLITFX; DstBitsPtr: PBITPLANE): BOOL;
begin
  Result := CallDFX(hDFX, DLL_DrawPixels, DWORD(PixTabPtr), DWORD(XPos), DWORD(YPos), DWORD(PixCnt), DWORD(DstBitsPtr), DWORD(FXPtr));
end;

function digifxDrawBitplane(hDFX: DFXHND; SrcBitsPtr: PBITPLANE; XPos: Integer; YPos: Integer; KeyColor: DWORD; FXPtr: PBLITFX; DstBitsPtr: PBITPLANE): BOOL;
begin
  Result := CallDFX(hDFX, DLL_DrawBitplane, DWORD(SrcBitsPtr), DWORD(XPos), DWORD(YPos), KeyColor, DWORD(DstBitsPtr), DWORD(FXPtr));
end;

function digifxDrawRect(hDFX: DFXHND; RectPtr: PRect; XPos: Integer; YPos: Integer; FXPtr: PBLITFX; DstBitsPtr: PBITPLANE): BOOL;
begin
  Result := CallDFX(hDFX, DLL_DrawRect, DWORD(RectPtr), DWORD(XPos), DWORD(YPos), DWORD(FXPtr), DWORD(DstBitsPtr), 0);
end;

function digifxDrawLine(hDFX: DFXHND; XBgn: Integer; YBgn: Integer; XEnd: Integer; YEnd: Integer; FXPtr: PBLITFX; DstBitsPtr: PBITPLANE): BOOL;
begin
  Result := CallDFX(hDFX, DLL_DrawLine, DWORD(XBgn), DWORD(YBgn), DWORD(XEnd), DWORD(YEnd), DWORD(DstBitsPtr), DWORD(FXPtr));
end;

function digifxConvertColor(hDFX: DFXHND; R: Byte; G: Byte; B: Byte): DWORD;
var
  Color: DWORD;
begin
  Result := 0;
  try
    asm
        mov al, R
        shl eax, 8
        mov al, G
        shl eax, 8
        mov al, B
        mov Color, eax
    end;
    if (CallDFX(hDFX, DLL_ConvertColor, Color, 0, 0, 0, 0, 0)) then
      Result := RegEAX
    else
      Result := NOKEYCOLOR;
  except
  end;
end;

function digifxCheckSupport(hDFX: DFXHND; ProcNo: DWORD; FXPtr: PBLITFX; SrcPtr: Pointer; DstPtr: PBITPLANE): BOOL;
begin
  Result := CallDFX(hDFX, DLL_CheckSupport, ProcNo, DWORD(FXPtr), 0, 0, DWORD(SrcPtr), DWORD(DstPtr));
end;

end.

