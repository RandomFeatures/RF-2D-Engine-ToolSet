unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtDlgs, StdCtrls, NGImages, NGConst,dirscanner, PBFolderDialog,
  FileScanner;

type
  TForm1 = class(TForm)
    Button1: TButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenPictureDialog;
    PBFolderDialog: TPBFolderDialog;
    Button2: TButton;
    FileScanner: TFileScanner;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FileScannerFoundFile(Filename: String);
    procedure Button3Click(Sender: TObject);
  private
    procedure Convert(openName, saveName: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
     screen.Cursor := crHourGlass;
     if OpenDialog.Execute then
     begin
         SaveDialog.FileName := ChangeFileExt(OpenDialog.FileName,'.png');
         SaveDialog.InitialDir := ExtractFilePath(OpenDialog.FileName);
         if SaveDialog.Execute then
            Convert(OpenDialog.FileName, SaveDialog.FileName);
     end;
     screen.Cursor := crDefault;
end;

procedure TForm1.Convert(openName: string; saveName: string);
var
   MyBmp: TBitmap;
   NG : TNGImage;
   mColor: Tcolor;
begin
     mColor := 16745215;
     MyBmp := TBitmap.Create;
     MyBmp.LoadFromFile(openName);
     NG := TNGImage.Create;
     NG.Assign(MyBmp);
     NG.SetAlphaColor(mColor);
     //NG.TransparentColor := mcolor;
     //NG.Transparent := true;
     NG.SaveToPNGfile(saveName);
     NG.Free;
     myBmp.FreeImage;
     MyBmp.Free;
end;
procedure TForm1.Button2Click(Sender: TObject);
begin
     showmessage('Just so you know I had to boot to windows to make this thing');
     screen.Cursor := crHourGlass;
     if PBFolderDialog.Execute then
     begin
        FileScanner.ProcessDirectory(PBFolderDialog.Folder);
     end;
     ShowMessage('Process Complete');
     screen.Cursor := crDefault;
end;


procedure TForm1.FileScannerFoundFile(Filename: String);
begin
    Convert(FileName,ChangeFileExt(FileName,'.png'));
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
     screen.Cursor := crDefault;
     close;
end;

end.
