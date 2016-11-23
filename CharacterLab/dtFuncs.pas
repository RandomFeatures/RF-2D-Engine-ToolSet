unit dtFuncs;

interface

uses Graphics, Classes, Forms, Windows, SysUtils, IniFiles;

{$DEFINE FIVESIXFIVE}

const //GIFPROPERTYNAME = 'ResourceGif';      //class/object property that controls image
      ROOTCLASSNAME   = 'Classes';          //name of root class in treeview
      RECORDID        = 'RecordType';       //type identifier that defines a record type
      BASECLASSID     = 'BaseClass';        //begins definition of a base class (cannot edit)
      HANDLERADIUS    = 4;                  //drawing handle for depth offsets
      GRIDX           = 16;                 //rectangle grid size, horiz
      GRIDY           = 8;                  //rectangle grid size, vert
      STRIPWIDTH      = 16;                 //width of depth offset strips
      GUIDPropName    = 'GUID';             //name of property that defines unique name for objects
      GROUPPropName   = 'GroupName';        //name of property that defines group for objects (groups used for patchcorners, etc)
      SCRIPTTYPE      = 'ScriptString';     //property type for entering scripting info.
      SCENETYPE       = 'SceneFlags';       //property type for scene support
      SCENEPropName   = 'InScene';          //property name for scene support
      LOCKPropName    = 'EditFreeze';       //property name for Object Locking;
      DIRPropName     = 'Facing';           //property name for facing direction
      PATHCLASSID     = 'PathCorner';       //class name for pathcorners, special drawing support
      GRIDSPACEClass  = 'GridSpace';
      GRIDSPACEProp   = 'ListOfTiles';     //prop name for region definition for gridspace class
      INIHEIGHTProp   = 'CollisionHeight'; //Ini entry for spriteobject heights
      DEFCOLLISION    = 10;                //collision offset to use if none in registry 
type
  //quadrants of a diamond tile
  TDiamondQuadrants = (dqCenter, dqOE, dqNE, dqON, dqNW, dqOW, dqSW, dqOS, dqSE, dqIE, dqIN, dqIW, dqIS);

  TDiamondEraseMode = (deAll, deNorth, deWest, deSouth, deEast);

  //mode user is working in
  TWorkMode = (wmDraw, wmErase, wmObject);

  //in which corner cursor sits when dragging an object
  TObjectDrawCorner = (odLowerLeft, odLowerRight, odUpperLeft, odUpperRight);

  //type of blocks in save file
  TMapBlockTypes = (mbHeader, mbMap,
                    mbRectResourceList, mbDiamResourceList, mbObjResourceList,
                    mbLayer0, mbLayer1, mbLayerDiamond, mbLayerTag, mbObject, mbScene);

  //if user is zoomed in or out
  TZoomMode = (zmNormal, zmIn, zmOut);

  //"nudging" is moving an object one grid space a direction
  TNudgeDirection = (ndUp, ndDown, ndLeft, ndRight);

  TObjectManipulationMode = (ommNone, ommAdding, ommDepthEditing, ommMarqueeDrawing, ommGridSpace, ommMoving);

procedure ColorToBytes(c: TColor; var r,g,b: byte);
function  ColorToColor16(var c: TColor): word;

//turns "c:\demo\resource\stuff\fred.gif" into "stuff\fred"
function  GIFFileToResourceName(cResourcePath, cFilename: string): string;
//turns "stuff\fred" into "c:\demo\resource\stuff\fred.gif"
function  ResourceNameToGifFile(cResourcePath, cResourceName: string): string;
//turns "stuff\fred" into "c:\demo\resource\stuff\"
function  ResourceNameToPath(cResourcePath, cResourceName: string): string;
//makes 25 backups of file in backup folder
procedure  BackupFile(cFilename: string);

function BitTurnedOn(w, pos: word): boolean;     //true if position pos=1 in w.
//procedure ExtractGifIniFile(aGif: TGifImage; var Ini: TMemIniFile);   //sucks the INI our of our GIF files
function Bracketed(s: string): string;         //makes [s] out of s
function FacingToAngle(cDir: string): integer;
function AngleToFacing(a: integer): string;


var
  SinTable: array[0..359] of single;
  CosTable: array[0..359] of single;

implementation

uses Dialogs, string32, FileCtrl, Math;

function RGBToColor16(r,g,b: byte): word;
begin
{$IFDEF FIVESIXFIVE}
  result := ((r div 8) shl 11) + ((g div 4) shl  5) + (b div 8);    //5-6-5
{$ELSE}
  result := ((r div 8) shl 10) + ((g div 8) shl  5) + (b div 8);    //5-5-5
{$ENDIF}
end;

function ColorToColor16(var c: TColor): word;
var r,g,b: byte;
begin
  ColorToBytes(c, r,g,b);
  result := RGBToColor16(r,g,b);
end;

procedure ColorToBytes(c: TColor; var r,g,b: byte);
begin
  r := (c and $FF);
  g := (c and $FF00) shr 8;
  b := (c and $FF0000) shr 16;
