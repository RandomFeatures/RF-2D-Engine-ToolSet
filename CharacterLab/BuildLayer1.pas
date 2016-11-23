{*****************************************************************************}
{ Digital Tome Game Design Utility                                            }
{                                                                             }
{ Copyright ©1999 Digital Tome L.P. Not for public release/use.               }
{                                                                             }
{ BuildLayer                                                                  }
{                                                                             }
{ A tool for displaying various parts of an animated sprite character as      }
{ ordered layers. Intended to allow previewing art files for use in the game. }
{                                                                             }
{*****************************************************************************}

unit BuildLayer1;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Dialogs,
  ComCtrls, Controls, ExtCtrls, StdCtrls, ImgList,
  FileCtrl, strFunctions, inifiles, DirScanner, NGImages,
  BLImage, Menus, Wordcap, ToolWin, BLRadioBtn, NGConst,SQLiteTable3,
  Registry, TFlatHintUnit, DFX, DigiFX, PBFolderDialog, Buttons;

type
  TfrmBuildLayer = class(TForm)
    lblFrameCount: TLabel;
    SaveDialog: TSaveDialog;
    ColorDialog: TColorDialog;
    pMainView: TPanel;
    lblCurFrame: TLabel;
    popBLImage: TPopupMenu;
    EditValidLayer1: TMenuItem;
    OpenDialog: TOpenDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    OpenCharacterImage1: TMenuItem;
    N1: TMenuItem;
    OpenImagePath1: TMenuItem;
    MakeAGif1: TMenuItem;
    Action1: TMenuItem;
    LoadDefaultAction1: TMenuItem;
    ChangeAction1: TMenuItem;
    Options1: TMenuItem;
    BackGroundColor1: TMenuItem;
    ColorAdjust1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ImageList1: TImageList;
    ViewFullAnimation1: TMenuItem;
    MainTimer: TTimer;
    ReOp1: TMenuItem;
    Open1: TMenuItem;
    Open2: TMenuItem;
    Open3: TMenuItem;
    N3: TMenuItem;
    ToolButton4: TToolButton;
    btnPlay: TToolButton;
    btnPause: TToolButton;
    btnback: TToolButton;
    btnForward: TToolButton;
    EditanImage1: TMenuItem;
    EditDialoge: TOpenDialog;
    odItems: TOpenDialog;
    FlipFrameDrawOrder1: TMenuItem;
    SaveiniData1: TMenuItem;
    ResetForNewCharacter1: TMenuItem;
    SaveIniDialog: TSaveDialog;
    FlatHint1: TFlatHint;
    N4: TMenuItem;
    GameImage1: TMenuItem;
    Image14: TImage;
    PBFolderDialog1: TPBFolderDialog;
    pcLayerTabs: TPageControl;
    tsLegs1: TTabSheet;
    sbxLegs1: TScrollBox;
    Panel2: TPanel;
    tsLegs2: TTabSheet;
    sbxLegs2: TScrollBox;
    Panel3: TPanel;
    tsBoots: TTabSheet;
    sbxboots: TScrollBox;
    Panel5: TPanel;
    tsChest1: TTabSheet;
    sbxchest1: TScrollBox;
    Panel6: TPanel;
    tsChest2: TTabSheet;
    sbxchest2: TScrollBox;
    Panel7: TPanel;
    tsArms: TTabSheet;
    sbxArms: TScrollBox;
    Panel8: TPanel;
    tsBelt: TTabSheet;
    sbxBelt: TScrollBox;
    Panel9: TPanel;
    tsChest3: TTabSheet;
    sbxchest3: TScrollBox;
    Panel10: TPanel;
    tsGauntlets: TTabSheet;
    sbxGauntlets: TScrollBox;
    Panel11: TPanel;
    tsOuter: TTabSheet;
    sbxOuter: TScrollBox;
    Panel12: TPanel;
    tsHead: TTabSheet;
    sbxhead: TScrollBox;
    Panel4: TPanel;
    tsHelmet: TTabSheet;
    Panel15: TPanel;
    sbxHelmet: TScrollBox;
    tsWeapon: TTabSheet;
    sbxWeapon: TScrollBox;
    Panel13: TPanel;
    tsShield: TTabSheet;
    sbxShield: TScrollBox;
    Panel14: TPanel;
    imgOuter: TBLImage;
    imgChest3: TBLImage;
    imgarms: TBLImage;
    Imglegs1: TBLImage;
    Imglegs2: TBLImage;
    ImgBoots: TBLImage;
    ImgChest1: TBLImage;
    imgchest2: TBLImage;
    imgBelt: TBLImage;
    ImgGauntlets: TBLImage;
    ImgHead: TBLImage;
    ImgHelmet: TBLImage;
    Imgweapon: TBLImage;
    ImgShield: TBLImage;
    MainImg: TBLImage;
    Panel1: TPanel;
    Label1: TLabel;
    tbLegs1Red: TTrackBar;
    Label2: TLabel;
    Label3: TLabel;
    tbLegs1Blue: TTrackBar;
    Label4: TLabel;
    tbLegs1Green: TTrackBar;
    Label5: TLabel;
    Label6: TLabel;
    Panel16: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    Panel17: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    TrackBar4: TTrackBar;
    TrackBar5: TTrackBar;
    TrackBar6: TTrackBar;
    Panel18: TPanel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    TrackBar7: TTrackBar;
    TrackBar8: TTrackBar;
    TrackBar9: TTrackBar;
    Panel19: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    TrackBar10: TTrackBar;
    TrackBar11: TTrackBar;
    TrackBar12: TTrackBar;
    Panel20: TPanel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    TrackBar13: TTrackBar;
    TrackBar14: TTrackBar;
    TrackBar15: TTrackBar;
    Panel21: TPanel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    TrackBar16: TTrackBar;
    TrackBar17: TTrackBar;
    TrackBar18: TTrackBar;
    Panel22: TPanel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    TrackBar19: TTrackBar;
    TrackBar20: TTrackBar;
    TrackBar21: TTrackBar;
    Panel23: TPanel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    TrackBar22: TTrackBar;
    TrackBar23: TTrackBar;
    TrackBar24: TTrackBar;
    Panel24: TPanel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    TrackBar25: TTrackBar;
    TrackBar26: TTrackBar;
    TrackBar27: TTrackBar;
    Panel25: TPanel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    TrackBar28: TTrackBar;
    TrackBar29: TTrackBar;
    TrackBar30: TTrackBar;
    Panel26: TPanel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    TrackBar31: TTrackBar;
    TrackBar32: TTrackBar;
    TrackBar33: TTrackBar;
    Panel27: TPanel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    TrackBar34: TTrackBar;
    TrackBar35: TTrackBar;
    TrackBar36: TTrackBar;
    Panel28: TPanel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    TrackBar37: TTrackBar;
    TrackBar38: TTrackBar;
    TrackBar39: TTrackBar;
    pColorNum: TPanel;
    lblLegs1red: TLabel;
    lblLegs1green: TLabel;
    lblLegs1blue: TLabel;
    Panel29: TPanel;
    lblLegs2red: TLabel;
    lblLegs2green: TLabel;
    lblLegs2blue: TLabel;
    Panel30: TPanel;
    lblBootsred: TLabel;
    lblBootsgreen: TLabel;
    lblbootsblue: TLabel;
    Panel31: TPanel;
    lblchest1red: TLabel;
    lblchest1green: TLabel;
    lblchest1blue: TLabel;
    Panel32: TPanel;
    lblchest2red: TLabel;
    lblchest2green: TLabel;
    lblchest2blue: TLabel;
    Panel33: TPanel;
    lblarmsred: TLabel;
    lblarmsgreen: TLabel;
    lblarmsblue: TLabel;
    Panel34: TPanel;
    lblbeltred: TLabel;
    lblbeltgreen: TLabel;
    lblbeltblue: TLabel;
    Panel35: TPanel;
    lblchest3red: TLabel;
    lblchest3green: TLabel;
    lblchest3blue: TLabel;
    Panel36: TPanel;
    lblhandsred: TLabel;
    lblhandsgreen: TLabel;
    lblhandsblue: TLabel;
    Panel37: TPanel;
    lblouterred: TLabel;
    lbloutergreen: TLabel;
    lblouterblue: TLabel;
    Panel38: TPanel;
    lblheadred: TLabel;
    lblheadgreen: TLabel;
    lblheadblue: TLabel;
    Panel39: TPanel;
    lblhelmred: TLabel;
    lblhelmgreen: TLabel;
    lblhelmblue: TLabel;
    Panel40: TPanel;
    lblweaponred: TLabel;
    lblweapongreen: TLabel;
    lblweaponblue: TLabel;
    Panel41: TPanel;
    lblshieldred: TLabel;
    lblshieldgreen: TLabel;
    lblshieldblue: TLabel;
    SaveDialog1: TSaveDialog;
    rgCombatType: TRadioGroup;
    Label85: TLabel;
    Label86: TLabel;
    OpenDialog1: TOpenDialog;
    cbPainSFX: TComboBox;
    cbDeathSFX: TComboBox;
    procedure Timer1Timer(Sender: TObject);
    procedure MainTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Imglegs1Click(Sender: TObject);
    procedure imgBeltClick(Sender: TObject);
    procedure ImgweaponClick(Sender: TObject);
    procedure ImgShieldClick(Sender: TObject);
    procedure ImgHelmetClick(Sender: TObject);
    procedure ImgChest1Click(Sender: TObject);
    procedure ImgBootsClick(Sender: TObject);
    procedure ImgGauntletsClick(Sender: TObject);
    procedure imgOuterClick(Sender: TObject);
    procedure imgChest3Click(Sender: TObject);
    procedure Imglegs2Click(Sender: TObject);
    procedure ImgHeadClick(Sender: TObject);
    procedure imgchest2Click(Sender: TObject);

    procedure imgarmsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditValidLayer1Click(Sender: TObject);
    procedure OpenCharacterImage1Click(Sender: TObject);
    procedure OpenImagePath1Click(Sender: TObject);
    procedure ColorAdjust1Click(Sender: TObject);
    procedure ChangeAction1Click(Sender: TObject);
    procedure BackGroundColor1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure BLImgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LoadDefaultAction1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SortOrder1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure OpenDirectory(strDirectory: string);
    procedure btnPauseClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnbackClick(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure EditanImage1Click(Sender: TObject);
    procedure SaveiniData1Click(Sender: TObject);
    procedure ResetForNewCharacter1Click(Sender: TObject);
    procedure ViewFullAnimation1Click(Sender: TObject);
    procedure Imglegs1Paint(Sender: TObject);
    procedure imgChest3Paint(Sender: TObject);
    procedure tbLegs1BlueChange(Sender: TObject);
    procedure tbLegs1RedChange(Sender: TObject);
    procedure tbLegs1GreenChange(Sender: TObject);
    procedure MakeAGif1Click(Sender: TObject);


  private
    { Private declarations }

    RLE: TRLESprite;
    BaseRLE: TRLESprite;
    gBitPlane: TBitPlane;
    Comments: string;

    Leg1frame :integer;
    Leg2frame :integer;
    Bootframe :integer;
    Chest1frame :integer;
    Chest2frame :integer;
    Armframe :integer;
    Beltframe :integer;
    Chest3frame :integer;
    Gauntletframe :integer;
    Outerframe :integer;
    Weaponframe :integer;
    Shieldframe :integer;
    Headframe :integer;
    Helmetframe :integer;



  public
    { Public declarations }
    NextFrame : integer;
    FirstFrame: integer;
    LastFrame: integer;
    ListFrames: String;
    ListAllFrames: String;
    FrameCounter:  integer;
    MainIniFile: TMemIniFile;
    BaseIniFile: TMemIniFile;
    MaxFrameCount : integer;
    FrameWidth: integer;   // Read from GIF/INI, don't leave as const
    FrameHeight: integer;  // Read from GIF/INI, don't leave as const
    TotalFiles: integer;
    TagTrack: integer;
    TotalImages: integer;
    bPause: boolean;
    strDBFile: string;
    pObjResourceFolder: string;          //set this to the root folder for object GIFs
    pLogFile: string;                    //set this to the name of the log text file
    SortFileName: string;
    SortImage : TBLImage;
    SortClick :TNotifyEvent;
    strDatabase: string;
    iCharacterID: integer;
    strCharPath: string;
    strTexPath: string;
    sfxLookup: TStringList;
    procedure AnimationControl;
    procedure ItemAnimation;
    function  ProcessGif(ImgID: integer; fName: String): Boolean;
    procedure LoadAFile(Filename: string);
    procedure CountFiles(Filename: string);
    Procedure BuildIni(fName: string);
    procedure SelectImage(sltImage: TBLImage; var PvImage: TBLImage);
    function BackFrameTest(ImgBackFrames: string; TstFrame: integer): Boolean;
    procedure EditIniData(FileName: string);
    procedure UpdateImage(newFrame: Integer);
    procedure ResetAll;
    procedure LoadPOX(POXFile: string; tmpMemInifile: TMemIniFile);
    procedure LoadPOX2(var Image: TBLImage; POXFile: string; var tmpMemInifile: TMemIniFile);
    procedure SavePOX(POXFile: string; tmpIniFile: TMemIniFile);
    procedure Draw(indx: integer; Image: TBLImage; MyCanvas: TCanvas);
    function Compile(): TRLESprite;
    procedure DrawColoredparts(Frame: integer; BitPlane : PBITPLANE );
    procedure WriteLayeredPoxToDisk(fileName: string);
    procedure WriteTextureAction(FilePath: string; Frames: string; Action: string; Dir: string);
    procedure WriteCharStand(FilePath: string);
    procedure ActionStartStop(var iStart, iStop: integer; Dir, Action: string);
    procedure SaveNewCharDBData(strFileName: string; iFrame: integer);
    procedure SaveNewCharActionFileData(strFileName: string; strDir: string; strAction: string);
    procedure SaveNewCharStandFileData(strFileName: string);
    procedure LoadIniFile;
    procedure LoadSFX;
    procedure SaveSFX(strCharacterID: string);
  end;

var
  frmBuildLayer: TfrmBuildLayer;
  IniFile: TMemIniFile;
  SettingIni: TIniFile;
  BGColor: TColor;
  mColor: TColor;
  strNameBase: string;

//  ViewAllList: TList;
//  ViewAllListBMP : TBitmap;
//  UsedGifList: TStringList;
//  XRefFieldCount: integer;
//  ItemDatabase: TStringList;
//  XRefDatabase: TStringList;
implementation

{$R *.DFM}

uses
  fLoading1, TextFile, options, process, actions;


// Timer1Timer
// The work-horse routine for display animation. Feel free to optimize.
procedure TfrmBuildLayer.Timer1Timer(Sender: TObject);
begin
(*
   Assumes all the MainView layers will be painted in order here. It is
   possible for a specific layer to not have any objects selected, so
   empty layers need to be skipped.

   NOTE: The proper drawing order for layers is a follows:
    Legs1 (drawn first)
    Legs2 (drawn next)
    Boots
    Chest1
    Chest2
    Arms
    Belt
    Chest3
    Gauntlets
    Outer (see note 1)
    Weapon
    Shield (see note 2)
    Head
    Helmet

 Note 1: Outer can be a special 2-part image with a "near/front" and a "far/back"
 part. In the current example \Resource files that I provided, the near/front
 image is called "_grey hooded cloak front.gif" and its matching far/back
 image is "grey hooded cloak.gif"  I've not actually decided on a naming convention,
 and the GIF/INI doesn't yet have an entry linking these 2 parts (so hard code
 this one image for now until we work this out). If the GreyHoodedCloak is
 selected to be drawn on MainView then it must be handled in the special way all
 2-part "Outer" items are:
   1) the far/back part is actually drawn even before the NakedMan, it must be
       the very farthest (first drawn) of everything in the MainView.
   2) the near/front part is drawn in the order shown above, after Gauntlets and
       before Weapon

 Note 2: Shield is a special case. For displaying in MainView, and for
 constructing the output GIF of the dressed character, it is important to note
 that the Shield is always worn on the Left arm. When the character is walking
 towards the user (the SS or South action direction), or towards the left of
 the screen (the WW or West action direction) then the shield can be drawn in
 the order listed above. However the drawing order changes when the character
 is walking in these specific action directions:
   NE (North East, or towards 1:30 clock direction)
   EE (East, or towards 3:00)
   SE (South East, or towards 4:30)
 During only these action directions the shield should be drawn before Legs1
 (immediately after the NakedMan).
 You can tell which frames of the animation relate to these facings by looking
 at the GIF/INI text comment data in the Shield GIF file. It will have these
 entries:

  [HEADER]
  Actions=Walk ; Usually has "Actions=Stand,Walk,Fight,Pain,Death" as the value

  [Action Walk]
  NWFrames=1,2,3,4,5,6,7,8,LOOP ; the "Loop" parameter is optional!
  NNFrames=9,10,11,12,13,14,15,16,LOOP
  NEFrames=17,18,19,20,21,22,23,24,LOOP
  EEFrames=25,26,27,28,29,30,31,32,LOOP
  SEFrames=33,34,35,36,37,38,39,40,LOOP
  SSFrames=41,42,43,44,45,46,47,48,LOOP
  SWFrames=49,50,51,52,53,54,55,56,LOOP
  WWFrames=57,58,59,60,61,62,63,64,LOOP

 From the above you can see that during animation frames 17 through 40 the
 drawing order of a Shield has to be shifted before Legs1. Note that as
 action sequences are added to the GIF files that the order of frames changes,
 so don't hard code any frame number assumptions. The key names ("Actions",
 "NWFrames", "WWFrames", etc.) are certainly consistent. The "[Action Walk]"
 section only exists if there is a "Walk" value in the  "Actions=" part of the
 [Header] section. Frames do not have to be in any order, and can repeat...
 If you don't see valid frames available during loading then reject the GIF
 and clearly note that in an error message to the user. In the near future we
 will allow the user to select which "Action" sequence to preview in the
 MainView, but for now we can hard-code it to "Walk" only.
