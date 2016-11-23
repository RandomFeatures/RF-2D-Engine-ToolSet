object frmMapList: TfrmMapList
  Left = 507
  Top = 414
  Width = 370
  Height = 507
  Caption = 'Map List'
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
  object Label1: TLabel
    Left = 8
    Top = 368
    Width = 56
    Height = 13
    Caption = 'Description:'
  end
  object Label2: TLabel
    Left = 8
    Top = 320
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object Label3: TLabel
    Left = 8
    Top = 344
    Width = 50
    Height = 13
    Caption = 'May Type:'
  end
  object Label4: TLabel
    Left = 72
    Top = 320
    Width = 193
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 72
    Top = 344
    Width = 193
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 72
    Top = 368
    Width = 193
    Height = 97
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object lblMapList: TListBox
    Left = 8
    Top = 16
    Width = 257
    Height = 289
    ItemHeight = 13
    TabOrder = 0
    OnClick = lblMapListClick
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
