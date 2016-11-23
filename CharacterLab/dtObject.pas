unit dtObject;

interface

uses Classes, Graphics, Windows, MyList, dtFuncs,
     LinkedList;

//object definition. Currently used for object master list, and object list.
type
TDTObject = class(TObject)
 constructor Create(AOwner: TObject);
 destructor Destroy; override;
private
    FOwner: TObject;        //TDTObjectList
    FProperties: TMyList;   //list of TDTProperties;
    FX: integer;
    FY: integer;
    //FZ: integer;
    FWidth, FHeight: word;          //store instead of lookup
    FResourceName: string;          //stored instead of looked up
    FImageIndex: integer;
    FObjectIndex: integer;
    FDepthOffset: integer;
    FOldDepthOffset: integer;      //used when editing to save original
    FEditorVisible: boolean;
    FEnabled      : boolean;       //if not in current scene, disabled
    FNameOfClass: string;
    FIsStaticObject: boolean;      //if true, use 16-wide strips to build. If false, use one strip
    FDrawODA: boolean;
    FSelected: boolean;            //is currently selected?
    procedure SetX(const Value: integer);
    procedure SetY(const Value: integer);
    //procedure SetZ(const Value: integer);
    procedure SetObjectIndex(const i: integer);
    procedure SetDepthOffset(const i: integer);
    procedure SetProperty(n: string; v: variant);
    procedure SetLocked(const b: boolean);
    function  GetPropertyName(i: integer): string;
    function  GetPropertyValue(i: integer): variant;
    function  GetPropertyCount: integer;
    function  GetProperty(n: string): Variant;
    function  GetPropertyChanged(n: string): boolean;
    function  GetLocked: boolean;
    function  GetDisplayName: string;
    function  GetDefaultCollisionHeight: integer;
    function  IndexOfProperty(n: string): integer;
protected
    //dont let outsiders change this, only objectlist
    property  EditorVisible: boolean  read FEditorVisible  write FEditorVisible;
    property  Enabled      : boolean  read FEnabled        write FEnabled;
public
    property  X: integer read FX write SetX;
    property  Y: integer read FY write SetY;
    //property  Z: integer read FZ write SetZ;
    property  Width : word read FWidth;            //read only
    property  Height: word read FHeight;           //read only
    property  NameOfClass: string  read FNameOfClass write FNameOfClass;
    property  ObjectIndex: integer read FObjectIndex write SetObjectIndex;          //points to TObjectInfo array
    property  ImageIndex : integer read FImageIndex  write FImageIndex;             //if multi-image tiles (barrel2)
    property  DepthOffset: integer read FDepthOffset write SetDepthOffset;
    property  OldDepthOffset: integer read FOldDepthOffset write FOldDepthOffset;
    property  ResourceName: string read FResourceName;                             //read only
    property  PropertyNames[i: integer]: string read GetPropertyName;             //by index retrieval (in order)
    property  PropertyValues[i: integer]: variant read GetPropertyValue;
    property  Properties[n: string]: Variant read GetProperty write SetProperty;  //by name storage/retrieval
    property  PropertyChanged[n: string]: boolean read GetPropertyChanged;
    property  PropertyCount: integer read GetPropertyCount;
    property  Owner: TObject read FOwner;
    property  IsStaticObject: boolean read FIsStaticObject write FIsStaticObject;
    property  DrawODA : boolean read FDrawODA  write FDrawODA;
    property  Locked  : boolean read GetLocked write SetLocked;
    property  Selected: boolean read FSelected write FSelected;
    property  DisplayName: string read GetDisplayName;              //either GUID or classname
    property  DefaultCollisionHeight: integer read GetDefaultCollisionHeight;
    procedure Assign(o: TDTObject);
    procedure DelProperty(i: integer);
    procedure ClearPropertyChangedFlags;
    procedure ClearProperties;
end;

type
TDTProperty = class(TObject)
    constructor Create;
  private
    FValue : Variant;
    FName  : string;
    FOwner : TObject;   //points to TDTObject;
    FChanged: boolean;
    procedure SetName(const n: string);
    procedure SetValue(const v: variant);
  public
    property  Owner: TObject read FOwner write FOwner;
    property  Name : string  read FName  write SetName;
    property  Value: variant read FValue write SetValue;
    property  Changed: boolean read FChanged write FChanged;
end;

implementation

uses SysUtils, Math, TextFile, string32,
     dtClassManager, dtResource;

constructor TDTObject.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  FX := 0;
  FY := 0;
  //FZ := 0;
  FImageIndex  := 0;
  FObjectIndex := 0;
  FDepthOffset := 0;
  FIsStaticObject := false;
  FEditorVisible  := true;
  FEnabled        := true;
  FSelected       := false;

  FProperties := TMyList.Create;
end;

destructor TDTObject.Destroy;
begin
  FProperties.Free;
  inherited;
end;

