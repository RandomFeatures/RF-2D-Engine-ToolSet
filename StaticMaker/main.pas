unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus,DFX, digifx, Converter, inifiles, ComCtrls, ExtCtrls,
   PBFolderDialog, Grids, Outline, DirOutln, FileCtrl, Numedit,
   Buttons, strFunctions, NGImages, NGConst,  SQLiteTable3,
  Spin,Math;

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
    ScrollBox1: TScrollBox;
    imgMain: TImage;
    Panel1: TPanel;
    ofOpen: TPBFolderDialog;
    btnSave: TSpeedButton;
    OpenDialog: TOpenDialog;
    edtIHeight: TNumEdit;
    edtIWidth: TNumEdit;
    Label2: TLabel;
    Label3: TLabel;
    Presets1: TMenuItem;
    mnuPreWalls: TMenuItem;
    mnuPreDefault: TMenuItem;
    edtBaseName: TEdit;
    Label8: TLabel;
    N2: TMenuItem;
    mnuOpnWllSt: TMenuItem;
    btnAdjustSize: TSpeedButton;
    mnuClearAll: TMenuItem;
    mnuOpnPox: TMenuItem;
    btnSpriteScript: TSpeedButton;
    Script1: TMenuItem;
    StaticScript1: TMenuItem;
    SpriteScript1: TMenuItem;
    Timer1: TTimer;
    btnAutoArrange: TSpeedButton;
    Actions1: TMenuItem;
    AdjustSize1: TMenuItem;
    AutoArrange1: TMenuItem;
    OpenStatic1: TMenuItem;
    cbLock: TCheckBox;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel2: TPanel;
    lbFrames: TListBox;
    Panel3: TPanel;
    btnAddImage: TSpeedButton;
    btnDeleteImage: TSpeedButton;
    btnImageDown: TSpeedButton;
    btnImageUp: TSpeedButton;
    Panel4: TPanel;
    DriveComboBox1: TDriveComboBox;
    FileListBox1: TFileListBox;
    Panel5: TPanel;
    ImgPreview: TImage;
    DirectoryOutline1: TDirectoryOutline;
    OpenFromDB1: TMenuItem;
    GroupBox1: TGroupBox;
    Label15: TLabel;
    edtFrameX: TSpinEdit;
    Label16: TLabel;
    edtFrameY: TSpinEdit;
    Bevel4: TBevel;
    Label6: TLabel;
    edtFWidth: TNumEdit;
    Label7: TLabel;
    edtFHeight: TNumEdit;
    GroupBox2: TGroupBox;
    Bevel1: TBevel;
    Label4: TLabel;
    edtXoffset: TSpinEdit;
    Label5: TLabel;
    edtYoffset: TSpinEdit;
    Label9: TLabel;
    edtTileWidth: TSpinEdit;
    Label10: TLabel;
    edtTilelength: TSpinEdit;
    btnNew: TSpeedButton;
    procedure SaveAs1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure edtXoffsetChange(Sender: TObject);
    procedure btnAddImageClick(Sender: TObject);
    procedure lbFramesClick(Sender: TObject);
    procedure edtYoffsetChange(Sender: TObject);
    procedure mnuPreWallsClick(Sender: TObject);
    procedure mnuPreDefaultClick(Sender: TObject);
    procedure btnDeleteImageClick(Sender: TObject);
    procedure btnImageDownClick(Sender: TObject);
    procedure btnImageUpClick(Sender: TObject);
    procedure mnuOpnWllStClick(Sender: TObject);
    procedure mnuClearAllClick(Sender: TObject);
    procedure imgMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuOpnPoxClick(Sender: TObject);
    procedure edtTilelengthChange(Sender: TObject);
    procedure edtTileWidthChange(Sender: TObject);
    procedure btnSpriteScriptClick(Sender: TObject);
    procedure imgMainMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnAdjustSizeClick(Sender: TObject);
    procedure edtFrameXChange(Sender: TObject);
    procedure edtFrameYChange(Sender: TObject);
    procedure btnAutoArrangeClick(Sender: TObject);
    procedure ShowFrameEditor1Click(Sender: TObject);
    procedure lbFramesDblClick(Sender: TObject);
    procedure imgMainDblClick(Sender: TObject);
    procedure OpenStatic1Click(Sender: TObject);
    procedure FileListBox1Click(Sender: TObject);
    procedure ImgPreviewDblClick(Sender: TObject);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure DirectoryOutline1Change(Sender: TObject);
    procedure OpenFromDB1Click(Sender: TObject);
  private
    { Private declarations }
    Comments: string;
    mColor: TColor;
    LastDir: string;
    MainIniFile: TMemInifile;
    FrameList: TList;
    PresetType: TStaticType;
    MouseOffSet: Boolean;
    DragOn: Boolean;
    dblClick: boolean;
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
    strResource: string;
    m_iStaticID: integer;
    procedure LoadIniFile;
  public
    { Public declarations }
    procedure AutoArrange;
    procedure PreviewPOX(POXFile: string);
    procedure LoadPOX(POXFile: string);
    procedure LoadBMP(BMPFile: string);
    procedure SetSize;
    procedure Draw;
    procedure CaculateTextureSize(TileCount: integer; var W: integer; var H: integer; var r: integer; var c: integer);
    function NextPow2(n: integer): integer;
    procedure BuildStaticScript(Root: string; FileName:string; Question: boolean);
    procedure LoadSetupImage(FileName: string);
    procedure SaveFile(FileName: string);
    procedure LoadDBStatic(iStaticID: integer);
    procedure SaveToDatabase(strFileName: string; iStaticID: integer);

  end;

