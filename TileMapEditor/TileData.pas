unit TileData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, ImageManager, IniFiles,
  strFunctions;

Type
 TTileLayer =(tlBase, tlDiamond, tlCollision, tlBaseDiamond, tlAll);
  //quadrants of a diamond tile
 TDiamondType =  (dtSingle, dtQuad);
 TDiamondQuadrants = (dqCenter, dqOE, dqNE, dqON, dqNW, dqOW, dqSW, dqOS, dqSE, dqIE, dqIN, dqIW, dqIS);
 TQuadCorner = (qcNorth, qcEast, qcSouth, qcWest);

  TTile = class(TObject)
  public
        ID: integer;
        x,y: integer;
        FileName: string;
  end;

  TQuadSlice = class(TTile)
  public
      used: boolean;
      dqType: TDiamondQuadrants;
  end;

  TSlice = record
     x,y: integer;
     Tile: TQuadSlice;
  end;
  //Holds all the tiles in the set
  TTileSet = class(TObject)
    constructor Create(fileName: String);
    destructor  Destroy; override;
  private
    BaseName: string;
    CenterTiles:TList;
    EECornerOutTiles:TList;
    NEEdgeTiles:TList;
    NNCornerOutTiles:TList;
    NWEdgeTiles:TList;
    WWCornerOutTiles:TList;
    SWEdgeTiles:TList;
    SSCornerOutTiles:TList;
    SEEdgeTiles:TList;
    EECornerInTiles:TList;
    NNCornerInTiles:TList;
    WWCornerInTiles:TList;
    SSCornerInTiles:TList;
    procedure LoadIndxTiles(IndxList: string;  QuadType: TDiamondQuadrants);
    procedure LoadTile(fileName: string; QuadType: TDiamondQuadrants);
    procedure AddTile(Slice: TQuadSlice);
  public
    GUID: String;
    imQuadTiles: TImageManager;
    procedure LoadIniFile(fileName: string);
    function GetRandomSlice(dQuad: TDiamondQuadrants): TQuadSlice;
  end;

  TQuadTile = class(TObject)
      constructor Create(var TileSet: TTileSet);
  public
      x,y: integer;
      pTileSet: TTileSet;
      North: TSlice;
      East: TSlice;
      South: TSlice;
      West: TSlice;
      procedure reInit(TileSet: TTileSet);
      procedure SetPos(x,y: integer);
  end;

  TQuadCollection = class(TObject)
    constructor Create;
    destructor  Destroy; override;
  private
     TileSetList : TList;  //All of the TTileSets on the map
  public
     QuadList: TList; //All of the TQuadTiles on the map
     CurrentTileSet: TTileSet;
     CurrentQuad: TQuadTile;
     function GetNWQuad(CrntTile:TQuadTile): TQuadTile;
     function GetSWQuad(CrntTile:TQuadTile): TQuadTile;
     function GetSEQuad(CrntTile:TQuadTile): TQuadTile;
     function GetNEQuad(CrntTile:TQuadTile): TQuadTile;
     function GetNNQuad(CrntTile:TQuadTile): TQuadTile;
     function GetSSQuad(CrntTile:TQuadTile): TQuadTile;
     function GetEEQuad(CrntTile:TQuadTile): TQuadTile;
     function GetWWQuad(CrntTile:TQuadTile): TQuadTile;
     procedure ChangeQuadSlice(var QuadTile: TQuadTile; Corner: TQuadCorner; DQType: TDiamondQuadrants);
     procedure AddQuadTile(x: integer; y: integer); //Add a new TQuadTile to the map
     procedure AddTileSet(FileName: string); //Add a new TTileSet to the map
     procedure DeleteQuadTile(x: integer; y: integer); //delete a TQuadTile from the map
     procedure placeQuad(var CrntTile:TQuadTile; x: integer;y: integer);
     function CheckExistingTileSet(GUID: string): boolean;
     function CheckExistingQuadTile(x: integer; y: integer): boolean;
     procedure QuadCornerNN(x: integer; y: integer);
     procedure QuadCornerEE(x: integer; y: integer);
     procedure QuadCornerSS(x: integer; y: integer);
     procedure QuadCornerWW(x: integer; y: integer);
     procedure ClearAll;
   end;

 {
  TQuadData = Class(TObject)
  public
    Center:string;
    EECornerOut:string;
    NEEdge:string;
    NNCornerOut:string;
    NWEdge:string;
    WWCornerOut:string;
    SWEdge:string;
    SSCornerOut:string;
    SEEdge:string;
    EECornerIn:string;
    NNCornerIn:string;
    WWCornerIn:string;
    SSCornerIn:string;
  end;
  }
  
