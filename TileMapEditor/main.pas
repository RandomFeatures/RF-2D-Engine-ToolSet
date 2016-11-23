unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, ImageManager, VRSprite, strFunctions, ComCtrls, DirScanner, SQLiteTable3,
  ExtDlgs, TreeNT, isoMath, NGImages, NGConst, IniFiles, Settings, TileData, GameObjects,
  Buttons;



 type
     TMapProps = record
        MapName: string;
        MapDesc: string;
        ScriptFile: string;
        MapType: integer;
        UseShadows: Boolean;
        LightLevel: integer;
        LightColor: integer;
        CloudBlend: integer;
        WindDirect: integer;
        SnowFlakes: integer;
        FogType: integer;
        FogColor: integer;
        FogBlend: integer;
        FogText: integer;
        WalkSfx: integer;
        ArmySize: integer;
     end;


  TfrmMain = class(TForm)
    ColorDialog: TColorDialog;
    Panel1: TPanel;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    OpenPictureDialog: TOpenPictureDialog;
    Panel2: TPanel;
    Splitter2: TSplitter;
    imgPreview: TImage;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    mnuNewMap: TMenuItem;
    mnuOpen: TMenuItem;
    mnuSave: TMenuItem;
    mnuClearAll: TMenuItem;
    N1: TMenuItem;
    mnuExit: TMenuItem;
    Color1: TMenuItem;
    mnuBackgroundColor: TMenuItem;
    mnuGridColor: TMenuItem;
    mStatusBar: TStatusBar;
    Panel3: TPanel;
    ScrollBarX: TScrollBar;
    ScrollBarY: TScrollBar;
    iMap: TImage;
    Panel4: TPanel;
    cbBase: TCheckBox;
    cbDiamond: TCheckBox;
    cbCollision: TCheckBox;
    mnuClearBase: TMenuItem;
    mnuClearDiamond: TMenuItem;
    mnuClearCollision: TMenuItem;
    Clear1: TMenuItem;
    FloodFill1: TMenuItem;
    mnuFillBase: TMenuItem;
    mnuFillDiamond: TMenuItem;
    mnuFillCollision: TMenuItem;
    Settings1: TMenuItem;
    N2: TMenuItem;
    PageControl1: TPageControl;
    tsTiles: TTabSheet;
    tvTileList: TTreeNT;
    cbStatic: TCheckBox;
    cbSprite: TCheckBox;
    tsStatics: TTabSheet;
    tsSprites: TTabSheet;
    tvSpriteList: TTreeNT;
    popupMenu: TPopupMenu;
    mnuEditProperties: TMenuItem;
    mnuDeleteNPC: TMenuItem;
    Facing1: TMenuItem;
    mnuNPCFaceNW: TMenuItem;
    mnuNPCFaceNE: TMenuItem;
    mnuNPCFaceSE: TMenuItem;
    mnuNPCFaceSW: TMenuItem;
    Script1: TMenuItem;
    EditScript1: TMenuItem;
    mnuSelect: TMenuItem;
    N3: TMenuItem;
    mnuTiles: TMenuItem;
    mnuMergQuad: TMenuItem;
    mnuHideShow: TMenuItem;
    N4: TMenuItem;
    Popup1: TMenuItem;
    EditSprite1: TMenuItem;
    N5: TMenuItem;
    SelectGroup1: TMenuItem;
    EditFacing1: TMenuItem;
    HideShow1: TMenuItem;
    N6: TMenuItem;
    DeleteSprite1: TMenuItem;
    tvStaticList: TTreeNT;
    Panel5: TPanel;
    rgGrid: TRadioGroup;
    mnuShowAll: TMenuItem;
    LockAddMode1: TMenuItem;
    ShowAll1: TMenuItem;
    popTile: TPopupMenu;
    mnuNCorner: TMenuItem;
    mnuECorner: TMenuItem;
    mnuSCorner: TMenuItem;
    mnuWCorner: TMenuItem;
    Select1: TMenuItem;
    SelectAllHiddenObjects1: TMenuItem;
    DisableSelected1: TMenuItem;
    DisableUnselected1: TMenuItem;
    EnableAll1: TMenuItem;
    BeginGroup1: TMenuItem;
    EndGroup1: TMenuItem;
    N7: TMenuItem;
    BeginGroup2: TMenuItem;
    EndGroup2: TMenuItem;
    mnuMapProp: TMenuItem;
    Test1: TMenuItem;
    SetLayer1: TMenuItem;
    Layer01: TMenuItem;
    Layer11: TMenuItem;
    Layer21: TMenuItem;
    Layer31: TMenuItem;
    cbLight: TCheckBox;
    cbStart: TCheckBox;
    rbStart: TRadioGroup;
    SetSide1: TMenuItem;
    Host1: TMenuItem;
    Challenger1: TMenuItem;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    btnSFX: TSpeedButton;
    SFXPorperties1: TMenuItem;
    ObjectProperties1: TMenuItem;
    procedure mnuExitClick(Sender: TObject);
    procedure mnuBackgroundColorClick(Sender: TObject);
    procedure mnuGridColorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure iMapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure iMapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure tvTileListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuClearAllClick(Sender: TObject);
    procedure mnuSaveClick(Sender: TObject);
    procedure mnuOpenClick(Sender: TObject);
    procedure mnuNewMapClick(Sender: TObject);
    procedure ScrollBarYScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure ScrollBarXScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure iMapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbBaseClick(Sender: TObject);
    procedure rgGridClick(Sender: TObject);
    procedure mnuClearBaseClick(Sender: TObject);
    procedure mnuClearDiamondClick(Sender: TObject);
    procedure mnuClearCollisionClick(Sender: TObject);
    procedure mnuFillBaseClick(Sender: TObject);
    procedure mnuFillDiamondClick(Sender: TObject);
    procedure mnuFillCollisionClick(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure tvSpriteListClick(Sender: TObject);
    procedure mnuDeleteNPCClick(Sender: TObject);
    procedure mnuNPCFaceNWClick(Sender: TObject);
    procedure mnuNPCFaceNEClick(Sender: TObject);
    procedure mnuNPCFaceSEClick(Sender: TObject);
    procedure mnuNPCFaceSWClick(Sender: TObject);
    procedure EditScript1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuSelectClick(Sender: TObject);
    procedure mnuMergQuadClick(Sender: TObject);
    procedure mnuHideShowClick(Sender: TObject);
    procedure EditFacing1Click(Sender: TObject);
    procedure tvStaticListClick(Sender: TObject);
    procedure mnuShowAllClick(Sender: TObject);
    procedure LockAddMode1Click(Sender: TObject);
    procedure mnuNCornerClick(Sender: TObject);
    procedure mnuECornerClick(Sender: TObject);
    procedure mnuSCornerClick(Sender: TObject);
    procedure mnuWCornerClick(Sender: TObject);
    procedure mnuEditPropertiesClick(Sender: TObject);
    procedure EndGroup1Click(Sender: TObject);
    procedure BeginGroup1Click(Sender: TObject);
    procedure mnuMapPropClick(Sender: TObject);
    procedure Test1Click(Sender: TObject);
    procedure Layer01Click(Sender: TObject);
    procedure Layer11Click(Sender: TObject);
    procedure Layer21Click(Sender: TObject);
    procedure Layer31Click(Sender: TObject);
    procedure Host1Click(Sender: TObject);
    procedure Challenger1Click(Sender: TObject);
    procedure SFXPorperties1Click(Sender: TObject);
    procedure ObjectProperties1Click(Sender: TObject);

  private
    { Private declarations }
       bgColor,gColor: TColor;
       tmColor: TColor;
       BmpBuffer: TBitmap;
       BackBuffer: TBitmap;
       TileImage: TBitmap;
       MouseImage: TBitmap;
       bmpSideOne: TBitmap;
       bmpSideTwo: TBitmap;
       bmpCollison: TBitmap;
       bmpOccupied: TBitmap;
       bmpPlaceHolder: TBitmap;
       bmpPopOff: TBitmap;
       bmpTrigger: TBitmap;
       bmpBlankNPC: TBitmap;
       bmpSelected: TBitmap;
       bmpParticles: TBitmap;
       bmpLight: TBitmap;
       MainImgMngr: TImageManager;
       imDiamondTiles: TImageManager;
       imBaseTiles: TImageManager;
       ImageFileName: string;
       MouseX: integer;
       MouseY: integer;
       MapWidth: integer;
       MapHeight: integer;
       TileWidth: integer;
       TileHeight: integer;
       TileHalfWidth: integer;
       TileHalfHeight: integer;
       Tile2xWidth: integer;
       Tile2xHeight: integer;
       StartTileX: integer;
       StartDiamondY: integer;
       StartBaseY: integer;
       PlaceGroup: integer;
       BaseLayer: array of array of Integer;
       DiamondLayer: array of array of Integer;
       CollisionLayer: array of array of Integer;
       StartLayer: array of array of Integer;
       TileCount: integer;
       SelectedTileAnchorX: integer;
       SelectedTileAnchorY: integer;
       SelectedTileCenterX: integer;
       SelectedTileCenterY: integer;
       SelectedTileX: integer;
       SelectedTileY: integer;
       WorldTileX: integer;
       WorldTileY: integer;
       DiamondTileList: TList;
       BaseTileList: TList;
       SelectedList: TList;
       ActiveQuad: TQuadTile;
       UsedQuadList: TList; //Collection of Active Quads
       QuadCollection: TQuadCollection;
       MousePaint: boolean;
       EditMode: TEditMode;
       SpriteMode: TSpriteMode;
       StaticMode: TStaticMode;
       EditorMode: TEditorMode;
       DiamondType: TDiamondType;
       SelectTileName: string;
       RandomTileList: TStringList;
       FacingsList: TStringList;
       SpriteRoot: TTreeNTNode;
       CharacterRoot: TTreeNTNode;
       EditorRoot: TTreeNTNode;
       ParticleRoot: TTreeNTNode;
       iXoffSet: integer;
       iYoffSet: integer;
       iImageTileLength: integer;
       iImageTileWidth: integer;
       bLockAddMode: boolean;
       CopyObject: TGameObject;
       MapPropeties: TMapProps;
       MapLoading: boolean;
       Drawing: boolean;
       GameScreenX: integer;
       GameScreenY: integer;
       iEncounterID: integer;
    procedure ReBuildScriptEvents;
    procedure ReBuildAutoExecScript;
    procedure ShowMapPropertiesWindow();
    function GetImageAt(List: TList; x, y: integer): TGameObject;
  public
    { Public declarations }
      //INI File Settings
       ObjectList: TList;
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
       
       procedure SaveToFile;
       procedure SaveToDatabase;
       procedure LoadFromFile;
       procedure LoadFromDatabase;
       procedure DrawOctagon(var bmp: TBitmap);
       procedure DrawSquare(var bmp: TBitmap);
       procedure DrawDiamond(Var bmp: TBitmap);
       procedure DrawRectangle(var bmp: TBitmap);
       procedure DrawGameScreen(Var bmp: TBitmap);
       procedure RefreshScreen;
       procedure LoadTileTreeData(fileName: string);
       procedure LoadBMPPreview(ImageName: string);
       procedure RenderDiamondTiles;
       procedure RenderCollisionTiles;
       procedure RenderStartTiles;
       procedure RenderLightEdit;

       procedure RenderBaseTiles;
       procedure RenderGameObjects;
       procedure RenderQuadTiles;
       procedure PaintDiamondTile(id: integer; x: integer; y: integer);
       procedure PaintBaseTile(id: integer; x: integer; y: integer);
       procedure PaintCollisionTile(x: integer; y: integer);
       procedure PaintStartTile(x: integer; y: integer; side: integer);
       procedure PaintOccupiedTile(x: integer; y: integer);
       procedure PaintSelectedTile(x: integer; y: integer);
       procedure AddQuadDiamondTileToMap;
       procedure AddSingleDiamondTileToMap;
       procedure AddBaseTileToMap;
       procedure AddCollisionTileToMap;
       procedure AddStartTileToMap;
       procedure CreateMap(w: integer; h: integer);
       procedure AddTileZero;
       procedure LoadTileByName(tileName: string);
       procedure GetSelectedDiamondTile(X: integer; Y: integer);
       procedure GetSelectedBaseTile(X: integer; Y: integer);
       procedure GetSelectedQuadTile(X: integer; Y: integer);
       procedure RemoveDiamondTileFromMap;
       procedure RemoveBaseTileFromMap;
       procedure RemoveCollisionTileFromMap;
       procedure RemoveStartTileFromMap;
       procedure CaculateTextureSize(TileCount: integer; var W: integer; var H: integer; var r: integer; var c: integer);
       function WriteOutTileTexture(ImageManager:TImageManager; FileName: string; BaseName: string): string;
       procedure LoadTileSheet(Layer: integer; TileList: TList; ImageManager: TImageManager; FileName: string; count: integer);
       procedure LoadIniFile;
       procedure MouseOverTiles(x: integer; y: integer);
       procedure MouseOverSprites(x: integer; y: integer);
       //procedure LoadCharacterTreeData(Filename: string);
       procedure LoadEditorTreeData;
       //procedure LoadSpriteTreeData(Filename: string);
       procedure LoadSpriteFiles;
       function LoadStatic(strStaticID: string; ItemName: string): TBitmap;
       function LoadSprite(strSpriteID: string): TBitmap;
       function LoadCharacter(strCharacterID: string): TBitmap;

       procedure LoadEditorImages;
       procedure AddCharacterToMap;
       procedure AddSpriteToMap;
       procedure AddStartPointToMap;
       procedure AddLightToMap;
       procedure AddStaticToMap;
       procedure AddParticleToMap;
       procedure SortSpriteList(var List: TList);
       function GetObjectAt(List: TList; x: integer; y: integer): TGameObject;
       function GetObjectIndxAt(List: TList; x: integer; y: integer): integer;
       //function ParseSpriteFile(FileName: string): TBitmap;
       //function ParseCharacterFile(FileName: string): TBitmap;
       //function ParseStaticFile(FileName: string; Frame: integer): TBitmap;
       //function ParseStatic(FileName, ItemName: string): TBitmap;
       procedure BuildScript(mapName: string);
       Procedure RenderGroupLine(List: TList);
       function TestForSelected(MyObject: TGameObject): boolean;
       procedure SetupPopUp(MyObject: TGameObject);
       procedure MergeSingleTiles(fileName: string; x: integer; y: integer);
       procedure MergeQuadTiles;
       procedure WriteResourceBlock(var Output: TextFile);
       procedure WriteLevelBlock(var Output: TextFile);
       procedure WriteObjectBlock(var Output: TextFile);
       procedure UpdateStatusBar;
       procedure LoadResourceBlock(var Input: TextFile);
       procedure LoadObjectBlock(var Input: TextFile);
       procedure LoadLevelBlock(var Input: TextFile);
       //procedure LoadStaticTreeData(Filename: string);
       procedure LoadStaticFiles;
       procedure EditSpriteProperties;
       procedure EditStaticProperties;
       procedure EditLightProperties;

       procedure LoadParticleTreeData(Filename: string);
  end;

var
  frmMain: TfrmMain;

implementation

uses NPCProp, scriptMain, StaticProp, newMap, mapprop, mapList, mapsfx;

{$R *.DFM}

procedure TfrmMain.mnuExitClick(Sender: TObject);
begin
     close;
end;

procedure TfrmMain.mnuBackgroundColorClick(Sender: TObject);
begin
//Changed the background color
if ColorDialog.execute then
   bgColor := ColorDialog.Color;
   RefreshScreen;
end;

procedure TfrmMain.RenderDiamondTiles;
var
xLoop: integer;
yLoop: integer;
TileIndex: integer;
crntTileX: integer;
crntTileY: integer;
crntTileAnchorX: integer;
crntTileAnchorY: integer;
begin

   for yLoop := StartDiamondY-1 to (StartDiamondY + 38) do
   begin
        for xLoop := StartTileX -1 to (StartTileX + 14) do
        begin
           if (yLoop < MapHeight) and (xLoop < MapWidth) then
           begin
               TileIndex := DiamondLayer[yLoop,xLoop];

               crntTileX := xLoop - StartTileX;
               crntTileY := yLoop - StartDiamondY;

               if odd(yLoop)then
                 crntTileAnchorX :=  (crntTileX * TileWidth) + TileHalfWidth
               else
                 crntTileAnchorX :=  (crntTileX * TileWidth );

               crntTileAnchorY :=  (crntTileY * TileHalfHeight);

              // if (crntTileAnchorX < -65) or (crntTileAnchorX > 900) then continue;
              // if (crntTileAnchorY < -33) or (crntTileAnchorY > 700) then continue;

               if TileIndex > 0 then
               PaintDiamondTile(TileIndex, crntTileAnchorX, crntTileAnchorY);
           end;
        end;
   end;
end;


procedure TfrmMain.RenderCollisionTiles;
var
xLoop: integer;
yLoop: integer;
TileIndex: integer;
crntTileX: integer;
crntTileY: integer;
crntTileAnchorX: integer;
crntTileAnchorY: integer;
begin

   for yLoop := StartDiamondY-1 to (StartDiamondY + 38) do
   begin
        for xLoop := StartTileX-1 to (StartTileX + 14) do
        begin
           if (yLoop < MapHeight) and (xLoop < MapWidth) then
           begin
               TileIndex := CollisionLayer[yLoop,xLoop];

               crntTileX := xLoop - StartTileX;
               crntTileY := yLoop - StartDiamondY;

               if odd(yLoop)then
                 crntTileAnchorX :=  (crntTileX * TileWidth) + TileHalfWidth
               else
                 crntTileAnchorX :=  (crntTileX * TileWidth );

               crntTileAnchorY :=  (crntTileY * TileHalfHeight);


               //if (crntTileAnchorX < -32) or (crntTileAnchorX > BmpBuffer.Width) then continue;
               //if (crntTileAnchorY < -16) or (crntTileAnchorY > BmpBuffer.Height) then continue;

               if TileIndex > 0 then
                  PaintCollisionTile(crntTileAnchorX, crntTileAnchorY);
           end;
        end;
   end;
end;

procedure TfrmMain.RenderStartTiles;
var
xLoop: integer;
yLoop: integer;
TileIndex: integer;
crntTileX: integer;
crntTileY: integer;
crntTileAnchorX: integer;
crntTileAnchorY: integer;
begin

   for yLoop := StartDiamondY to (StartDiamondY + 36) do
   begin
        for xLoop := StartTileX to (StartTileX + 12) do
        begin
           try
           if (xLoop > MapWidth-1) or (yLoop > MapHeight-1) then continue;
           TileIndex := StartLayer[yLoop,xLoop];

           crntTileX := xLoop - StartTileX;
           crntTileY := yLoop - StartDiamondY;

           if odd(yLoop)then
             crntTileAnchorX :=  (crntTileX * TileWidth) + TileHalfWidth
           else
             crntTileAnchorX :=  (crntTileX * TileWidth );

           crntTileAnchorY :=  (crntTileY * TileHalfHeight);


           if (crntTileAnchorX < -32) or (crntTileAnchorX > BmpBuffer.Width) then continue;
           if (crntTileAnchorY < -16) or (crntTileAnchorY > BmpBuffer.Height) then continue;

           if TileIndex > 0 then
              PaintStartTile(crntTileAnchorX, crntTileAnchorY, TileIndex);
           except
           end;
        end;
   end;
end;

procedure TfrmMain.RenderBaseTiles;
var
xLoop: integer;
yLoop: integer;
TileIndex: integer;
crntTileX: integer;
crntTileY: integer;
crntTileAnchorX: integer;
crntTileAnchorY: integer;
begin

   for yLoop := StartBaseY to (StartBaseY + 19) do
   begin
        for xLoop := StartTileX-1 to (StartTileX + 12) do
        begin
           if (yLoop < MapHeight) and (xLoop < MapWidth) then
           begin
               TileIndex := BaseLayer[yLoop,xLoop];

               crntTileX := xLoop - StartTileX;
               crntTileY := yLoop - StartBaseY;

               crntTileAnchorX :=  (crntTileX * TileWidth);
               crntTileAnchorY :=  (crntTileY * TileHeight) ;


               if (crntTileAnchorX < -64) or (crntTileAnchorX > BmpBuffer.Width) then continue;
               if (crntTileAnchorY < -16) or (crntTileAnchorY > BmpBuffer.Height) then continue;

               if TileIndex > 0 then
               PaintBaseTile(TileIndex, crntTileAnchorX, crntTileAnchorY);
           end;
        end;
   end;

end;

procedure TfrmMain.RenderQuadTiles;
var
iLoop: integer;
id: integer;
crntTileX: integer;
crntTileY: integer;
crntTileAnchorX: integer;
crntTileAnchorY: integer;
bContinue: boolean;
begin
    for iLoop := 0 to QuadCollection.QuadList.Count -1 do
    begin
      //North
      bContinue := false;
      if assigned(TQuadTile(QuadCollection.QuadList.Items[iLoop]).North.Tile) then
      begin
          id := TQuadTile(QuadCollection.QuadList.Items[iLoop]).North.Tile.ID;
          crntTileX := TQuadTile(QuadCollection.QuadList.Items[iLoop]).North.x-StartTileX;
          crntTileY := TQuadTile(QuadCollection.QuadList.Items[iLoop]).North.y-StartDiamondY;

          if odd(crntTileY)then
           crntTileAnchorX :=  (crntTileX * TileWidth) + TileHalfWidth
          else
           crntTileAnchorX :=  (crntTileX * TileWidth );

          crntTileAnchorY :=  (crntTileY * TileHalfHeight);

          if (crntTileAnchorX < -32) or (crntTileAnchorX > BmpBuffer.Width) then bContinue := true;
          if (crntTileAnchorY < -16) or (crntTileAnchorY > BmpBuffer.Height) then bContinue := true;

          if not(bContinue) and (id > -1) and (id < TQuadTile(QuadCollection.QuadList.Items[iLoop]).pTileSet.imQuadTiles.ImageCount) then
            TQuadTile(QuadCollection.QuadList.Items[iLoop]).pTileSet.imQuadTiles.DrawImage(id, BmpBuffer.canvas, crntTileAnchorX+32,crntTileAnchorY);
      end;
      //East
      bContinue := false;

      if assigned(TQuadTile(QuadCollection.QuadList.Items[iLoop]).East.Tile) then
      begin
          id := TQuadTile(QuadCollection.QuadList.Items[iLoop]).East.Tile.ID;
          crntTileX := TQuadTile(QuadCollection.QuadList.Items[iLoop]).East.x-StartTileX;
          crntTileY := TQuadTile(QuadCollection.QuadList.Items[iLoop]).East.y-StartDiamondY;

          if odd(crntTileY)then
           crntTileAnchorX :=  (crntTileX * TileWidth) + TileHalfWidth
          else
           crntTileAnchorX :=  (crntTileX * TileWidth );

          crntTileAnchorY :=  (crntTileY * TileHalfHeight);

          if (crntTileAnchorX < -32) or (crntTileAnchorX > BmpBuffer.Width) then bContinue := true;
          if (crntTileAnchorY < -16) or (crntTileAnchorY > BmpBuffer.Height) then bContinue := true;

          if not(bContinue) and (id > -1) and (id < TQuadTile(QuadCollection.QuadList.Items[iLoop]).pTileSet.imQuadTiles.ImageCount) then
            TQuadTile(QuadCollection.QuadList.Items[iLoop]).pTileSet.imQuadTiles.DrawImage(id, BmpBuffer.canvas, crntTileAnchorX+32,crntTileAnchorY);
      end;
      //South
      bContinue := false;
      if assigned(TQuadTile(QuadCollection.QuadList.Items[iLoop]).South.Tile) then
      begin
          id := TQuadTile(QuadCollection.QuadList.Items[iLoop]).South.Tile.ID;
          crntTileX := TQuadTile(QuadCollection.QuadList.Items[iLoop]).South.x-StartTileX;
          crntTileY := TQuadTile(QuadCollection.QuadList.Items[iLoop]).South.y-StartDiamondY;

          if odd(crntTileY)then
           crntTileAnchorX :=  (crntTileX * TileWidth) + TileHalfWidth
          else
           crntTileAnchorX :=  (crntTileX * TileWidth );

          crntTileAnchorY :=  (crntTileY * TileHalfHeight);

          if (crntTileAnchorX < -32) or (crntTileAnchorX > BmpBuffer.Width) then bContinue := true;
          if (crntTileAnchorY < -16) or (crntTileAnchorY > BmpBuffer.Height) then bContinue := true;

          if not(bContinue) and (id > -1) and (id < TQuadTile(QuadCollection.QuadList.Items[iLoop]).pTileSet.imQuadTiles.ImageCount) then
            TQuadTile(QuadCollection.QuadList.Items[iLoop]).pTileSet.imQuadTiles.DrawImage(id, BmpBuffer.canvas, crntTileAnchorX+32,crntTileAnchorY);
      end;
      //West
      bContinue := false;
      if assigned(TQuadTile(QuadCollection.QuadList.Items[iLoop]).West.Tile) then
      begin
          id := TQuadTile(QuadCollection.QuadList.Items[iLoop]).West.Tile.ID;
          crntTileX := TQuadTile(QuadCollection.QuadList.Items[iLoop]).West.x-StartTileX;
          crntTileY := TQuadTile(QuadCollection.QuadList.Items[iLoop]).West.y-StartDiamondY;

          if odd(crntTileY)then
           crntTileAnchorX :=  (crntTileX * TileWidth) + TileHalfWidth
          else
           crntTileAnchorX :=  (crntTileX * TileWidth );

          crntTileAnchorY :=  (crntTileY * TileHalfHeight);

          if (crntTileAnchorX < -32) or (crntTileAnchorX > BmpBuffer.Width) then bContinue := true;
          if (crntTileAnchorY < -16) or (crntTileAnchorY > BmpBuffer.Height) then bContinue := true;

          if not(bContinue) and (id > -1) and (id < TQuadTile(QuadCollection.QuadList.Items[iLoop]).pTileSet.imQuadTiles.ImageCount) then
            TQuadTile(QuadCollection.QuadList.Items[iLoop]).pTileSet.imQuadTiles.DrawImage(id, BmpBuffer.canvas, crntTileAnchorX+32,crntTileAnchorY);
      end;

    end;
end;

procedure TfrmMain.MergeSingleTiles(fileName: string; x: integer; y: integer);
var
NewTile: TTile;
iTileID: integer;
bFound: boolean;
iLoop : integer;
begin
      bFound := false;
      for iLoop := 0 to DiamondTileList.Count -1 do
      begin
          if LowerCase(TTile(DiamondTileList.Items[iLoop]).FileName) = LowerCase(extractFileName(fileName)) then
          begin  //Found the Tile
               bFound := true;
               iTileID := TTile(DiamondTileList.Items[iLoop]).ID;
          end;
      end;

      if not(bFound) then
      begin
          LoadTileByName(fileName);
          imDiamondTiles.AddImage2(TileImage);
          NewTile := TTile.Create;
          NewTile.FileName := SelectTileName;
          NewTile.ID :=  imDiamondTiles.ImageCount -1;
          iTileID := NewTile.ID;
          DiamondTileList.add(NewTile);
      end;
      if (x > -1) and (y > -1) then
      DiamondLayer[y, x] := iTileID;

end;

procedure TfrmMain.MergeQuadTiles;
var
iLoop: integer;
fileName : string;
crntTileX: integer;
crntTileY: integer;
begin
    for iLoop := 0 to QuadCollection.QuadList.Count -1 do
    begin
      //North
      if assigned(TQuadTile(QuadCollection.QuadList.Items[iLoop]).North.Tile) then
      begin
        fileName:= TQuadTile(QuadCollection.QuadList.Items[iLoop]).North.Tile.fileName;
        crntTileX:= TQuadTile(QuadCollection.QuadList.Items[iLoop]).North.x;
        crntTileY:= TQuadTile(QuadCollection.QuadList.Items[iLoop]).North.y;
        MergeSingleTiles(fileName,crntTileX,crntTileY);
      end;
      //East
      if assigned(TQuadTile(QuadCollection.QuadList.Items[iLoop]).East.Tile) then
      begin
        fileName:= TQuadTile(QuadCollection.QuadList.Items[iLoop]).East.Tile.fileName;
        crntTileX:= TQuadTile(QuadCollection.QuadList.Items[iLoop]).East.x;
        crntTileY:= TQuadTile(QuadCollection.QuadList.Items[iLoop]).East.y;
        MergeSingleTiles(fileName,crntTileX,crntTileY);
      end;

      //South
      if assigned(TQuadTile(QuadCollection.QuadList.Items[iLoop]).South.Tile) then
      begin
        fileName:= TQuadTile(QuadCollection.QuadList.Items[iLoop]).South.Tile.fileName;
        crntTileX:= TQuadTile(QuadCollection.QuadList.Items[iLoop]).South.x;
        crntTileY:= TQuadTile(QuadCollection.QuadList.Items[iLoop]).South.y;
        MergeSingleTiles(fileName,crntTileX,crntTileY);
      end;


      //West
      if assigned(TQuadTile(QuadCollection.QuadList.Items[iLoop]).West.Tile) then
      begin
        fileName:= TQuadTile(QuadCollection.QuadList.Items[iLoop]).West.Tile.fileName;
        crntTileX:= TQuadTile(QuadCollection.QuadList.Items[iLoop]).West.x;
        crntTileY:= TQuadTile(QuadCollection.QuadList.Items[iLoop]).West.y;
        MergeSingleTiles(fileName,crntTileX,crntTileY);
      end;
    end;
end;


procedure TfrmMain.RenderGameObjects;
var
   crntSpriteAnchorX: integer;
   crntSpriteAnchorY: integer;
   crntSpriteX: integer;
   crntSpriteY: integer;
   iLoop: integer;
   imgHalfWidth: integer;
   imgHalfHeight: integer;
   crntTileAnchorX: integer;
   crntTileAnchorY: integer;
   tmpX,tmpY,tmpH,tmpW: integer;
begin

       for iLoop := 0 to ObjectList.count -1 do
       begin

           crntSpriteX := TGameObject(ObjectList.Items[iLoop]).x - StartTileX;
           crntSpriteY := TGameObject(ObjectList.Items[iLoop]).y - StartDiamondY;

           if odd(crntSpriteY)then
             crntSpriteAnchorX :=  (crntSpriteX * TileWidth) + TileHalfWidth
           else
             crntSpriteAnchorX :=  (crntSpriteX * TileWidth );

           if odd(crntSpriteY)then
             crntTileAnchorX :=  (crntSpriteX * TileWidth) + TileHalfWidth
           else
             crntTileAnchorX :=  (crntSpriteX * TileWidth );
           crntTileAnchorY :=  (crntSpriteY * TileHalfHeight);

           //Decide to Draw Selected or Occupied Tile Under a sprite
           if TestForSelected(TGameObject(ObjectList.Items[iLoop])) then
           begin
              if not TGameObject(ObjectList.Items[iLoop]).Hidden then
              PaintSelectedTile(crntTileAnchorX, crntTileAnchorY)
           end
           else
           begin
               if not TGameObject(ObjectList.Items[iLoop]).Hidden then
               PaintOccupiedTile(crntTileAnchorX, crntTileAnchorY);
           end;

           case TGameObject(ObjectList.Items[iLoop]).MyType of
               otSprite:
                  if cbSprite.Checked then
                  begin
                     if TSprite(ObjectList.Items[iLoop]).spriteType = stParticle then
                     begin
                          imgHalfWidth := (bmpParticles.width div 2);
                          imgHalfHeight := (bmpParticles.Height div 2);

                          crntSpriteAnchorY :=  (crntSpriteY * TileHalfHeight) +(TileHalfHeight) -16 + TSprite(ObjectList.Items[iLoop]).offSetY;
                          crntSpriteAnchorX := crntSpriteAnchorX + TileHalfWidth  -8+ TSprite(ObjectList.Items[iLoop]).offSetX +32;
                          //Dont draw sprites too far off screen
                          if (crntSpriteAnchorX < -64) or (crntSpriteAnchorX > 815) then continue;
                          if (crntSpriteAnchorY < -64) or (crntSpriteAnchorY > 700) then continue;
                          if not TSprite(ObjectList.Items[iLoop]).Hidden then
                          BmPBuffer.Canvas.Draw(crntSpriteAnchorX,crntSpriteAnchorY, bmpParticles);
                     end
                     else
                     if TSprite(ObjectList.Items[iLoop]).spriteType = stStart then
                     begin
                          imgHalfWidth := (bmpBlankNPC.width div 2);
                          imgHalfHeight := (bmpBlankNPC.Height div 2);

                          crntSpriteAnchorY :=  (crntSpriteY * TileHalfHeight) +(TileHalfHeight) -85;
                          crntSpriteAnchorX := crntSpriteAnchorX + TileHalfWidth -23 +32;
                          //Dont draw sprites too far off screen
                          if (crntSpriteAnchorX < -64) or (crntSpriteAnchorX > 815) then continue;
                          if (crntSpriteAnchorY < -64) or (crntSpriteAnchorY > 700) then continue;
                          if not TSprite(ObjectList.Items[iLoop]).Hidden then
                          BmPBuffer.Canvas.Draw(crntSpriteAnchorX,crntSpriteAnchorY, bmpBlankNPC);
                     end
                     else
                     if TSprite(ObjectList.Items[iLoop]).spriteType = stSprite then
                     begin
                         imgHalfWidth := (TSprite(ObjectList.Items[iLoop]).Image.width div 2);
                         imgHalfHeight := (TSprite(ObjectList.Items[iLoop]).Image.Height div 2);

                        // crntSpriteAnchorY := crntTileAnchorY - (TSprite(ObjectList.Items[iLoop]).Image.Height );
                        // crntSpriteAnchorX := (crntSpriteAnchorX - imgHalfWidth) + TileHalfWidth ;
                         crntSpriteAnchorY := ((crntTileAnchorY + tileHalfHeight) - (TStatic(ObjectList.Items[iLoop]).Image.Height))- TSprite(ObjectList.Items[iLoop]).offSetY;
                         crntSpriteAnchorX := crntSpriteAnchorX + TSprite(ObjectList.Items[iLoop]).offSetX +32;

                      //   crntSpriteAnchorY :=  (crntSpriteY * TileHalfHeight) - (TSprite(ObjectList.Items[iLoop]).Image.Height - (TileHalfHeight) + TSprite(ObjectList.Items[iLoop]).offSetY);
                       //  crntSpriteAnchorX := crntSpriteAnchorX - TileHalfWidth + TSprite(ObjectList.Items[iLoop]).offSetX;
                         //Dont draw sprites too far off screen
                         if (crntSpriteAnchorX + TSprite(ObjectList.Items[iLoop]).Image.width < 0) or (crntSpriteAnchorX > 815) then continue;
                         if (crntSpriteAnchorY + TSprite(ObjectList.Items[iLoop]).Image.Height < 0) or (crntSpriteAnchorY > 700) then continue;

                         if not TSprite(ObjectList.Items[iLoop]).Hidden then
                         BmPBuffer.Canvas.Draw(crntSpriteAnchorX,crntSpriteAnchorY, TSprite(ObjectList.Items[iLoop]).Image);
                         TSprite(ObjectList.Items[iLoop]).CurrentX := crntSpriteAnchorX;
                         TSprite(ObjectList.Items[iLoop]).CurrentY := crntSpriteAnchorY;
                     end
                     else
                     if TSprite(ObjectList.Items[iLoop]).spriteType = stNPC then
                     begin
                         imgHalfWidth := (TSprite(ObjectList.Items[iLoop]).Image.width div 2);
                         imgHalfHeight := (TSprite(ObjectList.Items[iLoop]).Image.Height div 2);
                         crntSpriteAnchorY := crntTileAnchorY - (TSprite(ObjectList.Items[iLoop]).Image.Height -25);
                         //crntSpriteAnchorY :=  (crntSpriteY * TileHalfHeight) - (TSprite(ObjectList.Items[iLoop]).Image.Height);
                         crntSpriteAnchorX := (crntSpriteAnchorX - imgHalfWidth) + TileHalfWidth +32;

                         //Dont draw sprites too far off screen
                         if (crntSpriteAnchorX + TSprite(ObjectList.Items[iLoop]).Image.width < 0) or (crntSpriteAnchorX > 815) then continue;
                         if (crntSpriteAnchorY + TSprite(ObjectList.Items[iLoop]).Image.Height < 0) or (crntSpriteAnchorY > 700) then continue;

                         if not TSprite(ObjectList.Items[iLoop]).Hidden then
                         BmPBuffer.Canvas.Draw(crntSpriteAnchorX,crntSpriteAnchorY, TSprite(ObjectList.Items[iLoop]).Image);
                         TSprite(ObjectList.Items[iLoop]).CurrentX := crntSpriteAnchorX;
                         TSprite(ObjectList.Items[iLoop]).CurrentY := crntSpriteAnchorY;
                     end;

                         BmPBuffer.Canvas.Font.Color := clYellow;
                         BmPBuffer.Canvas.Font.Style := [fsBold];
                         BmPBuffer.Canvas.Brush.style := bsClear;
                         //Write out the character name
                         if (TSprite(ObjectList.Items[iLoop]).spriteType = stNPC) then
                            BmPBuffer.Canvas.TextOut((crntSpriteAnchorX + imgHalfWidth) -(imgHalfWidth div 2),crntSpriteAnchorY + 30,TSprite(ObjectList.Items[iLoop]).DisplayName);
                         //Write out the object name
                         //if (TSprite(ObjectList.Items[iLoop]).spriteType = stParticle)  then
                         //   BmPBuffer.Canvas.TextOut((crntSpriteAnchorX + imgHalfWidth) -(imgHalfWidth div 2)-20,crntSpriteAnchorY + 20,ExtractFileName(TSprite(ObjectList.Items[iLoop]).FileName));

                         if (TSprite(ObjectList.Items[iLoop]).spriteType <> stParticle) then
                         begin
                             //Write out the character facing
                             BmPBuffer.Canvas.TextOut(crntSpriteAnchorX + imgHalfWidth - 7,crntSpriteAnchorY + imgHalfHeight + 10,FacingsList.Strings[TSprite(ObjectList.Items[iLoop]).Facing]);
                             //Change colors
                             BmPBuffer.Canvas.Brush.Color := clred;
                             BmPBuffer.Canvas.Pen.Color := clred;
                             //Draw the cenert dot
                             BmPBuffer.Canvas.Ellipse(crntSpriteAnchorX+imgHalfWidth -5,crntSpriteAnchorY + imgHalfHeight -5,crntSpriteAnchorX + imgHalfWidth +5,crntSpriteAnchorY + imgHalfHeight+5);
                             BmPBuffer.Canvas.MoveTo(crntSpriteAnchorX+imgHalfWidth,crntSpriteAnchorY + imgHalfHeight);

                             //Draw the Arrow For the Facing
                             case TSprite(ObjectList.Items[iLoop]).Facing of
                              0:BmPBuffer.Canvas.LineTo(crntSpriteAnchorX+imgHalfWidth+20,crntSpriteAnchorY + imgHalfHeight-10);
                              1:BmPBuffer.Canvas.LineTo(crntSpriteAnchorX+imgHalfWidth-20,crntSpriteAnchorY + imgHalfHeight-10);
                              2:BmPBuffer.Canvas.LineTo(crntSpriteAnchorX+imgHalfWidth+20,crntSpriteAnchorY + imgHalfHeight+10);
                              3:BmPBuffer.Canvas.LineTo(crntSpriteAnchorX+imgHalfWidth-20,crntSpriteAnchorY + imgHalfHeight+10);
                             end;
                         end;
                  end;
               otStatic:
                  if cbStatic.checked then
                  begin
                         imgHalfWidth := (TStatic(ObjectList.Items[iLoop]).Image.width div 2);
                         imgHalfHeight := (TStatic(ObjectList.Items[iLoop]).Image.Height div 2);

                         crntSpriteAnchorY := ((crntTileAnchorY + tileHalfHeight) - (TStatic(ObjectList.Items[iLoop]).Image.Height))- TStatic(ObjectList.Items[iLoop]).offSetY;

                         crntSpriteAnchorX := crntSpriteAnchorX + TStatic(ObjectList.Items[iLoop]).offSetX +32;

                         //Dont draw sprites too far off screen
                         if (crntSpriteAnchorX + TStatic(ObjectList.Items[iLoop]).Image.width < 0) or (crntSpriteAnchorX > 815) then continue;
                         if (crntSpriteAnchorY + TStatic(ObjectList.Items[iLoop]).Image.Height < 0) or (crntSpriteAnchorY > 700) then continue;

                         if not TStatic(ObjectList.Items[iLoop]).Hidden then
                         BmPBuffer.Canvas.Draw(crntSpriteAnchorX,crntSpriteAnchorY, TStatic(ObjectList.Items[iLoop]).Image);
                         TStatic(ObjectList.Items[iLoop]).CurrentX := crntSpriteAnchorX;
                         TStatic(ObjectList.Items[iLoop]).CurrentY := crntSpriteAnchorY;

                  end;
               otLight:
                     if cbLight.checked then
                     begin
                          imgHalfWidth := (bmpLight.width div 2);
                          imgHalfHeight := (bmpLight.Height div 2);

                          crntSpriteAnchorY :=  (crntSpriteY * TileHalfHeight) +(TileHalfHeight) -16 + TLight(ObjectList.Items[iLoop]).offSetY;
                          crntSpriteAnchorX := crntSpriteAnchorX + TileHalfWidth  -8+ TLight(ObjectList.Items[iLoop]).offSetX +32;
                          //Dont draw sprites too far off screen
                          if (crntSpriteAnchorX < -64) or (crntSpriteAnchorX > 815) then continue;
                          if (crntSpriteAnchorY < -64) or (crntSpriteAnchorY > 700) then continue;
                          if not TLight(ObjectList.Items[iLoop]).Hidden then
                          BmPBuffer.Canvas.Draw(crntSpriteAnchorX,crntSpriteAnchorY, bmpLight);
                          TLight(ObjectList.Items[iLoop]).CurrentX := crntSpriteAnchorX;
                          TLight(ObjectList.Items[iLoop]).CurrentY := crntSpriteAnchorY;
                     end;
           end;
       end;
       RenderGroupLine(ObjectList);

       for iLoop := 0 to ObjectList.count -1 do
       if TestForSelected(TGameObject(ObjectList.Items[iLoop])) then
       begin
          //Border box
          if TGameObject(ObjectList.Items[iLoop]).Image <> nil then
          begin
              tmpX := TGameObject(ObjectList.Items[iLoop]).currentX;
              tmpY := TGameObject(ObjectList.Items[iLoop]).currentY;
              tmpW := TGameObject(ObjectList.Items[iLoop]).Image.Width;
              tmpH := TGameObject(ObjectList.Items[iLoop]).image.height;
              BmPBuffer.canvas.Pen.Color := clBlue;
              BmPBuffer.canvas.Pen.Style := psDot;
              BmPBuffer.canvas.MoveTo(tmpX,tmpY);
              BmPBuffer.canvas.LineTo(tmpX+tmpW,tmpY);
              BmPBuffer.canvas.LineTo(tmpX+tmpW,tmpY+tmpH);
              BmPBuffer.canvas.LineTo(tmpX,tmpY+tmpH);
              BmPBuffer.canvas.LineTo(tmpX,tmpY);
          end;
{
          if TGameObject(ObjectList.Items[iLoop]).MyType = otLight then
          begin
              tmpX := TLight(ObjectList.Items[iLoop]).currentX;
              tmpY := TLight(ObjectList.Items[iLoop]).currentY;
              tmpW := TLight(ObjectList.Items[iLoop]).Width;
              tmpH := TLight(ObjectList.Items[iLoop]).Height;
              tmpX := tmpX - (tmpW div 2);
              tmpY := tmpY - (tmpH div 2);
              BmPBuffer.canvas.Pen.Color := clBlue;
              BmPBuffer.canvas.Pen.Style := psDot;
              BmPBuffer.canvas.MoveTo(tmpX,tmpY);
              BmPBuffer.canvas.LineTo(tmpX+tmpW,tmpY);
              BmPBuffer.canvas.LineTo(tmpX+tmpW,tmpY+tmpH);
              BmPBuffer.canvas.LineTo(tmpX,tmpY+tmpH);
              BmPBuffer.canvas.LineTo(tmpX,tmpY);
          end;
 }
       end;
       BmPBuffer.canvas.Pen.Style := psSolid;

end;


procedure TfrmMain.RenderLightEdit;
var
 tmpX,tmpY,tmpH,tmpW: integer;
begin
      if TGameObject(SelectedList.items[0]).MyType = otLight then
      begin
          BmpBuffer.Canvas.Draw(0,0,BackBuffer);
          tmpX := TLight(SelectedList.items[0]).currentX + 8;
          tmpY := TLight(SelectedList.items[0]).currentY + 8;
          tmpW := TLight(SelectedList.items[0]).Width;
          tmpH := TLight(SelectedList.items[0]).Height;
          tmpX := tmpX - (tmpW div 2);
          tmpY := tmpY - (tmpH div 2);
          BmPBuffer.canvas.Pen.Color := clBlue;
          BmPBuffer.canvas.Pen.Style := psDot;
          BmPBuffer.canvas.MoveTo(tmpX,tmpY);
          BmPBuffer.canvas.LineTo(tmpX+tmpW,tmpY);
          BmPBuffer.canvas.LineTo(tmpX+tmpW,tmpY+tmpH);
          BmPBuffer.canvas.LineTo(tmpX,tmpY+tmpH);
          BmPBuffer.canvas.LineTo(tmpX,tmpY);
          iMap.canvas.Draw(0,0,BmPBuffer);
      end;
      BmPBuffer.canvas.Pen.Style := psSolid;
end;


Procedure TfrmMain.RenderGroupLine(List: TList);
var
GroupList: TStringList;
TmpGroupList: TList;
iLoop: integer;
tmpStr: string;
jLoop: integer;
crntItemX: integer;
crntItemY: integer;
crntItemAnchorX: integer;
crntItemAnchorY: integer;

begin
    GroupList := TStringList.create;
    for iLoop := 0 to List.Count-1 do
    begin
      tmpStr := IntToStr(TSprite(List.Items[iLoop]).GroupID);
      if (tmpStr <> '-1') and (GroupList.IndexOf(tmpStr) = -1) then
      GroupList.Add(tmpStr);
    end;

    for iLoop := 0 to GroupList.count -1 do
    begin
          TmpGroupList:= TList.Create;
          for jLoop := 0 to List.Count-1 do
          begin
            if TSprite(List.Items[jLoop]).GroupID = StrToInt(GroupList.strings[iLoop]) then
               TmpGroupList.Add(List.Items[jLoop]);
          end;
          //MoveTo The first one
          crntItemX := TSprite(TmpGroupList.Items[0]).x - StartTileX;
          crntItemY := TSprite(TmpGroupList.Items[0]).y - StartDiamondY;

          if odd(crntItemY)then
             crntItemAnchorX :=  (crntItemX * TileWidth) + TileWidth
          else
             crntItemAnchorX :=  (crntItemX * TileWidth )+ TileHalfWidth;
             crntItemAnchorY :=  (crntItemY * TileHalfHeight)+TileHalfHeight;
          BmPBuffer.Canvas.MoveTo(crntItemAnchorX,crntItemAnchorY);
          BmPBuffer.Canvas.Pen.Color := clLime;
          BmPBuffer.Canvas.Brush.Color := clLime;
          BmPBuffer.Canvas.Ellipse(crntItemAnchorX-5,crntItemAnchorY-5,crntItemAnchorX+5,crntItemAnchorY+5);

          for jLoop := 1 to TmpGroupList.Count -1 do
          begin
              //LineTo The rest
               crntItemX := TSprite(TmpGroupList.Items[jLoop]).x - StartTileX;
               crntItemY := TSprite(TmpGroupList.Items[jLoop]).y - StartDiamondY;

               if odd(crntItemY)then
                 crntItemAnchorX :=  (crntItemX * TileWidth) + TileWidth
               else
                 crntItemAnchorX :=  (crntItemX * TileWidth )+ TileHalfWidth;

               crntItemAnchorY :=  (crntItemY * TileHalfHeight)+TileHalfHeight;

               BmPBuffer.Canvas.LineTo(crntItemAnchorX,crntItemAnchorY);
               BmPBuffer.Canvas.Ellipse(crntItemAnchorX-5,crntItemAnchorY-5,crntItemAnchorX+5,crntItemAnchorY+5);
          end;

          tmpGroupList.Clear;
          tmpGroupList.free;
    end;
end;


procedure TfrmMain.SortSpriteList(var List: TList);
var
tmpSortList: TList;
iLoop: integer;
workingIndx: integer;

  Function GetLowestY: integer;
    var
       jLoop: integer;
       indx: integer;
  begin
        indx := 0;
        for jLoop := 0 to List.Count -1 do
        begin
            if TGameObject(List.Items[jLoop]).Y < TSprite(List.Items[indx]).Y then
            begin
               indx := jLoop;
            end;
        end;
        Result := indx;
  end;
begin
     tmpSortList := TList.Create;

     while List.Count > 0 do
     begin  //Get the lowest Y in they
        workingIndx := GetLowestY;
        //Add it to the tmp Staging list
        tmpSortList.Add(List.Items[workingIndx]);
        //Delete it from the existing list so we dont count it again
        List.Delete(workingIndx);
     end;

     //Go through the stagin list and copy teh back in the same order
     for iLoop := 0 to tmpSortList.count -1 do
     begin
        List.add(tmpSortList.Items[iLoop]);
     end;
end;

function TfrmMain.GetObjectAt(List: TList; x: integer; y: integer): TGameObject;
var
  iLoop: integer;
  MySprite: TGameObject;
begin
    MySprite := nil;

    for iLoop := 0 to List.count -1 do
    begin
       if (TGameObject(List.items[iLoop]).x = x) and (TGameObject(List.items[iLoop]).Y = y) and (TGameObject(List.items[iLoop]).Hidden = false) then
          MySprite := TGameObject(List.items[iLoop]);
    end;
    result := MySprite;
end;

function TfrmMain.GetImageAt(List: TList; x: integer; y: integer): TGameObject;
var
  iLoop: integer;
  MySprite: TGameObject;
begin
    MySprite := nil;

    for iLoop := 0 to List.count -1 do
    begin
        MySprite := TGameObject(List.items[iLoop]);
        if (MySprite.Image <> nil) then
        begin
        if ((x > MySprite.CurrentX) and (x < (MySprite.CurrentX +MySprite.Image.Width))) and
          ((y > MySprite.CurrentY) and (Y < (MySprite.CurrentY +MySprite.Image.Height))) then
            break;
        end;
        MySprite := nil;
    end;
    result := MySprite;
end;


function TfrmMain.GetObjectIndxAt(List: TList; x: integer; y: integer): integer;
var
  iLoop: integer;
  indx: integer;
begin
    indx := -1;

    for iLoop := 0 to List.count -1 do
    begin
       if (TGameObject(List.items[iLoop]).x = x) and (TGameObject(List.items[iLoop]).Y = y) then
          indx := iLoop;
    end;
    result := indx;
end;


procedure TfrmMain.PaintDiamondTile(id: integer; x: integer; y: integer);
begin
     if (id > 0) and (id < imDiamondTiles.ImageCount) then
     imDiamondTiles.DrawImage(id, BmpBuffer.canvas, x + 32,y);
end;

procedure TfrmMain.PaintBaseTile(id: integer; x: integer; y: integer);
begin
     if (id > 0) and (id < imBaseTiles.ImageCount) then
     imBaseTiles.DrawImage(id, BmpBuffer.canvas, x + 32,y-16);
end;

procedure TfrmMain.PaintCollisionTile(x: integer; y: integer);
begin
     BmpBuffer.canvas.draw(x + 32,y, bmpCollison);
end;

procedure TfrmMain.PaintStartTile(x: integer; y: integer; side: integer);
begin
     if side = 1 then
       BmpBuffer.canvas.draw(x + 32,y, bmpSideOne);
     if side = 2 then
       BmpBuffer.canvas.draw(x + 32,y, bmpSideTwo);
end;

procedure TfrmMain.PaintOccupiedTile(x: integer; y: integer);
begin
     BmpBuffer.canvas.draw(x + 32,y, bmpOccupied);
end;

procedure TfrmMain.PaintSelectedTile(x: integer; y: integer);
begin
     BmpBuffer.canvas.draw(x + 32,y, bmpSelected);
end;


procedure TfrmMain.mnuGridColorClick(Sender: TObject);
begin
//changed the Grid Color
if ColorDialog.execute then
   gColor := ColorDialog.Color;

   RefreshScreen;

end;


procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    try
      BmpBuffer.FreeImage;
      BmpBuffer.ReleaseHandle;
      BmpBuffer.free;
      BmpBuffer := nil;

      bmpCollison.FreeImage;
      bmpCollison.ReleaseHandle;
      bmpCollison.free;
      bmpCollison := nil;

      bmpSideOne.FreeImage;
      bmpSideOne.ReleaseHandle;
      bmpSideOne.free;
      bmpSideOne := nil;

      bmpSideTwo.FreeImage;
      bmpSideTwo.ReleaseHandle;
      bmpSideTwo.free;
      bmpSideTwo := nil;

      bmpOccupied.FreeImage;
      bmpOccupied.ReleaseHandle;
      bmpOccupied.free;
      bmpOccupied := nil;

      bmpPlaceHolder.FreeImage;
      bmpPlaceHolder.ReleaseHandle;
      bmpPlaceHolder.free;
      bmpPlaceHolder := nil;

      bmpPopOff.FreeImage;
      bmpPopOff.ReleaseHandle;
      bmpPopOff.free;
      bmpPopOff := nil;

      bmpTrigger.FreeImage;
      bmpTrigger.ReleaseHandle;
      bmpTrigger.free;
      bmpTrigger := nil;

      bmpBlankNPC.FreeImage;
      bmpBlankNPC.ReleaseHandle;
      bmpBlankNPC.free;
      bmpBlankNPC := nil;

      bmpLight.FreeImage;
      bmpLight.ReleaseHandle;
      bmpLight.free;
      bmpLight := nil;

      bmpSelected.FreeImage;
      bmpSelected.ReleaseHandle;
      bmpSelected.free;
      bmpSelected := nil;

      bmpParticles.FreeImage;
      bmpParticles.ReleaseHandle;
      bmpParticles.free;
      bmpParticles := nil;

      BackBuffer.FreeImage;
      BackBuffer.ReleaseHandle;
      BackBuffer.free;
      BackBuffer := nil;

      MainImgMngr.free;
      imDiamondTiles.free;
      imBaseTiles.free;
      EmptyTList(DiamondTileList);
      DiamondTileList.clear;
      DiamondTileList.free;
      EmptyTList(BaseTileList);
      BaseTileList.clear;
      BaseTileList.free;
      EmptyTList(ObjectList);
      ObjectList.clear;
      ObjectList.free;
      QuadCollection.free;
      //These pointers were freed with SpriteList
      SelectedList.clear;
      SelectedList.Free;
      FacingsList.clear;
      FacingsList.Free;
      ScriptList.clear;
      ScriptList.Free;
      RandomTileList.clear;
      RandomTileList.free;
    except
    end;
end;


procedure TfrmMain.DrawSquare(var bmp: TBitmap);
var
x,y: Integer;
iLoop: integer;
begin
// Draw the Square Grid
Bmp.Canvas.Pen.Color := gColor;

          x := 0;
          for iLoop := 0 to Bmp.width div 48 do
          begin
               //Verticle
               X := X + 48;
               Bmp.Canvas.Moveto(x, 0);

               Bmp.Canvas.LineTo(x,iMap.Height);
          end;

          y := 0;
          for iLoop := 0 to iMap.width div 48 do
          begin
               //horizontal
               y := y + 48;
               Bmp.Canvas.Moveto(0, y);

               Bmp.Canvas.LineTo(iMap.width,y);
          end;


end;

procedure TfrmMain.DrawOctagon(Var bmp: TBitmap);
var
x,y: Integer;
x1,y1: Integer;
mLoop: integer;
iLoop: integer;
begin
//  32X28  X 14
// Draw the Hex grid
X1 := 1;
Y1 := 29;
Bmp.Canvas.Pen.Color := gColor;

      for mLoop := 0 to Bmp.height div 56 do
      begin
          X := x1;
          Y := y1;
          Bmp.Canvas.Moveto(x  + 32, y);
          //Top
          for iLoop := 0 to Bmp.width div 32 do
          begin
               //Up
               X := X + 15;
               y := y - 28;
               Bmp.Canvas.LineTo(x + 32,y);
               //over
               X := X + 32;
               Bmp.Canvas.LineTo(x + 32,y);
               //down
               X := X + 15;
               y := y + 28;
               Bmp.Canvas.LineTo(x + 32,y);
               //over
               X := X + 32;
               Bmp.Canvas.LineTo(x + 32,y);
          end;

          X := x1;
          Y := y1;
          Bmp.Canvas.Moveto(x, y);
          //Bottom
          for iLoop := 0 to iMap.width div 32 do
          begin
               //down
               X := X + 15;
               y := y + 28;
               Bmp.Canvas.LineTo(x + 32,y);
               //over
               X := X + 32;
               Bmp.Canvas.LineTo(x + 32,y);
               //Up
               X := X + 15;
               y := y - 28;
               Bmp.Canvas.LineTo(x + 32,y);
               //over
               X := X + 32;
               Bmp.Canvas.LineTo(x + 32,y);
          end;
           y1 := y1 + 56;
      end;
end;

procedure TfrmMain.DrawRectangle(var bmp: TBitmap);
var
x,y: Integer;
iLoop: integer;
begin
// Draw the Square Grid
Bmp.Canvas.Pen.Color := gColor;

          x := -32;
          for iLoop := 0 to (iMap.width div TileWidth) do
          begin
               //Verticle
               X := X + TileWidth;
               Bmp.Canvas.Moveto(x, 0);

               Bmp.Canvas.LineTo(x,iMap.Height);
          end;

          y := -16;
          for iLoop := 0 to (iMap.Height div TileHeight) do
          begin
               //horizontal
               y := y + TileHeight;
               Bmp.Canvas.Moveto(0, y);
               Bmp.Canvas.LineTo(iMap.width,y);
          end;


end;


procedure TfrmMain.DrawDiamond(Var bmp: TBitmap);
var
x,y: Integer;
x1,y1: Integer;
mLoop: integer;
iLoop: integer;
begin
//  32X28  X 14
// Draw the Hex grid
X1 := -32;
Y1 := 16;
Bmp.Canvas.Pen.Color := gColor;

      for mLoop := 0 to Bmp.height div 32 do
      begin
          X := x1;
          Y := y1;
          Bmp.Canvas.Moveto(x, y);
          //Top
          for iLoop := 0 to Bmp.width div 64 do
          begin
               //Up
               X := X + 32;
               y := y - 16;
               Bmp.Canvas.LineTo(x,y);
               //over
             //  X := X + 2;
             //  Bmp.Canvas.LineTo(x,y);
               //down
               X := X + 32;
               y := y + 16;
               Bmp.Canvas.LineTo(x,y);
               //over
          //     X := X + 4;
           //    Bmp.Canvas.LineTo(x,y);
          end;

          X := x1;
          Y := y1;
          Bmp.Canvas.Moveto(x, y);
          //Bottom
          for iLoop := 0 to iMap.width div 32 do
          begin
               //down
               X := X + 32;
               y := y + 16;
               Bmp.Canvas.LineTo(x,y);
               //over
             //  X := X + 2;
             //  Bmp.Canvas.LineTo(x,y);
               //Up
               X := X + 32;
               y := y - 16;
               Bmp.Canvas.LineTo(x,y);
               //over
             //  X := X + 4;
              // Bmp.Canvas.LineTo(x,y);
          end;
           y1 := y1 + 32;
      end;
exit;
  X1 := -32;
  Y1 := 16;
      //Fill In Blank Left to look pretty
      for mLoop := 0 to Bmp.height div 32 do
      begin
          X := x1;
          Y := y1;
          Bmp.Canvas.Moveto(x, y);
          //Top
          for iLoop := 0 to Bmp.width div 64 do
          begin
               //Up
               X := X + 32;
               y := y - 16;
               Bmp.Canvas.LineTo(x,y);
               //down
               X := X + 32;
               y := y + 16;
               Bmp.Canvas.LineTo(x,y);
          end;

          X := x1;
          Y := y1;
          Bmp.Canvas.Moveto(x  + 32, y);
          //Bottom
          for iLoop := 0 to iMap.width div 32 do
          begin
               //down
               X := X + 32;
               y := y + 16;
               Bmp.Canvas.LineTo(x,y);
               //Up
               X := X + 32;
               y := y - 16;
               Bmp.Canvas.LineTo(x,y);
          end;
           y1 := y1 + 32;
      end;


end;


procedure TfrmMain.DrawGameScreen(Var bmp: TBitmap);
var
crntTileX: integer;
crntTileY: integer;
crntTileAnchorX: integer;
crntTileAnchorY: integer;
begin

    crntTileX := GameScreenX - StartTileX;
    crntTileY := GameScreenY - StartDiamondY;

    if odd(GameScreenY)then
     crntTileAnchorX :=  (crntTileX * TileWidth) + TileHalfWidth
    else
     crntTileAnchorX :=  (crntTileX * TileWidth );

    crntTileAnchorY :=  (crntTileY * TileHalfHeight);

    crntTileAnchorX := crntTileAnchorX + 32  + 32;
//    if (crntTileAnchorX < -32) or (crntTileAnchorX > BmpBuffer.Width) then continue;
//    if (crntTileAnchorY < -16) or (crntTileAnchorY > BmpBuffer.Height) then continue;

    Bmp.Canvas.Pen.Color := clRed;

    Bmp.Canvas.Moveto(crntTileAnchorX, crntTileAnchorY);
    Bmp.Canvas.LineTo(crntTileAnchorX + 800,crntTileAnchorY);
    Bmp.Canvas.LineTo(crntTileAnchorX + 800,crntTileAnchorY+600);
    Bmp.Canvas.LineTo(crntTileAnchorX,crntTileAnchorY+600);
    Bmp.Canvas.LineTo(crntTileAnchorX,crntTileAnchorY);

end;



procedure TfrmMain.GetSelectedDiamondTile(X: integer; Y: integer);
var
  tmpX: integer;
  tmpY: integer;
  tmpTileX: integer;
  tmpTileY: integer;
  loopx, loopy, // use for tile loop
  visx, visy, // first visible tile
  wx, wy: integer; // world x and y
  xoffset: integer;
  yoffset: integer;
begin

  xoffset :=  StartTileX* TileWidth - 32 ;
  yoffset :=  StartDiamondY* TileHalfHeight;

  MouseX := X;
  MouseY := Y;
  wx := xoffset + MouseX; // set world x,y
  wy := yoffset + MouseY;

  // *** cheap, fast and easy "What tile am I on...?"

  visx := isomax(0, wx div TileWidth - 1); // guess what tile left
  visy := isomax(0, wy div (TileHeight div 2) - 1); // guess what tile top
  for loopy := visy - 1 to // just loop through 9 tiles
    isomin(mapheight, visy + 1) do
    for loopx := visx - 1 to
      isomin(mapwidth, visx + 1) do
      if isoPointInQuad(
        (loopx * TileWidth) + ((loopy mod 2) * (TileWidth div 2)),
        (loopy * (TileHeight div 2)) + (TileHeight div 2),
        (loopx * TileWidth) + ((loopy mod 2) * (TileWidth div 2)) + (TileWidth div 2),
        (loopy * (TileHeight div 2)) + TileHeight,
        (loopx * TileWidth) + ((loopy mod 2) * (TileWidth div 2)) + TileWidth,
        (loopy * (TileHeight div 2)) + (TileHeight div 2),
        (loopx * TileWidth) + ((loopy mod 2) * (TileWidth div 2)) + (TileWidth div 2),
        (loopy * (TileHeight div 2)),
        wx, wy) then
      begin
        SelectedTileX := loopx;
        SelectedTileY := loopy;
      end; // get mouse co-ords relative to tile

      SelectedTileAnchorX := ((SelectedTileX * TileWidth) + ((SelectedTileY mod 2) * (TileWidth div 2)) - xoffset);
      SelectedTileAnchorY := ((SelectedTileY * (TileHeight div 2)) + (TileHeight div 2) - yoffset);

    if  (WorldTileX <> SelectedTileX) or (WorldTileY <> SelectedTileY) then
    begin
      with BmpBuffer.Canvas do // highlite selected tile
      begin
        Draw(0,0,BackBuffer);
        pen.Color := clRed;
        moveto((SelectedTileX * TileWidth) + ((SelectedTileY mod 2) * (TileWidth div 2)) - xoffset,
          (SelectedTileY * (TileHeight div 2)) + (TileHeight div 2) - yoffset);
        lineto((SelectedTileX * TileWidth) + ((SelectedTileY mod 2) * (TileWidth div 2)) + (TileWidth div 2) - xoffset,
          (SelectedTileY * (TileHeight div 2)) + TileHeight - yoffset);
        lineto((SelectedTileX * TileWidth) + ((SelectedTileY mod 2) * (TileWidth div 2)) + TileWidth - xoffset,
          (SelectedTileY * (TileHeight div 2)) + (TileHeight div 2) - yoffset);
        lineto((SelectedTileX * TileWidth) + ((SelectedTileY mod 2) * (TileWidth div 2)) + (TileWidth div 2) - xoffset,
          (SelectedTileY * (TileHeight div 2)) - yoffset);
        lineto((SelectedTileX * TileWidth) + ((SelectedTileY mod 2) * (TileWidth div 2)) - xoffset,
          (SelectedTileY * (TileHeight div 2)) + (TileHeight div 2) - yoffset);
      end; // with
    end;
    WorldTileX := SelectedTileX;
    WorldTileY := SelectedTileY;

    UpdateStatusBar;

    //iMap.canvas.Draw(0,0,BmPBuffer);
end;


procedure TfrmMain.GetSelectedQuadTile(X: integer; Y: integer);
var
  tmpX: integer;
  tmpY: integer;
  tmpTileX: integer;
  tmpTileY: integer;
  loopx, loopy, // use for tile loop
  visx, visy, // first visible tile
  wx, wy: integer; // world x and y
  xoffset: integer;
  yoffset: integer;
begin

  xoffset :=  StartTileX * TileWidth -32;
  yoffset :=  (StartDiamondY * TileHalfHeight);

  MouseX := X;
  MouseY := Y;
  wx := xoffset + MouseX; // set world x,y
  wy := yoffset + MouseY;

  // *** cheap, fast and easy "What tile am I on...?"

  visx := isomax(0, wx div Tile2xWidth - 1); // guess what tile left
  visy := isomax(0, wy div (Tile2xHeight div 2) - 1); // guess what tile top
  for loopy := visy - 1 to // just loop through 9 tiles
    isomin(mapheight, visy + 1) do
    for loopx := visx - 1 to
      isomin(mapwidth, visx + 1) do
      if isoPointInQuad(
        (loopx * Tile2xWidth) + ((loopy mod 2) * (Tile2xWidth div 2)),
        (loopy * (Tile2xHeight div 2)) + (Tile2xHeight div 2)+TileHalfHeight,
        (loopx * Tile2xWidth) + ((loopy mod 2) * (Tile2xWidth div 2)) + (Tile2xWidth div 2),
        (loopy * (Tile2xHeight div 2)) + Tile2xHeight+TileHalfHeight,
        (loopx * Tile2xWidth) + ((loopy mod 2) * (Tile2xWidth div 2)) + Tile2xWidth,
        (loopy * (Tile2xHeight div 2)) + (Tile2xHeight div 2)+TileHalfHeight,
        (loopx * Tile2xWidth) + ((loopy mod 2) * (Tile2xWidth div 2)) + (Tile2xWidth div 2),
        (loopy * (Tile2xHeight div 2))+TileHalfHeight,
        wx, wy) then
      begin
        SelectedTileX := loopx ;
        SelectedTileY := loopy ;
      end; // get mouse co-ords relative to tile

      SelectedTileAnchorX := ((SelectedTileX * Tile2xWidth) + ((SelectedTileY mod 2) * (TileWidth)) - xoffset);
      SelectedTileAnchorY := ((SelectedTileY * (TileHeight)) + (TileHeight) - yoffset);

      if (WorldTileX <> StartTileX + (SelectedTileAnchorX div TileWidth)) or
         (WorldTileY <> StartDiamondY + (SelectedTileAnchorY div TilehalfHeight)) then
      begin
        with BmpBuffer.Canvas do // highlite selected tile
        begin
          Draw(0,0,BackBuffer);
          pen.Color := clRed;
          moveto((SelectedTileX * Tile2xWidth) + ((SelectedTileY mod 2) * (Tile2xWidth div 2)) - xoffset,
            ((SelectedTileY * (Tile2xHeight div 2)) + (Tile2xHeight div 2) - yoffset + TileHalfHeight));
          lineto((SelectedTileX * Tile2xWidth) + ((SelectedTileY mod 2) * (Tile2xWidth div 2)) + (Tile2xWidth div 2) - xoffset,
            (SelectedTileY * (Tile2xHeight div 2)) + Tile2xHeight - yoffset + TileHalfHeight);
          lineto((SelectedTileX * Tile2xWidth) + ((SelectedTileY mod 2) * (Tile2xWidth div 2)) + Tile2xWidth - xoffset,
            (SelectedTileY * (Tile2xHeight div 2)) + (Tile2xHeight div 2) - yoffset + TileHalfHeight);
          lineto((SelectedTileX * Tile2xWidth) + ((SelectedTileY mod 2) * (Tile2xWidth div 2)) + (Tile2xWidth div 2) - xoffset,
            (SelectedTileY * (Tile2xHeight div 2)) - yoffset + TileHalfHeight);
          lineto((SelectedTileX * Tile2xWidth) + ((SelectedTileY mod 2) * (Tile2xWidth div 2)) - xoffset,
            (SelectedTileY * (Tile2xHeight div 2)) + (Tile2xHeight div 2) - yoffset + TileHalfHeight);
        end; // with
      end;
      if  SelectedTileAnchorX = -32 then
          WorldTileX := 2
      else
          WorldTileX := StartTileX + (SelectedTileAnchorX div TileWidth);
      WorldTileY := StartDiamondY + (SelectedTileAnchorY div TilehalfHeight) ;

//    WorldTileX := SelectedTileX;
//    WorldTileY := SelectedTileY;
      UpdateStatusBar;
      iMap.canvas.Draw(0,0,BmPBuffer);
end;



procedure TfrmMain.GetSelectedBaseTile(X: integer; Y: integer);
var
  tmpX: integer;
  tmpY: integer;
  tmpTileX: integer;
  tmpTileY: integer;
begin

       MouseX := X-32;
       MouseY := Y+16;
       tmpTileY := Trunc((MouseY) / TileHeight);
       tmpTileX := Trunc((MouseX) / TileWidth);


       if  (tmpTileX <> SelectedTileX) or (tmpTileY <> SelectedTileY) then
       begin
           SelectedTileX := tmpTileX;
           SelectedTileY := tmpTileY;

           WorldTileX := StartTileX + SelectedTileX;
           WorldTileY := StartBaseY + SelectedTileY;

           if WorldTileY >= MapHeight then exit;
           if WorldTileX >= MapWidth then exit;

           SelectedTileAnchorX :=  SelectedTileX * TileWidth+32;
           SelectedTileAnchorY :=  SelectedTileY * TileHeight-16;

           UpdateStatusBar;

           if MousePaint then
           begin
                AddBaseTileToMap;
                RefreshScreen;
           end;

           //Draw Selected Tile
           BmpBuffer.Canvas.Draw(0,0,BackBuffer);
           BmpBuffer.Canvas.Pen.Color := clRed;
           tmpX := SelectedTileAnchorX;
           tmpY := SelectedTileAnchorY;
           BmpBuffer.Canvas.Moveto(tmpX,tmpY);
           //Top
           tmpX := tmpX + 64;
           BmpBuffer.Canvas.LineTo(tmpX,tmpY);
           //Right
           tmpY := tmpY + 32;
           BmpBuffer.Canvas.LineTo(tmpX,tmpY);
           //Bottom
           tmpX := tmpX - 64;
           BmpBuffer.Canvas.LineTo(tmpX,tmpY);
           //LEft
           tmpY := tmpY - 32;
           BmpBuffer.Canvas.LineTo(tmpX,tmpY);
           iMap.canvas.Draw(0,0,BmPBuffer);
      end;
end;

procedure TfrmMain.iMapMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  case EditMode of
    emTiles: MouseOverTiles(x,y);
    emSprites: MouseOverSprites(x,y);
    emStatics: MouseOverSprites(x,y);
//    emLights:MouseOverLights(x,y);
  end;
end;

procedure TfrmMain.MouseOverSprites(x: integer; y: integer);
var
crntSpriteAnchorY: integer;
crntSpriteAnchorX: integer;
crntSpriteX: integer;
crntSpriteY: integer;
crntWorldX: integer;
crntWorldY: integer;
begin
//  figure out which tile the mouse is on and select it
//        iMap.canvas.Draw(0,0,BmPBuffer);
        crntWorldX:= WorldTileX;
        crntWorldY:= WorldTileY;

        GetSelectedDiamondTile(x,y);

        if (WorldTileX <> crntWorldX) or (WorldTileY <> crntWorldY) then
        begin
            if ((StaticMode = smAddNew) or (SpriteMode = smSprite) or (SpriteMode = smCharacter))
               and Assigned(MouseImage) then
            begin
                crntSpriteX := WorldTileX - StartTileX;
                crntSpriteY := WorldTileY - StartDiamondY;

                if odd(crntSpriteY)then
                    crntSpriteAnchorX :=  (crntSpriteX * TileWidth) + TileHalfWidth
                else
                    crntSpriteAnchorX :=  (crntSpriteX * TileWidth );

                crntSpriteAnchorY := ((crntSpriteY * TileHalfHeight)+TileHalfHeight)- (MouseImage.height +iYoffSet);
                crntSpriteAnchorX := crntSpriteAnchorX + iXoffSet;
                //Dont draw sprites too far off screen
                //if (crntSpriteAnchorX < -64) or (crntSpriteAnchorX > 815) then exit;
                //if (crntSpriteAnchorY < -64) or (crntSpriteAnchorY > 700) then exit;
                BmpBuffer.Canvas.Draw(crntSpriteAnchorX,crntSpriteAnchorY, MouseImage);
            end;
            iMap.canvas.Draw(0,0,BmPBuffer);
        end;

end;

procedure TfrmMain.MouseOverTiles(x: integer; y: integer);
var
crntWorldX: integer;
crntWorldY: integer;
begin
    crntWorldX:= WorldTileX;
    crntWorldY:= WorldTileY;

//  figure out which tile the mouse is on and select it

  if cbSprite.checked or cbStatic.checked then
  begin
      GetSelectedDiamondTile(x,y);
      iMap.canvas.Draw(0,0,BmPBuffer);
  end
  else if cbCollision.checked then
  begin
        GetSelectedDiamondTile(x,y);
        if (crntWorldX <> WorldTileX) or (crntWorldY <> WorldTileY) then
        begin
            if MousePaint then
            begin
                  AddCollisionTileToMap;
                  RefreshScreen;
            end
            else iMap.canvas.Draw(0,0,BmPBuffer);
        end;
  end
  else if cbStart.checked then
  begin
        GetSelectedDiamondTile(x,y);
        if (crntWorldX <> WorldTileX) or (crntWorldY <> WorldTileY) then
        begin
            if MousePaint then
            begin
                  AddStartTileToMap;
                  RefreshScreen;
            end
            else iMap.canvas.Draw(0,0,BmPBuffer);
        end;
  end
  else if cbDiamond.checked then
      begin
        case DiamondType of
        dtSingle:
              begin
                  GetSelectedDiamondTile(x,y);
                  if (crntWorldX <> WorldTileX) or (crntWorldY <> WorldTileY) then
                  begin
                      if MousePaint then
                      begin
                        AddSingleDiamondTileToMap;
                        RefreshScreen;
                      end
                      else iMap.canvas.Draw(0,0,BmPBuffer);
                  end;
              end;
         dtQuad:
              begin
                  GetSelectedQuadTile(x,y);
                  if (crntWorldX <> WorldTileX) or (crntWorldY <> WorldTileY) then
                  begin
                      if MousePaint then
                      begin
                        AddQuadDiamondTileToMap;
                        RefreshScreen;
                      end
                      else iMap.canvas.Draw(0,0,BmPBuffer);
                  end;
              end;
        end;
      end
  else if cbBase.checked then
  GetSelectedBaseTile(x,y);
end;


procedure TfrmMain.iMapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var
  MyObject: TGameObject;
begin
     frmMain.ActiveControl := nil;
     //clear tile
     if (Button = mbRight) and (ssShift in Shift) then
     begin
          case EditMode of
            emTiles:
                begin
                    if cbCollision.checked then
                       RemoveCollisionTileFromMap
                    else if cbStart.checked then
                       RemoveStartTileFromMap
                    else if cbDiamond.Checked then
                       RemoveDiamondTileFromMap
                    else if cbBase.checked then
                       RemoveBaseTileFromMap;
                end;
            end;
             RefreshScreen;
             exit;
     end;

     if (Button = mbRight) and not(ssShift in Shift) then
     begin
          case EditMode of
            emTiles:
                begin
                    if cbCollision.checked then
                       //RemoveCollisionTileFromMap
                    else if cbDiamond.Checked then
                       popTile.Popup(iMap.left + X , Panel3.top + Y + 30)
                    else if cbBase.checked then
                        //  RemoveBaseTileFromMap;
                end;
            emSprites,
            emStatics:
                begin
                   if bLockAddMode then
                   begin
                      bLockAddMode := false;
                      MouseImage.FreeImage;
                      MouseImage.free;
                      MouseImage := nil;
                      iMap.Cursor := crDefault;
                      CopyObject := nil;
                      case EditMode of
                        emSprites:
                            begin
                                 SpriteMode := smNone;
                                 tvSpriteList.Selected := nil;
                                 iMap.Cursor := crDefault;
                            end;
                        emStatics:
                            begin
                                 StaticMode := smEdit;
                                 tvStaticList.Selected := nil;
                                 iMap.Cursor := crDefault;
                            end;
                      end;
                     // RefreshScreen;
                   end
                   else
                   if SelectedList.count > 0 then
                   begin//Look for selected Sprites
                        MyObject :=  GetObjectAt(ObjectList, WorldTileX,WorldTileY);
                        if MyObject <> nil then
                        begin //Get the sprite int he current spot
                             if TestForSelected(MyObject) then //see if he is selected
                             begin
                                SetupPopUp(MyObject);
                                popupMenu.Popup(Panel3.left + X , Panel3.top + Y + 30);
                             end
                             else
                             begin //New Selection
                                 SelectedList.Clear;
                                 SelectedList.add(MyObject);

                                 case MyObject.MyType of
                                   otStatic:
                                       frmNPCProp.SetupStatic(SelectedList);
                                   otSprite:
                                       frmNPCProp.SetupSprite(SelectedList);
                                   otLight:
                                       frmNPCProp.SetupSprite(SelectedList);
                                 end;
                                 //RefreshScreen;
                                 SetupPopUp(MyObject);
                                 popupMenu.Popup(Panel3.left + X, Panel3.top + Y + 30);
                             end;
                        end
                        else
                        begin //Go with what is selected
                           SetupPopUp(TGameObject(SelectedList.items[0]));
                           popupMenu.Popup(Panel3.left + X,Panel3.top + Y + 20)
                        end;
                   end
                   else
                   begin   //See if there is a sprite here to selected
                        MyObject :=  GetObjectAt(ObjectList, WorldTileX,WorldTileY);
                        if MyObject <> nil then
                        begin  //select and edit the current sprite;
                             SelectedList.add(MyObject);
                             case MyObject.MyType of
                             otStatic:
                                 frmNPCProp.SetupStatic(SelectedList);
                             otSprite:
                                 frmNPCProp.SetupSprite(SelectedList);
                             otLight:
                                 frmNPCProp.SetupSprite(SelectedList);
                             end;
                             //RefreshScreen;
                             SetupPopUp(MyObject);
                             popupMenu.Popup(Panel3.left + X,Panel3.top + Y + 20)
                        end;
                   end;
                end;
          end;
          RefreshScreen;
          exit;
     end;

     //Select the image in the current spot
     if (Button = mbLeft) and (ssShift in Shift) then
     begin
          if (EditMode = emSprites) or (EditMode = emStatics) then
          begin
            MyObject :=  GetObjectAt(ObjectList, WorldTileX,WorldTileY);
            if MyObject = Nil then
              MyObject :=  GetImageAt(ObjectList, x,y);
            if MyObject <> nil then
            begin
                 if SelectedList.count > 0 then
                 begin//only select if they are the same
                   if MyObject.MyType = TGameObject(SelectedList.items[0]).MyType then
                      SelectedList.add(MyObject);
                   end
                 else
                     SelectedList.add(MyObject);

                 frmNPCProp.SetupSprite(SelectedList);
                 RefreshScreen;
                 exit;
            end;
          end;
     end;

     //Place the image in the current spot
     if (Button = mbLeft) and not(ssShift in Shift)then
     begin
       case EditMode of
          emTiles:
              begin
                  if cbCollision.checked then
                     AddCollisionTileToMap
                  else if cbStart.checked then
                     AddStartTileToMap
                  else if cbDiamond.Checked then
                  begin
                       if DiamondType = dtQuad then
                        AddQuadDiamondTileToMap
                       else
                        AddSingleDiamondTileToMap;
                  end
                  else if cbBase.checked then
                        AddBaseTileToMap;
                  MousePaint := true;
              end;
          emSprites:
              begin
                   case SpriteMode of
                     smCharacter: AddCharacterToMap;
                     smSprite: AddSpriteToMap;
                     smParticles:AddParticleToMap;
                     smEditor:
                         begin
                              case EditorMode of
                                erStart: AddStartPointToMap;
                                erPath:;
                                erLight: AddLightToMap;
                              end;
                         end;
                     else
                          begin  //Im not adding so try to select
                              MyObject :=  GetObjectAt(ObjectList, WorldTileX,WorldTileY);
                              if MyObject = Nil then
                                 MyObject :=  GetImageAt(ObjectList, x,y);
                              if MyObject <> nil then
                              begin //select teh current sprite
                                   SelectedList.Clear;
                                   SelectedList.add(MyObject);
                                   case MyObject.MyType of
                                   otStatic:
                                       frmNPCProp.SetupStatic(SelectedList);
                                   otSprite:
                                       frmNPCProp.SetupSprite(SelectedList);
                                   otLight:
                                       frmNPCProp.SetupSprite(SelectedList);
                                   end;

                                  // RefreshScreen;
                              end //Left click on nothing clear select
                              else SelectedList.Clear;
                          end;
                   end;
                   if not(ssCtrl in Shift) and Not(bLockAddMode) then
                   begin
                      SpriteMode := smNone;
                      EditorMode := erNone;
                      tvSpriteList.Selected := nil;
                      iMap.Cursor := crDefault;

                   end;
              end;
          emStatics:
              begin
                   case StaticMode of
                        smEdit:
                          begin  //Im not adding so try to select
                              MyObject :=  GetObjectAt(ObjectList, WorldTileX,WorldTileY);
                              if MyObject = Nil then
                                 MyObject :=  GetImageAt(ObjectList, x,y);
                              if MyObject <> nil then
                              begin //select teh current sprite
                                   SelectedList.Clear;
                                   SelectedList.add(MyObject);
                                   case MyObject.MyType of
                                   otStatic:
                                       frmNPCProp.SetupStatic(SelectedList);
                                   otSprite:
                                       frmNPCProp.SetupSprite(SelectedList);
                                   otLight:
                                       frmNPCProp.SetupSprite(SelectedList);
                                   end;
                                  //RefreshScreen;
                              end //Left click on nothing clear select
                              else SelectedList.Clear;
                          end;
                        smAddNew: AddStaticToMap;
                   end;
                   if not(ssCtrl in Shift) and Not(bLockAddMode) then
                   begin
                      StaticMode := smEdit;
                      tvStaticList.Selected := nil;
                      iMap.Cursor := crDefault;
                   end;
              end;
        end;
          RefreshScreen;
          exit;
     end;
end;

procedure TfrmMain.SetupPopUp(MyObject: TGameObject);
begin
     SetLayer1.enabled := true;
     if MyObject.MyType = otSprite then
     begin
          Facing1.Enabled := true;
     end
     else
     begin
          Facing1.Enabled := false;
     end;
     if MyObject.MyType = otLight then
        SetLayer1.enabled := false;
end;

function TfrmMain.TestForSelected(MyObject: TGameObject): boolean;
var
iLoop: integer;
rtn: boolean;
begin
    rtn:= false;
    for iLoop := 0 to SelectedList.count -1 do
    begin
        if TGameObject(SelectedList.Items[iLoop]) = MyObject then
           rtn := true;
    end;
    Result := rtn;
end;

procedure TfrmMain.RemoveDiamondTileFromMap;
begin
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;
     DiamondLayer[WorldTileY, WorldTileX] := 0;
end;

procedure TfrmMain.RemoveBaseTileFromMap;
begin
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;
     BaseLayer[WorldTileY, WorldTileX] := 0;
end;

procedure TfrmMain.RemoveCollisionTileFromMap;
begin
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;
     CollisionLayer[WorldTileY, WorldTileX] := 0;
end;

procedure TfrmMain.RemoveStartTileFromMap;
begin
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;
     StartLayer[WorldTileY, WorldTileX] := 0;
end;

procedure TfrmMain.AddSingleDiamondTileToMap;
var
   NewTile: TTile;
   iLoop: integer;
   bFound: boolean;
   iTileID: integer;
   RndNum: integer;
begin
     bFound := false;
     iTileID := 0;
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;
     if WorldTileY <= 0 then exit;
     if WorldTileX <= 0 then exit;

     if RandomTileList.Count = 0 then exit;
     RndNum := random(RandomTileList.Count-1);
     LoadTileByName(RandomTileList.Strings[RndNum]);
     // Loop throught the tile lists looking for the existing tile
     for iloop := 0 to DiamondTileList.Count -1 do
     begin
          if LowerCase(TTile(DiamondTileList.Items[iLoop]).FileName) = SelectTileName then
          begin  //Found the Tile
               bFound := true;
               iTileID := TTile(DiamondTileList.Items[iLoop]).ID;
          end;
     end;

     if not(bFound) then
     begin
          imDiamondTiles.AddImage2(TileImage);
          NewTile := TTile.Create;
          NewTile.FileName := SelectTileName;
          NewTile.ID :=  imDiamondTiles.ImageCount -1;
          iTileID := NewTile.ID;
          DiamondTileList.add(NewTile);
     end;
     DiamondLayer[WorldTileY, WorldTileX] := iTileID;
end;

procedure TfrmMain.AddQuadDiamondTileToMap;
begin
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;
     if WorldTileY < 0 then exit;
     if WorldTileX < 0 then exit;

     QuadCollection.AddQuadTile(WorldTileX,WorldTileY);

end;


procedure TfrmMain.AddCollisionTileToMap;
begin
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;
     if WorldTileY <= 0 then exit;
     if WorldTileX <= 0 then exit;

     CollisionLayer[WorldTileY, WorldTileX] := 1;
end;

procedure TfrmMain.AddStartTileToMap;
begin
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;
     if WorldTileY <= 0 then exit;
     if WorldTileX <= 0 then exit;
     if rbStart.ItemIndex = 0 then
        StartLayer[WorldTileY, WorldTileX] := 1
     else
        StartLayer[WorldTileY, WorldTileX] := 2;
end;

procedure TfrmMain.AddCharacterToMap;
var
  NewNPC: TSprite;
begin
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;
     if WorldTileY <= 0 then exit;
     if WorldTileX <= 0 then exit;

     if not Assigned(CopyObject) then
     begin
         NewNPC := TSprite.Create;
         NewNPC.SpriteType := stNPC;
         //NewNPC.FileName := 'resources\\Data\\characters\\' +tvSpriteList.Selected.Text + '.dat';
         NewNPC.DisplayName := tvSpriteList.Selected.Text;
         NewNPC.ISO_ID :=  tvSpriteList.Selected.ImageIndex;
         NewNPC.GenerateGUID;
         //NewNPC.ID := ObjectList.Count;
         NewNPC.PhyResist := '0.0';
         NewNPC.MagResist := '0.0';
         NewNPC.Facing := 0;
         NewNPC.Layer := 2;
         NewNPC.GroupID := PlaceGroup;
         NewNPC.GroupIndx := -1;
         NewNPC.x := WorldTileX;
         NewNPC.y := WorldTileY;
         NewNPC.Red := -1;
         NewNPC.Blue := -1;
         NewNPC.Green := -1;
         NewNPC.Blend := -1;
         NewNPC.Movement := 6;
         NewNPC.SpellID := 1100;
         NewNPC.Image := TBitMap.Create;
         NewNPC.Image.TransparentColor := clwhite;//tmColor;
         NewNPC.Image.TransparentMode := tmFixed;
         NewNPC.Image.Transparent := true;
         NewNPC.Image.Height :=ImgPreview.Picture.bitmap.height;
         NewNPC.Image.Width := ImgPreview.Picture.bitmap.width;
         NewNPC.Image.Canvas.Draw(0,0,ImgPreview.Picture.bitmap);
         NewNPC.Image.Dormant;
     end
     else
     begin
         NewNPC := TSprite.Create;
         NewNPC.SpriteType := TSprite(CopyObject).SpriteType;
         //NewNPC.FileName := CopyObject.FileName;
         NewNPC.DisplayName := TSprite(CopyObject).DisplayName;
         NewNPC.Facing:= TSprite(CopyObject).Facing;
         NewNPC.ISO_ID :=  TSprite(CopyObject).ISO_ID;
         NewNPC.GenerateGUID;
         NewNPC.SpellID := TSprite(CopyObject).SpellID;
         NewNPC.Layer := TSprite(CopyObject).Layer;
         NewNPC.Movement := TSprite(CopyObject).Movement;
         //NewNPC.ID := ObjectList.Count;
         NewNPC.GroupID := CopyObject.GroupID ;
         NewNPC.GroupIndx := CopyObject.GroupIndx ;
         NewNPC.x := WorldTileX;
         NewNPC.y := WorldTileY;
         NewNPC.offSetX := CopyObject.offSetX;
         NewNPC.offSetY := CopyObject.offSetY;
         NewNPC.Image := TBitMap.Create;
         NewNPC.Image.TransparentColor := clwhite;//tmColor;
         NewNPC.Image.TransparentMode := tmFixed;
         NewNPC.Image.Transparent := true;
         NewNPC.Image.Assign(CopyObject.Image);

         //TODO JAH
         // copy NPC Stuff too
     end;


     ObjectList.add(NewNPC);
     SortSpriteList(ObjectList);
end;

procedure TfrmMain.AddStaticToMap;
var
  NewStatic: TStatic;
begin
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;
     if WorldTileY <= 0 then exit;
     if WorldTileX <= 0 then exit;
     if not Assigned(CopyObject) then
     begin
       NewStatic := TStatic.Create;
       //NewStatic.FileName := 'resources\\Data\\Static\\' +tvStaticList.Selected.Parent.text;
       NewStatic.DisplayName := tvStaticList.Selected.text;
       NewStatic.ISO_ID := tvStaticList.Selected.ImageIndex;
       //NewStatic.ID := ObjectList.Count;
       NewStatic.Frame := tvStaticList.Selected.text;
       NewStatic.GenerateGUID;
       NewStatic.Layer := 2;
       NewStatic.GroupID := PlaceGroup;
       NewStatic.GroupIndx := -1;
       NewStatic.x := WorldTileX;
       NewStatic.y := WorldTileY;
       NewStatic.offSetX := iXoffSet;
       NewStatic.offSetY := iYoffSet;
       NewStatic.Length := iImageTileLength;
       NewStatic.Width := iImageTileWidth;
       NewStatic.Red := -1;
       NewStatic.Blue := -1;
       NewStatic.Green := -1;
       NewStatic.Blend := -1;
       NewStatic.Shadow := true;
  //     NewStatic.offSetX := 0;
  //     NewStatic.offSetY := 0;
       NewStatic.Image := TBitMap.Create;
       NewStatic.Image.TransparentColor := clwhite;//tmColor;
       NewStatic.Image.TransparentMode := tmFixed;
       NewStatic.Image.Transparent := true;
       NewStatic.Image.Height :=ImgPreview.Picture.bitmap.height;
       NewStatic.Image.Width := ImgPreview.Picture.bitmap.width;
       NewStatic.Image.Canvas.Draw(0,0,ImgPreview.Picture.bitmap);
       NewStatic.Image.Dormant;
     end
     else
     begin
       NewStatic := TStatic.Create;
       //NewStatic.FileName := CopyObject.FileName;
       NewStatic.ISO_ID := CopyObject.ISO_ID;
       NewStatic.DisplayName := CopyObject.DisplayName;
       NewStatic.GenerateGUID;
       NewStatic.Layer := TStatic(CopyObject).Layer;
       //NewStatic.ID := ObjectList.Count;
       NewStatic.GroupID := CopyObject.GroupID ;
       NewStatic.Frame := TStatic(CopyObject).Frame ;
       NewStatic.GroupIndx := CopyObject.GroupIndx ;
       NewStatic.x := WorldTileX;
       NewStatic.y := WorldTileY;
       NewStatic.offSetX := CopyObject.offSetX;
       NewStatic.offSetY := CopyObject.offSetY;
       NewStatic.Length := TStatic(CopyObject).length;
       NewStatic.Width := TStatic(CopyObject).width;
       NewStatic.Image := TBitMap.Create;
       NewStatic.Image.TransparentColor := clwhite;//tmColor;
       NewStatic.Image.TransparentMode := tmFixed;
       NewStatic.Image.Transparent := true;
       NewStatic.Image.Assign(CopyObject.Image);
       NewStatic.Shadow := TStatic(CopyObject).shadow;
     end;

     ObjectList.add(NewStatic);
     SortSpriteList(ObjectList);
end;

procedure TfrmMain.AddSpriteToMap;
var
  NewSprite: TSprite;
begin
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;
     if not Assigned(CopyObject) then
     begin
         NewSprite := TSprite.Create;
         NewSprite.SpriteType := stSprite;
         //NewSprite.FileName := 'resources\\Data\\sprites\\' +tvSpriteList.Selected.Text + '.dat';
         NewSprite.ISO_ID := tvSpriteList.Selected.ImageIndex;
         NewSprite.DisplayName := tvSpriteList.Selected.text;
         NewSprite.GenerateGUID;
         NewSprite.Layer := 2;
         //NewSprite.ID := ObjectList.Count;
         NewSprite.GroupID := PlaceGroup;
         NewSprite.GroupIndx := -1;
         NewSprite.x := WorldTileX;
         NewSprite.y := WorldTileY;
         NewSprite.Red := -1;
         NewSprite.Blue := -1;
         NewSprite.Green := -1;
         NewSprite.Blend := -1;
         NewSprite.Image := TBitMap.Create;
         NewSprite.Image.TransparentColor := clwhite;//tmColor;
         NewSprite.Image.TransparentMode := tmFixed;
         NewSprite.Image.Transparent := true;
         NewSprite.Image.Height :=ImgPreview.Picture.bitmap.height;
         NewSprite.Image.Width := ImgPreview.Picture.bitmap.width;
         NewSprite.Image.Canvas.Draw(0,0,ImgPreview.Picture.bitmap);
         NewSprite.Image.Dormant;
     end
     else
     begin
         NewSprite := TSprite.Create;
         NewSprite.SpriteType := TSprite(CopyObject).SpriteType;
         //NewSprite.FileName := CopyObject.FileName;
         NewSprite.ISO_ID := CopyObject.ISO_ID;
         NewSprite.DisplayName := CopyObject.DisplayName;
         NewSprite.GenerateGUID;
         NewSprite.Layer := TSprite(CopyObject).Layer;
         //NewSprite.ID := ObjectList.Count;
         NewSprite.GroupID := CopyObject.GroupID ;
         NewSprite.GroupIndx := CopyObject.GroupIndx ;
         NewSprite.x := WorldTileX;
         NewSprite.y := WorldTileY;
         NewSprite.offSetX := CopyObject.offSetX;
         NewSprite.offSetY := CopyObject.offSetY;
         NewSprite.Image := TBitMap.Create;
         NewSprite.Image.TransparentColor := clwhite;//tmColor;;
         NewSprite.Image.TransparentMode := tmFixed;
         NewSprite.Image.Transparent := true;
         NewSprite.Image.Assign(CopyObject.Image);
     end;

     ObjectList.add(NewSprite);
     SortSpriteList(ObjectList);
end;

procedure TfrmMain.AddStartPointToMap;
var
  NewStartPoint: TSprite;
begin
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;

     if not Assigned(CopyObject) then
     begin
         NewStartPoint := TSprite.Create;
         NewStartPoint.SpriteType := stStart;
         NewStartPoint.DisplayName := 'StartPoint';
         //NewStartPoint.ID := ObjectList.Count;
         NewStartPoint.GenerateGUID;
         NewStartPoint.Facing := 0;
         NewStartPoint.Layer := 2;
         NewStartPoint.GroupID := PlaceGroup;
         NewStartPoint.GroupIndx := -1;
         NewStartPoint.x := WorldTileX;
         NewStartPoint.y := WorldTileY;
     end
     else
     begin
         NewStartPoint := TSprite.Create;
         NewStartPoint.SpriteType := TSprite(CopyObject).SpriteType;
         NewStartPoint.DisplayName := CopyObject.DisplayName;
        // NewStartPoint.ID := ObjectList.Count;
         NewStartPoint.GenerateGUID;
         NewStartPoint.Layer := 2;
         NewStartPoint.Facing := TSprite(CopyObject).Facing;
         NewStartPoint.GroupID := CopyObject.GroupID ;
         NewStartPoint.GroupIndx := CopyObject.GroupIndx ;
         NewStartPoint.x := WorldTileX;
         NewStartPoint.y := WorldTileY;
     end;

     ObjectList.add(NewStartPoint);
     SortSpriteList(ObjectList);
end;

procedure TfrmMain.AddLightToMap;
var
  NewLight: TLight;
begin
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;

     if not Assigned(CopyObject) then
     begin
         NewLight := TLight.Create;
         NewLight.ISO_ID := ObjectList.Count;
         NewLight.GenerateGUID;
         NewLight.GroupID := PlaceGroup;
         NewLight.GroupIndx := -1;
         NewLight.x := WorldTileX;
         NewLight.y := WorldTileY;
         NewLight.flicker := 0;
         NewLight.width := 256;
         NewLight.Height := 256;
     end
     else
     begin
         NewLight := TLight.Create;
         NewLight.ISO_ID := CopyObject.ISO_ID;
         NewLight.GenerateGUID;
         NewLight.GroupID := CopyObject.GroupID ;
         NewLight.GroupIndx := CopyObject.GroupIndx ;
         NewLight.x := WorldTileX;
         NewLight.y := WorldTileY;
         NewLight.flicker := TLight(CopyObject).flicker;
         NewLight.width := TLight(CopyObject).width;
         NewLight.Height := TLight(CopyObject).height;
     end;
     ObjectList.add(NewLight);
end;

procedure TfrmMain.AddParticleToMap;
var
  NewParticle: TSprite;
begin
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;

     if not Assigned(CopyObject) then
     begin
         NewParticle := TSprite.Create;
         NewParticle.SpriteType := stParticle;
         //NewParticle.FileName := 'resources\\Data\\sprites\\' +tvSpriteList.Selected.Text + '.psi';
         NewParticle.DisplayName := tvSpriteList.Selected.Text;
         NewParticle.GenerateGUID;
         //NewParticle.ID := ObjectList.Count;
         NewParticle.Facing := 0;
         NewParticle.GroupID := PlaceGroup;
         NewParticle.GroupIndx := -1;
         NewParticle.x := WorldTileX;
         NewParticle.y := WorldTileY;
     end
     else
     begin
         NewParticle := TSprite.Create;
         NewParticle.SpriteType := TSprite(CopyObject).SpriteType;
         //NewParticle.FileName := CopyObject.FileName;
         NewParticle.DisplayName := CopyObject.DisplayName;
         NewParticle.GenerateGUID;
         //NewParticle.ID := ObjectList.Count;
         NewParticle.Facing := TSprite(CopyObject).Facing;
         NewParticle.GroupID := CopyObject.GroupID ;
         NewParticle.GroupIndx := CopyObject.GroupIndx ;
         NewParticle.x := WorldTileX;
         NewParticle.y := WorldTileY;
     end;

     ObjectList.add(NewParticle);
     SortSpriteList(ObjectList);
end;

procedure TfrmMain.AddBaseTileToMap;
var
   NewTile: TTile;
   iLoop: integer;
   bFound: boolean;
   iTileID: integer;
   RndNum: integer;
begin
     bFound := false;
     iTileID := 0;
     if WorldTileY >= MapHeight then exit;
     if WorldTileX >= MapWidth then exit;
     if WorldTileY <= 0 then exit;
     if WorldTileX <= 0 then exit;
     if RandomTileList.Count = 0 then exit;
     RndNum := random(RandomTileList.Count-1);
     LoadTileByName(RandomTileList.Strings[RndNum]);
     // Loop throught the tile lists looking for the existing tile
     for iloop := 0 to BaseTileList.Count -1 do
     begin
          if LowerCase(TTile(BaseTileList.Items[iLoop]).FileName) = SelectTileName then
          begin  //Found the Tile
               bFound := true;
               iTileID := TTile(BaseTileList.Items[iLoop]).ID;
          end;
     end;

     if not(bFound) then
     begin
          imBaseTiles.AddImage2(TileImage);
          NewTile := TTile.Create;
          NewTile.FileName := SelectTileName;
          NewTile.ID :=  imBaseTiles.ImageCount -1;
          iTileID := NewTile.ID;
          BaseTileList.add(NewTile);
     end;

     BaseLayer[WorldTileY, WorldTileX] := iTileID;
end;


procedure TfrmMain.FormCreate(Sender: TObject);
var
   NewTile: TTile;
begin
   Top := 0;
   Left := 0;
   iEncounterID := 0;
   MapLoading := false;
   Randomize;
   LoadIniFile;

    //Buffer to preven flicker
   BmpBuffer := TBitmap.Create;
//   bmpBuffer.PixelFormat := pf32bit;
   BmpBuffer.Height := 627;
   BmpBuffer.Width := 858;
   BmpBuffer.canvas.TextFlags := ETO_OPAQUE;
   // To cut down on redraws for mouse moves
   BackBuffer := TBitmap.Create;
//   BackBuffer.PixelFormat := pf32bit;
   BackBuffer.Height := 627;
   BackBuffer.Width := 858;
   BackBuffer.canvas.TextFlags := ETO_OPAQUE;
   //Default Globals
   GameScreenX := 2; //tiles
   GameScreenY := 5; //tiles
   MapHeight := 44;
   MapWidth := 18;
   TileWidth := 64;
   TileHeight := 32;
   TileHalfWidth := TileWidth div 2;
   TileHalfHeight := TileHeight div 2;
   Tile2xWidth :=  TileWidth * 2;
   Tile2xHeight :=  TileHeight * 2;
   ScrollBarY.Max  := MapHeight -36;
   ScrollBarX.Max  := MapWidth -12;
   CreateMap(MapWidth,MapHeight);
   PlaceGroup := -1;
   LoadEditorImages;
   //will hold all images
   MainImgMngr := TImageManager.Create;
   MainImgMngr.MaxImageCache := 32;
   //Will hold the tiles currently in use
   imDiamondTiles := TImageManager.Create;
   imDiamondTiles.MaxImageCache := 32;
   imBaseTiles  := TImageManager.Create;
   imBaseTiles.MaxImageCache := 32;
   //This is the leading blank tile
   AddTileZero;

   //More default Setting
   bgColor := clBlack;
   gColor := clTeal;

   StartTileX := 3;
   StartBaseY := 2;
   StartDiamondY := 4;
   EditMode := emTiles;
   SpriteMode := smNone;
   StaticMode := smEdit;
   DiamondType := dtSingle;
   DiamondTileList := TList.Create;
   BaseTileList := TList.create;
   RandomTileList := TStringList.Create;
   FacingsList := TStringList.Create;
   ScriptList := TStringList.Create;
   ObjectList := TList.Create;
   SelectedList := TList.Create;
   PageControl1.ActivePage := tsTiles;
   RefreshScreen; //Draw the first grid
   MousePaint := false;
   QuadCollection := TQuadCollection.Create;
   FacingsList.Add('NE');
   FacingsList.Add('NW');
   FacingsList.Add('SE');
   FacingsList.Add('SW');
   BuildScript('NewMap.map');
   MapPropeties.MapName := 'New Map';
   MapPropeties.LightLevel := 100;
   MapPropeties.LightColor := 0;
   MapPropeties.MapType := 2;//multiplayer map
   MapPropeties.MapDesc := '';
   MapPropeties.ScriptFile := '';
   MapPropeties.UseShadows := true;
   MapPropeties.CloudBlend := 0;
   MapPropeties.WindDirect := 0;
   MapPropeties.SnowFlakes := 0;
   MapPropeties.FogType := 0;
   MapPropeties.FogColor := 0;
   MapPropeties.FogBlend := 0;
   MapPropeties.FogText := 0;
   MapPropeties.WalkSfx := 30;
   MapPropeties.ArmySize := 5;

end;

procedure TfrmMain.LoadEditorImages;
begin

   bmpCollison := TBitMap.Create;
   bmpCollison.TransparentMode := tmAuto;
   bmpCollison.Transparent := true;
   bmpCollison.LoadFromFile(strEditorIconPath + 'Collision.bmp');
   bmpCollison.Dormant;

   bmpSideOne := TBitMap.Create;
   bmpSideOne.TransparentMode := tmAuto;
   bmpSideOne.Transparent := true;
   bmpSideOne.LoadFromFile(strEditorIconPath + 'SideOne.bmp');
   bmpSideOne.Dormant;

   bmpSideTwo := TBitMap.Create;
   bmpSideTwo.TransparentMode := tmAuto;
   bmpSideTwo.Transparent := true;
   bmpSideTwo.LoadFromFile(strEditorIconPath + 'SideTwo.bmp');
   bmpSideTwo.Dormant;

   bmpOccupied := TBitMap.Create;
   bmpOccupied.TransparentMode := tmAuto;
   bmpOccupied.Transparent := true;
   bmpOccupied.LoadFromFile(strEditorIconPath + 'Occupied.bmp');
   bmpOccupied.Dormant;

   bmpPlaceHolder := TBitMap.Create;
   bmpPlaceHolder.TransparentMode := tmAuto;
   bmpPlaceHolder.Transparent := true;
   bmpPlaceHolder.LoadFromFile(strEditorIconPath + 'PlaceHolder.bmp');
   bmpPlaceHolder.Dormant;

   bmpPopOff := TBitMap.Create;
   bmpPopOff.TransparentMode := tmAuto;
   bmpPopOff.Transparent := true;
   bmpPopOff.LoadFromFile(strEditorIconPath + 'PopOff.bmp');
   bmpPopOff.Dormant;

   bmpTrigger := TBitMap.Create;
   bmpTrigger.TransparentMode := tmAuto;
   bmpTrigger.Transparent := true;
   bmpTrigger.LoadFromFile(strEditorIconPath + 'Trigger.bmp');
   bmpTrigger.Dormant;

   bmpBlankNPC := TBitMap.Create;
   bmpBlankNPC.TransparentMode := tmAuto;
   bmpBlankNPC.Transparent := true;
   bmpBlankNPC.LoadFromFile(strEditorIconPath + 'BlankCharacter.bmp');
   bmpBlankNPC.Dormant;

   bmpSelected := TBitMap.Create;
   bmpSelected.TransparentMode := tmAuto;
   bmpSelected.Transparent := true;
   bmpSelected.LoadFromFile(strEditorIconPath + 'Selected.bmp');
   bmpSelected.Dormant;

   bmpParticles := TBitMap.Create;
   bmpParticles.TransparentMode := tmAuto;
   bmpParticles.Transparent := true;
   bmpParticles.LoadFromFile(strEditorIconPath + 'Particles.bmp');
   bmpParticles.Dormant;

   bmpLight := TBitMap.Create;
   bmpLight.TransparentMode := tmAuto;
   bmpLight.Transparent := true;
   bmpLight.LoadFromFile(strEditorIconPath + 'light.bmp');
   bmpLight.Dormant;

end;

procedure TfrmMain.AddTileZero;
var
   bmpZero: TBitmap;
   fileName: string;
begin
     fileName := strEditorIconPath + 'BlankTile.bmp';

     if fileExists(fileName) then
     begin
          bmpZero := TBitmap.Create;
//          bmpZero.PixelFormat := pf32bit;
          bmpZero.LoadFromFile(fileName);
          bmpZero.Dormant;
          imDiamondTiles.AddImage2(bmpZero);
          imBaseTiles.AddImage2(bmpZero);
          bmpZero.FreeImage;
          bmpZero.free;
     end;

end;


procedure TfrmMain.RefreshScreen;
begin
     if not Drawing then
     begin
         Drawing := true;
         if MapLoading then exit;
            //Clear the buffer
         BmpBuffer.Canvas.Brush.Color := bgColor;
         BmpBuffer.Canvas.FillRect(Rect(0,0,858,627));

         if cbBase.checked then
            RenderBaseTiles;
         if cbDiamond.checked then
         begin
            RenderDiamondTiles;
            RenderQuadTiles;
         end;
         if cbCollision.checked then
            RenderCollisionTiles;
         if cbStart.checked then
            RenderStartTiles;
         if rgGrid.ItemIndex = 0 then
           DrawRectangle(BmpBuffer);
         if rgGrid.ItemIndex = 1 then
           DrawDiamond(BmpBuffer);
         if cbSprite.Checked or cbStatic.checked or cbLight.Checked then
            RenderGameObjects;
         DrawGameScreen(BmpBuffer);
         //Flip the buffer
         iMap.canvas.Draw(0,0,BmPBuffer);
         //Make a backup
         BackBuffer.Canvas.Draw(0,0,BmPBuffer);
         Drawing := false;
        // Application.processmessages();
     end;
end;

{
procedure TfrmMain.LoadCharacterTreeData(Filename: string);
var
strTmp: string;
iLoop: integer;
RootItem: TTreeNTNode;
NodeExists: Boolean;
begin

       RootItem := CharacterRoot;
       strTmp := ChangeFileExt(ExtractFileName(FileName),'');
       NodeExists := false;
       if RootItem.HasChildren then
       begin
         //search through the children
         for iLoop:= 0 to RootItem.Count -1 do
         begin
             if RootItem.Item[iLoop].text = strTmp then
             begin
                NodeExists:= true;
                Break;
             end;
         end;
       end;
       if Not(NodeExists) then
       begin
           tvSpriteList.Items.AddChild(RootItem,strTmp);
       end;
end;
}


procedure TfrmMain.LoadEditorTreeData;
var
RootItem: TTreeNTNode;
begin
       RootItem := EditorRoot;
       tvSpriteList.Items.AddChild(RootItem,'Start Point');
       tvSpriteList.Items.AddChild(RootItem,'Path Corner');
       tvSpriteList.Items.AddChild(RootItem,'Light');
end;

procedure TfrmMain.LoadParticleTreeData(Filename: string);
var
strTmp: string;
iLoop: integer;
RootItem: TTreeNTNode;
NodeExists: Boolean;
begin

       RootItem := ParticleRoot;
       strTmp := ChangeFileExt(ExtractFileName(FileName),'');
       NodeExists := false;
       if RootItem.HasChildren then
       begin
         //search through the children
         for iLoop:= 0 to RootItem.Count -1 do
         begin
             if RootItem.Item[iLoop].text = strTmp then
             begin
                NodeExists:= true;
                Break;
             end;
         end;
       end;
       if Not(NodeExists) then
       begin
           tvSpriteList.Items.AddChild(RootItem,strTmp);
       end;
end;
{
procedure TfrmMain.LoadSpriteTreeData(Filename: string);
var
strTmp: string;
iLoop: integer;
RootItem: TTreeNTNode;
NodeExists: Boolean;
begin

       RootItem := SpriteRoot;
       strTmp := ChangeFileExt(ExtractFileName(FileName),'');
       NodeExists := false;
       if RootItem.HasChildren then
       begin
         //search through the children
         for iLoop:= 0 to RootItem.Count -1 do
         begin
             if RootItem.Item[iLoop].text = strTmp then
             begin
                NodeExists:= true;
                Break;
             end;
         end;
       end;
       if Not(NodeExists) then
       begin
           tvSpriteList.Items.AddChild(RootItem,strTmp);
       end;
end;
 }


//Load sprite tree
procedure TfrmMain.LoadSpriteFiles;
var
 oDirScan: TDirectoryScanner;
 objDB: TSQLiteDatabase;
 objDS: TSQLIteTable;
 strSQL: String;
 strTmp: string;
 iLoop: integer;
 NodeExists: Boolean;
 SpriteItem: TTreeNTNode;
 strSpriteID: String;
RootItem: TTreeNTNode;
begin

        CharacterRoot:= tvSpriteList.Items.add(nil,'Characters');
        SpriteRoot:= tvSpriteList.Items.add(nil,'Sprites');
        EditorRoot:= tvSpriteList.Items.add(nil,'Editor');
        ParticleRoot:= tvSpriteList.Items.add(nil,'Particles');

        objDB := TSQLiteDatabase.Create(strDatabase);

        //sprite Files
        strSQL := 'SELECT [SpriteID], [FileName] ' +
               'FROM [tblISO_SpriteFiles] NOLOCK;';
        objDS := objDB.GetTable(strSQL);
        if objDS.Count > 0 then
        begin
         while not objDS.EOF do
         begin
              try

                strTmp := ExtractFileName(ChangeFileExt(objDS.FieldAsString(objDS.FieldIndex['FileName']),''));
                strSpriteID := objDS.FieldAsString(objDS.FieldIndex['SpriteID']);
                NodeExists := false;

                RootItem := SpriteRoot;
                NodeExists := false;
                if RootItem.HasChildren then
                begin
                 //search through the children
                 for iLoop:= 0 to RootItem.Count -1 do
                 begin
                     if RootItem.Item[iLoop].text = strTmp then
                     begin
                        NodeExists:= true;
                        Break;
                     end;
                 end;
                end;
                if Not(NodeExists) then
                begin
                  SpriteItem := tvSpriteList.Items.AddChild(SpriteRoot,strTmp);
                  SpriteItem.ImageIndex := StrToInt(strSpriteID);
                end;
              finally
                 objDS.Next;
              end;
         end;
        end;
        objDS.free;

        //character files
        strSQL := 'SELECT [ISO_CharacterID], [CharacterName] ' +
               'FROM [tblPA_Characters] NOLOCK;';
        objDS := objDB.GetTable(strSQL);
        if objDS.Count > 0 then
        begin
         while not objDS.EOF do
         begin
              try

                strTmp := ExtractFileName(ChangeFileExt(objDS.FieldAsString(objDS.FieldIndex['CharacterName']),''));
                strSpriteID := objDS.FieldAsString(objDS.FieldIndex['ISO_CharacterID']);
                NodeExists := false;

                RootItem := SpriteRoot;
                NodeExists := false;
                if RootItem.HasChildren then
                begin
                 //search through the children
                 for iLoop:= 0 to RootItem.Count -1 do
                 begin
                     if RootItem.Item[iLoop].text = strTmp then
                     begin
                        NodeExists:= true;
                        Break;
                     end;
                 end;
                end;
                if Not(NodeExists) then
                begin
                  SpriteItem := tvSpriteList.Items.AddChild(CharacterRoot,strTmp);
                  SpriteItem.ImageIndex := StrToInt(strSpriteID);
                end;
              finally
                 objDS.Next;
              end;
         end;
        end;
        objDS.free;


        objDB.free;
//    oDirScan := TDirectoryScanner.Create;
//    oDirScan.Extension := 'dat';
//    oDirScan.OnFoundFile := LoadCharacterTreeData;
//    oDirScan.ProcessDirectory(strCharPath);
//    oDirScan.Free;

//    oDirScan := TDirectoryScanner.Create;
//    oDirScan.Extension := 'dat';
//    oDirScan.OnFoundFile := LoadSpriteTreeData;
//    oDirScan.ProcessDirectory(strSpritePath);
//    oDirScan.Free;


    //leave as flat files
    oDirScan := TDirectoryScanner.Create;
    oDirScan.Extension := 'dat';
    oDirScan.OnFoundFile := LoadTileTreeData;
    oDirScan.ProcessDirectory(strEditorTilePath);
    oDirScan.Free;
   //leave as flat files
    oDirScan := TDirectoryScanner.Create;
    oDirScan.Extension := 'psi';
    oDirScan.OnFoundFile := LoadParticleTreeData;
    oDirScan.ProcessDirectory(strParticlePath);
    oDirScan.Free;

    LoadEditorTreeData;
end;


procedure TfrmMain.LoadStaticFiles;
var
// oDirScan: TDirectoryScanner;
objDB: TSQLiteDatabase;
objDS: TSQLIteTable;
objDS2: TSQLIteTable;
strSQL: String;
strTmp: string;
iLoop: integer;
StaticRoot: TTreeNTNode;
NodeExists: Boolean;
StaticNode: TTreeNTNode;
StaticItem: TTreeNTNode;
strStaticID: String;
begin
     objDB := TSQLiteDatabase.Create(strDatabase);

     //Static File
     strSQL := 'SELECT [StaticID], [RootName], [FileName] ' +
               'FROM [tblISO_StaticFiles] NOLOCK;';
     objDS := objDB.GetTable(strSQL);
     if objDS.Count > 0 then
     begin
         while not objDS.EOF do
         begin
              try

                strTmp := objDS.FieldAsString(objDS.FieldIndex['RootName']);
                strStaticID := objDS.FieldAsString(objDS.FieldIndex['StaticID']);
                NodeExists := false;
                //search The existing root
                for iLoop:= 0 to tvStaticList.Items.Count -1 do
                begin
                 if tvStaticList.Items[iloop].text = strTmp then
                 begin
                    StaticRoot := tvStaticList.Items[iloop];
                    NodeExists := true;
                    Break;
                 end;
                end;
                if Not(NodeExists) then
                begin
                  StaticRoot:= tvStaticList.Items.add(nil,strTmp);
                end;

                StaticNode := tvStaticList.Items.AddChild(StaticRoot,ExtractFileName(objDS.FieldAsString(objDS.FieldIndex['FileName'])));

                 //Images in the static file
                strSQL := 'SELECT [EditorName] ' +
                       'FROM [tblISO_StaticObjects] NOLOCK WHERE [StaticID] = '+ strStaticID + ';';
                objDS2 := objDB.GetTable(strSQL);
                if objDS2.Count > 0 then
                begin
                     while not objDS2.EOF do
                     begin
                         try
                           StaticItem := tvStaticList.Items.AddChild(StaticNode,objDS2.FieldAsString(objDS2.FieldIndex['EditorName']));
                           StaticItem.ImageIndex :=  StrToInt(strStaticID);
                         finally
                          objDS2.Next;
                         end;
                     end;
                end;
                objDS2.free;

              finally
                 objDS.Next;
              end;
         end;
     end;
     objDS.free;
     objDB.free;

//    oDirScan := TDirectoryScanner.Create;
//    oDirScan.Extension := 'dat';
//    oDirScan.OnFoundFile := LoadStaticTreeData;
//    oDirScan.ProcessDirectory(strStaticPath);
//    oDirScan.Free;




end;

{
procedure TfrmMain.LoadStaticTreeData(Filename: string);
var
strTmp: string;
iLoop: integer;
StaticRoot: TTreeNTNode;
NodeExists: Boolean;
StaticFile: TextFile;
StaticNode: TTreeNTNode;
iCount: integer;
begin
      AssignFile(StaticFile, FileName);
      ReSet(StaticFile);
      Readln(StaticFile,strTmp); //root
      NodeExists := false;
      //search The existing root
      for iLoop:= 0 to tvStaticList.Items.Count -1 do
      begin
         if tvStaticList.Items[iloop].text = strTmp then
         begin
            StaticRoot := tvStaticList.Items[iloop];
            NodeExists := true;
            Break;
         end;
      end;
      if Not(NodeExists) then
      begin
          StaticRoot:= tvStaticList.Items.add(nil,strTmp);
      end;

      StaticNode := tvStaticList.Items.AddChild(StaticRoot,ExtractFileName(Filename));
      Readln(StaticFile,strTmp);//File Name
      Readln(StaticFile,strTmp);//Count
      iCount := StrToInt(strTmp);
      for iLoop := 1 to iCount do
      begin
          Readln(StaticFile,strTmp);//Item Line
          tvStaticList.Items.AddChild(StaticNode,StrTokenAt(strTmp,' ',0));
      end;

      CloseFile(StaticFile);
end;
}

{
function TfrmMain.ParseSpriteFile(FileName: string): TBitmap;
var
strFileName: string;
FrameHeight: integer;
FrameWidth: integer;
SpriteFile: TextFile;
NG : TNGImage;
SpriteTexture: TBitmap;
SourceRect, DestRect: TRect;
strTmp: string;

begin

   AssignFile(SpriteFile, FileName);
   ReSet(SpriteFile);
   Readln(SpriteFile,strFileName);
   strFileName := Trim(strFileName);
   Readln(SpriteFile,strTmp); //Number of Frames
   Readln(SpriteFile,strTmp); //Frames Per Second
   Readln(SpriteFile,strTmp); //Frame Width
   FrameWidth := StrToInt(strTmp);
   Readln(SpriteFile,strTmp); //Frame Height
   FrameHeight := StrToInt(strTmp);

   //Creat Editor Sprite Image
   SpriteTexture := TBitmap.Create;
   SpriteTexture.Canvas.Brush.Color := tmColor;
//   SpriteTexture.TransparentColor := tmColor;
//   SpriteTexture.TransparentMode := tmFixed;
  // SpriteTexture.Transparent := true;
   SpriteTexture.Width := FrameWidth;
   SpriteTexture.Height := FrameHeight;

   DestRect := Rect(0,0,FrameWidth,FrameHeight);
   SourceRect := Rect(0,0,FrameWidth,FrameHeight);
   //Load the PNG and Get the first frame
   NG := TNGImage.Create;
   NG.SetAlphaColor(tmColor);
   NG.Transparent := true;
   NG.TransparentColor := tmColor;
   NG.LoadFromFile(strTexturePath + strFileName);
   //Copy out the first frame for the editor
   SpriteTexture.Canvas.FillRect(Rect(0,0,FrameWidth,FrameHeight));
   SpriteTexture.Canvas.CopyRect(DestRect,NG.CopyBitmap.Canvas,SourceRect);
   CloseFile(SpriteFile);
   NG.Free;
   Result := SpriteTexture;
end;
}
{
function TfrmMain.ParseStaticFile(FileName: string; Frame: integer): TBitmap;
var
strFileName: string;
FrameHeight: integer;
FrameWidth: integer;
FrameCount: integer;
StaticFile: TextFile;
NG : TNGImage;
StaticTexture: TBitmap;
SourceRect, DestRect: TRect;
strTmp: string;
iLoop: integer;
begin

   AssignFile(StaticFile, FileName);
   ReSet(StaticFile);
   Readln(StaticFile,strTmp); //Root
   Readln(StaticFile,strFileName);
   strFileName := Trim(strFileName);
   Readln(StaticFile,strTmp); //Frames
   FrameCount := StrToInt(strTmp);
   Readln(StaticFile,strTmp); //Frame Width
   FrameWidth := StrToInt(strTmp);
   Readln(StaticFile,strTmp); //Frame Height
   FrameHeight := StrToInt(strTmp);

   for iLoop := 0 to Frame do
   begin
       Readln(StaticFile,strTmp); //XY Offset
       iXoffSet := StrToInt(StrTokenAt(strTmp,' ',0));
       iYoffSet := StrToInt(StrTokenAt(strTmp,' ',1));
       iImageTileLength :=StrToInt(StrTokenAt(strTmp,' ',2));
       iImageTileWidth :=StrToInt(StrTokenAt(strTmp,' ',3));
   end;
   //Creat Editor Static Image
   StaticTexture := TBitmap.Create;
   StaticTexture.TransparentColor := tmColor;
   StaticTexture.TransparentMode := tmFixed;
   StaticTexture.Transparent := true;
   StaticTexture.Width := FrameWidth;
   StaticTexture.Height := FrameHeight;

   SourceRect := Rect(FrameWidth*Frame,0,(FrameWidth*Frame)+FrameWidth,FrameHeight);
   DestRect := Rect(0,0,FrameWidth,FrameHeight);
   //Load the PNG and Get the first frame
   NG := TNGImage.Create;
   //NG.SetAlphaColor(tmColor);
   NG.Transparent := true;
   NG.TransparentColor := tmColor;
   NG.LoadFromFile(strTexturePath + strFileName);
   //Copy out the first frame for the editor
   StaticTexture.Canvas.FillRect(Rect(0,0,FrameWidth,FrameHeight));
   StaticTexture.Canvas.CopyRect(DestRect,NG.CopyBitmap.Canvas,SourceRect);
   CloseFile(StaticFile);
   NG.Free;
   Result := StaticTexture;
end;
}

{
function TfrmMain.ParseStatic(FileName: string; ItemName: string): TBitmap;
var
strFileName: string;
FrameHeight: integer;
FrameWidth: integer;
FrameCount: integer;
StaticFile: TextFile;
NG : TNGImage;
StaticTexture: TBitmap;
SourceRect, DestRect: TRect;
strTmp: string;
iLoop: integer;
strFrameName: string;
x,y: integer;
begin

    AssignFile(StaticFile, FileName);
    ReSet(StaticFile);
    Readln(StaticFile,strTmp); //Root
    Readln(StaticFile,strFileName);
    strFileName := Trim(strFileName);
    Readln(StaticFile,strTmp); //Count
    FrameCount := StrToInt(strTmp);

    //Load the PNG and Get the first frame
    NG := TNGImage.Create;
    NG.SetAlphaColor(tmColor);
    NG.Transparent := true;
    NG.TransparentColor := tmColor;
    NG.LoadFromFile(strTexturePath + strFileName);
    StaticTexture := TBitmap.Create;
    StaticTexture.Canvas.Brush.Color := tmColor;
//    StaticTexture.TransparentColor := tmColor;
//    StaticTexture.TransparentMode := tmFixed;
//    StaticTexture.Transparent := true;

   for iLoop := 0 to FrameCount-1 do
   begin //EditorName x y width height xOffset YOffset Length Width
      Readln(StaticFile,strTmp);
      strFrameName := StrTokenAt(strTmp,' ',0);
      if lowercase(ItemName) = lowercase(strFrameName) then
      begin
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
          StaticTexture.Width := FrameWidth;
          StaticTexture.Height := FrameHeight;
          StaticTexture.Canvas.Brush.Color := tmColor;
          StaticTexture.Canvas.FillRect(Rect(0,0,FrameWidth,FrameHeight));
          StaticTexture.Canvas.CopyRect(DestRect,NG.CopyBitmap.Canvas,SourceRect);
      end;
   end;
   CloseFile(StaticFile);
   NG.Free;
   Result := StaticTexture;
end;
}
function TfrmMain.LoadStatic(strStaticID: string; ItemName: string): TBitmap;
var
strFileName: string;
FrameHeight: integer;
FrameWidth: integer;
NG : TNGImage;
StaticTexture: TBitmap;
SourceRect, DestRect: TRect;
x,y: integer;
objDB: TSQLiteDatabase;
objDS: TSQLiteTable;
strSQL: String;
begin

    objDB := TSQLiteDatabase.Create(strDatabase);
    //get image file name
    strSQL := 'SELECT [FileName] ' +
               'FROM [tblISO_StaticFiles] WHERE [StaticID] = '+ strStaticID +';';
    objDS := objDB.GetTable(strSQL);
    if objDS.Count > 0 then
         strFileName := objDS.FieldAsString(objDS.FieldIndex['FileName'])
    else
        strFileName := '';

    objDS.free;


    //get editor images
    strSQL := 'SELECT [Startx], [Starty], [Width], [Height], [xOffset], [yOffset], [Length], [Depth] ' +
              'FROM [tblISO_StaticObjects] WHERE [StaticID] = '+ strStaticID +
              ' AND [EditorName] = "' +ItemName + '";';
    objDS := objDB.GetTable(strSQL);
    if objDS.Count > 0 then
    begin
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

         StaticTexture := TBitmap.Create;
         StaticTexture.Canvas.Brush.Color := tmColor;

         StaticTexture.Width := FrameWidth;
         StaticTexture.Height := FrameHeight;
         StaticTexture.Canvas.Brush.Color := tmColor;

         //Load the PNG and Get the first frame
         NG := TNGImage.Create;
         NG.SetAlphaColor(tmColor);
         NG.Transparent := true;
         NG.TransparentColor := tmColor;
         if FileExists(strTexturePath + strFileName) then
         begin
                NG.LoadFromFile(strTexturePath + strFileName);

                StaticTexture.Canvas.FillRect(Rect(0,0,FrameWidth,FrameHeight));
                StaticTexture.Canvas.CopyRect(DestRect,NG.CopyBitmap.Canvas,SourceRect);
         end;
    end;

    objDS.free;
    objDB.free;
    NG.Free;


    Result := StaticTexture;

end;

function TfrmMain.LoadCharacter(strCharacterID: string): TBitmap;
var
strFileName: string;
FrameHeight: integer;
FrameWidth: integer;
NG : TNGImage;
SpriteTexture: TBitmap;
SourceRect, DestRect: TRect;
objDB: TSQLiteDatabase;
objDS: TSQLIteTable;
strSQL: String;
begin

    objDB := TSQLiteDatabase.Create(strDatabase);
    //get image file name
    strSQL := 'SELECT [FileName],[Width],[Height] ' +
               'FROM [tblISO_CharacterFiles] WHERE [ActionType]= 0 and [CharacterID] = '+ strCharacterID +';';
    objDS := objDB.GetTable(strSQL);
    if objDS.Count > 0 then
         strFileName := objDS.FieldAsString(objDS.FieldIndex['FileName'])
    else
       strFileName := '';

    FrameWidth := objDS.FieldAsInteger(objDS.FieldIndex['Width']);
    FrameHeight := objDS.FieldAsInteger(objDS.FieldIndex['Height']);

    //Creat Editor Sprite Image
    SpriteTexture := TBitmap.Create;
    SpriteTexture.Canvas.Brush.Color := tmColor;
    SpriteTexture.Width := FrameWidth;
    SpriteTexture.Height := FrameHeight;

    DestRect := Rect(0,0,FrameWidth,FrameHeight);
    SourceRect := Rect(0,FrameHeight*3,FrameWidth,FrameHeight*4);
    //Load the PNG and Get the first frame
    NG := TNGImage.Create;
    NG.Transparent := true;
    NG.TransparentColor := tmColor;
    NG.SetAlphaColor(tmColor);
    if FileExists(strTexturePath + strFileName) then
    begin
        NG.LoadFromFile(strTexturePath + strFileName);

        //Copy out the first frame for the editor
        SpriteTexture.Canvas.FillRect(Rect(0,0,FrameWidth,FrameHeight));
        SpriteTexture.Canvas.CopyRect(DestRect,NG.CopyBitmap.Canvas,SourceRect);
    end;
    Result := SpriteTexture;

    NG.Free;
    objDS.free;
    objDB.free;
end;

function TfrmMain.LoadSprite(strSpriteID: string): TBitmap;
var
strFileName: string;
FrameHeight: integer;
FrameWidth: integer;
NG : TNGImage;
SpriteTexture: TBitmap;
SourceRect, DestRect: TRect;
objDB: TSQLiteDatabase;
objDS: TSQLIteTable;
strSQL: String;
begin

    objDB := TSQLiteDatabase.Create(strDatabase);
    //get image file name
    strSQL := 'SELECT [FileName],[Width],[Height] ' +
               'FROM [tblISO_SpriteFiles] WHERE [SpriteID] = '+ strSpriteID +';';
    objDS := objDB.GetTable(strSQL);
    if objDS.Count > 0 then
    begin
         strFileName := objDS.FieldAsString(objDS.FieldIndex['FileName']);
    end;

    FrameWidth := objDS.FieldAsInteger(objDS.FieldIndex['Width']);
    FrameHeight := objDS.FieldAsInteger(objDS.FieldIndex['Height']);

    SpriteTexture := TBitmap.Create;
    SpriteTexture.Canvas.Brush.Color := tmColor;
    SpriteTexture.Width := FrameWidth;
    SpriteTexture.Height := FrameHeight;

    DestRect := Rect(0,0,FrameWidth,FrameHeight);
    SourceRect := Rect(0,0,FrameWidth,FrameHeight);
    //Load the PNG and Get the first frame
    NG := TNGImage.Create;
    NG.SetAlphaColor(tmColor);
    NG.Transparent := true;
    NG.TransparentColor := tmColor;
    if FileExists(strTexturePath + strFileName) then
    begin
        NG.LoadFromFile(strTexturePath + strFileName);
        //Copy out the first frame for the editor
        SpriteTexture.Canvas.FillRect(Rect(0,0,FrameWidth,FrameHeight));
        SpriteTexture.Canvas.CopyRect(DestRect,NG.CopyBitmap.Canvas,SourceRect);
    end;

    Result := SpriteTexture;

    NG.Free;
    objDS.free;
    objDB.free;
end;

{
function TfrmMain.ParseCharacterFile(FileName: string): TBitmap;
var
strFileName: string;
FrameHeight: integer;
FrameWidth: integer;
SpriteFile: TextFile;
NG : TNGImage;
SpriteTexture: TBitmap;
SourceRect, DestRect: TRect;
strTmp: string;

begin

   AssignFile(SpriteFile, FileName);
   ReSet(SpriteFile);
   Readln(SpriteFile,strFileName);
   strFileName := Trim(strFileName +'_stand.png');
   Readln(SpriteFile,strTmp); //Number of Frames
   Readln(SpriteFile,strTmp); //Frames Per Second
   Readln(SpriteFile,strTmp); //Frame Width
   FrameWidth := StrToInt(strTmp);
   Readln(SpriteFile,strTmp); //Frame Height
   FrameHeight := StrToInt(strTmp);

   //Creat Editor Sprite Image
   SpriteTexture := TBitmap.Create;
   SpriteTexture.Canvas.Brush.Color := tmColor;
//   SpriteTexture.TransparentColor := tmColor;
//   SpriteTexture.TransparentMode := tmFixed;
//   SpriteTexture.Transparent := true;
   SpriteTexture.Width := FrameWidth;
   SpriteTexture.Height := FrameHeight;

   DestRect := Rect(0,0,FrameWidth,FrameHeight);
   SourceRect := Rect(0,FrameHeight*3,FrameWidth,FrameHeight*4);
   //Load the PNG and Get the first frame
   NG := TNGImage.Create;

   NG.Transparent := true;
   NG.TransparentColor := tmColor;
   NG.SetAlphaColor(tmColor);
   NG.LoadFromFile(strTexturePath + strFileName);
   //Copy out the first frame for the editor
   SpriteTexture.Canvas.FillRect(Rect(0,0,FrameWidth,FrameHeight));
   SpriteTexture.Canvas.CopyRect(DestRect,NG.CopyBitmap.Canvas,SourceRect);
   CloseFile(SpriteFile);
   NG.Free;

   Result := SpriteTexture;
end;
 }

procedure TfrmMain.LoadTileTreeData(fileName: string);
var
strLine: string;
iLoop: integer;
nLoop: integer;
treeFile: TextFile;
RootFlag: TTreeNTNode;
tmpNode: TTreeNTNode;
NodeExists: Boolean;
RootName: string;
begin
   //Load the tree view with images -- TTree View SUCKS!!
   AssignFile(TreeFile, fileName);                                     // Get our handle
   ReSet(TreeFile);

   while Not(Eof(Treefile)) do
   begin
        Readln(TreeFile,strLine);
        strLine := Trim(StrLine);

        if (LowerCase(StrLine) <> 'endroot') and (strLine <> '') and (strTokenAt(strLine,'.',1) <> 'bmp') then
        begin

             tmpNode := nil;
             if LowerCase(strTokenAt(StrLine, '\', 0)) = 'root' then
             begin
                   NodeExists := false;
                   for nLoop:= 0 to tvTileList.Items.Count -1 do
                   begin
                       if tvTileList.Items[nLoop].text = StrTokenAt(StrLine,'\',iLoop) then
                       begin
                          RootFlag := tvTileList.Items[nLoop];
                          NodeExists:= true;
                          Break;
                       end;
                   end;
                   if Not(NodeExists) then
                   begin
                        RootFlag := tvTileList.Items.add(nil,strTokenAt(StrLine, '\', 1));
                   end;

                   RootName := strTokenAt(StrLine, '\', 1);
             end
             else
             begin
                  if FileExists(ExtractFilePath(Application.exeName) + 'Resources\Tiles\' + RootName +'\' +StrLine) then
                  begin
                      tmpNode := RootFlag;
                      for iLoop := 0 to StrTokenCount(StrLine,'\') -1 do
                      begin
                           if tmpNode.HasChildren then
                           begin
                              //search through the children
                             NodeExists := false;
                             for nLoop:= 0 to tmpNode.Count -1 do
                             begin
                                 if tmpNode.Item[nLoop].text = StrTokenAt(StrLine,'\',iLoop) then
                                 begin
                                    TmpNode := tmpNode.Item[nLoop];
                                    NodeExists:= true;
                                    Break;
                                 end;
                             end;
                             if Not(NodeExists) then
                             begin
                                 tmpNode :=  tvTileList.Items.AddChild(tmpNode,strTokenAt(StrLine, '\', iLoop));
                             end;
                           end
                           else
                              tmpNode :=  tvTileList.Items.AddChild(tmpNode,strTokenAt(StrLine, '\', iLoop));
                      end;
                  end;
             end;
        end;
   end;
   CloseFile(TreeFile);
end;


procedure TfrmMain.tvTileListClick(Sender: TObject);
var iLoop: integer;
myIniFile : TIniFile;
strFileName: string;
begin
     RandomTileList.Clear;
     //choose an image to draw
     if tvTileList.Selected = nil then exit;
   //  if tvTileList.Selected.Parent = nil then exit;
     if (LowerCase(strRight(tvTileList.Selected.text,4)) = '.bmp') then
     begin
          DiamondType := dtSingle;
          MergeQuadTiles;
          QuadCollection.ClearAll;
          //QuadCollection := TQuadCollection.Create;

          myIniFile := TIniFile.Create(ExtractFilePath(Application.exeName) + 'Resources\Tiles\' +tvTileList.Selected.Parent.text +'\'+ tvTileList.Selected.Parent.Item[0].text);

          if myIniFile.SectionExists('ImageList') then
            cbDiamond.Checked := True
          else
            cbDiamond.Checked := False;
          myIniFile.Free;

         ImageFileName := ExtractFilePath(Application.exeName) + 'Resources\Tiles\' +tvTileList.Selected.Parent.text +'\'+ tvTileList.Selected.text;
         LoadBMPPreview(ImageFileName);
         iMap.Cursor := crDrag;
         if fileExists(ImageFileName) then
         begin
              //Get rid of the old mouse image
              //Draw the select item preview
              RandomTileList.Add(ImageFileName);
              ImgPreview.Picture := nil;
              ImgPreview.Canvas.Brush.Color := tmColor;
              ImgPreview.Canvas.FillRect(Rect(0,0,ImgPreview.width,ImgPreview.height));
             // ImgPreview.Canvas.Draw(0,0,TileImage);
              ImgPreview.Picture.LoadFromFile(ImageFileName);
         end;
     end
     else
     if (LowerCase(strRight(tvTileList.Selected.text,4)) = '.ini') then
     begin
          myIniFile := TIniFile.Create(ExtractFilePath(Application.exeName) + 'Resources\Tiles\' +tvTileList.Selected.Parent.text +'\'+ tvTileList.Selected.text);
         // LoadBMPPreview(ExtractFilePath(Application.exeName) + 'Resources\Tiles\' +tvTileList.Selected.Parent.text +'\'+ tvTileList.Selected.parent.Item[1].text);
          LoadBMPPreview(ExtractFilePath(Application.exeName) + 'Resources\Tiles\' +tvTileList.Selected.Parent.text +'\'+ StrTokenAt(tvTileList.Selected.text,'.',0) + '_00.bmp');

          if myIniFile.SectionExists('ImageList') then
          begin
            cbDiamond.Checked := True;
            DiamondType := dtQuad;
            if not(QuadCollection.CheckExistingTileSet(ChangeFileExt(tvTileList.Selected.text,''))) then
            begin
                 QuadCollection.AddTileSet(ExtractFilePath(Application.exeName) + 'Resources\Tiles\' +tvTileList.Selected.Parent.text +'\'+ tvTileList.Selected.text);
            end;
          end
          else
          begin
             iMap.Cursor := crDrag;
             cbDiamond.Checked := false;
             strFileName := ExtractFilePath(Application.exeName) + 'Resources\Tiles\' +tvTileList.Selected.Parent.text +'\'+StrTokenAt(tvTileList.Selected.text,'.',0);
             for iLoop := 0 to 100 do
                if FileExists(strFileName + '_' + IntToStr(iLoop) + '.bmp') then
                    RandomTileList.Add(strFileName + '_' + IntToStr(iLoop) + '.bmp')
                else  if FileExists(strFileName + '_0' + IntToStr(iLoop) + '.bmp') then
                    RandomTileList.Add(strFileName + '_0' + IntToStr(iLoop) + '.bmp')
           {  for iLoop := 0 to tvTileList.Selected.parent.count -1 do
                 if LowerCase(strRight(tvTileList.Selected.parent.Item[iLoop].text,4)) = '.bmp' then
                    RandomTileList.Add(ExtractFilePath(Application.exeName) + 'Resources\Tiles\' +tvTileList.Selected.Parent.Text  +'\'+tvTileList.Selected.parent.Item[iLoop].text);
          }
          end;
          myIniFile.Free;
     end
     else
     begin
          myIniFile := TIniFile.Create(ExtractFilePath(Application.exeName) + 'Resources\Tiles\' +tvTileList.Selected.text +'\'+ tvTileList.Selected.Item[0].text);
          //LoadBMPPreview(ExtractFilePath(Application.exeName) + 'Resources\Tiles\' +tvTileList.Selected.text +'\'+ tvTileList.Selected.Item[1].text);
          LoadBMPPreview(ExtractFilePath(Application.exeName) + 'Resources\Tiles\' +tvTileList.Selected.text +'\'+ tvTileList.Selected.text + '_00.bmp');

          if myIniFile.SectionExists('ImageList') then
          begin
            cbDiamond.Checked := True;
            DiamondType := dtQuad;
            if not(QuadCollection.CheckExistingTileSet(tvTileList.Selected.text)) then
            begin
                 QuadCollection.AddTileSet(ExtractFilePath(Application.exeName) + 'Resources\Tiles\' +tvTileList.Selected.text +'\'+ tvTileList.Selected.Item[0].text);
            end;
          end
          else
          begin
             iMap.Cursor := crDrag;
             cbDiamond.Checked := false;
             for iLoop := 0 to tvTileList.Selected.count -1 do
                 if LowerCase(strRight(tvTileList.Selected.Item[iLoop].text,4)) = '.bmp' then
                    RandomTileList.Add(ExtractFilePath(Application.exeName) + 'Resources\Tiles\' +tvTileList.Selected.Text  +'\'+tvTileList.Selected.Item[iLoop].text);
          end;
          myIniFile.Free;

     end;

end;

procedure TfrmMain.LoadTileByName(tileName: string);
begin
     if fileExists(tileName) and (Pos('.ini', ExtractFileName(tileName)) =0) then
     begin
          //Get rid of the old mouse image
          if Assigned(TileImage) then
          begin
               TileImage.ReleaseHandle;
               TileImage.FreeImage;
               TileImage.free;
               TileImage := nil;
          end;
          //creat and load a new mouse image
          TileImage := TBitmap.Create;
          TileImage.TransparentMode := tmFixed;
          TileImage.TransparentColor := tmColor;
          TileImage.Transparent := true;
          TileImage.LoadFromFile(tileName);
          TileImage.Dormant;

          SelectTileName := LowerCase(ExtractFileName(tileName));
     end;

end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
//   LoadTileTreeData;
     LoadSpriteFiles;
     LoadStaticFiles;
     tmColor := 16745215;
     Top := 0;
     frmNPCProp.Show();
     frmNPCProp.Left := Left;
     if (Top+Height+10 + frmNPCProp.Height)> Screen.Height then
     begin
        frmNPCProp.Top := Screen.Height - frmNPCProp.Height -10;
       // frmNPCProp.FormStyle := fsStayOnTop;
     end
     else
         frmNPCProp.Top := Top + Height + 10;
end;

procedure TfrmMain.mnuClearAllClick(Sender: TObject);
var
yLoop: integer;
xLoop: integer;
begin
  //confirm clear
  if MessageDlg('Are you shure you want to clear everything on the entire map?',mtConfirmation,[mbYes, mbNo],0) = mryes then
  begin
   for yLoop := 0  to MapHeight -1do
   begin
        for xLoop := 0 to MapWidth -1 do
        begin
           BaseLayer[yLoop,xLoop] := 0;
           DiamondLayer[yLoop,xLoop] := 0;
           CollisionLayer[yLoop,xLoop] := 0;
           StartLayer[yLoop,xLoop] := 0;
        end;
   end;

  end;
  RefreshScreen;
end;

procedure TfrmMain.WriteResourceBlock(var Output: TextFile);
begin
     WriteLn(Output,'RB');
     WriteLn(Output,'EB');
end;

procedure TfrmMain.WriteLevelBlock(var Output: TextFile);
begin
    // WriteLn(Output,'LB');
    // WriteLn(Output,'AMBIENT ' + IntToStr(GetRValue(LightColor)) +' '+ IntToStr(GetGValue(LightColor)) +' '+ IntToStr(GetBValue(LightColor)));
    // WriteLn(Output,'SHADOW ' + IntToStr(ShadowType));
    // WriteLn(Output,'WEATHER ' + IntToStr(Weather));
    // WriteLn(Output,'EB');
end;

procedure TfrmMain.WriteObjectBlock(var Output: TextFile);
var
   iLoop: integer;
   tmpStr: string;
   MySprite: TSprite;
   MyStatic: TStatic;
   MyLight: TLight;
begin
     WriteLn(Output,'SB ' + IntToStr(ObjectList.Count));
     for iLoop := 0 to ObjectList.Count -1 do
     begin
        tmpStr := '';
        if TGameObject(ObjectList.items[iLoop]).MyType = otStatic then
        begin
            MyStatic := TStatic(ObjectList.items[iLoop]);
            tmpStr := 'STATIC ' +
                      MyStatic.ID +  ' '+
                      IntToStr(MyStatic.GroupID) +  ' '+
                      MyStatic.Frame +  ' '+
                      IntToStr(MyStatic.x) +  ' '+
                      IntToStr(MyStatic.y) +  ' '+
                      IntToStr(MyStatic.offSetX) +  ' '+
                      IntToStr(MyStatic.offSetY) +  ' '+
                      IntToStr(MyStatic.Length) +  ' '+
                      IntToStr(MyStatic.Width) +  ' '+
                      IntToStr(MyStatic.Layer);
            if (MyStatic.Shadow) then
               //tmpStr := tmpStr + ' 1 ' + MyStatic.FileName
            else
              // tmpStr := tmpStr + ' 0 ' + MyStatic.FileName;
            WriteLn(Output,tmpStr);
        end;

        if TGameObject(ObjectList.items[iLoop]).MyType = otLight then
        begin
            MyLight := TLight(ObjectList.items[iLoop]);
            tmpStr := 'LIGHT ' +
                      MyLight.ID +  ' '+
                      IntToStr(MyLight.GroupID) +  ' '+
                      IntToStr(MyLight.x) +  ' '+
                      IntToStr(MyLight.y) +  ' '+
                      IntToStr(MyLight.offSetX) +  ' '+
                      IntToStr(MyLight.offSetY) +  ' '+
                      IntToStr(MyLight.Height) +  ' '+
                      IntToStr(MyLight.Width) +  ' '+
                      IntToStr(MyLight.Blend) +  ' '+
                      IntToStr(MyLight.Red) +  ' '+
                      IntToStr(MyLight.Green) +  ' '+
                      IntToStr(MyLight.Blue) +  ' '+
                      IntToStr(MyLight.Flicker);
            WriteLn(Output,tmpStr);
        end;

        if TGameObject(ObjectList.items[iLoop]).MyType = otSprite then
        begin
            MySprite := TSprite(ObjectList.items[iLoop]);
            Case MySprite.SpriteType of
              stNPC:
                  tmpStr := 'NPC ' +
                            IntToStr(MySprite.Facing) +  ' ' +
                            IntToStr(MySprite.Side) +  ' ' +
                            MySprite.ID +  ' '+
                            IntToStr(MySprite.GroupID) +  ' ' +
                            IntToStr(MySprite.x) +  ' ' +
                            IntToStr(MySprite.y) +  ' ' +
                            //MySprite.FileName +  ' ' +
                            MySprite.DisplayName +  ' ' +
                            IntToStr(MySprite.CharType) + ' ' +
                            IntToStr(MySprite.DefRating) + ' ' +
                            IntToStr(MySprite.HealthRating) + ' ' +
                            IntToStr(MySprite.AttRating) + ' ' +
                            IntToStr(MySprite.MoveRating) + ' ' +
                            IntToStr(MySprite.SpellID) + ' ' +
                            MySprite.PhyResist + ' ' +
                            MySprite.MagResist + ' ' +
                            IntToStr(MySprite.HitPoints) + ' ' +
                            IntToStr(MySprite.MinDamage) + ' ' +
                            IntToStr(MySprite.MaxDamage) + ' ' +
                            IntToStr(MySprite.Movement);
              stSprite:
                  tmpStr := 'SPRITE ' +
                            MySprite.ID +  ' '+
                            IntToStr(MySprite.GroupID) +  ' '+
                            IntToStr(MySprite.x) +  ' '+
                            IntToStr(MySprite.y) +  ' '+
                            IntToStr(MySprite.offSetX) +  ' '+
                            IntToStr(MySprite.offSetY) +  ' '+
                            //MySprite.FileName  +  ' '+
                            MySprite.DisplayName;
              stStart:
                  tmpStr := 'Start '+
                            IntToStr(MySprite.Facing) +  ' '+
                            MySprite.ID +  ' '+
                            IntToStr(MySprite.GroupID) +  ' '+
                            IntToStr(MySprite.x) +  ' '+
                            IntToStr(MySprite.y);
              stParticle:
                  tmpStr := 'Particle '+
                            MySprite.ID +  ' '+
                            IntToStr(MySprite.GroupID) +  ' '+
                            IntToStr(MySprite.x) +  ' '+
                            IntToStr(MySprite.y) +  ' '+
                            IntToStr(MySprite.offSetX) +  ' '+
                            IntToStr(MySprite.offSetY) +  ' ';
                            //MySprite.FileName;
            end;
            if tmpStr <> '' then WriteLn(Output,tmpStr);
        end;
     end;

     WriteLn(Output,'EB');

end;

procedure TfrmMain.SaveToFile;
var
   iLoop: Integer;
   jLoop: Integer;
   Output: TextFile;
   BaseFileName: string;
   DiamondFileName: string;
begin
     SaveDialog.InitialDir := strMapPath;
     if SaveDialog.execute then
     begin
         if FileExists(SaveDialog.filename) then
            deletefile(SaveDialog.filename);

         //Write out BaseTiles
         BaseFileName := WriteOutTileTexture(imBaseTiles, SaveDialog.filename, 'Base');
         //Write out DiamondTiles
         DiamondFileName := WriteOutTileTexture(imDiamondTiles, SaveDialog.filename, 'Diamond');

         AssignFile(Output, SaveDialog.fileName);
         ReWrite(Output);
         Append(Output);
         WriteResourceBlock(Output);
         WriteLevelBlock(Output);
         WriteObjectBlock(Output);
         WriteLn(Output,BaseFileName);
         WriteLn(Output,DiamondFileName);
         WriteLn(Output,IntToStr(imBaseTiles.ImageCount)+' '+ IntToStr(imDiamondTiles.ImageCount)+' '+ IntToStr(MapWidth)+' '+ IntToStr(MapHeight)+' ');
           //Base Tiles
         for iLoop := 0 to MapHeight -1 do
         begin
              for jLoop := 0 to MapWidth -1 do
              begin
                   Write(Output,IntToStr(BaseLayer[iLoop,jLoop]) + ' ');
              end
         end;
         //Diamond Tiles
         for iLoop := 0 to MapHeight -1 do
         begin
              for jLoop := 0 to MapWidth -1 do
              begin
                   Write(Output,IntToStr(DiamondLayer[iLoop,jLoop]) + ' ');
              end
         end;
         //Collision Layer
         for iLoop := 0 to MapHeight -1 do
         begin
              for jLoop := 0 to MapWidth -1 do
              begin
                   Write(Output,IntToStr(CollisionLayer[iLoop,jLoop]) + ' ');
              end
         end;
         //Start Layer
         for iLoop := 0 to MapHeight -1 do
         begin
              for jLoop := 0 to MapWidth -1 do
              begin
                   Write(Output,IntToStr(StartLayer[iLoop,jLoop]) + ' ');
              end
         end;

     //    WriteLn(Output,'');
     //    WriteLn(Output,'EB');
         CloseFile(Output);

         ReBuildAutoExecScript;
         ReBuildScriptEvents;

         ScriptList.SaveToFile(ChangeFileExt(strScriptPath + ExtractFileName(SaveDialog.filename),'.lua'));
     end;
end;

procedure TfrmMain.SaveToDatabase;
var
   iLoop: Integer;
   jLoop: Integer;
   Output: TextFile;
   BaseFileName: string;
   DiamondFileName: string;
   objDB: TSQLiteDatabase;
   objDS: TSQLIteTable;
   strSQL: string;
   strShadows: string;
   WorkingFileName: string;
   strTileMap: string;
   MySprite: TSprite;
   MyStatic: TStatic;
   MyLight: TLight;
   MySFX: TSFX;

begin

     if MapPropeties.UseShadows then
        strShadows := 'true'
     else
       strShadows := 'false';

     WorkingFileName :=  strReplace(MapPropeties.MapName,' ','_');

     objDB := TSQLiteDatabase.Create(strDatabase);

     if iEncounterID > 0 then
     begin
          strSQL := 'UPDATE [tblISO_Encounter] SET ' +
                    '[MapType] = "' + IntToStr(MapPropeties.MapType) +'", '+
                    '[MapName] = "' + MapPropeties.MapName +'", '+
                    '[Description] = "' + MapPropeties.MapDesc +'", '+
                    '[AmbientR] = "' + IntToStr(GetRValue(MapPropeties.LightColor)) +'", '+
                    '[AmbientG] = "' + IntToStr(GetGValue(MapPropeties.LightColor)) +'", '+
                    '[AmbientB] = "' + IntToStr(GetBValue(MapPropeties.LightColor)) +'", '+
                    '[ArmySize] = "' + IntToStr(MapPropeties.ArmySize) +'", '+
                    '[WalkSFX] = "' +  IntToStr(MapPropeties.WalkSfx)  +'", '+
                    '[UseShadows] = "' + strShadows +'", '+
                    '[CloudBlend] = "' + IntToStr(MapPropeties.CloudBlend)  +'", '+
                    '[WindDir] = "' + IntToStr(MapPropeties.WindDirect) +'", '+
                    '[Snow] = "' +  IntToStr(MapPropeties.SnowFlakes) +'", '+
                    '[FogType] = "' + IntToStr(MapPropeties.FogType) +'", '+
                    '[FogBlend] = "' + IntToStr(MapPropeties.FogBlend) +'", '+
                    '[FogR] = "' +  IntToStr(GetRValue(MapPropeties.FogColor)) +'",'+
                    '[FogG] = "' +  IntToStr(GetGValue(MapPropeties.FogColor)) +'", '+
                    '[FogB] = "' +  IntToStr(GetBValue(MapPropeties.FogColor)) +'", '+
                    '[FogTextureID] = "' + IntToStr(MapPropeties.FogText) +'", '+
                    '[ScriptFile] = "' +  MapPropeties.ScriptFile + '" '+
                    ' WHERE '+
                    '[EncounterID]= ' + IntToStr(iEncounterID) + ';';
          objDB.ExecSQL(strSQL);
          //clean up old encounter data
          strSQL := 'DELETE FROM [tblISO_EncounterStatics] WHERE [EncounterID]=' + IntToStr(iEncounterID) + ';';
          objDB.ExecSQL(strSQL);
          strSQL := 'DELETE FROM [tblISO_EncounterCharacters] WHERE [EncounterID]=' + IntToStr(iEncounterID) + ';';
          objDB.ExecSQL(strSQL);
          strSQL := 'DELETE FROM [tblISO_EncounterLights] WHERE [EncounterID]=' + IntToStr(iEncounterID) + ';';
          objDB.ExecSQL(strSQL);
          strSQL := 'DELETE FROM [tblISO_EncounterSprites] WHERE [EncounterID]=' + IntToStr(iEncounterID) + ';';
          objDB.ExecSQL(strSQL);
          strSQL := 'DELETE FROM [tblISO_EncounterTiles] WHERE [EncounterID]=' + IntToStr(iEncounterID) + ';';
          objDB.ExecSQL(strSQL);
          strSQL := 'DELETE FROM [tblISO_EncounterSFX] WHERE [EncounterID]=' + IntToStr(iEncounterID) + ';';
          objDB.ExecSQL(strSQL);
     end
     else
     begin
         strSQL := 'SELECT  [EncounterID] '+
                   'FROM  [tblISO_Encounter] '+
                   'WHERE [MapName] = "'+ MapPropeties.MapName +'";';
         objDS := objDB.GetTable(strSQL);
         if objDS.Count > 0 then
         begin
             objDS.Free;
             objDB.free;
             ShowMessage('A map named ' + MapPropeties.MapName + ' already exists. Please choose another name before saving.');
             ShowMapPropertiesWindow;
             exit;
         end;


         //Write MapName, desc, light, shadows, and weather
         strSQL := 'INSERT INTO [tblISO_Encounter] ([MapType], [MapName], [Description], [AmbientR], [AmbientG], [AmbientB],' +
                               '[ArmySize], [WalkSFX], [UseShadows], [CloudBlend], [WindDir], [Snow], [FogType],' +
                               '[FogBlend], [FogR], [FogG], [FogB], [FogTextureID], [ScriptFile]) ' +
                    'VALUES("' +
                              IntToStr(MapPropeties.MapType) +'", "'+
                              MapPropeties.MapName +'", "'+
                              MapPropeties.MapDesc +'", "'+
                              IntToStr(GetRValue(MapPropeties.LightColor)) +'", "'+
                              IntToStr(GetGValue(MapPropeties.LightColor)) +'", "'+
                              IntToStr(GetBValue(MapPropeties.LightColor)) +'", "'+
                              IntToStr(MapPropeties.ArmySize) +'", "'+
                              IntToStr(MapPropeties.WalkSfx)  +'", "'+
                              strShadows +'", "'+
                              IntToStr(MapPropeties.CloudBlend)  +'", "'+
                              IntToStr(MapPropeties.WindDirect) +'", "'+
                              IntToStr(MapPropeties.SnowFlakes) +'", "'+
                              IntToStr(MapPropeties.FogType) +'", "'+
                              IntToStr(MapPropeties.FogBlend) +'", "'+
                              IntToStr(GetRValue(MapPropeties.FogColor)) +'", "'+
                              IntToStr(GetGValue(MapPropeties.FogColor)) +'", "'+
                              IntToStr(GetBValue(MapPropeties.FogColor)) +'", "'+
                              IntToStr(MapPropeties.FogText) +'", "'+
                              MapPropeties.ScriptFile + '");';

         objDB.ExecSQL(strSQL);
        //Estabish master encounter record
         iEncounterID := objDB.GetLastInsertRowID;
     end;
     //write game objects
     for iLoop := 0 to ObjectList.Count -1 do
     begin
        if TGameObject(ObjectList.items[iLoop]).MyType = otStatic then
        begin
            MyStatic := TStatic(ObjectList.items[iLoop]);
            if MyStatic.Shadow then
               strShadows := 'true'
            else
            strShadows := 'false';

            strSQL := 'INSERT INTO [tblISO_EncounterStatics] ([EncounterID],[StaticID],[GroupID],' +
                      '[StaticName],[Frame],[Shadow],[WorldX],[WorldY],[OffsetX],[OffsetY],[TileLength],[TileWidth],[Layer]) ' +
                      'VALUES ('+
                              IntToStr(iEncounterID) + ', '+
                              IntToStr(MyStatic.ISO_ID) +  ', '+
                              IntToStr(MyStatic.GroupID) +  ', "'+
                              MyStatic.DisplayName +  '", "'+
                              MyStatic.Frame  +  '", "'+
                              strShadows  +  '", '+
                              IntToStr(MyStatic.x) +  ', '+
                              IntToStr(MyStatic.y) +  ', '+
                              IntToStr(MyStatic.offSetX) +  ', '+
                              IntToStr(MyStatic.offSetY) +  ', '+
                              IntToStr(MyStatic.Length) +  ', '+
                              IntToStr(MyStatic.Width) +  ', '+
                              IntToStr(MyStatic.Layer) + ');';
        end;

        if TGameObject(ObjectList.items[iLoop]).MyType = otLight then
        begin
            MyLight := TLight(ObjectList.items[iLoop]);

            strSQL := 'INSERT INTO [tblISO_EncounterLights] ([EncounterID],[LightID],[GUID],[GroupID],[WorldX],' +
                      '[WorldY],[OffsetX],[OffsetY],[Height],[Width],[Blend],[Red],[Green],[Blue],[Flicker]) ' +
                      'VALUES (' +
                              IntToStr(iEncounterID) + ', '+
                              IntToStr(MyLight.ISO_ID) + ', "'+
                              MyLight.ID + '", '+
                              IntToStr(MyLight.GroupID) +  ', '+
                              IntToStr(MyLight.x) +  ', '+
                              IntToStr(MyLight.y) +  ', '+
                              IntToStr(MyLight.offSetX) +  ', '+
                              IntToStr(MyLight.offSetY) +  ', '+
                              IntToStr(MyLight.Height) +  ', '+
                              IntToStr(MyLight.Width) +  ', '+
                              IntToStr(MyLight.Blend) +  ', '+
                              IntToStr(MyLight.Red) +  ', '+
                              IntToStr(MyLight.Green) +  ', '+
                              IntToStr(MyLight.Blue) +  ', '+
                              IntToStr(MyLight.Flicker) +');';
        end;

        if TGameObject(ObjectList.items[iLoop]).MyType = otSprite then
        begin
            MySprite := TSprite(ObjectList.items[iLoop]);
            Case MySprite.SpriteType of
              stNPC:
                 strSQL := 'INSERT INTO [tblISO_EncounterCharacters] ( ' +
                            '[EncounterID],[ISO_CharacterID],[GUID],[Facing],[Side],' +
                            '[GroupID],[WorldX],[WorldY],[CharacterName],[CharType],' +
                            '[DefenseRating],[HealthRating],[AttackRating],[MoveRating],' +
                            '[SpellID],[PhyResist],[MagResist],[Hitpoints],[MinDamage],' +
                            '[MaxDamage],[Movement]) ' +
                             'VALUES('+
                                    IntToStr(iEncounterID) + ', '+
                                    IntToStr(MySprite.ISO_ID) +  ', "'+
                                    MySprite.ID +  '", '+
                                    IntToStr(MySprite.Facing) +  ', ' +
                                    IntToStr(MySprite.Side) +  ', ' +
                                    IntToStr(MySprite.GroupID) +  ', ' +
                                    IntToStr(MySprite.x) +  ', ' +
                                    IntToStr(MySprite.y) +  ', "' +
                                    MySprite.DisplayName +  '", ' +
                                    IntToStr(MySprite.CharType) + ', ' +
                                    IntToStr(MySprite.DefRating) + ', ' +
                                    IntToStr(MySprite.HealthRating) + ', ' +
                                    IntToStr(MySprite.AttRating) + ', ' +
                                    IntToStr(MySprite.MoveRating) + ', ' +
                                    IntToStr(MySprite.SpellID) + ', "' +
                                    MySprite.PhyResist + '", "' +
                                    MySprite.MagResist + '", ' +
                                    IntToStr(MySprite.HitPoints) + ', ' +
                                    IntToStr(MySprite.MinDamage) + ', ' +
                                    IntToStr(MySprite.MaxDamage) + ', ' +
                                    IntToStr(MySprite.Movement) +');';
              stSprite:

                 strSQL := 'INSERT INTO [tblISO_EncounterSprites] ('+
	                   '[EncounterID],[SpriteID],[GUID],[SpriteType],[GroupID],'+
                           '[Facing],[Side],[WorldX],[WorldY],[OffsetX],[OffsetY]) '+
                           'VALUES ('+
                                    IntToStr(iEncounterID) + ','+
                                    IntToStr(MySprite.ISO_ID) +  ',"'+
                                    MySprite.ID + '", '+
                                    '1' + ',' + // sprite type
                                    IntToStr(MySprite.GroupID) +  ','+
                                    IntToStr(MySprite.Facing) + ',' +  //facing
                                    '0' + ',' +  //side
                                    IntToStr(MySprite.x) +  ','+
                                    IntToStr(MySprite.y) +  ', '+
                                    IntToStr(MySprite.offSetX) +  ','+
                                    IntToStr(MySprite.offSetY) +');';

              stStart:
                  strSQL := 'INSERT INTO [tblISO_EncounterSprites] ('+
	                   '[EncounterID],[SpriteID],[GUID],[SpriteType],[GroupID],'+
                           '[Facing],[Side],[WorldX],[WorldY],[OffsetX],[OffsetY]) '+
                           'VALUES ('+
                                    IntToStr(iEncounterID) + ', '+
                                    IntToStr(MySprite.ISO_ID) +  ',"'+
                                    MySprite.ID + '", '+
                                    '2' + ',' + // sprite type
                                    IntToStr(MySprite.GroupID) +  ', '+
                                    IntToStr(MySprite.Facing) + ',' +  //facing
                                    '0' + ',' +  //side
                                    IntToStr(MySprite.x) +  ', '+
                                    IntToStr(MySprite.y) +  ', '+
                                    IntToStr(MySprite.offSetX) +  ', '+
                                    IntToStr(MySprite.offSetY) +');';
              stParticle:
                   strSQL := 'INSERT INTO [tblISO_EncounterSprites] ( '+
	                   '[EncounterID],[SpriteID],[GUID],[SpriteType],[GroupID],'+
                           '[Facing],[Side],[WorldX],[WorldY],[OffsetX],[OffsetY]) '+
                           'VALUES ('+
                                    IntToStr(iEncounterID) + ', '+
                                    IntToStr(MySprite.ISO_ID) +  ',"'+
                                    MySprite.ID + '", '+
                                    '3' + ',' + // sprite type
                                    IntToStr(MySprite.GroupID) +  ', '+
                                    IntToStr(MySprite.Facing) + ',' +  //facing
                                    '0' + ',' +  //side
                                    IntToStr(MySprite.x) +  ', '+
                                    IntToStr(MySprite.y) +  ', '+
                                    IntToStr(MySprite.offSetX) +  ', '+
                                    IntToStr(MySprite.offSetY) +');';
            end;
        end;
         objDB.ExecSQL(strSQL);
     end;

      //Write out BaseTiles
     BaseFileName := WriteOutTileTexture(imBaseTiles, WorkingFileName, 'Base');
     //Write out DiamondTiles
     DiamondFileName := WriteOutTileTexture(imDiamondTiles, WorkingFileName, 'Diamond');

     strTileMap := '';
     //Base Tiles
     for iLoop := 0 to MapHeight -1 do
     begin
          for jLoop := 0 to MapWidth -1 do
          begin
               strTileMap := strTileMap + IntToStr(BaseLayer[iLoop,jLoop]) + ' ';
          end
     end;
     //Diamond Tiles
     for iLoop := 0 to MapHeight -1 do
     begin
          for jLoop := 0 to MapWidth -1 do
          begin
               strTileMap := strTileMap + IntToStr(DiamondLayer[iLoop,jLoop]) + ' ';
          end
     end;
     //Collision Layer
     for iLoop := 0 to MapHeight -1 do
     begin
          for jLoop := 0 to MapWidth -1 do
          begin
               strTileMap := strTileMap + IntToStr(CollisionLayer[iLoop,jLoop]) + ' ';
          end
     end;
     //Start Layer
     for iLoop := 0 to MapHeight -1 do
     begin
          for jLoop := 0 to MapWidth -1 do
          begin
               strTileMap := strTileMap + IntToStr(StartLayer[iLoop,jLoop]) + ' ';
          end
     end;


     //Write Tile data to DB
     strSQL := 'INSERT INTO [tblISO_EncounterTiles] ([EncounterID], [BaseTile], ' +
               '[DiamondTile], [BaseCount], [DiamonCount], [MapWidth], [MapHeight], [TileMap]) ' +
                'VALUES ('+
                        IntToStr(iEncounterID) +', "'+
                        BaseFileName+'", "'+
                        DiamondFileName+'", '+
                        IntToStr(imBaseTiles.ImageCount)+', '+
                        IntToStr(imDiamondTiles.ImageCount)+', '+
                        IntToStr(MapWidth)+', '+
                        IntToStr(MapHeight)+', "'+
                        strTileMap+'");';

     objDB.ExecSQL(strSQL);


     for iLoop :=0 to frmSFX.lbSFXList.Items.Count -1 do
     begin
          MySFX := TSFX(frmSFX.lbSFXList.Items.Objects[iLoop]);
          strSQL := 'INSERT INTO [tblISO_EncounterSFX] ([EncounterID],[GUID],[Pan], [Rand], ' +
                    '[Inter], [PlayLoop], [SFXID], [SFXType]) ' +
                    'VALUES ('+
                             IntToStr(iEncounterID) +', "'+
                             MySFX.ID + '", '+
                             IntToStr(MySFX.Pan)+', '+
                             IntToStr(MySFX.Rand)+', '+
                             IntToStr(MySFX.Inter)+', '+
                             IntToStr(MySFX.Loop)+', '+
                             IntToStr(MySFX.SFXID)+', '+
                             IntToStr(MySFX.SFXType)+');';

         MySFX := nil;
         objDB.ExecSQL(strSQL);
     end;

     for iLoop :=0 to frmSFX.lbMusicList.Items.Count -1 do
     begin
          MySFX := TSFX(frmSFX.lbMusicList.Items.Objects[iLoop]);
          strSQL := 'INSERT INTO [tblISO_EncounterSFX] ([EncounterID],[GUID],[Pan], [Rand], ' +
                    '[Inter], [PlayLoop], [SFXID], [SFXType]) ' +
                    'VALUES ('+
                             IntToStr(iEncounterID) +', "'+
                             MySFX.ID + '", '+
                             IntToStr(MySFX.Pan)+', '+
                             IntToStr(MySFX.Rand)+', '+
                             IntToStr(MySFX.Inter)+', '+
                             IntToStr(MySFX.Loop)+', '+
                             IntToStr(MySFX.SFXID)+', '+
                             IntToStr(MySFX.SFXType)+');';
         MySFX := nil;
         objDB.ExecSQL(strSQL);
     end;


     objDB.free;

     ReBuildAutoExecScript;
     ReBuildScriptEvents;

     ScriptList.SaveToFile(ChangeFileExt(strScriptPath + WorkingFileName,'.lua'));
end;

function TfrmMain.WriteOutTileTexture(ImageManager: TImageManager; FileName: string; BaseName: string): string;
var
   iLoop: Integer;
   jLoop: Integer;
   MyBmp: TBitmap;
   BmpWidth: integer;
   BmpHeight: integer;
   BmpCol: integer;
   BmpRow: integer;
   iCurrnt: integer;
   ImageFileName: string;
   NG : TNGImage;
begin
         CaculateTextureSize(ImageManager.ImageCount, BmpWidth,BmpHeight,BmpRow, BmpCol);
         MyBmp := TBitmap.Create;
//         MyBmp.PixelFormat := pf32bit;
         MyBmp.Height := BmpHeight;
         MyBmp.Width := BmpWidth;
         MyBmp.Canvas.Brush.Color := clFuchsia;
         MyBmp.Canvas.FillRect(Rect(0,0,BmpWidth,BmpHeight));
         iCurrnt := 0;
         for iLoop := 0 to BmpRow -1 do
            for jLoop :=  0 to BmpCol -1 do
            begin
                if iCurrnt > ImageManager.ImageCount -1 {zero based}then continue;
                ImageManager.DrawImage(iCurrnt, MyBmp.canvas, (jLoop * TileWidth), (iLoop * TileHeight));
                inc(iCurrnt)
            end;
         ImageFileName := strTexturePath+ ChangeFileExt(extractfilename(filename), BaseName+'Tile.png');
        if FileExists(ImageFileName) then
           DeleteFile(ImageFileName);
        // MyBmp.SaveToFile(ChangeFileExt(ImageFileName,'.bmp'));
         NG := TNGImage.Create;
         NG.Assign(MyBmp);
         NG.SetAlphaColor(clFuchsia);
         NG.SaveToPNGfile(ImageFileName);
         MyBmp.FreeImage;
         MyBmp.free;
         NG.Free;

         Result := ExtractFileName(ImageFileName);

end;

procedure TfrmMain.ReBuildScriptEvents;
var
   iLoop : integer;
   EventStart: integer;
   EventStop: integer;
   MySprite: TSprite;
begin
  EventStart := -1;
  EventStop := -1;
  for iLoop := 0 to ScriptList.Count -1 do
  begin
      if EventStop > -1 then continue; //lots of 'end' statements
      
      if LowerCase(ScriptList.strings[iLoop]) = 'function loadevents()' then
      EventStart := iLoop;

      if EventStart > -1 then
        if LowerCase(ScriptList.strings[iLoop]) = 'end' then
          EventStop := iLoop;
  end;

  for iLoop := (EventStart+1) to (EventStop-1) do
     ScriptList.Delete(EventStart+1);

  for iLoop := 0 to ObjectList.Count -1 do
  begin
       if TGameObject(ObjectList.items[iLoop]).MyType = otSprite then
        begin
            MySprite := TSprite(ObjectList.items[iLoop]);
            if MySprite.IdleScript <> '' then
              ScriptList.Insert(EventStart+1,'regEvent("'+ MySprite.ID+'","'+MySprite.IdleScript+'");');
            if MySprite.CombatScript <> '' then
              ScriptList.Insert(EventStart+1,'regEvent("'+ MySprite.ID+'","'+MySprite.CombatScript+'");');
            if MySprite.OnActivate  <> '' then
              ScriptList.Insert(EventStart+1,'regEvent("'+ MySprite.ID+'","'+MySprite.OnActivate+'");');
            if MySprite.OnAttacked  <> '' then
              ScriptList.Insert(EventStart+1,'regEvent("'+ MySprite.ID+'","'+MySprite.OnAttacked+'");');
            if MySprite.OnClose  <> '' then
              ScriptList.Insert(EventStart+1,'regEvent("'+ MySprite.ID+'","'+MySprite.OnClose+'");');
            if MySprite.OnDie  <> '' then
              ScriptList.Insert(EventStart+1,'regEvent("'+ MySprite.ID+'","'+MySprite.OnDie+'");');
            if MySprite.OnFirstAttacked  <> '' then
              ScriptList.Insert(EventStart+1,'regEvent("'+ MySprite.ID+'","'+MySprite.OnFirstAttacked+'");');
            if MySprite.OnLoad  <> '' then
              ScriptList.Insert(EventStart+1,'regEvent("'+ MySprite.ID+'","'+MySprite.OnLoad+'");');
            if MySprite.OnOpen  <> '' then
              ScriptList.Insert(EventStart+1,'regEvent("'+ MySprite.ID+'","'+MySprite.OnOpen+'");');
        end;
  end;

end;

procedure TfrmMain.ReBuildAutoExecScript;
var
   iLoop : integer;
   EventStart: integer;
   EventStop: integer;
begin
  EventStart := -1;
  EventStop := -1;
  for iLoop := 0 to ScriptList.Count -1 do
  begin
      if EventStop > -1 then continue; //lots of 'end' statements

      if LowerCase(ScriptList.strings[iLoop]) = 'function autoexec()' then
      EventStart := iLoop;

      if EventStart > -1 then
        if LowerCase(ScriptList.strings[iLoop]) = 'end' then
          EventStop := iLoop;
  end;

  for iLoop := (EventStart+1) to (EventStop-1) do
     ScriptList.Delete(EventStart+1);

  ScriptList.Insert(EventStart+1,'changeMap("resources\\Data\\maps\\'+ExtractFileName(SaveDialog.filename)+'");');

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

procedure TfrmMain.LoadResourceBlock(var Input: TextFile);
var
   InputStr: string;
begin
    Readln(Input,InputStr);
    while InputStr <> 'EB' do
    begin
         Readln(Input,InputStr);
    end;
end;

procedure TfrmMain.LoadLevelBlock(var Input: TextFile);
var
   InputStr: string;
   tmpStr: string;
begin

    Readln(Input,InputStr);
    while InputStr <> 'EB' do
    begin
         tmpStr := StrTokenAt(InputStr,' ',0);
         if UpperCase(tmpStr) = 'AMBIENT' then
         begin
       //       LightColor := RGB(StrToInt(StrTokenAt(InputStr,' ',1)),StrToInt(StrTokenAt(InputStr,' ',2)),StrToInt(StrTokenAt(InputStr,' ',3)));
         end;
         if UpperCase(tmpStr) = 'SHADOW' then
         begin
         //     ShadowType := StrToInt(StrTokenAt(InputStr,' ',1));
         end;
         if UpperCase(tmpStr) = 'WEATHER' then
         begin
          //    Weather := StrToInt(StrTokenAt(InputStr,' ',1));
         end;

         Readln(Input,InputStr);
    end;
end;

procedure TfrmMain.LoadObjectBlock(var Input: TextFile);
var
   InputStr: string;
   tmpStr: string;
   MyBitMap: TBitMap;
   NewSprite: TSprite;
   NewStatic: TStatic;
   NewLight: TLight;
begin
    Readln(Input,InputStr);
    while InputStr <> 'EB' do
    begin
         if InputStr <> 'SB' then
         begin
             tmpStr := StrTokenAt(InputStr,' ',0);
             //Load Image and Sprite File
             if UpperCase(tmpStr) = 'NPC' then
             begin
                  //MyBitMap := ParseCharacterFile(strCharPath+ExtractFileName(StrTokenAt(InputStr,' ',7)));
                  NewSprite := TSprite.Create;
                  NewSprite.SpriteType := stNPC;
                  //NewSprite.FileName := StrTokenAt(InputStr,' ',7);
                  NewSprite.DisplayName := StrTokenAt(InputStr,' ',8);
                  NewSprite.ID := StrTokenAt(InputStr,' ',3);
                  NewSprite.Facing := StrToInt(StrTokenAt(InputStr,' ',1));
                  NewSprite.side := StrToInt(StrTokenAt(InputStr,' ',2));
                  NewSprite.GroupID := StrToInt(StrTokenAt(InputStr,' ',4));
                  NewSprite.GroupIndx := -1;
                  NewSprite.x := StrToInt(StrTokenAt(InputStr,' ',5));
                  NewSprite.y := StrToInt(StrTokenAt(InputStr,' ',6));
                  NewSprite.CharType := StrToInt(StrTokenAt(InputStr,' ',9));
                  NewSprite.DefRating := StrToInt(StrTokenAt(InputStr,' ',10));
                  NewSprite.HealthRating := StrToInt(StrTokenAt(InputStr,' ',11));
                  NewSprite.AttRating := StrToInt(StrTokenAt(InputStr,' ',12));
                  NewSprite.MoveRating := StrToInt(StrTokenAt(InputStr,' ',13));
                  NewSprite.SpellID := StrToInt(StrTokenAt(InputStr,' ',14));
                  NewSprite.PhyResist := StrTokenAt(InputStr,' ',15);
                  NewSprite.MagResist := StrTokenAt(InputStr,' ',16);
                  NewSprite.HitPoints := StrToInt(StrTokenAt(InputStr,' ',17));
                  NewSprite.MinDamage := StrToInt(StrTokenAt(InputStr,' ',18));
                  NewSprite.MaxDamage := StrToInt(StrTokenAt(InputStr,' ',19));
                  NewSprite.Movement := StrToInt(StrTokenAt(InputStr,' ',20));

                  NewSprite.Image := TBitMap.Create;
                  NewSprite.Image.TransparentColor := tmColor;
                  NewSprite.Image.TransparentMode := tmFixed;
                  NewSprite.Image.Transparent := true;
                  NewSprite.Image.Height :=MyBitMap.height;
                  NewSprite.Image.Width := MyBitMap.width;
                  NewSprite.Image.Canvas.Draw(0,0,MyBitMap);
                  NewSprite.Image.Dormant;
                  ObjectList.add(NewSprite);
                  SortSpriteList(ObjectList);
                  MyBitMap.FreeImage;
                  MyBitMap.Free;
                  NewSprite := nil;
             end;
             if UpperCase(tmpStr) = 'SPRITE' then
             begin
                  //MyBitMap := ParseSpriteFile(strSpritePath+ExtractFileName(StrTokenAt(InputStr,' ',7)));
                  NewSprite := TSprite.Create;
                  NewSprite.SpriteType := stSprite;
                  //NewSprite.FileName := StrTokenAt(InputStr,' ',7);
                  NewSprite.DisplayName := StrTokenAt(InputStr,' ',8);
                  NewSprite.ID :=  StrTokenAt(InputStr,' ',1);
                  NewSprite.GroupID :=  StrToInt(StrTokenAt(InputStr,' ',2));
                  NewSprite.GroupIndx := -1;
                  NewSprite.x :=  StrToInt(StrTokenAt(InputStr,' ',3));
                  NewSprite.y :=  StrToInt(StrTokenAt(InputStr,' ',4));
                  NewSprite.offSetX := StrToInt(StrTokenAt(InputStr,' ',5));
                  NewSprite.offSetY := StrToInt(StrTokenAt(InputStr,' ',6));
                  NewSprite.Image := TBitMap.Create;
                  NewSprite.Image.TransparentColor := tmColor;
                  NewSprite.Image.TransparentMode := tmFixed;
                  NewSprite.Image.Transparent := true;
                  NewSprite.Image.Height :=MyBitMap.height;
                  NewSprite.Image.Width := MyBitMap.width;
                  NewSprite.Image.Canvas.Draw(0,0,MyBitMap);
                  NewSprite.Image.Dormant;
                  ObjectList.add(NewSprite);
                  SortSpriteList(ObjectList);
                  MyBitMap.FreeImage;
                  MyBitMap.Free;
                  NewSprite := nil;
             end;
             if UpperCase(tmpStr) = 'START' then
             begin
                  NewSprite := TSprite.Create;
                  NewSprite.SpriteType := stStart;
                  NewSprite.ID := StrTokenAt(InputStr,' ',2);
                  NewSprite.Facing := StrToInt(StrTokenAt(InputStr,' ',1));;
                  NewSprite.GroupID := StrToInt(StrTokenAt(InputStr,' ',3));;
                  NewSprite.GroupIndx := -1;
                  NewSprite.x := StrToInt(StrTokenAt(InputStr,' ',4));
                  NewSprite.y := StrToInt(StrTokenAt(InputStr,' ',5));
                  ObjectList.add(NewSprite);
                  SortSpriteList(ObjectList);
                  NewSprite := nil;
             end;

             if UpperCase(tmpStr) = 'LIGHT' then
             begin
                  NewLight := TLight.Create;
                  NewLight.ID := StrTokenAt(InputStr,' ',1);
                  NewLight.GroupID := StrToInt(StrTokenAt(InputStr,' ',2));;
                  NewLight.GroupIndx := -1;
                  NewLight.x := StrToInt(StrTokenAt(InputStr,' ',3));
                  NewLight.y := StrToInt(StrTokenAt(InputStr,' ',4));
                  NewLight.offSetX := StrToInt(StrTokenAt(InputStr,' ',5));
                  NewLight.offSetY := StrToInt(StrTokenAt(InputStr,' ',6));
                  NewLight.Width := StrToInt(StrTokenAt(InputStr,' ',7));
                  NewLight.Height := StrToInt(StrTokenAt(InputStr,' ',8));
                  NewLight.Blend := StrToInt(StrTokenAt(InputStr,' ',9));
                  NewLight.Red := StrToInt(StrTokenAt(InputStr,' ',10));
                  NewLight.Green := StrToInt(StrTokenAt(InputStr,' ',11));
                  NewLight.Blue := StrToInt(StrTokenAt(InputStr,' ',12));
                  NewLight.Flicker :=  StrToInt(StrTokenAt(InputStr,' ',13));

                  ObjectList.add(NewLight);
                 // SortSpriteList(ObjectList);
                  NewLight := nil;
             end;

                           //Load Image and Sprite File
              if UpperCase(tmpStr) = 'STATIC' then
              begin
                  NewStatic := TStatic.Create;
                  //NewStatic.FileName := StrTokenAt(InputStr,' ',12);
                  NewStatic.ID := StrTokenAt(InputStr,' ',1);
                  NewStatic.GroupID := StrToInt(StrTokenAt(InputStr,' ',2));
                  NewStatic.GroupIndx := -1;
                  NewStatic.Frame := StrTokenAt(InputStr,' ',3);
                  NewStatic.x := StrToInt(StrTokenAt(InputStr,' ',4));
                  NewStatic.y := StrToInt(StrTokenAt(InputStr,' ',5));
                  NewStatic.offSetX  := StrToInt(StrTokenAt(InputStr,' ',6));
                  NewStatic.offSetY  := StrToInt(StrTokenAt(InputStr,' ',7));
                  NewStatic.Length := StrToInt(StrTokenAt(InputStr,' ',8));
                  NewStatic.Width := StrToInt(StrTokenAt(InputStr,' ',9));
                  NewStatic.Layer := StrToInt(StrTokenAt(InputStr,' ',10));
                  if StrTokenAt(InputStr,' ',11) = '1' then
                  NewStatic.Shadow := true
                  else
                   NewStatic.Shadow := false;

                  //MyBitMap := ParseStatic(strStaticPath+ExtractFileName(StrTokenAt(InputStr,' ',12)),NewStatic.Frame);
                  NewStatic.Image := TBitMap.Create;
                  NewStatic.Image.TransparentColor := tmColor;
                  NewStatic.Image.TransparentMode := tmFixed;
                  NewStatic.Image.Transparent := true;
                  NewStatic.Image.Height :=MyBitMap.height;
                  NewStatic.Image.Width := MyBitMap.width;
                  NewStatic.Image.Canvas.Draw(0,0,MyBitMap);
                  NewStatic.Image.Dormant;
                  ObjectList.add(NewStatic);
                  SortSpriteList(ObjectList);
                  MyBitMap.FreeImage;
                  MyBitMap.Free;
                  NewStatic := nil;
              end;
         end;
         Readln(Input,InputStr);
    end;
end;

procedure TfrmMain.LoadFromFile;
var
   Input: TextFile;
   BaseTileName: String;
   DiamondTileName: string;
   BaseTileCount: integer;
   DiamondTileCount: integer;
   tmpStr: string;
   iLoop: integer;
   jLoop: integer;
   tileCounter: integer;

begin
     OpenDialog.InitialDir := ExtractFilePath(strMapPath);
     if OpenDialog.execute then
     begin
         MapLoading := true;
         if fileexists(ChangeFileExt(strScriptPath + ExtractFileName(OpenDialog.filename),'.lua')) then
            ScriptList.LoadFromFile(ChangeFileExt(strScriptPath + ExtractFileName(OpenDialog.filename),'.lua'));

         AssignFile(Input, OpenDialog.fileName);
         ReSet(Input);
         LoadResourceBlock(Input);
         LoadLevelBlock(Input);
         LoadObjectBlock(Input);
         //Readln(Input,tmpStr);//TileBlock
         Readln(Input,BaseTileName);
         Readln(Input,DiamondTileName);
         Readln(Input,tmpStr);
         BaseTileCount := StrToInt(strTokenAt(tmpStr,' ',0));
         DiamondTileCount := StrToInt(strTokenAt(tmpStr,' ',1));
         MapWidth := StrToInt(strTokenAt(tmpStr,' ',2));
         MapHeight := StrToInt(strTokenAt(tmpStr,' ',3));
        // Readln(Input,tmpStr);//EndBlock
        // Readln(Input,tmpStr);//MapBlock
         ScrollBarY.Max  := MapHeight -36;
         ScrollBarX.Max  := MapWidth -12;
         TileCount := MapWidth * MapHeight;
         BaseTileName := strTexturePath+BaseTileName;
         DiamondTileName := strTexturePath+DiamondTileName ;
         LoadTileSheet(0,BaseTileList, imBaseTiles, BaseTileName, BaseTileCount);
         LoadTileSheet(1,DiamondTileList, imDiamondTiles, DiamondTileName, DiamondTileCount);


         CreateMap(MapWidth,MapHeight);
         Readln(Input,tmpStr);
         tileCounter := 0;
         //Read the base layer from map file
         for iLoop := 0 to MapHeight -1 do
            for jLoop := 0 to MapWidth -1 do
            begin
               BaseLayer[iLoop,jLoop] := StrToInt(StrTokenAt(tmpStr,' ',tileCounter));
               inc(tileCounter)
            end;

         //Read the Diamond layer from map file
         for iLoop := 0 to MapHeight -1 do
            for jLoop := 0 to MapWidth -1 do
            begin
               DiamondLayer[iLoop,jLoop] := StrToInt(StrTokenAt(tmpStr,' ',tileCounter));
               inc(tileCounter)
            end;

         //Read the collision layer from map file
         for iLoop := 0 to MapHeight -1 do
            for jLoop := 0 to MapWidth -1 do
            begin
               CollisionLayer[iLoop,jLoop] := StrToInt(StrTokenAt(tmpStr,' ',tileCounter));
               inc(tileCounter)
            end;

         //Read Start Layer
         for iLoop := 0 to MapHeight -1 do
              for jLoop := 0 to MapWidth -1 do
              begin
                   StartLayer[iLoop,jLoop] := StrToInt(StrTokenAt(tmpStr,' ',tileCounter));
                   inc(tileCounter)
              end;

         CloseFile(Input);
         MapLoading := false;
         RefreshScreen;
     end;
end;

procedure TfrmMain.LoadFromDatabase();
var
   objDB: TSQLiteDatabase;
   objDS: TSQLIteTable;
   strSQL: String;
   bUseShadows: boolean;
   MyBitMap: TBitMap;
   NewSprite: TSprite;
   NewStatic: TStatic;
   NewLight: TLight;
   strTileMap: string;
   BaseTileName: String;
   DiamondTileName: string;
   BaseTileCount: integer;
   DiamondTileCount: integer;
   iLoop: integer;
   jLoop: integer;
   tileCounter: integer;
   MySFX: TSFX;
   tmpStr: string;
begin
        MapLoading := true;

        frmMapList.Setup(strDatabase);
        frmMapList.ShowModal();
        iEncounterID := frmMapList.iEncounterID;
        if iEncounterID > -1 then
        begin
             objDB := TSQLiteDatabase.Create(strDatabase);
             //Load the encounter
             strSQL := 'SELECT  [EncounterID],[MapType],[MapName],[Description],[AmbientR],[AmbientG],[AmbientB],[ArmySize],[WalkSFX], ' +
                       '[UseShadows],[CloudBlend],[WindDir],[Snow],[FogType],[FogBlend],[FogR],[FogG],[FogB],[FogTextureID],[ScriptFile] ' +
                       'FROM  [tblISO_Encounter] WHERE [EncounterID] ='+  IntToStr(iEncounterID);
             objDS := objDB.GetTable(strSQL);
             if objDS.Count > 0 then
             begin
                  if objDS.FieldAsString(objDS.FieldIndex['UseShadows'])='1' then
                     bUseShadows := true
                  else
                     bUseShadows := false;

                  MapPropeties.MapName := objDS.FieldAsString(objDS.FieldIndex['MapName']);
                  MapPropeties.LightColor := RGB(StrToInt(objDS.FieldAsString(objDS.FieldIndex['AmbientR'])),StrToInt(objDS.FieldAsString(objDS.FieldIndex['AmbientG'])),StrToInt(objDS.FieldAsString(objDS.FieldIndex['AmbientB'])));
                  MapPropeties.MapType := StrToInt(objDS.FieldAsString(objDS.FieldIndex['MapType']));
                  MapPropeties.MapDesc := objDS.FieldAsString(objDS.FieldIndex['Description']);
                  MapPropeties.UseShadows := bUseShadows;
                  MapPropeties.CloudBlend  := StrToInt(objDS.FieldAsString(objDS.FieldIndex['CloudBlend']));
                  MapPropeties.WindDirect := StrToInt(objDS.FieldAsString(objDS.FieldIndex['WindDir']));
                  MapPropeties.SnowFlakes := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Snow']));
                  MapPropeties.ArmySize := StrToInt(objDS.FieldAsString(objDS.FieldIndex['ArmySize']));
                  MapPropeties.FogType := StrToInt(objDS.FieldAsString(objDS.FieldIndex['FogType']));
                  MapPropeties.FogColor := RGB(StrToInt(objDS.FieldAsString(objDS.FieldIndex['FogR'])),StrToInt(objDS.FieldAsString(objDS.FieldIndex['FogG'])),StrToInt(objDS.FieldAsString(objDS.FieldIndex['FogB'])));
                  MapPropeties.FogBlend := StrToInt(objDS.FieldAsString(objDS.FieldIndex['FogBlend']));
                  MapPropeties.FogText := StrToInt(objDS.FieldAsString(objDS.FieldIndex['FogTextureID']));
                  MapPropeties.WalkSfx :=  StrToInt(objDS.FieldAsString(objDS.FieldIndex['WalkSFX']));
                  if FileExists(strScriptPath + objDS.FieldAsString(objDS.FieldIndex['ScriptFile'])) then
                     ScriptList.LoadFromFile(strScriptPath + objDS.FieldAsString(objDS.FieldIndex['ScriptFile']));
             end;
             objDS.free;


             //Load the encounter Statics
             strSQL := 'SELECT [ID],[EncounterID],[StaticID],[StaticName],[GroupID],[Shadow],[Frame],[WorldX],'+
                       '[WorldY],[OffsetX],[OffsetY],[TileLength],[TileWidth],[Layer] '+
                       'FROM [tblISO_EncounterStatics] '+
                       'WHERE [EncounterID] =' +  IntToStr(iEncounterID);
             objDS := objDB.GetTable(strSQL);
             if objDS.Count > 0 then
             begin
                  while not objDS.EOF do
                  begin
                      try
                         NewStatic := TStatic.Create;
                         //NewStatic.FileName := StrTokenAt(InputStr,' ',12);
                         NewStatic.ISO_ID := StrToInt(objDS.FieldAsString(objDS.FieldIndex['StaticID']));
                         NewStatic.GroupID := StrToInt(objDS.FieldAsString(objDS.FieldIndex['GroupID']));
                         NewStatic.GroupIndx := -1;
                         NewStatic.Frame := objDS.FieldAsString(objDS.FieldIndex['Frame']);
                         NewStatic.x := StrToInt(objDS.FieldAsString(objDS.FieldIndex['WorldX']));
                         NewStatic.y := StrToInt(objDS.FieldAsString(objDS.FieldIndex['WorldY']));
                         NewStatic.offSetX  := StrToInt(objDS.FieldAsString(objDS.FieldIndex['OffsetX']));
                         NewStatic.offSetY  := StrToInt(objDS.FieldAsString(objDS.FieldIndex['OffsetY']));
                         NewStatic.Length := StrToInt(objDS.FieldAsString(objDS.FieldIndex['TileLength']));
                         NewStatic.Width := StrToInt(objDS.FieldAsString(objDS.FieldIndex['TileWidth']));
                         NewStatic.Layer := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Layer']));
                         if objDS.FieldAsString(objDS.FieldIndex['Shadow']) = '1' then
                            NewStatic.Shadow := true
                         else
                             NewStatic.Shadow := false;

                         MyBitMap := LoadStatic( IntToStr(NewStatic.ISO_ID), NewStatic.Frame);
                         NewStatic.Image := TBitMap.Create;
                         NewStatic.Image.TransparentColor := tmColor;
                         NewStatic.Image.TransparentMode := tmFixed;
                         NewStatic.Image.Transparent := true;
                         NewStatic.Image.Height :=MyBitMap.height;
                         NewStatic.Image.Width := MyBitMap.width;
                         NewStatic.Image.Canvas.Draw(0,0,MyBitMap);
                         NewStatic.Image.Dormant;
                         ObjectList.add(NewStatic);
                         SortSpriteList(ObjectList);
                         MyBitMap.FreeImage;
                         MyBitMap.Free;
                         NewStatic := nil;
                      finally
                             objDS.Next;
                      end;
                  end;
             end;
             objDS.free;


             //Load the encounter Sprites
             strSQL := 'SELECT [ID],[EncounterID],[SpriteID],[GUID],[SpriteType],[GroupID], ' +
                        '[Facing],[Side],[WorldX],[WorldY],[OffsetX],[OffsetY] ' +
                        'FROM  [tblISO_EncounterSprites] ' +
                        'WHERE [EncounterID] = ' +  IntToStr(iEncounterID);

             objDS := objDB.GetTable(strSQL);
             if objDS.Count > 0 then
             begin
                  while not objDS.EOF do
                  begin
                      try
                         //load normal sprites
                         if objDS.FieldAsString(objDS.FieldIndex['SpriteType'])='1' then
                         begin
                              MyBitMap := LoadSprite(objDS.FieldAsString(objDS.FieldIndex['SpriteID']));
                              NewSprite := TSprite.Create;
                              NewSprite.SpriteType := stSprite;
                              //NewSprite.FileName := StrTokenAt(InputStr,' ',7);
                              NewSprite.DisplayName := objDS.FieldAsString(objDS.FieldIndex['OffsetY']);
                              NewSprite.ISO_ID :=  StrToInt(objDS.FieldAsString(objDS.FieldIndex['SpriteID']));
                              NewSprite.ID :=  objDS.FieldAsString(objDS.FieldIndex['GUID']);
                              NewSprite.GroupID :=  StrToInt(objDS.FieldAsString(objDS.FieldIndex['GroupID']));
                              NewSprite.GroupIndx := -1;
                              NewSprite.x :=  StrToInt(objDS.FieldAsString(objDS.FieldIndex['WorldX']));
                              NewSprite.y :=  StrToInt(objDS.FieldAsString(objDS.FieldIndex['WorldY']));
                              NewSprite.offSetX := StrToInt(objDS.FieldAsString(objDS.FieldIndex['OffsetX']));
                              NewSprite.offSetY := StrToInt(objDS.FieldAsString(objDS.FieldIndex['OffsetY']));
                              NewSprite.Image := TBitMap.Create;
                              NewSprite.Image.TransparentColor := tmColor;
                              NewSprite.Image.TransparentMode := tmFixed;
                              NewSprite.Image.Transparent := true;
                              NewSprite.Image.Height :=MyBitMap.height;
                              NewSprite.Image.Width := MyBitMap.width;
                              NewSprite.Image.Canvas.Draw(0,0,MyBitMap);
                              NewSprite.Image.Dormant;
                              ObjectList.add(NewSprite);
                              SortSpriteList(ObjectList);
                              MyBitMap.FreeImage;
                              MyBitMap.Free;
                              NewSprite := nil;
                         end;
                         //load start points
                         if objDS.FieldAsString(objDS.FieldIndex['SpriteType'])='2' then
                         begin
                              NewSprite := TSprite.Create;
                              NewSprite.SpriteType := stStart;
                              NewSprite.ISO_ID := StrToInt(objDS.FieldAsString(objDS.FieldIndex['SpriteID']));
                              NewSprite.ID :=  objDS.FieldAsString(objDS.FieldIndex['GUID']);
                              NewSprite.Facing := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Facing']));;
                              NewSprite.GroupID := StrToInt(objDS.FieldAsString(objDS.FieldIndex['GroupID']));;
                              NewSprite.GroupIndx := -1;
                              NewSprite.x := StrToInt(objDS.FieldAsString(objDS.FieldIndex['WorldX']));
                              NewSprite.y := StrToInt(objDS.FieldAsString(objDS.FieldIndex['WorldY']));
                              ObjectList.add(NewSprite);
                              SortSpriteList(ObjectList);
                              NewSprite := nil;
                         end;

                      finally
                             objDS.Next;
                      end;
                  end;
             end;
             objDS.free;

             //Load encounter Characters
              strSQL := 'SELECT [ID],[EncounterID],[ISO_CharacterID],[GUID],[Facing], ' +
                        '[Side],[GroupID],[WorldX],[WorldY],[CharacterName], ' +
                        '[CharType],[DefenseRating],[HealthRating],[AttackRating], ' +
                        '[MoveRating],[SpellID],[PhyResist],[MagResist], ' +
                        '[Hitpoints],[MinDamage],[MaxDamage],[Movement] ' +
                        'FROM  [tblISO_EncounterCharacters] ' +
                        'WHERE [EncounterID] = ' +  IntToStr(iEncounterID);
             objDS := objDB.GetTable(strSQL);
             if objDS.Count > 0 then
             begin
                  while not objDS.EOF do
                  begin
                      try
                       MyBitMap := LoadCharacter(objDS.FieldAsString(objDS.FieldIndex['ISO_CharacterID']));
                        NewSprite := TSprite.Create;
                        NewSprite.SpriteType := stNPC;
                        //NewSprite.FileName := StrTokenAt(InputStr,' ',7);
                        NewSprite.DisplayName := objDS.FieldAsString(objDS.FieldIndex['CharacterName']);
                        NewSprite.ISO_ID := StrToInt(objDS.FieldAsString(objDS.FieldIndex['ISO_CharacterID']));
                        NewSprite.ID := objDS.FieldAsString(objDS.FieldIndex['GUID']);
                        NewSprite.Facing := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Facing']));
                        NewSprite.side := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Side']));
                        NewSprite.GroupID := StrToInt(objDS.FieldAsString(objDS.FieldIndex['GroupID']));
                        NewSprite.GroupIndx := -1;
                        NewSprite.x := StrToInt(objDS.FieldAsString(objDS.FieldIndex['WorldX']));
                        NewSprite.y := StrToInt(objDS.FieldAsString(objDS.FieldIndex['WorldY']));
                        NewSprite.CharType := StrToInt(objDS.FieldAsString(objDS.FieldIndex['CharType']));
                        NewSprite.DefRating := StrToInt(objDS.FieldAsString(objDS.FieldIndex['DefenseRating']));
                        NewSprite.HealthRating := StrToInt(objDS.FieldAsString(objDS.FieldIndex['HealthRating']));
                        NewSprite.AttRating := StrToInt(objDS.FieldAsString(objDS.FieldIndex['AttackRating']));
                        NewSprite.MoveRating := StrToInt(objDS.FieldAsString(objDS.FieldIndex['MoveRating']));
                        NewSprite.SpellID := StrToInt(objDS.FieldAsString(objDS.FieldIndex['SpellID']));
                        NewSprite.PhyResist := objDS.FieldAsString(objDS.FieldIndex['PhyResist']);
                        NewSprite.MagResist := objDS.FieldAsString(objDS.FieldIndex['MagResist']);
                        NewSprite.HitPoints := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Hitpoints']));
                        NewSprite.MinDamage := StrToInt(objDS.FieldAsString(objDS.FieldIndex['MinDamage']));
                        NewSprite.MaxDamage := StrToInt(objDS.FieldAsString(objDS.FieldIndex['MaxDamage']));
                        NewSprite.Movement := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Movement']));

                        NewSprite.Image := TBitMap.Create;
                        NewSprite.Image.TransparentColor := tmColor;
                        NewSprite.Image.TransparentMode := tmFixed;
                        NewSprite.Image.Transparent := true;
                        NewSprite.Image.Height :=MyBitMap.height;
                        NewSprite.Image.Width := MyBitMap.width;
                        NewSprite.Image.Canvas.Draw(0,0,MyBitMap);
                        NewSprite.Image.Dormant;
                        ObjectList.add(NewSprite);
                        SortSpriteList(ObjectList);
                        MyBitMap.FreeImage;
                        MyBitMap.Free;
                        NewSprite := nil;

                      finally
                             objDS.Next;
                      end;
                  end;
             end;
             objDS.free;


             //Load encounter Light Source
             strSQL := 'SELECT [ID],[EncounterID],[LightID],[GUID],[GroupID],[WorldX],[WorldY],[OffsetX], ' +
                        '[OffsetY],[Height],[Width],[Blend],[Red],[Green],[Blue],[Flicker] ' +  
                        'FROM [tblISO_EncounterLights] ' +
                        'WHERE [EncounterID] = ' +  IntToStr(iEncounterID);
             objDS := objDB.GetTable(strSQL);
             if objDS.Count > 0 then
             begin
                  while not objDS.EOF do
                  begin
                      try
                        NewLight := TLight.Create;
                        NewLight.ISO_ID := StrToInt(objDS.FieldAsString(objDS.FieldIndex['LightID']));
                        NewLight.ID := objDS.FieldAsString(objDS.FieldIndex['GUID']);
                        NewLight.GroupID := StrToInt(objDS.FieldAsString(objDS.FieldIndex['GroupID']));
                        NewLight.GroupIndx := -1;
                        NewLight.x := StrToInt(objDS.FieldAsString(objDS.FieldIndex['WorldX']));
                        NewLight.y := StrToInt(objDS.FieldAsString(objDS.FieldIndex['WorldY']));
                        NewLight.offSetX := StrToInt(objDS.FieldAsString(objDS.FieldIndex['OffsetX']));
                        NewLight.offSetY := StrToInt(objDS.FieldAsString(objDS.FieldIndex['OffsetY']));
                        NewLight.Width := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Width']));
                        NewLight.Height := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Height']));
                        NewLight.Blend := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Blend']));
                        NewLight.Red := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Red']));
                        NewLight.Green := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Green']));
                        NewLight.Blue := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Blue']));
                        NewLight.Flicker :=  StrToInt(objDS.FieldAsString(objDS.FieldIndex['Flicker']));

                        ObjectList.add(NewLight);
                       // SortSpriteList(ObjectList);
                        NewLight := nil;
                      finally
                          objDS.Next;
                      end;
                  end;
             end;
             objDS.free;

             //load encounter tiles
             strSQL := 'SELECT [ID],[EncounterID],[BaseTile],[DiamondTile],[BaseCount], '+
                     '[DiamonCount],[MapWidth],[MapHeight],[TileMap] '+
                     'FROM [tblISO_EncounterTiles]  '+
                     'WHERE [EncounterID] = ' +  IntToStr(iEncounterID);
             objDS := objDB.GetTable(strSQL);
             if objDS.Count > 0 then
             begin
                  BaseTileName := objDS.FieldAsString(objDS.FieldIndex['BaseTile']);
                  DiamondTileName := objDS.FieldAsString(objDS.FieldIndex['DiamondTile']);
                  BaseTileCount := StrToInt(objDS.FieldAsString(objDS.FieldIndex['BaseCount']));
                  DiamondTileCount := StrToInt(objDS.FieldAsString(objDS.FieldIndex['DiamonCount']));
                  MapWidth := StrToInt(objDS.FieldAsString(objDS.FieldIndex['MapWidth']));
                  MapHeight := StrToInt(objDS.FieldAsString(objDS.FieldIndex['MapHeight']));
                  strTileMap :=  objDS.FieldAsString(objDS.FieldIndex['TileMap']);

                  ScrollBarY.Max  := MapHeight -36;
                  ScrollBarX.Max  := MapWidth -12;
                  TileCount := MapWidth * MapHeight;
                  BaseTileName := strTexturePath+BaseTileName;
                  DiamondTileName := strTexturePath+DiamondTileName ;
                  LoadTileSheet(0,BaseTileList, imBaseTiles, BaseTileName, BaseTileCount);
                  LoadTileSheet(1,DiamondTileList, imDiamondTiles, DiamondTileName, DiamondTileCount);


                  CreateMap(MapWidth,MapHeight);

                  tileCounter := 0;
                  //Read the base layer from map file
                  for iLoop := 0 to MapHeight -1 do
                      for jLoop := 0 to MapWidth -1 do
                      begin
                           BaseLayer[iLoop,jLoop] := StrToInt(StrTokenAt(strTileMap,' ',tileCounter));
                           inc(tileCounter)
                      end;

                  //Read the Diamond layer from map file
                  for iLoop := 0 to MapHeight -1 do
                      for jLoop := 0 to MapWidth -1 do
                      begin
                           DiamondLayer[iLoop,jLoop] := StrToInt(StrTokenAt(strTileMap,' ',tileCounter));
                           inc(tileCounter)
                      end;

                  //Read the collision layer from map file
                  for iLoop := 0 to MapHeight -1 do
                      for jLoop := 0 to MapWidth -1 do
                      begin
                           CollisionLayer[iLoop,jLoop] := StrToInt(StrTokenAt(strTileMap,' ',tileCounter));
                           inc(tileCounter)
                      end;

                  //Read Start Layer
                  for iLoop := 0 to MapHeight -1 do
                      for jLoop := 0 to MapWidth -1 do
                      begin
                           StartLayer[iLoop,jLoop] := StrToInt(StrTokenAt(strTileMap,' ',tileCounter));
                           inc(tileCounter)
                      end;

             end;
             objDS.free;


             //Load SFX and Music
             strSQL := 'SELECT [EncounterID], [GUID], [Pan], [Rand], ' +
                       '[Inter], [PlayLoop], [SFXID], [SFXType] ' +
                        'FROM [tblISO_EncounterSFX] ' +
                        'WHERE [EncounterID] = ' +  IntToStr(iEncounterID);
             objDS := objDB.GetTable(strSQL);
             if objDS.Count > 0 then
             begin
                  while not objDS.EOF do
                  begin
                      try
                         MySFX := TSFX.Create();
                         MySFX.ID := objDS.FieldAsString(objDS.FieldIndex['GUID']);
                         MySFX.Rand := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Rand']));
                         MySFX.Pan := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Pan']));
                         MySFX.Inter := StrToInt(objDS.FieldAsString(objDS.FieldIndex['Inter']));
                         MySFX.Loop := StrToInt(objDS.FieldAsString(objDS.FieldIndex['PlayLoop']));
                         MySFX.SfxID := StrToInt(objDS.FieldAsString(objDS.FieldIndex['SFXID']));
                         MySFX.SFXType := StrToInt(objDS.FieldAsString(objDS.FieldIndex['SFXType']));
                         MySFX.SFXName := frmSFX.slNameLookup.Values[objDS.FieldAsString(objDS.FieldIndex['SFXID'])];
                         if MySFX.SFXType = 5 then
                           frmSFX.lbMusicList.Items.AddObject(MySFX.SFXName,MySFX)
                         else
                         if MySFX.SFXType = 4 then
                           frmSFX.lbSFXList.Items.AddObject(MySFX.SFXName,MySFX)
                         else
                         MySFX := nil;
                      finally
                          objDS.Next;
                      end;
                  end;
             end;
             objDS.free;


             objDB.Free;
             MapLoading := false;
             RefreshScreen;
        end;
end;

procedure TfrmMain.LoadTileSheet(layer: integer; TileList: TList; ImageManager: TImageManager; FileName: string; count: integer);
var
  iLoop: Integer;
  jLoop: Integer;
  TileTexture: TBitmap;
  BmpWidth: integer;
  BmpHeight: integer;
  BmpCol: integer;
  BmpRow: integer;
  MyBmp: TBitmap;
  iCurrnt: integer;
  SourceRect, DestRect: TRect;
  NG : TNGImage;
  NewTile: TTile;
begin
   ImageManager.Clear;
   TileTexture := TBitmap.Create;

   NG := TNGImage.Create;
   NG.SetAlphaColor(tmColor);
   NG.Transparent := true;
   NG.TransparentColor := tmColor;
   NG.LoadFromFile(FileName);
   TileTexture.Assign(NG.CopyBitmap);
   NG.Free;
  //Load the tile sheet into memory
   TileTexture.Dormant;
   CaculateTextureSize(count, BmpWidth,BmpHeight,BmpRow, BmpCol);
   //Load a temp bmp to copy each tile too
   MyBmp := TBitmap.Create;
   if layer > 0 then
   begin
        MyBmp.TransparentColor := tmColor;
        MyBmp.TransparentMode := tmFixed;
        MyBmp.Transparent := true;
   end;
   MyBmp.Height := TileHeight;
   MyBmp.Width := TileWidth;
   MyBmp.Canvas.Brush.Color := tmColor;
   DestRect := Rect(0,0,TileWidth,TileHeight);
   iCurrnt := 0;
   for iLoop := 0 to BmpRow -1 do
      for jLoop :=  0 to BmpCol -1 do
      begin
          if iCurrnt > count -1 {zero based}then continue;
          //Copy each tile from the tile sheet to the tmp bmp
          SourceRect.top := (iLoop * TileHeight);
          SourceRect.left := (jLoop * TileWidth);
          SourceRect.Right := (jLoop * TileWidth) + TileWidth;
          SourceRect.Bottom :=  (iLoop * TileHeight) + TileHeight;
          MyBmp.Canvas.FillRect(Rect(0,0,TileWidth,TileHeight));
          MyBmp.Canvas.CopyRect(DestRect,TileTexture.Canvas,SourceRect);

          //Add the tmp bmp to the image manger collection
          ImageManager.AddImage2(MyBmp);
          NewTile := TTile.Create;
          NewTile.FileName := SelectTileName;
          NewTile.ID :=  ImageManager.ImageCount -1;
          TileList.add(NewTile);

          inc(iCurrnt);
      end;

   MyBmp.FreeImage;
   MyBmp.free;
   TileTexture.FreeImage;
   TileTexture.Free;
end;


procedure TfrmMain.mnuSaveClick(Sender: TObject);
begin
    mnuMergQuadClick(sender);
    //SaveToFile;
    SaveToDatabase;
end;

procedure TfrmMain.mnuOpenClick(Sender: TObject);
begin
     //LoadFromFile;
     frmMapProp.Setup(strDatabase);
     frmSFX.Setup(strDatabase);
     LoadFromDatabase;
       cbBase.checked := true;
       cbDiamond.checked  := true;
       cbCollision.checked  := true;
       cbSprite.checked  := true;
       cbStatic.checked  := true;
       cbLight.checked  := true;
     RefreshScreen;
     Panel1.Enabled := true;
end;

procedure TfrmMain.mnuNewMapClick(Sender: TObject);
var
   NewTile: TTile;
begin
        frmMapProp.Setup(strDatabase);
        frmSFX.Setup(strDatabase);
        
        frmNewMap.showmodal;
        MapPropeties.MapName := 'New Map';
        MapPropeties.LightLevel := 100;
        MapPropeties.LightColor := 0;
        MapPropeties.MapType := 2;//multiplayer map
        MapPropeties.MapDesc := '';
        MapPropeties.ScriptFile := '';
        MapPropeties.UseShadows := true;
        MapPropeties.CloudBlend := 0;
        MapPropeties.WindDirect := 0;
        MapPropeties.SnowFlakes := 0;
        MapPropeties.FogType := 0;
        MapPropeties.FogColor := 0;
        MapPropeties.FogBlend := 0;
        MapPropeties.FogText := 0;
        MapPropeties.WalkSfx := 30;
        MapPropeties.ArmySize := 5;
        
        MainImgMngr.Clear;
        imDiamondTiles.Clear;
        imBaseTiles.Clear;
        EmptyTList(DiamondTileList);
        DiamondTileList.clear;
        EmptyTList(BaseTileList);
        BaseTileList.clear;
        EmptyTList(ObjectList);
        ObjectList.clear;
        QuadCollection.ClearAll;
        SelectedList.clear;
        ScriptList.clear;
        RandomTileList.clear;
        AddTileZero;

        MapWidth := StrToInt(frmNewMap.edtMapWidth.text);
        MapHeight := StrToInt(frmNewMap.edtMapHeight.text);
        TileWidth := StrToInt(frmNewMap.edtTileWidth.text);
        TileHeight := StrToInt(frmNewMap.edtTileHeight.text);
        TileHalfWidth := TileWidth div 2;
        TileHalfHeight := TileHeight div 2;
        Tile2xWidth :=  TileWidth * 2;
        Tile2xHeight :=  TileHeight * 2;
        ScrollBarY.Max  := MapHeight -37;
        ScrollBarX.Max  := MapWidth -12;
        TileCount := MapWidth * MapHeight;
        CreateMap(MapWidth,MapHeight);
        BuildScript('NewMap.map');
        iEncounterID := 0;
        RefreshScreen;
        ShowMapPropertiesWindow;
        Panel1.Enabled := true;

end;

procedure TfrmMain.CreateMap(w: integer; h: integer);
var
   iLoop: integer;
begin
     BaseLayer := nil;
     SetLength(BaseLayer, h);
     for iLoop := 0 to h  -1 do
     begin
           SetLength(BaseLayer[iLoop], w);
     end;

     DiamondLayer := nil;
     SetLength(DiamondLayer, h);
     for iLoop := 0 to h -1 do
     begin
           SetLength(DiamondLayer[iLoop], w);
     end;

     CollisionLayer := nil;
     SetLength(CollisionLayer, h);
     for iLoop := 0 to h -1 do
     begin
           SetLength(CollisionLayer[iLoop], w);
     end;

     StartLayer := nil;
     SetLength(StartLayer, h);
     for iLoop := 0 to h -1 do
     begin
           SetLength(StartLayer[iLoop], w);
     end;

end;

procedure TfrmMain.ScrollBarYScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
    if  ScrollCode = scLineUp then
    begin
{
         case DiamondType of
         dtSingle:
                 if StartDiamondY > 0 then
                    StartDiamondY := StartDiamondY -2;
         dtQuad:
                 if StartDiamondY > 0 then
                   StartDiamondY := StartDiamondY -2;
        end;
}

       if StartDiamondY-2 > -1 then
         Dec(StartDiamondY,2);

        if StartBaseY-1 > -1 then
           Dec(StartBaseY)
    end;

    if  ScrollCode = scLineDown	 then
    begin
    {
         case DiamondType of
         dtSingle:
             begin
                 if StartDiamondY < MapHeight - 40 then
                    StartDiamondY := StartDiamondY +2;
                 if StartBaseY < (MapHeight div 2) - 20 then
                    Inc(StartBaseY);
             end;

         dtQuad:
             begin
               if StartDiamondY < MapHeight - 40 then
                  StartDiamondY := StartDiamondY +2;
                 if StartBaseY < (MapHeight div 2) - 20 then
                    StartBaseY := StartBaseY +1;
             end
         end;
}
        if StartDiamondY + 38 < MapHeight + 1 then
        begin
          Inc(StartDiamondY,2);
          Inc(StartBaseY);
        end;

    end;

//    StartDiamondY := ScrollBarY.Position;

    RefreshScreen;
end;

procedure TfrmMain.ScrollBarXScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin

    if  ScrollCode = scLineUp then  //left
    begin
         case DiamondType of
         dtQuad:
                if StartTileX - 2 > -1 then
                   Dec(StartTileX, 2)
                else
                   StartTileX := 0;
         else
                if StartTileX - 1 > -1 then
                   Dec(StartTileX);
        end;
    end;

    if  ScrollCode = scLineDown	 then    //right
    begin
         case DiamondType of
         dtQuad:
                if StartTileX + 14 < MapWidth +1 then
                   inc(StartTileX, 2)
                else
                    StartTileX := MapWidth-12;

         else
           if StartTileX + 13 < MapWidth  then
                   inc(StartTileX)
                else
                    StartTileX := MapWidth-12;
         end;
    end;

    RefreshScreen;
end;

procedure TfrmMain.iMapMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     //Cancle drawing
     if (Button = mbLeft) then
        MousePaint := false;

end;

procedure TfrmMain.cbBaseClick(Sender: TObject);
begin
     if cbSprite.Checked then
        rgGrid.ItemIndex := 1
     else if cbStatic.checked then
        rgGrid.ItemIndex := 1
     else if cbCollision.Checked then
        rgGrid.ItemIndex := 1
     else if cbDiamond.Checked then
        rgGrid.ItemIndex := 1
     else if cbStart.Checked then
        rgGrid.ItemIndex := 1
     else if cbBase.checked then
        rgGrid.ItemIndex := 0
     else
        rgGrid.ItemIndex := 2;


     RefreshScreen;
end;

procedure TfrmMain.rgGridClick(Sender: TObject);
begin
     RefreshScreen;
end;

procedure TfrmMain.mnuClearBaseClick(Sender: TObject);
var
yLoop: integer;
xLoop: integer;
begin
  //confirm clear
  if MessageDlg('Are you shure you want to clear the entire base layer?',mtConfirmation,[mbYes, mbNo],0) = mryes then
  begin
   for yLoop := 0  to MapHeight -1do
   begin
        for xLoop := 0 to MapWidth -1 do
        begin
           BaseLayer[yLoop,xLoop] := 0;
        end;
   end;

  end;
  RefreshScreen;

end;

procedure TfrmMain.mnuClearDiamondClick(Sender: TObject);
var
yLoop: integer;
xLoop: integer;
begin
  //confirm clear
  if MessageDlg('Are you shure you want to clear everything on the entire diamond layer?',mtConfirmation,[mbYes, mbNo],0) = mryes then
  begin
   for yLoop := 0  to MapHeight -1do
   begin
        for xLoop := 0 to MapWidth -1 do
        begin
           DiamondLayer[yLoop,xLoop] := 0;
        end;
   end;

  end;
  RefreshScreen;

end;

procedure TfrmMain.mnuClearCollisionClick(Sender: TObject);
var
yLoop: integer;
xLoop: integer;
begin
  //confirm clear
  if MessageDlg('Are you shure you want to clear everything on the entire collision layer?',mtConfirmation,[mbYes, mbNo],0) = mryes then
  begin
   for yLoop := 0  to MapHeight -1do
   begin
        for xLoop := 0 to MapWidth -1 do
        begin
           CollisionLayer[yLoop,xLoop] := 0;
        end;
   end;

  end;
  RefreshScreen;

end;

procedure TfrmMain.mnuFillBaseClick(Sender: TObject);
var
yLoop: integer;
xLoop: integer;
begin
   for yLoop := 0  to MapHeight -1do
   begin
        for xLoop := 0 to MapWidth -1 do
        begin
           if BaseLayer[yLoop,xLoop] = 0 then
           begin
             WorldTileY := yLoop;
             WorldTileX := xLoop;
             AddBaseTileToMap;
           end
        end;
   end;

  RefreshScreen;

end;

procedure TfrmMain.mnuFillDiamondClick(Sender: TObject);
var
yLoop: integer;
xLoop: integer;
begin
   for yLoop := 0  to MapHeight -1do
   begin
        for xLoop := 0 to MapWidth -1 do
        begin
           if DiamondLayer[yLoop,xLoop] = 0 then
           begin
             WorldTileY := yLoop;
             WorldTileX := xLoop;
             AddSingleDiamondTileToMap;
           end
        end;
   end;

  RefreshScreen;


end;

procedure TfrmMain.mnuFillCollisionClick(Sender: TObject);
var
yLoop: integer;
xLoop: integer;
begin

     //2,5 - 2,41 odd
    for xLoop := 5 to 41 do
    begin
          if (xLoop mod 2)=0 then continue;

          CollisionLayer[xLoop,2] := 1;
    end;

    //3,4 - 15,4 all
    for yLoop := 3 to 15 do
    begin
          CollisionLayer[4,yLoop] := 1;
    end;

    //15,6 - 15,40 even
    for xLoop := 6 to 40 do
    begin
          if (xLoop mod 2)=0 then
             CollisionLayer[xLoop,15] := 1;
    end;

    //3,42 - 15,42 all
    for yLoop := 3 to 15 do
    begin
          CollisionLayer[42,yLoop] := 1;
    end;

  RefreshScreen;
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

procedure TfrmMain.Settings1Click(Sender: TObject);
begin
    frmSetting.edtMapPath.text := strMapPath;
    frmSetting.edtTexturePath.text :=  strTexturePath;
    frmSetting.EdtScriptPath.text:=  strScriptPath;
    frmSetting.edtTilePath.text  := strEditorTilePath;
    frmSetting.edtChrPath.text := strCharPath;
    frmSetting.edtEditorPath.text := strEditorIconPath;
    frmSetting.edtSpritePath.text := strSpritePath;
    frmSetting.edtStaticPath.text := strStaticPath;
    frmSetting.edtGameEngine.text := strGameEngine;
    frmSetting.edtParticlePath.text := strParticlePath;
    frmSetting.edtEditorScriptPath.text := strEditorScrPath;
    frmSetting.ShowModal;
    if frmSetting.ModalResult = MROK then
    begin
        strMapPath := frmSetting.edtMapPath.text;
        strTexturePath := frmSetting.edtTexturePath.text;
        strScriptPath := frmSetting.EdtScriptPath.text;
        strEditorTilePath := frmSetting.edtTilePath.text;
        strCharPath := frmSetting.edtChrPath.text;
        strEditorIconPath := frmSetting.edtEditorPath.text;
        strSpritePath := frmSetting.edtSpritePath.text;
        strStaticPath := frmSetting.edtStaticPath.text;
        strGameEngine := frmSetting.edtGameEngine.text;
        strParticlePath := frmSetting.edtParticlePath.text;
        strEditorScrPath := frmSetting.edtEditorScriptPath.text;
    end;
end;

procedure TfrmMain.PageControl1Change(Sender: TObject);
begin
      if PageControl1.ActivePage = tsTiles then
      begin
           SelectedList.Clear;
           cbSprite.Checked := false;
           cbStatic.Checked := false;
           EditMode := emTiles;
           imgPreview.Transparent := false;
      end;
      if PageControl1.ActivePage = tsSprites then
      begin
           SelectedList.Clear;
           EditMode := emSprites;
           cbSprite.Checked := true;
           imgPreview.Transparent := true;
      end;
      if PageControl1.ActivePage = tsStatics then
      begin
           SelectedList.Clear;
           EditMode := emStatics;
           cbStatic.Checked := true;
           imgPreview.Transparent := true;
      end;
      if Assigned(MouseImage) then
      begin
           MouseImage.FreeImage;
           MouseImage.free;
           MouseImage := nil;
      end;

      SpriteMode := smNone;
      tvSpriteList.Selected := nil;
      StaticMode := smEdit;
      tvStaticList.Selected := nil;
      tvTileList.selected := nil;
      CopyObject := nil;
      iMap.Cursor := crDefault;
      bLockAddMode := false;
end;

procedure TfrmMain.tvSpriteListClick(Sender: TObject);
var
MyBitMap: TBitMap;

begin
     SpriteMode := smNone;
     //choose an image to draw
     if tvSpriteList.Selected = nil then exit;
     if tvSpriteList.Selected.Parent = nil then exit;

     MyBitMap := nil;
     if tvSpriteList.Selected.Parent.Text = 'Characters' then
     begin
        SpriteMode := smCharacter;
        ImgPreview.Picture := nil;
        ImgPreview.Canvas.Brush.Color := tmColor;
        ImgPreview.Canvas.FillRect(Rect(0,0,ImgPreview.width,ImgPreview.height));
        MyBitMap := LoadCharacter(IntToStr(tvSpriteList.Selected.ImageIndex));
        //MyBitMap := ParseCharacterFile(strCharPath+tvSpriteList.Selected.Text+ '.dat');
        ImgPreview.Picture.Assign(MyBitMap);
     end;

     if tvSpriteList.Selected.Parent.Text = 'Sprites' then
     begin
        SpriteMode := smSprite;
        ImgPreview.Picture := nil;
        ImgPreview.Canvas.Brush.Color := tmColor;
        ImgPreview.Canvas.FillRect(Rect(0,0,ImgPreview.width,ImgPreview.height));
        MyBitMap := LoadSprite(IntToStr(tvSpriteList.Selected.ImageIndex));
       // MyBitMap := ParseSpriteFile(strSpritePath+tvSpriteList.Selected.Text+ '.dat');
        ImgPreview.Picture.Assign(MyBitMap);
     end;

     if tvSpriteList.Selected.Parent.Text = 'Editor' then
     begin
        SpriteMode := smEditor;
        if tvSpriteList.Selected.Text = 'Start Point' then
           EditorMode := erStart;
        if tvSpriteList.Selected.Text = 'Light' then
        begin
           EditorMode := erLight;
           cbLight.checked := true;
        end;
     end;

     if tvSpriteList.Selected.Parent.Text = 'Particles' then
     begin
        SpriteMode := smParticles;
     end;

     if Assigned(MyBitMap) then
     begin
       if Assigned(MouseImage) then
        begin
            MouseImage.FreeImage;
            MouseImage.free;
        end;
        MouseImage := TBitMap.Create;
        MouseImage.height := ImgPreview.Picture.Bitmap.Height;
        MouseImage.width := ImgPreview.Picture.bitmap.width;
        MouseImage.TransparentColor := clwhite;//tmColor;
        MouseImage.TransparentMode := tmFixed;
        MouseImage.transparent := true;
        MouseImage.Canvas.Draw(0,0,ImgPreview.Picture.bitmap);
//        MouseImage.Assign(MyBitMap);
     end;
     CopyObject := nil;
     iMap.Cursor := crDrag;
end;

procedure TfrmMain.mnuDeleteNPCClick(Sender: TObject);
var
  indx: integer;
  iLoop: integer;
begin
   for iLoop := 0 to SelectedList.count -1 do
   begin
       indx := ObjectList.IndexOf(SelectedList.items[iLoop]);
       if indx > -1 then
         ObjectList.Delete(indx);
   end;
   SelectedList.clear;
   RefreshScreen;
end;

procedure TfrmMain.EditStaticProperties;
begin
     frmNPCProp.SetupStatic(SelectedList);
     RefreshScreen;
end;

procedure TfrmMain.EditSpriteProperties;
begin
     frmNPCProp.SetupSprite(SelectedList);
     RefreshScreen;
end;

procedure TfrmMain.EditLightProperties;
var
 MyLight: TLight;
 iLoop : integer;
begin
     //Get the first select sprite
     MyLight := TLight(SelectedList.Items[0]);

     frmStaticProp.cbGroupID.Clear;
     frmStaticProp.Label1.caption := 'Height';
     frmStaticProp.Caption := 'Light Properties';
     frmStaticProp.cbShadow.caption := 'Flicker';
     for iLoop := 0 to ObjectList.count -1 do
     begin
       if TStatic(ObjectList.Items[iLoop]).groupID > -1 then
       if frmStaticProp.cbGroupID.Items.IndexOf(IntToStr(TStatic(ObjectList.Items[iLoop]).groupID)) = -1 then
          frmStaticProp.cbGroupID.Items.Add(IntToStr(TStatic(ObjectList.Items[iLoop]).groupID));
     end;

     frmStaticProp.lblX.caption := 'X = ' +IntToStr(MyLight.x);
     frmStaticProp.lblY.caption := 'Y = ' +IntToStr(MyLight.y);
     if MyLight.GroupID > -1 then
        frmStaticProp.cbGroupID.text := IntToStr(MyLight.GroupID)
     else
        frmStaticProp.cbGroupID.text := '';
     frmStaticProp.cbLayer.enabled  := false;
     frmStaticProp.Label3.enabled  := false;
     frmStaticProp.Label4.enabled  := false;
     frmStaticProp.Label7.enabled  := false;
     frmStaticProp.edtLength.text := IntToStr(MyLight.Height);
     frmStaticProp.edtWidth.text := IntToStr(MyLight.Width);
     frmStaticProp.edtFrameIndx.enabled  := false;
     frmStaticProp.edtDrawOrder.enabled  := false;
     frmStaticProp.edtRed.text := IntToStr(MyLight.Red);
     frmStaticProp.edtBlue.text := IntToStr(MyLight.Blue);
     frmStaticProp.edtGreen.text := IntToStr(MyLight.Green);
     frmStaticProp.edtBlend.text := IntToStr(MyLight.Blend);
     frmStaticProp.pnAmbientColor.Color := RGB(MyLight.Red,MyLight.Green,MyLight.Blue);
     if MyLight.flicker = 1 then
        frmStaticProp.cbShadow.checked := true
     else
         frmStaticProp.cbShadow.checked := false;

     frmStaticProp.ShowModal;

     for iLoop := 0 to SelectedList.count -1 do
     begin
       if frmStaticProp.cbGroupID.text <> '' then
       TLight(SelectedList.Items[iLoop]).GroupID := StrToInt(frmStaticProp.cbGroupID.text);

       if frmStaticProp.edtLength.text <> '' then
       TLight(SelectedList.Items[iLoop]).Height := StrToInt(frmStaticProp.edtLength.text);
       if frmStaticProp.edtWidth.text <> '' then
       TLight(SelectedList.Items[iLoop]).Width := StrToInt(frmStaticProp.edtWidth.text);

       if frmStaticProp.edtRed.text <> '' then
       TLight(SelectedList.Items[iLoop]).Red := StrToInt(frmStaticProp.edtRed.text);
       if frmStaticProp.edtBlue.text <> '' then
       TLight(SelectedList.Items[iLoop]).Blue := StrToInt(frmStaticProp.edtBlue.text);
       if frmStaticProp.edtGreen.text <> '' then
       TLight(SelectedList.Items[iLoop]).Green := StrToInt(frmStaticProp.edtGreen.text);
       if frmStaticProp.edtBlend.text <> '' then
       TLight(SelectedList.Items[iLoop]).Blend := StrToInt(frmStaticProp.edtBlend.text);
       if frmStaticProp.cbShadow.Checked then
          TLight(SelectedList.Items[iLoop]).flicker := 1
       else
           TLight(SelectedList.Items[iLoop]).flicker := 0;
     end;
     RefreshScreen;
end;

procedure TfrmMain.mnuNPCFaceNWClick(Sender: TObject);
var
 MyNPC: TSprite;
 iLoop: integer;
begin
   for iLoop := 0 to SelectedList.count -1 do
   begin
       MyNPC := TSprite(SelectedList.items[iLoop]);
       MyNPC.Facing := 0;
   end;
     RefreshScreen;
end;

procedure TfrmMain.mnuNPCFaceNEClick(Sender: TObject);
var
 MyNPC: TSprite;
 iLoop: integer;
begin
   for iLoop := 0 to SelectedList.count -1 do
   begin
       MyNPC := TSprite(SelectedList.items[iLoop]);
       MyNPC.Facing := 1;
   end;
     RefreshScreen;
end;

procedure TfrmMain.mnuNPCFaceSEClick(Sender: TObject);
var
 MyNPC: TSprite;
 iLoop: integer;
begin
   for iLoop := 0 to SelectedList.count -1 do
   begin
       MyNPC := TSprite(SelectedList.items[iLoop]);
       MyNPC.Facing := 2;
   end;
     RefreshScreen;
end;

procedure TfrmMain.mnuNPCFaceSWClick(Sender: TObject);
var
 MyNPC: TSprite;
 iLoop: integer;
begin
   for iLoop := 0 to SelectedList.count -1 do
   begin
       MyNPC := TSprite(SelectedList.items[iLoop]);
       MyNPC.Facing := 3;
   end;
     RefreshScreen;
end;

procedure TfrmMain.EditScript1Click(Sender: TObject);
begin
    if ScriptList.Count = 0 then BuildScript('NewMap.map');
    ReBuildScriptEvents;
    frmScript.mmEventScr.lines.Text := ScriptList.Text;
    frmScript.ShowModal;
    ScriptList.Text := frmScript.mmEventScr.lines.Text;
end;

procedure TfrmMain.BuildScript(mapName: string);
begin
     if not(Assigned(ScriptList)) then exit;
     if MapName = '' then MapName := 'NewMap.map';
     ScriptList.Clear;
     ScriptList.Add('function autoexec()');
     ScriptList.Add('changeMap("resources\\Data\\maps\\'+mapName+'");');
     ScriptList.Add('end');
     ScriptList.Add('');
     ScriptList.Add('function loadevents()');
     ScriptList.Add('end');
     ScriptList.Add('');
     ScriptList.Add('function postexec()');
     ScriptList.Add('end');
     ScriptList.Add('');



{
     for iLoop := 0 to ObjectList.Count -1 do
     begin
        MySprite := TSprite(ObjectList.items[iLoop]);
        Case MySprite.SpriteType of
          stNPC:
              begin
                  if MySprite.CombatScript.count > 0 then
                  begin
                      ScriptList.Add('function ' + MySprite.Name + IntToStr(MySprite.ID)+'_Combat()');
                      for jLoop := 0 to MySprite.CombatScript.count -1 do
                          if MySprite.CombatScript.Strings[jLoop] <> '' then
                             ScriptList.Add(MySprite.CombatScript.Strings[jLoop]);
                      ScriptList.Add('end');
                      ScriptList.Add('');
                  end;
                  if MySprite.IdleScript.count > 0 then
                  begin
                      ScriptList.Add('function ' + MySprite.Name + IntToStr(MySprite.ID)+'_Idle()');
                      for jLoop := 0 to MySprite.IdleScript.count -1 do
                          if MySprite.IdleScript.Strings[jLoop] <> '' then
                             ScriptList.Add(MySprite.IdleScript.Strings[jLoop]);
                      ScriptList.Add('end');
                      ScriptList.Add('');
                  end;
                  if MySprite.OnActivate.count > 0 then
                  begin
                      ScriptList.Add('function ' + MySprite.Name + IntToStr(MySprite.ID)+'_OnActivate()');
                      for jLoop := 0 to MySprite.OnActivate.count -1 do
                          if MySprite.OnActivate.Strings[jLoop] <> '' then
                             ScriptList.Add(MySprite.OnActivate.Strings[jLoop]);
                      ScriptList.Add('end');
                      ScriptList.Add('');
                  end;
                  if MySprite.OnAttack.count > 0 then
                  begin
                      ScriptList.Add('function ' + MySprite.Name + IntToStr(MySprite.ID)+'_OnAttacked()');
                      for jLoop := 0 to MySprite.OnAttack.count -1 do
                          if MySprite.OnAttack.Strings[jLoop] <> '' then
                             ScriptList.Add(MySprite.OnAttack.Strings[jLoop]);
                      ScriptList.Add('end');
                      ScriptList.Add('');
                  end;
                  if MySprite.OnDie.count > 0 then
                  begin
                      ScriptList.Add('function ' + MySprite.Name + IntToStr(MySprite.ID)+'_OnDie()');
                      for jLoop := 0 to MySprite.OnDie.count -1 do
                          if MySprite.OnDie.Strings[jLoop] <> '' then
                             ScriptList.Add(MySprite.OnDie.Strings[jLoop]);
                      ScriptList.Add('end');
                      ScriptList.Add('');
                  end;
                  if MySprite.OnFirstAttack.count > 0 then
                  begin
                      ScriptList.Add('function ' + MySprite.Name + IntToStr(MySprite.ID)+'_OnFirstAttacked()');
                      for jLoop := 0 to MySprite.OnFirstAttack.count -1 do
                          if MySprite.OnFirstAttack.Strings[jLoop] <> '' then
                             ScriptList.Add(MySprite.OnFirstAttack.Strings[jLoop]);
                      ScriptList.Add('end');
                      ScriptList.Add('');
                  end;
                  if MySprite.OnLoad.count > 0 then
                  begin
                      ScriptList.Add('function ' + MySprite.Name + IntToStr(MySprite.ID)+'_OnLoad()');
                      for jLoop := 0 to MySprite.OnLoad.count -1 do
                          if MySprite.OnLoad.Strings[jLoop] <> '' then
                             ScriptList.Add(MySprite.OnLoad.Strings[jLoop]);
                      ScriptList.Add('end');
                      ScriptList.Add('');
                  end;
              end;
          stSprite:
              begin
                  if MySprite.OnActivate.count > 0 then
                  begin
                      ScriptList.Add('function ' + MySprite.Name + IntToStr(MySprite.ID)+'_OnActivate()');
                      for jLoop := 0 to MySprite.OnActivate.count -1 do
                          if MySprite.OnActivate.Strings[jLoop] <> '' then
                             ScriptList.Add(MySprite.OnActivate.Strings[jLoop]);
                      ScriptList.Add('end');
                      ScriptList.Add('');
                 end;
                  if MySprite.OnClose.count > 0 then
                  begin
                      ScriptList.Add('function ' + MySprite.Name + IntToStr(MySprite.ID)+'_OnClose()');
                      for jLoop := 0 to MySprite.OnClose.count -1 do
                          if MySprite.OnClose.Strings[jLoop] <> '' then
                             ScriptList.Add(MySprite.OnClose.Strings[jLoop]);
                      ScriptList.Add('end');
                      ScriptList.Add('');
                  end;
                  if MySprite.OnLoad.count > 0 then
                  begin
                      ScriptList.Add('function ' + MySprite.Name + IntToStr(MySprite.ID)+'_OnLoad()');
                      for jLoop := 0 to MySprite.OnLoad.count -1 do
                          if MySprite.OnLoad.Strings[jLoop] <> '' then
                             ScriptList.Add(MySprite.OnLoad.Strings[jLoop]);
                      ScriptList.Add('end');
                      ScriptList.Add('');
                  end;
                  if MySprite.OnOpen.count > 0 then
                  begin
                      ScriptList.Add('function ' + MySprite.Name + IntToStr(MySprite.ID)+'_OnOpen()');
                      for jLoop := 0 to MySprite.OnOpen.count -1 do
                          if MySprite.OnOpen.Strings[jLoop] <> '' then
                             ScriptList.Add(MySprite.OnOpen.Strings[jLoop]);
                      ScriptList.Add('end');
                      ScriptList.Add('');
                  end;
              end;
          stStart:
              begin
                  if MySprite.OnLoad.count > 0 then
                  begin
                      ScriptList.Add('function ' + MySprite.Name + IntToStr(MySprite.ID)+'_OnLoad()');
                      for jLoop := 0 to MySprite.OnLoad.count -1 do
                          if MySprite.OnLoad.Strings[jLoop] <> '' then
                             ScriptList.Add(MySprite.OnLoad.Strings[jLoop]);
                      ScriptList.Add('end');
                      ScriptList.Add('');
                  end;
              end;
        end;
     end;
 }

 {
     //addNPC(2, 0, 0, 4, 16, "resources\\Data\\characters\\Mage1.dat", "Mage", "");

     for iLoop := 0 to ObjectList.Count -1 do
     begin
        MySprite := TSprite(ObjectList.items[iLoop]);
        Case MySprite.SpriteType of
          stNPC:
              tmpStr := 'addNPC('+
                        IntToStr(MySprite.Facing) +  ', '+
                        '0, ' +
                        IntToStr(MySprite.GroupID) +  ', '+
                        IntToStr(MySprite.ID) +  ', '+
                        IntToStr(MySprite.x) +  ', '+
                        IntToStr(MySprite.y) +  ', "'+
                        MySprite.FileName  +  '", "'+
                        MySprite.Name + '", "");';
          stSprite:
              tmpStr := 'addSprite('+
                        IntToStr(MySprite.ID) +  ', '+
                        IntToStr(MySprite.GroupID) +  ', '+
                        IntToStr(MySprite.x) +  ', '+
                        IntToStr(MySprite.y) +  ', "'+
                        MySprite.FileName  +  '", "'+
                        MySprite.Name + '");';
          stStart:
              tmpStr := 'addStartPoint('+
                        IntToStr(MySprite.ID) +  ', '+
                        IntToStr(MySprite.GroupID) +  ', '+
                        IntToStr(MySprite.x) +  ', '+
                        IntToStr(MySprite.y)+ ');';
        end;
        ScriptList.Add(tmpStr);
     end;
  }


end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  iLoop : integer;
  indx: integer;
begin

     if (ssCtrl in shift) and (ssShift in Shift) then
     begin

         if (SelectedList.count = 1) and (TGameObject(SelectedList.Items[0]).MyType = otLight) then
         case Key of
           VK_Up:
           begin
               Key := 0;
               inc(TLight(SelectedList.Items[0]).Height);
               RenderLightEdit;

           end;
           VK_Down:
           begin
                Key := 0;
                dec(TLight(SelectedList.Items[0]).Height);
                RenderLightEdit;
           end;
           VK_Left:
           begin
                Key := 0;
                dec(TLight(SelectedList.Items[0]).Width);
                RenderLightEdit;
           end;
           VK_Right:
           begin
                Key := 0;
                inc(TLight(SelectedList.Items[0]).Width);
                RenderLightEdit;
           end;
         end;
     end
     else
     begin
     if (ssCtrl in shift) then
     begin
        case Key of
           VK_Up:
           begin
               Key := 0;
               for iLoop := 0 to SelectedList.count -1 do
                inc(TGameObject(SelectedList.Items[iLoop]).offSetY);
           end;
           VK_Down:
           begin
                Key := 0;
               for iLoop := 0 to SelectedList.count -1 do
                 dec(TGameObject(SelectedList.Items[iLoop]).offSetY);
           end;
           VK_Left:
           begin
                Key := 0;
                for iLoop := 0 to SelectedList.count -1 do
                   dec(TGameObject(SelectedList.Items[iLoop]).offSetX);
           end;
           VK_Right:
           begin
                Key := 0;
                for iLoop := 0 to SelectedList.count -1 do
                   inc(TGameObject(SelectedList.Items[iLoop]).offSetX);
           end;
           VK_Delete:
           begin
               Key := 0;
               for iLoop := 0 to SelectedList.count -1 do
               begin
                   indx := ObjectList.IndexOf(SelectedList.items[iLoop]);
                   if indx > -1 then
                     ObjectList.Delete(indx);
               end;
               SelectedList.clear;
               RefreshScreen;
           end;
           67: //C
           begin
                if SelectedList.Count = 0 then exit;
                CopyObject := TGameObject(SelectedList.items[0]);
                MouseImage := TBitMap.Create;
                MouseImage.TransparentColor := tmColor;
                MouseImage.TransparentMode := tmFixed;
                MouseImage.Transparent := true;
                MouseImage.Assign(CopyObject.Image);
                bLockAddMode := true;
                iXoffSet := CopyObject.offSetX;
                iYoffSet := CopyObject.offSetY;

                iMap.Cursor := crDrag;
                case CopyObject.MyType of
                otSprite:
                   begin
                      PageControl1.ActivePage :=  tsSprites;
                      EditMode:=emSprites;
                      case TSprite(CopyObject).spriteType of
                        stNPC:SpriteMode := smCharacter;
                        stSprite:SpriteMode := smSprite;
                        stStart:SpriteMode := smEditor;
                      end
                   end;
                otStatic:
                   begin
                      PageControl1.ActivePage := tsStatics;
                      EditMode:=emStatics;
                      StaticMode:= smAddNew;
                   end;
                end;
           end;
        end;
        if Key = 0 then
         refreshScreen;
     end;


     if (ssShift in Shift) then
     begin
        case Key of
           VK_Up:
           begin
                 Key := 0;
               for iLoop := 0 to SelectedList.count -1 do
                  dec(TGameObject(SelectedList.Items[iLoop]).y)
           end;
           VK_Down:
           begin
                Key := 0;
               for iLoop := 0 to SelectedList.count -1 do
                 Inc(TGameObject(SelectedList.Items[iLoop]).y)
               end;
           VK_Left:
           begin
                Key := 0;
                for iLoop := 0 to SelectedList.count -1 do
                   dec(TGameObject(SelectedList.Items[iLoop]).x)
           end;
           VK_Right:
           begin
                Key := 0;
                for iLoop := 0 to SelectedList.count -1 do
                  inc(TGameObject(SelectedList.Items[iLoop]).x)
           end;
        end;
        if Key <> VK_Shift then
        begin
         SortSpriteList(ObjectList);
         refreshScreen;
        end;
     end;

     if not(ssShift in Shift) then
     begin
        case Key of
           VK_Up:
                 begin
                    Key := 0;
//                 ScrollBarY.Position := ScrollBarY.Position -1;
                    if StartDiamondY > 0 then
                       StartDiamondY := StartDiamondY -2;
                    if StartBaseY > 0 then
                       StartBaseY := StartBaseY -1;
                    ScrollBarY.Position := ScrollBarY.Position -1;
                    RefreshScreen;
                 end;
           VK_Down:
                 begin
                    Key := 0;
                    if StartDiamondY < MapHeight - 40 then
                       StartDiamondY := StartDiamondY +2;
                    if StartBaseY < (MapHeight div 2) - 20 then
                       StartBaseY := StartBaseY +1;
                    ScrollBarY.Position := ScrollBarY.Position +1;
                    RefreshScreen;
                 end;
           VK_Left:
                 begin
                      Key := 0;
                      ScrollBarX.Position := ScrollBarX.Position -1;
                      StartTileX := ScrollBarX.Position;
                      RefreshScreen;
                 end;
           VK_Right:
                 begin
                      Key := 0;
                      ScrollBarX.Position := ScrollBarX.Position +1;
                      StartTileX := ScrollBarX.Position;
                      RefreshScreen;
                 end;
        end;
     end;
     end;
     if (Key = VK_Escape) and bLockAddMode then
     begin
       bLockAddMode := false;
       MouseImage.FreeImage;
       MouseImage.free;
       MouseImage := nil;
       iMap.Cursor := crDefault;
       CopyObject := nil;
       case EditMode of
          emSprites:
              begin
                   SpriteMode := smNone;
                   tvSpriteList.Selected := nil;
                   iMap.Cursor := crDefault;
              end;
          emStatics:
              begin
                   StaticMode := smEdit;
                   tvStaticList.Selected := nil;
                   iMap.Cursor := crDefault;
              end;
        end;
       RefreshScreen;
     end;
     if (key = VK_Escape) then
        SelectedList.Clear

end;

procedure TfrmMain.mnuSelectClick(Sender: TObject);
var
MySprite: TSprite;
iLoop : integer;
begin
      if SelectedList.Count = 0 then exit;
      MySprite := TSprite(SelectedList.Items[0]);
      SelectedList.clear;
      for iLoop := 0 to ObjectList.Count -1 do
      begin
          if TSprite(ObjectList.items[iLoop]).GroupID = MySprite.GroupID then
             SelectedList.Add(TSprite(ObjectList.items[iLoop]));
      end;
      refreshScreen;
      MySprite := nil;
end;

procedure TfrmMain.mnuMergQuadClick(Sender: TObject);
begin
 MergeQuadTiles;
 QuadCollection.ClearAll;
 tvTileListClick(Sender);
// QuadCollection := TQuadCollection.Create;
end;

procedure TfrmMain.mnuHideShowClick(Sender: TObject);
var
  iLoop: integer;
  MyNPC: TSprite;
begin
   for iLoop := 0 to SelectedList.count -1 do
   begin
        MyNPC := TSprite(SelectedList.items[iLoop]);
        MyNPC.Hidden := true;
   end;
   SelectedList.Clear;
   RefreshScreen;
end;

procedure TfrmMain.UpdateStatusBar;
begin
   mStatusBar.Panels.Items[0].Text :=
    ' World Tile  x:' + IntToStr(WorldTileX) + '  y:' + IntToStr(WorldTileY);
   mStatusBar.Panels.Items[1].Text :=
    ' Map Size  h:' + IntToStr(MapHeight) +'  w:'+ IntToStr(MapWidth);
   mStatusBar.Panels.Items[2].Text :=
    ' Rect Tiles: ' + IntToStr(imBaseTiles.ImageCount) ;
   mStatusBar.Panels.Items[3].Text :=
    ' Diamond Tiles: ' + IntToStr(imDiamondTiles.ImageCount);
   mStatusBar.Panels.Items[4].Text :=
    ' Sprites: ' + IntToStr(ObjectList.Count);

end;

procedure TfrmMain.EditFacing1Click(Sender: TObject);
var
  iLoop: integer;
  MyNPC: TSprite;
  tmpInt: integer;
begin
   for iLoop := 0 to SelectedList.count -1 do
   begin
        MyNPC := TSprite(SelectedList.items[iLoop]);
        tmpInt := MyNPC.Facing;
        if tmpInt = 3 then
           tmpInt := 0
        else
            inc(tmpInt);
        MyNPC.Facing := tmpInt;
   end;
   RefreshScreen;
end;

procedure TfrmMain.tvStaticListClick(Sender: TObject);
var
MyBitMap: TBitMap;
StaticItem: TTreeNTNode;
begin
     if tvStaticList.Selected = nil then exit;
     if tvStaticList.Selected.Parent = nil then exit;
     if tvStaticList.Selected.HasChildren then exit;
     StaticMode:= smEdit;
    // if (LowerCase(strRight(tvStaticList.Selected.parent.text,4)) = '.dat') then
     begin
        ImgPreview.Picture := nil;
        ImgPreview.Canvas.Brush.Color := tmColor;
        ImgPreview.Canvas.FillRect(Rect(0,0,ImgPreview.width,ImgPreview.height));

        StaticItem := tvStaticList.Selected;
        MyBitMap := LoadStatic(IntToStr(StaticItem.ImageIndex), StaticItem.text);
        //MyBitMap := ParseStatic(strStaticPath+tvStaticList.Selected.parent.text,tvStaticList.Selected.text);
        ImgPreview.Picture.Assign(MyBitMap);
        if Assigned(MouseImage) then
        begin
            MouseImage.FreeImage;
            MouseImage.free;
        end;
        MouseImage := TBitMap.Create;
        MouseImage.height := ImgPreview.Picture.Bitmap.Height;
        MouseImage.width := ImgPreview.Picture.bitmap.width;
        MouseImage.TransparentColor := clwhite;//tmColor;
        MouseImage.TransparentMode := tmFixed;
        MouseImage.transparent := true;
        MouseImage.Canvas.Draw(0,0,ImgPreview.Picture.bitmap);
       // MouseImage.Assign(MyBitMap);
        CopyObject := nil;
        StaticMode:= smAddNew;
        iMap.Cursor := crDrag;
     end;
end;


procedure TfrmMain.mnuShowAllClick(Sender: TObject);
var
  iLoop: integer;
  MyNPC: TSprite;
begin
   for iLoop := 0 to ObjectList.count -1 do
   begin
        MyNPC := TSprite(ObjectList.items[iLoop]);
        MyNPC.Hidden := False;
   end;
   RefreshScreen;
end;

procedure TfrmMain.LockAddMode1Click(Sender: TObject);
begin
     bLockAddMode := true;
end;

procedure TfrmMain.mnuNCornerClick(Sender: TObject);
begin
     QuadCollection.QuadCornerNN(WorldTileX,WorldTileY);
     RefreshScreen;
end;

procedure TfrmMain.mnuECornerClick(Sender: TObject);
begin
     QuadCollection.QuadCornerEE(WorldTileX,WorldTileY);
     RefreshScreen;
end;

procedure TfrmMain.mnuSCornerClick(Sender: TObject);
begin
     QuadCollection.QuadCornerSS(WorldTileX,WorldTileY);
     RefreshScreen;
end;

procedure TfrmMain.mnuWCornerClick(Sender: TObject);
begin
     QuadCollection.QuadCornerWW(WorldTileX,WorldTileY);
     RefreshScreen;
end;

procedure TFrmMain.LoadBMPPreview(ImageName: string);
begin
    ImgPreview.Picture := nil;
    ImgPreview.Canvas.Brush.Color := tmColor;
    ImgPreview.Canvas.FillRect(Rect(0,0,ImgPreview.width,ImgPreview.height));
    if fileExists(ImageName) then
    ImgPreview.Picture.LoadFromFile(ImageName);

    if ImgPreview.Picture.Bitmap.Canvas .Pixels[0,0] = 16745215 then
     imgPreview.Transparent := true
    else
    imgPreview.Transparent := false;


end;


procedure TfrmMain.mnuEditPropertiesClick(Sender: TObject);
begin
     //Get the first select sprite
     case TGameObject(SelectedList.Items[0]).MyType of
     otSprite: EditSpriteProperties;
     otStatic: EditStaticProperties;
     otLight: EditLightProperties;
     end;
end;

procedure TfrmMain.EndGroup1Click(Sender: TObject);
begin
  PlaceGroup := -1;
  EndGroup1.enabled := false;
  BeginGroup1.Enabled := true;
  EndGroup2.enabled := false;
  BeginGroup2.Enabled := true;
end;

procedure TfrmMain.BeginGroup1Click(Sender: TObject);
begin
  if  TGameObject(SelectedList.Items[0]).GroupID > -1 then
  begin
     PlaceGroup := TGameObject(SelectedList.Items[0]).GroupID;
     EndGroup1.enabled := true;
     BeginGroup1.Enabled := false;
     EndGroup2.enabled := true;
     BeginGroup2.Enabled := false;
  end;
end;

procedure TfrmMain.mnuMapPropClick(Sender: TObject);
begin
        ShowMapPropertiesWindow
end;


procedure TfrmMain.Test1Click(Sender: TObject);
begin
ReBuildScriptEvents;
end;

procedure TfrmMain.Layer01Click(Sender: TObject);
var
 MyNPC: TGameObject;
 iLoop: integer;
begin
   for iLoop := 0 to SelectedList.count -1 do
   begin
       MyNPC := TGameObject(SelectedList.items[iLoop]);
       MyNPC.Layer := 0;
   end;

end;

procedure TfrmMain.Layer11Click(Sender: TObject);
var
 MyNPC: TGameObject;
 iLoop: integer;
begin
   for iLoop := 0 to SelectedList.count -1 do
   begin
       MyNPC := TGameObject(SelectedList.items[iLoop]);
       MyNPC.Layer := 1;
   end;


end;

procedure TfrmMain.Layer21Click(Sender: TObject);
var
 MyNPC: TGameObject;
 iLoop: integer;
begin
   for iLoop := 0 to SelectedList.count -1 do
   begin
       MyNPC := TGameObject(SelectedList.items[iLoop]);
       MyNPC.Layer := 2;
   end;

end;

procedure TfrmMain.Layer31Click(Sender: TObject);
var
 MyNPC: TGameObject;
 iLoop: integer;
begin
   for iLoop := 0 to SelectedList.count -1 do
   begin
       MyNPC := TGameObject(SelectedList.items[iLoop]);
       MyNPC.Layer := 3;
   end;

end;

procedure TfrmMain.Host1Click(Sender: TObject);
var
 MyNPC: TSprite;
 iLoop: integer;
begin
   for iLoop := 0 to SelectedList.count -1 do
   begin
       MyNPC := TSprite(SelectedList.items[iLoop]);
       MyNPC.Side := 0;
   end;

end;

procedure TfrmMain.Challenger1Click(Sender: TObject);
var
 MyNPC: TSprite;
 iLoop: integer;
begin
   for iLoop := 0 to SelectedList.count -1 do
   begin
       MyNPC := TSprite(SelectedList.items[iLoop]);
       MyNPC.Side := 1;
   end;

end;

procedure TfrmMain.ShowMapPropertiesWindow;
begin
    
     frmMapProp.edtName.text :=  MapPropeties.MapName;
     frmMapProp.pnAmbientColor.Color := MapPropeties.LightColor;
     frmMapProp.cbMapType.ItemIndex :=  MapPropeties.MapType;
     frmMapProp.edtDesc.Lines.text := MapPropeties.MapDesc;
     frmMapProp.cbShadows.Checked :=  MapPropeties.UseShadows;
     frmMapProp.tbCloudBlend.Position := MapPropeties.CloudBlend;
     frmMapProp.cbWindDir.ItemIndex :=  MapPropeties.WindDirect;
     frmMapProp.edtSnow.Text :=  IntToStr(MapPropeties.SnowFlakes);
     frmMapProp.edtArmySize.Text := IntToStr(MapPropeties.ArmySize);
     frmMapProp.cbFogType.ItemIndex := MapPropeties.FogType;
     frmMapProp.pnlFogColor.Color := MapPropeties.FogColor;
     frmMapProp.tbFogBlend.Position :=  MapPropeties.FogBlend;
     frmMapProp.cbFogTexture.ItemIndex := MapPropeties.FogText;
     frmMapProp.cbWalkSfx.ItemIndex :=  MapPropeties.WalkSfx -30;
     if frmMapProp.ShowModal = mrOK then
     begin
        MapPropeties.MapName := frmMapProp.edtName.text;
        MapPropeties.LightColor := frmMapProp.pnAmbientColor.Color;
        MapPropeties.MapType := frmMapProp.cbMapType.ItemIndex;
        MapPropeties.MapDesc := frmMapProp.edtDesc.Lines.text;
        MapPropeties.UseShadows := frmMapProp.cbShadows.Checked;
        MapPropeties.CloudBlend  := frmMapProp.tbCloudBlend.Position;
        MapPropeties.WindDirect := frmMapProp.cbWindDir.ItemIndex;
        MapPropeties.SnowFlakes := StrToInt(frmMapProp.edtSnow.Text);
        MapPropeties.ArmySize := StrToInt(frmMapProp.edtArmySize.Text);
        MapPropeties.FogType := frmMapProp.cbFogType.ItemIndex;
        MapPropeties.FogColor := frmMapProp.pnlFogColor.Color;
        MapPropeties.FogBlend := frmMapProp.tbFogBlend.Position;
        MapPropeties.FogText := frmMapProp.cbFogTexture.ItemIndex;
        MapPropeties.WalkSfx :=  frmMapProp.cbWalkSfx.ItemIndex + 30;
     end;

end;

procedure TfrmMain.SFXPorperties1Click(Sender: TObject);
begin

     frmSFX.Show;
end;

procedure TfrmMain.ObjectProperties1Click(Sender: TObject);
begin
     frmNPCProp.Show();
end;

end.
