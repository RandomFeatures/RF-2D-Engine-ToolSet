object frmCharacterFiles: TfrmCharacterFiles
  Left = 253
  Top = 226
  Width = 432
  Height = 332
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Character Files'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 273
    Top = 15
    Width = 137
    Height = 233
    BevelOuter = bvLowered
    Color = clInactiveCaption
    TabOrder = 0
    object imgPreview: TImage
      Left = 1
      Top = 1
      Width = 135
      Height = 231
      Align = alClient
      Center = True
      Transparent = True
    end
  end
  object lbStaticFiles: TListBox
    Left = 8
    Top = 16
    Width = 257
    Height = 265
    ItemHeight = 13
    TabOrder = 1
    OnClick = lbStaticFilesClick
  end
  object Button1: TButton
    Left = 272
    Top = 256
    Width = 65
    Height = 25
    Caption = 'Select'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 344
    Top = 256
    Width = 66
    Height = 25
    Caption = 'Close'
    TabOrder = 3
    OnClick = Button2Click
  end
end
