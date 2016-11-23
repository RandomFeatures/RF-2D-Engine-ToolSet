unit NPCProp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Numedit, StdCtrls, ComCtrls, Buttons, strFunctions, GameObjects, MemoEx, IniFiles,
  ExtCtrls;

type
  TfrmNPCProp = class(TForm)
    PageControl1: TPageControl;
    tsCmmon: TTabSheet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label8: TLabel;
    edtRed: TNumEdit;
    edtBlue: TNumEdit;
    Label9: TLabel;
    edtGreen: TNumEdit;
    edtBlend: TNumEdit;
    Label10: TLabel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    cbGroupID: TComboBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    edtNPCName: TEdit;
    lblX: TLabel;
    Label4: TLabel;
    cbFacing: TComboBox;
    lblY: TLabel;
    Label5: TLabel;
    tsEvents: TTabSheet;
    cbOnActivate: TComboBox;
    Label3: TLabel;
    Label11: TLabel;
    cbOnAttacked: TComboBox;
    Label12: TLabel;
    cbOnClose: TComboBox;
    Label13: TLabel;
    cbOnDie: TComboBox;
    Label14: TLabel;
    cbOnFirstAttacked: TComboBox;
    Label15: TLabel;
    cbOnLoad: TComboBox;
    Label16: TLabel;
    cbOnOpen: TComboBox;
    Label17: TLabel;
    cbOnCombat: TComboBox;
    Label18: TLabel;
    cbOnIdle: TComboBox;
    edtGUID: TEdit;
    cbLayer: TComboBox;
    Label19: TLabel;
    tsCharacter: TTabSheet;
    Label20: TLabel;
    Label21: TLabel;
    cbClass: TComboBox;
    cbSpells: TComboBox;
    Label22: TLabel;
    cbAttRating: TComboBox;
    Label23: TLabel;
    cbHealthRating: TComboBox;
    Label24: TLabel;
    cbDefRating: TComboBox;
    Label25: TLabel;
    cbMoveRating: TComboBox;
    Label26: TLabel;
    edtMagResist: TNumEdit;
    Label27: TLabel;
    editMin: TNumEdit;
    Label28: TLabel;
    edtHits: TNumEdit;
    Label29: TLabel;
    edtPhyResist: TNumEdit;
    Label30: TLabel;
    edtMax: TNumEdit;
    Label31: TLabel;
    cbMove: TComboBox;
    Label32: TLabel;
    Label33: TLabel;
    tsStatic: TTabSheet;
    lblStX: TLabel;
    lblStY: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    cbStGroupID: TComboBox;
    edtLength: TNumEdit;
    edtWidth: TNumEdit;
    edtDrawOrder: TNumEdit;
    edtStRed: TNumEdit;
    edtStBlue: TNumEdit;
    edtStGreen: TNumEdit;
    edtStBlend: TNumEdit;
    cbStLayer: TComboBox;
    cbShadow: TCheckBox;
    edtFrameIndx: TEdit;
    pnAmbientColor: TPanel;
    cDialog: TColorDialog;
    procedure edtNPCNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbFacingChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mmIdleScrGetLineAttr(Sender: TObject; const Line: String;
      Index: Integer; const SelAttrs: TSelAttrs; var Attrs: TLineAttrs);
    procedure cbOnActivateDblClick(Sender: TObject);
    procedure edtMagResistExit(Sender: TObject);
    procedure pnAmbientColorClick(Sender: TObject);
    procedure edtNPCNameChange(Sender: TObject);
    procedure edtFrameIndxChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    BlueList: TStringList;
    GreenList: TStringList;
    RedList: TStringList;
    BoldList: TStringList;
    PurpleList: TStringList;
    procedure SetCharacter;
    procedure SetParticle;
    procedure SetSprite;
    procedure SetStart;
    procedure SetStatic;
    procedure BuildGroupList;
    procedure ResetDefaults;
    procedure CleanScript;
    procedure LoadEventLists;
    function GetEventName(event: string): string;
    procedure RegisterEvent(evnt: string);
    procedure UpdateSprites();
    procedure UpdateStatics();
  public
    { Public declarations }
    NameChange: boolean;
    FacingChange: boolean;
    bLoading: boolean;
    SelectedList: TList;
    procedure SetupStatic(var StaticList: TList);
    procedure SetupSprite(var SpriteList: TList);
  end;