procedure EmptyTList(var List: TList);


implementation

procedure EmptyTList(var List: TList);
begin
   if Assigned(List) then
   while List.count > 0 do
   begin
       TObject(List.Items[0]).free;
       List.Delete(0);
   end;
end;


{ TTileSet }
procedure TTileSet.AddTile(Slice: TQuadSlice);
begin
   case Slice.dqType of
   dqCenter: CenterTiles.add(Slice);
   dqOE: EECornerOutTiles.add(Slice);
   dqNE: NEEdgeTiles.add(Slice);
   dqON: NNCornerOutTiles.add(Slice);
   dqNW: NWEdgeTiles.add(Slice);
   dqOW: WWCornerOutTiles.add(Slice);
   dqSW: SWEdgeTiles.add(Slice);
   dqOS: SSCornerOutTiles.add(Slice);
   dqSE: SEEdgeTiles.add(Slice);
   dqIE: EECornerInTiles.add(Slice);
   dqIN: NNCornerInTiles.add(Slice);
   dqIW: WWCornerInTiles.add(Slice);
   dqIS: SSCornerInTiles.add(Slice);
   end;
end;


constructor TTileSet.Create(fileName: String);
begin
    CenterTiles := TList.Create;
    EECornerOutTiles := TList.Create;
    NEEdgeTiles := TList.Create;
    NNCornerOutTiles := TList.Create;
    NWEdgeTiles := TList.Create;
    WWCornerOutTiles := TList.Create;
    SWEdgeTiles := TList.Create;
    SSCornerOutTiles := TList.Create;
    SEEdgeTiles := TList.Create;
    EECornerInTiles := TList.Create;
    NNCornerInTiles := TList.Create;
    WWCornerInTiles := TList.Create;
    SSCornerInTiles := TList.Create;
    imQuadTiles  := TImageManager.Create;
    imQuadTiles.MaxImageCache := 32;
    LoadIniFile(fileName);
end;

destructor TTileSet.Destroy;
begin
  inherited;
    EmptyTList(CenterTiles);
    EmptyTList(EECornerOutTiles);
    EmptyTList(NEEdgeTiles);
    EmptyTList(NNCornerOutTiles);
    EmptyTList(NWEdgeTiles);
    EmptyTList(WWCornerOutTiles);
    EmptyTList(SWEdgeTiles);
    EmptyTList(SSCornerOutTiles);
    EmptyTList(SEEdgeTiles);
    EmptyTList(EECornerInTiles);
    EmptyTList(NNCornerInTiles);
    EmptyTList(WWCornerInTiles);
    EmptyTList(SSCornerInTiles);

    CenterTiles.clear;
    EECornerOutTiles.clear;
    NEEdgeTiles.clear;
    NNCornerOutTiles.clear;
    NWEdgeTiles.clear;
    WWCornerOutTiles.clear;
    SWEdgeTiles.clear;
    SSCornerOutTiles.clear;
    SEEdgeTiles.clear;
    EECornerInTiles.clear;
    NNCornerInTiles.clear;
    WWCornerInTiles.clear;
    SSCornerInTiles.clear;

    CenterTiles.free;
    EECornerOutTiles.free;
    NEEdgeTiles.free;
    NNCornerOutTiles.free;
    NWEdgeTiles.free;
    WWCornerOutTiles.free;
    SWEdgeTiles.free;
    SSCornerOutTiles.free;
    SEEdgeTiles.free;
    EECornerInTiles.free;
    NNCornerInTiles.free;
    WWCornerInTiles.free;
    SSCornerInTiles.free;
    imQuadTiles.free;

end;

function TTileSet.GetRandomSlice(
  dQuad: TDiamondQuadrants): TQuadSlice;
var
  rtn:TQuadSlice;
  rnd: integer;