var
  frmMain: TfrmMain;
  M: array [1..2] of Char;

implementation

uses frameEdit, staticlist;

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
      end;

    finally
      Stream.free;
    end;
  except
  end;
end;

procedure TfrmMain.PreviewPOX(POXFile: string);
var
  Stream: TFileStream;
  L: longint;
  EOB,BB: word;
  INI: TStringINIFile;
  RLE: TRLESprite;
  BitPlane: TBitPlane;
  MyWidth: integer;
  MyHeight: integer;
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
        ImgPreview.Canvas.Brush.Color := mColor;
        ImgPreview.Canvas.FillRect(Rect(0,0,ImgPreview.Width,ImgPreview.Height));


        BitPlane:=TBitPlane.create(MyWidth,MyHeight);
        BitPlane.KeyColor := mColor;
        RLE:=TRLESprite.create;
        RLE.LoadFromStream(Stream);

        BitPlane.Clear;

        RLE.Draw(0,0,0,BitPlane.Bits);
        BitPlane.DrawToDC(ImgPreview.canvas.handle,0,0);

        RLE.Free;
        BitPlane.free;
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
      MyFrame.FileName := ExtractFileName(ChangeFileExt(BMPFile,''));
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
      if lbFrames.Items.IndexOf(MyFrame.FileName) = -1 then
         lbFrames.Items.Add(MyFrame.FileName)
      else
       lbFrames.Items.Add(MyFrame.FileName+IntToStr(lbFrames.Items.count));

end;


procedure TfrmMain.SaveAs1Click(Sender: TObject);
begin
    SaveDialog1.InitialDir := strTexturePath+'statics\';

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

procedure TfrmMain.SaveFile(FileName: string);
var
  MyFrame: TFrame;
  NG : TNGImage;
  iLoop: integer;
begin

    //BuildStaticScript(ChangeFileExt(extractfileName(fileName),''),ExtractFileName(FileName),false);
    //mmScript.Lines.SaveToFile(strStaticPath+ExtractFileName(ChangeFileExt(FileName,'.dat')));
    SaveToDatabase(extractfileName(fileName), m_iStaticID);

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

procedure TfrmMain.SaveToDatabase(strFileName: string; iStaticID: integer);
var
objDB: TSQLiteDatabase;
strSQL: String;
MyFrame: TFrame;
iLoop: integer;
begin

     objDB := TSQLiteDatabase.Create(strDatabase);

     if iStaticID > -1 then
     begin
          //remove the old static objects
          strSQL := 'DELETE FROM tblISO_StaticObjects ' +
                    'WHERE StaticID = ' + IntToStr(iStaticID) + ';';
          objDB.ExecSQL(strSQL);
          //update static files
          strSQL := 'UPDATE tblISO_StaticFiles ' +
                    'SET [RootName] = "'+ edtBaseName.text +'", [FileName] = "'+'Statics\\'+ strFileName +'" '+
                    'WHERE StaticID = ' + IntToStr(iStaticID) + ';';
          objDB.ExecSQL(strSQL);
     end
     else
     begin
         //insert a new static file
         strSQL := 'INSERT INTO tblISO_StaticFiles([RootName],[FileName]) ' +
                    'VALUES("'+ edtBaseName.text +'", "'+'Statics\\'+ strFileName+'");';
         objDB.ExecSQL(strSQL);
         //get the new static ID
         //TODO
         m_iStaticID := objDB.GetLastInsertRowID;
     end;
     //insert all static objects
     for iLoop := 0 to FrameList.count -1 do
     begin
          MyFrame := TFrame(FrameList.items[iLoop]);

          strSQL := 'INSERT INTO tblISO_StaticObjects(' +
                    '[StaticID],[EditorName],[Startx],[Starty],[Width],[Height],[xOffset],[yOffset],[Length],[Depth],[Active]) ' +
                    'VALUES('+ IntToStr(iStaticID) +', "'+ExtractFileName(MyFrame.FileName)+'",'+ IntToStr(MyFrame.X)+','+ IntToStr(MyFrame.Y)+',' +
                               IntToStr(MyFrame.bmp.width)+','+ IntToStr(MyFrame.bmp.height)+','+ IntToStr(MyFrame.OffSetX)+','+ IntToStr(MyFrame.OffSetY)+
                               ','+ IntToStr(MyFrame.Length)+','+ IntToStr(MyFrame.Width)+',"true");';
          objDB.ExecSQL(strSQL);
          MyFrame := nil;
     end;
     
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
     close;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
   PageControl1.ActivePage := TabSheet2;
   mColor := 16745215;
   PageControl2.ActivePage := TabSheet3;
   edtIWidth.text := '512';
   edtIHeight.text := '512';
   btnAdjustSizeClick(sender);
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