var
  frmNPCProp: TfrmNPCProp;

implementation

uses scriptMain, main;

{$R *.DFM}

procedure TfrmNPCProp.edtNPCNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   NameChange := true;
end;

procedure TfrmNPCProp.cbFacingChange(Sender: TObject);
begin
  FacingChange := true;
  UpdateSprites
end;

procedure TfrmNPCProp.FormCreate(Sender: TObject);
var
  ColorIni: TiniFile;
  MyIniFile: TIniFile;
  EnginINI: TIniFile;
  SpellList: TStringList;
  iLoop: integer;
  s: string;
begin
      //create my color lists
      BlueList := TStringList.Create;
      GreenList := TStringList.Create;
      RedList := TStringList.Create;
      PurpleList := TStringList.Create;
      BoldList := TStringList.Create;

      //open the color ini file
      ColorIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+  'Resources\Editor\scriptColors.ini');
      //Read in the colors for the script commands
      ColorIni.ReadSection('blue', BlueList);
      ColorIni.ReadSection('red', RedList);
      ColorIni.ReadSection('green', GreenList);
      ColorIni.ReadSection('purple', PurpleList);
      ColorIni.ReadSection('Bold', BoldList);

      ColorIni.free;

      MyIniFile := TIniFile.create(ExtractFilePath(Application.exename) + 'TileMapEditor.ini');

      SpellList := TStringList.Create();
      EnginINI := TIniFile.create(MyIniFile.ReadString('path','EngineIni','') + 'rf2d.ini');
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

      NameChange := false;
      FacingChange := false;
      PageControl1.ActivePageIndex := 0;
      tsCharacter.Tabvisible := false;
      tsCmmon.Tabvisible := true;
      tsEvents.Tabvisible := true;
      tsStatic.Tabvisible := false;

end;

procedure TfrmNPCProp.FormDestroy(Sender: TObject);
begin
      BlueList.free;
      GreenList.free;
      RedList.free;
      PurpleList.free;
      BoldList.Free;
end;

procedure TfrmNPCProp.SetCharacter;
begin
      Caption := 'Character Properties';
      cbOnClose.enabled := false;
      cbOnOpen.enabled := false;
      Label12.enabled := false;
      Label16.enabled := false;
      tsCharacter.enabled := true;
      tsCmmon.enabled := true;
      tsEvents.enabled := true;
      tsCharacter.Tabvisible := true;
      tsCmmon.Tabvisible := true;
      tsEvents.Tabvisible := true;
      tsStatic.enabled := false;
      tsStatic.Tabvisible := false;
      PageControl1.ActivePageIndex := 0;
end;

procedure TfrmNPCProp.SetSprite;
begin
      cbFacing.Enabled := false;
     // edtAction.Enabled := false;
      Label4.Enabled := false;
      Label5.Enabled := false;
      Caption := 'Sprite Properties';
      cbOnIdle.enabled := false;
      cbOnCombat.Enabled := false;
      cbOnAttacked.Enabled := false;
      cbOnFirstAttacked.Enabled := false;
      cbOnDie.Enabled := false;
      Label11.enabled := false;
      Label14.enabled := false;
      Label17.enabled := false;
      Label18.enabled := false;
      Label13.enabled := false;
      tsCharacter.enabled := false;
      tsCmmon.enabled := true;
      tsEvents.enabled := true;
      tsCharacter.Tabvisible := false;
      tsCmmon.Tabvisible := true;
      tsEvents.Tabvisible := true;
      tsStatic.enabled := false;
      tsStatic.Tabvisible := false;
      PageControl1.ActivePageIndex := 0;

end;