*)

end;

procedure TfrmBuildLayer.MainTimerTimer(Sender: TObject);
begin
     application.processmessages;
     AnimationControl;
end;

procedure TfrmBuildLayer.FormCreate(Sender: TObject);
begin

  MaxFrameCount := 0;
  NextFrame := -1;
  TagTrack := -1;
  FirstFrame := 0;
  LastFrame := 63;
  iCharacterID := -1;
  // mColor := 16737535;
    mColor := 16745215; //fushia

 // mColor := 0;

//  PoxManager  := TList.create;
//  PoxManager  := TStringList.create;

//  FImageManager := TImageManager.Create;
//  FImageManager.MaxImageCache := 64;

//  MainImgMngr := TImageManager.Create;
//  MainImgMngr.MaxImageCache := 32;

//  TabImgMngr := TImageManager.Create;
//  TabImgMngr.MaxImageCache := 16;
  //  UsedGifList := TStringList.Create;
  bPause := false;

  Leg1frame := 20;
  Leg2frame := 20;
  Bootframe := 20;
  Chest1frame := 20;
  Chest2frame := 20;
  Armframe := 1;
  Beltframe := 20;
  Chest3frame := 20;
  Gauntletframe := 22;
  Outerframe := 21;
  Weaponframe := 16;
  Shieldframe := 1;
  Headframe := 18;
  Helmetframe := 18;
  
end;

procedure TfrmBuildLayer.FormDestroy(Sender: TObject);
begin
  maintimer.Enabled := false;
  MainIniFile.free;
  BaseIniFile.free;


  Try
    Imglegs1.RLE := nil;
    Imglegs2.RLE := nil;
    ImgBoots.RLE := nil;
    ImgChest1.RLE := nil;
    imgchest2.RLE := nil;
    imgBelt.RLE := nil;
    ImgGauntlets.RLE := nil;
    ImgHead.RLE := nil;
    ImgHelmet.RLE := nil;
    Imgweapon.RLE := nil;
    ImgShield.RLE := nil;
    imgOuter.RLE := nil;
    imgChest3.RLE := nil;
    imgarms.RLE := nil;

    while sbxLegs1.ComponentCount <> 0 do
        (sbxLegs1.Components[0] as TBLImage).free;
    while sbxLegs2.ComponentCount <> 0 do
        (sbxLegs2.Components[0] as TBLImage).free;
    while sbxHead.ComponentCount <> 0 do
        (sbxHead.Components[0] as TBLImage).free;
    while sbxboots.ComponentCount <> 0 do
        (sbxboots.Components[0] as TBLImage).free;
    while sbxChest1.ComponentCount <> 0 do
        (sbxChest1.Components[0] as TBLImage).free;
    while sbxChest2.ComponentCount <> 0 do
        (sbxChest2.Components[0] as TBLImage).free;
    while sbxArms.ComponentCount <> 0 do
        (sbxArms.Components[0] as TBLImage).free;
    while sbxBelt.ComponentCount <> 0 do
        (sbxBelt.Components[0] as TBLImage).free;
    while sbxchest3.ComponentCount <> 0 do
        (sbxChest3.Components[0] as TBLImage).free;
    while sbxGauntlets.ComponentCount <> 0 do
        (sbxGauntlets.Components[0] as TBLImage).free;
    while sbxOuter.ComponentCount <> 0 do
        (sbxOuter.Components[0] as TBLImage).free;
    while sbxShield.ComponentCount <> 0 do
        (sbxShield.Components[0] as TBLImage).free;
    while sbxWeapon.ComponentCount <> 0 do
        (sbxWeapon.Components[0] as TBLImage).free;
   while sbxHelmet.ComponentCount <> 0 do
        (sbxHelmet.Components[0] as TBLImage).free;

   RLE.free;
   RLE := nil;
   BaseRLE.free;
   BaseRLE := nil;
   gBitPlane.free;
   gBitPlane := nil;
  except
   //Log Error
  end;

end;

procedure TfrmBuildLayer.Imglegs1Click(Sender: TObject);
begin
  if Sender = ImgLegs1 then
    (sender as TBLImage).InUse := Not((sender as TBLImage).InUse)
  else
     SelectImage((sender as TBLImage), ImgLegs1);
  UpdateImage(-1);

end;

procedure TfrmBuildLayer.imgBeltClick(Sender: TObject);
begin
  if Sender = Imgbelt then
    (Sender as TBLImage).InUse := Not((Sender as TBLImage).InUse)
  else
     SelectImage((sender as TBLImage), Imgbelt);
  UpdateImage(-1);

end;

procedure TfrmBuildLayer.ImgweaponClick(Sender: TObject);
begin
  if Sender = ImgWeapon then
    (Sender as TBLImage).InUse := Not((Sender as TBLImage).InUse)
  else
     SelectImage((sender as TBLImage), ImgWeapon);
  UpdateImage(-1);
end;

procedure TfrmBuildLayer.ImgShieldClick(Sender: TObject);
begin
  if Sender = ImgShield then
    (Sender as TBLImage).InUse := Not((Sender as TBLImage).InUse)
  else
      SelectImage((sender as TBLImage), ImgShield);
  UpdateImage(-1);
end;

procedure TfrmBuildLayer.ImgHelmetClick(Sender: TObject);
begin
  if Sender = ImgHelmet then
    (Sender as TBLImage).InUse := Not((Sender as TBLImage).InUse)
  else
     SelectImage((sender as TBLImage), ImgHelmet);
  UpdateImage(-1);
end;

procedure TfrmBuildLayer.ImgChest1Click(Sender: TObject);
begin
  if Sender = ImgChest1 then
    (Sender as TBLImage).InUse := Not((Sender as TBLImage).InUse)
  else
     SelectImage((sender as TBLImage), ImgChest1);
  UpdateImage(-1);
end;

procedure TfrmBuildLayer.ImgBootsClick(Sender: TObject);
begin
  if Sender = ImgBoots then
    (Sender as TBLImage).InUse := Not((Sender as TBLImage).InUse)
  else
     SelectImage((sender as TBLImage), ImgBoots);
  UpdateImage(-1);
end;

procedure TfrmBuildLayer.ImgGauntletsClick(Sender: TObject);
begin
  if Sender = ImgGauntlets then
    (Sender as TBLImage).InUse := Not((Sender as TBLImage).InUse)
  else
      SelectImage((sender as TBLImage), ImgGauntlets);
  UpdateImage(-1);
end;

procedure TfrmBuildLayer.imgOuterClick(Sender: TObject);
begin
  if Sender = ImgOuter then
    (Sender as TBLImage).InUse := Not((Sender as TBLImage).InUse)
  else
      SelectImage((sender as TBLImage), ImgOuter);
  UpdateImage(-1);
end;

procedure TfrmBuildLayer.imgChest3Click(Sender: TObject);
begin
  if Sender = ImgChest3 then
    (Sender as TBLImage).InUse := Not((Sender as TBLImage).InUse)
  else
     SelectImage((sender as TBLImage), ImgChest3);
  UpdateImage(-1);
end;

procedure TfrmBuildLayer.Imglegs2Click(Sender: TObject);
begin
  if Sender = Imglegs2 then
    (Sender as TBLImage).InUse := Not((Sender as TBLImage).InUse)
  else
     SelectImage((sender as TBLImage), Imglegs2);
  UpdateImage(-1);
end;

procedure TfrmBuildLayer.ImgHeadClick(Sender: TObject);
begin
  if Sender = ImgHead then
    (Sender as TBLImage).InUse := Not((Sender as TBLImage).InUse)
  else
     SelectImage((sender as TBLImage), ImgHead);
  UpdateImage(-1);
end;

procedure TfrmBuildLayer.imgchest2Click(Sender: TObject);
begin
  if Sender = ImgChest2 then
    (Sender as TBLImage).InUse := Not((Sender as TBLImage).InUse)
  else
     SelectImage((sender as TBLImage), ImgChest2);
  UpdateImage(-1);
end;

procedure TfrmBuildLayer.ItemAnimation;
begin
    try
        if (pcLayerTabs.ActivePage = tsShield) and ((MainTimer.enabled) or bpause) then
        begin
             imgShield.Canvas.Brush.Color := BGColor;
             imgShield.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgShield, imgShield.Canvas);
        end;

        if (pcLayerTabs.ActivePage = tsWeapon) and ((MainTimer.enabled) or bpause) then
        begin
             imgWeapon.Canvas.Brush.Color := BGColor;
             imgWeapon.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgWeapon, imgWeapon.Canvas);
        end;


        if (pcLayerTabs.ActivePage = tsHelmet) and ((MainTimer.enabled) or bpause) then
        begin
             imgHelmet.Canvas.Brush.Color := BGColor;
             imgHelmet.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgHelmet, imgHelmet.Canvas);
        end;
        if (pcLayerTabs.ActivePage = tsHead) and ((MainTimer.enabled) or bpause) then
        begin
             imgHead.Canvas.Brush.Color := BGColor;
             imgHead.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgHead, imgHead.Canvas);
        end;
        if (pcLayerTabs.ActivePage = tsOuter) and ((MainTimer.enabled) or bpause) then
        begin
             imgOuter.Canvas.Brush.Color := BGColor;
             imgOuter.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgOuter, imgOuter.Canvas);
        end;
        if (pcLayerTabs.ActivePage = tsGauntlets) and ((MainTimer.enabled) or bpause) then
        begin
             imgGauntlets.Canvas.Brush.Color := BGColor;
             imgGauntlets.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgGauntlets, imgGauntlets.Canvas);
        end;
        if (pcLayerTabs.ActivePage = tsChest3) and ((MainTimer.enabled) or bpause) then
        begin
             imgChest3.Canvas.Brush.Color := BGColor;
             imgChest3.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgChest3, imgChest3.Canvas);
        end;
        if (pcLayerTabs.ActivePage = tsBelt) and ((MainTimer.enabled) or bpause) then
        begin
             imgBelt.Canvas.Brush.Color := BGColor;
             imgBelt.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgBelt, imgBelt.Canvas);
        end;
        if (pcLayerTabs.ActivePage = tsArms) and ((MainTimer.enabled) or bpause) then
        begin
             imgArms.Canvas.Brush.Color := BGColor;
             imgArms.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgArms, imgArms.Canvas);
        end;
        if (pcLayerTabs.ActivePage = tsChest2) and ((MainTimer.enabled) or bpause) then
        begin
             imgChest2.Canvas.Brush.Color := BGColor;
             imgChest2.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgChest2, imgChest2.Canvas);
        end;
        if (pcLayerTabs.ActivePage = tsChest1) and ((MainTimer.enabled) or bpause) then
        begin
             imgchest1.Canvas.Brush.Color := BGColor;
             imgChest1.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgchest1, imgchest1.Canvas);
        end;
        if (pcLayerTabs.ActivePage = tsBoots) and ((MainTimer.enabled) or bpause) then
        begin
             imgboots.Canvas.Brush.Color := BGColor;
             imgBoots.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgboots, imgboots.Canvas);
        end;
        if (pcLayerTabs.ActivePage = tslegs2) and ((MainTimer.enabled) or bpause) then
        begin
             imgLegs2.Canvas.Brush.Color := BGColor;
             imgLegs2.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgLegs2, imgLegs2.Canvas);
        end;
        if (pcLayerTabs.ActivePage = tslegs1) and ((MainTimer.enabled) or bpause) then
        begin
             imgLegs1.Canvas.Brush.Color := BGColor;
             imgLegs1.Canvas.FillRect(Rect(0,0,160,160));
             Draw(NextFrame,imgLegs1, imgLegs1.Canvas);
        end;
    except
       //ignor it for now we dont need it
    end;

end;

procedure TfrmBuildLayer.AnimationControl;
var
  BitPlane: TBitPlane;
