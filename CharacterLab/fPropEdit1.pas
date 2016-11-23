unit fPropEdit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, OutlTree, InPlace, StdCtrls, ExtCtrls, dtObject, dtClassManager,
  Menus;

type
  TfPropEdit = class(TForm)
    Panel1: TPanel;
    cbOk: TButton;
    otProp: TOutlineTreeView;
    oDialog: TOpenDialog;
    cDialog: TColorDialog;
    cbCancel: TButton;
    sbStat: TStatusBar;
    pmProp: TPopupMenu;
    mAddProp: TMenuItem;
    mDelProp: TMenuItem;
    procedure otPropIsReadOnlyNode(Node: TTreeNode; var aReadOnly: Boolean);
    procedure otPropGetNodeData(Node: TTreeNode; var aData: String;
      var PwdChar: Boolean; var MaxLength: Integer);
    procedure otPropValidateNodeData(Node: TTreeNode; aData: String);
    procedure otPropGetEditStyle(Node: TTreeNode; var aEditStyle: TEditStyle);
    procedure otPropGetPicklist(Node: TTreeNode; var aPickList: TStrings);
    procedure otPropEditButtonClick(Node: TTreeNode);
    procedure otPropPreCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure otPropKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure otPropMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pmPropPopup(Sender: TObject);
    procedure mDelPropClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FClass      : TClassDescriptor;
    FObj        : TDTObject;
    FCustomType : TCustomTypeDescriptor;
    FCurrentGroups: TStringList;
    FCurrentScenes: TStringList;
    FbIsEditingClass: boolean;                 //true if editing class def props, false if editing object
    function  GroupNodeWithText(cText: string): TTreeNode;
    function  PropNameFromNode(Node: TTreeNode): string;
    procedure StatusMessage(cMsg: string);
    procedure SetClass(c: TClassDescriptor);
    procedure FillControl;
    procedure DisplayBitFlagEditor(Node: TTreeNode);
    procedure DisplaySceneEditor(Node: TTreeNode);
  public
    procedure WriteClassDefaultProperties;
    property  ClassBeingEdited : TClassDescriptor read FClass write SetClass;
    property  GroupNames: TStringlist read FCurrentGroups;
    property  SceneNames: TStringlist read FCurrentScenes;
  end;

implementation

uses string32, fBitFlag1, buildlayer1,
     Math, dtFuncs, TextFile, dtProperty;

{$R *.DFM}

{ TfPropEdit }
procedure TfPropEdit.StatusMessage(cMsg: string);
begin
  sbStat.SimpleText := ' ' + cMsg;
end;

//assumes all group nodes built and are on first level
function TfPropEdit.GroupNodeWithText(cText: string): TTreeNode;
var FNode : TTreeNode;
    bDone : boolean;
begin
  FNode := otProp.Items.GetFirstNode;
  bDone := StringsEqual(FNode.Text, cText);
  while not bDone do begin
     FNode := FNode.GetNextSibling;
     bDone := StringsEqual(FNode.Text, cText);
  end;

  result := FNode;
end;

procedure TfPropEdit.FillControl;
var i, iPos: integer;
    aGroups: TStringList;
    aProps : TStringList;
    FParent: TTreeNode;
    FNew:  TTreeNode;

    bDone: boolean;
    oClass: TClassDescriptor;
    oProp: TPropertyDescriptor;
