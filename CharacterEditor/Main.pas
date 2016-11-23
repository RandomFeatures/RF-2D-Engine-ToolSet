unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Numedit,charObj, Buttons, strFunctions, Menus, PBFolderDialog, inifiles,
  ExtCtrls,NGImages,SQLiteTable3;

type
  TfrmMain = class(TForm)
    lbMain: TListBox;
    cbHitRating: TComboBox;
    cbDefRating: TComboBox;
    cbAttRating: TComboBox;
    edtGUID: TEdit;
    edtName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtMagResist: TNumEdit;
    edtPhyResist: TNumEdit;
    edtHits: TNumEdit;
    editMin: TNumEdit;
    edtMax: TNumEdit;
    cbMove: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    btnNew: TButton;
    btnUpdate: TButton;
    btnDelete: TButton;
    cbClass: TComboBox;
    Label12: TLabel;
    cbMoveRating: TComboBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    btnCharDat: TSpeedButton;
    MainMenu1: TMainMenu;
    Label16: TLabel;
    PBFolderDialog1: TPBFolderDialog;
    SaveDialog1: TSaveDialog;
    File1: TMenuItem;
    Exit1: TMenuItem;
    btnEdit: TButton;
    OpenDialog1: TOpenDialog;
    cbSpells: TComboBox;
    Panel1: TPanel;
    imgPreview: TImage;
    edtISO_CharacterID: TNumEdit;
    Label17: TLabel;
    cbGroup: TComboBox;
    edtDB_ID: TEdit;
    Label18: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lbMainClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCharDatClick(Sender: TObject);

  private
    { Private declarations }
    procedure ClearScreen();
    procedure LockAll();
    procedure UnLockAll();
    procedure PreviewCharacter(strCharacterID: string);
    procedure LoadListFromDB();
    procedure LoadIniFile;
  public
    { Public declarations }
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
    strEngineINIPath: string;
    CharList: TList;
    iCount: integer;
    strListFilePath: string;
    bNew: boolean;
    MainIniFile: TMemInifile;
  end;

var
  frmMain: TfrmMain;

implementation

uses CharacterFiles;