procedure TfrmNPCProp.SetStart;
begin
      Caption := 'Start Point Properties';
      edtNPCName.Enabled := false;
      Label1.Enabled := false;
      Label4.Enabled := false;
      Label5.Enabled := false;
     // edtAction.Enabled := false;
      frmNPCProp.cbOnIdle.enabled := false;
      frmNPCProp.cbOnCombat.Enabled := false;
      frmNPCProp.cbOnAttacked.Enabled := false;
      frmNPCProp.cbOnFirstAttacked.Enabled := false;
      frmNPCProp.cbOnDie.Enabled := false;
      frmNPCProp.cbOnClose.enabled := false;
      frmNPCProp.cbOnOpen.enabled := false;
      frmNPCProp.cbOnActivate.enabled := false;
      Label11.enabled := false;
      Label14.enabled := false;
      Label17.enabled := false;
      Label18.enabled := false;
      Label13.enabled := false;
      Label3.enabled := false;
      tsCharacter.enabled := false;
      tsCmmon.enabled := true;
      tsEvents.enabled := true;
      tsCharacter.Tabvisible := false;
      tsCmmon.Tabvisible := true;
      tsEvents.Tabvisible := true;
      tsStatic.enabled := false;
      tsStatic.Tabvisible := false;
      PageControl1.ActivePageIndex := 0;

end;

procedure TfrmNPCProp.SetParticle;
begin
      Caption := 'Start Point Properties';
      edtNPCName.Enabled := false;
      Label1.Enabled := false;
      Label4.Enabled := false;
      Label5.Enabled := false;
    //  edtAction.Enabled := false;
      frmNPCProp.cbOnIdle.enabled := false;
      frmNPCProp.cbOnCombat.Enabled := false;
      frmNPCProp.cbOnAttacked.Enabled := false;
      frmNPCProp.cbOnFirstAttacked.Enabled := false;
      frmNPCProp.cbOnDie.Enabled := false;
      frmNPCProp.cbOnClose.enabled := false;
      frmNPCProp.cbOnOpen.enabled := false;
      frmNPCProp.cbOnActivate.enabled := false;
      Label11.enabled := false;
      Label14.enabled := false;
      Label17.enabled := false;
      Label18.enabled := false;
      Label13.enabled := false;
      Label3.enabled := false;
end;

procedure TfrmNPCProp.ResetDefaults;
begin
      Caption := 'Sprite Properties';
      Label1.Enabled := true;
      Label4.Enabled := true;
      Label5.Enabled := true;
      edtNPCName.Enabled := true;
      cbFacing.Enabled := true;
     // edtAction.Enabled := true;
      frmNPCProp.cbOnIdle.enabled := true;
      frmNPCProp.cbOnCombat.Enabled := true;
      frmNPCProp.cbOnAttacked.Enabled := true;
      frmNPCProp.cbOnFirstAttacked.Enabled := true;
      frmNPCProp.cbOnDie.Enabled := true;
      frmNPCProp.cbOnClose.enabled := true;
      frmNPCProp.cbOnOpen.enabled := true;
      frmNPCProp.cbOnActivate.enabled := true;
      Label11.enabled := true;
      Label14.enabled := true;
      Label17.enabled := true;
      Label18.enabled := true;
      Label13.enabled := true;
      Label3.enabled := true;

end;

procedure TfrmNPCProp.BuildGroupList;
var
  iLoop: integer;
begin
     cbGroupID.Clear;
     cbStGroupID.Clear;
     for iLoop := 0 to frmMain.ObjectList.count -1 do
     begin
       if TSprite(frmMain.ObjectList.Items[iLoop]).groupID > -1 then
       if cbGroupID.Items.IndexOf(IntToStr(TSprite(frmMain.ObjectList.Items[iLoop]).groupID)) = -1 then
       begin
          cbGroupID.Items.Add(IntToStr(TSprite(frmMain.ObjectList.Items[iLoop]).groupID));
          cbStGroupID.Items.Add(IntToStr(TSprite(frmMain.ObjectList.Items[iLoop]).groupID));
       end;
     end;
