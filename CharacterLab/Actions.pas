unit Actions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, StrFunctions, IniFiles, gifext, GifImage, BLRadioBtn;

type
  TfrmAction = class(TForm)
    pcActions: TPageControl;
    btnClose: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure DirectionChange(Sender: TObject);
    Procedure BuildActions(ListActions: string);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
   strfileName: string;

  end;

var
  frmAction: TfrmAction;
implementation

uses BuildLayer1;

{$R *.DFM}

procedure TfrmAction.FormShow(Sender: TObject);
begin
     top :=  frmBuildLayer.top ;
     left := frmBuildLayer.left + frmBuildLayer.width + 10;
end;

procedure TfrmAction.btnCloseClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmAction.DirectionChange(Sender: TObject);
var
iloop: integer;
begin
  try
     frmBuildLayer.ListFrames := '';
     for iLoop := 0 to StrTokenCount(frmBuildLayer.MainIniFile.Readstring('Action '+(sender as TBLRadioBtn).ActionText, (sender as TBLRadioBtn).DirectionText, ''), ',') - 1 do
         if StrToIntDef(StrTokenAt(frmBuildLayer.MainIniFile.Readstring('Action '+(sender as TBLRadioBtn).ActionText, (sender as TBLRadioBtn).DirectionText, ''), ',', iLoop), -25) <> -25 then
            frmBuildLayer.ListFrames := frmBuildLayer.ListFrames + IntToStr(StrToInt(strTokenAt(frmBuildLayer.MainIniFile.Readstring('Action '+(sender as TBLRadioBtn).ActionText, (sender as TBLRadioBtn).DirectionText, ''), ',', iLoop)) -1) + '|';
     strStripLast(frmBuildLayer.ListFrames);
     frmBuildLayer.FirstFrame := StrToInt(StrTokenAt(frmBuildLayer.ListFrames, '|', 0));
     frmBuildLayer.LastFrame :=  StrToInt(StrTokenAt(frmBuildLayer.ListFrames, '|', StrTokenCount(frmBuildLayer.ListFrames, '|') -1));
     frmBuildLayer.NextFrame := frmBuildLayer.FirstFrame;
     frmBuildLayer.FrameCounter:= -1;

     frmBuildLayer.NextFrame := frmBuildLayer.Nextframe - 1;
     frmBuildLayer.FrameCounter := frmBuildLayer.FrameCounter - 1;
     if frmBuildLayer.framecounter < 0 then frmBuildLayer.frameCounter := -1  ;
     frmBuildLayer.AnimationControl;

  except
  end


end;


procedure TfrmAction.BuildActions(ListActions: string);
var
iLoop: integer;
NewTabSheet : TTabSheet;
NewRadioBtn: TBLRadioBtn;

   procedure AddBLRadioBtn(iTop: integer; Dir: TBLDirection; chkd: boolean);
   begin
        try
           NewRadioBtn:= TBLRadioBtn.Create(NewTabSheet);
           NewRadioBtn.parent:= NewTabSheet;
           NewRadioBtn.Left := 8;
           NewRadioBtn.Top := iTop;
           NewRadioBtn.Checked := Chkd;
           NewRadioBtn.OnClick := DirectionChange;
           NewRadioBtn.Direction := Dir;
           NewRadioBtn.ActionText := NewTabSheet.Caption;
           NewRadioBtn.Show;
       finally
          NewRadioBtn:= nil;
       end;
   end;

begin
  try
    if ListActions = '' then exit;
    for iLoop := 0 to StrTokenCount(ListActions, ',') -1 do
    begin
        NewTabSheet := TTabSheet.Create(Self);
        NewTabSheet.Caption := StrTokenAt(ListActions, ',', iLoop);
        NewTabSheet.PageControl := pcActions;
        NewTabSheet.show;

        AddBLRadioBtn(16, blSouthWest, false);
        AddBLRadioBtn(41, blWest, false);
        AddBLRadioBtn(66, blNorthWest, false);
        AddBLRadioBtn(91, blNorth, false);
        AddBLRadioBtn(117, blNorthEast, false);
        AddBLRadioBtn(142, blEast, false);
        AddBLRadioBtn(167, blSouthEast, false);
        AddBLRadioBtn(192, blSouth, false);
        NewTabSheet := nil;
    end;
        pcActions.ActivePage := pcActions.Pages[0];
  except
  end;
end;

procedure TfrmAction.FormDestroy(Sender: TObject);
begin
    while ComponentCount <> 0 do
        Components[0].free;

end;

procedure TfrmAction.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     frmBuildLayer.ChangeAction1.Checked := false;
end;

end.