procedure TfrmMain.AutoArrange;
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
          Label2.enabled := true;
          Label3.enabled := true;
          Label4.enabled := true;
          Label5.enabled := true;
          Label6.enabled := true;
          Label7.enabled := true;
          Label8.enabled := true;
          edtXoffset.enabled := true;
          edtYoffset.enabled := true;
          edtTileLength.enabled := true;
          edtTileWidth.enabled := true;
          edtIWidth.enabled := true;
          edtIHeight.enabled := true;
          edtBaseName.enabled := true;
          
      end
      else
      begin
          Panel1.enabled := false;
          btnSave.enabled := false;
          btnAdjustSize.Enabled := false;
          Label2.enabled := false;
          Label3.enabled := false;
          Label4.enabled := false;
          Label5.enabled := false;
          Label6.enabled := false;
          Label7.enabled := false;
          Label8.enabled := false;
          edtXoffset.enabled := false;
          edtYoffset.enabled := false;
          edtTileLength.enabled := false;
          edtTileWidth.enabled := false;
          edtIWidth.enabled := false;
          edtIHeight.enabled := false;
          edtBaseName.enabled := false;
      end;
end;

procedure TfrmMain.CaculateTextureSize(TileCount: integer; var W: integer; var H: integer; var r: integer; var c: integer);
begin
{
1024x1024 = 512      1024x512 = 256
512x512 = 128        512x256 = 64
256x256 = 32         256x128 = 16
256x64 = 8           128x64 = 4
128x32 = 2           64x32 = 1
}
        case TileCount of
        1:
          begin
                w:=64; h:=32;
                c:=1; r:=1;
          end;
        2:
          begin
                w:=128; h:=32;
                c:=2; r:=1;
          end;
        3,4:
          begin
                w:=128; h:=64;
                c:=2; r:=2;
          end;
        5..8:
          begin
                w:=256; h:=64;
                c:=4; r:=2;
          end;
        9..16:
          begin
                w:=256; h:=128;
                c:=4; r:=4;
          end;
        17..32:
          begin
                w:=256; h:=256;
                c:=4; r:=8;
          end;
        33..64:
          begin
                w:=512; h:=256;
                c:=8; r:=8;
          end;
        65..128:
          begin
                w:=512; h:=512;
                c:=8; r:=16;
          end;
        129..256:
          begin
                w:=1024; h:=512;
                c:=16; r:=16;
          end;
        257..512:
          begin
                w:=1024; h:=1024;
                c:=16; r:=32;
          end;
        end;
end;


