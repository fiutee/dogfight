object Form1: TForm1
  Left = 514
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 582
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image3: TImage
    Left = 0
    Top = 0
    Width = 601
    Height = 625
  end
  object Image2: TImage
    Left = 192
    Top = 352
    Width = 233
    Height = 105
    Cursor = crNoDrop
    OnClick = Image2Click
    OnMouseEnter = Image2MouseEnter
    OnMouseLeave = Image2MouseLeave
  end
  object Image1: TImage
    Left = 192
    Top = 224
    Width = 233
    Height = 105
    Cursor = crUpArrow
    OnClick = Image1Click
    OnMouseEnter = Image1MouseEnter
    OnMouseLeave = Image1MouseLeave
  end
  object Label1: TLabel
    Left = 149
    Top = 128
    Width = 117
    Height = 42
    Cursor = crHandPoint
    Caption = 'Label1'
    Color = clGrayText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -35
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsItalic]
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 149
    Top = 80
    Width = 218
    Height = 42
    Caption = 'BEST SCORE'
    Color = clGrayText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -35
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsItalic]
    ParentColor = False
    ParentFont = False
  end
  object Button1: TButton
    Left = 563
    Top = 16
    Width = 25
    Height = 25
    Caption = 'X'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 536
    Top = 16
    Width = 25
    Height = 25
    Caption = '?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Database.mdb;Persis' +
      't Security Info=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 280
    Top = 160
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 384
    Top = 152
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 488
    Top = 224
  end
end