begin
  aGroups := TStringList.Create;
  FClass.GetAllGroupNames(aGroups);

  otProp.Items.BeginUpdate;
  otProp.Items.Clear;

  for i := 0 to aGroups.Count - 1 do begin
     FParent := otProp.Items.AddChildObject(nil, aGroups.Strings[i], nil);
     FParent.ImageIndex := -1;
     FParent.SelectedIndex := -1;
  end;
  aGroups.Free;

  aProps := TStringList.Create;
  bDone  := false;
  oClass := FClass;
  while not bDone do begin
     for i := 0 to oClass.Props.PropertyCount - 1 do begin
        oProp := oClass.Props.PropertiesByIndex[i];

        iPos := aProps.IndexOf(oProp.Name);
        if iPos = -1 then begin                //don't add twice
           FParent := GroupNodeWithText(oProp.Group);
           FNew := otProp.Items.AddChildObject(FParent, oProp.NameOnly, oProp);        //note: don't add name w/ group
           FNew.ImageIndex := -1;
           FNew.SelectedIndex := -1;
           aProps.Add(oProp.Name);
        end;
     end;

     oClass := oClass.Ancestor;
     bDone := (oClass = nil);
  end;

  otProp.Items[0].Expand(false);
  otProp.Items.EndUpdate;
  aProps.Free;

end;

procedure TfPropEdit.SetClass(c: TClassDescriptor);
begin
  FClass := c;
  FbIsEditingClass := true;

  FObj := TDTObject.Create(nil);
  FClassManager.Instantiate(FObj, FClass.NameOfClass, 0);     //object index does not matter here

  FillControl;
end;

{procedure TfPropEdit.SetObj(o: TDTObject);
begin
  FObj := TDTObject.Create(nil);
  FObj.Assign(o);
  FOldGroupName := o.Properties[GROUPPropName];
  FObj.ClearPropertyChangedFlags;

  FbIsEditingClass := false;
  FClass := FClassManager.Classes[FObj.NameOfClass];
  assert(FClass <> nil, 'Assert Failed, FClass = nil in Property Edit');
  FillControl ;
end;}

procedure TfPropEdit.otPropIsReadOnlyNode(Node: TTreeNode; var aReadOnly: Boolean);
var oProp: TPropertyDescriptor;
    cVal : string;
    cTestVal: string;
begin
  StatusMessage('');
  if Node.Level = 0 then
     aReadOnly := true
  else begin
     oProp := TPropertyDescriptor(Node.Data);
     if StringsEqual(Node.Text, GUIDPROPNAME) then begin
        //non-read only, but changing disabled
        //aReadOnly := true;
        //StatusMessage('GUID property is read only');
     end else
     if StringsEqual(oProp.PropertyType, SCENETYPE) and FbIsEditingClass then begin
        aReadOnly := true;
        StatusMessage('Scene Support read only for class defaults');
     end else
     if StringsEqual(oProp.PropertyType, SCRIPTTYPE) and FbIsEditingClass then begin
        aReadOnly := true;
        StatusMessage('Script Support read only for class defaults');
     end else begin
        aReadOnly := false;
        if oProp.bConditional then begin                             //need to test for value
           cTestVal := FObj.Properties[oProp.ConditionalPropName];   //get value
           cVal     := oProp.ConditionalString;
           if oProp.bConditionalExact then
              aReadOnly := not StringsEqual(cTestVal, cVal)         //if not equal, allow editing
           else
              aReadOnly := Instr(cVal, cTestVal + ',') = 0;         //if not found, allow editing
        end;
        if aReadOnly then
           StatusMessage('read only based on value of ' + oProp.ConditionalPropName);
     end;
  end;
end;

procedure TfPropEdit.otPropGetNodeData(Node: TTreeNode; var aData: String;
  var PwdChar: Boolean; var MaxLength: Integer);

var cPropName: string;
    oProp: TPropertyDescriptor;
begin
  if (Node.Level = 0) then exit;

  oProp := TPropertyDescriptor(Node.Data);
  if StringsEqual(oProp.PropertyType, SCRIPTTYPE) then begin
     aData := '(script)';
  end else begin
     cPropName := PropNameFromNode(Node);
     aData := FObj.Properties[cPropName];
  end;
end;

procedure TfPropEdit.otPropValidateNodeData(Node: TTreeNode; aData: String);
var cProp: string;
begin
  if (Node.Level = 0) then exit;

  //GUID is not read only so cutting and pasting can be done. Prevent changing here.
  cProp := PropNameFromNode(Node);
  if StringsEqual(cProp, GUIDPROPNAME) then begin
     StatusMessage('GUID property is read only');
  end else
     FObj.Properties[cProp] := aData;
  otProp.Invalidate;
