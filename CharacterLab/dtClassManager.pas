unit dtClassManager;

//manages the game's class list and properties

interface

uses Classes, Controls, StdCtrls, ComCtrls, SysUtils, MyList, TextFile,
     dtObject, dtProperty, dtResource, dtFuncs, enhlv;

type
  TCustomTypeType = (cttOneOf, cttBitSet);

  //describes a single OneOf or BitSet type
  TCustomTypeDescriptor = class(TObject)
    constructor Create;
    destructor Destroy; override;
   private
    FTypeName: string;
    FType: TCustomTypeType;
    FElements: TStringList;
   public
    property  TypeName: string read FTypeName write FTypeName;
    property  TypeType: TCustomTypeType read FType write FType;      //"typetype", cool. means "the type of this type" (bitset or OneOf)
    procedure AddTypeElement(Elt: string);
    procedure GetChoices(s: TStringList);
  end;

  //manages custom OneOf and BitSet classes,
  TCustomTypeManager = class(TObject)
    constructor Create(AOwner: TObject);
    destructor Destroy; override;
  private
    FOwner: TObject;   //dtClassManager;
    FTypes: TMyList;  //holds TCustomTypeDescriptors
    function GetTypeByName(Name: string): TCustomTypeDescriptor;
  public
    property  Types[Name: string]: TCustomTypeDescriptor read GetTypeByName;
    function  TypeExists(Name: string): boolean;
    procedure ReadTypeFromLine(cLine: string);
  end;

  //describes a single record type. A record is simply a group of regular properties.
  //they reside in the text files in the same format as classes.
  TRecordDescriptor = class(TObject)
    constructor Create;
    destructor Destroy; override;
   private
    FTypeName: string;
    FProps: TPropertyList;
   public
    property  Props: TPropertyList read FProps;
    property  TypeName: string read FTypeName write FTypeName;
    procedure ReadFromLine(cLine: string);        //sets up
    function  AddProperty(oProp: TPropertyDescriptor): boolean;
  end;

  //manages record classes,
  TRecordManager = class(TObject)
    constructor Create(AOwner: TObject);
    destructor Destroy; override;
  private
    FOwner:  TObject;   //tClassManager
    FTypes:  TMyList;  //holds TRecordDescriptors
    function GetTypeName(i: integer): string;
    function GetRecordByName(Name: string): TRecordDescriptor;
  public
    property  Records[Name: string]: TRecordDescriptor read GetRecordByName;
    property  TypeNames[i: integer]: string read GetTypeName;
    function  TypeExists(Name: string): boolean;
    function  AddRecord(oRec: TRecordDescriptor): boolean;
  end;


  TClassManager = class;  //forward declaration

  TClassDescriptor = class(TObject)
    constructor Create(m: TClassManager);
    destructor Destroy; override;
   private
     FIsBase: boolean;
     FTreeNode: TTreeNode;
     FListItem: TListItem;
     FNameOfClass: string;
     FAncestor: TClassDescriptor;
     FAncestorName: string;                 //used ONLY during class building time, use GetAncestorName
     FProps: TPropertyList;
     FDescendants: TMyList;                 //recursive structure
     FResourceManager: TResourceManager;
     FClassManager: TClassManager;          //parent pointer
     FRecordDefs  : TStringList;            //record types are "broken down" on load. This stringlist holds
     function  GetAncestorName: string;      //their original file definition, so it can be written out later
     function  GetDescendantCount: integer;
     function  GetDescendant(i: integer): TClassDescriptor;
     function  GetMasterProperty(Name: string) : TPropertyDescriptor;
     procedure CheckForValidPropertyType(oProp: TPropertyDescriptor);
   protected
   public
     property  Props: TPropertyList read FProps;
     property  Ancestor: TClassDescriptor read FAncestor write FAncestor;
     property  DescendantCount: integer read GetDescendantCount;
     property  MasterProperties[Name: string]     : TPropertyDescriptor read GetMasterProperty;
     property  Descendants[i: integer]: TClassDescriptor read GetDescendant;
     property  AncestorName: string read GetAncestorName;
     property  NameofClass: string read FNameOfClass;
     property  IsBaseClass: boolean read FIsBase;
     property  ClassManager: TClassManager read FClassManager;
     property  ResourceManager: TResourceManager read FResourceManager;
     function  BaseClassAncestor: string;      //inherited from item, weapon, character
     function  DescendsFrom(cAncestor: string): boolean;      //true if class descends from class cAncestor
     procedure GetAllGroupNames(s: TStringList);
     procedure LoadResourceNames(s: TStringList);
     procedure AddDescendant(oClass: TClassDescriptor);
     procedure ReadFromLine(cLine: string);
     function  AddProperty(oProp: TPropertyDescriptor): boolean;        //false if dup
     function  ToDisplayOnlyTreeView(Tree: TTreeView; Parent: TTreeNode): TTreeNode;
     function  ToTreeView(Tree: TTreeView; Parent: TTreeNode; Sort: boolean): TTreeNode;
     function  ToListView(List: TListView; cDir: string): TListItem;
   end;

  //list of classes. Recursive in structure (cool!)
  TClassManager = class(TObject)
    constructor Create;
    destructor Destroy; override;
   private
     FReadOnly: boolean;                       //set to read-only if a duplicate class is found in parsing
                                               //so the duplicate doesn't get erased.
     FChanged: boolean;                        //true if at least one thing changes
     FTypeManager  : TCustomTypeManager;       //see above
     FRecordManager: TRecordManager;           //stores custom record types
     FRootClass    : TClassDescriptor;         //dummy class, points to all others via recursive struc.
     FCurrentClass : TClassDescriptor;         //points to currently selected one
     FTreeView: TTreeView;                     //shown when isclassview
     FListView: TListView;                     //shown when not isclassview
     FIsClassView: boolean;                    //if true, uses treeview. If false, uses folder view.
     FResourceListView: THintListView;             //shows resource-based variants of current class (TResourceManager)
     FCurrentFolder: string;                   //folder-based viewing
     FStatusLabel: TLabel;                     //shows status during parsing
     FImageLabel : TLabel;                     //shows image status during parsing (many images w/i class).
     function   RecursiveFindName(oClass: TClassDescriptor; Name: string): TClassDescriptor;
     function   GetClassByName(Name: string): TClassDescriptor;
     procedure  SetCurrentClass(oClass: TClassDescriptor);
     function   GetRecordByName(Name: string): TRecordDescriptor;
     procedure  SetIsClassView(b: boolean);
     procedure  SetCurrentFolder(s: string);
     procedure  SetResourceListView(lv: THintListView);
     procedure  WarnUserOfReadOnlyStatus;
   public
     property  Changed: boolean read FChanged write FChanged;
     property  IsReadOnly: boolean read FReadOnly;
     property  TreeView: TTreeView read FTreeView write FTreeView;        //this tree shows full class hierarchy
     property  ListView: TListView read FListView write FListView;        //this listview shows folder-based class setup
     property  ResourceListView: THintListView read FResourceListView write SetResourceListView;
     property  StatusLabel: TLabel read FStatusLabel write FStatusLabel;
     property  ImageLabel : TLabel read FImageLabel  write FImageLabel;
     property  Classes[Name: string]: TClassDescriptor  read GetClassByName;
     property  Records[Name: string]: TRecordDescriptor read GetRecordByName;
     property  CurrentClass: TClassDescriptor read FCurrentClass write SetCurrentClass;
     property  TypeManager   : TCustomTypeManager read FTypeManager;
     property  RecordManager : TRecordManager read FRecordManager;
     property  IsClassView : boolean read FIsClassView   write SetIsClassView;
     property  CurrentFolder: string read FCurrentFolder write SetCurrentFolder;
     procedure Clear;
     procedure ParseFile(Filename: string);
     procedure ToTreeView;       //set it all up
     procedure ToListView;
     procedure LoadResourceNames(s: TStringList);
     procedure Instantiate(oObj: TDTObject; NameOfClass: string; iObjectIndex: integer);
  end;