procedure TDTObject.Assign(o: TDTObject);
var i: integer;
begin
  x := o.x;
  y := o.y;
  //z := o.z;
  ObjectIndex   := o.ObjectIndex;
  ImageIndex    := o.ImageIndex;
  EditorVisible := o.EditorVisible;
  NameOfClass   := o.NameOfClass;
  DepthOffset   := o.DepthOffset;
  IsStaticObject := o.IsStaticObject;
  DrawODA        := o.DrawODA;

  ClearProperties;
  for i := 0 to o.PropertyCount - 1 do
     Properties[o.PropertyNames[i]] := o.PropertyValues[i];
end;

procedure TDTObject.ClearProperties;
begin FProperties.Blank end;

procedure TDTObject.DelProperty(i: integer);
begin
  if (i < 0) or (i >= FProperties.Count) then exit;
  //TODO: set other vars if deleting
  FProperties.Delete(i);
end;

function  TDTObject.GetPropertyName(i: integer): string;
begin
  result := TDTProperty(FProperties.Items[i]).Name
end;

function  TDTObject.GetPropertyValue(i: integer): variant;
begin
  result := TDTProperty(FProperties.Items[i]).Value
end;

function TDTObject.GetPropertyCount: integer;
begin result := FProperties.Count end;

function TDTObject.IndexOfProperty(n: string): integer;
var i: integer;
    bDone, bFound: boolean;
begin
  result := -1;
  bFound := false;
  i := 0;
  bDone := (i >= FProperties.Count);
  while not (bDone or bFound) do begin
     if StringsEqual(n, TDTProperty(FProperties.Items[i]).Name) then
        bFound := true
     else begin
        inc(i);
        bDone := (i >= FProperties.Count);
     end;
  end;
  if bFound then result := i;
end;

function TDTObject.GetPropertyChanged(n: string): boolean;
var iPos: integer;
begin
  iPos := IndexOfProperty(n);
  if iPos > -1 then
     result := TDTProperty(FProperties.Items[iPos]).Changed
  else
     result := false;
end;

function TDTObject.GetProperty(n: string): Variant;
var iPos: integer;
begin
  iPos := IndexOfProperty(n);
  if iPos > -1 then
     result := TDTProperty(FProperties.Items[iPos]).Value
  else
     result := '';
end;

procedure TDTObject.SetProperty(n: string; v: variant);
var iPos: integer;
    aNew: TDTProperty;
    //cFile: string;
begin
  iPos := IndexOfProperty(n);
  if iPos > -1 then begin
     TDTProperty(FProperties[iPos]).Value := v;
     TDTProperty(FProperties[iPos]).Changed := true;
  end else begin
     //special properties, don't add
     if StringsEqual(n, 'NameOfClass') then begin
        FNameOfClass := v;
        exit;
     end;

     //baseclassancestor not stored in properties. Used for drawing strips
     if StringsEqual(n, 'BaseClassAncestor') then
         IsStaticObject := StringsEqual(v, 'StaticObject');

     //anchor offset: stored in Z now (can remove this test eventually)
     if StringsEqual(n, 'DepthOffSet') then begin
        FDepthOffset := v;
        exit;
     end;

     aNew := TDTProperty.Create;
     aNew.Name := n;
     aNew.Value := v;
     aNew.Owner := self;
     aNew.Changed := true;
     FProperties.Add(aNew)
  end;

  //do work any time set
  //if StringsEqual(n, GIFPROPERTYNAME) then begin
  //   cFile := trim(v);
  //   if cFile <> '' then begin
  //      FResourceName := cFile;
  //      FTileManager.LoadObjectGraphicsData(FResourceName, FObjectIndex);
  //   end;
  //end;
end;

procedure TDTObject.SetX(const Value: integer);
begin
  FX := Value;
end;

procedure TDTObject.SetY(const Value: integer);
begin
  FY := Value;
end;

{procedure TDTObject.SetZ(const Value: integer);
begin
  FZ := Value;
end;}

procedure TDTObject.SetObjectIndex(const i: integer);
begin
  FObjectIndex  := i;
end;

procedure TDTObject.SetDepthOffset(const i: integer);
begin
  FDepthOffset := i;
  if FDepthOffset < 0 then FDepthOffset := 0;
end;

procedure TDTObject.SetLocked(const b: boolean);
var cLock: string;
begin
  cLock := iif(b, 'True', 'False');
  Properties[LOCKPropName] := cLock;
end;

function  TDTObject.GetLocked: boolean;
var cLock: string;
begin
  cLock := Properties[LOCKPropName];
  result := StringsEqual(cLock, 'True');
end;

function  TDTObject.GetDisplayName: string;
begin
  result := trim(Properties[GUIDPRopName]);
  if result = '' then
     result := NameOfClass;
end;

function TDTObject.GetDefaultCollisionHeight: integer;
begin
  result := self.Height;
end;

procedure TDTObject.ClearPropertyChangedFlags;
var i: integer;
begin
  for i := 0 to FProperties.Count - 1 do
     TDTProperty(FProperties[i]).Changed := false;
end;

{ tDTPRoperty }

constructor TDTProperty.Create;
begin
  inherited Create;
  FOwner := nil;
  FName  := '';
  FValue := '';
end;

procedure TDTProperty.SetName(const n: string);
begin
  FName := n;
end;

procedure TDTProperty.SetValue(const v: variant);
begin
  FValue := v;
end;


end.
