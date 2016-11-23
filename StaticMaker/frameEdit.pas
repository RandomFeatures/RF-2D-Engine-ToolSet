unit frameEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Numedit, Buttons;

type
  TfrmFrameEdit = class(TForm)
    ScrollBox1: TScrollBox;
    imgMain: TImage;
    procedure FormShow(Sender: TObject);
    procedure imgMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMainMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ScrollBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScrollBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScrollBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    OffSetX: integer;
    OffSetY: integer;
    Dragging: boolean;
    Sizing: boolean;
    mColor: TColor;
    procedure Draw;
    { Private declarations }
  public
    { Public declarations }
    MasterBMP: TBitMap;
    procedure Setup;
    procedure DrawClear;
  end;

var
  frmFrameEdit: TfrmFrameEdit;

implementation

{$R *.DFM}


procedure TfrmFrameEdit.Draw;
begin
    imgMain.Canvas.Brush.Color := mColor;
    imgMain.Canvas.FillRect(Rect(0,0,imgMain.Width,imgMain.Height));
    imgMain.Canvas.Draw(OffSetX,OffSetY,MasterBMP);
         //Border box
    if Sizing then
    begin
      imgMain.canvas.Pen.Color := clBlue;
      imgMain.canvas.Pen.Style := psDot;
      imgMain.canvas.MoveTo(0,0);
      imgMain.canvas.LineTo(imgMain.width-1,0);
      imgMain.canvas.LineTo(imgMain.Width-1,imgMain.Height-1);
      imgMain.canvas.LineTo(0,imgMain.Height-1);
      imgMain.canvas.LineTo(0,0);
    end;
    caption := 'Frame Editor (' + IntToStr(imgMain.width) + 'x' + IntToStr(imgMain.height) + ')';
end;

procedure TfrmFrameEdit.DrawClear;
begin
    imgMain.Canvas.Brush.Color := mColor;
    imgMain.Canvas.FillRect(Rect(0,0,imgMain.Width,imgMain.Height));
    imgMain.Canvas.Draw(OffSetX,OffSetY,MasterBMP);
end;

procedure TfrmFrameEdit.FormShow(Sender: TObject);
begin
     Draw;
end;

procedure TfrmFrameEdit.Setup;
begin
     MasterBMP.Canvas.Brush.Color := mColor;
     MasterBMP.Canvas.FillRect(Rect(0,0,MasterBMP.Width,MasterBMP.Height));
     imgMain.width := MasterBMP.Width;
     imgMain.height := MasterBMP.height;
     imgMain.Picture.Bitmap.width :=  MasterBMP.Width;
     imgMain.Picture.Bitmap.Height := MasterBMP.height;

     imgMain.Canvas.Brush.Color := mColor;
     imgMain.Canvas.FillRect(Rect(0,0,imgMain.Width,imgMain.Height));
     OffSetX := 0;
     OffSetY := 0;
end;
procedure TfrmFrameEdit.imgMainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
         if (X > imgMain.width-4) and (Y < imgMain.Height-4) then
            Sizing:= true
         else
         if (X < imgMain.width-4) and (Y > imgMain.Height-4) then
            Sizing:= true
         else
         if (X > imgMain.width-4) and (Y > imgMain.Height-4)  then
            Sizing:= true
         else
             Dragging := true
end;

procedure TfrmFrameEdit.imgMainMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     Dragging := false;
     Sizing:= False;
     ScrollBox1.Cursor := crDefault;
     Draw;
end;

procedure TfrmFrameEdit.imgMainMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    if Dragging then
    begin
        OffSetX:= X - (MasterBMP.Width div 2);
        OffSetY:= Y - (MasterBMP.Height div 2);
        Draw;
    end;
   if not Sizing then
   begin
   if (X < imgMain.width+4) and (X > imgMain.width-4) and (Y < imgMain.Height-4) then
      ScrollBox1.Cursor :=  crSizeWE
   else
   if (X < imgMain.width-4) and (Y > imgMain.Height-4)and (Y < imgMain.Height+4) then
      ScrollBox1.Cursor :=  crSizeNS
   else
   if (X < imgMain.width+4) and (X > imgMain.width-4) and (Y > imgMain.Height-4)and (Y < imgMain.Height+4)  then
      ScrollBox1.Cursor :=  crSizeNWSE
   else
       ScrollBox1.Cursor := crDefault;
   end;
   if Sizing then
   begin
       case ScrollBox1.Cursor of
       crSizeWE:
       begin
            imgMain.width := X;
            imgMain.Picture.Bitmap.width :=  X;
       end;
       crSizeNS:
       begin
            imgMain.height:= Y;
            imgMain.Picture.Bitmap.height := Y;
       end;
       crSizeNWSE:
       begin
            imgMain.width:= X;
            imgMain.Picture.Bitmap.width :=  X;
            imgMain.Picture.Bitmap.Height := Y;
            imgMain.height:= Y;
       end;
       end;
       Draw;
   end;


end;

procedure TfrmFrameEdit.ScrollBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
         if (X < imgMain.width+4) and (X > imgMain.width-4) and (Y < imgMain.Height-4) then
            Sizing:= true
         else
         if (X < imgMain.width-4) and (Y > imgMain.Height-4)and (Y < imgMain.Height+4) then
            Sizing:= true
         else
         if (X < imgMain.width+4) and (X > imgMain.width-4) and (Y > imgMain.Height-4)and (Y < imgMain.Height+4)  then
            Sizing:= true
         else
              Sizing:= false;

end;

procedure TfrmFrameEdit.ScrollBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     Sizing:= false;
     Dragging := false;
     ScrollBox1.Cursor := crDefault;
     Draw;
end;

procedure TfrmFrameEdit.ScrollBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin

         if not Sizing then
         begin
         if (X < imgMain.width+4) and (X > imgMain.width-4) and (Y < imgMain.Height-4) then
         ScrollBox1.Cursor :=  crSizeWE
         else
         if (X < imgMain.width-4) and (Y > imgMain.Height-4)and (Y < imgMain.Height+4) then
         ScrollBox1.Cursor :=  crSizeNS
         else
         if (X < imgMain.width+4) and (X > imgMain.width-4) and (Y > imgMain.Height-4)and (Y < imgMain.Height+4)  then
         ScrollBox1.Cursor :=  crSizeNWSE
         else
         ScrollBox1.Cursor := crDefault;
         end;
         if Sizing then
         begin
             case ScrollBox1.Cursor of
             crSizeWE:
             begin
                  imgMain.width := X;
                  imgMain.Picture.Bitmap.width :=  X;
             end;
             crSizeNS:
             begin
                  imgMain.height:= Y;
                  imgMain.Picture.Bitmap.height := Y;
             end;
             crSizeNWSE:
             begin
                  imgMain.width:= X;
                  imgMain.Picture.Bitmap.width :=  X;
                  imgMain.Picture.Bitmap.Height := Y;
                  imgMain.height:= Y;
             end;
             end;
             Draw;
         end;
end;

procedure TfrmFrameEdit.FormCreate(Sender: TObject);
begin
     mColor := 16745215;
     MasterBMP := TBitMap.Create;
     MasterBMP.TransparentColor := mColor;
     MasterBMP.TransparentMode := tmFixed;
     MasterBMP.transparent := true;
end;

procedure TfrmFrameEdit.FormDestroy(Sender: TObject);
begin
     MasterBMP.FreeImage;
     MasterBMP.free;
end;

procedure TfrmFrameEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     modalresult := mrok;
end;

end.
