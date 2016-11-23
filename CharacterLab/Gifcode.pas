{*****************************************************************************
 Digital Tome Game Design Utility

 Portions Copyright ©1998-2000 Steven D. Davis
 Portions Copyright ©1999-2000 Digital Tome L.P. Texas USA
 Not for public release/use.

 // INSERT SHORT DESCRIPTION OF THIS UNIT HERE

*****************************************************************************}
unit GifCode;

interface

uses WinTypes,
  Forms,
  SysUtils,
  Classes,
  Graphics,
{$IFDEF DirectX}
  DirectX, Anigrp30, LogFile,
{$ENDIF}
  ExtCtrls;

const
  { image descriptor bit masks }
  idLocalColorTable = $80;              { set if a local color table follows }
  idInterlaced = $40;                   { set if image is interlaced }
  idSort = $20;                         { set if color table is sorted }
  idReserved = $0C;                     { reserved - must be set to $00 }
  idColorTableSize = $07;               { size of color table as above }
  Trailer: Byte = $3B;                  { indicates the end of the GIF data stream }
  ExtensionIntroducer: Byte = $21;
  ControlExLabel: Byte = $F9;
  CommentLabel: Byte = $FE;
  cxTransparent: Byte = $01;
  cxUserInput: Byte = $02;
  cxDisposal: Byte = $1C;
  cxDispNone: Byte = $00;
  cxDispKeep: Byte = $04;
  cxDispRestoreBG: Byte = $08;
  cxDispRestorePrev: Byte = $0C;
  MAXSCREENWIDTH = 800;
  ImageSeparator: Byte = $2C;
  { logical screen descriptor packed field masks }
  lsdGlobalColorTable = $80;            { set if global color table follows L.S.D. }
  lsdColorResolution = $70;             { Color resolution - 3 bits }
  lsdSort = $08;                        { set if global color table is sorted - 1 bit }
  lsdColorTableSize = $07;              { size of global color table - 3 bits }
  { Actual size = 2^value+1    - value is 3 bits }
  BlockTerminator: Byte = 0;            { terminates stream of data blocks }
  MAXCODES = 4095;                      { the maximum number of different codes 0 inclusive }
  { error constants }
  geNoError = 0;                        { no errors found }
  geNoFile = 1;                         { gif file not found }
  geNotGIF = 2;                         { file is not a gif file }
  geNoGlobalColor = 3;                  { no Global Color table found }
  geImagePreceded = 4;                  { image descriptor preceeded by other unknown data }
  geEmptyBlock = 5;                     { Block has no data }
  geUnExpectedEOF = 6;                  { unexpected EOF }
  geBadCodeSize = 7;                    { bad code size }
  geBadCode = 8;                        { Bad code was found }
  geBitSizeOverflow = 9;                { bit size went beyond 12 bits }
  geNoBMP = 10;                         { Could not make BMP file }

  ErrName: array[1..10] of string = (
    'GIF file not found',
    'Not a GIF file',
    'Missing color table',
    'Bad data',
    'No data',
    'Unexpected EOF',
    'Bad code size',
    'Bad code',
    'Bad bit size',
    'Bad bitmap');

  CodeMask: array[0..12] of Integer = ( { bit masks for use with Next code }
    0,
    $0001, $0003,
    $0007, $000F,
    $001F, $003F,
    $007F, $00FF,
    $01FF, $03FF,
    $07FF, $0FFF);

type
  TDataSubBlock = record
    Size: Byte;                         { size of the block -- 0 to 255 }
    Data: array[1..255] of Byte;        { the data }
  end;

type
  TControlExt = record
    PackedFields: Byte;
    Delay: Word;
    TransparentIndex: Byte;
  end;

type
  TColorItem = record                   { one item a a color table }
    Red: Byte;
    Green: Byte;
    Blue: Byte;
  end;

  TColorTable = array[0..255] of TColorItem; { the color table }

type
  TFrame = record
    Disposal: Byte;
    UserInput: Boolean;
    TRANSPARENT: Boolean;
    TransparentIndex: Byte;
    TransparentColor: TColor;
    Delay: Word;
    ghBmi: HGLOBAL;
    ghBits: HGLOBAL;
    LeftPos: Word;
    TopPos: Word;
    Width: Word;
    Height: Word;
    UseLocal: Boolean;
    Interlaced: Boolean;
    Ordered: Boolean;
    ColorTable: TColorTable;
    Palette: HPALETTE;
  end;

type
  THeader = record
    Signature: array[0..2] of Char;     { contains 'GIF' }
    version: array[0..2] of Char;       { '87a' or '89a' }
  end;

  TLogicalScreenDescriptor = record
    ScreenWidth: Word;                  { logical screen width }
    ScreenHeight: Word;                 { logical screen height }
    PackedFields: Byte;                 { packed fields - see below }
    BackGroundColorIndex: Byte;         { index to global color table }
    AspectRatio: Byte;                  { actual ratio = (AspectRatio + 15) / 64 }
  end;