implementation

uses string32, Forms, IniFiles, Dialogs;

{ TCustomTypeDescriptor }

procedure TCustomTypeDescriptor.GetChoices(s: TStringList);
begin
  s.Assign(FElements);
end;

procedure TCustomTypeDescriptor.AddTypeElement(Elt: string);
begin
  if FElements.IndexOf(Elt) = -1 then
     FElements.Add(Elt);
end;

constructor TCustomTypeDescriptor.Create;
begin
  inherited;
  FElements := TStringList.Create;
end;

destructor TCustomTypeDescriptor.Destroy;
begin
  FElements.Free;
  inherited;
end;

{ TCustomTypeManager }

constructor TCustomTypeManager.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  FTypes := TMyList.Create;
end;

destructor TCustomTypeManager.Destroy;
begin
  FTypes.Free;
  inherited;
end;

function TCustomTypeManager.TypeExists(Name: string): boolean;
var i: integer;
    oType: TCustomTypeDescriptor;
begin
  result := false;
  for i := 0 to FTypes.Count - 1 do begin
     oType := TCustomTypeDescriptor(FTypes.Items[i]);
     if StringsEqual(oType.TypeName, Name) then begin
        result := true;
        exit;
     end;
  end;
end;

function TCustomTypeManager.GetTypeByName(Name: string): TCustomTypeDescriptor;
var i: integer;
    oType: TCustomTypeDescriptor;
