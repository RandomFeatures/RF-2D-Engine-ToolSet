unit CharacterFiles;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,NGImages, SQLiteTable3, strFunctions;

type
  TfrmCharacterFiles = class(TForm)
    Panel1: TPanel;
    imgPreview: TImage;
    lbStaticFiles: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure lbStaticFilesClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    slLookup: TStringList;
    strDatabase: string;
    strTexturePath: string;
  public
    { Public declarations }
    strCharacterID: string;
    procedure Setup(strDB: string; strTexPath: string);
    procedure PreviewCharacter(strCharacterID: string);
  end;

var
  frmCharacterFiles: TfrmCharacterFiles;

implementation

{$R *.DFM}

{ TfrmCharacterFiles }

procedure TfrmCharacterFiles.Setup(strDB: string; strTexPath: string);
var
objDB: TSQLiteDatabase;
objDS: TSQLIteTable;
strSQL: String;
iIndx: integer;
begin

     ImgPreview.Picture := nil;
     ImgPreview.Refresh;
     strDatabase := strDB;
     strTexturePath :=strTexPath;
     strCharacterID := '';
     slLookup := TStringList.create();
     lbStaticFiles.Clear;
     objDB := TSQLiteDatabase.Create(strDatabase);

     strSQL := 'SELECT [CharacterID], [Description] ' +
               'FROM [tblISO_Character] NOLOCK;';
     objDS := objDB.GetTable(strSQL);
     if objDS.Count > 0 then
     begin
         while not objDS.EOF do
         begin
              try
                slLookup.Add(objDS.FieldAsString(objDS.FieldIndex['Description']));
                slLookup.Values[objDS.FieldAsString(objDS.FieldIndex['Description'])] := objDS.FieldAsString(objDS.FieldIndex['CharacterID']);
                lbStaticFiles.Items.Add(objDS.FieldAsString(objDS.FieldIndex['Description']));
              finally
                 objDS.Next;
              end;
         end;
     end;
     objDS.free;
     objDB.free;

end;


procedure TfrmCharacterFiles.PreviewCharacter(strCharacterID: string);
var
MyBitMap: TBitMap;
objDB: TSQLiteDatabase;
objDS: TSQLIteTable;
strSQL: String;
strTextureFileName: string;
FrameHeight: integer;
FrameWidth: integer;
NG : TNGImage;
SourceRect, DestRect: TRect;
PortraitFrame: integer;
begin

     objDB := TSQLiteDatabase.Create(strDatabase);


     strSQL := 'SELECT c.[CharacterID], f.[FileName], c.[PortraitFrame], f.[FrameCount], f.[Width], f.[Height] ' +
               'FROM [tblISO_Character] c ' +
               'JOIN  [tblISO_CharacterFiles] f ' +
               'ON c.[CharacterID] = f.[CharacterID] ' +
               'WHERE c.[CharacterID]=' + strCharacterID + ' AND ' +
               'f.[ActionType] = 0;';
     objDS := objDB.GetTable(strSQL);
     if objDS.Count > 0 then
     begin
          try
             FrameWidth := objDS.FieldAsInteger(objDS.FieldIndex['Width']);
             FrameHeight := objDS.FieldAsInteger(objDS.FieldIndex['Height']);
             PortraitFrame := objDS.FieldAsInteger(objDS.FieldIndex['PortraitFrame']);
             strTextureFileName :=  objDS.FieldAsString(objDS.FieldIndex['FileName']);
             strTextureFileName := StringReplace(strTextureFileName,'\\','\',[rfReplaceAll]);
             //Creat Editor Sprite Image
             MyBitMap := TBitmap.Create;
             MyBitMap.Canvas.Brush.Color := 16745215;
             MyBitMap.Width := FrameWidth;
             MyBitMap.Height := FrameHeight;

             DestRect := Rect(0,0,FrameWidth,FrameHeight);
             SourceRect := Rect(0,FrameHeight*3,FrameWidth,FrameHeight*4);
            //Load the PNG and Get the first frame
             NG := TNGImage.Create;

             NG.Transparent := true;
             NG.TransparentColor := 16745215;
             NG.SetAlphaColor(16745215);
             NG.LoadFromFile(strTexturePath + strTextureFileName);
             //Copy out the first frame for the editor
             MyBitMap.Canvas.FillRect(Rect(0,0,FrameWidth,FrameHeight));
             MyBitMap.Canvas.CopyRect(DestRect,NG.CopyBitmap.Canvas,SourceRect);
             NG.Free;
             ImgPreview.Picture := nil;
             ImgPreview.Canvas.Brush.Color := clbtnface;
             ImgPreview.Canvas.FillRect(Rect(0,0,ImgPreview.width,ImgPreview.height));
             ImgPreview.Picture.Assign(MyBitMap);
             
          finally
          end;
     end;
     objDS.free;
     objDB.free;

end;




procedure TfrmCharacterFiles.lbStaticFilesClick(Sender: TObject);
begin
    PreviewCharacter(slLookup.Values[lbStaticFiles.Items[lbStaticFiles.ItemIndex]]);
end;

procedure TfrmCharacterFiles.Button1Click(Sender: TObject);
begin
    if lbStaticFiles.ItemIndex > -1 then
    begin
          strCharacterID := slLookup.Values[lbStaticFiles.Items[lbStaticFiles.ItemIndex]];
    end;
    close;
end;

procedure TfrmCharacterFiles.Button2Click(Sender: TObject);
begin
     close;
end;

end.