begin
   rtn := nil;
   rnd := 0;
   case dQuad of
   dqCenter:
       begin
          if CenterTiles.Count > 0 then
          begin
            rnd := Random(CenterTiles.Count-1);
            if rnd < 0 then rnd := 0;
            rtn := CenterTiles.Items[rnd];
          end;
       end;
   dqOE:
       begin
          if EECornerOutTiles.Count > 0 then
          begin
            rnd := Random(EECornerOutTiles.Count-1);
            if rnd < 0 then rnd := 0;
            rtn := EECornerOutTiles.Items[rnd];
          end;
       end;
   dqNE:
       begin
          if NEEdgeTiles.Count > 0 then
          begin
            rnd := Random(NEEdgeTiles.Count-1);
            if rnd < 0 then rnd := 0;
            rtn := NEEdgeTiles.Items[rnd];
          end;
       end;
   dqON:
       begin
          if NNCornerOutTiles.Count > 0 then
          begin
            rnd := Random(NNCornerOutTiles.Count-1);
            if rnd < 0 then rnd := 0;
            rtn := NNCornerOutTiles.Items[rnd];
          end;
       end;
   dqNW:
       begin
          if NWEdgeTiles.Count > 0 then
          begin
            rnd := Random(NWEdgeTiles.Count-1);
            if rnd < 0 then rnd := 0;
            rtn := NWEdgeTiles.Items[rnd];
          end;
       end;
   dqOW:
       begin
          if WWCornerOutTiles.Count > 0 then
          begin
            rnd := Random(WWCornerOutTiles.Count-1);
            if rnd < 0 then rnd := 0;
            rtn := WWCornerOutTiles.Items[rnd];
          end;
       end;
   dqSW:
       begin
          if SWEdgeTiles.Count > 0 then
          begin
            rnd := Random(SWEdgeTiles.Count-1);
            if rnd < 0 then rnd := 0;
            rtn := SWEdgeTiles.Items[rnd];
          end;
       end;
   dqOS:
       begin
          if SSCornerOutTiles.Count > 0 then
          begin
            rnd := Random(SSCornerOutTiles.Count-1);
            if rnd < 0 then rnd := 0;
            rtn := SSCornerOutTiles.Items[rnd];
          end;
       end;
   dqSE:
       begin
          if SEEdgeTiles.Count > 0 then
          begin
            rnd := Random(SEEdgeTiles.Count-1);
            if rnd < 0 then rnd := 0;
            rtn := SEEdgeTiles.Items[rnd];
          end;
       end;
   dqIE:
       begin
          if EECornerInTiles.Count > 0 then
          begin
            rnd := Random(EECornerInTiles.Count-1);
            if rnd < 0 then rnd := 0;
            rtn := EECornerInTiles.Items[rnd];
          end;
       end;
   dqIN:
       begin
          if NNCornerInTiles.Count > 0 then
          begin
            rnd := Random(NNCornerInTiles.Count-1);
            if rnd < 0 then rnd := 0;
            rtn := NNCornerInTiles.Items[rnd];
          end;
       end;
   dqIW:
       begin
          if WWCornerInTiles.Count > 0 then
          begin
            rnd := Random(WWCornerInTiles.Count-1);
            if rnd < 0 then rnd := 0;
            rtn := WWCornerInTiles.Items[rnd];
          end;
       end;
   dqIS:
       begin
          if SSCornerInTiles.Count > 0 then
          begin
            rnd := Random(SSCornerInTiles.Count-1);
            if rnd < 0 then rnd := 0;
            rtn := SSCornerInTiles.Items[rnd];
          end;
       end;
   end;
   Result := rtn;
end;