begin
  result := nil;
  for i := 0 to FTypes.Count - 1 do begin
     oType := TCustomTypeDescriptor(FTypes.Items[i]);
     if StringsEqual(oType.TypeName, Name) then begin
        result := oType;
        exit;
     end;
  end;
end;

procedure TCustomTypeManager.ReadTypeFromLine(cLine: string);
var cWholeLine: string;
    cWord: string;
    cName: string;
    cType: string;
    cElts: string;
    oType : TCustomTypeDescriptor;
begin
   cWholeLine := cLine;
   cWord := ParseString(cLine, ' ');  //already know should be 'type'
   cName := ParseString(cLine, '=');  //name of type
   if cName = '' then begin
      tLog.WriteLogEntry('Error: invalid Type description line (equal sign not found). Text of line follows:');
      tLog.WriteLogEntry(cWholeLine);
      TClassManager(FOwner).WarnUserOfReadOnlyStatus;
      exit;
   end;
   if TypeExists(cName) then begin
      tLog.WriteLogEntry('Error: invalid Type description line (type already exists). Text of line follows:');
      tLog.WriteLogEntry(cWholeLine);
      TClassManager(FOwner).WarnUserOfReadOnlyStatus;
      exit;
   end;

   cType := ParseString(cLine, '(');
   if not (StringsEqual(cType, 'BitSet') or StringsEqual(cType, 'OneOf')) then begin
      tLog.WriteLogEntry('Error: invalid Type description line (not OneOf or BitSet). Text of line follows:');
      tLog.WriteLogEntry(cWholeLine);
      TClassManager(FOwner).WarnUserOfReadOnlyStatus;
      exit;
   end;

   cElts := ParseString(cLine, ')');
   if cElts = '' then begin
      tLog.WriteLogEntry('Error: invalid Type description line (right paren not found). Text of line follows:');
      tLog.WriteLogEntry(cWholeLine);
      TClassManager(FOwner).WarnUserOfReadOnlyStatus;
      exit;
   end;

   tLog.WriteLogEntry('adding custom type ' + cName);
   oType := TCustomTypeDescriptor.Create;
   oType.TypeName := cName;
   oType.TypeType := iif(StringsEqual(cType, 'BitSet'), cttBitSet, cttOneOf);
   while cElts <> '' do begin
      cWord := ParseString(cElts, ',');
      if cWord <> '' then oType.AddTypeElement(cWord);
   end;
   FTypes.Add(oType);
end;


constructor TRecordDescriptor.Create;
begin
  inherited;
  FProps := TPropertyList.Create(self);
end;


destructor TRecordDescriptor.Destroy;
begin
  FProps.Free;
  inherited;
end;

procedure TRecordDescriptor.ReadFromLine(cLine: string);
var cWord: string;
begin
  cWord := ParseString(cLine, ' ');
  FTypeName := ParseString(cLine, ' ');
end;

function TRecordDescriptor.AddProperty(oProp: TPropertyDescriptor): boolean;
begin
  oProp.Group := '';                  //no groups in prop names allowed
  oProp.Parent := self;
  result := FProps.AddProperty(oProp);
end;

constructor TRecordManager.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  FTypes := TMyList.Create;
end;

destructor TRecordManager.Destroy;
begin
  FTypes.Free;
  inherited;
end;

function TRecordManager.GetTypeName(i: integer): string;
begin
  result := TRecordDescriptor(FTypes.Items[i]).TypeName;
end;

function TRecordManager.GetRecordByName(Name: string): TRecordDescriptor;
var bDone, bFound: boolean;
    i: integer;
    oRec: TRecordDescriptor;
begin
  result := nil;
  i := 0;
  bFound := false;
  bDone := (i >= FTypes.Count);
  while not (bDone or bFound) do begin
     oRec := TRecordDescriptor(FTypes.Items[i]);
     if StringsEqual(oRec.TypeName, Name) then begin
        bFound := true;
        result := oRec;
     end else begin
        inc(i);
        bDone := (i >= FTypes.Count);
     end;
  end;
