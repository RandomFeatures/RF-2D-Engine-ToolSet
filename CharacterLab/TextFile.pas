unit TextFile;

interface

uses Classes;

type
TTextFileWriter = class(TObject)
 constructor Create(Filename: string);
 destructor  Destroy; override;
private
 FDisabled: boolean;
 FDisconnected: boolean;
 FFilename: string;
 FTextFile: TFileStream;
public
 procedure WriteString(s: string);
 procedure WriteLogEntry(s: string);
 property  Filename: string read FFilename;
 procedure Disconnect;       //temporarily closes file so it can be read by other processes
 procedure Reconnect;
end;

//if this implementation is too slow, we can always go to a TStringList
//there's the old AssignFile method also
TTextFileReader = class(TObject)
 constructor Create(Filename: string);
 destructor  Destroy; override;
private
 FFilename: string;
 FTextFile: TFileStream;
 function GetEOF: boolean;
public
 function ReadLine: string;
 property Eof: boolean read GetEOF;
 property Filename: string read FFilename;
end;

//declare a global instance of a writer for a log file.
//any unit writing to the log should include TextFile in the
//uses clause (implementation, not interface)
var
  tLog: TTextFileWriter;

implementation

uses SysUtils;

constructor TTextFileWriter.Create(Filename: string);
begin
  inherited Create;
  FDisabled := false;
  FFilename := Filename;
  try
     if FileExists(FFilename) then DeleteFile(FFilename);
     FTextFile := TFileStream.Create(FFilename,  fmCreate or fmShareDenyNone);
  except
     FDisabled := true;
  end;
end;

destructor TTextFileWriter.Destroy;
begin
  FTextFile.Free;
  inherited;
end;

procedure TTextFileWriter.Disconnect;
begin
  FTextFile.Free;
  FDisconnected := true;
end;

procedure TTextFileWriter.Reconnect;
begin
  if FDisconnected then begin
     FTextFile := TFileStream.Create(FFilename,  fmOpenReadWrite or fmShareDenyNone);
     FTextFile.Seek(0, soFromEnd);
     FDisconnected := false;
  end;
end;

procedure TTextFileWriter.WriteLogEntry(s: string);
begin
  WriteString(TimeToStr(Time) + ': ' + s);
end;

procedure TTextFileWriter.WriteString(s: string);
begin
  if not (FDisabled or FDisconnected) then begin
     s := s + chr(13) + chr(10);
     FTextFile.Write(s[1], length(s));
  end;
end;

{ TTextFileReader }

constructor TTextFileReader.Create(Filename: string);
begin
  inherited Create;
  FFilename := Filename;
  if not FileExists(FFilename) then
     raise Exception.Create('File not found');
  FTextFile := TFileStream.Create(FFilename, fmOpenRead + fmShareDenyNone);
end;

destructor TTextFileReader.Destroy;
begin
  FTextFile.Free;
  inherited;
end;

function TTextFileReader.GetEOF: boolean;
begin result := FTextFile.Position >= FTextFile.Size end;

function TTextFileReader.ReadLine: string;
var c: char;
    s: string;
    bDone: boolean;
begin
  s := '';
  bDone := Eof;
  while not bDone do begin
     FTextFile.Read(c, 1);
     if c = #13 then begin
        FTextFile.Read(c, 1);
        if c <> #10 then
           FTextFile.Seek(-1, soFromCurrent);
        bDone := true;
     end else begin
        s := s + c;
        bDone := Eof;
     end;
  end;
  result := s;
end;

end.