begin
//    BitPlane := nil;
    BitPlane:=TBitPlane.create(FrameWidth,FrameHeight);
    BitPlane.KeyColor := BGColor;
    BitPlane.Clear;

    Inc(FrameCounter);//Frame Control
    if FrameCounter = strTokenCount(ListFrames, '|') then FrameCounter :=  0;
    NextFrame := StrToInt(StrTokenAt(ListFrames, '|', FrameCounter));

    try


    if imgShield.ManagerIndex <> -1 then
    //*************2-Part Image stuff***************
    if (imgShield.LinkedLayerFirstFrame <> -1)then
    begin
        if imgShield.InUse then
        imgShield.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgShield.Red,imgShield.Green,imgShield.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgShield.LayeredFramesToBack, NextFrame) then
    begin
        if imgShield.InUse then
          imgShield.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgShield.Red,imgShield.Green,imgShield.Blue,100,0);
    end;

    if imgWeapon.ManagerIndex <> -1 then
    //*************2-Part Image stuff***************
    if (imgWeapon.LinkedLayerFirstFrame <> -1)then
    begin
        if imgWeapon.InUse then
        imgWeapon.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgWeapon.Red,imgWeapon.Green,imgWeapon.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgWeapon.LayeredFramesToBack, NextFrame) then
    begin
        if imgWeapon.InUse then
           imgWeapon.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgWeapon.Red,imgWeapon.Green,imgWeapon.Blue,100,0);
    end;


    if imgHelmet.ManagerIndex <> -1 then
    //*************2-Part Image stuff***************
    if (imgHelmet.LinkedLayerFirstFrame <> -1)then
    begin
        if imgHelmet.InUse then
        imgHelmet.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgHelmet.Red,imgHelmet.Green,imgHelmet.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgHelmet.LayeredFramesToBack, NextFrame) then
    begin
        if imgHelmet.InUse then
        imgHelmet.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgHelmet.Red,imgHelmet.Green,imgHelmet.Blue,100,0);
    end;


    if ImgHead.ManagerIndex <> -1 then
    //*************2-Part Image stuff***************
    if (ImgHead.LinkedLayerFirstFrame <> -1)then
    begin
        if ImgHead.InUse then
        ImgHead.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,ImgHead.Red,ImgHead.Green,ImgHead.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgHead.LayeredFramesToBack, NextFrame) then
    begin
        if ImgHead.InUse then
        ImgHead.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,ImgHead.Red,ImgHead.Green,ImgHead.Blue,100,0);
    end;

    if imgOuter.ManagerIndex <> -1 then
    //*************2-Part Image stuff***************
    if (imgOuter.LinkedLayerFirstFrame <> -1)then
    begin
        if imgOuter.InUse then
        imgOuter.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgOuter.Red,imgOuter.Green,imgOuter.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgOuter.LayeredFramesToBack, NextFrame) then
    begin
        if imgOuter.InUse then
        imgOuter.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgOuter.Red,imgOuter.Green,imgOuter.Blue,100,0);
    end;


    if imgGauntlets.ManagerIndex <> -1 then
    //*************2-Part Image stuff***************
    if (imgGauntlets.LinkedLayerFirstFrame <> -1)then
    begin
        if imgGauntlets.InUse then
        imgGauntlets.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgGauntlets.Red,imgGauntlets.Green,imgGauntlets.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgGauntlets.LayeredFramesToBack, NextFrame) then
    begin
        if imgGauntlets.InUse then
        imgGauntlets.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgGauntlets.Red,imgGauntlets.Green,imgGauntlets.Blue,100,0);
    end;


    if imgChest3.ManagerIndex <> -1 then
    //*************2-Part Image stuff***************
    if (imgChest3.LinkedLayerFirstFrame <> -1)then
    begin
        if imgChest3.InUse then
        imgChest3.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgChest3.Red,imgChest3.Green,imgChest3.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgChest3.LayeredFramesToBack, NextFrame) then
    begin
        if imgChest3.inuse then
        imgChest3.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgChest3.Red,imgChest3.Green,imgChest3.Blue,100,0);
    end;


    if imgBelt.ManagerIndex <> -1 then
    //*************2-Part Image stuff***************
    if (imgBelt.LinkedLayerFirstFrame <> -1)then
    begin
        if imgBelt.InUse then
        imgBelt.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgBelt.Red,imgBelt.Green,imgBelt.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgBelt.LayeredFramesToBack, NextFrame) then
    begin
        if imgBelt.InUse then
        imgBelt.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgBelt.Red,imgBelt.Green,imgBelt.Blue,100,0);
    end;

    if imgArms.ManagerIndex <> -1 then
    //*************2-Part Image stuff***************
    if (imgArms.LinkedLayerFirstFrame <> -1)then
    begin
        if imgArms.InUse then
        imgArms.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgArms.Red,imgArms.Green,imgArms.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgArms.LayeredFramesToBack, NextFrame) then
    begin
        if imgArms.InUse then
        imgArms.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgArms.Red,imgArms.Green,imgArms.Blue,100,0);
    end;


    if imgChest2.ManagerIndex <> -1 then
    //*************2-Part Image stuff***************
    if (imgChest2.LinkedLayerFirstFrame <> -1)then
    begin
        if imgChest2.InUse then
        imgChest2.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgChest2.Red,imgChest2.Green,imgChest2.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgChest2.LayeredFramesToBack, NextFrame) then
    begin
        if imgChest2.InUse then
        imgChest2.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgChest2.Red,imgChest2.Green,imgChest2.Blue,100,0);
    end;


    if ImgChest1.ManagerIndex <> -1 then
    //*************2-Part Image stuff***************
    if (ImgChest1.LinkedLayerFirstFrame <> -1)then
    begin
        if ImgChest1.InUse then
        ImgChest1.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,ImgChest1.Red,imgShield.Green,ImgChest1.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgChest1.LayeredFramesToBack, NextFrame) then
    begin
        if ImgChest1.InUse then
        ImgChest1.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,ImgChest1.Red,ImgChest1.Green,ImgChest1.Blue,100,0);
    end;


    if imgBoots.ManagerIndex <> -1 then
    //*************2-Part Image stuff***************
    if (imgBoots.LinkedLayerFirstFrame <> -1)then
    begin
        if imgBoots.InUse then
        imgBoots.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgBoots.Red,imgBoots.Green,imgBoots.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgBoots.LayeredFramesToBack, NextFrame) then
    begin
        if imgBoots.InUse then
        imgBoots.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgBoots.Red,imgBoots.Green,imgBoots.Blue,100,0);
    end;

    if Imglegs2.ManagerIndex <> -1 then
    //*************2-Part Image stuff***************
    if (Imglegs2.LinkedLayerFirstFrame <> -1)then
    begin
        if Imglegs2.InUse then
        Imglegs2.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,Imglegs2.Red,Imglegs2.Green,Imglegs2.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(Imglegs2.LayeredFramesToBack, NextFrame) then
    begin

        if Imglegs2.InUse then
        Imglegs2.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,Imglegs2.Red,Imglegs2.Green,Imglegs2.Blue,100,0);
    end;

    if Imglegs1.ManagerIndex <> -1  then
    //*************2-Part Image stuff***************
    if (Imglegs1.LinkedLayerFirstFrame <> -1)then
    begin
        if Imglegs1.InUse then
        Imglegs1.BackRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,Imglegs1.Red,Imglegs1.Green,Imglegs1.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(Imglegs1.LayeredFramesToBack, NextFrame) then
    begin
        if Imglegs1.InUse then
        Imglegs1.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,Imglegs1.Red,Imglegs1.Green,Imglegs1.Blue,100,0);
    end;
    except
        //ignor it for now we dont need it
    end;



  //  MainImgMngr.DrawMaskedImage(NextFrame, BmpBuffer.canvas, 0,0); //draw naked man
      BaseRLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,MainImg.Red,MainImg.Green,MainImg.Blue,100,0);


    try
    if Imglegs1.ManagerIndex <> -1  then
    if Not(BackFrameTest(Imglegs1.LayeredFramesToBack, NextFrame)) then
    begin
        if Imglegs1.InUse then
         Imglegs1.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,Imglegs1.Red,Imglegs1.Green,Imglegs1.Blue,100,0);
    end;

    if Imglegs2.ManagerIndex <> -1 then
    if Not(BackFrameTest(Imglegs2.LayeredFramesToBack, NextFrame)) then
    begin

        if Imglegs2.InUse then
        Imglegs2.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,Imglegs2.Red,Imglegs2.Green,Imglegs2.Blue,100,0);
    end;


    if imgBoots.ManagerIndex <> -1 then
    if Not(BackFrameTest(imgBoots.LayeredFramesToBack, NextFrame)) then
    begin
        if imgBoots.InUse then
        imgBoots.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgBoots.Red,imgBoots.Green,imgBoots.Blue,100,0);
    end;

    if ImgChest1.ManagerIndex <> -1 then
    if Not(BackFrameTest(imgChest1.LayeredFramesToBack, NextFrame)) then
    begin
        if ImgChest1.InUse then
        ImgChest1.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,ImgChest1.Red,ImgChest1.Green,ImgChest1.Blue,100,0);
    end;

    if imgChest2.ManagerIndex <> -1 then
    if Not(BackFrameTest(imgChest2.LayeredFramesToBack, NextFrame)) then
    begin
        if imgChest2.InUse then
        imgChest2.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgChest2.Red,imgChest2.Green,imgChest2.Blue,100,0);
    end;

    if imgArms.ManagerIndex <> -1 then
    if Not(BackFrameTest(imgArms.LayeredFramesToBack, NextFrame)) then
    begin
        if imgArms.InUse then
        imgArms.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgArms.Red,imgArms.Green,imgArms.Blue,100,0);
    end;

    if imgBelt.ManagerIndex <> -1 then
    if Not(BackFrameTest(imgBelt.LayeredFramesToBack, NextFrame)) then
    begin
        if imgBelt.InUse then
        imgBelt.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgBelt.Red,imgBelt.Green,imgBelt.Blue,100,0);
    end;

    if imgChest3.ManagerIndex <> -1 then
    if Not(BackFrameTest(imgChest3.LayeredFramesToBack, NextFrame)) then
    begin
        if imgChest3.inuse then
        imgChest3.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgChest3.Red,imgChest3.Green,imgChest3.Blue,100,0);
    end;

    if imgGauntlets.ManagerIndex <> -1 then
    if Not(BackFrameTest(imgGauntlets.LayeredFramesToBack, NextFrame)) then
    begin
        if imgGauntlets.InUse then
        imgGauntlets.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgGauntlets.Red,imgGauntlets.Green,imgGauntlets.Blue,100,0);
    end;

    if imgOuter.ManagerIndex <> -1 then
    if Not(BackFrameTest(imgOuter.LayeredFramesToBack, NextFrame)) then
    begin
        if imgOuter.InUse then
        imgOuter.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgOuter.Red,imgOuter.Green,imgOuter.Blue,100,0);
    end;


    if ImgHead.ManagerIndex <> -1 then
    if Not(BackFrameTest(imgHead.LayeredFramesToBack, NextFrame)) then
    begin
        if ImgHead.InUse then
        ImgHead.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,ImgHead.Red,ImgHead.Green,ImgHead.Blue,100,0);
    end;

    if imgHelmet.ManagerIndex <> -1 then
    if Not(BackFrameTest(imgHelmet.LayeredFramesToBack, NextFrame)) then
    begin
        if imgHelmet.InUse then
        imgHelmet.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgHelmet.Red,imgHelmet.Green,imgHelmet.Blue,100,0);
    end;
    if imgWeapon.ManagerIndex <> -1 then
    if Not(BackFrameTest(imgWeapon.LayeredFramesToBack, NextFrame)) then
    begin
        if imgWeapon.InUse then
        imgWeapon.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgWeapon.Red,imgWeapon.Green,imgWeapon.Blue,100,0);
    end;


    if imgShield.ManagerIndex <> -1 then
    if Not(BackFrameTest(imgShield.LayeredFramesToBack, NextFrame)) then
    begin
        if imgShield.InUse then
        imgShield.RLE.DrawColorize(NextFrame,0,0,BitPlane.Bits,imgShield.Red,imgShield.Green,imgShield.Blue,100,0);
    end;

    except
       //ignor it for now we dont need it
    end;


    if (MainTimer.enabled) or (bpause) then //incase background drawing is needed
    begin
//       MainImg.canvas.StretchDraw(MainImg.canvas.ClipRect,BmPBuffer);
         BitPlane.DrawToDC(MainImg.canvas.handle,0,0);
         //BitPlane.free;
    end;

    lblFrameCount.Caption := IntToStr(NextFrame);
    BitPlane.Free;
    BitPlane := nil;
    ItemAnimation;
    application.processmessages;//finish everything else up
end;



Function TfrmBuildLayer.ProcessGif(ImgID: integer; fName: String): Boolean;
var
   MyNewImage: TBLImage;
   MyIniFile: TMemIniFile;
//   aBitmap: TBitmap;

   procedure AddaTImage(ImgScrollBox: TScrollBox; ImgClick :TNotifyEvent; DisplayFrame: Integer);
   begin
          MyNewImage := TBLImage.create(ImgScrollBox);
          LoadPOX2(MyNewImage, fName,MyIniFile);

          MyNewImage.ManagerIndex := 0;
          MyNewImage.Parent := ImgScrollBox;
          MyNewImage.Height := FrameHeight + 10;
          MyNewImage.Width := FrameWidth - 10;
          MyNewImage.top := 0;
          MyNewImage.DisplayFrame := DisplayFrame;
          MyNewImage.OnPaint := Imglegs1Paint;
          MyNewImage.left :=  ((FrameWidth - 10) * (ImgScrollBox.ComponentCount-1)) + 4;
          ImgScrollBox.HorzScrollBar.Range :=  ((FrameWidth - 10) * (ImgScrollBox.ComponentCount-1)) + 148;
          MyNewImage.ImageID := ImgID;
          MyNewImage.OnClick := ImgClick;
          MyNewImage.OnMouseDown:=  BLImgMouseDown ;
          MyNewImage.PopupMenu:= popBLImage;
          MyNewImage.MaxFrameCount := MyNewImage.RLE.frames;
          MyNewImage.FirstFrame := -1;
          MyNewImage.LastFrame := (MyNewImage.RLE.Frames-1);
          MyNewImage.ImagePath := fName;
          copyMemIniFile(MyIniFile, MyNewImage.IniFile);
          MyNewImage.InitImage;
          MyNewImage.Show;
   end;

begin