{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
var
   MyIniFile: TIniFile;
   EnginINI: TIniFile;
   SpellList: TStringList;
   iLoop: integer;
   iCount: integer;
   s: string;
begin
     CharList := TList.Create();

     LoadIniFile();
     //LoadList();
     LoadListFromDB();
     SpellList := TStringList.Create();
     EnginINI := TIniFile.create(strEngineINIPath);
     EnginINI.ReadSectionValues('spells',SpellList);
     for iLoop := 0 to SpellList.Count -1 do
     begin
          s := SpellList.Values[SpellList.Names[iLoop]];
          s := strRight(s,Length(s) -7);
          s := strLeft(s,Length(s) -4);
          SpellList.Values[SpellList.Names[iLoop]] := s;
          cbSpells.items.Add(s+'='+SpellList.Names[iLoop]);
//          cbSpells.Items.Values[s] := SpellList.Names[iLoop];
     end;
     SpellList.Clear;
     SpellList.Free;
end;




procedure TfrmMain.ClearScreen();
begin
    cbHitRating.ItemIndex := 2;
    cbDefRating.ItemIndex := 2;
    cbAttRating.ItemIndex := 2;
    cbMoveRating.ItemIndex := 2;
    cbMove.ItemIndex := 0;
    cbClass.ItemIndex := 0;
    edtMagResist.Text :=  '0.0';
    edtPhyResist.Text :=  '0.0';
    edtHits.Text :=  '100';
    editMin.Text :=  '1';
    edtMax.Text :=  '5';
    cbSpells.itemIndex := 0;
    edtGUID.Text :=  'auto';
    edtName.text := '';
    edtISO_CharacterID.text := '0';
    edtDB_ID.text := '0';
    cbGroup.ItemIndex := 0;
    ImgPreview.Picture := nil;
    ImgPreview.Refresh;
end;

procedure TfrmMain.LockAll();
begin
    cbHitRating.enabled := false;
    cbDefRating.enabled := false;
    cbAttRating.enabled := false;
    cbMoveRating.enabled := false;
    cbMove.enabled := false;
    cbClass.enabled := false;
    edtMagResist.enabled := false;
    edtPhyResist.enabled := false;
    edtHits.enabled := false;
    editMin.enabled := false;
    edtMax.enabled := false;
    cbSpells.enabled := false;
    edtName.enabled := false;
    edtISO_CharacterID.enabled := false;
    btnCharDat.enabled := false;
    btnUPdate.Enabled :=false;
    btnNew.Enabled := true;
    btnEdit.Enabled := true;
    cbGroup.Enabled := false;
end;

procedure TfrmMain.UnLockAll();
begin
    cbHitRating.enabled := true;
    cbDefRating.enabled := true;
    cbAttRating.enabled := true;
    cbMoveRating.enabled := true;
    cbMove.enabled := true;
    cbClass.enabled := true;
    edtMagResist.enabled := true;
    edtPhyResist.enabled := true;
    edtHits.enabled := true;
    editMin.enabled := true;
    edtMax.enabled := true;
    cbSpells.enabled := true;
    edtName.enabled := true;
    edtISO_CharacterID.enabled := true;
    btnCharDat.enabled := true;
    btnUPdate.Enabled :=true;
    btnNew.Enabled := false;
    btnEdit.Enabled := false;
    cbGroup.Enabled := true;

end;

procedure TfrmMain.lbMainClick(Sender: TObject);
var
   MyChar: TCharacterObject;
   iLoop: integer;
begin
     MyChar :=  TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]);
     cbHitRating.ItemIndex := MyChar.HitRating;
     cbDefRating.ItemIndex := MyChar.DefRating;
     cbAttRating.ItemIndex := MyChar.AttRating;
     cbMoveRating.ItemIndex := MyChar.MoveRating;
     cbMove.ItemIndex := cbMove.Items.IndexOf(IntToStr(MyChar.Movement));
     edtMagResist.Text := MyChar.MagResist;
     edtPhyResist.Text := MyChar.PhyResist;
     edtHits.Text := IntToStr(MyChar.HitPoints);
     editMin.Text := IntToStr(MyChar.MinDamage);
     edtMax.Text :=  IntToStr(MyChar.MaxDamage);
     edtISO_CharacterID.text := IntToStr(MyChar.ISO_CharacterID);
     edtDB_ID.text := IntToStr(MyChar.DBID);
     for iLoop := 0 to cbSpells.Items.count - 1 do
     begin
          if cbSpells.Items.Values[cbSpells.Items.Names[iLoop]] = IntToStr(MyChar.SpellID)then
            cbSpells.ItemIndex := iLoop
          else
              continue;
     end;
     edtGUID.Text := MyChar.GUID_Txt;
     edtName.text := MyChar.DisplayName;
     edtISO_CharacterID.text := IntToStr(MyChar.ISO_CharacterID);
     cbClass.ItemIndex := MyChar.CharClass;
     cbGroup.ItemIndex := MyChar.Group;
     bNew := false;
     LockAll();
     PreviewCharacter(edtISO_CharacterID.text);
end;

procedure TfrmMain.btnNewClick(Sender: TObject);
begin
    ClearScreen();
    UnLockAll();
    edtName.SetFocus();
    bNew := true;
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
     close;
end;

procedure TfrmMain.btnUpdateClick(Sender: TObject);
var
   MyChar: TCharacterObject;
   myFile: TextFile;
   objDB: TSQLiteDatabase;
   objDS: TSQLiteTable;
   strSQL: String;