end;


procedure TfrmNPCProp.SetupSprite(var SpriteList: TList);
var
 MyNPC: TSprite;
 iLoop : integer;
begin
     bLoading := true;
     NameChange := false;
     FacingChange := false;

     SelectedList := SpriteList;
     //Get the first select sprite
     MyNPC := TSprite(SelectedList.Items[0]);
     case MyNPC.SpriteType of
       stNPC: SetCharacter;
       stSprite: SetSprite;
       stStart: SetStart;
     end;
     BuildGroupList;

     lblX.caption := 'X = ' +IntToStr(MyNPC.x);
     lblY.caption := 'Y = ' +IntToStr(MyNPC.y);
     edtNPCName.text := MyNPC.DisplayName;
     cbFacing.ItemIndex := MyNPC.Facing;
     edtRed.text := IntToStr(MyNPC.Red);
     edtBlue.text := IntToStr(MyNPC.Blue);
     edtGreen.text := IntToStr(MyNPC.Green);
     edtBlend.text := IntToStr(MyNPC.Blend);

     if MyNPC.SpriteType = stNPC then
     begin

         for iLoop := 0 to cbSpells.Items.count - 1 do
         begin
              if cbSpells.Items.Values[cbSpells.Items.Names[iLoop]] = IntToStr(MyNPC.SpellID)then
                cbSpells.ItemIndex := iLoop
              else
                  continue;
         end;
         cbClass.ItemIndex := MyNPC.CharType;
         cbAttRating.ItemIndex := MyNPC.AttRating;
         cbHealthRating.ItemIndex := MyNPC.HealthRating;
         cbDefRating.ItemIndex := MyNPC.DefRating;
         cbMoveRating.ItemIndex := MyNPC.MoveRating;
         edtMagResist.Text := strTokenAt(MyNPC.MagResist,'.',1);
         edtPhyResist.Text := strTokenAt(MyNPC.PhyResist,'.',1);
         editMin.text := IntToStr(MyNPC.MinDamage);
         edtHits.text := IntToStr(MyNPC.HitPoints);
         edtMax.text := IntToStr(MyNPC.MaxDamage);
         cbMove.ItemIndex := cbMove.Items.IndexOf(IntToStr(MyNPC.Movement));
     end;

     edtGUID.text := MyNPC.Id;
     LoadEventLists;
     CleanScript;

     //Assign Events
     cbOnActivate.itemIndex := cbOnActivate.Items.IndexOf(MyNPC.OnActivate);
     cbOnAttacked.itemIndex := cbOnAttacked.Items.IndexOf(MyNPC.OnAttacked);
     cbOnClose.itemIndex := cbOnClose.Items.IndexOf(MyNPC.OnClose);
     cbOnDie.itemIndex := cbOnDie.Items.IndexOf(MyNPC.OnDie);
     cbOnFirstAttacked.itemIndex := cbOnFirstAttacked.Items.IndexOf(MyNPC.OnFirstAttacked);
     cbOnLoad.itemIndex := cbOnLoad.Items.IndexOf(MyNPC.OnLoad);
     cbOnOpen.itemIndex := cbOnOpen.Items.IndexOf(MyNPC.OnOpen);
     cbOnCombat.itemIndex := cbOnCombat.Items.IndexOf(MyNPC.CombatScript);
     cbOnIdle.itemIndex := cbOnIdle.Items.IndexOf(MyNPC.IdleScript);

     if MyNPC.GroupID > -1 then
        cbGroupID.text := IntToStr(MyNPC.GroupID)
     else
        cbGroupID.text := '';
     cbLayer.ItemIndex := MyNPC.Layer;

     bLoading := false;
end;

procedure TfrmNPCProp.mmIdleScrGetLineAttr(Sender: TObject;
  const Line: String; Index: Integer; const SelAttrs: TSelAttrs;
  var Attrs: TLineAttrs);
var
  iOLoop, iLoop, iPos: integer;
  tmpStr: string;
  strLine: string;
