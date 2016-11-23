unit options;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, StrFunctions, IniFiles, GifImage, BLImage,Registry,DFX;

type
  TfrmOptions = class(TForm)
    pcOptions: TPageControl;
    tsLayers: TTabSheet;
    cblegs1: TCheckBox;
    cblegs2: TCheckBox;
    cbHead: TCheckBox;
    cbBoots: TCheckBox;
    cbchest1: TCheckBox;
    cbchest2: TCheckBox;
    cbArms: TCheckBox;
    cbbelt: TCheckBox;
    cbchest3: TCheckBox;
    cbgauntlets: TCheckBox;
    cbouter: TCheckBox;
    cbweapon: TCheckBox;
    cbshield: TCheckBox;
    cbhelmet: TCheckBox;
    btnSaveLayers: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnSaveLayersClick(Sender: TObject);
    procedure SetComments(Gif: TGifImage; strSection, strValue: String);
    procedure ReadComments(Gif: TGifImage);
    procedure LoadPOX(POXFile: string; tmpMemInifile: TMemIniFile);
    procedure SavePOX(POXFile: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDeactivate(Sender: TObject);

  private
    { Private declarations }
   RLE: TRLESprite;
   Comments: string;

  public
    { Public declarations }
   strfileName: string;
   ImgIniFile: TMemIniFile;
   strLeftHand: string;
   strRightHand: string;
   ImgPreview : TBLImage;

  end;

var
  frmOptions: TfrmOptions;
implementation

uses BuildLayer1;

{$R *.DFM}

procedure TfrmOptions.FormShow(Sender: TObject);
var
tmpStr: string;
begin

top :=  frmBuildLayer.top + 70;
left := (frmBuildLayer.left + (frmBuildLayer.width div 2)) - width div 2 ;

if strFileName = '' then exit;

  ImgIniFile := TMemIniFile.Create('');

  LoadPOX(StrFileName,ImgIniFile);

  TmpStr := ImgIniFile.Readstring('Header', 'ValidLayers','');

  cblegs1.Checked := StrContains('leg1', TmpStr);
  cblegs2.Checked := StrContains('leg2', TmpStr);
  cbBoots.Checked := StrContains('boot', TmpStr);
  cbChest1.Checked := StrContains('chest1', TmpStr);
  cbChest2.Checked := StrContains('chest2', TmpStr);
  cbArms.Checked := StrContains('arm', TmpStr);
  cbbelt.Checked := StrContains('belt', TmpStr);
  cbchest3.Checked := StrContains('chest3', TmpStr);
  cbGauntlets.Checked := StrContains('gauntlet', TmpStr);
  cbouter.Checked := StrContains('outer', TmpStr);
  cbhead.Checked := StrContains('head', TmpStr);
  cbhelmet.Checked := StrContains('helmet', TmpStr);
  cbweapon.Checked := StrContains('weapon', TmpStr);
  cbshield.Checked := StrContains('shield', TmpStr);

end;

procedure TfrmOptions.btnSaveLayersClick(Sender: TObject);
var
tmpStr: string;
begin
tmpStr := '';
  if cblegs1.Checked Then tmpStr :='leg1'+ ',';
  if cblegs2.Checked Then tmpStr := tmpStr +'leg2'+ ',';
  if cbBoots.Checked Then tmpStr := tmpStr +'boot'+ ',';
  if cbChest1.Checked Then tmpStr := tmpStr+'chest1'+ ',';
  if cbChest2.Checked Then tmpStr := tmpStr +'chest2'+ ',';
  if cbArms.Checked Then tmpStr := tmpStr +'arm'+ ',';
  if cbbelt.Checked Then tmpStr := tmpStr +'belt'+ ',';
  if cbchest3.Checked Then tmpStr := tmpStr +'chest3'+ ',';
  if cbGauntlets.Checked Then tmpStr := tmpStr +'gauntlet'+ ',';
  if cbouter.Checked Then tmpStr := tmpStr +'outer'+ ',';
  if cbHead.Checked Then tmpStr := tmpStr +'head'+ ',';
  if cbhelmet.Checked Then tmpStr := tmpStr +'helmet'+ ',';
  if cbweapon.Checked Then tmpStr := tmpStr +'weapon'+ ',';
  if cbshield.Checked Then tmpStr := tmpStr +'shield'+ ',';

  StrStripLast(tmpStr);
  //SetComments(aGif, 'ValidLayers', TmpStr);
  ImgIniFile.WriteString('Header','ValidLayers', TmpStr);
  SavePOX(StrFileName);

  Close;
end;

procedure TfrmOptions.SetComments(Gif: TGifImage; strSection, strValue: String);
var
iLoop : integer;
jLoop: integer;
   IniFile: TMemIniFile;
   FileIni: TIniFile;
begin
      IniFile := TMemIniFile.Create('');
      with Gif do
      begin
        // Loop through all frames
        for iLoop := 0 to Images.Count-1 do
          // Loop through all extensions
          for jLoop := 0 to Images[iLoop].Extensions.Count-1 do
            // Test for comment extension
            if (Images[iLoop].Extensions[jLoop] is TGIFCommentExtension) then
            begin
              IniFile.SetStrings(TGIFCommentExtension(Images[iLoop].Extensions[jLoop]).Text);

              IniFile.WriteString('Header', strSection,strValue);

              TGIFCommentExtension(Images[iLoop].Extensions[jLoop]).Text.Clear;
              IniFile.GetStrings(TGIFCommentExtension(Images[iLoop].Extensions[jLoop]).Text);

               if FileExists(StrTokenAt(strFilename, '.',0)+ '.ini') then
               begin
                    FileIni := TIniFile.create(StrTokenAt(strFilename, '.',0)+ '.ini');
                    FileIni.WriteString('Header', strSection,strValue);
                    FileIni.free;
               end
               else
               begin
                    FileIni := TIniFile.create(StrTokenAt(strFilename, '.',0)+ '.ini');
                    copyIniFile(IniFile,FileIni);
                    FileIni.free;
               end;

               copyMemIniFile(IniFile,ImgPreview.IniFile);
               ImgPreview.InitImage;

              IniFile.free;
              exit;
            end;
      end;
end;

procedure TfrmOptions.ReadComments(Gif: TGifImage);
var
iLoop : integer;
jLoop: integer;
//strfileName
begin
      with Gif do
      begin
        // Loop through all frames
        for iLoop := 0 to Images.Count-1 do
          // Loop through all extensions
          for jLoop := 0 to Images[iLoop].Extensions.Count-1 do
            // Test for comment extension
            if (Images[iLoop].Extensions[jLoop] is TGIFCommentExtension) then
            begin
              ImgIniFile.SetStrings(TGIFCommentExtension(Images[iLoop].Extensions[jLoop]).Text);
              exit;
            end;
      end;
end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ImgIniFile.free;
imgIniFile := nil;
tsLayers.TabVisible := true;
caption :=  'INI Data Options';

end;

procedure TfrmOptions.FormDeactivate(Sender: TObject);
begin
close;
end;

procedure TfrmOptions.LoadPOX(POXFile: string; tmpMemInifile: TMemIniFile);
var
  Stream: TFileStream;
  L: longint;
  M: array [1..2] of Char;
  EOB,BB: word;
  TextOnly: boolean;
  tmpList : TStrings;
begin
  RLE.free;
  RLE:=nil;
  EOB:=$4242;
  try
    Stream:=TFileStream.create(POXFile,fmOpenRead or fmShareCompat);
    try
      TextOnly:=false;
      Stream.Read(L,sizeof(L));
      if (L<>$41584F50) then exit;
      Stream.Read(M,sizeof(M));
      Stream.Read(BB,sizeof(BB)); //CRLF
      if (M=#67#67) then begin //CC
        Stream.Read(L,sizeof(L));
      end
      else if (M=#76#67) then begin //LC
        L:=Stream.Size-Stream.Position;
        TextOnly:=true;
      end
      else if (M=#68#83) then begin //DS
        Stream.Read(L,sizeof(L));
      end
      else if (M=#83#84) then begin //ST
        Stream.Read(L,sizeof(L));
      end
      else if (M=#84#84) then begin //TT
        Stream.Read(L,sizeof(L));
      end
      else if (M=#80#82) then begin //PR
        Stream.Read(L,sizeof(L));
      end
      else if (M=#83#67) then begin //SC
        Stream.Read(L,sizeof(L));
      end
      else if (M=#76#76) then begin //LL
        Stream.Read(L,sizeof(L));
      end
      else if (M=#73#73) then begin //II
        Stream.Read(L,sizeof(L));
      end
      else if (M=#83#80) then begin //SP
        Stream.Read(L,sizeof(L));
      end
      else exit;
      SetLength(Comments,L);
      Stream.Read(Comments[1],L);
      tmpList := TStringlist.create;
      tmpList.setText(PChar(Comments));
      tmpMemInifile.SetStrings(tmpList);

      if TextOnly then begin
        RLE:=nil;
      end
      else begin
        Stream.Read(BB,sizeof(BB));
        if BB=EOB then begin
          RLE:=TRLESprite.create;
          RLE.LoadFromStream(Stream);
        end
        else begin
          exit;
        end;
      end;
    finally
      Stream.free;
    end;
  except
  end;
end;

procedure TfrmOptions.SavePOX(POXFile: string);
var
  Stream: TFileStream;
//  BM: TBitmap;
  S: string;
  TextOnly: boolean;
  L: longword;
  EOB: word;
  C: TColor;
  tmpList : TStringlist;


begin
        EOB:=$4242;
        Stream:=TFileStream.create(POXFile,fmCreate or fmShareExclusive);
        try
          TextOnly:=false;
          Stream.write(#80#79#88#65,4); //POX vA - Proprietary Object eXtension
          S:=lowercase(trim(ImgIniFile.ReadString('Header','GameClass','')));
          if (S='character') or (S='charactersprite') then
          begin
            S:=lowercase(trim(ImgIniFile.ReadString('Header','LayeredParts','')));
            if (S='yes') or (S='base') then
               Stream.write(#76#76,2); //fmt LL

            Stream.write(#13#10,2);

            tmpList := TStringlist.create;
            ImgIniFile.GetStrings(TmpList);
            s:= tmpList.text;
            tmpList.free;
            L:=Length(S);

            Stream.write(L,sizeof(L));
            Stream.write(S[1],L);
            Stream.write(EOB,sizeof(EOB));
            C:=StrToInt(lowercase(trim(ImgIniFile.ReadString('Header','TransparentColor','16776960'))));
           // result.RLE:=TRLESprite.create;
           // result.RLE.LoadFromBitmap(BM,result.FrameWidth,result.FrameHeight,C);
            //result.RLE.SaveToStream(Stream);
            RLE.SaveToStream(Stream);
            Stream.write(EOB,sizeof(EOB));
          end;
        finally
          Stream.free;
//        BM.free;
      end;
end;

end.
