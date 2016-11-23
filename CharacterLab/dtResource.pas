unit dtResource;

interface

uses Classes, Controls, ComCtrls,SysUtils, MyList;

type

  //classes can be identical except for their display (internally, a crate can be the same as
  //a barrel can be the same as a wall fragment).
  TResourceDescriptor = class(TObject)
    constructor Create;
    destructor Destroy; override;
   private
    FResourceName: string;
    FObjectIndex: integer;      //pointer to FTileManager
    FIniEntries: TStringList;   //sucked entries out of INI file, for Ini. properties
    function GetDefaultIniValue(s: string): string;
   public
    property ResourceName: string  read FResourceName write FResourceName;
    property ObjectIndex:  integer read FObjectIndex  write FObjectIndex;
    property DefaultIniValues[s: string]: string read GetDefaultIniValue;
  end;

  //used by each TClassDescriptor
  TResourceManager = class(TObject)
    constructor Create;
    destructor Destroy; override;
  private
    FResources: TMyList;                 //holds TResourceDescriptors
    FCurrentResourceName: string;
    FCurrentObjectIndex: integer;
    function GetResourceCount: integer;
    function GetResourceName(i: integer): string;
    function GetResource(i: integer): TResourceDescriptor;
    function GetResourceByName(s: string): TResourceDescriptor;
  public
    property ResourceCount: integer read GetResourceCount;
    property CurrentResourceName: string  read FCurrentResourceName write FCurrentResourceName;
    property CurrentObjectIndex : integer read FCurrentObjectIndex  write FCurrentObjectIndex;
    property ResourceNames[i: integer]: string read GetResourceName;
    property Resources[i: integer]: TResourceDescriptor read GetResource;
    property ResourcesByName[s: string]: TResourceDescriptor read GetResourceByName;
    procedure AddResource(cResourceName: string);
    procedure LoadResourceNames(s: TStringList);
    procedure ToListView(FListView: TListView);
    function  ResourceExists(cResourceName: string): boolean;
    function  ResourceIndexByName(cResourceName: string): integer;
    function  RemoveCurrentResource: boolean;
  end;


implementation

uses TextFile, string32;

constructor TResourceDescriptor.Create;
begin
  inherited;
  FIniEntries := TStringList.Create;
end;

destructor TResourceDescriptor.Destroy;
begin
  FIniEntries.Free;
  inherited;
end;

function TResourceDescriptor.GetDefaultIniValue(s: string): string;
begin
  result := FIniEntries.Values[s];
end;


{ TResourceManager }

constructor TResourceManager.Create;
begin
  inherited;
  FResources := TMyList.Create;
  FCurrentResourceName := '';
end;

destructor TResourceManager.Destroy;
begin
  FResources.Free;
  inherited;
end;

procedure TResourceManager.AddResource(cResourceName: string);
var oRD: TResourceDescriptor;
begin
  if not ResourceExists(cResourceName) then begin
     oRD := TResourceDescriptor.Create;
     oRD.ResourceName := cResourceName;
     //oRD.ObjectIndex  := iObjectIndex;
     //oRD.FIniEntries.Assign(aList);
     FResources.Add(oRD);
  end else
     tLog.WriteLogEntry('Warning: Attempt to load duplicate resource ' + cResourceName + ' into class')
end;

procedure TResourceManager.LoadResourceNames(s: TStringList);
var i: integer;
begin
  for i := 0 to FResources.Count - 1 do
     s.Add(ResourceNames[i]);
end;

procedure TResourceManager.ToListView(FListView: TListView);
var i: integer;
    FListItem: TListItem;
    SaveProc: TLVChangeEvent;
    oRD: TResourceDescriptor;
begin
  FListView.Items.BeginUpdate;
  SaveProc := FListView.OnChange;       //don't process changes

  try
     FListView.OnChange := nil;
     FListView.Selected := nil;
     FListView.Items.Clear;

     for i := 0 to FResources.Count - 1 do begin
        oRD := Resources[i];
        FListItem := FListView.Items.Add;
        with FListItem do begin
           Caption    := ExtractFileName(oRD.ResourceName);
           ImageIndex := -1;
           Data       := oRD;
        end;
     end;
  finally
     with FListView do begin
        FListView.AlphaSort;
        OnChange := SaveProc;
        if Items.Count > 0 then
           Selected := Items[0]
        else begin
           //force call
           if Assigned(FListView.OnChange) then
              FListView.OnChange(nil, nil, ctState);
        end;
        Items.EndUpdate;
     end;
  end;
end;

function TResourceManager.GetResourceCount: integer;
begin result := FResources.Count end;

function TResourceManager.ResourceExists(cResourceName: string): boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to FResources.Count - 1 do begin
     if StringsEqual(Resources[i].ResourceName, cResourceName) then begin
        result := true;
        exit;
     end;
  end;
end;

function TResourceManager.ResourceIndexByName(cResourceName: string): integer;
var
  oRD: TResourceDescriptor;
  i: integer;
begin
  result := -1;
  for i := 0 to FResources.Count - 1 do begin
     oRD := TResourceDescriptor(FResources.Items[i]);
     if oRD.ResourceName = cResourceName then begin
        result := i;
        exit;
     end;
  end;
end;


function TResourceManager.RemoveCurrentResource: boolean;
var iPos: integer;
begin
  result := false;
  if FCurrentResourceName = '' then exit;
  iPos := ResourceIndexByName(FCurrentResourceName);
  if iPos <> -1 then begin
     FResources.Delete(iPos);
     result := true;
  end;
end;

function TResourceManager.GetResourceName(i: integer): string;
begin result := Resources[i].ResourceName end;

function TResourceManager.GetResource(i: integer): TResourceDescriptor;
begin result := TResourceDescriptor(FResources.Items[i]) end;

function TResourceManager.GetResourceByName(s: string): TResourceDescriptor;
var iPos: integer;
begin
  iPos := ResourceIndexByName(FCurrentResourceName);
  if iPos <> -1 then
     result := Resources[iPos]
  else
     result := nil;
end;

end.