procedure TTileSet.LoadIniFile(fileName: string);
var
MyIni :TIniFile;
begin
     BaseName := ChangeFileExt(FileName,'');
     MyIni := TIniFile.Create(fileName);
     GUID := LowerCase(BaseName);
     LoadIndxTiles(MyIni.ReadString('ImageList','Center','0') , dqCenter);
     LoadIndxTiles(MyIni.ReadString('ImageList','EECornerOut','0'), dqOE);
     LoadIndxTiles(MyIni.ReadString('ImageList','NEEdge','0'), dqNE);
     LoadIndxTiles(MyIni.ReadString('ImageList','NNCornerOut','0'), dqON);
     LoadIndxTiles(MyIni.ReadString('ImageList','NWEdge','0'), dqNW);
     LoadIndxTiles(MyIni.ReadString('ImageList','WWCornerOut','0'), dqOW);
     LoadIndxTiles(MyIni.ReadString('ImageList','SWEdge','0'), dqSW);
     LoadIndxTiles(MyIni.ReadString('ImageList','SSCornerOut','0'), dqOS);
     LoadIndxTiles(MyIni.ReadString('ImageList','SEEdge','0'), dqSE);
     LoadIndxTiles(MyIni.ReadString('ImageList','EECornerIn','0'), dqIE);
     LoadIndxTiles(MyIni.ReadString('ImageList','NNCornerIn','0'), dqIN);
     LoadIndxTiles(MyIni.ReadString('ImageList','WWCornerIn','0'), dqIW);
     LoadIndxTiles(MyIni.ReadString('ImageList','SSCornerIn','0'), dqIS);
     MyIni.free;

end;

procedure TTileSet.LoadIndxTiles(IndxList: string;  QuadType: TDiamondQuadrants);
var
   iLoop: Integer;
   indxName: string;
   tmpInt: integer;
begin
      for iLoop := 0 to  strTokenCount(IndxList,',')-1 do
      begin
          indxName := strTokenAt(IndxList,',',iLoop);
          tmpInt := StrToInt(indxName);
          dec(tmpInt);
          indxName := IntToStr(tmpInt);
          indxName := strPadChL(indxName,'0',2);
          LoadTile(BaseName + '_' + indxName + '.bmp', QuadType);
      end;
end;

procedure TTileSet.LoadTile(fileName: string; QuadType: TDiamondQuadrants);
var
   TileImage: TBitmap;
   NewTile: TQuadSlice;
begin
    if fileExists(fileName) then
    begin
         TileImage := TBitmap.Create;
         TileImage.LoadFromFile(fileName);
         TileImage.Dormant;
         TileImage.TransparentMode := tmAuto;
         TileImage.Transparent := true;
         imQuadTiles.AddImage2(TileImage);
         NewTile := TQuadSlice.Create;
         NewTile.FileName := fileName;
         NewTile.ID :=  imQuadTiles.ImageCount -1;
         NewTile.dqType := QuadType;
         AddTile(NewTile);
    end;

end;

{ TQuadCollection }

procedure TQuadCollection.AddQuadTile(x: integer; y: integer);
var
   NewQuadTile: TQuadTile;
begin
     if CheckExistingQuadTile(x,y) then
     begin
        CurrentQuad.reInit(CurrentTileSet);
        placeQuad(CurrentQuad,x,y);
     end
     else
     begin
          NewQuadTile := TQuadTile.Create(CurrentTileSet);
          currentQuad := QuadList.Items[QuadList.Add(NewQuadTile)];
          placeQuad(CurrentQuad,x,y);
     end;
end;

procedure TQuadCollection.QuadCornerNN(x: integer; y: integer);
var
MySlice: TQuadSlice;
begin
     if CheckExistingQuadTile(x,y) then
     begin
          MySlice := CurrentTileSet.GetRandomSlice(dqIS);
          if MySlice <> nil then
          currentQuad.North.Tile  := MySlice
     end
end;

procedure TQuadCollection.QuadCornerEE(x: integer; y: integer);
var
MySlice: TQuadSlice;
begin
     if CheckExistingQuadTile(x,y) then
     begin
          MySlice := CurrentTileSet.GetRandomSlice(dqIW);
          if MySlice <> nil then
          currentQuad.East.Tile  := MySlice
     end
end;

procedure TQuadCollection.QuadCornerSS(x: integer; y: integer);
var
MySlice: TQuadSlice;
begin
     if CheckExistingQuadTile(x,y) then
     begin
          MySlice := CurrentTileSet.GetRandomSlice(dqIN);
          if MySlice <> nil then
          currentQuad.South.Tile  := MySlice
     end
end;

procedure TQuadCollection.QuadCornerWW(x: integer; y: integer);
var
MySlice: TQuadSlice;
begin
     if CheckExistingQuadTile(x,y) then
     begin
          MySlice := CurrentTileSet.GetRandomSlice(dqIE);
          if MySlice <> nil then
          currentQuad.West.Tile  := MySlice
     end
