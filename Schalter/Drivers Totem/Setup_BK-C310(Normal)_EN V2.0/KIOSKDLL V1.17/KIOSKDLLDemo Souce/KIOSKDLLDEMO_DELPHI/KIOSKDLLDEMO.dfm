object MainForm: TMainForm
  Left = 0
  Top = 0
  HelpType = htKeyword
  HelpKeyword = 'F1'
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'KIOSKDLLDEMO_DELPHI'
  ClientHeight = 436
  ClientWidth = 776
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHelp = FormHelp
  PixelsPerInch = 96
  TextHeight = 13
  object Openport: TButton
    Left = 8
    Top = 403
    Width = 75
    Height = 25
    Caption = '&Open Port'
    TabOrder = 10
    OnClick = OpenportClick
  end
  object QueryStatus: TButton
    Left = 89
    Top = 403
    Width = 75
    Height = 25
    Caption = '&Query Status'
    Enabled = False
    TabOrder = 11
    TabStop = False
    OnClick = QueryStatusClick
  end
  object Print: TButton
    Left = 521
    Top = 400
    Width = 75
    Height = 25
    Caption = '&Print'
    Enabled = False
    TabOrder = 13
    OnClick = PrintClick
  end
  object Close: TButton
    Left = 602
    Top = 400
    Width = 75
    Height = 25
    Caption = 'C&lose'
    Enabled = False
    TabOrder = 14
    OnClick = CloseClick
  end
  object nExit: TButton
    Left = 689
    Top = 400
    Width = 75
    Height = 25
    Caption = '&Exit'
    TabOrder = 15
    OnClick = nExitClick
  end
  object strMsg: TEdit
    Left = 182
    Top = 402
    Width = 320
    Height = 21
    ReadOnly = True
    TabOrder = 12
    Text = 'All is ok,version is V1.0'
  end
  object Savetofile: TCheckBox
    Left = 8
    Top = 367
    Width = 201
    Height = 17
    Caption = 'Sending data to file but not to port.'
    TabOrder = 9
    OnClick = SavetofileClick
  end
  object SelectPort: TRadioGroup
    Left = 9
    Top = 8
    Width = 370
    Height = 57
    Caption = 'Port Selecting'
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      ' COM '
      ' LPT'
      ' USB'
      ' Driver')
    TabOrder = 0
    TabStop = True
    OnClick = SelectPortClick
  end
  object GroupBox1: TGroupBox
    Left = 9
    Top = 71
    Width = 370
    Height = 284
    Caption = 'Port Setting'
    TabOrder = 1
    TabStop = True
    object StaticText1: TStaticText
      Left = 30
      Top = 25
      Width = 61
      Height = 17
      Caption = 'COM Name:'
      TabOrder = 7
    end
    object StaticText2: TStaticText
      Left = 38
      Top = 67
      Width = 52
      Height = 17
      Caption = 'Baudrate:'
      TabOrder = 11
    end
    object StaticText3: TStaticText
      Left = 39
      Top = 100
      Width = 51
      Height = 17
      Caption = 'Data Bits:'
      TabOrder = 12
    end
    object StaticText4: TStaticText
      Left = 228
      Top = 25
      Width = 36
      Height = 17
      Caption = 'Parity:'
      TabOrder = 13
    end
    object StaticText5: TStaticText
      Left = 214
      Top = 64
      Width = 50
      Height = 17
      Caption = 'Stop Bits:'
      TabOrder = 14
    end
    object StaticText6: TStaticText
      Left = 200
      Top = 100
      Width = 64
      Height = 17
      Caption = 'Flow Contol:'
      TabOrder = 15
    end
    object StaticText7: TStaticText
      Left = 23
      Top = 135
      Width = 67
      Height = 17
      Caption = 'LPT Address:'
      TabOrder = 16
    end
    object StaticText8: TStaticText
      Left = 17
      Top = 171
      Width = 73
      Height = 17
      Caption = 'ReadTimeOut:'
      TabOrder = 17
    end
    object StaticText9: TStaticText
      Left = 16
      Top = 204
      Width = 74
      Height = 17
      Caption = 'WriteTimeOut:'
      TabOrder = 18
    end
    object StaticText10: TStaticText
      Left = 23
      Top = 245
      Width = 67
      Height = 17
      Caption = 'Driver Name:'
      TabOrder = 19
    end
    object DriverName: TComboBox
      Left = 92
      Top = 243
      Width = 145
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      TabOrder = 10
    end
    object WriteTimeOut: TEdit
      Left = 92
      Top = 204
      Width = 89
      Height = 21
      TabOrder = 9
      Text = '90000'
      OnKeyPress = WriteTimeOutKeyPress
    end
    object StaticText11: TStaticText
      Left = 191
      Top = 208
      Width = 68
      Height = 17
      Caption = '( Millisecond )'
      TabOrder = 20
    end
    object StaticText12: TStaticText
      Left = 191
      Top = 171
      Width = 68
      Height = 17
      Caption = '( Millisecond )'
      TabOrder = 21
    end
    object GroupBox2: TGroupBox
      Left = 399
      Top = 157
      Width = 185
      Height = 105
      Caption = 'GroupBox2'
      TabOrder = 22
    end
    object ComName: TComboBox
      Left = 92
      Top = 20
      Width = 75
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'COM1'
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5 '
        'COM6 '
        'COM7'
        'COM8'
        'COM9'
        'COM10')
    end
    object DataBits: TComboBox
      Left = 92
      Top = 95
      Width = 76
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 2
      Text = '8'
      Items.Strings = (
        '7'
        '8')
    end
    object Parity: TComboBox
      Left = 267
      Top = 20
      Width = 91
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 3
      Text = 'NONE'
      Items.Strings = (
        'NONE'
        'ODD'
        'EVEN'
        'MARK'
        'SPACE')
    end
    object StopBits: TComboBox
      Left = 267
      Top = 60
      Width = 91
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      Text = '1'
      Items.Strings = (
        '1'
        '2')
    end
    object FlowControl: TComboBox
      Left = 267
      Top = 95
      Width = 91
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 5
      Text = 'DTR/DSR'
      Items.Strings = (
        'DTR/DSR')
    end
    object LPTAddress: TComboBox
      Left = 92
      Top = 130
      Width = 76
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 6
      Text = '0x0378'
      Items.Strings = (
        '0x0378'
        '0x0278')
    end
    object Baudrate: TComboBox
      Left = 92
      Top = 60
      Width = 76
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 4
      TabOrder = 1
      Text = '38400'
      Items.Strings = (
        '2400 '
        '4800'
        '9600'
        '19200'
        '38400'
        '57600'
        '115200')
    end
    object ReadTimeOut: TEdit
      Left = 92
      Top = 167
      Width = 89
      Height = 21
      TabOrder = 8
      Text = '3000'
      OnKeyPress = ReadTimeOutKeyPress
    end
  end
  object StandardMode: TRadioButton
    Left = 429
    Top = 32
    Width = 53
    Height = 17
    Caption = 'Page'
    TabOrder = 16
  end
  object PresenterMode: TRadioButton
    Left = 416
    Top = 93
    Width = 113
    Height = 17
    Caption = 'Presenter'
    TabOrder = 17
  end
  object RadioGroup4: TRadioGroup
    Left = 386
    Top = 8
    Width = 190
    Height = 347
    TabOrder = 18
  end
  object StaticText13: TStaticText
    Left = 411
    Top = 296
    Width = 69
    Height = 17
    Caption = 'Page width'#65306
    TabOrder = 19
  end
  object StaticText14: TStaticText
    Left = 411
    Top = 325
    Width = 69
    Height = 17
    Caption = 'Resolution '#65306
    TabOrder = 20
  end
  object GroupBox7: TGroupBox
    Left = 582
    Top = 8
    Width = 182
    Height = 347
    Caption = 'Status Monitor'
    TabOrder = 8
    TabStop = True
    object Start: TButton
      Left = 55
      Top = 284
      Width = 75
      Height = 25
      Caption = 'Start'
      Enabled = False
      TabOrder = 1
      TabStop = False
      OnClick = StartClick
    end
    object Stop: TButton
      Left = 56
      Top = 315
      Width = 75
      Height = 25
      Caption = 'Stop'
      Enabled = False
      TabOrder = 2
      TabStop = False
      OnClick = StopClick
    end
    object StatusMonitor: TMemo
      Left = 9
      Top = 23
      Width = 164
      Height = 253
      Enabled = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object SelectMode: TRadioGroup
    Left = 395
    Top = 15
    Width = 175
    Height = 50
    Caption = 'Print Mode Selecting'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Standard'
      'Page')
    TabOrder = 2
    TabStop = True
    OnClick = SelectModeClick
  end
  object Select: TRadioGroup
    Left = 395
    Top = 71
    Width = 175
    Height = 50
    Caption = 'Paper Out Mode Selecting'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Presenter'
      'Bundler')
    TabOrder = 3
    TabStop = True
    OnClick = SelectClick
  end
  object Presenter: TRadioGroup
    Left = 395
    Top = 127
    Width = 175
    Height = 105
    Caption = 'Presenter Setting'
    ItemIndex = 0
    Items.Strings = (
      'Retraction on'
      'Paper Forward'
      'Paper Hold')
    TabOrder = 4
    TabStop = True
    OnClick = PresenterClick
  end
  object Bundler: TRadioGroup
    Left = 395
    Top = 238
    Width = 175
    Height = 50
    Caption = 'Bundler Setting'
    Columns = 2
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Retract'
      'Present')
    TabOrder = 5
    TabStop = True
    OnClick = BundlerClick
  end
  object PageWidth: TComboBox
    Left = 488
    Top = 295
    Width = 73
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 6
    Text = '80mm'
    Items.Strings = (
      '56mm'
      '80mm'
      '210mm')
  end
  object Resolution: TComboBox
    Left = 488
    Top = 324
    Width = 73
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 7
    Text = '203DPI'
    Items.Strings = (
      '203DPI'
      '300DPI')
  end
  object PDF417: TButton
    Left = 521
    Top = 361
    Width = 75
    Height = 25
    Caption = 'PDF417'
    Enabled = False
    TabOrder = 21
    OnClick = PDF417Click
  end
  object Sample: TButton
    Left = 602
    Top = 361
    Width = 75
    Height = 25
    Caption = 'PrintSample'
    Enabled = False
    TabOrder = 22
    OnClick = SampleClick
  end
end