try
   MyIniFile := TMemIniFile.Create('');
   MyNewImage := nil;
   LoadPOX2(MyNewImage, fName, MyIniFile);

   if not(MyIniFile.ReadString('HEADER', 'LayeredParts','') = 'Yes') then
      begin
           Result := false;
           exit;
      end;
   if (tsLegs1.tabVisible) and (strContains('leg1',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxLegs1,Imglegs1Click, Leg1frame);

   if (tsLegs2.tabVisible) and (strContains('leg2',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxLegs2,Imglegs2Click, Leg2Frame);

   if (tsBoots.tabVisible) and (strContains('boot',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxBoots,ImgBootsClick, bootFrame);

   if (tsChest1.tabVisible) and (strContains('chest1',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxchest1,Imgchest1Click, chest1frame);

   if (tsChest2.tabVisible) and (strContains('chest2',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxChest2, ImgChest2Click, chest2frame);

   if (tsArms.tabVisible) and (strContains('arm',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxArms, ImgArmsClick, armframe);

   if (tsBelt.tabVisible) and (strContains('belt',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxbelt, ImgbeltClick, beltframe);

   if (tsChest3.tabVisible) and (strContains('chest3',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxChest3, ImgChest3Click, chest3frame);

   if (tsGauntlets.tabVisible) and (strContains('gauntlet',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxGauntlets, ImgGauntletsClick, gauntletframe);

   if (tsOuter.tabVisible) and (strContains('outer',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxOuter, ImgOuterClick, outerframe);

   if (tsWeapon.tabVisible) and (strContains('weapon',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxweapon, ImgWeaponClick, weaponframe);

   if (tshead.tabVisible) and (strContains('head',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxHead,ImgHeadClick, headframe);

   if (tsShield.tabVisible) and (strContains('shield',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxShield, ImgShieldClick, shieldframe);

   if (tsHelmet.tabVisible) and (strContains('helmet',LowerCase(MyIniFile.ReadString('HEADER', 'ValidLayers','')))) then
      AddaTImage(sbxHelmet, ImghelmetClick, helmetframe);
except
      ShowMessage('Exception processing ' + FName + ' Layers');
      Result := false;
      exit;
end;
   MyIniFile.free;
   MyIniFile := nil;
   Result := True;

end;

procedure TfrmBuildLayer.imgarmsClick(Sender: TObject);
begin
  if Sender = Imgarms then
    (Sender as TBLImage).InUse := Not((Sender as TBLImage).InUse)
  else
     SelectImage((sender as TBLImage), ImgArms);
  UpdateImage(-1);
end;

procedure TfrmBuildLayer.LoadAFile(Filename: string);
begin
          
     try
        Inc(TagTrack);
        if Not(ProcessGif(TagTrack, FileName)) then
            dec(tagTrack);

        frmProcess.PBProcessing.Position := frmProcess.PBProcessing.Position +1;

     except
        showMessage('Exception loading image ' + fileName);
     end;
end;




procedure TfrmBuildLayer.FormShow(Sender: TObject);
var
Reg: TRegistry;
//tmpItemList: TStringList;
//tmpXrefList: TStringList;

//i, j: integer;
begin

  LoadIniFile;
  LoadSFX;
  if tsLegs1.TabVisible then
  pcLayerTabs.ActivePage := tsLegs1;
  OpenCharacterImage1Click(Sender);
//HKEY_CURRENT_USER\Software\DigitalTome\CharacterLAB\Settings

  Reg := TRegistry.Create;
  Reg.OpenKey('Software\DigitalTome\CharacterLAB\Settings', true);

  if Reg.ValueExists('Action') then
     if Reg.ReadBool('Action') then
        ChangeAction1Click(Sender);

  if Reg.ValueExists('BGColor') then
     BGColor := StringToColor(Reg.ReadString('BGColor'))
  else
     BGColor := clBlack;

  if Reg.ValueExists('Open1') then
     begin
          Open1.Caption := Reg.ReadString('Open1');
          open1.visible := true;
     end;

  if Reg.ValueExists('Open2') then
     begin
          Open2.Caption := Reg.ReadString('Open2');
          open2.visible := true;
     end;

  if Reg.ValueExists('Open3') then
     begin
          Open3.Caption := Reg.ReadString('Open3');
          open3.visible := true;
     end;


  if Reg.ValueExists('leg1frame') then
     Leg1frame := Reg.ReadInteger('leg1frame');
  if Reg.ValueExists('leg2frame') then
     Leg2frame := Reg.ReadInteger('leg2frame');
  if Reg.ValueExists('bootframe') then
     Bootframe := Reg.ReadInteger('bootframe');
  if Reg.ValueExists('ches1frame') then
     Chest1frame := Reg.ReadInteger('ches1frame');
  if Reg.ValueExists('chest2frame') then
     Chest2frame := Reg.ReadInteger('chest2frame');
  if Reg.ValueExists('armframe') then
     Armframe := Reg.ReadInteger('armframe');
  if Reg.ValueExists('beltframe') then
     Beltframe := Reg.ReadInteger('beltframe');
  if Reg.ValueExists('chest3frame') then
     Chest3frame := Reg.ReadInteger('chest3frame');
  if Reg.ValueExists('gauntletframe') then
     Gauntletframe := Reg.ReadInteger('gauntletframe');
  if Reg.ValueExists('outerframe') then
     Outerframe := Reg.ReadInteger('outerframe');
  if Reg.ValueExists('weaponframe') then
     Weaponframe := Reg.ReadInteger('weaponframe');
  if Reg.ValueExists('shieldframe') then
     Shieldframe := Reg.ReadInteger('shieldframe');
  if Reg.ValueExists('headframe') then
     Headframe := Reg.ReadInteger('headframe');
  if Reg.ValueExists('helmetframe') then
     Helmetframe := Reg.ReadInteger('helmetframe');


     Reg.Free;
{
     if fileExists(FrmSetting.edtItemDB.Text) then
      begin
           //here
           tmpItemList:= TStringList.Create;
           tmpItemList.LoadFromFile(FrmSetting.edtItemDB.Text);

           tmpXrefList:= TStringList.Create;
           tmpXrefList.LoadFromFile(FrmSetting.edtXRefDB.Text);

           XRefFieldCount := strTokenCount(tmpXrefList.Strings[0],'|');
           ItemDatabase := TStringList.Create;
           XRefDatabase:= TStringList.Create;
           for i := 0 to tmpItemList.Count - 1 do
           begin
                ItemDatabase.add(StrTokenAt(tmpItemList.Strings[i],'|', 0)+'='+ StrTokenAt(tmpItemList.Strings[i],'|', 70));
           end;

           for i := 1 to tmpXrefList.Count - 1 do
           begin
                for j := 1 to XRefFieldCount -1 do
                    XRefDatabase.add(StrTokenAt(tmpXrefList.Strings[i],'|', 0)+IntToStr(j)+'='+ StrTokenAt(StrTokenAt(tmpXrefList.Strings[i],'|', j), '\', 1));
           end;
           tmpItemList.free;
           tmpItemList := nil;
           tmpXrefList.free;
           tmpXrefList := nil;

      end;
 }


end;

procedure TfrmBuildLayer.EditValidLayer1Click(Sender: TObject);
begin

frmOptions.pcOptions.ActivePage := frmOptions.tsLayers;
frmOptions.show;

end;

procedure TfrmBuildLayer.OpenCharacterImage1Click(Sender: TObject);
var
 iLoop : integer;
 Reg: TRegistry;
 //tmpMemIni: TMeminiFile;
// tmpStrIni: TStringIniFile;
 S: string;
// aBitmap: TBitmap;
 tmpAction: string;
 begin

 Reg := TRegistry.Create;
 Reg.OpenKey('Software\DigitalTome\CharacterLAB\Settings', true);
  if Reg.ValueExists('BasePath') then
     begin
          OpenDialog.InitialDir := Reg.ReadString('BasePath');
     end;

if OpenDialog.execute then
begin
 try
   try
      MainIniFile := TMemIniFile.Create('');
      BaseIniFile := TMemIniFile.Create('');

      DFXInit(ExtractFilePath(ParamStr(0)));
      RLE:=nil;
      gBitPlane:=nil;
      S:=OpenDialog.FileName;
      LoadPOX(S,MainIniFile);
      BaseRLE := RLE;
      FrameWidth:=MainIniFile.ReadInteger('Header','ImageWidth',0);
      FrameHeight:=MainIniFile.ReadInteger('Header','ImageHeight',0);

      gBitPlane.free;
      gBitPlane:=TBitPlane.create(FrameWidth,FrameHeight);

      reg.WriteString('BasePath',ExtractFilePath(OpenDialog.fileName));
      MaxFrameCount := BaseRLE.Frames;
      TotalImages := 0;
      MainIniFile.WriteString('Layers', 'naked', MainIniFile.ReadString('Header', 'FileName',''));

      copyMemIniFile(MainIniFile,BaseIniFile);

      for iLoop := 0 to MaxFrameCount -1 do
      begin
          ListAllFrames := ListAllFrames + IntToStr(iLoop) + '|';
      end;
   finally
       strStripLast(ListAllFrames);
       reg.free;
       RLE := nil;
   end;
 except
  showMessage('Exception processing ' +OpenDialog.FileName);
 end;

   //Make sure walk is there... will adjust later to go with what ever action is there
   if strContains('Walk', MainIniFile.ReadString('HEADER', 'Actions', '')) then
   begin
        for iLoop := 0 to StrTokenCount(MainIniFile.Readstring('Action Walk', 'SWFrames', ''), ',') - 1 do
          if StrToIntDef(StrTokenAt(MainIniFile.Readstring('Action Walk', 'SWFrames', ''), ',', iLoop), -25) <> -25 then
             ListFrames := ListFrames + IntToStr(StrToInt(strTokenAt(MainIniFile.Readstring('Action Walk', 'SWFrames', ''), ',', iLoop)) -1) + '|';

        strStripLast(ListFrames);
        FirstFrame := StrToInt(StrTokenAt(ListFrames, '|', 0));
        LastFrame :=  StrToInt(StrTokenAt(ListFrames, '|', StrTokenCount(ListFrames, '|') -1));
        NextFrame := FirstFrame;
        FrameCounter:=-1;
   end
   else
   begin
        tmpAction := StrTokenAt(MainIniFile.ReadString('HEADER', 'Actions', ''), ',',0);
        for iLoop := 0 to StrTokenCount(MainIniFile.Readstring('Action '+tmpAction, 'SWFrames', ''), ',') - 1 do
          if StrToIntDef(StrTokenAt(MainIniFile.Readstring('Action '+tmpAction, 'SWFrames', ''), ',', iLoop), -25) <> -25 then
             ListFrames := ListFrames + IntToStr(StrToInt(strTokenAt(MainIniFile.Readstring('Action '+tmpAction, 'SWFrames', ''), ',', iLoop)) -1) + '|';

        strStripLast(ListFrames);
        FirstFrame := StrToInt(StrTokenAt(ListFrames, '|', 0));
        LastFrame :=  StrToInt(StrTokenAt(ListFrames, '|', StrTokenCount(ListFrames, '|') -1));
        NextFrame := FirstFrame;
        FrameCounter:=-1;

   end;

   try
      //build TabSheets
      frmAction.BuildActions(MainIniFile.ReadString('HEADER', 'Actions', ''));
   except
     Showmessage('Exception processing Action section in INI data');

   end;

   if Not((strTokenCount(MainInifile.ReadString('HEADER', 'ValidLayers',''), ',') = 1) and (strContains('naked',MainInifile.ReadString('HEADER', 'ValidLayers','')))) then
   begin
        //Setup Up Layers
        tsLegs1.TabVisible := strContains('leg1',MainInifile.ReadString('HEADER', 'ValidLayers',''));
        tsLegs2.TabVisible := strContains('leg2',MainInifile.ReadString('HEADER', 'ValidLayers',''));
        tsboots.TabVisible := strContains('boot',MainInifile.ReadString('HEADER', 'ValidLayers',''));
        tschest1.TabVisible := strContains('chest1',MainInifile.ReadString('HEADER', 'ValidLayers',''));
        tsChest2.TabVisible := strContains('chest2',MainInifile.ReadString('HEADER', 'ValidLayers',''));
        tsarms.TabVisible := strContains('arm',MainInifile.ReadString('HEADER', 'ValidLayers',''));
        tsbelt.TabVisible := strContains('belt',MainInifile.ReadString('HEADER', 'ValidLayers',''));
        tschest3.TabVisible := strContains('chest3',MainInifile.ReadString('HEADER', 'ValidLayers',''));
        tsgauntlets.TabVisible := strContains('gauntlet',MainInifile.ReadString('HEADER', 'ValidLayers',''));
        tsouter.TabVisible := strContains('outer',MainInifile.ReadString('HEADER', 'ValidLayers',''));
        tsweapon.TabVisible := strContains('weapon',MainInifile.ReadString('HEADER', 'ValidLayers',''));
        tshead.TabVisible := strContains('head',MainInifile.ReadString('HEADER', 'ValidLayers',''));
        tsshield.TabVisible := strContains('shield',MainInifile.ReadString('HEADER', 'ValidLayers',''));
        tshelmet.TabVisible := strContains('helmet',MainInifile.ReadString('HEADER', 'ValidLayers',''));
  end;

   //Everything is based on NakedMan
   FrameHeight := MainIniFile.Readinteger('Header', 'ImageHeight', 130);
   FrameWidth := MainIniFile.Readinteger('Header', 'ImageWidth', 148);

   //Create our buffer canvas
   //all drawing will be here then flipped to the main viewer
//   BmpBuffer := TBitmap.Create;
//   BmpBuffer.Height := FrameHeight;
//   BmpBuffer.Width := FrameWidth;

   MainIniFile.WriteString('Header', 'LayeredParts', 'No');// for later output
   pMainView.Height:=  FrameHeight +2;//size our main viewer
   pMainView.Width :=  FrameWidth +2 ; //size our main viewer
   height := PMainView.Top + PMainView.Height + 60;  //size our form for the viewer

   MainTimer.Enabled := true;//start the animation

end;
end;

procedure TfrmBuildLayer.OpenImagePath1Click(Sender: TObject);

begin
    MainTimer.Enabled := false;
    if PBFolderDialog1.Execute then
       OpenDirectory(PBFolderDialog1.folder);
end;

procedure TfrmBuildLayer.ColorAdjust1Click(Sender: TObject);
begin

(*
 This might be an interesting code challenge. I want the rest of this program
 completed and tested first, so the artists can start using it ASAP, before
 any work begins on even trying to implement this feature.

 Some of the source "wardrobe" images are designed with the intention that we
 can change their look simply by adjusting their color values (e.g. shirts and
 pants). The goal is to open some kind of color adjusting interface that allows
 us to tune the presentation, either via RGB or HSL adjustments, for the current
 item selected in the TTabSheet/TImage and displayed both in the TImage and
 the MainView. This color information would then need to go in the output
 INI and GIF files created by this utility.
*)

end;

procedure TfrmBuildLayer.ChangeAction1Click(Sender: TObject);
begin
 ChangeAction1.Checked := Not(ChangeAction1.Checked);

 if ChangeAction1.Checked then
    frmAction.show
 else
     frmAction.close;

end;



procedure TfrmBuildLayer.BackGroundColor1Click(Sender: TObject);
begin
if ColorDialog.Execute then
   BGColor := ColorDialog.Color;

end;

procedure TfrmBuildLayer.Exit1Click(Sender: TObject);
begin
 // application.terminate;
  Close;
end;

procedure TfrmBuildLayer.BLImgMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

begin
  if (Not(sender is TblImage)) and (button <> mbRight) then exit;
  SortFileName := (Sender as TBLImage).ImagePath;
  SortImage := (Sender as TBLImage);
  frmOptions.ImgPreview := (Sender as TBLImage);
  frmOptions.strfileName := (Sender as TBLImage).ImagePath;
  SortClick := (Sender as TBLImage).OnClick;
end;

procedure TfrmBuildLayer.CountFiles(Filename: string);
begin
     //Todo --- what a waste find a better way
     Inc(TotalFiles);
end;


procedure TfrmBuildLayer.LoadDefaultAction1Click(Sender: TObject);
var
iLoop: integer;
begin
   //Make sure walk is there... will adjust later to go with what ever action is there
   frmBuildLayer.ListFrames := '';
   if strContains('Walk', MainIniFile.ReadString('HEADER', 'Actions', '')) then
   begin
        for iLoop := 0 to StrTokenCount(MainIniFile.Readstring('Action Walk', 'SWFrames', ''), ',') - 1 do
          if StrToIntDef(StrTokenAt(MainIniFile.Readstring('Action Walk', 'SWFrames', ''), ',', iLoop), -25) <> -25 then
             ListFrames := ListFrames + IntToStr(StrToInt(strTokenAt(MainIniFile.Readstring('Action Walk', 'SWFrames', ''), ',', iLoop)) -1) + '|';
        strStripLast(ListFrames);
        FirstFrame := StrToInt(StrTokenAt(ListFrames, '|', 0));
        LastFrame :=  StrToInt(StrTokenAt(ListFrames, '|', StrTokenCount(ListFrames, '|') -1));
        NextFrame := FirstFrame;
        FrameCounter:=-1;
   end;

end;

Procedure TfrmBuildLayer.BuildIni(fName: String);
var
IniOutPut : TiniFile;
begin
     try
        //StrTokenAt(SaveDialog.FileName, '.',0)+ '.ini'
        //create the ini file on the disk
        IniOutPut:= TiniFile.Create(fName);


        //copy over current data and lets TINIFile edit it on the disk
        copyIniFile(MainIniFile,IniOutPut);

        //No Longer needed
        IniOutPut.DeleteKey('Header','ValidLayers');
        IniOutPut.DeleteKey('Header','LayeredParts');

        MainIniFile.DeleteKey('Header','ValidLayers');
        MainIniFile.DeleteKey('Header','LayeredParts');

        //Pad Inifile with empty values
        IniOutPut.WriteString('LAYERS', 'leg1', '');
        IniOutPut.WriteString('LAYERS', 'leg2', '');
        IniOutPut.WriteString('LAYERS', 'boot', '');
        IniOutPut.WriteString('LAYERS', 'chest1', '');
        IniOutPut.WriteString('LAYERS', 'chest2', '');
        IniOutPut.WriteString('LAYERS', 'arm', '');
        IniOutPut.WriteString('LAYERS', 'belt', '');
        IniOutPut.WriteString('LAYERS', 'chest3', '');
        IniOutPut.WriteString('LAYERS', 'gauntlet', '');
        IniOutPut.WriteString('LAYERS', 'outer', '');
        IniOutPut.WriteString('LAYERS', 'head', '');
        IniOutPut.WriteString('LAYERS', 'helmet', '');
        IniOutPut.WriteString('LAYERS', 'weapon', '');
        IniOutPut.WriteString('LAYERS', 'shield', '');

        MainIniFile.WriteString('LAYERS', 'leg1', '');
        MainIniFile.WriteString('LAYERS', 'leg2', '');
        MainIniFile.WriteString('LAYERS', 'boot', '');
        MainIniFile.WriteString('LAYERS', 'chest1', '');
        MainIniFile.WriteString('LAYERS', 'chest2', '');
        MainIniFile.WriteString('LAYERS', 'arm', '');
        MainIniFile.WriteString('LAYERS', 'belt', '');
        MainIniFile.WriteString('LAYERS', 'chest3', '');
        MainIniFile.WriteString('LAYERS', 'gauntlet', '');
        MainIniFile.WriteString('LAYERS', 'outer', '');
        MainIniFile.WriteString('LAYERS', 'head', '');
        MainIniFile.WriteString('LAYERS', 'helmet', '');
        MainIniFile.WriteString('LAYERS', 'weapon', '');
        MainIniFile.WriteString('LAYERS', 'shield', '');

        //Strings may contain a value even if not used so check        StrTokenAt(ItmName, '.',0)
        if imglegs1.InUse then IniOutPut.WriteString('LAYERS', 'leg1', StrTokenAt(imgLegs1.ItemName, '.',0));

        if imglegs2.InUse then IniOutPut.WriteString('LAYERS', 'leg2', StrTokenAt(imgLegs2.ItemName, '.',0));

        if imgHead.InUse then IniOutPut.WriteString('LAYERS', 'head', imgHead.ItemName);

        if imgBoots.InUse then IniOutPut.WriteString('LAYERS', 'boot', StrTokenAt(imgBoots.ItemName, '.',0));

        if imgChest1.InUse then IniOutPut.WriteString('LAYERS', 'chest1', StrTokenAt(imgChest1.ItemName, '.',0));

        if imgChest2.InUse then IniOutPut.WriteString('LAYERS', 'chest2', StrTokenAt(imgChest2.ItemName, '.',0));

        if imgArms.InUse then IniOutPut.WriteString('LAYERS', 'arm', StrTokenAt(imgArms.ItemName, '.',0));

        if imgbelt.InUse then IniOutPut.WriteString('LAYERS', 'belt', StrTokenAt(imgBelt.ItemName, '.',0));

        if imgChest3.InUse then IniOutPut.WriteString('LAYERS', 'chest3',StrTokenAt(imgChest3.ItemName, '.',0));

        if imgGauntlets.InUse then IniOutPut.WriteString('LAYERS', 'gauntlet', StrTokenAt(imgGauntlets.ItemName, '.',0));

        if imgOuter.InUse then IniOutPut.WriteString('LAYERS', 'outer', StrTokenAt(imgOuter.ItemName, '.',0));

        if imgWeapon.InUse then IniOutPut.WriteString('LAYERS', 'weapon', StrTokenAt(imgWeapon.ItemName, '.',0));

        if imgShield.InUse then IniOutPut.WriteString('LAYERS', 'shield', StrTokenAt(imgShield.ItemName, '.',0));

        if imghelmet.InUse then IniOutPut.WriteString('LAYERS', 'helmet', StrTokenAt(imghelmet.ItemName, '.',0));


        if imglegs1.InUse then MainIniFile.WriteString('LAYERS', 'leg1', StrTokenAt(imgLegs1.ItemName, '.',0));

        if imglegs2.InUse then MainIniFile.WriteString('LAYERS', 'leg2', StrTokenAt(imgLegs2.ItemName, '.',0));

        if imgHead.InUse then MainIniFile.WriteString('LAYERS', 'head', imgHead.ItemName);

        if imgBoots.InUse then MainIniFile.WriteString('LAYERS', 'boot', StrTokenAt(imgBoots.ItemName, '.',0));

        if imgChest1.InUse then MainIniFile.WriteString('LAYERS', 'chest1', StrTokenAt(imgChest1.ItemName, '.',0));

        if imgChest2.InUse then MainIniFile.WriteString('LAYERS', 'chest2', StrTokenAt(imgChest2.ItemName, '.',0));

        if imgArms.InUse then MainIniFile.WriteString('LAYERS', 'arm', StrTokenAt(imgArms.ItemName, '.',0));

        if imgbelt.InUse then MainIniFile.WriteString('LAYERS', 'belt', StrTokenAt(imgBelt.ItemName, '.',0));

        if imgChest3.InUse then MainIniFile.WriteString('LAYERS', 'chest3', StrTokenAt(imgChest3.ItemName, '.',0));

        if imgGauntlets.InUse then MainIniFile.WriteString('LAYERS', 'gauntlet', StrTokenAt(imgGauntlets.ItemName, '.',0));

        if imgOuter.InUse then MainIniFile.WriteString('LAYERS', 'outer', StrTokenAt(imgOuter.ItemName, '.',0));

        if imgWeapon.InUse then MainIniFile.WriteString('LAYERS', 'weapon', StrTokenAt(imgWeapon.ItemName, '.',0));

        if imgShield.InUse then MainIniFile.WriteString('LAYERS', 'shield', StrTokenAt(imgShield.ItemName, '.',0));

        if imghelmet.InUse then MainIniFile.WriteString('LAYERS', 'helmet', StrTokenAt(imghelmet.ItemName, '.',0));


        if Pos('BaseHumanFemale.gif',MainInifile.ReadString('Layers', 'naked', ''))<>0 then
        begin
             if StrTokenAt(MainInifile.ReadString('Layers', 'naked', ''), '\',0) <> 'HumanFemaleLayers' then
             MainInifile.WriteString('Layers','naked', 'HumanFemaleLayers\' + MainInifile.ReadString('Layers', 'naked', ''));

             if MainInifile.ReadString('Layers', 'head', '') <> '' then
             if StrTokenAt(MainInifile.ReadString('Layers', 'head', ''), '\',0) <> 'HumanFemaleLayers' then
             MainInifile.WriteString('Layers','head', 'HumanFemaleLayers\' + MainInifile.ReadString('Layers', 'head', ''));
        end;

        if Pos('BaseElf.gif',MainInifile.ReadString('Layers', 'naked', '')) <> 0 then
        begin
             if StrTokenAt(MainInifile.ReadString('Layers', 'naked', ''), '\',0) <> 'ElfmaleLayers' then
             MainInifile.WriteString('Layers','naked', 'ElfmaleLayers\' + MainInifile.ReadString('Layers', 'naked', ''));

             if MainInifile.ReadString('Layers', 'head', '') <> '' then
             if StrTokenAt(MainInifile.ReadString('Layers', 'head', ''), '\',0) <> 'ElfmaleLayers' then
             MainInifile.WriteString('Layers','head', 'ElfmaleLayers\' + MainInifile.ReadString('Layers', 'head', ''));
        end;

        if (Pos('BaseHumanMale.gif',MainInifile.ReadString('Layers', 'naked', '')) <> 0) or (Pos('BaseShaman.gif',MainInifile.ReadString('Layers', 'naked', '')) <> 0) or (Pos('BaseAhoul.gif',MainInifile.ReadString('Layers', 'naked', '')) <>0) then
        begin
             if StrTokenAt(MainInifile.ReadString('Layers', 'naked', ''), '\',0) <> 'HumanMaleLayers' then
             MainInifile.WriteString('Layers','naked', 'HumanMaleLayers\' + MainInifile.ReadString('Layers', 'naked', ''));
             if MainInifile.ReadString('Layers', 'head', '') <> '' then
             if StrTokenAt(MainInifile.ReadString('Layers', 'head', ''), '\',0) <> 'HumanMaleLayers' then
             MainInifile.WriteString('Layers','head', 'HumanMaleLayers\' + MainInifile.ReadString('Layers', 'head', ''));
        end;

        //move the old name to the naked layer
//        IniOutPut.WriteString('LAYERS', 'naked', MainIniFile.ReadString('Header', 'FileName',''));
        //give it a new name
//        IniOutPut.WriteString('Header','FileName',ExtractFileName(SaveDialog.FileName));

     finally
        IniOutPut.free;
     end;
end;


procedure TfrmBuildLayer.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var
  Reg : TRegistry;

begin
//HKEY_CURRENT_USER\Software\DigitalTome\CharacterLAB\Settings

  Reg := TRegistry.Create;
  Reg.OpenKey('Software\DigitalTome\CharacterLAB\Settings', true);

  Reg.WriteBool('Action',ChangeAction1.checked);

  Reg.WriteString('BGColor', ColorToString(BGColor));

  if StrDBFile <> '' then
  Reg.WriteString('DBFile', strDBFile);

  Reg.free;
  sfxLookup.free;
end;

function TfrmBuildLayer.BackFrameTest(ImgBackFrames: string;TstFrame: integer): Boolean;
var
iLoop: integer;
begin
Result:= False;
    if ImgBackFrames = '' then exit;
    for iLoop := 0 to StrTokenCount(ImgBackFrames, ',')-1  do
    begin
         if StrTokenAt(ImgBackFrames, ',', iLoop) = IntToStr(TstFrame) then
         begin
            Result := true;
            exit;
         end;
    end;
end;

procedure TfrmBuildLayer.SelectImage(sltImage: TBLImage; var PvImage: TBLImage);
var
R,G,B: integer;
begin
     try
        R := PvImage.Red;
        G := PvImage.Green;
        B := PvImage.Blue;
        PvImage.ItemName := sltImage.ItemName;
        PvImage.ManagerIndex := sltImage.ManagerIndex;
        PvImage.LinkedLayerFile := sltImage.LinkedLayerFile;
        PvImage.LayeredFramesToBack := sltImage.LayeredFramesToBack;
        PvImage.RLE := sltImage.RLE;
        PvImage.BackRLE := sltImage.BackRLE;
        PvImage.LinkedLayerFirstFrame := sltImage.LinkedLayerFirstFrame;
        PvImage.LinkedLayerLastFrame  := sltImage.LinkedLayerLastFrame;
        PvImage.LinkedLayerMaxFrameCount  :=  sltImage.LinkedLayerMaxFrameCount;
        PvImage.Red := R;
        PvImage.Green := G;
        PvImage.Blue := B;

     except
           ShowMessage('Invalid image data');//Debug messages
     end;
end;

procedure TfrmBuildLayer.SortOrder1Click(Sender: TObject);
var
   ImgIniFile: TMemIniFile;
   ImgBackFrames: string;
   iLoop: integer;
   TmpStr: string;
   bFound: Boolean;


begin
     if Sender = FlipFrameDrawOrder1 then
     begin
        bFound:= false;
        if SortFileName = '' then exit;

        ImgIniFile := TMemIniFile.Create('');

        LoadPox(SortFileName, ImgIniFile);

        ImgBackFrames := ImgIniFile.Readstring('Header', 'LayeredFramesToBack','');
        if (Pos('N', ImgBackFrames) <> 0) or (Pos('E', ImgBackFrames) <> 0) or (Pos('S', ImgBackFrames) <> 0) or (Pos('W', ImgBackFrames) <> 0) then
           ImgBackFrames := '';
        if ImgBackFrames <> '' then
        begin
              for iLoop := 0 to StrTokenCount(ImgBackFrames, ',')-1  do
                begin

                     if StrTokenAt(ImgBackFrames, ',', iLoop) <> lblFrameCount.Caption then
                       tmpStr := tmpStr + StrTokenAt(ImgBackFrames, ',', iLoop) + ','
                     else
                         bFound := True;
                end;
        end;

        if Not(bFound) then
        begin
              if ImgBackFrames <> '' then
                 ImgBackFrames := ImgBackFrames + ',' + lblFrameCount.Caption
              else
                 ImgBackFrames := lblFrameCount.Caption;
        end
        else
        begin
             strStripLast(tmpStr);
             ImgBackFrames := tmpStr;
        end;

        ImgIniFile.WriteString('Header','LayeredFramesToBack', ImgBackFrames);

        SortImage.LayeredFramesToBack := ImgBackFrames;

        SavePox(SortFileName,ImgIniFile);

        ImgIniFile.free;
        imgIniFile := nil;


        if Assigned(SortClick) then
           SortClick(SortImage);

        NextFrame := Nextframe - 1;
        FrameCounter := FrameCounter - 1;
        if framecounter < 0 then frameCounter := -1  ;
        AnimationControl;
     end
     else
     begin
        if SortFileName = '' then exit;

        ImgIniFile := TMemIniFile.Create('');

        LoadPox(SortFileName, ImgIniFile);


        ImgIniFile.WriteString('Header', 'GameImageFrame', lblFrameCount.Caption);
        SavePox(SortFileName,ImgIniFile);

        ImgIniFile.free;
        imgIniFile := nil;

     end;

   {  try
        frmOptions.tsLayers.TabVisible := false;
        frmOptions.tsSorting.TabVisible := false;
        frmOptions.tsOrder.TabVisible := true;
        frmOptions.EditSortOrder;
     except
       //silent
     end;}
end;

procedure TfrmBuildLayer.Open1Click(Sender: TObject);
begin
    OpenDirectory((Sender as TMenuItem).caption);
end;

procedure TfrmBuildLayer.OpenDirectory(strDirectory: string);
var
 oDirScan: TDirectoryScanner;
 Reg : TRegistry;

begin

  try
    Application.processmessages;//damn Ole crap... give the system a break to catch up

    if strDirectory = '' then exit; //now what?

    MainTimer.Enabled := false;

    Reg := TRegistry.Create;
    Reg.OpenKey('Software\DigitalTome\CharacterLAB\Settings', true);

    if (Open2.Caption <> '') and (Open3.Caption <> strDirectory) and (Open2.Caption <> strDirectory) and (Open1.Caption <> strDirectory) then
       begin
            Open3.Caption := Open2.Caption;
            open3.Visible := true;
            Reg.WriteString('Open3', Open2.Caption);

       end;

    if (Open1.Caption <> '') and (Open3.Caption <> strDirectory) and (Open2.Caption <> strDirectory) and (Open1.Caption <> strDirectory) then
       begin
            Open2.Caption := Open1.Caption;
            open2.Visible := true;
            Reg.WriteString('Open2', Open1.Caption);
       end;

    if  (Open3.Caption <> strDirectory) and (Open2.Caption <> strDirectory) and (Open1.Caption <> strDirectory) then
    begin
         Open1.Caption := strDirectory;
         open1.Visible := true;
         Reg.WriteString('Open1', strDirectory);
    end;
    reg.free;

    OpenImagePath1.Enabled := false;
    ReOp1.enabled := false;
    screen.cursor := crHourglass;

    TotalFiles := 0;
    //Hate to do this twice but it seems to be the
    //fastes way to count the files
    oDirScan := TDirectoryScanner.Create;
    oDirScan.Extension := 'pox';
    oDirScan.OnFoundFile := CountFiles; //basically Inc(TotalFiles);
    oDirScan.ProcessDirectory(strDirectory);
    oDirScan.Free;

    //Setup Progress Bar
    frmProcess.PBProcessing.Max := TotalFiles;
    frmProcess.Show;

    //process Images
    oDirScan := TDirectoryScanner.Create;
    oDirScan.Extension := 'pox';              //scan for all files w/ this extension
    oDirScan.OnFoundFile := LoadAFile;        //call this proc for each file found
    oDirScan.ProcessDirectory(strDirectory);  //go!
    oDirScan.Free;

 finally
    screen.cursor := crDefault;
    MainTimer.Enabled := true;
    if tsLegs1.TabVisible then
    pcLayerTabs.ActivePage := tsLegs1;
    frmProcess.close;

 end;
end;

procedure TfrmBuildLayer.btnPauseClick(Sender: TObject);
begin
if bPause then exit;
FlipFrameDrawOrder1.Enabled := true;
GameImage1.Enabled := true;
MainTimer.Enabled := false;
bPause := true;
end;

procedure TfrmBuildLayer.btnPlayClick(Sender: TObject);
begin
if Not(bPause) then exit;
FlipFrameDrawOrder1.Enabled := False;
GameImage1.Enabled := false;
MainTimer.Enabled := true;
bPause := false;
end;

procedure TfrmBuildLayer.btnbackClick(Sender: TObject);
begin
if Not(bPause) then exit;
NextFrame := Nextframe - 2;
FrameCounter := FrameCounter - 2;
if framecounter < 0 then frameCounter := -1  ;
AnimationControl;
end;

procedure TfrmBuildLayer.btnForwardClick(Sender: TObject);
begin
if Not(bPause) then exit;
AnimationControl;
end;

procedure TfrmBuildLayer.EditanImage1Click(Sender: TObject);

begin
  if EditDialoge.Execute then
     EditIniData(EditDialoge.FileName);
     SaveDialog.FileName := strTokenAt(EditDialoge.FileName, '.',0);
end;

procedure TfrmBuildLayer.UpdateImage(newFrame: Integer);
begin
  if bPause then
  begin
    NextFrame := Nextframe + newFrame;
    FrameCounter := FrameCounter + newFrame;
    if framecounter < 0 then frameCounter := -1  ;
    AnimationControl;
  end;

end;

procedure TfrmBuildLayer.SaveiniData1Click(Sender: TObject);
var
 strCharData: string;
begin
    try
       bPause := false;
       FlipFrameDrawOrder1.Enabled := False;
       MainTimer.enabled := false;
       Application.Processmessages; //Finish any animation drawing inprogress
{
             if (SaveDialog.Execute) then
             begin
               //IniData  after we have the file name
               MainIniFile.WriteString('Header','FileName',StrTokenAt(ExtractFileName(SaveDialog.FileName),'.',0)+'.pox');

               BuildIni(StrTokenAt(SaveDialog.FileName, '.',0)+ '.ini');
               WriteLayeredPoxToDisk(StrTokenAt(SaveDialog.FileName, '.',0)+ '.pox');
//               SaveCharacterPOX(StrTokenAt(SaveDialog.FileName, '.',0)+ '.pox',MainIniFile);
//               CreateDir(ExtractFilePath(savedialog.fileName) +'editor');
//               SaveCharacterPOXImage(ExtractFilePath(savedialog.fileName) +'editor\'+ StrTokenAt(ExtractFileName(SaveDialog.FileName), '.',0)+ '.pox',MainIniFile,NewBitmap);
             end;
}
       SaveDialog1.InitialDir :=  strCharPath;

       if (SaveDialog1.Execute) then
       begin


            strNameBase := ExtractFileName(SaveDialog1.fileName);

            SaveNewCharDBData(strNameBase,4);

            //Stand
            WriteCharStand(ExtractFilePath(SaveDialog1.fileName));
            //Walk
            WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'NEFrames', 'Walk','NE');
            WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'NWFrames', 'Walk','NW');
            WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'SEFrames', 'Walk','SE');
            WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'SWFrames', 'Walk','SW');
            //Cast
            if rgCombatType.ItemIndex = 1 then
            begin
                WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'NEFrames', 'Cast','NE');
                WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'NWFrames', 'Cast','NW');
                WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'SEFrames', 'Cast','SE');
                WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'SWFrames', 'Cast','SW');
            end;
            //Attack1
            if rgCombatType.ItemIndex = 0 then
            begin
                WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'NEFrames', 'Attack1','NE');
                WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'NWFrames', 'Attack1','NW');
                WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'SEFrames', 'Attack1','SE');
                WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'SWFrames', 'Attack1','SW');
            end;
            //Death
            WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'NEFrames', 'Death','NE');
            WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'NWFrames', 'Death','NW');
            WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'SEFrames', 'Death','SE');
            WriteTextureAction(ExtractFilePath(SaveDialog1.fileName), 'SWFrames', 'Death','SW');
            //strCharData :=  edtPainSound.text + ' ' + edtDeathSound.text;
            AppendTextToFile(SaveDialog1.fileName+'.chr',strCharData);
            BuildIni(SaveDialog1.fileName+ '.ini');
            //TODO save soundFX
            SaveSFX(IntToStr(iCharacterID));

       end;
    finally
      if btnPlay.Down then
      MainTimer.enabled := true;
    end;
end;

procedure TfrmBuildLayer.SaveNewCharDBData(strFileName: string; iFrame: integer);
var
objDB: TSQLiteDatabase;
strSQL: String;

begin
    objDB := TSQLiteDatabase.Create(strDatabase);

    strSQL := 'INSERT INTO tblISO_Character([Description],[PortraitFrame],[Active]) VALUES("'+strFileName + '",'+ IntToStr(iFrame)+',"true")';
    objDB.ExecSQL(strSQL);
    //TODO
    iCharacterID :=  objDB.GetLastInsertRowID;
    objDB.free;
end;

procedure TfrmBuildLayer.SaveNewCharActionFileData(strFileName: string; strDir: string; strAction: string);
var
objDB: TSQLiteDatabase;
strSQL: String;
tmpDir: String;
tmpAction: String;
begin
    if iCharacterID > -1 then
    begin
        objDB := TSQLiteDatabase.Create(strDatabase);

       if strDir = 'NE' then
          tmpDir := '1'
       else
           if strDir = 'NW' then
              tmpDir := '2'
       else
           if strDir = 'SE' then
              tmpDir := '3'
       else
           if strDir = 'SW' then
              tmpDir := '4';

       if strAction = 'Walk' then
          tmpAction := '1'
       else
           if strAction = 'Cast' then
              tmpAction := '2'
       else
           if strAction = 'Attack1' then
              tmpAction := '2'
       else
           if strAction = 'Death' then
              tmpAction := '3';


        strSQL := 'INSERT INTO tblISO_CharacterFiles([CharacterID],[FileName],[FrameCount],[FPS],[Width],[Height],[ActionType],[Direction],[Active]) '+
                  'VALUES('+IntToStr(iCharacterID)+',"Characters\\'+strFileName+'",8, 10, 128, 128,'+tmpAction+','+tmpDir+', "true")';
        objDB.ExecSQL(strSQL);
        objDB.free;
    end;
end;


procedure TfrmBuildLayer.SaveNewCharStandFileData(strFileName: string);
var
objDB: TSQLiteDatabase;
strSQL: String;
begin
    if iCharacterID > -1 then
    begin
        objDB := TSQLiteDatabase.Create(strDatabase);

        strSQL := 'INSERT INTO tblISO_CharacterFiles([CharacterID],[FileName],[FrameCount],[FPS],[Width],[Height],[ActionType],[Direction],[Active]) '+
                  'VALUES('+IntToStr(iCharacterID)+',"Characters\\'+strFileName+'",4, 1, 128, 128,0,0,"true")';
        objDB.ExecSQL(strSQL);
        objDB.free;
    end;
end;

procedure TfrmBuildLayer.LoadIniFile;
var
  MyIniFile: TIniFile;
begin

  MyIniFile := TIniFile.create(ChangeFileExt(Application.exename, '.ini'));

  strDatabase := MyIniFile.ReadString('Path', 'Database', 'c:\temp\database.db3');
  strCharPath := MyIniFile.ReadString('Path', 'Chars', 'C:\Programming\Current Project\RF2dEngine\TestDirectory\resources\Data\characters\');
  strTexPath :=  MyIniFile.ReadString('Path', 'Textures', 'C:\Programming\Current Project\RF2dEngine\TestDirectory\resources\textures\');
  MyIniFile.free;
end;


procedure TfrmBuildLayer.ResetForNewCharacter1Click(Sender: TObject);
begin
     ResetAll;
end;

procedure TfrmBuildLayer.ResetAll;
begin
  iCharacterID := -1;
  MainIniFile.EraseSection('Layers');
  MainIniFile.EraseSection('Properties');
  copyMemIniFile(BaseIniFile,MainIniFile);
  imglegs1.InUse := false;
  imglegs2.InUse:= false;
  imgHead.InUse := false;
  imgBoots.InUse := false;
  imgChest1.InUse:= false;
  imgChest2.InUse:= false;
  imgArms.InUse := false;
  imgbelt.InUse := false;
  imgChest3.InUse := false;
  imgGauntlets.InUse := false;
  imgOuter.InUse := false;
  imgWeapon.InUse := false;
  imgShield.InUse := false;
  imghelmet.InUse := false;
  //TODO  Reset Properties!!!!
end;

procedure TfrmBuildLayer.EditIniData(FileName: string);
var
   EditIniFile: TIniFile;
   list: TStringList;
   i: integer;

   procedure EditLayer(Sllbx: TScrollBox; BLImg: TBLImage; ImgName: String);
   var
     iLoop : integer;
//     jLoop: integer;
     idIndex: integer;
     itemName: string;
//     PartName: string;
   begin
        idIndex := -1;
        if ImgName <> '' then
        begin
              ItemName := imgName;
{              if Assigned(ItemDatabase) then
              idIndex :=  ItemDataBase.IndexOfName(ImgName);

              if idIndex > -1 then
              begin
                    PartName := ItemDataBase.values[ImgName];
                    for iLoop := 0 to Sllbx.ControlCount -1 do
                    begin
                        for jLoop := 1 to XRefFieldCount -1 do
                           if (Sllbx.Controls[iLoop] as TBLImage).fileName = XRefDataBase.values[PartName + intToStr(jLoop)] then
                           begin
                                SelectImage(ItemName, (Sllbx.Controls[iLoop] as TBLImage), BLImg);
                                BLImg.InUse := true;
                                break;
                           end;
                    end;
              end
              else
              begin}
                    for iLoop := 0 to Sllbx.ControlCount -1 do
                    begin
                           if LowerCase(StrTokenAt(ImgName, '.', 1)) = 'gif' then
                           begin
                                if LowerCase((Sllbx.Controls[iLoop] as TBLImage).fileName) = LowerCase(ImgName) then
                                begin
                                     SelectImage((Sllbx.Controls[iLoop] as TBLImage), BLImg);
                                     BLImg.InUse := true;
                                     break;
                                end;
                           end
                           else
                           begin
                                if LowerCase((Sllbx.Controls[iLoop] as TBLImage).fileName) = LowerCase(ImgName + '.gif') then
                                begin
                                     SelectImage((Sllbx.Controls[iLoop] as TBLImage), BLImg);
                                     BLImg.InUse := true;
                                     break;
                                end;
                           end;
                    end;

            //  end;
        end;
   end;

begin

  EditIniFile := TIniFile.Create(fileName);

  ImgLegs1.InUse := false;
  ImgLegs2.InUse := false;
  ImgBoots.InUse := false;
  ImgChest1.InUse := false;
  ImgChest2.InUse := false;
  ImgArms.InUse := false;
  ImgBelt.InUse := false;
  ImgChest3.InUse := false;
  ImgGauntlets.InUse := false;
  ImgOuter.InUse := false;
  ImgWeapon.InUse := false;
  ImgShield.InUse := false;
  ImgHead.InUse := false;
  ImgHelmet.InUse := false;

  EditLayer( sbxLegs1, ImgLegs1, EditIniFile.ReadString('Layers', 'leg1', ''));
  EditLayer( sbxLegs2, ImgLegs2, EditIniFile.ReadString('Layers', 'leg2', ''));
  EditLayer( sbxBoots, Imgboots, EditIniFile.ReadString('Layers', 'boot', ''));
  EditLayer( sbxChest1, ImgChest1, EditIniFile.ReadString('Layers', 'chest1', ''));
  EditLayer( sbxChest2, ImgChest2, EditIniFile.ReadString('Layers', 'chest2', ''));
  EditLayer( sbxArms, Imgarms, EditIniFile.ReadString('Layers', 'arm', ''));
  EditLayer( sbxBelt, ImgBelt, EditIniFile.ReadString('Layers', 'belt', ''));
  EditLayer( sbxChest3, ImgChest3, EditIniFile.ReadString('Layers', 'chest3', ''));
  EditLayer( sbxOuter, ImgOuter, EditIniFile.ReadString('Layers', 'outer', ''));
  EditLayer( sbxGauntlets, ImgGauntlets, EditIniFile.ReadString('Layers', 'gauntlet', ''));
  if Pos('\',EditIniFile.ReadString('Layers', 'head', '')) <> 0 then
     EditLayer( sbxHead, ImgHead, StrTokenAt(EditIniFile.ReadString('Layers', 'head', ''),'\',1))
  else
      EditLayer( sbxHead, ImgHead, EditIniFile.ReadString('Layers', 'head', ''));
  EditLayer( sbxHelmet, ImgHelmet, EditIniFile.ReadString('Layers', 'helmet', ''));
  EditLayer( sbxWeapon, ImgWeapon, EditIniFile.ReadString('Layers', 'weapon', ''));
  EditLayer( sbxShield, ImgShield, EditIniFile.ReadString('Layers', 'shield', ''));

  list := TStringList.Create;
  EditIniFile.ReadSection('Properties', List);
  for i := 0 to list.Count -1 do
  begin
        MainIniFile.writeString('Properties',list.Strings[i],EditIniFile.ReadString('Properties',list.Strings[i],''));
  end;
  list.Free;

  EditIniFile.free;

end;


procedure TfrmBuildLayer.ViewFullAnimation1Click(Sender: TObject);
begin
     ListFrames := ListAllFrames;
     LastFrame := MaxFrameCount;
     FirstFrame := 0;
     NextFrame := FirstFrame;
     FrameCounter:=-1;

end;

procedure TfrmBuildLayer.Imglegs1Paint(Sender: TObject);
var
iLoop: integer;
begin
     if Sender is TScrollBox then
     begin
         for iLoop := 0 to (Sender as TScrollBox).ComponentCount -1 do
         begin
              if (TBLImage((Sender as TScrollBox).Components[iLoop]).ManagerIndex <> -1) then
              begin
                  ((Sender as TScrollBox).Components[iLoop] as TBLImage).Canvas.Brush.Color := clblack;
                  ((Sender as TScrollBox).Components[iLoop] as TBLImage).Canvas.FillRect(Rect(0,0,134,150));
                  Draw(TBLImage((Sender as TScrollBox).Components[iLoop]).DisplayFrame,TBLImage((Sender as TScrollBox).Components[iLoop]), ((Sender as TScrollBox).Components[iLoop] as TBLImage).Canvas);
                  ((Sender as TScrollBox).Components[iLoop]  as TBLImage).Canvas.Font.Color := clRed;
                  ((Sender as TScrollBox).Components[iLoop]  as TBLImage).Canvas.TextOut(10,120, ((Sender as TScrollBox).Components[iLoop]  as TBLImage).hint);
              end;
         end;
     end
     else
     if Sender is TBLImage then
     begin
          if (TBLImage(Sender).ManagerIndex <> -1) then
          begin
            (Sender as TBLImage).Canvas.Brush.Color := clBlack;
            (Sender as TBLImage).Canvas.FillRect(Rect(0,0,134,150));
             Draw((Sender as TBLImage).DisplayFrame, (Sender as TBLImage), (Sender as TBLImage).Canvas);
            (Sender as TBLImage).Canvas.Font.Color := clRed;
            (Sender as TBLImage).Canvas.TextOut(10,120, (Sender as TBLImage).hint);
          end;
     end;

end;

procedure TfrmBuildLayer.imgChest3Paint(Sender: TObject);
begin
     if assigned((Sender as TBLImage).RLE) then
     begin
     (Sender as TBLImage).Canvas.Brush.Color := clBlack;
     (Sender as TBLImage).Canvas.FillRect(Rect(0,0,134,150));
     Draw((Sender as TBLImage).DisplayFrame,(Sender as TBLImage), (Sender as TBLImage).Canvas);
     end;
end;


procedure TfrmBuildLayer.LoadPOX(POXFile: string; tmpMemInifile: TMemIniFile);
var
  Stream: TFileStream;
  L: longint;
  M: array [1..2] of Char;
  EOB,BB: word;
  TextOnly: boolean;
  tmpList : TStrings;
begin
  RLE.free;
  RLE:=nil;
  EOB:=$4242;
  try
    Stream:=TFileStream.create(POXFile,fmOpenRead or fmShareCompat);
    try
      TextOnly:=false;
      Stream.Read(L,sizeof(L));
      if (L<>$41584F50) then exit;
      Stream.Read(M,sizeof(M));
      Stream.Read(BB,sizeof(BB)); //CRLF
      if (M=#67#67) then begin //CC
        Stream.Read(L,sizeof(L));
      end
      else if (M=#76#67) then begin //LC
        L:=Stream.Size-Stream.Position;
        TextOnly:=true;
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
      tmpList := TStringlist.create;
      tmpList.setText(PChar(Comments));
      tmpMemInifile.SetStrings(tmpList);
      tmpList.free;
      if TextOnly then begin
        RLE:=nil;
      end
      else begin
        Stream.Read(BB,sizeof(BB));
        if BB=EOB then begin
          RLE:=TRLESprite.create;
          RLE.LoadFromStream(Stream);
        end
        else begin
          exit;
        end;
      end;
    finally

      Stream.free;
    end;
  except
  end;
end;

procedure TfrmBuildLayer.LoadPOX2(var Image: TBLImage; POXFile: string; var tmpMemInifile: TMemIniFile);
var
  Stream: TFileStream;
  L: longint;
  M: array [1..2] of Char;
  EOB,BB: word;
  TextOnly: boolean;
  tmpList : TStrings;
begin
//  RLE.free;
//  RLE:=nil;
  EOB:=$4242;
  try
    Stream:=TFileStream.create(POXFile,fmOpenRead or fmShareCompat);
    try
      TextOnly:=false;
      Stream.Read(L,sizeof(L));
      if (L<>$41584F50) then exit;
      Stream.Read(M,sizeof(M));
      Stream.Read(BB,sizeof(BB)); //CRLF
      if (M=#67#67) then begin //CC
        Stream.Read(L,sizeof(L));
      end
      else if (M=#76#67) then begin //LC
        L:=Stream.Size-Stream.Position;
        TextOnly:=true;
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
      tmpList := TStringlist.create;
      tmpList.setText(PChar(Comments));
      tmpMemInifile.SetStrings(tmpList);
      tmpList.free;
      if TextOnly then
      begin
           Image.RLE:=nil;
      end
      else
      begin
           Stream.Read(BB,sizeof(BB));
           if (BB=EOB) and Assigned(Image) then
           begin
                Image.RLE:=TRLESprite.create;
                Image.RLE.LoadFromStream(Stream);
           end
           else
               exit;
      end;

    finally

      Stream.free;
    end;
  except
  end;
end;


procedure TfrmBuildLayer.SavePOX(POXFile: string; tmpIniFile: TMemIniFile);
var
  Stream: TFileStream;
  S: string;
  L: longword;
  EOB: word;
  tmpList : TStringlist;


begin
        EOB:=$4242;
        Stream:=TFileStream.create(POXFile,fmCreate or fmShareExclusive);
        try
          Stream.write(#80#79#88#65,4); //POX vA - Proprietary Object eXtension
          S:=lowercase(trim(tmpIniFile.ReadString('Header','GameClass','')));
          if (S='character') or (S='charactersprite') then
          begin
            S:=lowercase(trim(tmpIniFile.ReadString('Header','LayeredParts','')));
            if (S='yes') or (S='base') then
               Stream.write(#76#76,2); //fmt LL

            Stream.write(#13#10,2);

            tmpList := TStringlist.create;
            tmpIniFile.GetStrings(TmpList);
            s:= tmpList.text;
            tmpList.free;
            L:=Length(S);

            Stream.write(L,sizeof(L));
            Stream.write(S[1],L);
            Stream.write(EOB,sizeof(EOB));
//            C:=StrToInt(lowercase(trim(tmpIniFile.ReadString('Header','TransparentColor','16776960'))));
           // result.RLE:=TRLESprite.create;
           // result.RLE.LoadFromBitmap(BM,result.FrameWidth,result.FrameHeight,C);
            //result.RLE.SaveToStream(Stream);
            RLE.SaveToStream(Stream);
            Stream.write(EOB,sizeof(EOB));
          end;
        finally
          Stream.free;
//        BM.free;
      end;
end;



procedure TfrmBuildLayer.Draw(indx: integer; Image: TBLImage; MyCanvas: TCanvas);
begin
  if assigned(Image) and (Image.ManagerIndex <> -1) then
  begin
    gBitPlane.Clear;
    gBitPlane.KeyColor := BGColor;
    Image.RLE.DrawColorize(indx,0,0,gBitPlane.Bits,Image.Red,Image.Green,Image.Blue,100,0);
    gBitPlane.DrawToDC(MyCanvas.handle,0,0);
  end;

end;


procedure TfrmBuildLayer.tbLegs1BlueChange(Sender: TObject);
begin
        if (pcLayerTabs.ActivePage = tsShield) then
        begin
             imgShield.Blue := TTrackBar(Sender).Position;
             lblshieldblue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsWeapon) then
        begin
             imgWeapon.Blue := TTrackBar(Sender).Position;
             lblweaponblue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsHelmet) then
        begin
             imgHelmet.Blue := TTrackBar(Sender).Position;
             lblhelmblue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsHead) then
        begin
             imgHead.Blue := TTrackBar(Sender).Position;
             lblheadblue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsOuter) then
        begin
             imgOuter.Blue := TTrackBar(Sender).Position;
             lblouterblue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsGauntlets) then
        begin
             imgGauntlets.Blue := TTrackBar(Sender).Position;
             lblhandsblue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsChest3) then
        begin
             imgChest3.Blue := TTrackBar(Sender).Position;
             lblchest3blue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsBelt) then
        begin
             imgBelt.Blue := TTrackBar(Sender).Position;
             lblbeltblue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsArms) then
        begin
             imgArms.Blue := TTrackBar(Sender).Position;
             lblarmsblue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsChest2)  then
        begin
             imgChest2.Blue := TTrackBar(Sender).Position;
             lblchest2blue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsChest1)  then
        begin
             imgchest1.Blue := TTrackBar(Sender).Position;
             lblchest1blue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsBoots) then
        begin
             imgboots.Blue := TTrackBar(Sender).Position;
             lblbootsblue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tslegs2) then
        begin
             imgLegs2.Blue := TTrackBar(Sender).Position;
             lbllegs2blue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tslegs1) then
        begin
             imgLegs1.Blue := TTrackBar(Sender).Position;
             lbllegs1blue.caption := 'B:'+IntToStr(TTrackBar(Sender).Position);
        end;
end;

procedure TfrmBuildLayer.tbLegs1RedChange(Sender: TObject);
begin
        if (pcLayerTabs.ActivePage = tsShield) then
        begin
             imgShield.Red := TTrackBar(Sender).Position;
             lblshieldred.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsWeapon) then
        begin
             imgWeapon.Red := TTrackBar(Sender).Position;
             lblweaponred.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsHelmet) then
        begin
             imgHelmet.Red := TTrackBar(Sender).Position;
             lblhelmred.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsHead) then
        begin
             imgHead.Red := TTrackBar(Sender).Position;
             lblheadred.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsOuter) then
        begin
             imgOuter.Red := TTrackBar(Sender).Position;
             lblouterred.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsGauntlets) then
        begin
             imgGauntlets.Red := TTrackBar(Sender).Position;
             lblhandsred.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsChest3) then
        begin
             imgChest3.Red := TTrackBar(Sender).Position;
             lblchest3red.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsBelt) then
        begin
             imgBelt.Red := TTrackBar(Sender).Position;
             lblbeltred.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsArms) then
        begin
             imgArms.Red := TTrackBar(Sender).Position;
             lblarmsred.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsChest2)  then
        begin
             imgChest2.Red := TTrackBar(Sender).Position;
             lblchest2red.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsChest1)  then
        begin
             imgchest1.Red := TTrackBar(Sender).Position;
             lblchest1red.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsBoots) then
        begin
             imgboots.Red := TTrackBar(Sender).Position;
             lblbootsred.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tslegs2) then
        begin
             imgLegs2.Red := TTrackBar(Sender).Position;
             lbllegs2red.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tslegs1) then
        begin
             imgLegs1.Red := TTrackBar(Sender).Position;
             lbllegs1red.caption := 'R:'+IntToStr(TTrackBar(Sender).Position);
        end;

