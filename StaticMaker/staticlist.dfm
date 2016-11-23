object frmStaticList: TfrmStaticList
  Left = 604
  Top = 411
  BorderStyle = bsToolWindow
  Caption = 'Static Files'
  ClientHeight = 306
  ClientWidth = 356
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
  object lbStaticFiles: TListBox
    Left = 8
    Top = 16
    Width = 257
    Height = 265
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = Button1Click
  end
  object Button1: TButton
    Left = 272
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 272
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 2
    OnClick = Button2Click
  end
end