end;


procedure TQuadCollection.AddTileSet(fileName: string);
var
MyTileSet: TTileSet;
iLoop: integer;
begin
     MyTileSet := TTileSet.Create(fileName);
     CurrentTileSet := Nil;
     for iLoop := 0 to TileSetList.Count -1 do
     begin
          if TTileSet(TileSetList.Items[iLoop]).GUID = MyTileSet.GUID then
             CurrentTileSet := TTileSet(TileSetList.Items[iLoop]);
     end;
     if not Assigned(CurrentTileSet) then
        currentTileSet := TileSetList.Items[TileSetList.Add(MyTileSet)];
end;

procedure TQuadCollection.ChangeQuadSlice(var QuadTile: TQuadTile; Corner: TQuadCorner; DQType: TDiamondQuadrants);
begin
       case Corner of
       qcNorth:QuadTile.North.Tile  := QuadTile.pTileSet.GetRandomSlice(DQType) ;
       qcEast:QuadTile.East.Tile  := QuadTile.pTileSet.GetRandomSlice(DQType) ;
       qcSouth:QuadTile.South.Tile  := QuadTile.pTileSet.GetRandomSlice(DQType) ;
       qcWest:QuadTile.West.Tile  := QuadTile.pTileSet.GetRandomSlice(DQType) ;
       end;
end;

function TQuadCollection.CheckExistingQuadTile(x, y: integer): boolean;
var
iLoop : integer;
rtn: boolean;
begin
     rtn := false;
     for iLoop := 0 to QuadList.Count -1 do
     begin
            if (TQuadTile(QuadList.items[iLoop]).x = x) and (TQuadTile(QuadList.items[iLoop]).y = y) then
            begin
                currentQuad := TQuadTile(QuadList.Items[iLoop]);
                rtn := true;
                break;
            end;
     end;
     result := rtn;
end;

function TQuadCollection.CheckExistingTileSet(GUID: string): boolean;
var
iLoop : integer;
rtn: boolean;
begin
     rtn := false;
     for iLoop := 0 to TileSetList.Count -1 do
     begin
          if LowerCase(TTileSet(TileSetList.items[iLoop]).GUID) = LowerCase(GUID) then
          begin
              currentTileSet := TTileSet(TileSetList.Items[iLoop]);
              rtn := true;
              break;
          end;
     end;
     result := rtn;
end;

constructor TQuadCollection.Create;
begin
     QuadList := TList.Create;
     TileSetList := TList.Create;
end;

procedure TQuadCollection.DeleteQuadTile(x, y: integer);
var
iLoop: integer;
begin
     for iLoop := 0 to QuadList.Count -1 do
     begin
          if (TQuadTile(QuadList.Items[iLoop]).x = x) and (TQuadTile(QuadList.Items[iLoop]).y = y) then
          begin
              TQuadTile(QuadList.Items[iLoop]).free;
              break;
          end;

     end;
end;

destructor TQuadCollection.Destroy;
begin
  inherited;
     ClearAll;
     QuadList.free;
     TileSetList.free;
end;

function TQuadCollection.GetNNQuad(CrntTile: TQuadTile): TQuadTile;
var
iLoop: integer;
rtn: TQuadTile;
begin
     rtn := nil;
     for iLoop := 0 to QuadList.Count -1 do
     begin
          if TQuadTile(QuadList.items[iLoop]).pTileSet = CrntTile.pTileSet  then
          if (TQuadTile(QuadList.Items[iLoop]).x = CrntTile.x) and (TQuadTile(QuadList.Items[iLoop]).y = CrntTile.y-4) then
          begin
               rtn := TQuadTile(QuadList.Items[iLoop]);
               break;
          end;
     end;
     result := rtn
end;

function TQuadCollection.GetSSQuad(CrntTile: TQuadTile): TQuadTile;
var
iLoop: integer;
rtn: TQuadTile;
begin
     rtn := nil;
     for iLoop := 0 to QuadList.Count -1 do
     begin
          if TQuadTile(QuadList.items[iLoop]).pTileSet = CrntTile.pTileSet  then
          if (TQuadTile(QuadList.Items[iLoop]).x = CrntTile.x) and (TQuadTile(QuadList.Items[iLoop]).y = CrntTile.y+4) then
          begin
               rtn := TQuadTile(QuadList.Items[iLoop]);
               break;
          end;
     end;
     result := rtn