end;


function TRecordManager.TypeExists(Name: string): boolean;
var bDone, bFound: boolean;
    i: integer;
    oRec: TRecordDescriptor;
begin
  i := 0;
  bFound := false;
  bDone := (i >= FTypes.Count);
  while not (bDone or bFound) do begin
     oRec := TRecordDescriptor(FTypes.Items[i]);
     if StringsEqual(oRec.TypeName, Name) then
        bFound := true
     else begin
        inc(i);
        bDone := (i >= FTypes.Count);
     end;
  end;
  result := bFound
end;

function TRecordManager.AddRecord(oRec: TRecordDescriptor): boolean;
begin
  result := false;
  if TypeExists(oRec.TypeName) then begin
     tLog.WriteLogEntry('Error: attempt to duplicate record type ' + oRec.TypeName);
     TClassManager(FOwner).WarnUserOfReadOnlyStatus;
  end else begin
     result := true;
     FTypes.Add(oRec);
     tLog.WriteLogEntry('adding record type ' + oRec.Typename);
  end;
end;

{ TClassDescriptor }

constructor TClassDescriptor.Create(m: TClassManager);
begin
 inherited Create;
 FClassManager    := m;
 //FObjectIndex     := -1;
 FIsBase          := false;
 FAncestor        := nil;
 FTreeNode        := nil;
 FListItem        := nil;
 FRecordDefs      := TStringList.Create;
 FProps           := TPropertyList.Create(self);
 FDescendants     := TMyList.Create;
 //FMissingResource := false;
 FResourceManager := TResourceManager.Create;
end;

destructor TClassDescriptor.Destroy;
begin
  FResourceManager.Free;
  FProps.Free;
  FDescendants.Free;
  FRecordDefs.Free;
  inherited;
end;

function TClassDescriptor.GetDescendantCount: integer;
begin result := FDescendants.Count end;

function TClassDescriptor.GetDescendant(i: integer): TClassDescriptor;
begin
  result := TClassDescriptor(FDescendants.Items[i])
end;

//goes up the tree until it finds given property
function TClassDescriptor.GetMasterProperty(Name: string) : TPropertyDescriptor;
var bDone, bFound: boolean;
    oClass: TClassDescriptor;
    oProp : TPropertyDescriptor;
begin
  oProp  := nil;
  bFound := false;
  bDone  := false;
  oClass := self;
  while not (bDone or bFound) do begin
     oProp := oClass.Props.Properties[Name];
     if oProp <> nil then
        bFound := true
     else begin
        oClass := oClass.Ancestor;
        bDone := (oClass = nil);
     end;
  end;

  if bFound then
     result := oProp
  else
     result := nil;
end;


procedure TClassDescriptor.AddDescendant(oClass: TClassDescriptor);
begin
  oClass.Ancestor := self;

  //if not oClass.Props.PropertyExists(GIFPROPERTYNAME) then begin
  //   oClass.FObjectIndex  := self.FObjectIndex;         //inherit property info
  //   oClass.FResourceName := self.FResourceName;
  //end;
  FDescendants.Add(oClass)
end;

//format class|Baseclass <name> inherits <fromclass>
procedure TClassDescriptor.ReadFromLine(cLine: string);
var cWord: string;
begin
  cWord := ParseString(cLine, ' ');
  FIsBase := StringsEqual(cWord, BASECLASSID);
  FNameOfClass := ParseString(cLine, ' ');

  if cLine <> '' then begin              //inheritance info
     cWord := ParseString(cLine, ' ');   //next word s.b. 'extends', dont bother to check, though
     FAncestorName := ParseString(cLine, ' ');
  end;

  if (FAncestorName = '') then
     FAncestorName := ROOTCLASSNAME;

end;

procedure TClassDescriptor.LoadResourceNames(s: TStringList);
var i: integer;
begin
  FResourceManager.LoadResourceNames(s);
  for i := 0 to FDescendants.Count - 1 do
     Descendants[i].LoadResourceNames(s);
end;

//makes sure it knows what kind of property this is
procedure TClassDescriptor.CheckForValidPropertyType(oProp: TPropertyDescriptor);
var bOk: boolean;
    t: string;
