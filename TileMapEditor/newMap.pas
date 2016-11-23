unit newMap;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Numedit;

type
  TfrmNewMap = class(TForm)
    edtMapHeight: TNumEdit;
    edtMapWidth: TNumEdit;
    edtTileWidth: TNumEdit;
    EdtTileHeight: TNumEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnOk: TButton;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNewMap: TfrmNewMap;

implementation

{$R *.DFM}

procedure TfrmNewMap.btnOkClick(Sender: TObject);
begin
     if strToInt(edtMapWidth.text) < 18 then
     begin
        showmessage('MapWidth may not be less than 18');
        exit;
     end;
     if strToInt(edtMapHeight.text) < 40  then
     begin
        showmessage('MapHeight may not be less than 40');
        exit;
     end;
close;
end;

end.