begin
     objDB := TSQLiteDatabase.Create(strDatabase);

     if bNew then
     begin
         MyChar := TCharacterObject.Create;
         MyChar.HitRating := cbHitRating.ItemIndex;
         MyChar.DefRating := cbDefRating.ItemIndex;
         MyChar.AttRating := cbAttRating.ItemIndex;
         MyChar.MoveRating := cbMoveRating.ItemIndex;

         MyChar.Movement := StrToInt(cbMove.items[0]);

         MyChar.MagResist := edtMagResist.Text;
         MyChar.PhyResist :=  edtPhyResist.Text;

         MyChar.HitPoints := StrToInt(edtHits.Text);
         MyChar.MinDamage := StrToInt(editMin.Text);
         MyChar.MaxDamage := StrToInt(edtMax.Text);
         MyChar.SpellID := StrToInt(strTokenAt(cbSpells.text,'=',1));

         //MyChar.GUID_Txt := edtGUID.Text;
         MyChar.DisplayName := edtName.text;
         MyChar.ISO_CharacterID := StrToInt(edtISO_CharacterID.text);
         MyChar.CharClass := cbClass.ItemIndex;
         MyChar.Group := cbGroup.ItemIndex;
         MyChar.GenerateGUID;
         strSQL := 'INSERT INTO tblPA_Characters([GUID],[CharacterName],[Class],[DefenseRating],[HealthRating],[AttackRating],[MoveRating],' +
                                                '[SpellID],[ISO_CharacterID],[PhyResist],[MagResist],[Hitpoints],[MinDamage],[MaxDamage],[Movement],[Type],[Group],[Active])' +
                   'VALUES("'+ MyChar.GUID_Txt +'", "'+ MyChar.DisplayName +'", '+ IntToStr(MyChar.CharClass) + ', '+ IntToStr(MyChar.DefRating) +
                                   ', '+ IntToStr(MyChar.HitRating) +', '+ IntToStr(MyChar.AttRating) +  ', ' + IntToStr(MyChar.MoveRating) +
                                   ', '+ IntToStr(MyChar.SpellID) +', '+ IntToStr(MyChar.ISO_CharacterID) +', "'+ MyChar.PhyResist + '", "'+ MyChar.MagResist + '"'+
                                   ', '+ IntToStr(MyChar.HitPoints) +', '+ IntToStr(MyChar.MinDamage) +', '+ IntToStr(MyChar.MaxDamage) +', '+ IntToStr(MyChar.Movement) +
                                   ',0,'+ IntToStr(MyChar.Group) + ', "true");';
         objDB.ExecSQL(strSQL);
         MyChar.DBID := objDB.GetLastInsertRowID;

         lbMain.Items.AddObject(MyChar.DisplayName, MyChar);
         MyChar := Nil;
         bNew := false;
     end
     else
     begin
         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).HitRating := cbHitRating.ItemIndex;
         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).DefRating := cbDefRating.ItemIndex;
         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).AttRating := cbAttRating.ItemIndex;
         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).MoveRating := cbMoveRating.ItemIndex;

         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).Movement := StrToInt(cbMove.items[0]);

         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).MagResist := edtMagResist.Text;
         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).PhyResist :=  edtPhyResist.Text;

         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).HitPoints := StrToInt(edtHits.Text);
         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).MinDamage := StrToInt(editMin.Text);
         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).MaxDamage := StrToInt(edtMax.Text);
         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).SpellID := StrToInt(strTokenAt(cbSpells.text,'=',1));

         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).GUID_Txt := edtGUID.Text;
         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).DisplayName := edtName.text;
         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).ISO_CharacterID := StrToInt(edtISO_CharacterID.text);
         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).CharClass := cbClass.ItemIndex ;
         TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]).Group := cbGroup.ItemIndex;

         //update existing character
         strSQL := 'UPDATE tblPA_Characters ' +
            'SET [GUID] ="' + edtGUID.Text + '"' +
            ',[CharacterName] ="' + edtName.text + '"' +
            ',[Class] ='+ IntToStr(cbClass.ItemIndex) +
            ',[DefenseRating] =' + IntToStr(cbDefRating.ItemIndex) +
            ',[HealthRating]  =' + IntToStr(cbHitRating.ItemIndex) +
            ',[AttackRating] =' + IntToStr(cbAttRating.ItemIndex) +
            ',[MoveRating] =' + IntToStr(cbMoveRating.ItemIndex) +
            ',[SpellID] ='  + strTokenAt(cbSpells.text,'=',1) +
            ',[ISO_CharacterID] =' + edtISO_CharacterID.text +
            ',[PhyResist] ="' + edtPhyResist.Text + '"' +
            ',[MagResist] ="' + edtMagResist.Text + '"' +
            ',[Hitpoints] =' + edtHits.Text +
            ',[MinDamage] =' + editMin.Text +
            ',[MaxDamage] =' + edtMax.Text +
            ',[Movement] =' + cbMove.items[0] +
            ',[Type] = 0'+
            ',[Group] ='+  IntToStr(cbGroup.ItemIndex) +
            ',[Active] = "true"'+
            ' WHERE [ID] = ' + edtDB_ID.Text + ';';
        objDB.ExecSQL(strSQL);

     end;
     LockAll();