begin
  //grab the current line
  strLine := LowerCase(Line);

  //see if the current line contains words from the blue list
  for iOLoop := 0 to  BlueList.Count -1 do
  begin
    tmpStr := BlueList.Strings[iOLoop];
    iPos := Pos(tmpStr,strLine);
    if (iPos <> 0) then
       for iLoop := iPos-1 to iPos + Length(tmpStr) - 2 do
           Attrs[iLoop].FC := clBlue;
  end;

  //see if the current line contains words from the green list
  for iOLoop :=  0 to GreenList.Count -1 do
  begin
    tmpStr := GreenList.Strings[iOLoop];
    iPos := Pos(tmpStr,strLine);
    if (iPos <> 0) then
       for iLoop := iPos-1 to iPos + Length(tmpStr) - 2 do
           Attrs[iLoop].FC := clGreen;
  end;

  //see if the current line contains words from the red list
  for iOLoop := 0 to RedList.Count -1 do
  begin
    tmpStr := RedList.Strings[iOLoop];
    iPos := Pos(tmpStr,strLine);
    if (iPos <> 0) then
       for iLoop := iPos-1 to iPos + Length(tmpStr) - 2 do
           Attrs[iLoop].FC := clRed;
  end;

    // color these special case characters
    iPos := Pos('=',strLine);
    if (iPos <> 0) then
       Attrs[iPos-1].FC := clRed;


    iPos := Pos(';',strLine);
    if (iPos <> 0) then
       Attrs[iPos-1].FC := clRed;

    iPos := Pos('[',strLine);
    if (iPos <> 0) then
       Attrs[iPos-1].FC := clRed;

    iPos := Pos(']',strLine);
    if (iPos <> 0) then
       Attrs[iPos-1].FC := clRed;

  //see if the current line contains words from the red list
  for iOLoop := 0 to PurpleList.Count -1 do
  begin
    tmpStr := PurpleList.Strings[iOLoop];
    iPos := Pos(tmpStr,strLine);
    if (iPos <> 0) then
       for iLoop := iPos-1 to iPos + Length(tmpStr) - 2 do
           Attrs[iLoop].FC := clPurple
  end;

    //see if the current line contains words from the bold list
  for iOLoop := 0 to BoldList.Count -1 do
  begin
    tmpStr := BoldList.Strings[iOLoop];
    iPos := Pos(tmpStr,strLine);
    if (iPos <> 0) then
       for iLoop := iPos-1 to iPos + Length(tmpStr) - 2 do
           Attrs[iLoop].Style := [fsBold];
  end;
end;


procedure TfrmNPCProp.CleanScript;
begin
     cbOnActivate.itemIndex := -1;
     cbOnAttacked.itemIndex := -1;
     cbOnClose.itemIndex := -1;
     cbOnDie.itemIndex := -1;
     cbOnFirstAttacked.itemIndex :=  -1;
     cbOnLoad.itemIndex := -1;
     cbOnOpen.itemIndex := -1;
     cbOnCombat.itemIndex := -1;
     cbOnIdle.itemIndex :=  -1;
     cbOnActivate.text := '';
     cbOnAttacked.text := '';
     cbOnClose.text := '';
     cbOnDie.text := '';
     cbOnFirstAttacked.text := '';
     cbOnLoad.text := '';
     cbOnOpen.text := '';
     cbOnCombat.text := '';
     cbOnIdle.text := '';
end;