type
  TImageDescriptor = record
    ImageLeftPos: Word;                 { Column in pixels in respect to left edge of logical screen }
    ImageTopPos: Word;                  { row in pixels in respect to top of logical screen }
    ImageWidth: Word;                   { width of image in pixels }
    ImageHeight: Word;                  { height of image in pixels }
    PackedFields: Byte;                 { see below }
  end;

  { other extension blocks not currently supported by this unit
   - Graphic Control extension
   - Comment extension           I'm not sure what will happen if these blocks
   - Plain text extension        are encountered but it'll be interesting
   - application extension }

type
  TExtensionBlock = record
    ExtensionLabel: Byte;
    BlockSize: Byte;
  end;

  PCodeItem = ^TCodeItem;

  TCodeItem = record
    Code1, Code2: Byte;
  end;
  {===============================================================}
  {    Bitmap File Structs
  {===============================================================}

type
  GraphicLine = array[0..2048] of Byte;
  PBmLine = ^TBmpLinesStruct;
  TBmpLinesStruct = record
    LineData: GraphicLine;
    LineNo: Integer;
  end;

type
  TDecodeEvent = function(Frame: TFrame): Boolean;

  {------------------------------------------------------------------------------}

type
  { This is the actual gif object }
  PGif = ^TGif;
  TGif = class(TObject)
  private
    GifStream: TMemoryStream;           { the file stream for the gif file }
    Header: THeader;                    { gif file header }
    LogicalScreen: TLogicalScreenDescriptor; { gif screen descriptor }
    GlobalColorTable: TColorTable;      { global color table }
    LZWCodeSize: Byte;                  { minimum size of the LZW codes in bits }
    ImageData: TDataSubBlock;           { variable to store incoming gif data }
    TableSize: Word;                    { number of entrys in the color table }
    BitsLeft, BytesLeft: Integer;       { bits left in byte - bytes left in block }
    CurrCodeSize: Integer;              { Current size of code in bits }
    ClearCode: Integer;                 { Clear code value }
    EndingCode: Integer;                { ending code value }
    Slot: Word;                         { position that the next new code is to be added }
    TopSlot: Word;                      { highest slot position for the current code size }
    HighCode: Word;                     { highest code that does not require decoding }
    NextByte: Integer;                  { the index to the next byte in the datablock array }
    CurrByte: Byte;                     { the current byte }
    DecodeStack: array[0..MAXCODES] of Byte; { stack for the decoded codes }
    Prefix: array[0..MAXCODES] of Integer; { array for code prefixes }
    Suffix: array[0..MAXCODES] of Integer; { array for code suffixes }
    LineBuffer: GraphicLine;            { array for buffer line output }
    CurrentX, CurrentY: Integer;        { current screen locations }
    InterlacePass: Byte;                { interlace pass number }
    LineSize: Word;
    {Member Functions}
    procedure GetHeader;
    procedure ParseMem;
    function NextCode: Word;            { returns the next available code }
    procedure Error(ErrCode: Integer);
    procedure InitCompressionStream;    { initializes info for decode }
    procedure ReadSubBlock;             { reads a data subblock from the stream }
    procedure CreateLine;
    procedure CreateBitHeader;          { Takes the gif header information and converts it to BMP }
  public
    BackGroundColor: TColor;
    GlobalPalette: HPALETTE;            { global palette }
    Frame: array[1..512] of TFrame;
    Frames: Word;
    Comments: string;
    CommentPosition: Longint;           //Location of last comment block
    OnDecode: TDecodeEvent;
    constructor Create;
    destructor Destroy; override;
    procedure Decode;
    procedure GifConvert(AGifName: string);
    function Render(FramesWide: Integer): TBitmap;
    function GetFrame(i: integer): TBitmap;
{$IFDEF DirectX}
    function RenderSurface(FramesWide: Integer): IDirectDrawSurface;
{$ENDIF}
  end;

type
  EGifException = class(Exception)
  end;

implementation

{------------------------------------------------------------------------------}

{ TGif }

constructor TGif.Create;
const
  FailName: string = 'TGif.Create';
begin
  {Create Memory Buffer to hold gif}
  GifStream := TMemoryStream.Create;
end;
{------------------------------------------------------------------------------}

destructor TGif.Destroy;
const
  FailName: string = 'TGif.Destroy';
var
  i: Word;
begin
  GifStream.Free;
  for i := 1 to Frames do begin
    if Frame[i].ghBits <> 0 then GlobalFree(Frame[i].ghBits);
    if Frame[i].ghbmi <> 0 then GlobalFree(Frame[i].ghbmi);
    if (Frame[i].Palette <> GlobalPalette) then DeleteObject(Frame[i].Palette);
  end;
  DeleteObject(GlobalPalette);
  inherited Destroy;
end;
{------------------------------------------------------------------------------}

procedure TGif.GifConvert(AGifName: string);
const
  FailName: string = 'TGif.GifConvert';
var
  Seperator: Byte;
begin
  { Converts GIF file to bitstream }
  GifStream.LoadFromFile(AGifName);     { Load the file into memory }
  GetHeader;
  Frames := 0;
  Comments := '';
  if (GifStream.Position <= GifStream.Size) then begin
    GifStream.Read(Seperator, 1);
    GifStream.Seek(-1, soFromCurrent);
    while (Seperator = ExtensionIntroducer) or (Seperator = ImageSeparator) do begin
      ParseMem;
      if (GifStream.Position >= GifStream.Size) then Break;
      CreateBitHeader;
      try
        Decode;
      except
      end;
      if Assigned(OnDecode) then begin
        if OnDecode(Frame[Frames]) then begin
          GlobalFree(Frame[Frames].ghBits);
          Frame[Frames].ghBits := 0;
          GlobalFree(Frame[Frames].ghbmi);
          Frame[Frames].ghbmi := 0;
          if (Frame[Frames].Palette <> GlobalPalette) then begin
            DeleteObject(Frame[Frames].Palette);
            Frame[Frames].Palette := 0;
          end;
        end;
      end;
      if (GifStream.Position >= GifStream.Size) then Break;
      GifStream.Seek(1, soFromCurrent);
      GifStream.Read(Seperator, 1);
      GifStream.Seek(-1, soFromCurrent);
    end;
  end;

end;
{------------------------------------------------------------------------------}

{Raise exception with a message}

procedure TGif.Error(ErrCode: Integer);
const
  FailName: string = 'TGif.Error';
begin
  raise EGifException.Create(ErrName[ErrCode]);
end;
{------------------------------------------------------------------------------}

procedure TGif.GetHeader;
const
  FailName: string = 'TGif.GetHeader';
var
  i: Integer;
  Pal: ^LOGPALETTE;
  PalEntry: ^PALETTEENTRY;
begin
  GifStream.Read(Header, SizeOf(Header)); { read the header }
  {Stupid validation tricks}
  if Header.Signature <> 'GIF' then Error(geNotGif); { is vaild signature }
  {Decode the header information}
  GifStream.Read(LogicalScreen, SizeOf(LogicalScreen));
  if LogicalScreen.PackedFields and lsdGlobalColorTable = lsdGlobalColorTable then begin
    TableSize := 1 shl ((LogicalScreen.PackedFields and lsdColorTableSize) + 1);
    GifStream.Read(GlobalColorTable, TableSize * SizeOf(TColorItem)); { read Global Color Table }
    BackgroundColor := GlobalColorTable[LogicalScreen.BackgroundColorIndex].Blue shl 16 +
      GlobalColorTable[LogicalScreen.BackgroundColorIndex].Green shl 8 +
      GlobalColorTable[LogicalScreen.BackgroundColorIndex].Red;
    GetMem(Pal, SizeOf(LOGPALETTE) + 256 * SizeOf(PALETTEENTRY));
    ZeroMemory(Pal, SizeOf(LOGPALETTE) + 256 * SizeOf(PALETTEENTRY));
    Pal^.palVersion := $300;
    Pal^.palNumEntries := 256;
    PalEntry := @Pal.palPalEntry;
    for i := 0 to 255 do begin
      PalEntry^.peRed := GlobalColorTable[i].Red;
      PalEntry^.peGreen := GlobalColorTable[i].Green;
      PalEntry^.peBlue := GlobalColorTable[i].Blue;
      Inc(PalEntry);
    end;
    GlobalPalette := CreatePalette(Pal^);
    FreeMem(Pal);
  end;
  //  else Error(geNoGlobalColor);
end;

{Decodes the header and palette info}

procedure TGif.ParseMem;
const
  FailName: string = 'TGif.ParseMem';
var
  Seperator: Byte;
  ExtensionBlock: TExtensionBlock;      { extension data }
  ImageDescriptor: TImageDescriptor;    { image descriptor }
  ControlExt: TControlExt;
  CommentBlock: array[1..255] of Char;
begin
  {Image specific headers}
  GifStream.Read(Seperator, SizeOf(Seperator));
  while (Seperator = ExtensionIntroducer) do begin
    GifStream.Read(ExtensionBlock, SizeOf(ExtensionBlock));
    if (ExtensionBlock.ExtensionLabel = ControlExLabel) then begin
      GifStream.Read(ControlExt, SizeOf(ControlExt));
      Frame[Frames + 1].Disposal := (ControlExt.PackedFields and cxDisposal);
      Frame[Frames + 1].UserInput := ((ControlExt.PackedFields and cxUserInput) > 0);
      Frame[Frames + 1].TRANSPARENT := ((ControlExt.PackedFields and cxTransparent) > 0);
      Frame[Frames + 1].Delay := ControlExt.Delay;
      Frame[Frames + 1].TransparentIndex := ControlExt.TransparentIndex;
      GifStream.Read(Seperator, SizeOf(Seperator));
    end
    else if (ExtensionBlock.ExtensionLabel = CommentLabel) then begin
      CommentPosition := GifStream.Position - SizeOf(ExtensionBlock);
      GIFStream.Read(CommentBlock, ExtensionBlock.BlockSize);
      if (Comments <> '') then Comments := Comments + Chr(13) + Chr(10);
      Comments := Comments + Copy(CommentBlock, 1, ExtensionBlock.BlockSize);
      GifStream.Read(Seperator, SizeOf(Seperator));
      while (Seperator <> 0) do begin
        GIFStream.Read(CommentBlock, Seperator);
//        if (Comments <> '') then Comments := Comments + Chr(13) + Chr(10);
        Comments := Comments + Copy(CommentBlock, 1, Seperator);
        GifStream.Read(Seperator, SizeOf(Seperator));
      end;
    end
    else begin
      GIFStream.Seek(ExtensionBlock.BlockSize, soFromCurrent);
      GifStream.Read(Seperator, SizeOf(Seperator));
      while (Seperator <> 0) do begin
        GIFStream.Seek(Seperator, soFromCurrent);
        GifStream.Read(Seperator, SizeOf(Seperator));
      end;
    end;
    GifStream.Read(Seperator, SizeOf(Seperator));
  end;
  if (Seperator = ImageSeparator) then begin
    Inc(Frames);
    GifStream.Read(ImageDescriptor, SizeOf(ImageDescriptor)); { read image descriptor }
    {Decode image header info}
    Frame[Frames].LeftPos := ImageDescriptor.ImageLeftPos;
    Frame[Frames].TopPos := ImageDescriptor.ImageTopPos;
    Frame[Frames].Width := ImageDescriptor.ImageWidth;
    Frame[Frames].Height := ImageDescriptor.ImageHeight;
    {Check for local color table}
    if ImageDescriptor.PackedFields and idLocalColorTable = idLocalColorTable then begin { if local color table }
      TableSize := 1 shl ((ImageDescriptor.PackedFields and idColorTableSize) + 1);
      GifStream.Read(Frame[Frames].ColorTable, TableSize * SizeOf(TColorItem)); { read Local Color Table }
      Frame[Frames].UseLocal := True;
    end
    else
      Frame[Frames].UseLocal := False;
    {Check for interlaced}
    if ImageDescriptor.PackedFields and idInterlaced = idInterlaced then begin
      Frame[Frames].Interlaced := True;
      InterlacePass := 0;
    end;
  end;
  {End of image header stuff}
  if (GifStream = nil) then             { check for stream error }
    Error(geNoFile);
end;
{------------------------------------------------------------------------------}

procedure TGif.InitCompressionStream;
const
  FailName: string = 'TGif.InitCompressionStream';
begin
  {InitGraphics;}{ Initialize the graphics display }
  GifStream.Read(LZWCodeSize, SizeOf(Byte)); { get minimum code size }
  if not (LZWCodeSize in [2..9]) then   { valid code sizes 2-9 bits }
    Error(geBadCodeSize);
  CurrCodeSize := succ(LZWCodeSize);    { set the initial code size }
  ClearCode := 1 shl LZWCodeSize;       { set the clear code }
  EndingCode := succ(ClearCode);        { set the ending code }
  HighCode := pred(ClearCode);          { set the highest code not needing decoding }
  BytesLeft := 0;                       { clear other variables }
  BitsLeft := 0;
  CurrentX := 0;
  CurrentY := 0;
end;
{------------------------------------------------------------------------------}

procedure TGif.ReadSubBlock;
const
  FailName: string = 'TGif.ReadSubBlock';
begin
  GifStream.Read(ImageData.Size, SizeOf(ImageData.Size)); { get the data block size }
  if ImageData.Size = 0 then
    Error(geEmptyBlock);                { check for empty block }
  GifStream.Read(ImageData.Data, ImageData.Size); { read in the block }
  NextByte := 1;                        { reset next byte }
  BytesLeft := ImageData.Size;          { reset bytes left }
end;
{------------------------------------------------------------------------------}

function TGif.NextCode: Word;           { returns a code of the proper bit size }
const
  FailName: string = 'TGif.NextCode';
begin
  if BitsLeft = 0 then begin            { any bits left in byte ? }
    if BytesLeft <= 0 then ReadSubBlock; { any bytes left?  If not get another block }
    CurrByte := ImageData.Data[NextByte]; { get a byte }
    Inc(NextByte);                      { set the next byte index }
    BitsLeft := 8;                      { set bits left in the byte }
    Dec(BytesLeft);                     { decrement the bytes left counter }
  end;
  Result := CurrByte shr (8 - BitsLeft); { shift off any previosly used bits}
  while CurrCodeSize > BitsLeft do begin { need more bits ? }
    if BytesLeft <= 0 then ReadSubBlock; { any bytes left in block?  If not read in another block}
    CurrByte := ImageData.Data[NextByte]; { get another byte }
    Inc(NextByte);                      { increment NextByte counter }
    Result := Result or (CurrByte shl BitsLeft); { add the remaining bits to the return value }
    BitsLeft := BitsLeft + 8;           { set bit counter }
    Dec(BytesLeft);                     { decrement bytesleft counter }
  end;
  BitsLeft := BitsLeft - CurrCodeSize;  { subtract the code size from bitsleft }
  Result := Result and CodeMask[CurrCodeSize]; { mask off the right number of bits }
end;

{------------------------------------------------------------------------------}

procedure TGif.Decode;
{ this procedure actually decodes the GIF image }
const
  FailName: string = 'TGif.Decode';
var
  SP: Integer;                          { index to the decode stack }

  { local procedure that decodes a code and puts it on the decode stack }

  procedure DecodeCode(var Code: Word);
  const
    FailName: string = 'Decode.DecodeCode';
  begin
    while Code > HighCode do begin      { rip thru the prefix list placing suffixes onto the decode stack }
      DecodeStack[SP] := Suffix[Code];  { put the suffix on the decode stack }
      Inc(SP);                          { increment decode stack index }
      Code := Prefix[Code];             { get the new prefix }
    end;
    DecodeStack[SP] := Code;            { put the last code onto the decode stack }
    Inc(SP);                            { increment the decode stack index }
  end;

var
  TempOldCode, OldCode: Word;
  BufCnt: Word;                         { line buffer counter }
  Code, C: Word;
  CurrBuf: Word;                        { line buffer index }
  MaxVal: Boolean;
begin
  InitCompressionStream;                { Initialize decoding paramaters }
  OldCode := 0;
  SP := 0;
  BufCnt := Frame[Frames].Width;        { set the Image Width }
  CurrBuf := 0;
  MaxVal := False;
  C := NextCode;                        { get the initial code - should be a clear code }
  while C <> EndingCode do begin        { main loop until ending code is found }
    if C = ClearCode then begin         { code is a clear code - so clear }
      CurrCodeSize := LZWCodeSize + 1;  { reset the code size }
      Slot := EndingCode + 1;           { set slot for next new code }
      TopSlot := 1 shl CurrCodeSize;    { set max slot number }
      while C = ClearCode do
        C := NextCode;                  { read until all clear codes gone - shouldn't happen }
      if C = EndingCode then Error(geBadCode); { ending code after a clear code }
      if C >= Slot then C := 0;         { if the code is beyond preset codes then set to zero }
      OldCode := C;
      DecodeStack[sp] := C;             { output code to decoded stack }
      Inc(SP);                          { increment decode stack index }
    end
    else begin                          { the code is not a clear code or an ending code so it must be a code code - so decode the code }
      Code := C;
      if Code < Slot then begin         { is the code in the table? }
        DecodeCode(Code);               { decode the code }
        if Slot <= TopSlot then begin   { add the new code to the table }
          Suffix[Slot] := Code;         { make the suffix }
          Prefix[slot] := OldCode;      { the previous code - a link to the data }
          Inc(Slot);                    { increment slot number }
          OldCode := C;                 { set oldcode }
        end;
        if Slot >= TopSlot then begin   { have reached the top slot for bit size, increment code bit size}
          if CurrCodeSize < 12 then begin { new bit size not too big? }
            TopSlot := TopSlot shl 1;   { new top slot }
            Inc(CurrCodeSize)           { new code size }
          end
          else
            MaxVal := True;             { Must check next code is a start code }
        end;
      end
      else begin                        { the code is not in the table }
        if Code <> Slot then Error(geBadCode); { so error out }
        { the code does not exist so make a new entry in the code table
        and then translate the new code }
        TempOldCode := OldCode;         { make a copy of the old code }
        while OldCode > HighCode do begin { translate the old code and place it on the decode stack }
          DecodeStack[SP] := Suffix[OldCode]; { do the suffix }
          OldCode := Prefix[OldCode];   { get next prefix }
        end;
        DecodeStack[SP] := OldCode;     { put the code onto the decode stack }
        { but DO NOT increment stack index }
{ the decode stack is not incremented because because we are only
translating the oldcode to get the first character }
        if Slot <= TopSlot then begin   { make new code entry }
          Suffix[Slot] := OldCode;      { first char of old code }
          Prefix[Slot] := TempOldCode;  { link to the old code prefix }
          Inc(Slot);                    { increment slot }
        end;
        if Slot >= TopSlot then begin   { slot is too big, increment code size }
          if CurrCodeSize < 12 then begin
            TopSlot := TopSlot shl 1;   { new top slot }
            Inc(CurrCodeSize);          { new code size }
          end
          else
            MaxVal := True;             { Must check next code is a start code }
        end;
        DecodeCode(Code);               { now that the table entry exists decode it }
        OldCode := C;                   { set the new old code }
      end;
    end;
    { the decoded string is on the decode stack so pop it off and put it into the line buffer }
    while SP > 0 do begin
      Dec(SP);
      LineBuffer[CurrBuf] := DecodeStack[SP];
      Inc(CurrBuf);
      Dec(BufCnt);
      if BufCnt = 0 then begin          { is the line full ? }
        CreateLine;
        CurrBuf := 0;
        BufCnt := Frame[Frames].Width;
      end;
    end;
    C := NextCode;                      { get the next code and go at is some more }
    if (MaxVal = True) and (C <> ClearCode) then Error(geBitSizeOverflow);
    MaxVal := False;
  end;
end;
{------------------------------------------------------------------------------}

procedure TGif.CreateBitHeader;
{ This routine takes the values from the GIF image
 descriptor and fills in the appropriate values in the
 bit map header struct. }
const
  FailName: string = 'TGif.CreateBitHeader';
var
  Bmi: ^TBitmapInfo;
  RGB: ^TRGBQuad;
  i: Integer;
  Pal: ^LOGPALETTE;
  PalEntry: ^PALETTEENTRY;
begin
  Frame[Frames].ghBmi := GlobalAlloc(GHND, SizeOf(TBitmapInfoHeader) + 256 * SizeOf(TRGBQuad));
  Bmi := GlobalLock(Frame[Frames].ghBmi);
  Bmi^.bmiHeader.biSize := SizeOf(TBitmapInfoHeader);
  Bmi^.bmiHeader.biWidth := Frame[Frames].Width;
  Bmi^.bmiHeader.biHeight := Frame[Frames].Height;
  Bmi^.bmiHeader.biPlanes := 1;         {Arcane and rarely used}
  Bmi^.bmiHeader.biBitCount := 8;
  Bmi^.bmiHeader.biCompression := BI_RGB; {Sorry Did not implement compression in this version}
  Bmi^.bmiHeader.biSizeImage := 0;      {Valid since we are not compressing the image}
  Bmi^.bmiHeader.biXPelsPerMeter := 143; {Rarely used very arcane field}
  Bmi^.bmiHeader.biYPelsPerMeter := 143; {Ditto}
  Bmi^.bmiHeader.biClrUsed := 0;        {all colors are used}
  Bmi^.bmiHeader.biClrImportant := 0;   {all colors are important}

  RGB := Addr(Bmi.bmiColors);
  if Frame[Frames].UseLocal then begin
    GetMem(Pal, SizeOf(LOGPALETTE) + 256 * SizeOf(PALETTEENTRY));
    ZeroMemory(Pal, SizeOf(LOGPALETTE) + 256 * SizeOf(PALETTEENTRY));
    Pal^.palVersion := $300;
    Pal^.palNumEntries := 256;
    PalEntry := @Pal.palPalEntry;
    for i := 0 to 255 do begin
      RGB^.rgbBlue := Frame[Frames].ColorTable[i].Blue;
      RGB^.rgbGreen := Frame[Frames].ColorTable[i].Green;
      RGB^.rgbRed := Frame[Frames].ColorTable[i].Red;
      RGB^.rgbReserved := 0;
      Inc(RGB);
      PalEntry^.peRed := Frame[Frames].ColorTable[i].Red;
      PalEntry^.peGreen := Frame[Frames].ColorTable[i].Green;
      PalEntry^.peBlue := Frame[Frames].ColorTable[i].Blue;
      Inc(PalEntry);
    end;
    Frame[Frames].Palette := CreatePalette(Pal^);
    FreeMem(Pal);
    if (GlobalPalette = 0) and (Frames = 1) then
      GlobalPalette := Frame[Frames].Palette;
  end
  else begin
    for i := 0 to 255 do begin
      RGB^.rgbBlue := GlobalColorTable[i].Blue;
      RGB^.rgbGreen := GlobalColorTable[i].Green;
      RGB^.rgbRed := GlobalColorTable[i].Red;
      RGB^.rgbReserved := 0;
      Inc(RGB);
    end;
    Frame[Frames].Palette := GlobalPalette;
  end;

  if Frame[Frames].TRANSPARENT then begin
    if (Frame[Frames].UseLocal) then
      Frame[Frames].TransparentColor :=
        Frame[Frames].ColorTable[Frame[Frames].TransparentIndex].Blue shl 16 +
        Frame[Frames].ColorTable[Frame[Frames].TransparentIndex].Green shl 8 +
        Frame[Frames].ColorTable[Frame[Frames].TransparentIndex].Red
    else
      Frame[Frames].TransparentColor :=
        GlobalColorTable[Frame[Frames].TransparentIndex].Blue shl 16 +
        GlobalColorTable[Frame[Frames].TransparentIndex].Green shl 8 +
        GlobalColorTable[Frame[Frames].TransparentIndex].Red;
  end;

  if ((Bmi^.bmiHeader.biWidth mod 4) = 0) then
    LineSize := Bmi^.bmiHeader.biWidth
  else
    LineSize := Bmi^.bmiHeader.biWidth + (4 - (Bmi^.bmiHeader.biWidth mod 4));
  GlobalUnlock(Frame[Frames].ghbmi);
  Frame[Frames].ghBits := GlobalAlloc(GHND, Bmi^.bmiHeader.biHeight * LineSize);
end;
{------------------------------------------------------------------------------}

{fills in Line list with current line}

procedure TGif.CreateLine;
const
  FailName: string = 'TGif.CreateLine';
var
  lpBits: ^Byte;
  i: Integer;
  AddY: Integer;
  Spaces: Integer;
  NewghBmi: HGLOBAL;
begin
  if (CurrentY >= Frame[Frames].Height) then begin
    Frame[Frames].Height := CurrentY + 1;
    NewghBmi := GlobalReAlloc(Frame[Frames].ghBits, Frame[Frames].Height * LineSize, GMEM_ZEROINIT);
    if (NewghBmi = 0) then Exit;
    Frame[Frames].ghBits := NewghBmi;
  end;
  lpBits := GlobalLock(Frame[Frames].ghBits);
  Inc(lpBits, (Frame[Frames].Height - CurrentY - 1) * LineSize);
  CopyMemory(lpBits, Addr(LineBuffer), Frame[Frames].Width);

  {Prepare for the next line}
  if Frame[Frames].InterLaced then begin { Interlace support }
    case InterlacePass of
      0: begin
          Addy := 8;
          Spaces := 7;
        end;
      1: begin
          AddY := 8;
          Spaces := 3;
        end;
      2: begin
          AddY := 4;
          Spaces := 1;
        end;
    else begin
        AddY := 2;
        Spaces := 0;
      end;
    end;
    for i := 1 to Spaces do begin
      if (CurrentY + i < Frame[Frames].Height) then begin
        Dec(lpBits, LineSize);
        CopyMemory(lpBits, Addr(LineBuffer), Frame[Frames].Width);
      end;
    end;
    Inc(CurrentY, AddY);
    if CurrentY >= Frame[Frames].Height then begin
      Inc(InterLacePass);
      case InterLacePass of
        1: CurrentY := 4;
        2: CurrentY := 2;
        3: CurrentY := 1;
      end;
    end;
  end
  else
    Inc(CurrentY);
  GlobalUnlock(Frame[Frames].ghBits)
end;

function TGif.GetFrame(i: integer): TBitmap;
var
  lpBits: ^Byte;
  lpbmi: ^TBitmapInfo;
begin
  lpbmi := GlobalLock(Frame[i].ghbmi);
  lpBits := GlobalLock(Frame[i].ghBits);
  Result:=TBitmap.create;
  Result.Width:=Frame[i].Width;
  Result.Height:=Frame[i].Height;
  SetDIBitsToDevice(Result.Canvas.Handle, 0, 0,
    Frame[i].Width, Frame[i].Height,
    0, 0, 0, Frame[i].Height, lpBits, lpbmi^, DIB_RGB_COLORS);
  GlobalUnlock(Frame[i].ghBits);
  GlobalUnlock(Frame[i].ghbmi);
end;

function TGif.Render(FramesWide: Integer): TBitmap;
const
  FailName: string = 'TGif.Render';
var
//  Pal: HPALETTE;
//  ValidPalette: Boolean;
  MaxWidth, MaxHeight: Integer;
  W, H: Integer;
  X, Y: Integer;
  NextX, NextY: Integer;
  i: Integer;
  lpBits: ^Byte;
  lpbmi: ^TBitmapInfo;
begin
  MaxWidth := LogicalScreen.ScreenWidth;
  MaxHeight := LogicalScreen.ScreenHeight;
{  if (Frame[1].UseLocal) and ((LogicalScreen.PackedFields and lsdGlobalColorTable) = lsdGlobalColorTable) then begin
    ValidPalette := False;
    for i := 1 to 255 do begin
      if (GlobalColorTable[i].Red <> GlobalColorTable[0].Red) or
        (GlobalColorTable[i].Green <> GlobalColorTable[0].Green) or
        (GlobalColorTable[i].Blue <> GlobalColorTable[0].Blue) then begin
        ValidPalette := True;
        Break;
      end;
    end;
    if ValidPalette then
      Pal := GlobalPalette
    else
      Pal := Frame[1].Palette;
  end
  else begin
    if (LogicalScreen.PackedFields and lsdGlobalColorTable) = lsdGlobalColorTable then
      Pal := GlobalPalette
    else
      Pal := Frame[1].Palette;
  end;   }
  if Frames > FramesWide then begin
    W := FramesWide;
    H := Frames div W;
    if (Frames mod W) <> 0 then Inc(H);
  end
  else begin
    W := Frames;
    H := 1;
  end;
  Result := TBitmap.Create;
  Result.width := MaxWidth * W;
  Result.Height := MaxHeight * H;
//  Result.Palette := CopyPalette(Pal);

  X := 0;
  Y := 0;
  for i := 1 to Frames do begin
    NextX := (i mod W) * MaxWidth;
    NextY := (i div W) * MaxHeight;

    lpbmi := GlobalLock(Frame[i].ghbmi);
    lpBits := GlobalLock(Frame[i].ghBits);
    SetDIBitsToDevice(Result.Canvas.Handle, X + Frame[i].LeftPos, Y + Frame[i].TopPos,
      Frame[i].Width, Frame[i].Height,
      0, 0, 0, Frame[i].Height, lpBits, lpbmi^, DIB_RGB_COLORS);
    GlobalUnlock(Frame[i].ghBits);
    GlobalUnlock(Frame[i].ghbmi);
    GlobalFree(Frame[i].ghBits);
    Frame[i].ghBits := 0;
    GlobalFree(Frame[i].ghbmi);
    Frame[i].ghbmi := 0;

    X := NextX;
    Y := NextY;
  end;

end;

{$IFDEF DirectX}

function TGif.RenderSurface(FramesWide: Integer): IDirectDrawSurface;
const
  FailName: string = 'TGif.RenderSurface';
var
{$IFDEF DirectX}
  ddsd: DDSurfaceDesc;
  DC: HDC;
{$ENDIF}
  MaxWidth, MaxHeight: Integer;
  W, H: Integer;
  X, Y: Integer;
  NextX, NextY: Integer;
  i: Integer;
  lpBits: ^Byte;
  lpbmi: ^TBitmapInfo;
begin
  MaxWidth := LogicalScreen.ScreenWidth;
  MaxHeight := LogicalScreen.ScreenHeight;
  if Frames > FramesWide then begin
    W := FramesWide;
    H := Frames div W;
    if (Frames mod W) <> 0 then Inc(H);
  end
  else begin
    W := Frames;
    H := 1;
  end;
  ddsd.dwSize := SizeOf(ddsd);
  ddsd.dwFlags := DDSD_CAPS + DDSD_HEIGHT + DDSD_WIDTH;
  ddsd.ddsCaps.dwCaps := DDSCAPS_OFFSCREENPLAIN or DDSCAPS_SYSTEMMEMORY;
  ddsd.dwWidth := MaxWidth * W;
  ddsd.dwHeight := MaxHeight * H;
  lpdd.CreateSurface(ddsd, Result, nil);

  X := 0;
  Y := 0;
  for i := 1 to Frames do begin
    NextX := (i mod W) * MaxWidth;
    NextY := (i div W) * MaxHeight;

    lpbmi := GlobalLock(Frame[i].ghbmi);
    lpBits := GlobalLock(Frame[i].ghBits);

    Result.GetDC(DC);
    SetDIBitsToDevice(DC, X + Frame[i].LeftPos, Y + Frame[i].TopPos,
      Frame[i].Width, Frame[i].Height,
      0, 0, 0, Frame[i].Height, lpBits, lpbmi^, DIB_RGB_COLORS);
    Result.ReleaseDC(DC);
    GlobalUnlock(Frame[i].ghBits);
    GlobalUnlock(Frame[i].ghbmi);
    GlobalFree(Frame[i].ghBits);
    Frame[i].ghBits := 0;
    GlobalFree(Frame[i].ghbmi);
    Frame[i].ghbmi := 0;

    X := NextX;
    Y := NextY;
  end;
end;
{$ENDIF}

end.

