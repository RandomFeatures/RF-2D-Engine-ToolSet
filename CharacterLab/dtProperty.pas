unit dtProperty;

interface

uses Classes, MyList, dtFuncs, TextFile;

  //describes a property in a CLASS. Object properties use a different structure (in dtObject.PAS)
type
  TPropertyDescriptor = class(TObject)
    constructor Create;
  private
     FParent: TObject;       
     FName: string;          //will be unique among all properties.
     FType: string;          //should be int, str, oneof, color. Err if not
     FGroup: string;
     FRangeLower: single;
     FRangeUpper: single;
     FDefault   : string;
     FRangeDefined: boolean;
     FDefaultDefined: boolean;
     FOriginalClass: string;                //for record types, name of record type tied to
     FShowWhen: string;                     //properties can hide based on values of other properties. Yuck.
     FbConditional: boolean;                //this property is shown conditionally
     FbConditionalExact: boolean;           //if true, exact match
     FConditionalPropName: string;          //name of prop to test condition
     FConditionalString: string;            //property value to test (exact or instr)
     procedure SetName(const s: string);
     procedure SetType(const s: string);
     procedure SetRangeLower(const i: single);
     procedure SetRangeUpper(const i: single);
     procedure SetDefault(const v: string);
     procedure SetGroup(const g: string);
     procedure SetShowWhen(const s: string);
     procedure CheckForValidDefault;
     function  GetName: string;
     function  GetGroup: string;
     function  GetIsRecordType: boolean;
     function  ParseRange(cLine: string): string;
     function  ParseDefault(cLine: string): string;
     function  ParseWhen(cLine: string): string;
     procedure ParseGeneric(cLine, cOperator: string; var cValue, cRemaining: string);
   public
     property Name          : string  read GetName         write SetName;    //builds group. for records
     property NameOnly      : string  read FName;                            //no group considered
     property Group         : string  read GetGroup        write SetGroup;
     property OriginalClass : string  read FOriginalClass  write FOriginalClass;
     property PropertyType  : string  read FType           write SetType;
     property RangeLower    : single  read FRangeLower     write SetRangeLower;
     property RangeUpper    : single  read FRangeUpper     write SetRangeUpper;
     property RangeDefined  : boolean read FRangeDefined   write FRangeDefined;
     property DefaultValue  : string read FDefault         write SetDefault;
     property DefaultDefined: boolean read FDefaultDefined write FDefaultDefined;
     property IsRecordType  : boolean read GetIsRecordType;
     //properties can be hidden conditionally
     property ShowWhen            : string  read FShowWhen write SetShowWhen;
     property bConditional        : boolean read FbConditional write FbConditional;
     property bConditionalExact   : boolean read FbConditionalExact;
     property ConditionalPropName : string read FConditionalPropName;
     property ConditionalString   : string read FConditionalString;
     property Parent        : TObject read FParent         write FParent;
     procedure ReadFromLine(cLine: string);
     procedure Assign(oProp: TPropertyDescriptor);
     procedure ExportToTextFile(tOut: TTextFileWriter);
  end;

  //controls a list of properties
  TPropertyList = class(TObject)
    constructor Create(o: TObject);
    destructor Destroy; override;
   private
     FParent: TObject;
     FProperties: TMyList;
     function GetPropertyCount: integer;
     function GetPropertyByIndex(i: integer): TPropertyDescriptor;
     function GetProperty(Name: string)     : TPropertyDescriptor;
     function GetPropertyDefaultValue(Name: string): string;
   public
     property  PropertyCount  : integer read GetPropertyCount;
     property  PropertiesByIndex[i: integer]: TPropertyDescriptor read GetPropertyByIndex;
     property  Properties[Name: string]     : TPropertyDescriptor read GetProperty;
     property  PropertyDefaultValues[Name: string]: string read GetPropertyDefaultValue;
     function  PropertyExists(Name: string): boolean;
     function  AddProperty(oProp: TPropertyDescriptor): boolean;        //false if dup
     procedure DeleteProperty(cPropName: string);
     procedure ExportToTextFile(tOut: TTextFileWriter);
  end;

  function IsABasePropertyType(t: string): boolean;

//properties of an object instance. DIFFERENT than properties of a class
implementation

uses SysUtils, string32, dtClassManager;