end;

procedure TfrmBuildLayer.tbLegs1GreenChange(Sender: TObject);
begin
        if (pcLayerTabs.ActivePage = tsShield) then
        begin
             imgShield.Green := TTrackBar(Sender).Position;
             lblshieldgreen.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsWeapon) then
        begin
             imgWeapon.Green := TTrackBar(Sender).Position;
             lblweapongreen.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsHelmet) then
        begin
             imgHelmet.Green := TTrackBar(Sender).Position;
             lblhelmgreen.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsHead) then
        begin
             imgHead.Green := TTrackBar(Sender).Position;
             lblheadgreen.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsOuter) then
        begin
             imgOuter.Green := TTrackBar(Sender).Position;
             lbloutergreen.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsGauntlets) then
        begin
             imgGauntlets.Green := TTrackBar(Sender).Position;
             lblhandsgreen.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsChest3) then
        begin
             imgChest3.Green := TTrackBar(Sender).Position;
             lblchest3green.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsBelt) then
        begin
             imgBelt.Green := TTrackBar(Sender).Position;
             lblbeltgreen.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsArms) then
        begin
             imgArms.Green := TTrackBar(Sender).Position;
             lblarmsgreen.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsChest2)  then
        begin
             imgChest2.Green := TTrackBar(Sender).Position;
             lblchest2green.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsChest1)  then
        begin
             imgchest1.Green := TTrackBar(Sender).Position;
             lblchest1green.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tsBoots) then
        begin
             imgboots.Green := TTrackBar(Sender).Position;
             lblbootsgreen.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tslegs2) then
        begin
             imgLegs2.Green := TTrackBar(Sender).Position;
             lbllegs2green.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;
        if (pcLayerTabs.ActivePage = tslegs1) then
        begin
             imgLegs1.Green := TTrackBar(Sender).Position;
             lbllegs1green.caption := 'G:'+IntToStr(TTrackBar(Sender).Position);
        end;