procedure TfrmNPCProp.LoadEventLists;
var
iLoop: integer;
begin
      cbOnActivate.Clear;
      cbOnAttacked.Clear;
      cbOnClose.Clear;
      cbOnDie.Clear;
      cbOnFirstAttacked.Clear;
      cbOnLoad.Clear;
      cbOnOpen.Clear;
      cbOnCombat.Clear;
      cbOnIdle.Clear;

     for iLoop := 0 to ScriptList.Count -1 do
     begin
          if Pos('function',ScriptList.strings[iLoop]) > 0 then
          begin
               if Pos('OnActivate()',ScriptList.strings[iLoop]) > 0 then
                  cbOnActivate.items.add(GetEventName(ScriptList.strings[iLoop]));
               if Pos('OnAttacked()',ScriptList.strings[iLoop]) > 0 then
                  cbOnAttacked.items.add(GetEventName(ScriptList.strings[iLoop]));
               if Pos('OnClose()',ScriptList.strings[iLoop]) > 0 then
                  cbOnClose.items.add(GetEventName(ScriptList.strings[iLoop]));
               if Pos('OnDie()',ScriptList.strings[iLoop]) > 0 then
                  cbOnDie.items.add(GetEventName(ScriptList.strings[iLoop]));
               if Pos('OnFirstAttacked()',ScriptList.strings[iLoop]) > 0 then
                  cbOnFirstAttacked.items.add(GetEventName(ScriptList.strings[iLoop]));
               if Pos('OnLoad()',ScriptList.strings[iLoop]) > 0 then
                  cbOnLoad.items.add(GetEventName(ScriptList.strings[iLoop]));
               if Pos('OnOpen()',ScriptList.strings[iLoop]) > 0 then
                  cbOnOpen.items.add(GetEventName(ScriptList.strings[iLoop]));
               if Pos('Combat()',ScriptList.strings[iLoop]) > 0 then
                  cbOnCombat.items.add(GetEventName(ScriptList.strings[iLoop]));
               if Pos('Idle()',ScriptList.strings[iLoop]) > 0 then
                  cbOnIdle.items.add(GetEventName(ScriptList.strings[iLoop]));
          end;
     end;
end;

function TfrmNPCProp.GetEventName(event: string): string;
var
strTmp: string;
begin
     strTmp := event;

     strTmp := Copy(event,9,Length(event));
     if Pos('()',strTmp) > 0 then
       strTmp := StrLeft(strTmp,Length(strTmp)-2);
     result := strTmp
end;

procedure TfrmNPCProp.cbOnActivateDblClick(Sender: TObject);
var
  tmpStr: string;
  iStart: integer;
begin
    tmpStr := edtGUID.text + TComboBox(Sender).hint;

    if TComboBox(Sender).Text = '' then
    begin
       TComboBox(Sender).Text := tmpStr;
       RegisterEvent(tmpStr);
       iStart := Length(ScriptList.text) + Length('function ' + tmpStr+'()') +3;
       if TComboBox(Sender).items.indexof(tmpStr) = -1 then
       begin
         ScriptList.Add('function ' + tmpStr+'()');
         ScriptList.Add('');
         ScriptList.Add('end');
         ScriptList.Add('');
         TComboBox(Sender).items.add(tmpStr);
       end;
       TComboBox(Sender).ItemIndex := TComboBox(Sender).Items.IndexOf(tmpStr);

    end
    else
      iStart := Pos('function ' + tmpStr+'()',ScriptList.text) + Length('function ' + tmpStr+'()') + 2;

    frmScript.mmEventScr.lines.Text := ScriptList.Text;
 //   frmScript.mmEventScr.setfocus;
    frmScript.mmEventScr.SelStart := iStart;
    frmScript.ShowModal;
    ScriptList.text := frmScript.mmEventScr.lines.Text;
end;

procedure TfrmNPCProp.RegisterEvent(evnt: string);
var
   iLoop : integer;
   EventStart: integer;
begin
  EventStart := -1;
  for iLoop := 0 to ScriptList.Count -1 do
  begin
      if EventStart > -1 then continue; //lots of 'end' statements

      if LowerCase(ScriptList.strings[iLoop]) = 'function loadevents()' then
      EventStart := iLoop;
  end;
  ScriptList.Insert(EventStart+1,'regEvent("'+ edtGUID.text+'","'+evnt+'");');
end;
procedure TfrmNPCProp.edtMagResistExit(Sender: TObject);
begin
     if strTokenCount(TNumEdit(Sender).Text,'.') > 1 then
      TNumEdit(Sender).Text := '0';
end;