end;

procedure TfPropEdit.otPropGetEditStyle(Node: TTreeNode; var aEditStyle: TEditStyle);
var oProp: TPropertyDescriptor;
begin
  if (Node.Level = 0) then exit;
  oProp := TPropertyDescriptor(Node.Data);

  if StringsEqual(oProp.NameOnly, GROUPPropName) then begin
     aEditStyle := etsPickList;
     //otProp.TreeOptions := otProp.TreeOptions - [totPopupOnClick];     //allow entry here
     exit;
  end;

  if StringsEqual(oProp.PropertyType, SCRIPTTYPE) then begin
     aEditStyle := etsEllipsis;
     exit;
  end;

  if StringsEqual(oProp.PropertyType, SCENETYPE) then begin
     aEditStyle := etsEllipsis;
     exit;
  end;

  aEditStyle := etsSimple;   //ints, floats, strings use basic property editor
  if StringsEqual(oProp.PropertyType, 'float') then exit;

  if StringsEqual(oProp.PropertyType, 'int') or
     StringsEqual(oProp.PropertyType, 'integer') then exit;

  if StringsEqual(oProp.PropertyType, 'str') or
     StringsEqual(oProp.PropertyType, 'string') then exit;

  //if StringsEqual(oProp.PropertyType, 'FileName') then
  //   aEditStyle := etsEllipsis;

  if StringsEqual(oProp.PropertyType, 'Color') then
     aEditStyle := etsEllipsis;

  //class type
  if StringsEqual(LeftStr(oProp.PropertyType, 6), 'Class(') then
     aEditStyle := etsEllipsis;

  FCustomType := FClassManager.TypeManager.Types[oProp.PropertyType];
  if FCustomType = nil then exit;

  if FCustomType.TypeType = cttBitSet then
     aEditStyle := etsEllipsis
  else begin
     aEditStyle := etsPickList;
     //otProp.TreeOptions := otProp.TreeOptions + [totPopupOnClick];
  end;

  //TODO: record types?
end;

procedure TfPropEdit.otPropGetPicklist(Node: TTreeNode; var aPickList: TStrings);
begin
  if (Node.Level = 0) then exit;

  if StringsEqual(Node.Text, GROUPPropName) then begin
     aPickList.Assign(FCurrentGroups);
  end else begin
     if FCustomType = nil then exit;
     FCustomType.GetChoices(TStringList(aPickList));
  end;
end;

procedure TfPropEdit.otPropEditButtonClick(Node: TTreeNode);
var //fc: TfPickClass;
    //fs: TfScriptEdit;
    iVal: longint;
    oProp: TPropertyDescriptor;
    cPropName: string;
    cClass: string;
begin
  if (Node.Level = 0) then exit;

    //ellipsis property either FileName, BitFlag, Color type
  oProp := TPropertyDescriptor(Node.Data);
  cPropName := PropNameFromNode(Node);

  if StringsEqual(oProp.PropertyType, SCRIPTTYPE) then begin
     {fs := TfScriptEdit.Create(self);
     fs.meScript.Text := FObj.Properties[cPropName];
     fs.ShowModal;
     if fs.ModalResult = mrOk then begin
        FObj.Properties[cPropName] := fs.meScript.Text;
     end;
     fs.Free;}
  end else
  if StringsEqual(oProp.PropertyType, SCENETYPE) then begin
     DisplaySceneEditor(Node);
  end else
  if StringsEqual(oProp.PropertyType, 'BitFlag') then begin
     DisplayBitFlagEditor(Node);
  end else if StringsEqual(leftstr(oProp.PropertyType,6), 'Class(') then begin

     cClass := midstr(oProp.PropertyType, 7, length(oProp.PropertyType));
     if rightstr(cClass,1) = ')' then cClass := leftstr(cClass, length(cClass)-1);

     {fc := TfPickClass.Create(self);
     fc.FillTree(cClass);
     fc.ShowModal;
     if fc.ModalResult = mrOk then begin
        FObj.Properties[cPropName] := fc.tvSelect.Selected.Text;
     end;
     fc.Free;}
  end else begin       //color
     iVal := StrToIntDef(FObj.Properties[cPropName], 0);
     cDialog.Color := TColor(iVal);
     if cDialog.Execute then
        FObj.Properties[cPropName] := longint(cDialog.Color);
  end;
