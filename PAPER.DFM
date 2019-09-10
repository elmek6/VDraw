object frmPaper: TfrmPaper
  Left = 156
  Top = 82
  BorderStyle = bsSingle
  Caption = 'frmPaper'
  ClientHeight = 385
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 424
    Top = 343
    Width = 89
    Height = 25
    Action = frmMain.dosyaCizdir
  end
  object Memo1: TMemo
    Left = 427
    Top = 11
    Width = 185
    Height = 325
    Lines.Strings = (
      '@preamp. 1.0'
      '@cizen '#214'v'#252'nc'
      'E'
      'S /200 /200'
      '@MAIN INSTANCE'
      'L /10/10/10/80'
      'L /15/15/15/50/2'
      '@POINT'
      'P /5/5/2')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object ScrollBox1: TScrollBox
    Left = 16
    Top = 11
    Width = 389
    Height = 361
    PopupMenu = frmMain.PopupMenu1
    TabOrder = 1
    object imgMain: TImage
      Left = 0
      Top = 0
      Width = 73
      Height = 73
      Cursor = crCross
      PopupMenu = frmMain.PopupMenu1
      Stretch = True
      OnMouseDown = imgMainMouseDown
      OnMouseMove = imgMainMouseMove
      OnMouseUp = imgMainMouseUp
    end
  end
  object CheckBox1: TCheckBox
    Left = 540
    Top = 344
    Width = 73
    Height = 17
    Caption = 'DoubleBuf'
    TabOrder = 2
    OnClick = CheckBox1Click
  end
end