procedure TfrmNPCProp.SetStatic;
begin
      Caption := 'Static Properties';
      tsCharacter.enabled := false;
      tsCmmon.enabled := false;
      tsEvents.enabled := false;
      tsCharacter.Tabvisible := false;
      tsCmmon.Tabvisible := false;
      tsEvents.Tabvisible := false;
      tsStatic.enabled := true;
      tsStatic.Tabvisible := true;
      PageControl1.ActivePageIndex := 3;
end;

procedure TfrmNPCProp.pnAmbientColorClick(Sender: TObject);
var
  L : Longint;

begin
 if cDialog.Execute then
 begin
     pnAmbientColor.Color := cDialog.Color;
     L := ColorToRGB(cDialog.Color);
     edtRed.text := IntToStr(GetRValue(L));
     edtGreen.text := IntToStr(GetGValue(L));
     edtBlue.text := IntToStr(GetBValue(L));
 end;


end;

procedure TfrmNPCProp.UpdateSprites;
var
   iLoop: integer;
begin
     if bLoading then exit;

     for iLoop := 0 to SelectedList.count -1 do
     begin
     //  TSprite(SelectedList.Items[iLoop]).x := StrToInt(frmNPCProp.edtX.text);
     //  TSprite(SelectedList.Items[iLoop]).y := StrToInt(frmNPCProp.edtY.text);
       if NameChange then
       TSprite(SelectedList.Items[iLoop]).DisplayName := edtNPCName.text;
       if FacingChange  then
       TSprite(SelectedList.Items[iLoop]).Facing := cbFacing.ItemIndex;
       if cbGroupID.text <> '' then
       TSprite(SelectedList.Items[iLoop]).GroupID := StrToInt(cbGroupID.text);

       TSprite(SelectedList.Items[iLoop]).Layer := cbLayer.ItemIndex;
       //Color/Blend
       if edtRed.text <> '' then
       TSprite(SelectedList.Items[iLoop]).Red := StrToInt(edtRed.text);
       if edtBlue.text <> '' then
       TSprite(SelectedList.Items[iLoop]).Blue := StrToInt(edtBlue.text);
       if edtGreen.text <> '' then
       TSprite(SelectedList.Items[iLoop]).Green := StrToInt(edtGreen.text);
       if edtBlend.text <> '' then
       TSprite(SelectedList.Items[iLoop]).Blend := StrToInt(edtBlend.text);

       if TSprite(SelectedList.Items[iLoop]).SpriteType = stNPC then
       begin
         TSprite(SelectedList.Items[iLoop]).spellID := strToInt(strTokenAt(cbSpells.text,'=',1));
         TSprite(SelectedList.Items[iLoop]).CharType := cbClass.ItemIndex;
         TSprite(SelectedList.Items[iLoop]).AttRating := cbAttRating.ItemIndex;
         TSprite(SelectedList.Items[iLoop]).HealthRating := cbHealthRating.ItemIndex;
         TSprite(SelectedList.Items[iLoop]).DefRating := cbDefRating.ItemIndex;
         TSprite(SelectedList.Items[iLoop]).MoveRating := cbMoveRating.ItemIndex;
         TSprite(SelectedList.Items[iLoop]).MagResist := '0.'+ edtMagResist.Text;
         TSprite(SelectedList.Items[iLoop]).PhyResist := '0.'+ edtPhyResist.Text;
         TSprite(SelectedList.Items[iLoop]).MinDamage := StrToInt(editMin.text);
         TSprite(SelectedList.Items[iLoop]).HitPoints := StrToInt(edtHits.text);
         TSprite(SelectedList.Items[iLoop]).MaxDamage := StrToInt(edtMax.text);
         TSprite(SelectedList.Items[iLoop]).Movement :=  StrToInt(cbMove.Text);
       end;

        //Script
       TSprite(SelectedList.Items[iLoop]).OnActivate := cbOnActivate.text;
       TSprite(SelectedList.Items[iLoop]).OnAttacked :=  cbOnAttacked.text;
       TSprite(SelectedList.Items[iLoop]).OnClose := cbOnClose.text;
       TSprite(SelectedList.Items[iLoop]).OnDie := cbOnDie.text;
       TSprite(SelectedList.Items[iLoop]).OnFirstAttacked := cbOnFirstAttacked.text;
       TSprite(SelectedList.Items[iLoop]).OnLoad := cbOnLoad.text;
       TSprite(SelectedList.Items[iLoop]).OnOpen := cbOnOpen.text;
       TSprite(SelectedList.Items[iLoop]).CombatScript := cbOnCombat.text;
       TSprite(SelectedList.Items[iLoop]).IdleScript := cbOnIdle.text;
     end;