end;

procedure TfPropEdit.DisplaySceneEditor(Node: TTreeNode);
var fb: TfBitFlag;
    i: longint;
    cSceneString: string;
    cThisScene: string;
begin

  fb := TfBitFlag.Create(self);
  fb.pnInstruct.Visible := true;
  fb.Caption := 'Select Scenes object appears in';
  try
     cSceneString := FObj.Properties[PropNameFromNode(Node)];
     for i := 0 to FCurrentScenes.Count - 1 do begin
        fb.clOptions.Items.Add(FCurrentScenes.Strings[i]);
        cThisScene := Bracketed(FCurrentScenes.Strings[i]);
        fb.clOptions.Checked[i] := Instr(cSceneString, cThisScene) > 0;
     end;

     fb.ShowModal;
     if fb.ModalResult = mrOk then begin
        cSceneString := '';
        for i := 0 to FCurrentScenes.Count - 1 do begin
           if fb.clOptions.Checked[i] then begin
              cThisScene := Bracketed(FCurrentScenes.Strings[i]);
              cSceneString := cSceneString + cThisScene;
           end;
        end;
        FObj.Properties[PropNameFromNode(Node)] := cSceneString;
     end;
  finally
     fb.Free;
  end;
end;

procedure TfPropEdit.DisplayBitFlagEditor(Node: TTreeNode);
var fb: TfBitFlag;
    oChoices: TStringList;
    iVal, i: longint;
begin

  fb := TfBitFlag.Create(self);
  oChoices := TStringList.Create;
  try
     FCustomType.GetChoices(oChoices);
     iVal := StrToIntDef(FObj.Properties[PropNameFromNode(Node)], 0);
     for i := 0 to oChoices.Count-1 do begin
        fb.clOptions.Items.Add(oChoices.Strings[i]);
        fb.clOptions.Checked[i] := BitTurnedOn(iVal, i);
     end;

     fb.ShowModal;
     if fb.ModalResult = mrOk then begin
        iVal := 0;
        for i := 0 to oChoices.Count-1 do begin
           if fb.clOptions.Checked[i] then
              iVal := iVal + Trunc(IntPower(2, i));
        end;
        FObj.Properties[PropNameFromNode(Node)] := iVal;
     end;
  finally
     oChoices.Free;
     fb.Free;
  end;
end;

//writes default properties
//to current class. This is done to override properties that might
//exist in ancestor classes but not in current class
procedure TfPropEdit.WriteClassDefaultProperties;
var i: integer;
    cName: string;
    oNewProp, oProp: TPropertyDescriptor;
begin
  for i := 0 to FObj.PropertyCount - 1 do begin
     cName := FObj.PropertyNames[i];

     oProp := FClass.MasterProperties[cName];
     if FObj.PropertyValues[i] <> oProp.DefaultValue then begin
        //cheating out the ass but it works
        //JAH
         frmBuildLayer.MainIniFile.WriteString('Properties', cName, FObj.PropertyValues[i]);
        //the property might not exist in the class (which means it was defined higher)
        if not FClass.Props.PropertyExists(cName) then begin
           //need to assign to property wherever it is up the tree
           oNewProp := TPropertyDescriptor.Create;
           oNewProp.Assign(oProp);
           FClass.AddProperty(oNewProp);
        end else
           oNewProp := FClass.Props.Properties[FObj.PropertyNames[i]];

        oNewProp.DefaultValue := FObj.PropertyValues[i];
        tLog.WriteLogEntry('property ' + FObj.PropertyNames[i] + ' changed');
     end;
  end;

  FObj.Free;