end;

//turns "c:\demo\resource\stuff\fred.gif" into "stuff\fred"
function  GIFFileToResourceName(cResourcePath, cFilename: string): string;
var cPath: string;
    cRPath: string;
begin
  cRPath := LongDirectoryToShort(cResourcePath);

  cPath  := ExtractFilePath(cFilename);
  cPath  := ExtractRelativePath(cRPath, cPath);
  result := ExtractFileName(cFileName);
  result := leftstr(result, length(result)-4);
  result := cPath + result;
end;

//turns "stuff\fred" into "c:\demo\resource\stuff\fred.gif"
function  ResourceNameToGifFile(cResourcePath, cResourceName: string): string;
begin
  result := cResourcePath + cResourceName;
  if not StringsEqual(rightstr(result,4), '.gif') then
     result := result + '.gif';
end;

//turns "stuff\fred" into "c:\demo\resource\stuff\"
function  ResourceNameToPath(cResourcePath, cResourceName: string): string;
begin
  result := ResourceNameToGifFile(cResourcePath, cResourceName);
  result := ExtractFilePath(result);
end;

//create 25 backup versions of cFilename. DELETES cFilename when done!
procedure BackupFile(cFilename: string);
const NUMTOSAVE = 25;
var cOldDir: string;
    cFromFile, cToFile: string;
    cRootFile: string;
    cExtension: string;
    i: integer;
begin
  cOldDir := ExtractFilePath(application.exename) + 'backup\';
  ForceDirectories(cOldDir);

  cRootFile := ExtractFileName(cFileName);
  i := instr(cRootFile, '.');
  if i > 0 then begin
     cExtension := midstr(cRootFile, i, length(cRootFile));
     cRootFile := leftstr(cRootFile, i-1);
  end else
     cExtension := '';

  cFromFile := cOldDir + cRootFile + rightstr('00' + inttostr(NUMTOSAVE),2) + cExtension;
  DeleteFile(cFromFile);

  for i := NUMTOSAVE-1 downto 1 do begin
     cFromFile := cOldDir + cRootFile + rightstr('00' + inttostr(i),2) + cExtension;
     cToFile   := cOldDir + cRootFile + rightstr('00' + inttostr(i+1),2) + cExtension;
     RenameFile(cFromFile, cToFile);
  end;

  cToFile := cOldDir + cRootFile + '01' + cExtension;
  CopyFile(@cFileName[1], @cToFile[1], false);
  DeleteFile(cFileName);
end;

function BitTurnedOn(w, pos: word): boolean;     //true if position pos=1 in w.
begin
  result := (w shr pos) mod 2 = 1;
  //result := (w and Trunc(IntPower(2, pos))) <> 0;
end;


//rips INI file out of our proprietary GIFs. TGifImage is already loaded.
{procedure ExtractGifIniFile(aGif: TGifImage; var Ini: TMemIniFile);
var i: integer;
    bFound, bDone: boolean;
    eCom: TGIFCommentExtension;
begin
  i      := 0;
  bFound := false;
  bDone  := (i >= aGif.Images[0].Extensions.Count);
  while not (bDone or bFound) do begin
     if aGif.Images[0].Extensions[i] is TGIFCommentExtension then
        bFound := true
     else begin
        inc(i);
        bDone  := (i >= aGif.Images[0].Extensions.Count)
     end;
  end;

  if bFound then begin
     eCom := TGIFCommentExtension(aGif.Images[0].Extensions[i]);
     Ini := TMemIniFile.Create('');
     Ini.SetStrings(eCom.Text);
  end;
end;}

function Bracketed(s: string): string;
begin
  result := '[' + s + ']';
end;

//(NW, NN, NE, EE, SE, SS, SW, WW)
function FacingToAngle(cDir: string): integer;
begin
       if cDir = 'EE' then result := 0
  else if cDir = 'SE' then result := 45
  else if cDir = 'SS' then result := 90
  else if cDir = 'SW' then result := 135
  else if cDir = 'WW' then result := 180
  else if cDir = 'NW' then result := 225
  else if cDir = 'NN' then result := 270
  else if cDir = 'NE' then result := 315
  else result := 0;
end;

function AngleToFacing(a: integer): string;
var s: single;
begin
  s := Round(Floor(a / 45));
  a := Trunc(s * 45);
       if a = 0   then result := 'EE'
  else if a = 45  then result := 'SE'
  else if a = 90  then result := 'SS'
  else if a = 135 then result := 'SW'
  else if a = 180 then result := 'WW'
  else if a = 225 then result := 'NW'
  else if a = 270 then result := 'NN'
  else if a = 315 then result := 'NE'
  else result := 'SS';
end;


procedure InitSinTables;
var i: integer;
    r: single;
begin
  for i := 0 to 359 do begin
     r := i*Pi/180;
     SinTable[i] := Sin(r);
     CosTable[i] := Cos(r);
  end;
end;


initialization
  InitSinTables;



end.
