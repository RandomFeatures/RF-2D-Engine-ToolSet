object frmMapProp: TfrmMapProp
  Left = 332
  Top = 371
  BorderStyle = bsToolWindow
  Caption = 'Map Properties'
  ClientHeight = 283
  ClientWidth = 668
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
  object GroupBox2: TGroupBox
    Left = 4
    Top = 2
    Width = 341
    Height = 263
    Caption = 'Map'
    TabOrder = 1
    object Label2: TLabel
      Left = 37
      Top = 22
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object Label3: TLabel
      Left = 41
      Top = 52
      Width = 27
      Height = 13
      Caption = 'Type:'
    end
    object Label10: TLabel
      Left = 208
      Top = 189
      Width = 64
      Height = 13
      Caption = 'Snow Flakes:'
    end
    object Label9: TLabel
      Left = 223
      Top = 53
      Width = 49
      Height = 13
      Caption = 'Army Size:'
    end
    object Label13: TLabel
      Left = 24
      Top = 188
      Width = 44
      Height = 13
      Caption = 'Wind Dir:'
    end
    object Label11: TLabel
      Left = 8
      Top = 232
      Width = 60
      Height = 13
      Caption = 'Cloud Blend:'
    end
    object Label12: TLabel
      Left = 216
      Top = 208
      Width = 18
      Height = 13
      Alignment = taRightJustify
      Caption = '100'
    end
    object Label1: TLabel
      Left = 12
      Top = 80
      Width = 56
      Height = 13
      Caption = 'Description:'
    end
    object edtName: TEdit
      Left = 80
      Top = 18
      Width = 241
      Height = 21
      TabOrder = 0
    end
    object cbMapType: TComboBox
      Left = 80
      Top = 48
      Width = 113
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        'Menu Background'
        'Single Player'
        'Multi Player')
    end
    object cbShadows: TCheckBox
      Left = 240
      Top = 226
      Width = 89
      Height = 17
      Caption = 'Use Shadows'
      TabOrder = 2
    end
    object edtSnow: TNumEdit
      Left = 280
      Top = 184
      Width = 41
      Height = 21
      TabOrder = 3
    end
    object edtArmySize: TNumEdit
      Left = 280
      Top = 48
      Width = 41
      Height = 21
      TabOrder = 4
    end
    object cbWindDir: TComboBox
      Left = 80
      Top = 184
      Width = 113
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      Items.Strings = (
        'NW'
        'NN'
        'NE'
        'EE'
        'SE'
        'SS'
        'SW'
        'WW')
    end
    object tbCloudBlend: TTrackBar
      Left = 72
      Top = 224
      Width = 169
      Height = 33
      Max = 100
      Orientation = trHorizontal
      Frequency = 5
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 6
      TickMarks = tmBottomRight
      TickStyle = tsAuto
    end
    object edtDesc: TMemo
      Left = 80
      Top = 80
      Width = 241
      Height = 97
      TabOrder = 7
    end
  end
  object GroupBox1: TGroupBox
    Left = 352
    Top = 148
    Width = 225
    Height = 57
    Caption = 'Ambient Light Properties'
    TabOrder = 0
    object Label4: TLabel
      Left = 16
      Top = 24
      Width = 65
      Height = 13
      Caption = 'Ambient Color'
    end
    object pnAmbientColor: TPanel
      Left = 88
      Top = 16
      Width = 41
      Height = 25
      BevelOuter = bvLowered
      Color = clWhite
      TabOrder = 0
      OnClick = pnAmbientColorClick
    end
  end
  object btnCancel: TButton
    Left = 584
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnSave: TButton
    Left = 584
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 3
    OnClick = btnSaveClick
  end
  object GroupBox3: TGroupBox
    Left = 352
    Top = 2
    Width = 225
    Height = 143
    Caption = 'Fog Properties'
    TabOrder = 4
    object Label5: TLabel
      Left = 8
      Top = 72
      Width = 27
      Height = 13
      Caption = 'Color:'
    end
    object Label6: TLabel
      Left = 192
      Top = 48
      Width = 18
      Height = 13
      Alignment = taRightJustify
      Caption = '100'
    end
    object Label7: TLabel
      Left = 8
      Top = 28
      Width = 27
      Height = 13
      Caption = 'Type:'
    end
    object Label8: TLabel
      Left = 8
      Top = 108
      Width = 39
      Height = 13
      Caption = 'Texture:'
    end
    object pnlFogColor: TPanel
      Left = 40
      Top = 64
      Width = 41
      Height = 25
      BevelOuter = bvLowered
      Color = clWhite
      TabOrder = 0
      OnClick = pnlFogColorClick
    end
    object tbFogBlend: TTrackBar
      Left = 80
      Top = 64
      Width = 137
      Height = 33
      Max = 100
      Orientation = trHorizontal
      Frequency = 5
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 1
      TickMarks = tmBottomRight
      TickStyle = tsAuto
    end
    object cbFogType: TComboBox
      Left = 40
      Top = 24
      Width = 169
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        'None'
        'Ground Fog'
        'Full Fog')
    end
    object cbFogTexture: TComboBox
      Left = 56
      Top = 104
      Width = 153
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      Items.Strings = (
        'Fog Texture 0'
        'Fog Texture 1'
        'Fog Texture 2'
        'Fog Texture 3'
        ''
        '')
    end
  end
  object GroupBox4: TGroupBox
    Left = 352
    Top = 208
    Width = 225
    Height = 57
    Caption = 'Default Walk SFX'
    TabOrder = 5
    object cbWalkSfx: TComboBox
      Left = 8
      Top = 20
      Width = 201
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object cDialog: TColorDialog
    Ctl3D = True
    Left = 584
    Top = 80
  end
end