end;

function TfrmBuildLayer.Compile(): TRLESprite;
var
  iLoop : Integer;
  Picture : TBitPlane;
begin
  Result := TRLESprite.Create;
  Picture:=TBitPlane.create(FrameWidth,FrameHeight);

  for iLoop := 0 to MaxFrameCount - 1 do
  begin { DONE -cplayer pox : make custom procedure for coloring }
    Picture.KeyColor := BGColor;
    Picture.Clear;
 //   Figure.Frame := iLoop + 1;
    DrawColoredparts(iLoop, Picture.Bits );
    if iLoop = 0 then
      Result.LoadFromBitPlane( Picture )
    else
      Result.LoadMoreFromBitPlane( Picture );
//      Picture.DrawToDC(MainImg.canvas.handle,FrameWidth *iLoop,0);
    Application.ProcessMessages;
  end;
  picture.free;
  picture := nil;

end;

procedure TfrmBuildLayer.DrawColoredparts(Frame: integer; BitPlane : PBITPLANE );
begin

    try


    //*************2-Part Image stuff***************
    if (imgShield.LinkedLayerFirstFrame <> -1)then
    begin
        if imgShield.InUse then
        imgShield.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,imgShield.Red,imgShield.Green,imgShield.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgShield.LayeredFramesToBack, Frame) then
    begin
        if imgShield.InUse then
          imgShield.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgShield.Red,imgShield.Green,imgShield.Blue,100,0);
    end;

    //*************2-Part Image stuff***************
    if (imgWeapon.LinkedLayerFirstFrame <> -1)then
    begin
        if imgWeapon.InUse then
        imgWeapon.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,imgWeapon.Red,imgWeapon.Green,imgWeapon.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgWeapon.LayeredFramesToBack, Frame) then
    begin
        if imgWeapon.InUse then
           imgWeapon.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgWeapon.Red,imgWeapon.Green,imgWeapon.Blue,100,0);
    end;


    //*************2-Part Image stuff***************
    if (imgHelmet.LinkedLayerFirstFrame <> -1)then
    begin
        if imgHelmet.InUse then
        imgHelmet.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,imgHelmet.Red,imgHelmet.Green,imgHelmet.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgHelmet.LayeredFramesToBack, Frame) then
    begin
        if imgHelmet.InUse then
        imgHelmet.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgHelmet.Red,imgHelmet.Green,imgHelmet.Blue,100,0);
    end;


    //*************2-Part Image stuff***************
    if (ImgHead.LinkedLayerFirstFrame <> -1)then
    begin
        if ImgHead.InUse then
        ImgHead.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,ImgHead.Red,ImgHead.Green,ImgHead.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgHead.LayeredFramesToBack, Frame) then
    begin
        if ImgHead.InUse then
        ImgHead.RLE.DrawColorize(Frame,-10,-1,BitPlane,ImgHead.Red,ImgHead.Green,ImgHead.Blue,100,0);
    end;

    //*************2-Part Image stuff***************
    if (imgOuter.LinkedLayerFirstFrame <> -1)then
    begin
        if imgOuter.InUse then
        imgOuter.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,imgOuter.Red,imgOuter.Green,imgOuter.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgOuter.LayeredFramesToBack, Frame) then
    begin
        if imgOuter.InUse then
        imgOuter.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgOuter.Red,imgOuter.Green,imgOuter.Blue,100,0);
    end;


    //*************2-Part Image stuff***************
    if (imgGauntlets.LinkedLayerFirstFrame <> -1)then
    begin
        if imgGauntlets.InUse then
        imgGauntlets.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,imgGauntlets.Red,imgGauntlets.Green,imgGauntlets.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgGauntlets.LayeredFramesToBack, Frame) then
    begin
        if imgGauntlets.InUse then
        imgGauntlets.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgGauntlets.Red,imgGauntlets.Green,imgGauntlets.Blue,100,0);
    end;


    //*************2-Part Image stuff***************
    if (imgChest3.LinkedLayerFirstFrame <> -1)then
    begin
        if imgChest3.InUse then
        imgChest3.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,imgChest3.Red,imgChest3.Green,imgChest3.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgChest3.LayeredFramesToBack, Frame) then
    begin
        if imgChest3.inuse then
        imgChest3.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgChest3.Red,imgChest3.Green,imgChest3.Blue,100,0);
    end;


    //*************2-Part Image stuff***************
    if (imgBelt.LinkedLayerFirstFrame <> -1)then
    begin
        if imgBelt.InUse then
        imgBelt.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,imgBelt.Red,imgBelt.Green,imgBelt.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgBelt.LayeredFramesToBack, Frame) then
    begin
        if imgBelt.InUse then
        imgBelt.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgBelt.Red,imgBelt.Green,imgBelt.Blue,100,0);
    end;

    //*************2-Part Image stuff***************
    if (imgArms.LinkedLayerFirstFrame <> -1)then
    begin
        if imgArms.InUse then
        imgArms.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,imgArms.Red,imgArms.Green,imgArms.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgArms.LayeredFramesToBack, Frame) then
    begin
        if imgArms.InUse then
        imgArms.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgArms.Red,imgArms.Green,imgArms.Blue,100,0);
    end;


    //*************2-Part Image stuff***************
    if (imgChest2.LinkedLayerFirstFrame <> -1)then
    begin
        if imgChest2.InUse then
        imgChest2.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,imgChest2.Red,imgChest2.Green,imgChest2.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgChest2.LayeredFramesToBack, Frame) then
    begin
        if imgChest2.InUse then
        imgChest2.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgChest2.Red,imgChest2.Green,imgChest2.Blue,100,0);
    end;


    //*************2-Part Image stuff***************
    if (ImgChest1.LinkedLayerFirstFrame <> -1)then
    begin
        if ImgChest1.InUse then
        ImgChest1.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,ImgChest1.Red,imgShield.Green,ImgChest1.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgChest1.LayeredFramesToBack, Frame) then
    begin
        if ImgChest1.InUse then
        ImgChest1.RLE.DrawColorize(Frame,-10,-1,BitPlane,ImgChest1.Red,ImgChest1.Green,ImgChest1.Blue,100,0);
    end;


    //*************2-Part Image stuff***************
    if (imgBoots.LinkedLayerFirstFrame <> -1)then
    begin
        if imgBoots.InUse then
        imgBoots.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,imgBoots.Red,imgBoots.Green,imgBoots.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(imgBoots.LayeredFramesToBack, Frame) then
    begin
        if imgBoots.InUse then
        imgBoots.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgBoots.Red,imgBoots.Green,imgBoots.Blue,100,0);
    end;

    //*************2-Part Image stuff***************
    if (Imglegs2.LinkedLayerFirstFrame <> -1)then
    begin
        if Imglegs2.InUse then
        Imglegs2.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,Imglegs2.Red,Imglegs2.Green,Imglegs2.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(Imglegs2.LayeredFramesToBack, Frame) then
    begin

        if Imglegs2.InUse then
        Imglegs2.RLE.DrawColorize(Frame,-10,-1,BitPlane,Imglegs2.Red,Imglegs2.Green,Imglegs2.Blue,100,0);
    end;

    //*************2-Part Image stuff***************
    if (Imglegs1.LinkedLayerFirstFrame <> -1)then
    begin
        if Imglegs1.InUse then
        Imglegs1.BackRLE.DrawColorize(Frame,-10,-1,BitPlane,Imglegs1.Red,Imglegs1.Green,Imglegs1.Blue,100,0);
    end
    //*************2-Part Image stuff***************
    else
    if BackFrameTest(Imglegs1.LayeredFramesToBack, Frame) then
    begin
        if Imglegs1.InUse then
        Imglegs1.RLE.DrawColorize(Frame,-10,-1,BitPlane,Imglegs1.Red,Imglegs1.Green,Imglegs1.Blue,100,0);
    end;
    except
        //ignor it for now we dont need it
    end;



  //  MainImgMngr.DrawMaskedImage(Frame, BmpBuffer.canvas, 0,0); //draw naked man
      BaseRLE.DrawColorize(Frame,-10,-1,BitPlane,MainImg.Red,MainImg.Green,MainImg.Blue,100,0);


    try
    if Not(BackFrameTest(Imglegs1.LayeredFramesToBack, Frame)) then
    begin
        if Imglegs1.InUse then
         Imglegs1.RLE.DrawColorize(Frame,-10,-1,BitPlane,Imglegs1.Red,Imglegs1.Green,Imglegs1.Blue,100,0);
    end;

    if Not(BackFrameTest(Imglegs2.LayeredFramesToBack, Frame)) then
    begin

        if Imglegs2.InUse then
        Imglegs2.RLE.DrawColorize(Frame,-10,-1,BitPlane,Imglegs2.Red,Imglegs2.Green,Imglegs2.Blue,100,0);
    end;


    if Not(BackFrameTest(imgBoots.LayeredFramesToBack, Frame)) then
    begin
        if imgBoots.InUse then
        imgBoots.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgBoots.Red,imgBoots.Green,imgBoots.Blue,100,0);
    end;

    if Not(BackFrameTest(imgChest1.LayeredFramesToBack, Frame)) then
    begin
        if ImgChest1.InUse then
        ImgChest1.RLE.DrawColorize(Frame,-10,-1,BitPlane,ImgChest1.Red,ImgChest1.Green,ImgChest1.Blue,100,0);
    end;

    if Not(BackFrameTest(imgChest2.LayeredFramesToBack, Frame)) then
    begin
        if imgChest2.InUse then
        imgChest2.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgChest2.Red,imgChest2.Green,imgChest2.Blue,100,0);
    end;

    if Not(BackFrameTest(imgArms.LayeredFramesToBack, Frame)) then
    begin
        if imgArms.InUse then
        imgArms.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgArms.Red,imgArms.Green,imgArms.Blue,100,0);
    end;

    if Not(BackFrameTest(imgBelt.LayeredFramesToBack, Frame)) then
    begin
        if imgBelt.InUse then
        imgBelt.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgBelt.Red,imgBelt.Green,imgBelt.Blue,100,0);
    end;

    if Not(BackFrameTest(imgChest3.LayeredFramesToBack, Frame)) then
    begin
        if imgChest3.inuse then
        imgChest3.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgChest3.Red,imgChest3.Green,imgChest3.Blue,100,0);
    end;

    if Not(BackFrameTest(imgGauntlets.LayeredFramesToBack, Frame)) then
    begin
        if imgGauntlets.InUse then
        imgGauntlets.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgGauntlets.Red,imgGauntlets.Green,imgGauntlets.Blue,100,0);
    end;

    if Not(BackFrameTest(imgOuter.LayeredFramesToBack, Frame)) then
    begin
        if imgOuter.InUse then
        imgOuter.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgOuter.Red,imgOuter.Green,imgOuter.Blue,100,0);
    end;


    if Not(BackFrameTest(imgHead.LayeredFramesToBack, Frame)) then
    begin
        if ImgHead.InUse then
        ImgHead.RLE.DrawColorize(Frame,-10,-1,BitPlane,ImgHead.Red,ImgHead.Green,ImgHead.Blue,100,0);
    end;

    if Not(BackFrameTest(imgHelmet.LayeredFramesToBack, Frame)) then
    begin
        if imgHelmet.InUse then
        imgHelmet.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgHelmet.Red,imgHelmet.Green,imgHelmet.Blue,100,0);
    end;
    if Not(BackFrameTest(imgWeapon.LayeredFramesToBack, Frame)) then
    begin
        if imgWeapon.InUse then
        imgWeapon.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgWeapon.Red,imgWeapon.Green,imgWeapon.Blue,100,0);
    end;


    if Not(BackFrameTest(imgShield.LayeredFramesToBack, Frame)) then
    begin
        if imgShield.InUse then
        imgShield.RLE.DrawColorize(Frame,-10,-1,BitPlane,imgShield.Red,imgShield.Green,imgShield.Blue,100,0);
    end;
    lblFrameCount.Caption := IntToStr(Frame);

    except
       //ignor it for now we dont need it
    end;

 //   application.processmessages;//finish everything else up
