unit fBitFlag1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, CheckLst;

type
  TfBitFlag = class(TForm)
    clOptions: TCheckListBox;
    Panel1: TPanel;
    cbCancel: TButton;
    cbOk: TButton;
    pnInstruct: TPanel;
    lbInstruct: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.