begin
  bOk := false;
  t := oProp.PropertyType;
  if IsABasePropertyType(t) then
     bOk := true
  else begin
     if FClassManager.FRecordManager.TypeExists(t) then bOk := true
     else if FClassManager.FTypeManager.TypeExists(t) then bOk := true
  end;

  if not bOk then begin
     tLog.WriteLogEntry('Error: type ' + t + ' not found, defaulting to string');
     oProp.PropertyType := 'string';
  end;
end;

function TClassDescriptor.AddProperty(oProp: TPropertyDescriptor): boolean;
var oRec: TRecordDescriptor;
    j: integer;
    rProp: TPropertyDescriptor;
begin
  result := false;
  oProp.Parent := self;                          //need for checking record types
  if oProp.IsRecordtype then begin               //take record types and break them down on load
     //save the original definition to a stringlist, for writing out later.
     FRecordDefs.Add(oProp.Name + ' ' + oProp.PropertyType);
     oRec  := FClassManager.RecordManager.Records[oProp.PropertyType];
     for j := 0 to oRec.Props.PropertyCount - 1 do begin
        rProp := TPropertyDescriptor.Create;
        rProp.Assign(oRec.Props.PropertiesByIndex[j]);
        rProp.OriginalClass := oProp.PropertyType;      //save this for lookup on writeout
        rProp.Group := oProp.Name + '.';
        if Props.AddProperty(rProp) then
           rProp.Parent := self;
     end;

  end else begin
    if Props.AddProperty(oProp) then begin
       if trim(oProp.Group) = '' then
          oProp.Group := FNameOfClass;

       CheckForValidPropertyType(oProp);

       {if StringsEqual(oProp.Name, GIFPROPERTYNAME) then begin
          cFile := trim(oProp.DefaultValue);
          if cFile <> '' then begin
             FTileManager.LoadObjectGraphicsData(cFile, FResourceName, FObjectIndex);
             FMissingResource := (FObjectIndex = -1);
          end;
       end;}
       result := true;
    end;
  end;
end;

function TClassDescriptor.GetAncestorName: string;
begin
  if FAncestor = nil then
     result := ''
  else
     result := FAncestor.NameOfClass;
end;

//makes sure there is a ResourceGIF property at or above this one.
//You cannot inherit off a class AND use its resource if it doesn't have one!
{function TClassDescriptor.ResourceExistsUpTheTree: boolean;
var bDone, bFound: boolean;
    oClass: TClassDescriptor;
    cName: string;
begin
  bFound := false;
  bDone  := false;
  oClass := self;
  while not (bDone or bFound) do begin
     cName := oClass.Props.PropertyDefaultValues[GIFPROPERTYNAME];
     if cName <> '' then
        bFound := true
     else begin
        oClass := oClass.Ancestor;
        bDone := (oClass = nil);
     end;
  end;
  result := bFound;
end;}

//also gets record types as group names.
procedure TClassDescriptor.GetAllGroupNames(s: TStringList);
var bDone: boolean;
    oClass: TClassDescriptor;
    oProp: TPropertyDescriptor;
    i, iPos: integer;
    cGroup: string;
begin
  bDone  := false;
  oClass := self;
  while not bDone do begin
     for i := 0 to oClass.Props.PropertyCount - 1 do begin
        oProp := oClass.Props.PropertiesByIndex[i];
        cGroup := oProp.Group;     //resolves record header

        iPos := s.IndexOf(cGroup);
        if iPos = -1 then
           s.Add(cGroup);
     end;

     oClass := oClass.Ancestor;
     bDone := (oClass = nil);
  end;

  s.Sort;
end;

function TClassDescriptor.BaseClassAncestor: string;
var bDone, bFound: boolean;
    oClass: TClassDescriptor;
begin
  bFound := false;
  bDone  := false;
  oClass := self;
  while not (bDone or bFound) do begin
     if oClass.IsBaseClass then
        bFound := true
     else begin
        oClass := oClass.Ancestor;
        bDone := (oClass = nil);
     end;
  end;

  assert(bFound, 'BaseClass Ancestor not found for ' + self.NameOfClass);
  result := oClass.NameOfClass;
end;


function  TClassDescriptor.DescendsFrom(cAncestor: string): boolean;      //true if class descends from class cAncestor
var bDone, bFound: boolean;
    oClass: TClassDescriptor;
begin
  bFound := false;
  bDone  := false;
  oClass := self;
  while not (bDone or bFound) do begin
     if StringsEqual(oClass.NameOfClass, cAncestor) then
        bFound := true
     else begin
        oClass := oClass.Ancestor;
        bDone := (oClass = nil);
     end;
  end;

  result := bFound;