end;

function TQuadCollection.GetNEQuad(CrntTile: TQuadTile): TQuadTile;
var
iLoop: integer;
rtn: TQuadTile;
begin
     rtn := nil;
     for iLoop := 0 to QuadList.Count -1 do
     begin
          if TQuadTile(QuadList.items[iLoop]).pTileSet = CrntTile.pTileSet  then
          if (TQuadTile(QuadList.Items[iLoop]).x = CrntTile.x+1) and (TQuadTile(QuadList.Items[iLoop]).y = CrntTile.y-2) then
          begin
               rtn := TQuadTile(QuadList.Items[iLoop]);
               break;
          end;
     end;
     result := rtn
end;

function TQuadCollection.GetNWQuad(CrntTile: TQuadTile): TQuadTile;
var
iLoop: integer;
rtn: TQuadTile;
begin
     rtn := nil;
     for iLoop := 0 to QuadList.Count -1 do
     begin
          if TQuadTile(QuadList.items[iLoop]).pTileSet = CrntTile.pTileSet  then
          if (TQuadTile(QuadList.Items[iLoop]).x = CrntTile.x-1) and (TQuadTile(QuadList.Items[iLoop]).y = CrntTile.y-2) then
          begin
               rtn := TQuadTile(QuadList.Items[iLoop]);
               break;
          end;
     end;
     result := rtn

end;

function TQuadCollection.GetSEQuad(CrntTile: TQuadTile): TQuadTile;
var
iLoop: integer;
rtn: TQuadTile;
begin
     rtn := nil;
     for iLoop := 0 to QuadList.Count -1 do
     begin
          if TQuadTile(QuadList.items[iLoop]).pTileSet = CrntTile.pTileSet  then
          if (TQuadTile(QuadList.Items[iLoop]).x = CrntTile.x+1) and (TQuadTile(QuadList.Items[iLoop]).y = CrntTile.y+2) then
          begin
               rtn := TQuadTile(QuadList.Items[iLoop]);
               break;
          end;
     end;
     result := rtn
end;

function TQuadCollection.GetSWQuad(CrntTile: TQuadTile): TQuadTile;
var
iLoop: integer;
rtn: TQuadTile;
begin
     rtn := nil;
     for iLoop := 0 to QuadList.Count -1 do
     begin
          if TQuadTile(QuadList.items[iLoop]).pTileSet = CrntTile.pTileSet  then
          if (TQuadTile(QuadList.Items[iLoop]).x = CrntTile.x-1) and (TQuadTile(QuadList.Items[iLoop]).y = CrntTile.y+2) then
          begin
               rtn := TQuadTile(QuadList.Items[iLoop]);
               break;
          end;
     end;
     result := rtn
end;

function TQuadCollection.GetWWQuad(CrntTile: TQuadTile): TQuadTile;
var
iLoop: integer;
rtn: TQuadTile;
begin
     rtn := nil;
     for iLoop := 0 to QuadList.Count -1 do
     begin
          if TQuadTile(QuadList.items[iLoop]).pTileSet = CrntTile.pTileSet  then
          if (TQuadTile(QuadList.Items[iLoop]).x = CrntTile.x-2) and (TQuadTile(QuadList.Items[iLoop]).y = CrntTile.y) then
          begin
               rtn := TQuadTile(QuadList.Items[iLoop]);
               break;
          end;
     end;
     result := rtn
end;

function TQuadCollection.GetEEQuad(CrntTile: TQuadTile): TQuadTile;
var
iLoop: integer;
rtn: TQuadTile;
begin
     rtn := nil;
     for iLoop := 0 to QuadList.Count -1 do
     begin
          if TQuadTile(QuadList.items[iLoop]).pTileSet = CrntTile.pTileSet  then
          if (TQuadTile(QuadList.Items[iLoop]).x = CrntTile.x+2) and (TQuadTile(QuadList.Items[iLoop]).y = CrntTile.y) then
          begin
               rtn := TQuadTile(QuadList.Items[iLoop]);
               break;
          end;
     end;
     result := rtn
end;

