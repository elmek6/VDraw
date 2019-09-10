object frmToolBox: TfrmToolBox
  Left = 163
  Top = 149
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Ara'#231'lar'
  ClientHeight = 257
  ClientWidth = 104
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 4
    Top = 168
    Width = 93
    Height = 21
    GroupIndex = 1
    Caption = 'Move'
  end
  object SpeedButton2: TSpeedButton
    Left = 4
    Top = 188
    Width = 93
    Height = 21
    GroupIndex = 1
    Caption = 'Draw'
  end
  object cmdLine: TSpeedButton
    Left = 4
    Top = 208
    Width = 93
    Height = 21
    GroupIndex = 1
    Caption = '&Line'
    OnClick = cmdShapeClick
  end
  object cmdPoint: TSpeedButton
    Left = 4
    Top = 228
    Width = 93
    Height = 21
    GroupIndex = 1
    Caption = '&Point'
    OnClick = cmdShapeClick
  end
  object cgMain: TColorGrid
    Left = 4
    Top = 4
    Width = 96
    Height = 160
    GridOrdering = go2x8
    BackgroundIndex = 15
    BackgroundEnabled = False
    TabOrder = 0
    OnClick = cgMainClick
  end
end
