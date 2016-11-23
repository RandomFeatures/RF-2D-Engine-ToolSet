object Form1: TForm1
  Left = 560
  Top = 241
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'The crap I volunteer to do'
  ClientHeight = 97
  ClientWidth = 194
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Convert File'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 104
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Convert All'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 64
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 2
    OnClick = Button3Click
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'png'
    Filter = 'PNG(*.png)|*.png'
    Title = 'Save a PNG'
    Left = 8
    Top = 48
  end
  object OpenDialog: TOpenPictureDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Title = 'Open a Bitmap'
    Left = 32
    Top = 48
  end
  object PBFolderDialog: TPBFolderDialog
    Flags = [ShowPath]
    NewFolderVisible = True
    NewFolderEnabled = True
    LabelCaptions.Strings = (
      'Default=Current folder:'
      '0009=Current folder:'
      '0406=Valgt mappe:'
      '0407=Ausgewählter Ordner:'
      '0409=Current folder:'
      '0410=Cartella selezionata:'
      '0413=Huidige map'
      '0416=Pasta Atual:'
      '0807=Ausgewählter Ordner:'
      '0809=Current folder:'
      '0810=Cartella selezionata:'
      '0C07=Ausgewählter Ordner:'
      '0C09=Current folder:'
      '1007=Ausgewählter Ordner:'
      '1009=Current folder:'
      '1407=Ausgewählter Ordner:'
      '1409=Current folder:'
      '1809=Current folder:'
      '1C09=Current folder:'
      '2009=Current folder:'
      '2809=Current folder:'
      '2C09=Current folder:')
    NewFolderCaptions.Strings = (
      'Default=New folder'
      '0009=New folder'
      '0406=Ny mappe'
      '0407=Neuer Ordner'
      '0409=New folder'
      '0410=Nuova Cartella'
      '0413=Nieuwe map'
      '0416=Nova Pasta'
      '0807=Neuer Ordner'
      '0809=New folder'
      '0810=Nuova Cartella'
      '0C07=Neuer Ordner'
      '0C09=New folder'
      '1007=Neuer Ordner'
      '1009=New folder'
      '1407=Neuer Ordner'
      '1409=New folder'
      '1809=New folder'
      '1C09=New folder'
      '2009=New folder'
      '2809=New folder'
      '2C09=New folder')
    Left = 136
    Top = 48
  end
  object FileScanner: TFileScanner
    FileExtension = 'bmp'
    OnFoundFile = FileScannerFoundFile
    Left = 160
    Top = 48
  end
end