procedure TQuadCollection.placeQuad(var CrntTile: TQuadTile; x, y: integer);
var
   tmpNEQuad: TQuadTile;
   tmpNWQuad: TQuadTile;
   tmpSEQuad: TQuadTile;
   tmpSWQuad: TQuadTile;
   tmpSSQuad: TQuadTile;
   tmpNNQuad: TQuadTile;
   tmpWWQuad: TQuadTile;
   tmpEEQuad: TQuadTile;
begin
//dqCenter, dqOE, dqNE, dqON, dqNW, dqOW, dqSW, dqOS, dqSE, dqIE, dqIN, dqIW, dqIS
     tmpNEQuad := nil;
     tmpNWQuad := nil;
     tmpSEQuad := nil;
     tmpSWQuad := nil;

     CrntTile.setPos(x,y);

     tmpNEQuad := GetNEQuad(crntTile);
     tmpNWQuad := GetNWQuad(crntTile);
     tmpSEQuad := GetSEQuad(crntTile);
     tmpSWQuad := GetSWQuad(crntTile);
     tmpSSQuad := GetSSQuad(crntTile);
     tmpWWQuad := GetWWQuad(crntTile);
     tmpEEQuad := GetEEQuad(crntTile);
     tmpNNQuad := GetNNQuad(crntTile);

     //North

     if assigned(tmpNEQuad) then
     begin
          CrntTile.North.Tile  := CurrentTileSet.GetRandomSlice(dqNW);
          if Assigned(tmpNNQuad) then
             tmpNEQuad.West.Tile  := CurrentTileSet.GetRandomSlice(dqCenter)
          else
             tmpNEQuad.West.Tile  := CurrentTileSet.GetRandomSlice(dqNW);

          if Assigned(tmpSEQuad) then
             CrntTile.East.Tile  := CurrentTileSet.GetRandomSlice(dqCenter)
          else
             CrntTile.East.Tile  := CurrentTileSet.GetRandomSlice(dqSE);

          if Assigned(tmpEEQuad) and Assigned(tmpNEQuad) then
             tmpNEQuad.South.Tile  := CurrentTileSet.GetRandomSlice(dqCenter)
          else
             tmpNEQuad.South.Tile  := CurrentTileSet.GetRandomSlice(dqSE);
     end;

     if Assigned(tmpNWQuad) then
     begin
          CrntTile.North.Tile  := CurrentTileSet.GetRandomSlice(dqNE);
          if Assigned(tmpNNQuad) then
             tmpNWQuad.East.Tile  := CurrentTileSet.GetRandomSlice(dqCenter)
          else
             tmpNWQuad.East.Tile  := CurrentTileSet.GetRandomSlice(dqNE);

          if Assigned(tmpSWQuad) then
             CrntTile.West.Tile  := CurrentTileSet.GetRandomSlice(dqCenter)
          else
             CrntTile.West.Tile  := CurrentTileSet.GetRandomSlice(dqSW);

          if Assigned(tmpWWQuad) and Assigned(tmpNWQuad) then
             tmpNWQuad.South.Tile  := CurrentTileSet.GetRandomSlice(dqCenter)
          else
             tmpNWQuad.South.Tile  := CurrentTileSet.GetRandomSlice(dqSW);
     end;

     if assigned(tmpNEQuad) and assigned(tmpNWQuad) then
     begin
          CrntTile.North.Tile  := CurrentTileSet.GetRandomSlice(dqCenter);
          if Assigned(tmpNNQuad) then
          begin //Finish square set all to center
            if Assigned(tmpNNQuad) then
               tmpNNQuad.South.Tile  := CurrentTileSet.GetRandomSlice(dqCenter);
            if Assigned(tmpNEQuad) then
               tmpNEQuad.West.Tile  := CurrentTileSet.GetRandomSlice(dqCenter);
            if Assigned(tmpNWQuad) then
               tmpNWQuad.East.Tile  := CurrentTileSet.GetRandomSlice(dqCenter);
          end
          else
          begin
            if Assigned(tmpNEQuad) then
               tmpNEQuad.West.Tile  := CurrentTileSet.GetRandomSlice(dqNW);
            if Assigned(tmpNWQuad) then
               tmpNWQuad.East.Tile  := CurrentTileSet.GetRandomSlice(dqNE);
          end;
     end;



     //South

     if assigned(tmpSEQuad) then
     begin
          CrntTile.South.Tile  := CurrentTileSet.GetRandomSlice(dqSW);
          if Assigned(tmpEEQuad) then
             tmpSEQuad.North.Tile  := CurrentTileSet.GetRandomSlice(dqCenter)
          else
             tmpSEQuad.North.Tile  := CurrentTileSet.GetRandomSlice(dqNE);

          if assigned(tmpNEQuad) then
             CrntTile.East.Tile  := CurrentTileSet.GetRandomSlice(dqCenter)
          else
             CrntTile.East.Tile  := CurrentTileSet.GetRandomSlice(dqNE);

          if assigned(tmpSSQuad) then
             tmpSEQuad.West.Tile  := CurrentTileSet.GetRandomSlice(dqCenter)
          else
             tmpSEQuad.West.Tile  := CurrentTileSet.GetRandomSlice(dqSW);

     end;

     if assigned(tmpSWQuad) then
     begin
          CrntTile.South.Tile  := CurrentTileSet.GetRandomSlice(dqSE);
          if Assigned(tmpWWQuad) then
             tmpSWQuad.North.Tile  := CurrentTileSet.GetRandomSlice(dqCenter)
          else
             tmpSWQuad.North.Tile  := CurrentTileSet.GetRandomSlice(dqNW);

          if assigned(tmpNWQuad) then
             CrntTile.West.Tile  := CurrentTileSet.GetRandomSlice(dqCenter)
          else
             CrntTile.West.Tile  := CurrentTileSet.GetRandomSlice(dqNW);

          if assigned(tmpSSQuad) then
             tmpSWQuad.East.Tile  := CurrentTileSet.GetRandomSlice(dqCenter)
          else
             tmpSWQuad.East.Tile  := CurrentTileSet.GetRandomSlice(dqSE);
     end;


     if assigned(tmpSEQuad) and assigned(tmpSWQuad) then
     begin
          CrntTile.South.Tile  := CurrentTileSet.GetRandomSlice(dqCenter);
          if Assigned(tmpSSQuad) then
          begin //Finish square set all to center
            if Assigned(tmpSSQuad) then
               tmpSSQuad.North.Tile  := CurrentTileSet.GetRandomSlice(dqCenter);
            if Assigned(tmpSEQuad) then
               tmpSEQuad.West.Tile  := CurrentTileSet.GetRandomSlice(dqCenter);
            if Assigned(tmpSWQuad) then
               tmpSWQuad.East.Tile  := CurrentTileSet.GetRandomSlice(dqCenter);
          end
          else
          begin
            if Assigned(tmpSEQuad) then
               tmpSEQuad.West.Tile  := CurrentTileSet.GetRandomSlice(dqSW);
            if Assigned(tmpSWQuad) then
               tmpSWQuad.East.Tile  := CurrentTileSet.GetRandomSlice(dqSE);
          end;
     end;
