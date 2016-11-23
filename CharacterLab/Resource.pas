unit Resource;

interface

uses
  Classes, Windows, SysUtils, Graphics, Anigrp30, AniDec30, INIFiles, GifCode;

type
  TDynamicWordArray = array of Word;

  TFacing = (fSS,fSE,fEE,fNE,fNN,fNW,fWW,fSW);

  TStringIniFile = class(TCustomIniFile)
  private
    FSections: TStringList;
    FData: string;
    function AddSection(const Section: string): TStrings;
    procedure LoadValues;
  public
    Filename: string;
    constructor Create(const Data: string);
    destructor Destroy; override;
    procedure Clear;
    procedure DeleteKey(const Section, Ident: String); override;
    procedure EraseSection(const Section: string); override;
    procedure GetStrings(List: TStrings);
    procedure ReadSection(const Section: string; Strings: TStrings); override;
    procedure ReadSections(Strings: TStrings); override;
    procedure ReadSectionValues(const Section: string; Strings: TStrings); override;
    function ReadString(const Section, Ident, Default: string): string; override;
    procedure SetStrings(List: TStrings);
    procedure UpdateFile; override;
    procedure WriteString(const Section, Ident, Value: String); override;
  end;

  TResource = class(TAniFigure)
  private
    FFrameCount: integer;
  protected
    procedure LoadAction(INI: TStringIniFile; Action: string; Base: integer);
    procedure LoadScript(S,Name: string; Index: integer);
  public
    constructor Load(Filename: string);
    procedure LoadData(INI: TStringIniFile; BM: TBitmap); virtual; abstract;
    property FrameCount: integer read FFrameCount;
  end;

  TCharacterResource = class(TResource)
  private
    FDefaultFrame: integer;
    FContactFrame: integer;
  public
    procedure LoadData(INI: TStringIniFile; BM: TBitmap); override;
    property DefaultFrame: integer read FDefaultFrame;
    property ContactFrame: integer read FContactFrame;
  end;

  TSpriteResource = class(TResource)
  private
    FDefaultFrame: integer;
  public
    procedure LoadData(INI: TStringIniFile; BM: TBitmap); override;
    property DefaultFrame: integer read FDefaultFrame;
  end;

const
  RenderWidth = 8;
  scrLoop = 1;
  scrDie = 2;
  Angles = 8;
  //Scripts
  WalkBase = 1;
  WalkS =  WalkBase+0;
  WalkSE = WalkBase+1;
  WalkE =  WalkBase+2;
  WalkNE = WalkBase+3;
  WalkN =  WalkBase+4;
  WalkNW = WalkBase+5;
  WalkW =  WalkBase+6;
  WalkSW = WalkBase+7;
  StandBase = 9;
  StandS =  StandBase+0;
  StandSE = StandBase+1;
  StandE =  StandBase+2;
  StandNE = StandBase+3;
  StandN =  StandBase+4;
  StandNW = StandBase+5;
  StandW =  StandBase+6;
  StandSW = StandBase+7;
  AttackBase = 17;
  AttackS =  AttackBase+0;
  AttackSE = AttackBase+1;
  AttackE =  AttackBase+2;
  AttackNE = AttackBase+3;
  AttackN =  AttackBase+4;
  AttackNW = AttackBase+5;
  AttackW =  AttackBase+6;
  AttackSW = AttackBase+7;
  PainBase = 25;
  PainS =  PainBase+0;
  PainSE = PainBase+1;
  PainE =  PainBase+2;
  PainNE = PainBase+3;
  PainN =  PainBase+4;
  PainNW = PainBase+5;
  PainW =  PainBase+6;
  PainSW = PainBase+7;
  DeathBase = 33;
  DeathS =  DeathBase+0;
  DeathSE = DeathBase+1;
  DeathE =  DeathBase+2;
  DeathNE = DeathBase+3;
  DeathN =  DeathBase+4;
  DeathNW = DeathBase+5;
  DeathW =  DeathBase+6;
  DeathSW = DeathBase+7;

var
  ArtPath: string;

procedure GetFile(Filename: string; var BM: TBitmap; var INI: TStringIniFile; var FrameCount: integer);
function LoadTile(Map: TAniMap; Zone,Index: word; INI: TStringIniFile; BM: TBitmap; TileCount: integer): integer;
procedure LoadStaticObject(Map: TAniMap; Zone,Index: word; INI: TStringIniFile; BM: TBitmap);
function Parse(S: string; Index: integer; ParseChar: Char): string;

implementation

function Parse(S: string; Index: integer; ParseChar: Char): string;
var
  i,j: integer;
begin
  result:='';
  for i:=1 to Index do begin
    j:=Pos(ParseChar,S);
    if j=0 then exit;
    S:=copy(S,j+1,length(S)-j);
  end;
  j:=Pos(ParseChar,S);
  if j=0 then
    result:=S
  else
    result:=copy(S,1,j-1);