end;


//doesn't use internal pointers
function  TClassDescriptor.ToDisplayOnlyTreeView(Tree: TTreeView; Parent: TTreeNode): TTreeNode;
var i: integer;
    FNode: TTreeNode;
begin
  FNode := Tree.Items.AddChildObject(Parent, self.NameOfClass, self);
  with FNode do begin
     if IsBaseClass then begin
        ImageIndex    := 15;
        SelectedIndex := 16;
     end else begin
        ImageIndex    := 13;
        SelectedIndex := 13;
     end;
  end;

  for i := 0 to DescendantCount - 1 do
     Descendants[i].ToTreeView(Tree, FNode, False);

  result := FNode;
end;


function TClassDescriptor.ToTreeView(Tree: TTreeView; Parent: TTreeNode; Sort: boolean): TTreeNode;
var i: integer;
begin
  //Tree.Items.BeginUpdate;

  FTreeNode := Tree.Items.AddChildObject(Parent, self.NameOfClass, self);
  with FTreeNode do begin
     if IsBaseClass then begin
        ImageIndex    := 15;
        SelectedIndex := 16;
     end else begin
        ImageIndex    := 13;
        SelectedIndex := 13;
     end;
  end;

  for i := 0 to DescendantCount - 1 do
     Descendants[i].ToTreeView(Tree, FTreeNode, False);

  FTreeNode.Collapse(false);
  result := FTreeNode;

  //if Sort then Parent.AlphaSort;
  //Tree.Items.EndUpdate;
end;

function TClassDescriptor.ToListView(List: TListView; cDir: string): TListItem;
//var i: integer;
//    cPath: string;
begin
  //TODO: dual mode ListView support w/ new class structure
  {if FResourceName <> '' then begin
    cPath := ResourceNameToPath(fMain.pDefaultResourceFolder, FResourceName);
    if StringsEqual(cPath, cDir) then begin
       FListItem := List.Items.Add;
       with FListItem do begin
          Caption    := FNameOfClass;
          ImageIndex := iif(IsBaseClass, 14, 13);
          Data       := self;
          //SelectedIndex := ImageIndex;
       end;
    end;
  end;

  for i := 0 to DescendantCount - 1 do
     Descendants[i].ToListView(List, cDir);

  result := FListItem;
  }
  result := nil
end;

{ TClassManager }

constructor TClassManager.Create;
begin
  inherited;
  FIsClassView   := true;       //default to treeview based view
  FRecordManager := nil;
  FTypeManager   := nil;
  FRootClass     := nil;
  FStatusLabel   := nil;
  FImageLabel    := nil;
  FChanged       := false;
  FReadOnly      := false;
  Clear;
end;

destructor TClassManager.Destroy;
begin
  FRootClass.Free;
  FTypeManager.Free;
  FRecordManager.Free;
  inherited;
end;

procedure TClassManager.Clear;
begin
  if FRootClass     <> nil then FRootClass.Free;
  if FTypeManager   <> nil then FTypeManager.Free;
  if FRecordManager <> nil then FRecordManager.Free;

  FRootClass              := TClassDescriptor.Create(self);
  FRootClass.FNameofClass := ROOTCLASSNAME;
  FRootClass.FIsBase      := true;
  FTypeManager   := TCustomTypeManager.Create(self);
  FRecordManager := TRecordManager.Create(self);
end;

function TClassManager.RecursiveFindName(oClass: TClassDescriptor; Name: string): TClassDescriptor;
var i: integer;
begin
  result := nil;
  if StringsEqual(oClass.NameofClass, Name) then
     result := oClass
  else begin
     for i := 0 to oClass.DescendantCount-1 do begin
        result := RecursiveFindName(oClass.Descendants[i], Name);
        if result <> nil then exit;
     end;
  end;
end;

function TClassManager.GetRecordByName(Name: string): TRecordDescriptor;
begin
  result := FRecordManager.Records[Name];
end;

function TClassManager.GetClassByName(Name: string): TClassDescriptor;
begin result := RecursiveFindName(FRootClass, Name) end;

procedure TClassManager.WarnUserOfReadOnlyStatus;
var cMsg: string;
begin
  if not FReadOnly then begin
     cMsg := 'Critical Errors were found parsing class text files.' + #13;
     cMsg := cMsg + 'Class creation will be disabled during this Chapted' + #13;
     cMsg := cMsg + 'session until the problems can be corrected.'+ #13;
     cMsg := cMsg + '(See Chapted Log for details)';
     MessageDlg(cMsg, mtError, [mbOk], 0);
  end;
  FReadOnly := true;