function IsABasePropertyType(t: string): boolean;
begin
  result :=
     StringsEqual(t, 'int') or
     StringsEqual(t, 'integer') or
     StringsEqual(t, 'str') or
     StringsEqual(t, 'string') or
     StringsEqual(t, 'float') or
     StringsEqual(t, 'color') or
     StringsEqual(t, SCENETYPE) or
     StringsEqual(t, SCRIPTTYPE) or
     StringsEqual(leftstr(t,5), 'Class');
end;


{ TPropertyDescriptor }

constructor TPropertyDescriptor.Create;
begin
  inherited;
  FName := '';
  FType := '';
  FOriginalClass := '';
  FRangeLower :=  0;
  FRangeUpper :=  0;
  FRangeDefined := false;
  FDefault := '';
  FDefaultDefined := false;
  FShowWhen := '';

  FbConditional := false;
  FbConditionalExact := false;
  FConditionalPropName := '';
  FConditionalString   := '';

end;

function TPropertyDescriptor.GetIsRecordType: boolean;
var t: string;
begin
  result := false;
  t := self.PropertyType;
  if not IsABasePropertyType(t) then begin
     Assert(FParent <> nil, 'Cant check recordmanager here, FParent is nil');
     if FParent is TClassDescriptor then begin    //get all the way back to the ClassManager
        with (FParent as TClassDescriptor) do
           result := ClassManager.RecordManager.TypeExists(self.PropertyType);
     end;
  end;
end;

procedure TPropertyDescriptor.SetGroup(const g: string);
begin
  FGroup := g;
end;

function TPropertyDescriptor.GetGroup: string;
begin
  assert(not IsRecordType, 'record types should not exist anymore');
  if IsRecordType then
     result := self.Name + '.'
  else
     result := FGroup;
end;

function TPropertyDescriptor.GetName: string;
begin
  if rightstr(FGroup,1) = '.' then
     result := FGroup + FName
  else
     result := FName;
end;

procedure TPropertyDescriptor.SetDefault(const v: string);
begin
  FDefault := v;
  FDefaultDefined := true;
end;

procedure TPropertyDescriptor.SetShowWhen(const s: string);
var iPos: integer;
begin
  FShowWhen := s;
  if FShowWhen <> '' then begin
     FbConditional := true;
     iPos := instr(FShowWhen, '=');
     if iPos > 0 then begin              //format Prop=Value
        FbConditionalExact := true;
        FConditionalPropName := trim(leftstr(FShowWhen, iPos-1));
        FConditionalString   := trim(midstr(FShowWhen, iPos+1, length(FShowWhen)));
     end else begin
        FbConditionalExact := false;
        iPos := instr(FShowWhen, ' IN ');   //format Prop IN Value, Value
        if iPos > 0 then begin
           FConditionalPropName := trim(leftstr(FShowWhen, iPos-1));
           FConditionalString   := trim(midstr(FShowWhen, iPos+4, length(FShowWhen)));
           FConditionalString   := FConditionalString + ',';     //add a trailing comma. Will do search on "Val,"
        end else begin
           FbConditional := false;          //bad format, log it
           tLog.WriteLogEntry('Error: WHEN clause bad format: ' + FShowWhen);
        end;
     end;
  end else begin
     FbConditional := false;
  end;
end;

procedure TPropertyDescriptor.SetName(const s: string);
begin
  FName := s;
end;

procedure TPropertyDescriptor.SetRangeLower(const i: single);
begin
  FRangeLower := i;
  FRangeDefined := (FRangeLower <> FRangeUpper);
end;

procedure TPropertyDescriptor.SetRangeUpper(const i: single);
begin
  FRangeUpper := i;
  FRangeDefined := (FRangeLower <> FRangeUpper);
end;

procedure TPropertyDescriptor.SetType(const s: string);
begin
  FType := s;
end;

procedure TPropertyDescriptor.Assign(oProp: TPropertyDescriptor);
begin
  self.Name          := oProp.NameOnly;        //dont take group into account
  self.Group         := oProp.Group;
  self.PropertyType  := oProp.PropertyType;
  self.RangeLower    := oProp.RangeLower;
  self.RangeUpper    := oProp.RangeUpper;
  self.RangeDefined  := oProp.RangeDefined;
  self.DefaultValue  := oProp.DefaultValue;
  self.DefaultDefined:= oProp.DefaultDefined;
  self.OriginalClass := oProp.OriginalClass;
  self.ShowWhen      := oProp.ShowWhen;
end;