end;

procedure LoadStaticObject(Map: TAniMap; Zone,Index: word; INI: TStringIniFile; BM: TBitmap);
var
  S: string;
//  W,H: integer;
  CollisionMask,DepthAnchors: TDynamicWordArray;

  procedure LoadArray(var A: TDynamicWordArray);
  var
    C: string;
    i: integer;
  begin
    i:=0;
    while true do begin
      C:=lowercase(Parse(S,i,','));
      if C='' then begin
        break;
      end
      else begin
        inc(i);
        SetLength(A,i);
        A[i-1]:=StrToInt(C);
      end;
    end;
  end;

begin
  CollisionMask:=nil;
  DepthAnchors:=nil;
//  W:=INI.ReadInteger('Header','ImageWidth',BM.width);
//  H:=INI.ReadInteger('Header','ImageHeight',BM.Height);
  S:=INI.ReadString('Header','CollisionMask','');
  if (S<>'') and (S<>'XX') then LoadArray(CollisionMask);
  S:=INI.ReadString('Header','DepthAnchors','');
  if (S<>'') and (S<>'XX') then LoadArray(DepthAnchors);
  Map.DefineItem(Zone,Index,BM,DepthAnchors,CollisionMask);
  CollisionMask:=nil;
  DepthAnchors:=nil;
end;

function LoadTile(Map: TAniMap; Zone,Index: word; INI: TStringIniFile; BM: TBitmap; TileCount: integer): integer;
var
  TileBM: TBitmap;
  W,H: integer;
  i: integer;
begin
  W:=INI.ReadInteger('Header','ImageWidth',BM.Width);
  H:=INI.ReadInteger('Header','ImageHeight',BM.Height);
//  S:=INI.ReadString('Header','CollisionMask',''); //Collision mask not yet supported
  if TileCount>1 then begin
    TileBM:=TBitmap.create;
    TileBM.width:=W;
    TileBM.height:=H;
    result:=TileCount;
    for i:=0 to result-1 do begin
      BitBlt(TileBM.canvas.handle,0,0,W,H,BM.canvas.handle,(i mod RenderWidth)*W,(i div RenderWidth)*H,SRCCOPY);
      Map.DefineTile(Zone,Index+i,TileBM);
    end;
    TileBM.free;
  end
  else begin
    result:=1;
    Map.DefineTile(Zone,Index,BM);
  end;
end;

procedure GetFile(Filename: string; var BM: TBitmap; var INI: TStringIniFile; var FrameCount: integer);
var
  GIF: TGIF;
  Comments: string;
begin
  GIF:=TGIF.create;
  try
    GIF.GifConvert(ArtPath+Filename);
    BM:=GIF.Render(RenderWidth);
    FrameCount:=GIF.Frames;
    Comments:=GIF.Comments;
  finally
    GIF.free;
  end;
  INI:=TStringIniFile.Create(Comments);
end;

{ TResource }

constructor TResource.Load(Filename: string);
var
  TempFilename: string;
  BM: TBitmap;
  INI: TStringIniFile;
begin
  inherited Create(nil);

  GetFile(Filename,BM,INI,FFrameCount);
  LoadData(INI,BM);
  BM.free;
  INI.free;
  DeleteFile(TempFileName);
end;

procedure TResource.LoadScript(S,Name: string; Index: integer);
var
  NewScript: ScriptInfo;
  C: string;
  i: integer;
begin
  i:=0;
  while true do begin
    C:=lowercase(Parse(S,i,','));
    if C='loop' then begin
      NewScript.tag:=scrLoop;
      NewScript.Frames:=i;
      Script[Index]:=NewScript;
      break;
    end
    else if C='die' then begin
      NewScript.tag:=scrDie;
      NewScript.Frames:=i;
      Script[Index]:=NewScript;
      break;
    end
    else if C='' then begin
      NewScript.tag:=0;
      NewScript.Frames:=i;
      Script[Index]:=NewScript;
      break;
    end
    else begin
      inc(i);
      NewScript.FrameID[i]:=StrToInt(C);
    end;
  end;
end;

procedure TResource.LoadAction(INI: TStringIniFile; Action: string; Base: integer);
var
  S: string;
begin
  S:=INI.ReadString(Action,'SSFrames','');
  LoadScript(S,Action,Base+0);
  S:=INI.ReadString(Action,'SEFrames','');
  LoadScript(S,Action,Base+1);
  S:=INI.ReadString(Action,'EEFrames','');
  LoadScript(S,Action,Base+2);
  S:=INI.ReadString(Action,'NEFrames','');
  LoadScript(S,Action,Base+3);
  S:=INI.ReadString(Action,'NNFrames','');
  LoadScript(S,Action,Base+4);
  S:=INI.ReadString(Action,'NWFrames','');
  LoadScript(S,Action,Base+5);
  S:=INI.ReadString(Action,'WWFrames','');
  LoadScript(S,Action,Base+6);
  S:=INI.ReadString(Action,'SWFrames','');
  LoadScript(S,Action,Base+7);
