object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1089#1095#1077#1090
  ClientHeight = 235
  ClientWidth = 292
  Color = clWindowText
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 16
    Top = 56
    Width = 257
    Height = 53
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -37
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Text = 'player'
  end
  object Button1: TButton
    Left = 15
    Top = 115
    Width = 195
    Height = 54
    Caption = 'ENTER'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -37
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 216
    Top = 115
    Width = 57
    Height = 54
    Caption = 'X'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -37
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button2Click
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Database.mdb;Persis' +
      't Security Info=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 56
    Top = 32
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 104
    Top = 8
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 232
    Top = 40
  end
end
