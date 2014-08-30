object frmSettings: TfrmSettings
  Left = 486
  Top = 372
  BorderStyle = bsToolWindow
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 233
  ClientWidth = 406
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 10
    Top = 16
    Width = 54
    Height = 13
    Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
  end
  object lbl2: TLabel
    Left = 10
    Top = 40
    Width = 148
    Height = 13
    Caption = #1047#1072' '#1089#1082#1086#1083#1100#1082#1086' '#1076#1085#1077#1081' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100
  end
  object lbl5: TLabel
    Left = 10
    Top = 62
    Width = 92
    Height = 13
    Caption = #1047#1072#1087#1091#1089#1082' '#1089' Windows'
  end
  object sbtnExpertDown: TSpeedButton
    Left = 8
    Top = 80
    Width = 23
    Height = 22
    Glyph.Data = {
      F6000000424DF60000000000000076000000280000000C000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      0000888880088888000088880000888800008880000008880000880008800088
      0000800088880008000000088888800000000088800888000000888800008888
      0000888000000888000088000880008800008000888800080000000888888000
      0000008888888800000088888888888800008888888888880000}
    OnClick = sbtnExpertDownClick
  end
  object sbtnExpertUp: TSpeedButton
    Left = 8
    Top = 80
    Width = 23
    Height = 22
    Glyph.Data = {
      F6000000424DF60000000000000076000000280000000C000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      0000888888888888000000888888880000000008888880000000800088880008
      0000880008800088000088800000088800008888000088880000008880088800
      0000000888888000000080008888000800008800088000880000888000000888
      0000888800008888000088888008888800008888888888880000}
    Visible = False
    OnClick = sbtnExpertUpClick
  end
  object btnOk: TButton
    Left = 216
    Top = 200
    Width = 185
    Height = 25
    Caption = #1054#1082
    TabOrder = 4
    OnClick = btnOkClick
  end
  object edtCaption: TEdit
    Left = 176
    Top = 13
    Width = 225
    Height = 21
    TabOrder = 1
    Text = #1053#1072#1087#1086#1084#1080#1085#1072#1083#1082#1072
  end
  object edtNumDays: TEdit
    Left = 176
    Top = 40
    Width = 225
    Height = 21
    TabOrder = 2
    Text = '30'
  end
  object btnCancel: TButton
    Left = 8
    Top = 200
    Width = 193
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 0
    OnClick = btnCancelClick
  end
  object chkAutostart: TCheckBox
    Left = 176
    Top = 62
    Width = 97
    Height = 17
    TabOrder = 3
  end
  object pnl1: TPanel
    Left = 8
    Top = 105
    Width = 393
    Height = 89
    BorderStyle = bsSingle
    TabOrder = 5
    Visible = False
    object lbl3: TLabel
      Left = 10
      Top = 10
      Width = 101
      Height = 13
      Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1074' '#1076#1072#1090#1077
    end
    object Label1: TLabel
      Left = 10
      Top = 32
      Width = 108
      Height = 13
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' "'#1089#1077#1075#1086#1076#1085#1103'"'
    end
    object lbl6: TLabel
      Left = 10
      Top = 56
      Width = 112
      Height = 13
      Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1074' '#1090#1077#1082#1089#1090#1077
    end
    object edtTodayLine: TEdit
      Left = 130
      Top = 32
      Width = 255
      Height = 21
      TabOrder = 1
      Text = #8212#8212#8212#8212#8212#8212#8212#8212#8212#8212' '#1057#1077#1075#1086#1076#1085#1103' '#1087#1088#1072#1079#1076#1085#1091#1102#1090': '#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212
    end
    object edtTextSeparator: TEdit
      Left = 130
      Top = 56
      Width = 255
      Height = 21
      TabOrder = 2
      Text = #8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212#8212
    end
    object edtSeparator: TEdit
      Left = 130
      Top = 5
      Width = 253
      Height = 21
      TabOrder = 0
      Text = '/'
    end
  end
end