end;

{ TCharacterResource }

procedure TCharacterResource.LoadData(INI: TStringIniFile; BM: TBitmap);
var
  S: string;
begin
  Width:=INI.ReadInteger('Header','ImageWidth',BM.Width);
  if Width>BM.Width then Width:=BM.Width;
  Height:=INI.ReadInteger('Header','ImageHeight',BM.Height);
  if Height>BM.Height then Height:=BM.Height;
  S:=Lowercase(INI.ReadString('Header','Blend',''));
  if (S='add') then SpecialEffect:=seAdd
  else if (S='subtract') or (S='sub') then SpecialEffect:=seSubtract
  else if (S='alpha') then SpecialEffect:=seTranslucent
  else SpecialEffect:=seNone;
  Alpha:=INI.ReadInteger('Header','BlendAmount',0);
  S:=Lowercase(INI.ReadString('Header','UseLighting',''));
  if (S='no') then UseLighting:=false
  else UseLighting:=true;
  TransparentColor:=INI.ReadInteger('Header','TransparentColor',clAqua);
  S:=Lowercase(INI.ReadString('Header','Highlightable',''));
  if (S='yes') then Highlightable:=true
  else Highlightable:=false;
  HighlightColor:=INI.ReadInteger('Header','HighlightColor',clRed);
  Radius:=INI.ReadInteger('Header','CollisionRadius',8);
  FrameMultiplier:=INI.ReadInteger('Header','FrameMultiplier',1);
  CenterX:=INI.ReadInteger('Header','CollisionHorizOffset',Width div 2);
  CenterY:=INI.ReadInteger('Header','CollisionVertOffset',Height-4);
  Speed:=INI.ReadFloat('Header','Speed',5.0);
  S:=INI.ReadString('Header','EditorImage','');
  if S='' then begin
    S:=Lowercase(INI.ReadString('Action Stand','SEFrames','1'));
    FDefaultFrame:=StrToInt(Parse(S,0,','));
  end
  else begin
    FDefaultFrame:=StrToInt(S);
  end;

  LoadAction(INI,'Action Stand',StandBase);
  LoadAction(INI,'Action Walk',WalkBase);
  LoadAction(INI,'Action Attack',AttackBase);
  LoadAction(INI,'Action Pain',PainBase);
  LoadAction(INI,'Action Death',DeathBase);

  FContactFrame:=INI.ReadInteger('Action Attack','TriggerFrame',1);

  Picture:=BM;
end;

{ TSpriteResource }

procedure TSpriteResource.LoadData(INI: TStringIniFile; BM: TBitmap);
var
  S: string;
begin
  Width:=INI.ReadInteger('Header','ImageWidth',BM.Width);
  if Width>BM.Width then Width:=BM.Width;
  Height:=INI.ReadInteger('Header','ImageHeight',BM.Height);
  if Height>BM.Height then Height:=BM.Height;
  S:=Lowercase(INI.ReadString('Header','Blend',''));
  if (S='add') then SpecialEffect:=seAdd
  else if (S='subtract') or (S='sub') then SpecialEffect:=seSubtract
  else if (S='alpha') then SpecialEffect:=seTranslucent
  else SpecialEffect:=seNone;
  Alpha:=INI.ReadInteger('Header','BlendAmount',0);
  S:=Lowercase(INI.ReadString('Header','UseLighting',''));
  if (S='no') then UseLighting:=false
  else UseLighting:=true;
  TransparentColor:=INI.ReadInteger('Header','TransparentColor',clAqua);
  S:=Lowercase(INI.ReadString('Header','Highlightable',''));
  if (S='yes') then Highlightable:=true
  else Highlightable:=false;
  HighlightColor:=INI.ReadInteger('Header','HighlightColor',clRed); //remove
  Radius:=INI.ReadInteger('Header','CollisionRadius',8);
  FrameMultiplier:=INI.ReadInteger('Header','FrameMultiplier',1);
  CenterX:=INI.ReadInteger('Header','CollisionHorizOffset',Width div 2);
  CenterY:=INI.ReadInteger('Header','CollisionVertOffset',Height-4);
  Speed:=INI.ReadFloat('Header','Speed',5.0);
  S:=INI.ReadString('Header','EditorImage','');
  if S='' then begin
    S:=Lowercase(INI.ReadString('Action Stand','SEFrames','1'));
    FDefaultFrame:=StrToInt(Parse(S,0,','));
  end
  else begin
    FDefaultFrame:=StrToInt(S);
  end;

  Picture:=BM;
end;

