object frmAbout: TfrmAbout
  Left = 453
  Top = 290
  BorderStyle = bsToolWindow
  Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
  ClientHeight = 145
  ClientWidth = 271
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblName: TLabel
    Left = 40
    Top = 13
    Width = 90
    Height = 16
    Caption = #1053#1072#1087#1086#1084#1080#1085#1072#1083#1082#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object lblDescription: TLabel
    Left = 8
    Top = 40
    Width = 254
    Height = 13
    Caption = #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1082#1072' '#1085#1072#1087#1086#1084#1080#1085#1072#1077#1090' '#1086' '#1076#1085#1103#1093' '#1088#1086#1078#1076#1077#1085#1080#1103#1093
  end
  object lblAuthor: TLabel
    Left = 8
    Top = 64
    Width = 191
    Height = 13
    Caption = #1040#1074#1090#1086#1088' '#1089#1077#1081' '#1087#1086#1083#1077#1079#1085#1086#1081' '#1087#1088#1086#1075#1088#1072#1084#1099': Str@y'
  end
  object lblContactText: TLabel
    Left = 8
    Top = 88
    Width = 89
    Height = 13
    Caption = #1057#1074#1103#1079#1100' '#1089' '#1072#1074#1090#1086#1088#1086#1084':'
  end
  object lblContactMail: TLabel
    Left = 104
    Top = 88
    Width = 108
    Height = 13
    Cursor = crHandPoint
    Caption = 'stray.omsk@gmail.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = lblContactMailClick
  end
  object lblVersion: TLabel
    Left = 138
    Top = 13
    Width = 19
    Height = 16
    Caption = 'V. '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object btnOk: TButton
    Left = 56
    Top = 112
    Width = 161
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1083' '#1082' '#1089#1074#1077#1076#1077#1085#1080#1102
    TabOrder = 0
    OnClick = btnOkClick
  end
end
