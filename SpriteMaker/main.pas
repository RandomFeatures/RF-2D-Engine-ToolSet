unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus,DFX, digifx, Converter, inifiles, ComCtrls, ExtCtrls,
  Buttons, Numedit, PBFolderDialog, strFunctions, NGImages, NGConst,
  Spin, dirscanner, Math, SQLiteTable3;

type
  TStaticType =(stDefault, stWall, stFurniture, stWallDec);
  TDirection = (dNone, dSW, dSE);

  TFrame = class(TObject)
  public
     FileName: string;
     X: integer;
     Y: integer;
     OffSetX: integer;
     OffSetY: integer;
     DisplayOffX: integer;
     DisplayOffY: integer;
     PoxIndex: integer;
     DisplayOrder: integer;
     Length: integer;
     Width: integer;
     Selected: Boolean;
     bmp: TBitmap;
     Dir: TDirection;
  end;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    SaveAs1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    OpenPox: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    mmScript: TMemo;
    TabSheet2: TTabSheet;
    ColorDialog1: TColorDialog;
    ScrollBox1: TScrollBox;
    imgMain: TImage;
    Panel1: TPanel;
    ofOpen: TPBFolderDialog;
    btnSave: TSpeedButton;
    Bevel1: TBevel;
    Panel2: TPanel;
    lbFrames: TListBox;
    Panel3: TPanel;
    btnAddImage: TSpeedButton;
    btnDeleteImage: TSpeedButton;
    btnImageDown: TSpeedButton;
    btnImageUp: TSpeedButton;
    OpenDialog: TOpenDialog;
    edtColCount: TNumEdit;
    Label1: TLabel;
    edtIHeight: TNumEdit;
    edtIWidth: TNumEdit;
    Label2: TLabel;
    Label3: TLabel;
    Panel4: TPanel;
    Label4: TLabel;
    edtXoffset: TSpinEdit;
    Label5: TLabel;
    edtYoffset: TSpinEdit;
    Presets1: TMenuItem;
    mnuPreDefault: TMenuItem;
    edtBaseName: TEdit;
    Label8: TLabel;
    N2: TMenuItem;
    btnAdjustSize: TSpeedButton;
    mnuClearAll: TMenuItem;
    mnuOpnPox: TMenuItem;
    Label12: TLabel;
    SpinEdit1: TSpinEdit;
    Label11: TLabel;
    SpinEdit2: TSpinEdit;
    btnSpriteScript: TSpeedButton;
    SpriteScript1: TMenuItem;
    Timer1: TTimer;
    edtFWidth: TNumEdit;
    edtFHeight: TNumEdit;
    Label6: TLabel;
    Label7: TLabel;
    Bevel3: TBevel;
    cbAni: TComboBox;
    cbBlend: TCheckBox;
    Label9: TLabel;
    btnFrameSize: TSpeedButton;
    procedure SaveAs1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure edtXoffsetChange(Sender: TObject);
    procedure btnAddImageClick(Sender: TObject);
    procedure lbFramesClick(Sender: TObject);
    procedure edtYoffsetChange(Sender: TObject);
    procedure mnuPreDefaultClick(Sender: TObject);
    procedure btnDeleteImageClick(Sender: TObject);
    procedure btnImageDownClick(Sender: TObject);
    procedure btnImageUpClick(Sender: TObject);
    procedure mnuClearAllClick(Sender: TObject);
    procedure imgMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuOpnPoxClick(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure btnSpriteScriptClick(Sender: TObject);
    procedure btnAdjustSizeClick(Sender: TObject);
    procedure imgMainMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnFrameSizeClick(Sender: TObject);
  private
    { Private declarations }
    Comments: string;
    mColor: TColor;
    FrameWidth,FrameHeight: integer;
    exportname: string;
    LastDir: string;
    MainIniFile: TMemInifile;
    FrameList: TList;
    PresetType: TStaticType;
    MouseOffSet: Boolean;
    strMapPath: string;
    strTexturePath: string;
    strScriptPath: string;
    strCharPath: string;
    strEditorIconPath: string;
    strEditorTilePath: string;
    strSpritePath: string;
    strStaticPath: string;
    strGameEngine: string;
    strParticlePath: string;
    strEditorScrPath: string;
    strDatabase: string;
  public
    { Public declarations }
    procedure LoadPOX(POXFile: string);
    procedure LoadBMP(BMPFile: string);
    procedure SetSize;
    procedure Draw;
    function NextPow2(n: integer): integer;
    procedure LoadSetupPoxImage(FileName: string);
    procedure SaveFile(FileName: string);
    procedure BuildSpriteScript(FileName: string);
    procedure AutoSize;
    procedure LoadIniFile;
    procedure SaveDatabase(FileName: string);

  end;

var
  frmMain: TfrmMain;
  M: array [1..2] of Char;

implementation

{$R *.DFM}

procedure TfrmMain.LoadPOX(POXFile: string);
var
  Stream: TFileStream;
  L: longint;
  EOB,BB: word;
  INI: TStringINIFile;
  MyFrame: TFrame;
  RLE: TRLESprite;
  BitPlane: TBitPlane;
  MyWidth: integer;
  MyHeight: integer;
  iLoop : integer;
begin
  EOB:=$4242;
  try
    Stream:=TFileStream.create(POXFile,fmOpenRead or fmShareCompat);
    try
      Stream.Read(L,sizeof(L));
      if (L<>$41584F50) then exit;
      Stream.Read(M,sizeof(M));
      Stream.Read(BB,sizeof(BB)); //CRLF
      if (M=#67#67) then begin //CC
        Stream.Read(L,sizeof(L));
      end
      else if (M=#76#67) then begin //LC
        L:=Stream.Size-Stream.Position;
        SaveAs1.enabled:= false;
      end
      else if (M=#68#83) then begin //DS
        Stream.Read(L,sizeof(L));
      end
      else if (M=#83#84) then begin //ST
        Stream.Read(L,sizeof(L));
      end
      else if (M=#84#84) then begin //TT
        Stream.Read(L,sizeof(L));
      end
      else if (M=#80#82) then begin //PR
        Stream.Read(L,sizeof(L));
      end
      else if (M=#83#67) then begin //SC
        Stream.Read(L,sizeof(L));
      end
      else if (M=#76#76) then begin //LL
        Stream.Read(L,sizeof(L));
      end
      else if (M=#73#73) then begin //II
        Stream.Read(L,sizeof(L));
      end
      else if (M=#83#80) then begin //SP
        Stream.Read(L,sizeof(L));
      end
      else exit;
      SetLength(Comments,L);
      Stream.Read(Comments[1],L);

      INI:=TStringINIFile.create(Comments);
      try
        if (EdtFWidth.Text = '') and (EdtFHeight.Text = '') then
        begin
             EdtFWidth.Text:=INI.ReadString('Header','ImageWidth','0');
             EdtFHeight.Text :=INI.ReadString('Header','ImageHeight','0');
        end;
        MyWidth :=INI.ReadInteger('Header','ImageWidth',0);
        MyHeight := INI.ReadInteger('Header','ImageHeight',0);
        if Odd(MyWidth) then
           MyWidth:=MyWidth +1;
        if Odd(MyHeight) then
           MyHeight:=MyHeight +1;

      finally
        INI.free;
      end;
      Stream.Read(BB,sizeof(BB));
      if BB=EOB then
      begin
        BitPlane:=TBitPlane.create(MyWidth,MyHeight);
        BitPlane.KeyColor := mColor;
        RLE:=TRLESprite.create;
        RLE.LoadFromStream(Stream);

        for iLoop := 0 to RLE.frames - 1 do
        begin
            BitPlane.Clear;
            MyFrame := TFrame.Create;
            if iLoop > 0 then
               MyFrame.FileName := ExtractFileName(ChangeFileExt(POXFile,''))+'_'+IntToStr(iLoop)
            else
               MyFrame.FileName := ExtractFileName(ChangeFileExt(POXFile,''));
            MyFrame.DisplayOrder := FrameList.Count;
            MyFrame.poxIndex :=0;
            MyFrame.DisplayOffX := 0;
            MyFrame.DisplayOffY := 0;
            MyFrame.OffSetX := 0;
            MyFrame.OffSetY := 0;
            MyFrame.Length := 1;
            MyFrame.Width := 1;
            MyFrame.Selected := false;
            MyFrame.bmp:=TBitMap.Create;
            MyFrame.bmp.TransparentColor := mcolor;
            MyFrame.bmp.TransparentMode := tmFixed;
            MyFrame.bmp.Transparent := true;
            MyFrame.bmp.Width := MyWidth;
            MyFrame.bmp.Height := MyHeight;
            MyFrame.dir := dNone;
            if POS('SW',PoxFile) > 0 then
             MyFrame.dir := dSW;
            if POS('SE',PoxFile) > 0 then
             MyFrame.dir := dSE;

            RLE.Draw(iLoop,0,0,BitPlane.Bits);
            BitPlane.DrawToDC(MyFrame.bmp.canvas.handle,0,0);
            FrameList.Add(MyFrame);
            if lbFrames.Items.IndexOf(MyFrame.FileName) = -1 then
              lbFrames.Items.Add(MyFrame.FileName)
            else
              lbFrames.Items.Add(MyFrame.FileName+IntToStr(lbFrames.Items.count));

            MyFrame := Nil;

        end;
        RLE.Free;
        BitPlane.free;
        edtColCount.text := IntToStr(FrameList.count);
      end;

    finally
      Stream.free;
    end;
  except
  end;
end;

procedure TfrmMain.LoadBMP(BMPFile: string);
var
  MyFrame: TFrame;
begin
      MyFrame := TFrame.Create;
      MyFrame.FileName := ExtractFileName(BMPFile);
      MyFrame.DisplayOrder := FrameList.Count;
      MyFrame.poxIndex :=0;
      MyFrame.DisplayOffX := 0;
      MyFrame.DisplayOffY := 0;
      MyFrame.OffSetX := 0;
      MyFrame.OffSetY := 0;
      MyFrame.Length := 1;
      MyFrame.Width := 1;
      MyFrame.Selected := false;
      MyFrame.dir := dNone;
      MyFrame.bmp := TBitmap.Create;
      MyFrame.bmp.TransparentColor := mcolor;
      MyFrame.bmp.TransparentMode := tmFixed;
      MyFrame.bmp.Transparent := true;
      if POS('SW',BMPFile) > 0 then
       MyFrame.dir := dSW;
      if POS('SE',BMPFile) > 0 then
       MyFrame.dir := dSE;

      MyFrame.bmp.LoadFromFile(BMPFile);
      if (EdtFWidth.Text = '') and (EdtFHeight.Text = '') then
      begin
            EdtFWidth.Text:=IntToStr(MyFrame.bmp.width);
            EdtFHeight.Text :=IntToStr(MyFrame.bmp.height);
      end;

      FrameList.Add(MyFrame);
end;



procedure TfrmMain.SaveAs1Click(Sender: TObject);
begin
    SaveDialog1.InitialDir := strTexturePath+'sprites\';
    if edtBaseName.text = '' then
    begin
        if SaveDialog1.execute then
        begin
            edtBaseName.text := ChangeFileExt(extractfileName(SaveDialog1.fileName),'');
//            BuildScript(mmScript.Lines[0],edtBaseName.text+'.png',true);
            SaveFile(SaveDialog1.FileName);
        end;

    end
    else
    begin
        //edtBaseName.text := ChangeFileExt(extractfileName(ofOpen.Folder+'.txt'),'');
        SaveDialog1.FileName := edtBaseName.text;
        if SaveDialog1.execute then
        begin
//          BuildScript(mmScript.Lines[0],edtBaseName.text+'.png',true);
          SaveFile(SaveDialog1.FileName);
        end;
    end;

end;

procedure TfrmMain.SaveDatabase(FileName: string);
var
   sldb: TSQLiteDatabase;
   sSQL: String;
   strBlend: string;
begin

    sldb := TSQLiteDatabase.Create(strDatabase);
    try

        if cbBlend.checked then
           strBlend := '"true"'
        else
            strBlend := '"false"';

      sSQL := 'INSERT INTO tblISO_SpriteFiles([FileName], [FrameCount], [FPS], [Width], [Height], [OneFacing], [Mode], [Blend], [Active])';
      sSQL := sSQL + ' VALUES ("Sprites\\'+ FileName +'", '+ IntToStr(FrameList.count) +',10,'+ IntToStr(FrameWidth)+',';
      sSQL := sSQL + IntToStr(FrameHeight)+',1,'+ IntToStr(cbAni.itemIndex)+','+ strBlend +',"true");';

      sldb.execsql(sSQL);
    finally
           sldb.Free;

    end;

end;

procedure TfrmMain.SaveFile(FileName: string);
var
  MyFrame: TFrame;
  NG : TNGImage;
  iLoop: integer;
begin
    //BuildSpriteScript(ExtractFileName(FileName));
    SaveDatabase(ExtractFileName(FileName));
    //mmScript.Lines.SaveToFile(strSpritePath+ChangeFileExt(ExtractFileName(FileName),'.dat'));
    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         MyFrame.Selected := false;
         MyFrame := nil;
    end;
    Draw;
    if LowerCase(ExtractFileExt(FileName)) = '.png' then
    begin
        NG := TNGImage.Create;
        NG.Assign(imgMain.Picture.Bitmap);
        NG.SetAlphaColor(mColor);
        NG.SaveToPNGfile(FileName);
        NG.Free;
    end;
    if LowerCase(ExtractFileExt(FileName)) = '.bmp' then
    begin
         imgMain.Picture.Bitmap.SaveToFile(fileName);
    end;

end;

procedure TfrmMain.Draw;
var
iLoop: integer;
jLoop : integer;
MyFrame: TFrame;
ImgLeft: integer;
ImgTop: integer;
FrameHWidth: integer;
FrameHHeight: integer;
AnchorTileX: integer;
AnchorTileY: integer;
TileX: integer;
TileY: integer;
CurrentCol: integer;
ColCount: integer;
CurrentRow: integer;
StripCount: integer;
begin
  imgMain.Canvas.Brush.Color := mColor;
  imgMain.Canvas.FillRect(Rect(0,0,imgMain.Width,imgMain.Height));

  if FrameList.Count > 0 then
  begin
    ColCount := 0;
    CurrentCol := 0;
    CurrentRow := 0;

    if  edtColCount.text <> '' then
        ColCount := StrToInt(edtColCount.text)
    else
       ColCount := FrameList.count;

    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         imgMain.canvas.Draw((CurrentCol*FrameWidth) + MyFrame.DisplayOffX,(CurrentRow*FrameHeight) + MyFrame.DisplayOffY,MyFrame.bmp);
         MyFrame := nil;

         if CurrentCol+1 = ColCount then
         begin
            Inc(CurrentRow);
            CurrentCol := 0;
         end
         else
            Inc(CurrentCol);
    end;

    CurrentCol := 0;
    CurrentRow := -1;


    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);

       //Find Out how many rows there are.
         if CurrentCol = 0 then Inc(CurrentRow);

         if MyFrame.Selected then
         begin
              StripCount := Ceil(FrameWidth / 64);
              ImgLeft:= ((CurrentCol)*FrameWidth);
              ImgTop:= ((CurrentRow)*FrameHeight);
              FrameHWidth:= FrameWidth div 2;
              FrameHHeight:= FrameHeight div 2;
              //Border box
              imgMain.canvas.Pen.Color := clBlue;
              imgMain.canvas.Pen.Style := psDot;
              imgMain.canvas.MoveTo(ImgLeft,ImgTop);
              imgMain.canvas.LineTo(ImgLeft+FrameWidth,ImgTop);
              imgMain.canvas.LineTo(ImgLeft+FrameWidth,ImgTop+FrameHeight);
              imgMain.canvas.LineTo(ImgLeft,ImgTop+FrameHeight);
              imgMain.canvas.LineTo(ImgLeft,ImgTop);

              //Establish Anchor
              AnchorTileX := (ImgLeft)+ (-(MyFrame.OffSetX)) ;
              AnchorTileY := (ImgTop+FrameHeight)+ MyFrame.OffSetY;
              //Draw Length
              if MyFrame.Length > 1 then
              begin
                  TileX := AnchorTileX;
                  TileY := AnchorTileY;
                  for jLoop := 1 to MyFrame.Length do
                  begin
                       imgMain.canvas.Pen.Color := clYellow;
                       imgMain.canvas.Pen.Style := psSolid;
                       imgMain.canvas.MoveTo(TileX,TileY);
                       imgMain.canvas.LineTo(TileX+32,TileY-16);
                       imgMain.canvas.LineTo(TileX+64,TileY);
                       imgMain.canvas.LineTo(TileX+32,TileY+16);
                       imgMain.canvas.LineTo(TileX,TileY);
                       TileX := TileX + 32;
                       TileY := TileY+16;
                  end;
              end;
              //Draw Width
              if MyFrame.Width > 1 then
              begin
                  TileX := AnchorTileX;
                  TileY := AnchorTileY;
                  for jLoop := 1 to MyFrame.Width do
                  begin
                       imgMain.canvas.Pen.Color := clYellow;
                       imgMain.canvas.Pen.Style := psSolid;
                       imgMain.canvas.MoveTo(TileX,TileY);
                       imgMain.canvas.LineTo(TileX+32,TileY-16);
                       imgMain.canvas.LineTo(TileX+64,TileY);
                       imgMain.canvas.LineTo(TileX+32,TileY+16);
                       imgMain.canvas.LineTo(TileX,TileY);
                       TileX := TileX - 32;
                       TileY := TileY + 16;
                  end;
              end;
              //Draw Anchor
              imgMain.canvas.Pen.Color := clRed;
              imgMain.canvas.Pen.Style := psSolid;
              imgMain.canvas.MoveTo(AnchorTileX,AnchorTileY);
              imgMain.canvas.LineTo(AnchorTileX+32,AnchorTileY-16);
              imgMain.canvas.LineTo(AnchorTileX+64,AnchorTileY);
              imgMain.canvas.LineTo(AnchorTileX+32,AnchorTileY+16);
              imgMain.canvas.LineTo(AnchorTileX,AnchorTileY);

         end;
         MyFrame := nil;
         if (CurrentCol = ColCount-1) then
            CurrentCol := 0
         else
            Inc(CurrentCol);
    end;
 //   ScrollBox1.Color:=imgMain.picture.bitmap.canvas.Pixels[1,1];


  end;
  imgMain.Refresh;

   //  NG := TNGImage(imgMain.Picture.Graphic);
   //  NG.SetAlphaColor(Color);
   //  NG.SaveToPNGfile(PBFolderDialog1.Folder +'\'+ exportname +'_' +IntToStr(TrackBar1.position) +'.png' );
   //  imgMain.Picture.Bitmap.SaveToFile(PBFolderDialog1.Folder +'\'+ exportname +'_' + strPadChL(IntToStr(TrackBar1.position),'0',2) +'.bmp' );
   //  NG.Free;
end;


procedure TfrmMain.Exit1Click(Sender: TObject);
begin
close;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
   PageControl1.ActivePage := TabSheet2;
   mColor := 16745215;
   cbBlend.checked := false;
   cbAni.ItemIndex := 0;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
    DFXInit(ExtractFilePath(ParamStr(0)));
    MainIniFile := TMemInifile.Create('');
    FrameList := TList.Create;
    PresetType := stDefault;
    LoadIniFile;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
    MainIniFile.free;
    DFXShutDown;
    FrameList.Clear;
    FrameList.free;
end;

procedure TfrmMain.AutoSize;
var
iLoop: integer;
tmpX: integer;
tmpY: integer;
begin
    tmpX := 0;
    tmpY := 0;

     for iLoop := 0 to FrameList.count -1 do
     begin
         TFrame(FrameList.items[iLoop]).Y := tmpY;
         TFrame(FrameList.items[iLoop]).X := tmpX;
         tmpX := tmpX + TFrame(FrameList.items[iLoop]).bmp.width;
         if tmpX > imgMain.Width then
         begin
            tmpX := 0;
            tmpY := TFrame(FrameList.items[0]).bmp.height;
         end
     end;

end;

procedure TfrmMain.SetSize;
var
iLoop: integer;
tmpWidth: integer;
tmpHeight: integer;
MyFrame: TFrame;
begin

   tmpWidth:=0;
   tmpHeight:=0;


   for iLoop := 0 to FrameList.Count -1 do
   begin
      MyFrame := TFrame(FrameList.items[iLoop]);
      tmpWidth := tmpWidth + MyFrame.Bmp.width;
      if tmpHeight < MyFrame.Bmp.height then
         tmpHeight := MyFrame.Bmp.height;
   end;
  FrameWidth := MyFrame.Bmp.width;
  FrameHeight := MyFrame.Bmp.Height;

  imgMain.Width := NextPow2(tmpWidth);
  imgMain.height:= NextPow2(tmpHeight);
  edtIWidth.text := IntToStr(imgMain.Width);
  edtIHeight.text := IntToStr(imgMain.Height);

  imgMain.Picture.Bitmap.width:=imgMain.width;
  imgMain.Picture.Bitmap.height:=imgMain.height;
end;

procedure TfrmMain.PageControl1Change(Sender: TObject);
begin
      if PageControl1.ActivePage = TabSheet2 then
      begin
          Panel1.enabled := true;
          btnSave.enabled := true;
          btnAdjustSize.Enabled := true;
          Label1.enabled := true;
          Label2.enabled := true;
          Label3.enabled := true;
          Label4.enabled := true;
          Label5.enabled := true;
          Label6.enabled := true;
          Label7.enabled := true;
          Label8.enabled := true;
          edtXoffset.enabled := true;
          edtYoffset.enabled := true;
          edtIWidth.enabled := true;
          edtIHeight.enabled := true;
          edtColCount.enabled := true;
          edtBaseName.enabled := true;
          
      end
      else
      begin
          Panel1.enabled := false;
          btnSave.enabled := false;
          btnAdjustSize.Enabled := false;
          Label1.enabled := false;
          Label2.enabled := false;
          Label3.enabled := false;
          Label4.enabled := false;
          Label5.enabled := false;
          Label6.enabled := false;
          Label7.enabled := false;
          Label8.enabled := false;
          edtXoffset.enabled := false;
          edtYoffset.enabled := false;
          edtIWidth.enabled := false;
          edtIHeight.enabled := false;
          edtColCount.enabled := false;
          edtBaseName.enabled := false;
      end;
end;

procedure TfrmMain.SpeedButton3Click(Sender: TObject);
begin
    //create a directory
    //CreateDir(ExtractFilePath(application.ExeName)+ ChangeFileExt(ExtractFileName(OpenDialog.FileName),''));
//    PBFolderDialog1.   := 'Choose an export folder.'

    //Tracking is one off so with minus 1

    exportname := ChangeFileExt(ExtractFileName(OpenDialog.FileName),'');
    if LastDir <> '' then
    ofOpen.SelectedFolder := LastDir;

    if ofOpen.Execute then
    begin
    end;
end;

procedure TfrmMain.edtXoffsetChange(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
tmpStr: string;
begin
    if not edtXoffset.Focused then exit;
    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         if MyFrame.Selected then
            MyFrame.OffSetX := edtXoffset.Value;
         MyFrame := nil;
    end;

    Draw;

end;

procedure TfrmMain.btnAddImageClick(Sender: TObject);
var
iLoop: integer;
begin
   if OpenPox.Execute then
   begin
        for iLoop := 0 to OpenPox.Files.Count -1 do
        begin
             LoadSetupPoxImage(OpenPox.Files[iLoop])
        end;
        SetSize;
        AutoSize;
        Draw;
   end;
end;

procedure TfrmMain.LoadSetupPoxImage(FileName: string);
begin
      if FileExists(FileName) then
      begin
        if (lowercase(ExtractFileExt(FileName))='.pox') then
           LoadPOX(FileName);
        if (lowercase(ExtractFileExt(FileName))='.bmp') then
           LoadBMP(FileName);
      end;
end;


function TfrmMain.NextPow2(n: integer): integer;
var
x:integer;
begin
   x := 1;
   while (x<n) do
    x:= x shl 1;

   result := x;
end;


procedure TfrmMain.lbFramesClick(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
begin
    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         MyFrame.Selected := false;
         MyFrame := nil;
    end;
    MyFrame := TFrame(FrameList.items[lbFrames.ItemIndex]);
    MyFrame.Selected := true;
    edtXoffset.Value := MyFrame.OffSetX;
    edtYoffset.Value := MyFrame.OffSetY;
    edtFWidth.Text := IntToStr(MyFrame.bmp.width);
    edtFHeight.Text := IntToStr(MyFrame.bmp.Height);
    Draw;
end;

procedure TfrmMain.edtYoffsetChange(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
tmpStr: string;
begin
    if not edtYoffset.Focused then exit;
    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         if MyFrame.Selected then
            MyFrame.OffSetY := edtYoffset.Value;
         MyFrame := nil;
    end;

    Draw;
end;

procedure TfrmMain.mnuPreDefaultClick(Sender: TObject);
var
   MyFrame: TFrame;
   iLoop : integer;
begin

    for iLoop := 0 to FrameList.count -1 do
    begin
          MyFrame := TFrame(FrameList.items[iLoop]);

          MyFrame.OffSetX := 0;
          MyFrame.OffSetY := 0;
          MyFrame := nil;
    end;
    Draw;
    mmScript.Clear;
end;



procedure TfrmMain.BuildSpriteScript(FileName:string);
begin
    mmScript.Clear;
    mmScript.Lines.Add('Sprites\\'+ FileName);
    mmScript.Lines.Add(IntToStr(FrameList.count));
    mmScript.Lines.Add('10');
    mmScript.Lines.Add(IntToStr(FrameWidth));
    mmScript.Lines.Add(IntToStr(FrameHeight));
    mmScript.Lines.Add('1');
    mmScript.Lines.Add(IntToStr(cbAni.itemIndex));
    if cbBlend.checked then
       mmScript.Lines.Add('1')
    else
       mmScript.Lines.Add('2');
end;

procedure TfrmMain.btnDeleteImageClick(Sender: TObject);
var
iTmp: integer;
begin
    if lbFrames.ItemIndex = -1 then exit;
    iTmp := lbFrames.ItemIndex;

    FrameList.Delete(iTmp);
    lbFrames.Items.Delete(iTmp);

    AutoSize;
    Draw;

end;

procedure TfrmMain.btnImageDownClick(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
tmpStr: string;
iTmp: integer;

begin
    iTmp := lbFrames.ItemIndex;
    if iTmp = -1 then exit;
    if iTmp = (FrameList.count -1) then exit;

    FrameList.Move(iTmp,iTmp + 1);
    lbFrames.Items.Move(iTmp,iTmp +1);
    lbFrames.ItemIndex := iTmp+1;

    AutoSize;
    Draw;
end;

procedure TfrmMain.btnImageUpClick(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
tmpStr: string;
iTmp: integer;
begin
    iTmp := lbFrames.ItemIndex;
    if iTmp = -1 then exit;
    if iTmp = 0 then exit;

    FrameList.Move(iTmp,iTmp - 1);
    lbFrames.Items.Move(iTmp,iTmp -1);
    lbFrames.ItemIndex := iTmp-1;

    AutoSize;
    Draw;
  end;

procedure TfrmMain.mnuClearAllClick(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
begin
    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         MyFrame.Free;
         MyFrame := nil;
    end;
    FrameList.Clear;
    lbFrames.items.Clear;
    edtFWidth.Text := '0';
    edtFHeight.Text := '0';
    edtIWidth.Text := '0';
    edtIHeight.Text := '0';
    edtBaseName.Text := '0';
    mmScript.Clear;
    imgMain.Canvas.Brush.Color := mColor;
    imgMain.Canvas.FillRect(Rect(0,0,imgMain.Width,imgMain.Height));

    cbBlend.checked := false;
    cbAni.ItemIndex := 0;
end;

procedure TfrmMain.imgMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    FrameIndx: integer;
    MyFrame: TFrame;
    iLoop : integer;
    NoImage: boolean;
begin

    FrameIndx := -1;
    if lbFrames.Items.count < 1 then exit;
    NoImage := true;
    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         if ((x > MyFrame.X) and (x < (MyFrame.X +MyFrame.bmp.Width))) and
            ((y > MyFrame.Y) and (Y < (MyFrame.Y +MyFrame.bmp.Height))) then
         begin
              lbFrames.ItemIndex := iLoop;
              NoImage := false;
              break;
         end;
    end;
    if not(NoImage) then
    begin
         lbFramesClick(sender);
         MouseOffSet := true;
    end;


end;

procedure TfrmMain.imgMainMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      MouseOffSet := false;
end;

procedure TfrmMain.mnuOpnPoxClick(Sender: TObject);
begin
   if OpenPox.Execute then
   begin
     mnuClearAllClick(sender);
     LoadSetupPoxImage(OpenPox.FileName);
     //establish a base name
     edtBaseName.text := ChangeFileExt(ExtractFileName(OpenPox.FileName),'');
     SetSize; //Must Call this before building
     Draw;
   end;

end;

procedure TfrmMain.SpinEdit1Change(Sender: TObject);
var
iLoop : integer;
MyFrame: TFrame;
begin
    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         MyFrame.DisplayOffx := SpinEdit1.value;
         MyFrame := nil;
    end;
    Draw;

end;

procedure TfrmMain.SpinEdit2Change(Sender: TObject);
var
iLoop : integer;
MyFrame: TFrame;
begin
    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         MyFrame.DisplayOffy := SpinEdit2.value;
         MyFrame := nil;
    end;
    Draw;
end;

procedure TfrmMain.btnSpriteScriptClick(Sender: TObject);
begin
     BuildSpriteScript(edtBaseName.text+'.png');
end;

procedure TfrmMain.btnAdjustSizeClick(Sender: TObject);
var
   tmpH: integer;
   tmpW: integer;
begin

  tmpW := (StrToInt(edtIWidth.text));
  tmpH := (StrToInt(edtIHeight.text));
//  edtIHeight.text := IntToStr(tmpH);
//  edtIWidth.text := IntToStr(tmpW);
  imgMain.Width := tmpW;
  imgMain.height:= tmpH;
  imgMain.Picture.Bitmap.width:=tmpW;
  imgMain.Picture.Bitmap.height:=tmpH;
  Draw;
end;

procedure TfrmMain.imgMainMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  var
   iLoop: integer;
   MyFrame: TFrame;
begin
        if MouseOffSet then
        begin
          for iLoop := 0 to FrameList.count -1 do
          begin
               MyFrame := TFrame(FrameList.items[iLoop]);
               MyFrame.OffSetX := -((X - MyFrame.X)-64);
               MyFrame.OffSetY := Y - (MyFrame.Y + MyFrame.bmp.height);
               edtXoffset.Value := MyFrame.OffSetX;
               edtYoffset.Value := MyFrame.OffSetY;
          end;
          Draw;
        end;
end;

procedure TfrmMain.LoadIniFile;
var
  MyIniFile: TIniFile;
begin

  MyIniFile := TIniFile.create(ChangeFileExt(Application.exename, '.ini'));

  strMapPath := MyIniFile.ReadString('Path', 'Maps', 'c:\temp\');
  strTexturePath := MyIniFile.ReadString('Path', 'Textures', 'c:\temp\');
  strScriptPath := MyIniFile.ReadString('Path', 'Scripts', 'c:\temp\');
  strCharPath := MyIniFile.ReadString('Path', 'Chars', 'c:\temp\');
  strEditorIconPath := MyIniFile.ReadString('Path', 'Editor', 'c:\temp\');
  strEditorTilePath := MyIniFile.ReadString('Path', 'Tiles', 'c:\temp\');
  strSpritePath := MyIniFile.ReadString('Path', 'Sprites', 'c:\temp\');
  strStaticPath := MyIniFile.ReadString('Path', 'Statics', 'c:\temp\');
  strParticlePath:= MyIniFile.ReadString('Path', 'Particles', 'c:\temp\');
  strGameEngine := MyIniFile.ReadString('Path', 'GameEngine', 'c:\temp\Game.exe');
  strEditorScrPath := MyIniFile.ReadString('Path', 'EditorScr', 'c:\temp\');
  strDatabase :=  MyIniFile.ReadString('Path', 'Database', 'c:\temp\database.db3');

  if strLastCh(strMapPath) <> '\' then
  strMapPath := strMapPath + '\';
  if strLastCh(strTexturePath) <> '\' then
  strTexturePath := strTexturePath + '\';
  if strLastCh(strScriptPath) <> '\' then
  strScriptPath := strScriptPath + '\';
  if strLastCh(strCharPath) <> '\' then
  strCharPath := strCharPath + '\';
  if strLastCh(strEditorIconPath) <> '\' then
  strEditorIconPath := strEditorIconPath + '\';
  if strLastCh(strEditorTilePath) <> '\' then
  strEditorTilePath := strEditorTilePath + '\';
  if strLastCh(strSpritePath) <> '\' then
  strSpritePath := strSpritePath + '\';
  if strLastCh(strStaticPath) <> '\' then
  strStaticPath := strStaticPath + '\';
  if strLastCh(strParticlePath) <> '\' then
  strParticlePath := strParticlePath + '\';
  if strLastCh(strEditorScrPath) <> '\' then
  strEditorScrPath := strEditorScrPath + '\';

  MyIniFile.free;
end;


procedure TfrmMain.btnFrameSizeClick(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
tmpStr: string;
begin
    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         //MyFrame.bmp.width := StrToInt(edtFWidth.Text);
         //MyFrame.bmp.Height :=  StrToInt(edtFHeight.Text);
         MyFrame := nil;
    end;
    FrameWidth := StrToInt(edtFWidth.Text);
    FrameHeight := StrToInt(edtFHeight.Text);
    Draw;
end;

end.
