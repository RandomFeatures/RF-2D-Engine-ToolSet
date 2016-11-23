object frmFrameEdit: TfrmFrameEdit
  Left = 485
  Top = 362
  Width = 410
  Height = 345
  Caption = 'Frame Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 402
    Height = 311
    Align = alClient
    TabOrder = 0
    OnMouseDown = ScrollBox1MouseDown
    OnMouseMove = ScrollBox1MouseMove
    OnMouseUp = ScrollBox1MouseUp
    object imgMain: TImage
      Left = 3
      Top = 3
      Width = 105
      Height = 105
      OnMouseDown = imgMainMouseDown
      OnMouseMove = imgMainMouseMove
      OnMouseUp = imgMainMouseUp
    end
  end
end