end;

procedure TClassManager.ParseFile(Filename: string);
var tIn: TTextFileReader;
    cLine: string;
    cMsg: string;
    oClass, oAncestor, oTemp: TClassDescriptor;
    bInClassDef: boolean;
    bInGIFDefs: boolean;
    bInRecord: boolean;
    oProp: TPropertyDescriptor;
    oRecord: TRecordDescriptor;
    iPos: integer;
begin
   oClass  := nil;
   oRecord := nil;
   bInClassDef := false;
   bInRecord   := false;
   bInGIFDefs  := false;
   tIn := TTextFileReader.Create(Filename);
   while not tIn.eof do begin
     cLine := trim(tIn.ReadLine);
     iPos := Instr(cLine, ';');
     if iPos > 0 then                          //strip comments
        cLine := trim(leftstr(cLine, iPos-1));

     if bInClassDef then begin
        if StringsEqual(leftstr(cLine, 8), 'StartGIF') then begin
           bInGIFDefs := true;
        end else
        if bInGIFDefs and StringsEqual(leftstr(cLine, 6), 'EndGIF') then begin
           bInGIFDefs := false
        end else
        if bInGIFDefs then begin
           //GIF file specification. Load it
           FImageLabel.Caption := 'adding resource ' + cLine;
           application.processmessages;
           oClass.ResourceManager.AddResource(cLine);
        end else
        if StringsEqual(leftstr(cLine, 8), 'EndClass') then begin
           bInClassDef := false;

           oTemp := Classes[oClass.NameOfClass];
           if oTemp <> nil then begin      //ignore class if it already exists
              cMsg := '***Critical Error: attempt to duplicate class ' + oClass.NameOfClass;
              cMsg := cMsg + ', ignoring second instance';
              tLog.WriteLogEntry(cMsg);
              WarnUserOfReadOnlyStatus;
              oClass.Free;
           end else begin
              {if oClass.MissingResource then begin
                 cMsg := 'Error: Class ' + oClass.FNameOfClass + ' not loaded, resource specified but not found';
                 tLog.WriteLogEntry(cMsg);
                 oClass.Free;
              end else begin}
                oAncestor := Classes[oClass.FAncestorName];  //note, don't use prop, use temp private var
                if oAncestor = nil then begin
                   cMsg := '***Critical Error: Ancestor Class ' + oClass.FAncestorName;
                   cMsg := cMsg + ' for class ' + oClass.NameOfClass;
                   cMsg := cMsg + ' not found, cannot add';
                   tLog.WriteLogEntry(cMsg);
                   WarnUserOfReadOnlyStatus;
                   FReadOnly := true;

                   oClass.Free;
                end else begin
                   cMsg := 'Adding Class ' + oClass.NameOfClass;
                   tLog.WriteLogEntry(cMsg);
                   oAncestor.AddDescendant(oClass);
                end;
              //end;
           end;
        end else begin    //assume a property and add it
           oProp := TPropertyDescriptor.Create;
           oProp.ReadFromLine(cLine);
           if not oClass.AddProperty(oProp) then
              oProp.Free;
        end;
     end else if bInRecord then begin
        if StringsEqual(leftstr(cLine, 7), 'EndType') then begin
           bInRecord := false;
           if not FRecordManager.AddRecord(oRecord) then
              oRecord.Free;
        end else begin
           oProp := TPropertyDescriptor.Create;
           oProp.ReadFromLine(cLine);
           if not oRecord.AddProperty(oProp) then
              oProp.Free;
        end;
     end else begin
        //found start of class def
        //if instr(cLine, 'Sundry') > 0 then
        //   bInRecord := bInRecord;

        if ( StringsEqual(leftstr(cLine, 5), 'Class') or
           ( StringsEqual(leftstr(cLine, length(BASECLASSID)), BASECLASSID))) then begin
           oClass := TClassDescriptor.Create(self);
           oClass.ReadFromLine(cLine);
           bInClassDef := true;
           if FStatusLabel <> nil then begin
              FStatusLabel.Caption := 'parsing class ' + oClass.NameOfClass;
              FImageLabel.Caption := '';
              application.processmessages;
           end;

        end else if StringsEqual(leftstr(cLine, 4), 'Type') then begin
           FTypeManager.ReadTypeFromLine(cLine);
        end else if StringsEqual(leftstr(cLine, length(RECORDID)), RECORDID) then begin
           oRecord := TRecordDescriptor.Create;
           oRecord.ReadFromLine(cLine);
           bInRecord := true;
        end;
     end;
   end;
   tIn.Free;
