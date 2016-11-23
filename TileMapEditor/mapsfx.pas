unit mapsfx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, EditPlus, GameObjects, SQLiteTable3, strFunctions, ComCtrls;

type
  TfrmSFX = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    lbSFXList: TListBox;
    txtInterval: TEditPlus;
    chkLoopSound: TCheckBox;
    cbSFXList: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label4: TLabel;
    chkRandomInterval: TCheckBox;
    lbMusicList: TListBox;
    cbMusicList: TComboBox;
    Button3: TButton;
    Button4: TButton;
    Label3: TLabel;
    chkRandomOrder: TCheckBox;
    Button5: TButton;
    tbPan: TTrackBar;
    Label2: TLabel;
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure tbPanChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    SFXProperties: TSFX;
    slLookup: TStringList;
    objDB: TSQLiteDatabase;
    iEncounterID: integer;
    slNameLookup: TStringList;
    procedure Setup(strDatabase: string);
    procedure Reset();
  end;

var
  frmSFX: TfrmSFX;

implementation

{$R *.DFM}

procedure TfrmSFX.Button5Click(Sender: TObject);
begin
     Hide;
end;

procedure TfrmSFX.Button1Click(Sender: TObject);
var
   MySFX: TSFX;
   tmpStr: string;
begin
    if cbSFXList.ItemIndex > -1 then
    begin

     MySFX := TSFX.Create();
     MySFX.GenerateGUID;
     MySFX.Pan := tbPan.Position;
     MySFX.Inter := StrToInt(txtInterval.text);
     if chkRandomInterval.Checked then
        MySFX.Rand := 1
     else
         MySFX.Rand := 0;
     if chkLoopSound.Checked then
        MySFX.Loop := 1
     else
         MySFX.Loop := 0;

     tmpStr := slLookup.Values[cbSFXList.Items[cbSFXList.ItemIndex]];
     MySFX.SfxID := StrToInt(StrTokenAt(tmpStr,'|',0));
     MySFX.SFXType := StrToInt(StrTokenAt(tmpStr,'|',1));
     MySFX.SFXName :=  cbSFXList.Items[cbSFXList.ItemIndex];
     lbSFXList.Items.AddObject(MySFX.SFXName,MySFX);
     //reset for next
     cbSFXList.ItemIndex := -1;
     tbPan.Position :=0;
     txtInterval.text  := '0';
     chkRandomInterval.Checked := false;
     chkLoopSound.Checked := false;
    end;
end;

procedure TfrmSFX.Setup(strDatabase: string);
var
objDS: TSQLIteTable;
strSQL: String;
tmpStr: String;
strMapType: String;
begin
     tbPan.Position :=0;
     chkRandomInterval.Checked := false;
     chkLoopSound.Checked := false;
     chkRandomOrder.Checked := false;
     lbMusicList.Clear;
     lbSFXList.Clear;
     slLookup := TStringList.create();
     slNameLookup := TStringList.create();
     cbSFXList.Clear;
     cbMusicList.Clear;
     objDB := TSQLiteDatabase.Create(strDatabase);

     //SFX list
     strSQL := 'SELECT  [SFXID], [FileName], [SFXType] '+
               'FROM  [tblISO_SoundFX] NOLOCK ' +
               'WHERE [Active]=1 AND [SFXType] IN (4,5);';
     objDS := objDB.GetTable(strSQL);
     if objDS.Count > 0 then
     begin
         while not objDS.EOF do
         begin
              try
                slLookup.Add(objDS.FieldAsString(objDS.FieldIndex['FileName']));
                tmpStr := objDS.FieldAsString(objDS.FieldIndex['SFXID']) +'|'+  objDS.FieldAsString(objDS.FieldIndex['SFXType']);
                slLookup.Values[objDS.FieldAsString(objDS.FieldIndex['FileName'])] := tmpStr;
                slNameLookup.Add(objDS.FieldAsString(objDS.FieldIndex['SFXID']));
                slNameLookup.Values[objDS.FieldAsString(objDS.FieldIndex['SFXID'])] := objDS.FieldAsString(objDS.FieldIndex['FileName']);
                if  objDS.FieldAsString(objDS.FieldIndex['SFXType']) = '4' then
                  cbSFXList.Items.Add(objDS.FieldAsString(objDS.FieldIndex['FileName']))
                else
                  cbMusicList.Items.Add(objDS.FieldAsString(objDS.FieldIndex['FileName']));
              finally
                 objDS.Next;
              end;
         end;
     end;
     objDS.free;


