unit scriptMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, strFunctions, Menus, StdActns, ActnList,
  MemoEx, ComCtrls, ExtCtrls, ImgList, IniFiles;

type
  TfrmScript = class(TForm)
    Panel1: TPanel;
    btnSaveCnv: TSpeedButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    ImageList1: TImageList;
    Action1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    OpenDialog1: TOpenDialog;
    FindDialog1: TFindDialog;
    SaveDialog1: TSaveDialog;
    SaveAs1: TMenuItem;
    N1: TMenuItem;
    EditStatusBar: TStatusBar;
    Panel2: TPanel;
    Panel3: TPanel;
    Button1: TButton;
    Button2: TButton;
    InsertAIScriptBase1: TMenuItem;
    mmEventScr: TMemoEx;
    procedure Save1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure InsertAIScriptBase1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mmEventScrGetLineAttr(Sender: TObject; const Line: String;
      Index: Integer; const SelAttrs: TSelAttrs; var Attrs: TLineAttrs);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    FSearchStartPos : Integer;
    FSearchNextPos : Integer;
    BlueList: TStringList;
    GreenList: TStringList;
    RedList: TStringList;
    PurpleList: TStringList;
    BoldList: TStringList;
  public
    { Public declarations }
  published
      property SearchStartPos : Integer read FSearchStartPos write FSearchStartPos;
      property SearchNextPos : Integer read FSearchNextPos write FSearchNextPos;
  end;

var
  frmScript: TfrmScript;

implementation



{$R *.DFM}



procedure TfrmScript.Save1Click(Sender: TObject);
begin
    if OpenDialog1.FileName <> '' then
       mmEventScr.Lines.SaveToFile(OpenDialog1.filename)
    else
    if SaveDialog1.execute then
    begin
       mmEventScr.Lines.SaveToFile(SaveDialog1.filename);
    end;

end;

procedure TfrmScript.SaveAs1Click(Sender: TObject);
begin
    if SaveDialog1.execute then
    begin
       mmEventScr.Lines.SaveToFile(SaveDialog1.filename);
    end;

end;

procedure TfrmScript.Open1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
     mmEventScr.Lines.LoadFromFile(OpenDialog1.filename);
     EditStatusBar.Panels[1].text := OpenDialog1.filename;
  end;
end;


procedure TfrmScript.Button1Click(Sender: TObject);
begin
    ModalResult := mrOk;
    close;
end;

procedure TfrmScript.Button2Click(Sender: TObject);
begin
     ModalResult := mrCancel;
     close;
end;

procedure TfrmScript.InsertAIScriptBase1Click(Sender: TObject);
begin
     mmEventScr.lines.LoadFromFile(ExtractFilePath(Application.exename) + 'Resources\Editor\ScriptBase.lst');
end;

procedure TfrmScript.FormCreate(Sender: TObject);
var
  ColorIni: TiniFile;
begin
      //create my color lists
      BlueList := TStringList.Create;
      GreenList := TStringList.Create;
      RedList := TStringList.Create;
      PurpleList := TStringList.Create;
      BoldList := TStringList.Create;
      
      //open the color ini file
      ColorIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+  'Resources\Editor\scriptColors.ini');
      //Read in the colors for the script commands
      ColorIni.ReadSection('blue', BlueList);
      ColorIni.ReadSection('red', RedList);
      ColorIni.ReadSection('green', GreenList);
      ColorIni.ReadSection('purple', PurpleList);
      ColorIni.ReadSection('bold',BoldList);

      ColorIni.free;

end;

procedure TfrmScript.FormDestroy(Sender: TObject);
begin
      BlueList.free;
      GreenList.free;
      RedList.free;
      PurpleList.free;
      BoldList.free;
end;

procedure TfrmScript.mmEventScrGetLineAttr(Sender: TObject;
  const Line: String; Index: Integer; const SelAttrs: TSelAttrs;
  var Attrs: TLineAttrs);
var
  iOLoop, iLoop, iPos: integer;
  tmpStr: string;
  strLine: string;
begin
  //grab the current line
  strLine := LowerCase(Line);

  //see if the current line contains words from the blue list
  for iOLoop := 0 to  BlueList.Count -1 do
  begin
    tmpStr :=  BlueList.Strings[iOLoop];
    iPos := Pos(tmpStr,strLine);
    if (iPos <> 0) then
       for iLoop := iPos-1 to iPos + Length(tmpStr) - 2 do
           Attrs[iLoop].FC := clBlue;
  end;

  //see if the current line contains words from the green list
  for iOLoop :=  0 to GreenList.Count -1 do
  begin
    tmpStr := GreenList.Strings[iOLoop];
    iPos := Pos(tmpStr,strLine);
    if (iPos <> 0) then
       for iLoop := iPos-1 to iPos + Length(tmpStr) - 2 do
           Attrs[iLoop].FC := clGreen;
  end;

  //see if the current line contains words from the red list
  for iOLoop := 0 to RedList.Count -1 do
  begin
    tmpStr := RedList.Strings[iOLoop];
    iPos := Pos(tmpStr,strLine);
    if (iPos <> 0) then
       for iLoop := iPos-1 to iPos + Length(tmpStr) - 2 do
           Attrs[iLoop].FC := clRed;
  end;

    // color these special case characters
    iPos := Pos('=',strLine);
    if (iPos <> 0) then
       Attrs[iPos-1].FC := clRed;


    iPos := Pos(';',strLine);
    if (iPos <> 0) then
       Attrs[iPos-1].FC := clRed;

    iPos := Pos('[',strLine);
    if (iPos <> 0) then
       Attrs[iPos-1].FC := clRed;

    iPos := Pos(']',strLine);
    if (iPos <> 0) then
       Attrs[iPos-1].FC := clRed;


  //see if the current line contains words from the purple list
  for iOLoop := 0 to PurpleList.Count -1 do
  begin
    tmpStr := PurpleList.Strings[iOLoop];
    iPos := Pos(tmpStr,strLine);
    if (iPos <> 0) then
       for iLoop := iPos-1 to iPos + Length(tmpStr) - 2 do
           Attrs[iLoop].FC := clPurple
  end;

  //see if the current line contains words from the bold list
  for iOLoop := 0 to BoldList.Count -1 do
  begin
    tmpStr := BoldList.Strings[iOLoop];
    iPos := Pos(tmpStr,strLine);
    if (iPos <> 0) then
       for iLoop := iPos-1 to iPos + Length(tmpStr) - 2 do
           Attrs[iLoop].Style := [fsBold];
  end;

end;

procedure TfrmScript.FormShow(Sender: TObject);
begin
     mmEventScr.SetFocus;
end;

end.
