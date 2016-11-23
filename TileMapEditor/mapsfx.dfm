object frmSFX: TfrmSFX
  Left = 359
  Top = 221
  BorderStyle = bsToolWindow
  Caption = 'Encounter Sounds'
  ClientHeight = 377
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 425
    Height = 129
    Caption = 'Ambient Music'
    TabOrder = 0
    object Label3: TLabel
      Left = 256
      Top = 16
      Width = 28
      Height = 13
      Caption = 'Music'
    end
    object lbMusicList: TListBox
      Left = 16
      Top = 16
      Width = 161
      Height = 97
      ItemHeight = 13
      TabOrder = 0
    end
    object cbMusicList: TComboBox
      Left = 256
      Top = 32
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
    end
    object Button3: TButton
      Left = 192
      Top = 80
      Width = 41
      Height = 25
      Caption = '>>'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 192
      Top = 32
      Width = 41
      Height = 25
      Caption = '<<'
      TabOrder = 3
      OnClick = Button4Click
    end
    object chkRandomOrder: TCheckBox
      Left = 256
      Top = 70
      Width = 137
      Height = 17
      Caption = 'Random Play Order'
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 144
    Width = 425
    Height = 193
    Caption = 'Ambient SFX'
    TabOrder = 1
    object Label1: TLabel
      Left = 256
      Top = 24
      Width = 62
      Height = 13
      Caption = 'Sound Effect'
    end
    object Label4: TLabel
      Left = 256
      Top = 72
      Width = 61
      Height = 13
      Caption = 'Interval (sec)'
    end
    object Label2: TLabel
      Left = 256
      Top = 136
      Width = 34
      Height = 13
      Caption = 'Pan (0)'
    end
    object lbSFXList: TListBox
      Left = 16
      Top = 24
      Width = 161
      Height = 161
      ItemHeight = 13
      TabOrder = 0
    end
    object txtInterval: TEditPlus
      Left = 256
      Top = 88
      Width = 145
      Height = 21
      TabOrder = 1
      Text = '0'
      NumbersOnly = True
      TabOnEnter = False
      FocusBGColor = clInfoBk
      FocusFontColor = clBlue
    end
    object chkLoopSound: TCheckBox
      Left = 256
      Top = 112
      Width = 81
      Height = 17
      Caption = 'Loop Sound'
      TabOrder = 2
    end
    object cbSFXList: TComboBox
      Left = 256
      Top = 40
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
    end
    object Button1: TButton
      Left = 192
      Top = 56
      Width = 41
      Height = 25
      Caption = '<<'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 192
      Top = 112
      Width = 41
      Height = 25
      Caption = '>>'
      TabOrder = 5
      OnClick = Button2Click
    end
    object chkRandomInterval: TCheckBox
      Left = 336
      Top = 70
      Width = 65
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Random'
      TabOrder = 6
    end
    object tbPan: TTrackBar
      Left = 248
      Top = 156
      Width = 169
      Height = 25
      Max = 100
      Min = -100
      Orientation = trHorizontal
      Frequency = 1
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 7
      TickMarks = tmBottomRight
      TickStyle = tsManual
      OnChange = tbPanChange
    end
  end
  object Button5: TButton
    Left = 184
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 2
    OnClick = Button5Click
  end
end