end;

procedure TfrmSFX.Button4Click(Sender: TObject);
var
   MySFX: TSFX;
   tmpStr: string;
begin
    if cbMusicList.ItemIndex > -1 then
    begin

     MySFX := TSFX.Create();
     MySFX.GenerateGUID;
     if chkRandomOrder.Checked then
        MySFX.Rand := 1
     else
         MySFX.Rand := 0;

     tmpStr := slLookup.Values[cbMusicList.Items[cbMusicList.ItemIndex]];
     MySFX.SfxID := StrToInt(StrTokenAt(tmpStr,'|',0));
     MySFX.SFXType := StrToInt(StrTokenAt(tmpStr,'|',1));
     MySFX.SFXName :=  cbMusicList.Items[cbMusicList.ItemIndex];
     lbMusicList.Items.AddObject(MySFX.SFXName,MySFX);

     chkRandomOrder.Checked := false;
     cbMusicList.ItemIndex := -1;
    end;
end;



procedure TfrmSFX.FormDestroy(Sender: TObject);
begin
    // objDB.Free;
     //slLookup.Clear;
     //slLookup.Free;
end;

procedure TfrmSFX.Button2Click(Sender: TObject);
var
   MySFX: TSFX;
begin
     if lbSFXList.ItemIndex > - 1 then
     begin
          MySFX := TSFX(lbSFXList.Items.Objects[lbSFXList.ItemIndex]);

          tbPan.Position := MySFX.Pan;
          txtInterval.text := IntToStr(MySFX.Inter);
          if MySFX.Rand = 1 then
            chkRandomInterval.Checked := true
          else
             chkRandomInterval.Checked := false;

          if MySFX.Loop = 1 then
            chkLoopSound.Checked := true
          else
             chkLoopSound.Checked := false;

          cbSFXList.ItemIndex := cbSFXList.Items.IndexOf(MySFX.SFXName);
          lbSFXList.Items.Objects[lbSFXList.ItemIndex].Free;
          lbSFXList.Items.Delete(lbSFXList.ItemIndex);
     end;

end;

procedure TfrmSFX.Button3Click(Sender: TObject);
var
   MySFX: TSFX;
begin
      if lbMusicList.ItemIndex > -1 then
      begin
           MySFX := TSFX(lbMusicList.Items.Objects[lbMusicList.ItemIndex]);
           cbMusicList.ItemIndex := cbMusicList.Items.IndexOf(MySFX.SFXName);
           lbMusicList.Items.Objects[lbMusicList.ItemIndex].Free;
           lbMusicList.Items.Delete(lbMusicList.ItemIndex);
      end;
end;

procedure TfrmSFX.tbPanChange(Sender: TObject);
begin
     Label2.Caption := 'Pan ('+IntToStr(tbPan.Position) +')';
end;

procedure TfrmSFX.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     CanClose := false;
     Hide;
end;

procedure TfrmSFX.Reset;
var
  iLoop: integer;
begin
     for iLoop:=0 to lbMusicList.items.count -1 do
     begin
           lbMusicList.Items.Objects[iLoop].Free;
     end;
     lbMusicList.Clear;

     for iLoop:=0 to lbSFXList.items.count -1 do
     begin
           lbSFXList.Items.Objects[iLoop].Free;
     end;
     lbSFXList.Clear;
end;

end.
