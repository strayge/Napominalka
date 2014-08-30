object frmMain: TfrmMain
  Left = 277
  Top = 147
  Width = 361
  Height = 379
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSizeToolWin
  Caption = #1053#1072#1087#1086#1084#1080#1085#1072#1083#1082#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = menuMain
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 337
    Height = 281
    TabStop = False
    BorderStyle = bsNone
    Color = clBtnFace
    Ctl3D = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HideSelection = False
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    WantReturns = False
    WordWrap = False
  end
  object btnOk: TButton
    Left = 96
    Top = 296
    Width = 169
    Height = 25
    Caption = #1054#1082
    TabOrder = 1
    OnClick = btnOkClick
  end
  object tmUpdDate: TTimer
    Interval = 60000
    OnTimer = tmUpdDateTimer
    Left = 8
    Top = 296
  end
  object menuMain: TMainMenu
    Left = 40
    Top = 296
    object menuSettings: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      OnClick = menuSettingsClick
    end
    object menuEditDates: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1090#1099
      OnClick = menuEditDatesClick
    end
    object menuAbout: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnClick = menuAboutClick
    end
    object menuExit: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = menuExitClick
    end
  end
end
