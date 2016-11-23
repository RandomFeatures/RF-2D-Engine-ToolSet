unit staticlist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SQLiteTable3;

type
  TfrmStaticList = class(TForm)
    lbStaticFiles: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iStaticID: integer;
    slLookup: TStringList;
    procedure Setup(strDatabase: string);

  end;

var
  frmStaticList: TfrmStaticList;

implementation

{$R *.DFM}

procedure TfrmStaticList.Setup(strDatabase: string);
var
objDB: TSQLiteDatabase;
objDS: TSQLIteTable;
strSQL: String;
begin
     slLookup := TStringList.create();
     iStaticID := -1;
     lbStaticFiles.Clear;
     objDB := TSQLiteDatabase.Create(strDatabase);

     //Static File
     strSQL := 'SELECT [StaticID], [FileName] ' +
               'FROM [tblISO_StaticFiles] NOLOCK;';
     objDS := objDB.GetTable(strSQL);
     if objDS.Count > 0 then
     begin
         while not objDS.EOF do
         begin
              try
                slLookup.Add(objDS.FieldAsString(objDS.FieldIndex['FileName']));
                slLookup.Values[objDS.FieldAsString(objDS.FieldIndex['FileName'])] := objDS.FieldAsString(objDS.FieldIndex['StaticID']);
                lbStaticFiles.Items.Add(objDS.FieldAsString(objDS.FieldIndex['FileName']));
              finally
                 objDS.Next;
              end;
         end;
     end;
     objDS.free;
     objDB.free;
     
end;

procedure TfrmStaticList.Button2Click(Sender: TObject);
begin
     close;
end;

procedure TfrmStaticList.Button1Click(Sender: TObject);
begin

     if lbStaticFiles.ItemIndex > -1 then
     begin
        iStaticID := StrToInt(slLookup.Values[lbStaticFiles.Items[lbStaticFiles.ItemIndex]]);
     end;
     close;
end;

end.