procedure TfrmMain.edtXoffsetChange(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
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


   if OpenPox.Files.Count = 0 then
      OpenPox.InitialDir := strResource;

   if OpenPox.Execute then
   begin
       for iLoop := 0 to OpenPox.Files.Count -1 do
       begin
           if edtBaseName.text = '' then
             edtBaseName.text := lowercase(ChangeFileExt(ExtractFileName(OpenPox.Files[iLoop]),''));
           LoadSetupImage(OpenPox.Files[iLoop])
       end;
       if not(cbLock.checked) then
       begin
          SetSize;
          AutoArrange;
       end;
       Draw;
   end;
end;

procedure TfrmMain.LoadSetupImage(FileName: string);
begin
      if FileExists(FileName) then
      begin
          if (lowercase(ExtractFileExt(FileName))='.pox') then
             LoadPOX(FileName);
          if (lowercase(ExtractFileExt(FileName))='.bmp') then
             LoadBMP(FileName);
      end;
      Application.ProcessMessages;
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
    DragOn:= False;
    MyFrame := TFrame(FrameList.items[lbFrames.ItemIndex]);
    MyFrame.Selected := true;
    edtXoffset.Value := MyFrame.OffSetX;
    edtYoffset.Value := MyFrame.OffSetY;
    edtTileLength.value := MyFrame.length;
    edtTileWidth.value := MyFrame.Width;
    edtFWidth.Text := IntToStr(MyFrame.bmp.width);
    edtFHeight.Text := IntToStr(MyFrame.bmp.Height);
    edtFrameX.Value := MyFrame.X;
    edtFrameY.Value := MyFrame.Y;
    Draw;
end;

procedure TfrmMain.edtYoffsetChange(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
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

procedure TfrmMain.mnuPreWallsClick(Sender: TObject);
var
   MyFrame: TFrame;
   iLoop : integer;
begin

    for iLoop := 0 to FrameList.count -1 do
    begin
          MyFrame := TFrame(FrameList.items[iLoop]);

//          if Pos('90',MyFrame.FileName) > 0 then
//          begin
//               MyFrame.Length := 1;
//               MyFrame.Width := 1;
//               MyFrame.OffSetX := 15;
//               MyFrame.OffSetY := -17;
//          end
//          else
          if Pos('SW',MyFrame.FileName) > 0 then
          begin
               MyFrame.Length := 2;
               MyFrame.Width := 1;
               MyFrame.OffSetX := 0;
               MyFrame.OffSetY := -32;
          end
          else
          if Pos('SE',MyFrame.FileName) > 0 then
          begin
               MyFrame.Length := 1;
               MyFrame.Width := 2;
               MyFrame.OffSetX := -18;
               MyFrame.OffSetY := -33;
          end;
          MyFrame := nil;
    end;
    BuildStaticScript('Walls',edtBaseName.text+'.png',false);
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


procedure TfrmMain.BuildStaticScript(Root: string; FileName:string; Question: boolean);
var
   MyFrame: TFrame;
   iLoop : integer;
begin

    if Question then
    begin
     if Application.MessageBox(
        'Would you like to rebuild the script before continuing?',
        'Script Rebuild',
        MB_YESNO + MB_DEFBUTTON1) <> IDYES then
         exit;
     end;

    mmScript.Clear;
    mmScript.Lines.Add(Root);
    mmScript.Lines.Add('Statics\\'+ FileName);
    mmScript.Lines.Add(IntToStr(FrameList.count));
    for iLoop := 0 to FrameList.count -1 do
    begin
          MyFrame := TFrame(FrameList.items[iLoop]);
          mmScript.Lines.Add(ExtractFileName(MyFrame.FileName) + ' '+
                             IntToStr(MyFrame.X)+' '+IntToStr(MyFrame.Y)+' '+
                             IntToStr(MyFrame.bmp.width)+' '+IntToStr(MyFrame.bmp.height)+' '+
                             IntToStr(MyFrame.OffSetX)+' '+IntToStr(MyFrame.OffSetY)+' '+
                             IntToStr(MyFrame.Length)+' '+IntToStr(MyFrame.Width));
          MyFrame := nil;
    end;

end;


procedure TfrmMain.btnDeleteImageClick(Sender: TObject);
var
iTmp: integer;
begin
    if lbFrames.ItemIndex = -1 then exit;
    iTmp := lbFrames.ItemIndex;
    FrameList.Delete(iTmp);
    lbFrames.Items.Delete(iTmp);
    Draw;
end;

procedure TfrmMain.btnImageDownClick(Sender: TObject);
var
iTmp: integer;

begin
    iTmp := lbFrames.ItemIndex;
    if iTmp = -1 then exit;
    if iTmp = (FrameList.count -1) then exit;

    FrameList.Move(iTmp,iTmp + 1);
    lbFrames.Items.Move(iTmp,iTmp +1);
    lbFrames.ItemIndex := iTmp+1;

    AutoArrange;
    Draw;
end;

procedure TfrmMain.btnImageUpClick(Sender: TObject);
var
iTmp: integer;
begin
    iTmp := lbFrames.ItemIndex;
    if iTmp = -1 then exit;
    if iTmp = 0 then exit;

    FrameList.Move(iTmp,iTmp - 1);
    lbFrames.Items.Move(iTmp,iTmp -1);
    lbFrames.ItemIndex := iTmp-1;

    AutoArrange;
    Draw;
  end;

procedure TfrmMain.mnuOpnWllStClick(Sender: TObject);
begin
  ofOpen.Folder := LastDir;
  if ofOpen.Execute then
  begin
       LastDir := ofOpen.Folder;
       mnuClearAllClick(sender);
       //load specific walls
       LoadSetupImage(ofOpen.Folder + '\MedSE.pox');
       LoadSetupImage(ofOpen.Folder + '\MedSW.pox');
       LoadSetupImage(ofOpen.Folder + '\MedSWDoorwayA.pox');
       LoadSetupImage(ofOpen.Folder + '\MedSWDoorwayB.pox');
       LoadSetupImage(ofOpen.Folder + '\MedSEDoorwayA.pox');
       LoadSetupImage(ofOpen.Folder + '\MedSEDoorwayB.pox');
//       LoadSetupImage(ofOpen.Folder + '\90CrnrSS.pox');
       if lbFrames.Items.Count > 0 then
       begin
         //establish a base name
         edtBaseName.text := ChangeFileExt(extractfileName(ofOpen.Folder+'.txt'),'');
         //set all sizes
         SetSize;
         //set wall defaults
         mnuPreWallsClick(sender);
         Draw;
       end;
  end;
end;

procedure TfrmMain.mnuClearAllClick(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
begin
    m_iStaticID := -1;
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
    edtBaseName.Text := '';
    mmScript.Clear;
    imgMain.Canvas.Brush.Color := mColor;
    imgMain.Canvas.FillRect(Rect(0,0,imgMain.Width,imgMain.Height));
    cbLock.checked := false;

end;

procedure TfrmMain.imgMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    FrameIndx: integer;
    MyFrame: TFrame;
    iLoop : integer;
    NoImage: boolean;
begin
   if not(dblClick) then
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
           if not (ssShift in Shift) then
           begin
              if not(cbLock.checked) then
                 DragOn:= true
           end
           else
               MouseOffSet := true;
      end;
   end
   else dblClick := false;

end;

procedure TfrmMain.imgMainMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      if DragOn then
      begin
           DragOn := False;
           Draw;
      end;
      MouseOffSet := false;
end;

procedure TfrmMain.mnuOpnPoxClick(Sender: TObject);
begin
   if OpenPox.Execute then
   begin
     mnuClearAllClick(sender);
     LoadSetupImage(OpenPox.FileName);
     //establish a base name
     edtBaseName.text := ChangeFileExt(ExtractFileName(OpenPox.FileName),'');
     if not(cbLock.checked) then
     begin
        SetSize; //Must Call this before building
        AutoArrange;
     end;
     Draw;
   end;

end;

procedure TfrmMain.edtTilelengthChange(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
begin
    if not edtTilelength.Focused then exit;
    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         if MyFrame.Selected then
            MyFrame.Length := edtTilelength.Value;
         MyFrame := nil;
    end;

    Draw;

end;

procedure TfrmMain.edtTileWidthChange(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
begin
    if not edtTileWidth.Focused then exit;
    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         if MyFrame.Selected then
            MyFrame.Width := edtTileWidth.Value;
         MyFrame := nil;
    end;

    Draw;

end;

procedure TfrmMain.btnSpriteScriptClick(Sender: TObject);
begin
     BuildStaticScript('Root',edtBaseName.text,false);
end;

procedure TfrmMain.Draw;
var
iLoop: integer;
jLoop : integer;
MyFrame: TFrame;
ImgLeft: integer;
ImgTop: integer;
AnchorTileX: integer;
AnchorTileY: integer;
TileX: integer;
TileY: integer;
begin
  imgMain.Canvas.Brush.Color := mColor;
  imgMain.Canvas.FillRect(Rect(0,0,imgMain.Width,imgMain.Height));

  if FrameList.Count > 0 then
  begin

    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         imgMain.Canvas.Draw(MyFrame.X,MyFrame.Y,MyFrame.Bmp);
         MyFrame := nil;
    end;

    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);

         if MyFrame.Selected then
         begin
              ImgLeft:= MyFrame.x;
              ImgTop:= MyFrame.Y;
              //Border box
              imgMain.canvas.Pen.Color := clBlue;
              imgMain.canvas.Pen.Style := psDot;
              imgMain.canvas.MoveTo(ImgLeft,ImgTop);
              imgMain.canvas.LineTo(ImgLeft+MyFrame.bmp.width,ImgTop);
              imgMain.canvas.LineTo(ImgLeft+MyFrame.bmp.Width,ImgTop+MyFrame.bmp.Height);
              imgMain.canvas.LineTo(ImgLeft,ImgTop+MyFrame.bmp.Height);
              imgMain.canvas.LineTo(ImgLeft,ImgTop);

              //Establish Anchor
              AnchorTileX := (ImgLeft)+(-(MyFrame.OffSetX)) ;
              AnchorTileY := (ImgTop+MyFrame.bmp.Height)+ MyFrame.OffSetY;
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
         if DragOn then
         begin
              ImgLeft:= MyFrame.x;
              ImgTop:= MyFrame.Y;
              //Border box
              imgMain.canvas.Pen.Color := clYellow;
              imgMain.canvas.Pen.Style := psDot;
              imgMain.canvas.MoveTo(ImgLeft,ImgTop);
              imgMain.canvas.LineTo(ImgLeft+MyFrame.bmp.width,ImgTop);
              imgMain.canvas.LineTo(ImgLeft+MyFrame.bmp.Width,ImgTop+MyFrame.bmp.Height);
              imgMain.canvas.LineTo(ImgLeft,ImgTop+MyFrame.bmp.Height);
              imgMain.canvas.LineTo(ImgLeft,ImgTop);
         end;


         MyFrame := nil;
    end;

  end;
  imgMain.Refresh;
end;

procedure TfrmMain.imgMainMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  var
   iLoop: integer;
   MyFrame: TFrame;
begin
        if DragOn or MouseOffSet then
        begin
          for iLoop := 0 to FrameList.count -1 do
          begin
               MyFrame := TFrame(FrameList.items[iLoop]);
               if MyFrame.selected then
               begin
                  if DragOn then
                  begin
                      MyFrame.X := X - (MyFrame.bmp.width div 2);
                      MyFrame.Y := Y - (MyFrame.bmp.Height div 2);
                      edtFrameX.Value := MyFrame.X;
                      edtFrameY.Value := MyFrame.Y;
                  end
                  else if MouseOffSet then
                  begin
                      MyFrame.OffSetX := -((X - MyFrame.X)-64);
                      MyFrame.OffSetY := Y - (MyFrame.Y + MyFrame.bmp.height);
                      edtXoffset.Value := MyFrame.OffSetX;
                      edtYoffset.Value := MyFrame.OffSetY;
                  end;
                  Draw;
               end;
          end;
        end;
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

procedure TfrmMain.edtFrameXChange(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
begin
    if not edtFrameX.Focused then exit;
    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         if MyFrame.Selected then
            MyFrame.X := edtFrameX.Value;
         MyFrame := nil;
    end;

    Draw;


end;

procedure TfrmMain.edtFrameYChange(Sender: TObject);
var
MyFrame: TFrame;
iLoop : integer;
begin
    if not edtFrameY.Focused then exit;
    for iLoop := 0 to FrameList.count -1 do
    begin
         MyFrame := TFrame(FrameList.items[iLoop]);
         if MyFrame.Selected then
            MyFrame.Y := edtFrameY.Value;
         MyFrame := nil;
    end;

    Draw;

end;

procedure TfrmMain.btnAutoArrangeClick(Sender: TObject);
begin

     if Application.MessageBox(
        'Are you sure you want to auto arrange all images?',
        'Auto Arrange',
        MB_YESNO + MB_DEFBUTTON1) <> IDYES then
         exit;
     AutoArrange;
     Draw;
end;

procedure TfrmMain.ShowFrameEditor1Click(Sender: TObject);
begin
frmFrameEdit.show;
end;

procedure TfrmMain.lbFramesDblClick(Sender: TObject);
var
MyFrame: TFrame;
begin
    if lbFrames.ItemIndex > -1 then
    begin
        MyFrame := TFrame(FrameList.items[lbFrames.ItemIndex]);
        frmFrameEdit.MasterBMP.Width := MyFrame.bmp.width;
        frmFrameEdit.MasterBMP.Height := MyFrame.bmp.height;
        frmFrameEdit.setup;
        frmFrameEdit.MasterBMP.Canvas.Draw(0,0,MyFrame.bmp);
        frmFrameEdit.showmodal;
        frmFrameEdit.DrawClear;
        MyFrame.bmp.width := frmFrameEdit.imgMain.Width;
        MyFrame.bmp.height := frmFrameEdit.imgMain.Height;
        MyFrame.bmp.Canvas.Brush.Color := mColor;
        MyFrame.bmp.Canvas.FillRect(Rect(0,0,MyFrame.bmp.Width,MyFrame.bmp.Height));
        MyFrame.bmp.canvas.draw(0,0,frmFrameEdit.imgMain.Picture.Bitmap);
        edtFWidth.text := IntToStr(MyFrame.bmp.width);
        edtFHeight.text := IntToStr(MyFrame.bmp.height);
        Draw;
    end;
    DragOn := False;
    MouseOffSet := false;

end;

procedure TfrmMain.imgMainDblClick(Sender: TObject);
begin
     lbFramesDblClick(sender);
     dblClick := true;
end;


procedure TfrmMain.LoadIniFile;
var
  MyIniFile: TIniFile;
  strPath: string;
begin
  m_iStaticID := -1;
  MyIniFile := TIniFile.create(ChangeFileExt(Application.exename, '.ini'));

  if LowerCase(ParamStr(1)) = 'win32' then
   strPath := 'Path_Win32'
  else
   strPath := 'Path_Linux';



  strMapPath := MyIniFile.ReadString(strPath, 'Maps', 'c:\temp\');
  strTexturePath := MyIniFile.ReadString(strPath, 'Textures', 'c:\temp\');
  strScriptPath := MyIniFile.ReadString(strPath, 'Scripts', 'c:\temp\');
  strCharPath := MyIniFile.ReadString(strPath, 'Chars', 'c:\temp\');
  strEditorIconPath := MyIniFile.ReadString(strPath, 'Editor', 'c:\temp\');
  strEditorTilePath := MyIniFile.ReadString(strPath, 'Tiles', 'c:\temp\');
  strSpritePath := MyIniFile.ReadString(strPath, 'Sprites', 'c:\temp\');
  strStaticPath := MyIniFile.ReadString(strPath, 'Statics', 'c:\temp\');
  strParticlePath:= MyIniFile.ReadString(strPath, 'Particles', 'c:\temp\');
  strGameEngine := MyIniFile.ReadString(strPath, 'GameEngine', 'c:\temp\Game.exe');
  strEditorScrPath := MyIniFile.ReadString(strPath, 'EditorScr', 'c:\temp\');
  strDatabase := MyIniFile.ReadString(strPath, 'Database', 'c:\temp\database.db3');
  strResource := MyIniFile.ReadString(strPath, 'Resources', 'c:\temp\');

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



procedure TfrmMain.OpenStatic1Click(Sender: TObject);
var
strFileName: string;
FrameHeight: integer;
FrameWidth: integer;
FrameCount: integer;
iXoffSet: integer;
iYoffSet: integer;
iImageTileLength: integer;
iImageTileWidth: integer;
StaticFile: TextFile;
NG : TNGImage;
SourceRect, DestRect: TRect;
strTmp: string;
strRoot: string;
iLoop: integer;
strFrameName: string;
x,y: integer;
MyFrame: TFrame;
begin
   OpenDialog.InitialDir :=  strStaticPath;
   if OpenDialog.execute then
   begin
   AssignFile(StaticFile, OpenDialog.FileName);
   edtBaseName.text := ExtractFileName(ChangeFileExt(OpenDialog.FileName,''));
   ReSet(StaticFile);
   Readln(StaticFile,strRoot); //Root
   Readln(StaticFile,strFileName);
   strFileName := Trim(strFileName);
   Readln(StaticFile,strTmp); //Count
   FrameCount := StrToInt(strTmp);

   //Load the PNG and Get the first frame
   NG := TNGImage.Create;
   NG.SetAlphaColor(mColor);
   NG.Transparent := true;
   NG.TransparentColor := mColor;
   NG.LoadFromFile(strTexturePath + strFileName);
   edtIWidth.text := IntToStr(NG.CopyBitmap.Width);
   edtIHeight.text := IntToStr(NG.CopyBitmap.height);
   btnAdjustSizeClick(sender);
   for iLoop := 0 to FrameCount-1 do
   begin //EditorName x y width height xOffset YOffset Length Width
      Readln(StaticFile,strTmp);
      strFrameName := StrTokenAt(strTmp,' ',0);
      x :=StrToInt(StrTokenAt(strTmp,' ',1));
      y := StrToInt(StrTokenAt(strTmp,' ',2));
      FrameWidth := StrToInt(StrTokenAt(strTmp,' ',3));
      FrameHeight := StrToInt(StrTokenAt(strTmp,' ',4));
      iXoffSet := StrToInt(StrTokenAt(strTmp,' ',5));
      iYoffSet := StrToInt(StrTokenAt(strTmp,' ',6));
      iImageTileLength :=StrToInt(StrTokenAt(strTmp,' ',7));
      iImageTileWidth :=StrToInt(StrTokenAt(strTmp,' ',8));
      SourceRect := Rect(x,y,x+FrameWidth,y+FrameHeight);
      DestRect := Rect(0,0,FrameWidth,FrameHeight);

      MyFrame := TFrame.Create;
      MyFrame.FileName := strFrameName;
      MyFrame.X := x;
      MyFrame.Y := y;
      MyFrame.DisplayOrder := 0;
      MyFrame.DisplayOffX := 0;
      MyFrame.DisplayOffY := 0;
      MyFrame.OffSetX := iXoffSet;
      MyFrame.OffSetY := iYoffSet;
      MyFrame.Length := iImageTileLength;
      MyFrame.Width := iImageTileWidth;
      MyFrame.Selected := false;
      MyFrame.dir := dNone;
      MyFrame.bmp := TBitmap.Create;
      MyFrame.bmp.Width := FrameWidth;
      MyFrame.bmp.Height := FrameHeight;
      MyFrame.bmp.TransparentColor := mcolor;
      MyFrame.bmp.TransparentMode := tmFixed;
      MyFrame.bmp.Transparent := true;
      MyFrame.bmp.Canvas.FillRect(Rect(0,0,FrameWidth,FrameHeight));
      MyFrame.bmp.Canvas.CopyRect(DestRect,NG.CopyBitmap.Canvas,SourceRect);

      FrameList.Add(MyFrame);
      if lbFrames.Items.IndexOf(MyFrame.FileName) = -1 then
         lbFrames.Items.Add(MyFrame.FileName)
      else
       lbFrames.Items.Add(MyFrame.FileName+IntToStr(lbFrames.Items.count));
   end;
    CloseFile(StaticFile);
    NG.Free;
    BuildStaticScript(strRoot,edtBaseName.text,false);
    Draw;
    cbLock.Checked := true;
   end;
end;

procedure TfrmMain.LoadDBStatic(iStaticID: integer);
var
objDB: TSQLiteDatabase;
objDS: TSQLIteTable;
strSQL: String;
strFileName: string;
FrameHeight: integer;
FrameWidth: integer;
iXoffSet: integer;
iYoffSet: integer;
iImageTileLength: integer;
iImageTileWidth: integer;
NG : TNGImage;
SourceRect, DestRect: TRect;
strFrameName: string;
strRoot: string;
x,y: integer;
MyFrame: TFrame;
begin

      try
         objDB := TSQLiteDatabase.Create(strDatabase);

         //Static File
         strSQL := 'SELECT [RootName], [FileName] ' +
                   'FROM [tblISO_StaticFiles] NOLOCK ' +
                   'WHERE [StaticID]=' + IntToStr(iStaticID) +';';
         objDS := objDB.GetTable(strSQL);

          try

            if objDS.Count > 0 then
            begin
                 //get first row
                 strRoot := objDS.FieldAsString(objDS.FieldIndex['RootName']);
                 strFileName := Trim(objDS.FieldAsString(objDS.FieldIndex['FileName']));
                 strFileName := strTokenAt(strFileName, '\',2);
                // strSearchReplace(strFileName, '\\', '\', [srAll]);
                 //Load the PNG and Get the first frame
                 NG := TNGImage.Create;
                 NG.SetAlphaColor(mColor);
                 NG.Transparent := true;
                 NG.TransparentColor := mColor;
                 NG.LoadFromFile(strTexturePath + 'statics\'+ strFileName);
                 edtIWidth.text := IntToStr(NG.CopyBitmap.Width);
                 edtIHeight.text := IntToStr(NG.CopyBitmap.height);
                 edtBaseName.text := strRoot;
                 btnAdjustSizeClick(nil);
            end;

          finally
                 //free the table object
                 objDS.Free;
          end;

          //Static Objects
          strSQL := 'SELECT [ObjectID],[EditorName],[Startx],[Starty],[Width],[Height],[xOffset],[yOffset],[Length],[Depth] ' +
                    'FROM [tblISO_StaticObjects] NOLOCK ' +
                    'WHERE [StaticID]=' + IntToStr(iStaticID) +';';
          objDS := objDB.GetTable(strSQL);

          try

            if objDS.Count > 0 then
            begin
                 while not objDS.EOF do
                 begin
                      try
                        strFrameName := objDS.FieldAsString(objDS.FieldIndex['EditorName']);
                        x := objDS.FieldAsInteger(objDS.FieldIndex['Startx']);
                        y := objDS.FieldAsInteger(objDS.FieldIndex['Starty']);
                        FrameWidth := objDS.FieldAsInteger(objDS.FieldIndex['Width']);
                        FrameHeight := objDS.FieldAsInteger(objDS.FieldIndex['Height']);
                        iXoffSet := objDS.FieldAsInteger(objDS.FieldIndex['xOffset']);
                        iYoffSet := objDS.FieldAsInteger(objDS.FieldIndex['yOffset']);
                        iImageTileLength :=objDS.FieldAsInteger(objDS.FieldIndex['Length']);
                        iImageTileWidth :=objDS.FieldAsInteger(objDS.FieldIndex['Depth']);
                        SourceRect := Rect(x,y,x+FrameWidth,y+FrameHeight);
                        DestRect := Rect(0,0,FrameWidth,FrameHeight);

                        MyFrame := TFrame.Create;
                        MyFrame.FileName := strFrameName;
                        MyFrame.X := x;
                        MyFrame.Y := y;
                        MyFrame.DisplayOrder := 0;
                        MyFrame.DisplayOffX := 0;
                        MyFrame.DisplayOffY := 0;
                        MyFrame.OffSetX := iXoffSet;
                        MyFrame.OffSetY := iYoffSet;
                        MyFrame.Length := iImageTileLength;
                        MyFrame.Width := iImageTileWidth;
                        MyFrame.Selected := false;
                        MyFrame.dir := dNone;
                        MyFrame.bmp := TBitmap.Create;
                        MyFrame.bmp.Width := FrameWidth;
                        MyFrame.bmp.Height := FrameHeight;
                        MyFrame.bmp.TransparentColor := mcolor;
                        MyFrame.bmp.TransparentMode := tmFixed;
                        MyFrame.bmp.Transparent := true;
                        MyFrame.bmp.Canvas.FillRect(Rect(0,0,FrameWidth,FrameHeight));
                        MyFrame.bmp.Canvas.CopyRect(DestRect,NG.CopyBitmap.Canvas,SourceRect);

                        FrameList.Add(MyFrame);
                        if lbFrames.Items.IndexOf(MyFrame.FileName) = -1 then
                           lbFrames.Items.Add(MyFrame.FileName)
                        else
                         lbFrames.Items.Add(MyFrame.FileName+IntToStr(lbFrames.Items.count));
                      finally
                             objDS.Next;
                      end;
                 end;
            end;

          finally
                 //free the table object
                 objDS.Free;
          end;
      finally
             //free the db object
             NG.Free;
             objDB.Free;
      end;
      //BuildStaticScript(strRoot,edtBaseName.text,false);
      Draw;
      cbLock.Checked := true;
end;

procedure TfrmMain.FileListBox1Click(Sender: TObject);
begin
     if  FileExists(FileListBox1.FileName) then
         PreviewPox(FileListBox1.FileName);
end;

procedure TfrmMain.ImgPreviewDblClick(Sender: TObject);
begin
     if  FileExists(FileListBox1.FileName) then
     begin
          LoadPox(FileListBox1.FileName);
          lbFrames.itemindex := lbFrames.Items.count -1;
          lbFramesClick(sender);
     end;
end;

procedure TfrmMain.DriveComboBox1Change(Sender: TObject);
begin
  DirectoryOutline1.Drive := DriveComboBox1.Drive; 
end;

procedure TfrmMain.DirectoryOutline1Change(Sender: TObject);
begin
      FileListBox1.Drive :=   DirectoryOutline1.Drive;
      FileListBox1.Directory :=  DirectoryOutline1.Directory;
end;

procedure TfrmMain.OpenFromDB1Click(Sender: TObject);
begin
        frmStaticList.setup(strDatabase);
        frmStaticList.showmodal;
        if frmStaticList.iStaticID > -1 then
        begin
             m_iStaticID := frmStaticList.iStaticID;
             LoadDBStatic(m_iStaticID);
        end;
end;

end.