end;

procedure TQuadCollection.ClearAll;
begin
     EmptyTList(QuadList);
     EmptyTList(TileSetList);
     QuadList.clear;
     TileSetList.clear;
end;

{ TQuadTile }

constructor TQuadTile.Create(var TileSet: TTileSet);
begin
    pTileSet := TileSet;
    North.Tile  := pTileSet.GetRandomSlice(dqON);
    South.Tile  := pTileSet.GetRandomSlice(dqOS);
    East.Tile  := pTileSet.GetRandomSlice(dqOE);
    West.Tile  := pTileSet.GetRandomSlice(dqOW);
end;


procedure TQuadTile.reInit(TileSet: TTileSet);
begin
    pTileSet := TileSet;
    North.Tile  := pTileSet.GetRandomSlice(dqON);
    South.Tile  := pTileSet.GetRandomSlice(dqOS);
    East.Tile  := pTileSet.GetRandomSlice(dqOE);
    West.Tile  := pTileSet.GetRandomSlice(dqOW);

end;

procedure TQuadTile.SetPos(x, y: integer);
begin
    self.x := x;
    self.y := y;
    North.x := x ;
    North.y := y-1;
    South.x := x;
    South.y := y+1;
    East.x := x+1;
    East.y := y;
    West.x := x;
    West.y := y;
end;

end.