end;

procedure TfrmBuildLayer.WriteLayeredPoxToDisk(fileName: string);
var
  Stream: TFileStream;
  S: string;
  L: longword;
  EOB: word;
  tmpList: TStringlist;
  MyRLE: TRLESprite;
begin
  try
    EOB := $4242;

  //  MakeSafeToWriteFile(FileName);
    Stream := TFileStream.create(FileName, fmCreate or fmShareExclusive);
    try
      Stream.write(#80#79#88#65, 4); //POX vA - Proprietary Object eXtension
      Stream.write(#67#67, 2); //fmt CC

      Stream.write(#13#10, 2); //CRLF
          { TODO -cplayer pox : document the use of the playertemplate }
      tmpList := TStringlist.create;
      tmplist.LoadFromFile(ExtractFilePath(Application.ExeName)+'playertemplate.dat');
//      tmpList.Insert(2, 'Gender=' + player.Gender);
      s := tmpList.text;
      tmpList.free;
      L := Length(S);

      Stream.write(L, sizeof(L));
      Stream.write(S[1], L);
      Stream.write(EOB, sizeof(EOB));

      MyRLE := Compile;

      MyRLE.SaveToStream(Stream);

      Stream.write(EOB, sizeof(EOB));
    finally
      Stream.free;
    end;
  except
  end;

end;

procedure TfrmBuildLayer.WriteTextureAction(FilePath: string; Frames: string; Action: string; Dir: string);
var
   MyBmp: TBitmap;
   iLoop: integer;
   X: integer;
   NG : TNGImage;
   ImageFileName : string;
   iStart, iStop: integer;
   iWidth:integer;
   iHeight: integer;
   fWidth: integer;
   fHeight: integer;
   iCount: integer;
   Picture : TBitPlane;
   strCharData: string;

begin
      fWidth := 128; //StrToInt(edtWidth.text);
      fHeight := 128; //StrToInt(edtHeight.text);
      iWidth := 512; //NextPow2(fWidth*8);
      iHeight:= 256; //NextPow2(fHeight*4);

      Picture:=TBitPlane.create(fWidth,fHeight);

      MyBmp := TBitmap.Create;
      MyBmp.Height := iHeight;
      MyBmp.Width := iWidth;
      MyBmp.Canvas.Brush.Color := mColor;
      MyBmp.Canvas.FillRect(Rect(0,0,iWidth,iHeight));
      //Walk NE Image
      ActionStartStop(iStart,iStop,Frames,Action);
      x := 0; //NE
      iCount := 0;
      for iLoop := iStart to iStop do
      begin
        if iCount = 4 then  x := 0;
        Picture.KeyColor := mColor;
        Picture.Clear;
        DrawColoredparts(iLoop,Picture.Bits );
      //            RLE.Draw(iLoop,0,0,BitPlane.Bits);
        if iCount < 4 then
           Picture.DrawToDC(MyBmp.canvas.handle,x,0)
        else
           Picture.DrawToDC(MyBmp.canvas.handle,x,fHeight);
        inc(x,fWidth);
        inc(iCount);
      end;
      ImageFileName :=  strTexPath + 'characters\' + strNameBase + '_' + Dir+ '_' + Action + '.png';
      if FileExists(ImageFileName) then
         DeleteFile(ImageFileName);
      NG := TNGImage.Create;
      NG.Assign(MyBmp);
      NG.SetAlphaColor(mColor);
      NG.SaveToPNGfile(ImageFileName);
      NG.Free;
      MyBmp.FreeImage;
      MyBmp.free;
      Picture.Free;
      Picture := nil;
      strCharData := ExtractFileName(ImageFileName) + ' 8 10 128 128';
      AppendTextToFile(FilePath + strNameBase + '.chr',strCharData);

      SaveNewCharActionFileData(ExtractFileName(ImageFileName), Dir, Action);
end;


procedure TfrmBuildLayer.WriteCharStand(FilePath: string);
var
   MyBmp: TBitmap;
   iLoop: integer;
   X: integer;
   NG : TNGImage;
   ImageFileName : string;
   iStart, iStop: integer;
   iWidth:integer;
   iHeight: integer;
   fWidth: integer;
   fHeight: integer;
   Picture : TBitPlane;
   strCharData: string;
begin
     fWidth :=128;//StrToInt(edtWidth.text);
     fHeight :=128;// StrToInt(edtHeight.text);
     iWidth := 512;//NextPow2(fWidth*4);
     iHeight:= 512; //NextPow2(fHeight*4);

     Picture:=TBitPlane.create(fWidth,fHeight);

     MyBmp := TBitmap.Create;
     MyBmp.Height := iHeight;
     MyBmp.Width := iWidth;
     MyBmp.Canvas.Brush.Color := mColor;
     MyBmp.Canvas.FillRect(Rect(0,0,iWidth,iHeight));
     //if assigned(RLE) then
     begin
          ActionStartStop(iStart,iStop,'NEFrames','Stand');
          x := 0; //NE
          for iLoop := iStart to iStop do
          begin
            Picture.KeyColor := mColor;
            Picture.Clear;
            DrawColoredparts(iLoop,Picture.Bits );
            Picture.DrawToDC(MyBmp.canvas.handle,x,0);
            inc(x,fWidth);
          end;

          ActionStartStop(iStart,iStop,'NWFrames','Stand');
          x := 0;//NW
          for iLoop := iStart to iStop do
          begin
            Picture.KeyColor := mColor;
            Picture.Clear;
            DrawColoredparts(iLoop,Picture.Bits );
            Picture.DrawToDC(MyBmp.canvas.handle,x,fHeight);
            inc(x,fWidth);
          end;

          ActionStartStop(iStart,iStop,'SEFrames','Stand');
          x := 0;  //SE
          for iLoop := iStart to iStop do
          begin
            Picture.KeyColor := mColor;
            Picture.Clear;
            DrawColoredparts(iLoop,Picture.Bits );
            Picture.DrawToDC(MyBmp.canvas.handle,x,fHeight*2);
            inc(x,fWidth);
          end;

          ActionStartStop(iStart,iStop,'SWFrames','Stand');
          x := 0; //SW
          for iLoop := iStart to iStop do
          begin
            Picture.KeyColor := mColor;
            Picture.Clear;
            DrawColoredparts(iLoop,Picture.Bits );
            Picture.DrawToDC(MyBmp.canvas.handle,x,fHeight*3);
            inc(x,fWidth);
          end;
     end;

     ImageFileName :=  FilePath + strNameBase +'_Stand.png';
     if FileExists(ImageFileName) then
       DeleteFile(ImageFileName);
//         MyBmp.SaveToFile(ChangeFileExt(ImageFileName,'.bmp'));
     NG := TNGImage.Create;
     NG.Assign(MyBmp);
     NG.SetAlphaColor(mcolor);
    // NG.TransparentColor := mcolor;
    // NG.Transparent := true;
     NG.SaveToPNGfile(ImageFileName);
     MyBmp.FreeImage;
     MyBmp.free;
     NG.Free;
     Picture.free;
     Picture := nil;
     strCharData := ExtractFileName(ImageFileName) + ' 1 1 128 128';
     AppendTextToFile(FilePath + strNameBase + '.chr',strCharData);
     SaveNewCharStandFileData(ExtractFileName(ImageFileName));
end;

procedure TfrmBuildLayer.ActionStartStop(var iStart:integer; var iStop: integer; Dir: string; Action: string);
var iLoop: integer;
MyList: string;
begin

     for iLoop := 0 to StrTokenCount(MainIniFile.Readstring('Action '+ Action, Dir, ''), ',') - 1 do
         if StrToIntDef(StrTokenAt(MainIniFile.Readstring('Action '+ Action, Dir, ''), ',', iLoop), -25) <> -25 then
            MyList := MyList + IntToStr(StrToInt(strTokenAt(MainIniFile.Readstring('Action '+ Action, Dir, ''), ',', iLoop))-1) + '|';
     strStripLast(MyList);
     iStart := StrToInt(StrTokenAt(MyList, '|', 0));
     iStop :=  StrToInt(StrTokenAt(MyList, '|', StrTokenCount(MyList, '|') -1));
end;


procedure TfrmBuildLayer.MakeAGif1Click(Sender: TObject);
begin
    try
       bPause := false;
       FlipFrameDrawOrder1.Enabled := False;
       MainTimer.enabled := false;
       Application.Processmessages; //Finish any animation drawing inprogress

             if (SaveDialog.Execute) then
             begin
               //IniData  after we have the file name
               MainIniFile.WriteString('Header','FileName',StrTokenAt(ExtractFileName(SaveDialog.FileName),'.',0)+'.pox');

               BuildIni(StrTokenAt(SaveDialog.FileName, '.',0)+ '.ini');
               WriteLayeredPoxToDisk(StrTokenAt(SaveDialog.FileName, '.',0)+ '.pox');
             end;


    finally
      if btnPlay.Down then
      MainTimer.enabled := true;
    end;
end;

procedure TfrmBuildLayer.LoadSFX;
var
objDB: TSQLiteDatabase;
objDS: TSQLIteTable;
strSQL: String;
begin
     sfxLookup := TStringList.create;

     objDB := TSQLiteDatabase.Create(strDatabase);

     strSQL := 'SELECT [SFXID],[FileName] from [tblISO_SoundFX] WHERE [SFXType] = 0 and [Active] = 1';
     objDS := objDB.GetTable(strSQL);
     if objDS.Count > 0 then
     begin
         while not objDS.EOF do
         begin
              try
                sfxLookup.Add(objDS.FieldAsString(objDS.FieldIndex['FileName']));
                sfxLookup.Values[objDS.FieldAsString(objDS.FieldIndex['FileName'])] := objDS.FieldAsString(objDS.FieldIndex['SFXID']);
                cbPainSFX.Items.Add(objDS.FieldAsString(objDS.FieldIndex['FileName']));
                cbDeathSFX.Items.Add(objDS.FieldAsString(objDS.FieldIndex['FileName']));
              finally
                 objDS.Next;
              end;
         end;
     end;
     objDS.free;
     objDB.free;


end;

procedure TfrmBuildLayer.SaveSFX(strCharacterID: string);
var
objDB: TSQLiteDatabase;
strSQL: String;
begin
     objDB := TSQLiteDatabase.Create(strDatabase);
     sfxLookup.Values[cbPainSFX.Items[cbPainSFX.ItemIndex]];
     strSQL := 'INSERT INTO [tblISO_CharacterSFX] ([CharacterID],[SFXID],[SFXType]) VALUE ('+strCharacterID+','+sfxLookup.Values[cbPainSFX.Items[cbPainSFX.ItemIndex]]+',0)';
     objDB.ExecSQL(strSQL);


     strSQL := 'INSERT INTO [tblISO_CharacterSFX] ([CharacterID],[SFXID],[SFXType]) VALUE ('+strCharacterID+','+sfxLookup.Values[cbPainSFX.Items[cbDeathSFX.ItemIndex]]+',1)';
     objDB.ExecSQL(strSQL);

     objDB.free;
end;

end.
