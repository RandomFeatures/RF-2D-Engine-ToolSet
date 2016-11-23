unit mapList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, SQLiteTable3,
  StdCtrls, strFunctions;

type
  TfrmMapList = class(TForm)
    lblMapList: TListBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure lblMapListClick(Sender: TObject);
  private
    { Private declarations }
     slLookup: TStringList;
     objDB: TSQLiteDatabase;
  public
    { Public declarations }
    iEncounterID: integer;
    procedure Setup(strDatabase: string);
  end;

var
  frmMapList: TfrmMapList;

implementation

{$R *.DFM}

{ TfrmMapList }

procedure TfrmMapList.Setup(strDatabase: string);
var
objDS: TSQLIteTable;
strSQL: String;
tmpStr: String;
strMapType: String;
begin
     slLookup := TStringList.create();
     iEncounterID := -1;
     lblMapList.Clear;
     objDB := TSQLiteDatabase.Create(strDatabase);

     //Static File
     strSQL := 'SELECT  [EncounterID], [MapType], [MapName], [Description]'+
                'FROM  [tblISO_Encounter] NOLOCK;';
     objDS := objDB.GetTable(strSQL);
     if objDS.Count > 0 then
     begin
         while not objDS.EOF do
         begin
              try
                case StrToInt(objDS.FieldAsString(objDS.FieldIndex['MapType'])) of
                  0: strMapType := '(Menu Bkg)';
                  1: strMapType := '(Single)';
                  2: strMapType := '(Multi)';
                end;

                slLookup.Add(objDS.FieldAsString(objDS.FieldIndex['MapName'])+strMapType);
                tmpStr := objDS.FieldAsString(objDS.FieldIndex['EncounterID']) +'|'+  objDS.FieldAsString(objDS.FieldIndex['MapType'])+'|'+
                          objDS.FieldAsString(objDS.FieldIndex['Description']) ;
                slLookup.Values[objDS.FieldAsString(objDS.FieldIndex['MapName'])+strMapType] := tmpStr;

                lblMapList.Items.Add(objDS.FieldAsString(objDS.FieldIndex['MapName'])+strMapType);
              finally
                 objDS.Next;
              end;
         end;
     end;
     objDS.free;
end;

procedure TfrmMapList.Button2Click(Sender: TObject);
begin
objDB.Free;
close;
end;

procedure TfrmMapList.Button1Click(Sender: TObject);
var
   tmpStr: string;
begin
 if lblMapList.ItemIndex > -1 then
 begin
      tmpStr := slLookup.Values[lblMapList.Items[lblMapList.ItemIndex]];
      iEncounterID := StrToInt(StrTokenAt(tmpStr,'|',0));
 end;
 objDB.Free;
 close;
end;

procedure TfrmMapList.lblMapListClick(Sender: TObject);
var
objDS: TSQLIteTable;
strSQL: String;
tmpStr: String;
strMapType: string;
begin
        tmpStr := Trim(StrTokenAt(lblMapList.Items[lblMapList.ItemIndex],'(',0));
        strSQL := 'SELECT  [EncounterID],[MapType],[MapName],[Description],[AmbientR],[AmbientG],[AmbientB],[ArmySize], '+
                  '[WalkSFX], [UseShadows],[CloudBlend],[WindDir],[Snow],[FogType],[FogBlend],[FogR],[FogG],[FogB],  '+
                  '[FogTextureID],[ScriptFile]  '+
                  'FROM  [tblISO_Encounter] '+
                  'WHERE [MapName] = "'+ tmpStr +'";';
         objDS := objDB.GetTable(strSQL);
         if objDS.Count > 0 then
         begin
               case StrToInt(objDS.FieldAsString(objDS.FieldIndex['MapType'])) of
                  0: strMapType := 'Menu Background';
                  1: strMapType := 'Single Player Map';
                  2: strMapType := 'Multiplayer Map';
                end;
              Label4.Caption := objDS.FieldAsString(objDS.FieldIndex['MapName']);
              Label5.Caption := strMapType;
              Label6.Caption := objDS.FieldAsString(objDS.FieldIndex['Description']);

         end;
         objDS.Free;
end;

end.