end;

//assumes tree never on level 0!
function TfPropEdit.PropNameFromNode(Node: TTreeNode): string;
begin
  result := Node.Text;
  if rightstr(Node.Parent.Text, 1) = '.' then
     result := Node.Parent.Text + result;        //record type
end;

procedure TfPropEdit.otPropPreCustomDrawItem(Sender: TCustomTreeView;  Node: TTreeNode;
   State: TCustomDrawState; var DefaultDraw: Boolean);
var oProp: TPropertyDescriptor;
    cVal : string;
    cTestVal: string;
    bHide: boolean;
begin
  bHide := false;
  if (Node.Level > 0) then begin

     oProp := TPropertyDescriptor(Node.Data);
     if oProp.bConditional then begin
        cTestVal := FObj.Properties[oProp.ConditionalPropName];   //get value
        cVal     := oProp.ConditionalString;
        if oProp.bConditionalExact then
           bHide := not StringsEqual(cTestVal, cVal)
        else
           bHide := Instr(cVal, cTestVal + ',') = 0;         //if not found, allow editing
     end;
  end;

  if bHide then begin
     DefaultDraw := false;
     Sender.Canvas.Brush.Color := clBlack;
     Sender.Canvas.FillRect(Node.DisplayRect(false));
  end;
end;

procedure TfPropEdit.FormCreate(Sender: TObject);
begin
  //remove this line to allow custom drawing
  otProp.OnPreCustomDrawItem := nil;
  FCurrentGroups := TStringList.Create;
  FCurrentGroups.Sorted := true;
  FCurrentGroups.Duplicates := dupIgnore;
  FCurrentScenes := TStringList.Create;

end;

procedure TfPropEdit.FormDestroy(Sender: TObject);
begin
  FCurrentGroups.Free;
  FCurrentScenes.Free;
end;

procedure TfPropEdit.otPropKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var Node: TTreeNode;
begin
  Node := otProp.Selected;
  if Node.Level = 0 then exit;
  if StringsEqual(Node.Text, GUIDPROPNAME) then begin
     StatusMessage('Key ' + inttostr(Key));
  end;
end;

procedure TfPropEdit.otPropMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var p: TPoint;
begin
  if (ssRight in Shift) and (FbIsEditingClass) then begin
     if x < otProp.WidthOutline then begin
        p := otProp.ClientToScreen(Point(x,y));
        pmProp.Popup(p.x,p.y);
     end;
  end;
end;

procedure TfPropEdit.pmPropPopup(Sender: TObject);
var Node: TTreeNode;
begin
  mDelProp.Enabled := false;
  Node := otProp.Selected;
  if (Node.Level = 1) then
     mDelProp.Enabled := FClass.Props.PropertyExists(Node.Text)
end;

procedure TfPropEdit.mDelPropClick(Sender: TObject);
var cMsg: string;
    cPropName: string;
    cGroupName: string;
    Node: TTreeNode;
begin
  Node := otProp.Selected;
  cPropName  := Node.Text;
  cGroupName := Node.Parent.Text;
  cMsg := 'Confirm, Delete Property ' + Quoted(cPropName);
  if MessageDlg(cMsg, mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

  if StringsEqual(cGroupName, 'ini.') then
     StatusMessage('cannot delete ini-style props')
  else begin
     FClass.Props.DeleteProperty(cPropName);
     Node.Delete;
  end;
end;

procedure TfPropEdit.FormShow(Sender: TObject);
var
list: TStringList;
i: integer;
begin
  list := TStringList.Create;
  frmBuildLayer.MainIniFile.ReadSection('Properties', List);
  for i := 0 to list.Count -1 do
  begin
       FObj.Properties[list.Strings[i]] := frmBuildLayer.MainIniFile.ReadString('Properties',list.Strings[i],'');
       otProp.Invalidate;
  end;
  list.Free;

end;


end.
