object frmStaticProp: TfrmStaticProp
  Left = 592
  Top = 751
  BorderStyle = bsToolWindow
  Caption = 'Static Properties'
  ClientHeight = 209
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblX: TLabel
    Left = 8
    Top = 48
    Width = 31
    Height = 13
    Caption = 'X = 0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblY: TLabel
    Left = 112
    Top = 48
    Width = 31
    Height = 13
    Caption = 'Y = 0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 105
    Width = 43
    Height = 13
    Caption = 'Group ID'
  end
  object Label1: TLabel
    Left = 8
    Top = 65
    Width = 33
    Height = 13
    Caption = 'Length'
  end
  object Label2: TLabel
    Left = 112
    Top = 65
    Width = 28
    Height = 13
    Caption = 'Width'
  end
  object Label3: TLabel
    Left = 8
    Top = 9
    Width = 52
    Height = 13
    Caption = 'Frame Indx'
  end
  object Label4: TLabel
    Left = 112
    Top = 9
    Width = 54
    Height = 13
    Caption = 'Draw Order'
  end
  object Label5: TLabel
    Left = 216
    Top = 9
    Width = 20
    Height = 13
    Caption = 'Red'
  end
  object Label8: TLabel
    Left = 320
    Top = 9
    Width = 21
    Height = 13
    Caption = 'Blue'
  end
  object Label9: TLabel
    Left = 216
    Top = 49
    Width = 29
    Height = 13
    Caption = 'Green'
  end
  object Label10: TLabel
    Left = 320
    Top = 49
    Width = 27
    Height = 13
    Caption = 'Blend'
  end
  object Label7: TLabel
    Left = 112
    Top = 103
    Width = 26
    Height = 13
    Caption = 'Layer'
  end
  object btnSave: TButton
    Left = 276
    Top = 174
    Width = 75
    Height = 25
    Caption = 'Save'
    Default = True
    TabOrder = 4
    OnClick = btnSaveClick
  end
  object cbGroupID: TComboBox
    Left = 8
    Top = 119
    Width = 89
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 360
    Top = 174
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object edtLength: TNumEdit
    Left = 8
    Top = 79
    Width = 89
    Height = 21
    TabOrder = 1
  end
  object edtWidth: TNumEdit
    Left = 112
    Top = 79
    Width = 89
    Height = 21
    TabOrder = 2
  end
  object edtDrawOrder: TNumEdit
    Left = 112
    Top = 23
    Width = 89
    Height = 21
    TabOrder = 0
  end
  object edtRed: TNumEdit
    Left = 216
    Top = 23
    Width = 89
    Height = 21
    TabOrder = 6
  end
  object edtBlue: TNumEdit
    Left = 320
    Top = 23
    Width = 89
    Height = 21
    TabOrder = 7
  end
  object edtGreen: TNumEdit
    Left = 216
    Top = 63
    Width = 89
    Height = 21
    TabOrder = 8
  end
  object edtBlend: TNumEdit
    Left = 320
    Top = 63
    Width = 89
    Height = 21
    TabOrder = 9
  end
  object cbLayer: TComboBox
    Left = 112
    Top = 119
    Width = 89
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    MaxLength = 20
    Sorted = True
    TabOrder = 10
    Items.Strings = (
      '0 - Below Ground'
      '1 - Ground'
      '2 - World'
      '3 - Roof')
  end
  object cbShadow: TCheckBox
    Left = 216
    Top = 96
    Width = 89
    Height = 17
    Caption = 'Shadow'
    Checked = True
    State = cbChecked
    TabOrder = 11
  end
  object edtFrameIndx: TEdit
    Left = 8
    Top = 23
    Width = 89
    Height = 21
    TabOrder = 12
  end
  object pnAmbientColor: TPanel
    Left = 320
    Top = 88
    Width = 41
    Height = 25
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 13
    OnClick = pnAmbientColorClick
  end
  object cDialog: TColorDialog
    Ctl3D = True
    Left = 184
    Top = 49
  end
end