end;

procedure TfrmNPCProp.edtNPCNameChange(Sender: TObject);
begin
     UpdateSprites();
end;


procedure TfrmNPCProp.edtFrameIndxChange(Sender: TObject);
begin
     UpdateStatics();
end;

procedure TfrmNPCProp.UpdateStatics;
var
   iLoop: integer;
begin
 for iLoop := 0 to SelectedList.count -1 do
     begin
       if cbStGroupID.text <> '' then
       TStatic(SelectedList.Items[iLoop]).GroupID := StrToInt(cbStGroupID.text);

       TStatic(SelectedList.Items[iLoop]).Layer := cbStLayer.ItemIndex;

       if edtLength.text <> '' then
       TStatic(SelectedList.Items[iLoop]).Length := StrToInt(edtLength.text);
       if edtWidth.text <> '' then
       TStatic(SelectedList.Items[iLoop]).Width := StrToInt(edtWidth.text);
       if edtFrameIndx.text <> '' then
       TStatic(SelectedList.Items[iLoop]).Frame := edtFrameIndx.text;
       if edtDrawOrder.text <> '' then
       TStatic(SelectedList.Items[iLoop]).DrawOrder := StrToInt(edtDrawOrder.text);

       if edtStRed.text <> '' then
       TStatic(SelectedList.Items[iLoop]).Red := StrToInt(edtStRed.text);
       if edtStBlue.text <> '' then
       TStatic(SelectedList.Items[iLoop]).Blue := StrToInt(edtStBlue.text);
       if edtStGreen.text <> '' then
       TStatic(SelectedList.Items[iLoop]).Green := StrToInt(edtStGreen.text);
       if edtStBlend.text <> '' then
       TStatic(SelectedList.Items[iLoop]).Blend := StrToInt(edtStBlend.text);
       TStatic(SelectedList.Items[iLoop]).Shadow := cbShadow.Checked;
     end;
end;

procedure TfrmNPCProp.SetupStatic(var StaticList: TList);
var
 MyStatic: TStatic;
 iLoop : integer;
begin
     bLoading := true;
     NameChange := false;
     FacingChange := false;
     SelectedList := StaticList;

     SetStatic();

     //Get the first select sprite
     MyStatic := TStatic(StaticList.Items[0]);

     BuildGroupList();

     lblStX.caption := 'X = ' +IntToStr(MyStatic.x);
     lblStY.caption := 'Y = ' +IntToStr(MyStatic.y);
     if MyStatic.GroupID > -1 then
        cbStGroupID.text := IntToStr(MyStatic.GroupID)
     else
        cbStGroupID.text := '';
     cbStLayer.ItemIndex := MyStatic.Layer;
     edtLength.text := IntToStr(MyStatic.Length);
     edtWidth.text := IntToStr(MyStatic.Width);
     edtFrameIndx.text := MyStatic.Frame;
     edtDrawOrder.text := IntToStr(MyStatic.DrawOrder);
     edtStRed.text := IntToStr(MyStatic.Red);
     edtStBlue.text := IntToStr(MyStatic.Blue);
     edtStGreen.text := IntToStr(MyStatic.Green);
     edtStBlend.text := IntToStr(MyStatic.Blend);
     cbShadow.Checked := MyStatic.Shadow;
    
end;

procedure TfrmNPCProp.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
     CanClose := false;
     Hide;
end;

end.

