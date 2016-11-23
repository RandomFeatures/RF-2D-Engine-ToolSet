unit mapprop;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, Numedit, Spin, ComCtrls, ExtCtrls, SQLiteTable3;

type
  TfrmMapProp = class(TForm)
    cDialog: TColorDialog;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    pnAmbientColor: TPanel;
    GroupBox2: TGroupBox;
    edtName: TEdit;
    Label2: TLabel;
    btnCancel: TButton;
    btnSave: TButton;
    cbMapType: TComboBox;
    Label3: TLabel;
    cbShadows: TCheckBox;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    pnlFogColor: TPanel;
    tbFogBlend: TTrackBar;
    cbFogType: TComboBox;
    Label7: TLabel;
    cbFogTexture: TComboBox;
    Label8: TLabel;
    Label10: TLabel;
    edtSnow: TNumEdit;
    Label9: TLabel;
    edtArmySize: TNumEdit;
    cbWindDir: TComboBox;
    Label13: TLabel;
    Label11: TLabel;
    tbCloudBlend: TTrackBar;
    Label12: TLabel;
    edtDesc: TMemo;
    Label1: TLabel;
    GroupBox4: TGroupBox;
    cbWalkSfx: TComboBox;
    procedure pnAmbientColorClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure pnlFogColorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Setup(db: string);
  end;

var
  frmMapProp: TfrmMapProp;

implementation

{$R *.DFM}

procedure TfrmMapProp.pnAmbientColorClick(Sender: TObject);
begin
  if cDialog.Execute then
     pnAmbientColor.Color := cDialog.Color;

end;

procedure TfrmMapProp.btnSaveClick(Sender: TObject);
begin
     ModalResult := mrOK;
end;

procedure TfrmMapProp.btnCancelClick(Sender: TObject);
begin
     ModalResult := mrCancel;
end;

procedure TfrmMapProp.pnlFogColorClick(Sender: TObject);
begin
  if cDialog.Execute then
     pnlFogColor.Color := cDialog.Color;

end;

procedure TfrmMapProp.Setup(db: string);
var
objDB: TSQLiteDatabase;
objDS: TSQLiteTable;
strSQL: String;
strFileName: string;
strID: string;
begin
    objDB := TSQLiteDatabase.Create(db);
    cbWalkSfx.Clear;

    //get image file name
    strSQL := 'SELECT [SFXID], [FileName] from [tblISO_SoundFX] WHERE [Active] = 1 and [SFXType] = 3;';
    objDS := objDB.GetTable(strSQL);
    if objDS.Count > 0 then
    begin
         while not objDS.EOF do
         begin
             try
                strFileName := objDS.FieldAsString(objDS.FieldIndex['FileName']);
                StrID := objDS.FieldAsString(objDS.FieldIndex['SFXID']);
              //  cbWalkSfx.Items.Add(strFileName);
                cbWalkSfx.Items.Values[strFileName] := StrID;
              finally
                 objDS.Next;
              end;
         end
    end;
    objDS.Free;
    objDB.free;

end;

end.
