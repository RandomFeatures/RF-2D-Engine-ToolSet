unit StaticProp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Numedit, ExtCtrls;

type
  TfrmStaticProp = class(TForm)
    lblX: TLabel;
    lblY: TLabel;
    Label6: TLabel;
    btnSave: TButton;
    cbGroupID: TComboBox;
    btnCancel: TButton;
    edtLength: TNumEdit;
    edtWidth: TNumEdit;
    edtDrawOrder: TNumEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtRed: TNumEdit;
    Label5: TLabel;
    edtBlue: TNumEdit;
    Label8: TLabel;
    edtGreen: TNumEdit;
    Label9: TLabel;
    edtBlend: TNumEdit;
    Label10: TLabel;
    cbLayer: TComboBox;
    Label7: TLabel;
    cbShadow: TCheckBox;
    edtFrameIndx: TEdit;
    pnAmbientColor: TPanel;
    cDialog: TColorDialog;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure pnAmbientColorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStaticProp: TfrmStaticProp;

implementation

{$R *.DFM}

procedure TfrmStaticProp.btnSaveClick(Sender: TObject);
begin
modalresult := mrOk;
Close;
end;

procedure TfrmStaticProp.btnCancelClick(Sender: TObject);
begin
modalresult := mrCancel;
Close;
end;

procedure TfrmStaticProp.pnAmbientColorClick(Sender: TObject);
var
  L : Longint;

begin
 if cDialog.Execute then
 begin
     pnAmbientColor.Color := cDialog.Color;
     L := ColorToRGB(cDialog.Color);
     edtRed.text := IntToStr(GetRValue(L));
     edtGreen.text := IntToStr(GetGValue(L));
     edtBlue.text := IntToStr(GetBValue(L));
 end;

end;

end.