end;

procedure TClassManager.Instantiate(oObj: TDTObject; NameOfClass: string; iObjectIndex: integer);
var oClass: TClassDescriptor;
    oFirstClass: TClassDescriptor;
    oProp : TPropertyDescriptor;
    oRD: TResourceDescriptor;
    i: integer;
    cValue: string;
    cNewValue: string;
begin
  oClass := Classes[NameOfClass];
  oFirstClass := oClass;           //save the one w/ all the resources in it.
  assert(oClass <> nil, 'Instantiate could not find class ' + NameOfClass);

  oObj.NameOfClass := oClass.NameOfClass;
  oObj.ObjectIndex := iObjectIndex;         //this will set resource name
  oObj.IsStaticObject := StringsEqual(oClass.BaseClassAncestor, 'StaticObject');

  //load property defaults recursively
  oObj.ClearProperties;

  //travel up the class hierarchy. Add all properties not already there (overridden)
  while oClass <> nil do begin
     for i := 0 to oClass.Props.PropertyCount - 1 do begin
        oProp := oClass.Props.PropertiesByIndex[i];
        assert(not oProp.IsRecordType, 'should never be record types by here');

        cNewValue := oProp.DefaultValue;
        if StringsEqual(oProp.Group, 'ini.') then begin

           oRD := oFirstClass.ResourceManager.ResourcesByName[oObj.ResourceName];
           if oRD <> nil then
              cNewValue := oRD.DefaultIniValues[oProp.NameOnly];

           if cNewValue = '' then cNewValue := oProp.DefaultValue;
        end;


        cValue := trim(oObj.Properties[oProp.Name]);
        if cValue = '' then        //dont override if already defined;
           oObj.Properties[oProp.Name] := cNewValue
     end;
     oClass := oClass.Ancestor;
  end;
end;

procedure TClassManager.ToTreeView;
var SaveProc: TTVChangedEvent;
    FRoot: TTreeNode;
begin
  if FTreeview = nil then exit;
  screen.cursor := crHourGlass;
  FTreeView.Items.BeginUpdate;
  SaveProc := FTreeView.OnChange;       //don't process changes
  FRoot := nil;  //compiler shut up

  try
     FTreeView.OnChange := nil;
     FTreeView.Selected := nil;
     FTreeView.Items.Clear;

     FRoot := FRootClass.ToTreeView(FTreeView, nil, True);
     FRoot.ImageIndex    := 15;
     FRoot.SelectedIndex := 16;

  finally
     with FTreeView do begin
        FTreeView.AlphaSort;
        if FRoot <> nil then FRoot.Expanded := true;
        OnChange := SaveProc;
        Selected := FRoot;
        TopItem  := FRoot;
        Items.EndUpdate;
     end;

     screen.cursor := crDefault;
  end;
end;

procedure TClassManager.LoadResourceNames(s: TStringList);
begin FRootClass.LoadResourceNames(s) end;

procedure TClassManager.ToListView;
var SaveProc: TLVChangeEvent;
begin
  screen.cursor := crHourGlass;
  FListView.Items.BeginUpdate;
  SaveProc := FListView.OnChange;       //don't process changes

  try
     FListView.OnChange := nil;
     FListView.Selected := nil;
     FListView.Items.Clear;

     FRootClass.ToListView(FListView, FCurrentFolder);

  finally
     with FListView do begin
        FListView.AlphaSort;
        OnChange := SaveProc;
        if Items.Count > 0 then
           Selected := Items[0];
        Items.EndUpdate;
     end;

     screen.cursor := crDefault;
  end;
end;

procedure TClassManager.SetCurrentClass(oClass: TClassDescriptor);
begin
  FCurrentClass := oClass;
end;

procedure TClassManager.SetIsClassView(b: boolean);
begin
  FIsClassView := b;
end;

procedure TClassManager.SetResourceListView(lv: THintListView);
begin
  FResourceListView := lv;
end;

procedure TClassManager.SetCurrentFolder(s: string);
begin
  s := AddRightSlash(s);
  FCurrentFolder := s;
  ToListView;
end;

end.