// if sent cLine := 'HitPoints int Range(1-100) default(0)', cOperator := 'Range'
//sends back cValue = '1-100', 'cRemaining:= HitPoints int default(0)'
procedure TPropertyDescriptor.ParseGeneric(cLine, cOperator: string; var cValue, cRemaining: string);
var iPos, iStartWord, iStartVal: integer;
    bDone, bFound: boolean;
begin
  cRemaining := cLine;
  iStartWord := instr(cLine, cOperator);
  if iStartWord > 0 then begin
     bDone  := false;
     bFound := false;
     iStartVal := iStartWord + length(cOperator) + 1;
     iPos      := iStartVal;
     while not (bDone or bFound) do begin
        if midstr(cLine, iPos, 1) = ')' then
           bFound := true
        else begin
           inc(iPos);
           bDone := (iPos > length(cLine));
        end;
     end;

     cValue := trim(midstr(cLine, iStartVal, iPos-iStartVal));
     if bFound then begin
        cRemaining := leftstr(cLine, iStartWord-1);
        cRemaining := cRemaining + midstr(cLine, iPos+1, length(cLine));
     end else begin
        cRemaining := leftstr(cLine, iStartWord-1);
     end;
  end;
  cRemaining := trim(cRemaining);
end;

function TPropertyDescriptor.ParseDefault(cLine: string): string;
var cWord: string;
begin
  ParseGeneric(cLine, 'Default', cWord, result);
  if cWord <> '' then
     self.DefaultValue := cWord;
end;

function TPropertyDescriptor.ParseWhen(cLine: string): string;
var
  cWord: string;
begin
  ParseGeneric(cLine, 'When', cWord, result);
  self.ShowWhen := cWord;
end;

function TPropertyDescriptor.ParseRange(cLine: string): string;
var iPos: integer;
    cWord: string;
begin
  ParseGeneric(cLine, 'Range', cWord, result);

  iPos  := instr(cWord, ',');
  if iPos = 0 then begin
     iPos  := instr(cWord, '-');
     if iPos = 0 then exit;
  end;

  self.RangeLower := StrToIntDef(leftstr(cWord, iPos-1),0);     //note: don't pass oProp, use Pascal scope
  cWord := midstr(cWord, iPos+1, length(cWord));
  if rightstr(cWord,1) = ')' then cWord := leftstr(cWord, length(cWord)-1);     //right paren
  self.RangeUpper := StrToIntDef(cWord,0);
end;

procedure TPropertyDescriptor.ReadFromLine(cLine: string);
var cWord: string;
    cGroup: string;
    iPos: integer;

begin
  cWord := ParseString(cLine, ' ');      //name
  iPos  := instr(cWord, '(');            //format Name(Group), parse out group
  if iPos > 0 then begin
     cGroup := midstr(cWord, iPos+1, length(cWord));
     if rightstr(cGroup,1) = ')' then cGroup := leftstr(cGroup, length(cGroup)-1);
     cWord := leftstr(cWord, iPos-1);
  end else
     cGroup := '';

  iPos := instr(cWord, '.');
  if iPos > 0 then begin
     cGroup  := leftstr(cWord, iPos);    //include '.'
     cWord := midstr(cWord, iPos+1, length(cWord));
  end;

  self.Name  := cWord;
  self.Group := cGroup;
  self.PropertyType := ParseString(cLine, ' ');

  cLine := ParseRange(cLine);
  cLine := ParseDefault(cLine);
  cLine := ParseWhen(cLine);

end;

//defaults all number props to zero instead of string
procedure TPropertyDescriptor.CheckForValidDefault;
var t: string;
begin
  t := PropertyType;
  if StringsEqual(t, 'int') or
     StringsEqual(t, 'integer') or
     StringsEqual(t, 'float') or
     StringsEqual(t, 'color') then begin

     //set to explicit zero if something else
     if StrToIntDef(DefaultValue, 0) = 0 then
        DefaultValue := '0';
  end;
end;


procedure TPropertyDescriptor.ExportToTextFile(tOut: TTextFileWriter);
var cLine: string;
    oRec: TRecordDescriptor;
    oProp: TPropertyDescriptor;
    bWriteMe: boolean;
