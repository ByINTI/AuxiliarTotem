object MainForm: TMainForm
  Left = 7
  Top = 0
  Caption = 'KIOSKDLLDEMO_DELPHI'
  ClientHeight = 439
  ClientWidth = 802
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object Openport: TButton
    Left = 15
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Open Port'
    TabOrder = 19
    TabStop = False
    OnClick = OpenportClick
  end
  object QueryStatus: TButton
    Left = 105
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Query Status'
    Enabled = False
    TabOrder = 21
    TabStop = False
    OnClick = QueryStatusClick
  end
  object Print: TButton
    Left = 530
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Print'
    Enabled = False
    TabOrder = 15
    TabStop = False
    OnClick = PrintClick
  end
  object Close: TButton
    Left = 623
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Close'
    Enabled = False
    TabOrder = 17
    TabStop = False
    OnClick = CloseClick
  end
  object nExit: TButton
    Left = 714
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Exit'
    TabOrder = 20
    OnClick = nExitClick
  end
  object strMsg: TEdit
    Left = 196
    Top = 402
    Width = 320
    Height = 24
    TabStop = False
    TabOrder = 13
    Text = 'All is ok,version is V1.0'
  end
  object Savetofile: TCheckBox
    Left = 15
    Top = 367
    Width = 201
    Height = 17
    TabStop = False
    Caption = 'Sending data to file but not to port.'
    TabOrder = 18
  end
  object SelectPort: TRadioGroup
    Left = 15
    Top = 8
    Width = 378
    Height = 57
    Caption = 'Select Port'
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      ' COM '
      ' LPT'
      ' USB'
      ' Driver')
    TabOrder = 0
    OnClick = SelectPortClick
  end
  object GroupBox1: TGroupBox
    Left = 15
    Top = 71
    Width = 378
    Height = 284
    Caption = 'Set Port'
    TabOrder = 1
    object StaticText1: TStaticText
      Left = 30
      Top = 25
      Width = 61
      Height = 17
      Caption = 'COM Name:'
      TabOrder = 0
    end
    object StaticText2: TStaticText
      Left = 38
      Top = 67
      Width = 52
      Height = 17
      Caption = 'Baudrate:'
      TabOrder = 8
    end
    object StaticText3: TStaticText
      Left = 39
      Top = 100
      Width = 51
      Height = 17
      Caption = 'Data Bits:'
      TabOrder = 11
    end
    object StaticText4: TStaticText
      Left = 230
      Top = 25
      Width = 36
      Height = 17
      Caption = 'Parity:'
      TabOrder = 12
    end
    object StaticText5: TStaticText
      Left = 216
      Top = 64
      Width = 50
      Height = 17
      Caption = 'Stop Bits:'
      TabOrder = 13
    end
    object StaticText6: TStaticText
      Left = 202
      Top = 100
      Width = 64
      Height = 17
      Caption = 'Flow Contol:'
      TabOrder = 14
    end
    object StaticText7: TStaticText
      Left = 23
      Top = 135
      Width = 67
      Height = 17
      Caption = 'LPT Address:'
      TabOrder = 15
    end
    object StaticText8: TStaticText
      Left = 17
      Top = 171
      Width = 73
      Height = 17
      Caption = 'ReadTimeOut:'
      TabOrder = 16
    end
    object StaticText9: TStaticText
      Left = 16
      Top = 204
      Width = 74
      Height = 17
      Caption = 'WriteTimeOut:'
      TabOrder = 17
    end
    object StaticText10: TStaticText
      Left = 23
      Top = 248
      Width = 67
      Height = 17
      Caption = 'Driver Name:'
      TabOrder = 18
    end
    object DriverName: TComboBox
      Left = 96
      Top = 243
      Width = 145
      Height = 21
      Enabled = False
      ItemHeight = 13
      TabOrder = 10
      TabStop = False
    end
    object WriteTimeOut: TEdit
      Left = 96
      Top = 204
      Width = 89
      Height = 21
      TabStop = False
      TabOrder = 9
      Text = '90000'
    end
    object StaticText11: TStaticText
      Left = 191
      Top = 208
      Width = 68
      Height = 17
      Caption = '( Millisecond )'
      TabOrder = 19
    end
    object StaticText12: TStaticText
      Left = 191
      Top = 171
      Width = 68
      Height = 17
      Caption = '( Millisecond )'
      TabOrder = 20
    end
    object GroupBox2: TGroupBox
      Left = 399
      Top = 157
      Width = 185
      Height = 105
      Caption = 'GroupBox2'
      TabOrder = 21
    end
    object ComName: TComboBox
      Left = 97
      Top = 20
      Width = 75
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      TabStop = False
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
      Left = 96
      Top = 95
      Width = 76
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 3
      TabStop = False
      Text = '8'
      Items.Strings = (
        '7'
        '8')
    end
    object Parity: TComboBox
      Left = 272
      Top = 20
      Width = 91
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      TabStop = False
      Text = 'NONE'
      Items.Strings = (
        'NONE'
        'ODD'
        'EVEN'
        'MARK'
        'SPACE')
    end
    object StopBits: TComboBox
      Left = 272
      Top = 60
      Width = 91
      Height = 21
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 5
      TabStop = False
      Text = '1'
      Items.Strings = (
        '0'
        '1')
    end
    object FlowControl: TComboBox
      Left = 272
      Top = 95
      Width = 91
      Height = 21
      ItemHeight = 13
      TabOrder = 6
      TabStop = False
      Text = 'DTR/DSR'
      Items.Strings = (
        'DTR/DSR'
        'RTS/CTS'
        'XON/XOFF'
        'NONE')
    end
    object LPTAddress: TComboBox
      Left = 96
      Top = 130
      Width = 76
      Height = 21
      Enabled = False
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 7
      TabStop = False
      Text = 'LPT1'
      Items.Strings = (
        'LPT1'
        'LPT2')
    end
    object Baudrate: TComboBox
      Left = 96
      Top = 60
      Width = 76
      Height = 21
      ItemHeight = 13
      ItemIndex = 4
      TabOrder = 2
      TabStop = False
      Text = '38400'
      Items.Strings = (
        '2400 '
        '4800'
        '9600'
        '19200'
        '38400'
        '57600')
    end
  end
  object ReadTimeOut: TEdit
    Left = 111
    Top = 238
    Width = 89
    Height = 21
    TabStop = False
    TabOrder = 8
    Text = '3000'
  end
  object StandardMode: TRadioButton
    Left = 436
    Top = 32
    Width = 53
    Height = 17
    Caption = 'Page'
    TabOrder = 2
  end
  object PresenterMode: TRadioButton
    Left = 423
    Top = 93
    Width = 113
    Height = 17
    Caption = 'Presenter'
    TabOrder = 3
  end
  object RadioGroup4: TRadioGroup
    Left = 400
    Top = 8
    Width = 199
    Height = 347
    TabOrder = 4
  end
  object StaticText13: TStaticText
    Left = 418
    Top = 296
    Width = 69
    Height = 17
    Caption = 'Page width'#65306
    TabOrder = 5
  end
  object StaticText14: TStaticText
    Left = 418
    Top = 325
    Width = 69
    Height = 17
    Caption = 'Resolution '#65306
    TabOrder = 6
  end
  object GroupBox7: TGroupBox
    Left = 607
    Top = 8
    Width = 182
    Height = 347
    Caption = 'Status Monitor'
    TabOrder = 7
    object Start: TButton
      Left = 55
      Top = 285
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
      TabOrder = 0
      TabStop = False
      OnClick = StopClick
    end
    object StatusMonitor: TMemo
      Left = 9
      Top = 24
      Width = 164
      Height = 253
      Enabled = False
      Lines.Strings = (
        '')
      ReadOnly = True
      TabOrder = 2
    end
  end
  object SelectMode: TRadioGroup
    Left = 408
    Top = 15
    Width = 180
    Height = 50
    Caption = 'Select Mode'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Standard'
      'Page')
    TabOrder = 9
  end
  object Select: TRadioGroup
    Left = 408
    Top = 71
    Width = 180
    Height = 50
    Caption = 'Select'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Presenter'
      'Bundler')
    TabOrder = 10
    OnClick = SelectClick
  end
  object Presenter: TRadioGroup
    Left = 408
    Top = 127
    Width = 180
    Height = 105
    Caption = 'Presenter'
    ItemIndex = 0
    Items.Strings = (
      'Retraction on'
      'Paper Forward'
      'paper Hold')
    TabOrder = 11
  end
  object Bundler: TRadioGroup
    Left = 408
    Top = 238
    Width = 180
    Height = 50
    Caption = 'Bundler'
    Columns = 2
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Retract'
      'Present')
    TabOrder = 12
  end
  object PageWidth: TComboBox
    Left = 500
    Top = 294
    Width = 73
    Height = 21
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 14
    TabStop = False
    Text = '80mm'
    Items.Strings = (
      '56mm'
      '80mm'
      '210mm')
  end
  object Resolution: TComboBox
    Left = 500
    Top = 325
    Width = 73
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 16
    TabStop = False
    Text = '203DPI'
    Items.Strings = (
      '203DPI'
      '300DPI')
  end
end
