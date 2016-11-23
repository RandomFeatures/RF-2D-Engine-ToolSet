unit settings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ComCtrls, PBFolderDialog, inifiles;

type
  TfrmSetting = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    edtMapPath: TEdit;
    edtTexturePath: TEdit;
    edtScriptPath: TEdit;
    edtTilePath: TEdit;
    edtChrPath: TEdit;
    edtStaticPath: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtEditorPath: TEdit;
    Label7: TLabel;
    btnSave: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    PBFolderDialog1: TPBFolderDialog;
    Label8: TLabel;
    edtSpritePath: TEdit;
    SpeedButton8: TSpeedButton;
    OpenExe: TOpenDialog;
    TabSheet2: TTabSheet;
    Label9: TLabel;
    edtGameEngine: TEdit;
    SpeedButton9: TSpeedButton;
    Label10: TLabel;
    edtParticlePath: TEdit;
    SpeedButton10: TSpeedButton;
    Label11: TLabel;
    edtEditorScriptPath: TEdit;
    SpeedButton11: TSpeedButton;
    procedure btnSaveClick(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     strMapPath: string;
     strTexturePath: string;
     strScriptPath: string;
     strCharPath: string;
     strEditorPath: string;
  end;

var
  frmSetting: TfrmSetting;

implementation

{$R *.DFM}

procedure TfrmSetting.btnSaveClick(Sender: TObject);
var
  MyIniFile: TIniFile;
begin

  MyIniFile := TIniFile.create(ChangeFileExt(Application.exename, '.ini'));

  MyIniFile.WriteString('Path', 'Maps', edtMapPath.text);
  MyIniFile.WriteString('Path', 'Textures', edtTexturePath.text );
  MyIniFile.WriteString('Path', 'Scripts', edtScriptPath.text);
  MyIniFile.WriteString('Path', 'Chars', edtChrPath.text );
  MyIniFile.WriteString('Path', 'Editor', edtEditorPath.text);
  MyIniFile.WriteString('Path', 'Tiles', edtTilePath.text);
  MyIniFile.WriteString('Path', 'GameEngine', edtGameEngine.text);
  MyIniFile.WriteString('Path', 'EditorScr', edtEditorScriptPath.text);
  MyIniFile.free;

  ModalResult := MrOk;

end;

procedure TfrmSetting.SpeedButton9Click(Sender: TObject);
begin
     if OpenExe.Execute then
        edtGameEngine.text := openExe.FileName;
end;

end.
