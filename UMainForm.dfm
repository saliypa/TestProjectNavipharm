object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'MainForm'
  ClientHeight = 471
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 524
    Height = 97
    Align = alTop
    TabOrder = 0
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 522
      Height = 72
      Align = alTop
      TabOrder = 0
      object Label6: TLabel
        Left = 1
        Top = 1
        Width = 520
        Height = 13
        Align = alTop
        Alignment = taCenter
        Caption = #1054#1090#1082#1091#1076#1072
        ExplicitWidth = 39
      end
      object Label7: TLabel
        Left = 1
        Top = 35
        Width = 520
        Height = 13
        Align = alTop
        Alignment = taCenter
        Caption = #1050#1091#1076#1072
        ExplicitWidth = 26
      end
      object Edit2: TEdit
        Left = 1
        Top = 48
        Width = 520
        Height = 21
        Align = alTop
        TabOrder = 0
        Text = 'Edit2'
        OnClick = Edit2Click
      end
      object Edit1: TEdit
        Left = 1
        Top = 14
        Width = 520
        Height = 21
        Align = alTop
        TabOrder = 1
        Text = 'Edit1'
        OnClick = Edit1Click
      end
    end
    object CheckBox2: TCheckBox
      Left = 1
      Top = 73
      Width = 522
      Height = 23
      Align = alClient
      Caption = #1055#1077#1088#1077#1079#1072#1087#1080#1089#1099#1074#1072#1090#1100' '#1092#1072#1081#1083#1099
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 97
    Width = 524
    Height = 374
    Align = alClient
    TabOrder = 1
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 522
      Height = 168
      Align = alTop
      TabOrder = 0
      object Panel3: TPanel
        Left = 461
        Top = 1
        Width = 60
        Height = 166
        Align = alRight
        TabOrder = 0
        object TrackBar1: TTrackBar
          Left = 14
          Top = 1
          Width = 45
          Height = 147
          Align = alRight
          Max = 3
          Orientation = trVertical
          Position = 3
          PositionToolTip = ptRight
          TabOrder = 0
          OnChange = TrackBar1Change
        end
        object CheckBox1: TCheckBox
          Left = 1
          Top = 148
          Width = 58
          Height = 17
          Align = alBottom
          Caption = #1055#1072#1091#1079#1072
          TabOrder = 1
          OnClick = CheckBox1Click
        end
      end
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 460
        Height = 166
        Align = alClient
        TabOrder = 1
        object LabelFullSize: TLabel
          Left = 1
          Top = 46
          Width = 458
          Height = 16
          Align = alTop
          Caption = ' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
          ExplicitWidth = 4
        end
        object Label3: TLabel
          Left = 1
          Top = 62
          Width = 458
          Height = 13
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = #1058#1077#1082#1091#1097#1080#1081' '#1092#1072#1081#1083
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = -4
          ExplicitTop = 81
          ExplicitWidth = 460
        end
        object Label4: TLabel
          Left = 1
          Top = 33
          Width = 458
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = #1054#1073#1097#1080#1081' '#1086#1073#1098#1105#1084' '#1076#1072#1085#1085#1099#1093
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 128
        end
        object Label1: TLabel
          Left = 1
          Top = 1
          Width = 458
          Height = 13
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = #1054#1073#1097#1080#1081' '#1093#1086#1076' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = -15
          ExplicitTop = 4
          ExplicitWidth = 460
        end
        object Label5: TLabel
          Left = 1
          Top = 92
          Width = 458
          Height = 13
          Align = alTop
          Caption = ' '
          ExplicitWidth = 3
        end
        object ProgressBar1: TProgressBar
          Left = 1
          Top = 14
          Width = 458
          Height = 19
          Align = alTop
          Step = 1
          TabOrder = 0
        end
        object BitBtn3: TBitBtn
          Left = 1
          Top = 115
          Width = 458
          Height = 25
          Align = alBottom
          Caption = #1057#1090#1072#1088#1090
          TabOrder = 1
          OnClick = BitBtn3Click
        end
        object ProgressBar2: TProgressBar
          Left = 1
          Top = 75
          Width = 458
          Height = 17
          Align = alTop
          TabOrder = 2
        end
        object BitBtn1: TBitBtn
          Left = 1
          Top = 140
          Width = 458
          Height = 25
          Align = alBottom
          Caption = #1054#1090#1084#1077#1085#1072
          TabOrder = 3
          Visible = False
          OnClick = BitBtn1Click
        end
      end
    end
    object Panel7: TPanel
      Left = 1
      Top = 169
      Width = 185
      Height = 204
      Align = alLeft
      TabOrder = 1
      object Label2: TLabel
        Left = 16
        Top = 13
        Width = 15
        Height = 13
        Caption = 'DB'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 16
        Top = 59
        Width = 26
        Height = 13
        Caption = 'User'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 16
        Top = 105
        Width = 20
        Height = 13
        Caption = 'Pas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object EditDB: TEdit
        Left = 16
        Top = 32
        Width = 160
        Height = 21
        TabOrder = 0
        Text = 'W:\(DB)\MYTEMPDB.FDB'
        OnClick = EditDBClick
      end
      object EditUser: TEdit
        Left = 16
        Top = 78
        Width = 160
        Height = 21
        TabOrder = 1
        Text = 'SYSDBA'
      end
      object EditPas: TEdit
        Left = 16
        Top = 124
        Width = 160
        Height = 21
        PasswordChar = '*'
        TabOrder = 2
        Text = 'masterkey'
      end
    end
    object Panel8: TPanel
      Left = 186
      Top = 169
      Width = 337
      Height = 204
      Align = alClient
      TabOrder = 2
      object DBGrid1: TDBGrid
        Left = 1
        Top = 1
        Width = 335
        Height = 202
        Align = alClient
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=W:\(DB)\MYTEMPDB.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'CharacterSet=WIN1251'
      'DriverID=FB')
    Left = 265
    Top = 290
  end
  object FDTable1: TFDTable
    IndexFieldNames = 'FILE_ID'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'FILE_TABLE'
    TableName = 'FILE_TABLE'
    Left = 273
    Top = 338
    object FDTable1FILE_NAME: TStringField
      DisplayLabel = #1048#1084#1103' '#1092#1072#1081#1083#1072
      FieldName = 'FILE_NAME'
      Origin = 'FILE_NAME'
      Required = True
      FixedChar = True
      Size = 30
    end
    object FDTable1FILE_SIZE: TStringField
      DisplayLabel = #1056#1072#1079#1084#1077#1088
      FieldName = 'FILE_SIZE'
      Origin = 'FILE_SIZE'
      FixedChar = True
      Size = 10
    end
    object FDTable1FILE_TIME: TStringField
      DisplayLabel = #1042#1088#1077#1084#1103
      FieldName = 'FILE_TIME'
      Origin = 'FILE_TIME'
      FixedChar = True
      Size = 35
    end
    object FDTable1FILE_ID: TSmallintField
      FieldName = 'FILE_ID'
      Origin = 'FILE_ID'
    end
  end
  object DataSource1: TDataSource
    DataSet = FDTable1
    Left = 273
    Top = 394
  end
end
