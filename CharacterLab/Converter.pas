unit converter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, digifx,
  StdCtrls, ExtCtrls, GIFCode, INIFiles, DFX;

type
  TStringIniFile = class(TCustomIniFile)
  private
    FSections: TStringList;
    FData: string;
    function AddSection(const Section: string): TStrings;
    procedure LoadValues;
  public
    FileName: string;
    constructor Create(const Data: string);
    destructor Destroy; override;
    procedure Clear;
    procedure DeleteKey(const Section, Ident: string); override;
    procedure EraseSection(const Section: string); override;
    procedure GetStrings(List: TStrings);
    procedure ReadSection(const Section: string; Strings: TStrings); override;
    procedure ReadSections(Strings: TStrings); override;
    procedure ReadSectionValues(const Section: string; Strings: TStrings); override;
    function ReadString(const Section, Ident, Default: string): string; override;
    procedure SetStrings(List: TStrings);
    procedure UpdateFile; override;
    procedure WriteString(const Section, Ident, Value: string); override;
    property Data: string read FData;
  end;

  function GIFToPOX(Filename: string): boolean;

implementation

function GIFToPOX(Filename: string): boolean;
var
  GIF: TGIF;
  POXFile: string;
  Stream: TmemoryStream;
  FileStream: TFileStream;
  Comments,S: string;
  TextOnly: boolean;
  L: longword;
  EOB: word;
  INI: TStringIniFile;
  RLE: TRLESprite;
  Color: TColor;
begin
  result:=false;
  EOB:=$4242;
  POXFile:=ChangeFileExt(Filename,'.pox');

  GIF := TGIF.Create;
  try
    GIF.GifConvert(Filename);
    Comments := GIF.Comments;
    INI:=TStringIniFile.create(Comments);
    Color:=INI.ReadInteger('Header','TransparentColor',clAqua);
    try
      Stream:=TMemoryStream.create;
      try
        TextOnly:=false;
        Stream.write(#80#79#88#65,4); //POX vA - Proprietary Object eXtension
        S:=lowercase(trim(INI.ReadString('Header','GameClass','')));
        if (S='character') or (S='charactersprite') then begin
          S:=lowercase(trim(INI.ReadString('Header','LayeredParts','')));
          if (S='yes') or (S='base') then begin
            Stream.write(#76#76,2); //fmt LL
          end
          else begin
            if ini.SectionExists('Layers') then begin
              Stream.write(#76#67,2); //fmt LC
              TextOnly:=true;
            end
            else begin
              Stream.write(#67#67,2); //fmt CC
            end;
          end;
        end
        else if S='doorsprite' then begin
          Stream.write(#68#83,2); //fmt DS
        end
        else if S='staticobject' then begin
          Stream.write(#83#84,2); //fmt ST
        end
        else if S='multiimagetile' then begin
          Stream.write(#84#84,2); //fmt TT
        end
        else if S='projectile' then begin
          Stream.write(#80#82,2); //fmt PR
        end
        else if S='spellcast' then begin
          Stream.write(#83#67,2); //fmt SC
        end
        else if S='inventoryitem'  then begin
          Stream.write(#73#73,2); //fmt II
        end
        else if S='spriteobject' then begin
          Stream.write(#83#80,2); //fmt SP
        end
        else
          exit;

        Stream.write(#13#10,2);
        S:=INI.Data;
        L:=Length(S);
        if TextOnly then begin
          Stream.write(S[1],L);
        end
        else begin
          Stream.write(L,sizeof(L));
          Stream.write(S[1],L);
          Stream.write(EOB,sizeof(EOB));
          RLE:=TRLESprite.create;
          RLE.LoadFromGIF(GIF,Color);
          RLE.SaveToStream(Stream);
          Stream.write(EOB,sizeof(EOB));
        end;
        FileStream:=TFileStream.create(POXFile,fmCreate or fmShareExclusive);
        try
          Stream.SaveToStream(FileStream);
        finally
          FileStream.free;
        end;  
        result:=true;
      finally
        Stream.free;
      end;
    finally
      INI.free;
    end;
  finally
    GIF.free;
  end;
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

procedure TStringIniFile.DeleteKey(const Section, Ident: string);
var
  I, J: Integer;
  Strings: TStrings;
begin
  I := FSections.IndexOf(Section);
  if I >= 0 then begin
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
  if I >= 0 then begin
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
    for I := 0 to FSections.Count - 1 do begin
      List.Add('[' + FSections[I] + ']');
      Strings := TStrings(FSections.Objects[I]);
      for J := 0 to Strings.Count - 1 do
        List.Add(Strings[J]);
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
  if (FData <> '') then begin
    List := TStringList.Create;
    try
      List.Text := FData;
      SetStrings(List);
    finally
      List.Free;
    end;
  end
  else
    Clear;
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
    if I >= 0 then begin
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
  if I >= 0 then begin
    Strings := TStrings(FSections.Objects[I]);
    I := Strings.IndexOfName(Ident);
    if I >= 0 then begin
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
  for I := 0 to List.Count - 1 do begin
    S := Trim(List[I]);
    if (S <> '') and (S[1] <> ';') then
      if (S[1] = '[') and (S[Length(S)] = ']') then
        Strings := AddSection(Copy(S, 2, Length(S) - 2))
      else if Strings <> nil then
        Strings.Add(S);
  end;
end;

procedure TStringIniFile.UpdateFile;
var
  List: TStringList;
begin
  if (FileName <> '') then begin
    List := TStringList.Create;
    try
      GetStrings(List);
      List.SaveToFile(FileName);
    finally
      List.Free;
    end;
  end;
end;

procedure TStringIniFile.WriteString(const Section, Ident, Value: string);
var
  I: Integer;
  S: string;
  Strings: TStrings;
begin
  I := FSections.IndexOf(Section);
  if I >= 0 then
    Strings := TStrings(FSections.Objects[I])
  else
    Strings := AddSection(Section);
  S := Ident + '=' + Value;
  I := Strings.IndexOfName(Ident);
  if I >= 0 then
    Strings[I] := S
  else
    Strings.Add(S);
end;

end.