end;

procedure TfrmMain.PreviewCharacter(strCharacterID: string);
var
MyBitMap: TBitMap;
objDB: TSQLiteDatabase;
objDS: TSQLIteTable;
strSQL: String;
strTextureFileName: string;
FrameHeight: integer;
FrameWidth: integer;
NG : TNGImage;
SourceRect, DestRect: TRect;
PortraitFrame: integer;
begin

     ImgPreview.Picture := nil;
     ImgPreview.Refresh;

     objDB := TSQLiteDatabase.Create(strDatabase);


     strSQL := 'SELECT c.[CharacterID], f.[FileName], c.[PortraitFrame], f.[FrameCount], f.[Width], f.[Height] ' +
               'FROM [tblISO_Character] c ' +
               'JOIN  [tblISO_CharacterFiles] f ' +
               'ON c.[CharacterID] = f.[CharacterID] ' +
               'WHERE c.[CharacterID]=' + strCharacterID + ' AND ' +
               'f.[ActionType] = 0;';
     objDS := objDB.GetTable(strSQL);
     if objDS.Count > 0 then
     begin
          try
             FrameWidth := objDS.FieldAsInteger(objDS.FieldIndex['Width']);
             FrameHeight := objDS.FieldAsInteger(objDS.FieldIndex['Height']);
             PortraitFrame := objDS.FieldAsInteger(objDS.FieldIndex['PortraitFrame']);
             strTextureFileName :=  objDS.FieldAsString(objDS.FieldIndex['FileName']);
             strTextureFileName := StringReplace(strTextureFileName,'\\','\',[rfReplaceAll]);
             //Creat Editor Sprite Image
             MyBitMap := TBitmap.Create;
             MyBitMap.Canvas.Brush.Color := 16745215;
             MyBitMap.Width := FrameWidth;
             MyBitMap.Height := FrameHeight;

             DestRect := Rect(0,0,FrameWidth,FrameHeight);
             SourceRect := Rect(0,FrameHeight*3,FrameWidth,FrameHeight*4);
            //Load the PNG and Get the first frame
             NG := TNGImage.Create;

             NG.Transparent := true;
             NG.TransparentColor := 16745215;
             NG.SetAlphaColor(16745215);
             NG.LoadFromFile(strTexturePath + strTextureFileName);
             //Copy out the first frame for the editor
             MyBitMap.Canvas.FillRect(Rect(0,0,FrameWidth,FrameHeight));
             MyBitMap.Canvas.CopyRect(DestRect,NG.CopyBitmap.Canvas,SourceRect);
             NG.Free;
             ImgPreview.Picture := nil;
             ImgPreview.Canvas.Brush.Color := clbtnface;
             ImgPreview.Canvas.FillRect(Rect(0,0,ImgPreview.width,ImgPreview.height));
             ImgPreview.Picture.Assign(MyBitMap);
             
          finally
          end;
     end;
     objDS.free;
     objDB.free;

end;


procedure TfrmMain.btnDeleteClick(Sender: TObject);
 var
   MyChar: TCharacterObject;
   objDB: TSQLiteDatabase;
   strSQL: String;
begin
     //TODO Delete from DB
     MyChar :=  TCharacterObject(lbMain.Items.Objects[lbMain.ItemIndex]);
     if MessageDlg('Are you sure you want to delete ' + MyChar.DisplayName + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     begin
          lbMain.Items.Delete(lbMain.ItemIndex);
          try
             objDB := TSQLiteDatabase.Create(strDatabase);
              strSQL := 'DELETE FROM tblPA_Characters ' +
                        ' WHERE [ID] = ' + edtDB_ID.Text + ';';
             objDB.ExecSQL(strSQL);
          finally
           //free the db object
             objDB.Free;
          end;
     end
end;

procedure TfrmMain.btnEditClick(Sender: TObject);
begin
     UnLockAll();
     edtName.SetFocus();
     bNew := false;
end;

procedure TfrmMain.btnCharDatClick(Sender: TObject);
begin
     frmCharacterFiles.setup(strDatabase,strTexturePath);
     frmCharacterFiles.showmodal;
     if frmCharacterFiles.strCharacterID <> '' then
     begin
          edtISO_CharacterID.text := frmCharacterFiles.strCharacterID;
          PreviewCharacter(edtISO_CharacterID.text);
     end;
     
end;

procedure TfrmMain.LoadListFromDB;
var
   objDB: TSQLiteDatabase;
   objDS: TSQLIteTable;
   strSQL: String;
   strFileName: string;
   MyChar: TCharacterObject;
begin

      try
         objDB := TSQLiteDatabase.Create(strDatabase);

         //Static Objects
         strSQL := 'SELECT [ID],[GUID],[CharacterName],[Class],[DefenseRating],[HealthRating],[AttackRating],[MoveRating],[SpellID],[ISO_CharacterID], ' +
                   '[PhyResist],[MagResist],[Hitpoints],[MinDamage],[MaxDamage],[Movement],[Type],[Group],[Active]' +
                   'FROM [tblPA_Characters] NOLOCK; ';

         objDS := objDB.GetTable(strSQL);

          try

            if objDS.Count > 0 then
            begin
                 while not objDS.EOF do
                 begin
                      try
                          MyChar := TCharacterObject.Create;
                          MyChar.DBID :=  objDS.FieldAsInteger(objDS.FieldIndex['ID']);
                          MyChar.GUID_Txt :=  objDS.FieldAsString(objDS.FieldIndex['GUID']);
                          MyChar.DisplayName  := objDS.FieldAsString(objDS.FieldIndex['CharacterName']);
                          MyChar.CharClass :=  objDS.FieldAsInteger(objDS.FieldIndex['Class']);
                          MyChar.Group :=  objDS.FieldAsInteger(objDS.FieldIndex['Group']);
                          MyChar.DefRating := objDS.FieldAsInteger(objDS.FieldIndex['DefenseRating']);
                          MyChar.HitRating := objDS.FieldAsInteger(objDS.FieldIndex['HealthRating']);
                          MyChar.AttRating := objDS.FieldAsInteger(objDS.FieldIndex['AttackRating']);
                          MyChar.MoveRating := objDS.FieldAsInteger(objDS.FieldIndex['MoveRating']);
                          MyChar.SpellID :=  objDS.FieldAsInteger(objDS.FieldIndex['SpellID']);
                          MyChar.ISO_CharacterID :=  objDS.FieldAsInteger(objDS.FieldIndex['ISO_CharacterID']);
                          MyChar.PhyResist := objDS.FieldAsString(objDS.FieldIndex['PhyResist']);
                          MyChar.MagResist := objDS.FieldAsString(objDS.FieldIndex['MagResist']);
                          MyChar.HitPoints := objDS.FieldAsInteger(objDS.FieldIndex['Hitpoints']);
                          MyChar.MinDamage := objDS.FieldAsInteger(objDS.FieldIndex['MinDamage']);
                          MyChar.MaxDamage := objDS.FieldAsInteger(objDS.FieldIndex['MaxDamage']);
                          MyChar.Movement := objDS.FieldAsInteger(objDS.FieldIndex['Movement']);
                          lbMain.Items.AddObject(MyChar.DisplayName, MyChar);
                          MyChar := Nil;
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
             objDB.Free;
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
  strDatabase := MyIniFile.ReadString('Path', 'Database', 'c:\temp\database.db3');
  strListFilePath := MyIniFile.ReadString('path','MasterList','');
  strEngineINIPath := MyIniFile.ReadString('path','EngineINI','');
  
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
end.