begin
  //period means record type, only write it if default changed.
  bWriteMe := false;
  if rightstr(self.Group,1) = '.' then begin
     Assert(FParent <> nil, 'Cannot check recordmanager here, FParent is nil');
     if FParent is TClassDescriptor then begin    //get all the way back to the ClassManager
        if self.OriginalClass = '' then
           bWriteMe := true                       //orig class is lost on rec props loaded straight from classes.txt. just re-write out.
           //tLog.WriteLogEntry('Error: original class lookup failed for prop ' + self.name + ' during export')
        else begin
           oRec := (FParent as TClassDescriptor).ClassManager.RecordManager.Records[self.OriginalClass];
           if oRec = nil then
              tLog.WriteLogEntry('Error: failed to find custom type ' + self.OriginalClass + ' during export')
           else begin
              oProp := oRec.Props.Properties[self.NameOnly];
              bWriteMe :=  (oProp.DefaultValue <> self.DefaultValue);
           end;
        end;
     end;
  end else
     bWriteMe := true;

  if bWriteMe then begin
    cLine := '  ' + self.Name + ' ';
    cLine := cLine + self.PropertyType + ' ';
    if self.RangeDefined then begin
       cLine := cLine + 'Range(' + FloatToStr(self.RangeLower);
       cLine := cLine + '-' + FloatToStr(self.RangeUpper) + ') ';
    end;
    if self.DefaultDefined then
       cLine := cLine + 'Default ' + self.DefaultValue;
    tOut.WriteString(cLine);
  end;
end;

{ TPropertyList }

function TPropertyList.GetPropertyCount: integer;
begin result := FProperties.Count end;

function TPropertyList.GetPropertyByIndex(i: integer): TPropertyDescriptor;
begin
  result := TPropertyDescriptor(FProperties.Items[i])
end;

procedure TPropertyList.DeleteProperty(cPropName: string);
var oProp: TPropertyDescriptor;
begin
  oProp := Properties[cPropName];
  if oProp <> nil then
     FProperties.Remove(oProp);
end;

function TPropertyList.AddProperty(oProp: TPropertyDescriptor): boolean;
var cName: string;
begin
  result := false;
  if PropertyExists(oProp.Name) then begin
     if FParent is TClassDescriptor then
        cName := 'class ' + (FParent as TClassDescriptor).NameOfClass
     else if FParent is TRecordDescriptor then
        cName := (FParent as TRecordDescriptor).TypeName
     else cName := '(unknown)';
     tLog.WriteLogEntry('Error: attempt to duplicate property ' + oProp.Name  + ' in ' + cName);
     exit;
  end else begin
     oProp.CheckForValidDefault;
     FProperties.Add(oProp);
     result := true;
  end;
end;

constructor TPropertyList.Create(o: TObject);
begin
  inherited Create;
  FParent := o;
  FProperties := TMyList.Create;
end;

destructor TPropertyList.Destroy;
begin
  FProperties.Free;
  inherited;
end;

function TPropertyList.GetProperty(Name: string) : TPropertyDescriptor;
var i: integer;
    bFound, bDone: boolean;
    oProp : TPropertyDescriptor;
begin
  oProp := nil;
  i := 0;
  bFound := false;
  bDone := (i >= FProperties.Count);
  while not (bDone or bFound) do begin
     oProp := TPropertyDescriptor(FProperties.Items[i]);
     if StringsEqual(oProp.Name, Name) then
        bFound := true
     else begin
        inc(i);
        bDone := (i >= FProperties.Count);
     end;
  end;

  if bFound then
     result := oProp
  else
     result := nil;
end;

function TPropertyList.GetPropertyDefaultValue(Name: string): string;
var i: integer;
    bFound, bDone: boolean;
    oProp : TPropertyDescriptor;
begin
  oProp := nil;
  i := 0;
  bFound := false;
  bDone := (i >= FProperties.Count);
  while not (bDone or bFound) do begin
     oProp := TPropertyDescriptor(FProperties.Items[i]);
     if StringsEqual(oProp.Name, Name) then
        bFound := true
     else begin
        inc(i);
        bDone := (i >= FProperties.Count);
     end;
  end;

  result := '';
  if bFound then begin
     if oProp.DefaultDefined then
        result := oProp.DefaultValue;
  end;
end;

function TPropertyList.PropertyExists(Name: string): boolean;
begin result := (Properties[Name] <> nil) end;

procedure TPropertyList.ExportToTextFile(tOut: TTextFileWriter);
var i: integer;
begin
  for i := 0 to PropertyCount - 1 do
     PropertiesByIndex[i].ExportToTextFile(tOut);
end;


end.