{ TStringINIFile }

constructor TStringIniFile.Create(const Data: string);
begin
  FSections := TStringList.Create;
  FData := Data;
  LoadValues;
end;

destructor TStringIniFile.Destroy;
begin
  if FSections <> nil then Clear;
  FSections.Free;
end;

function TStringIniFile.AddSection(const Section: string): TStrings;
begin
  Result := TStringList.Create;
  try
    FSections.AddObject(Section, Result);
  except
    Result.Free;
  end;
end;

procedure TStringIniFile.Clear;
var
  I: Integer;
begin
  for I := 0 to FSections.Count - 1 do
    TStrings(FSections.Objects[I]).Free;
  FSections.Clear;  
end;

procedure TStringIniFile.DeleteKey(const Section, Ident: String);
var
  I, J: Integer;
  Strings: TStrings;
begin
  I := FSections.IndexOf(Section);
  if I >= 0 then
  begin
    Strings := TStrings(FSections.Objects[I]);
    J := Strings.IndexOfName(Ident);
    if J >= 0 then Strings.Delete(J);
  end;
end;

procedure TStringIniFile.EraseSection(const Section: string);
var
  I: Integer;
begin
  I := FSections.IndexOf(Section);
  if I >= 0 then
  begin
    TStrings(FSections.Objects[I]).Free;
    FSections.Delete(I);
  end;
end;

procedure TStringIniFile.GetStrings(List: TStrings);
var
  I, J: Integer;
  Strings: TStrings;
begin
  List.BeginUpdate;
  try
    for I := 0 to FSections.Count - 1 do
    begin
      List.Add('[' + FSections[I] + ']');
      Strings := TStrings(FSections.Objects[I]);
      for J := 0 to Strings.Count - 1 do List.Add(Strings[J]);
      List.Add('');
    end;
  finally
    List.EndUpdate;
  end;
end;

procedure TStringIniFile.LoadValues;
var
  List: TStringList;
begin
  if (FData <> '') then
  begin
    List := TStringList.Create;
    try
      List.Text:=FData;
      SetStrings(List);
    finally
      List.Free;
    end;
  end else Clear;
end;

procedure TStringIniFile.ReadSection(const Section: string;
  Strings: TStrings);
var
  I, J: Integer;
  SectionStrings: TStrings;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    I := FSections.IndexOf(Section);
    if I >= 0 then
    begin
      SectionStrings := TStrings(FSections.Objects[I]);
      for J := 0 to SectionStrings.Count - 1 do
        Strings.Add(SectionStrings.Names[J]);
    end;
  finally
    Strings.EndUpdate;
  end;
end;

procedure TStringIniFile.ReadSections(Strings: TStrings);
begin
  Strings.Assign(FSections);
end;

procedure TStringIniFile.ReadSectionValues(const Section: string;
  Strings: TStrings);
var
  I: Integer;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    I := FSections.IndexOf(Section);
    if I >= 0 then Strings.Assign(TStrings(FSections.Objects[I]));
  finally
    Strings.EndUpdate;
  end;
end;

function TStringIniFile.ReadString(const Section, Ident,
  Default: string): string;
var
  I: Integer;
  Strings: TStrings;
begin
  I := FSections.IndexOf(Section);
  if I >= 0 then
  begin
    Strings := TStrings(FSections.Objects[I]);
    I := Strings.IndexOfName(Ident);
    if I >= 0 then
    begin
      Result := Copy(Strings[I], Length(Ident) + 2, Maxint);
      Exit;
    end;
  end;
  Result := Default;
end;

procedure TStringIniFile.SetStrings(List: TStrings);
var
  I: Integer;
  S: string;
  Strings: TStrings;
begin
  Clear;
  Strings := nil;
  for I := 0 to List.Count - 1 do
  begin
    S := Trim(List[I]);
    if (S <> '') and (S[1] <> ';') then
      if (S[1] = '[') and (S[Length(S)] = ']') then
        Strings := AddSection(Copy(S, 2, Length(S) - 2))
      else
        if Strings <> nil then Strings.Add(S);
  end;
end;

procedure TStringIniFile.UpdateFile;
var
  List: TStringList;
begin
  if (Filename<>'') then begin
    List := TStringList.Create;
    try
      GetStrings(List);
      List.SaveToFile(FileName);
    finally
      List.Free;
    end;
  end;  
end;

procedure TStringIniFile.WriteString(const Section, Ident, Value: String);
var
  I: Integer;
  S: string;
  Strings: TStrings;
begin
  I := FSections.IndexOf(Section);
  if I >= 0 then
    Strings := TStrings(FSections.Objects[I]) else
    Strings := AddSection(Section);
  S := Ident + '=' + Value;
  I := Strings.IndexOfName(Ident);
  if I >= 0 then Strings[I] := S else Strings.Add(S);
end;

end.
