object MainForm: TMainForm
  Left = 256
  Top = 154
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'POSdllDemo'
  ClientHeight = 334
  ClientWidth = 534
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object PortSet: TGroupBox
    Left = 8
    Top = 87
    Width = 392
    Height = 189
    Caption = #31471#21475#37197#32622
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 21
      Width = 67
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #31471#21475#21517#31216#65306
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 67
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #27599#31186#20301#25968#65306
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 23
      Top = 75
      Width = 60
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #25968#25454#20301#65306
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 204
      Top = 21
      Width = 70
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #26657#39564#20301#65306
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 197
      Top = 45
      Width = 77
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #20572#27490#20301#65306
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 189
      Top = 75
      Width = 85
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #25968#25454#27969#25511#21046#65306
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 23
      Top = 106
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = #24182#21475#21517#31216#65306
    end
    object Label7: TLabel
      Left = 37
      Top = 132
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'IP'#22320#22336#65306
    end
    object Label9: TLabel
      Left = 23
      Top = 159
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = #39537#21160#21517#31216#65306
    end
    object cbPortName: TComboBox
      Left = 97
      Top = 18
      Width = 81
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899' IME 3.0'
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'COM1'
      OnChange = cbPortNameChange
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8'
        'COM9'
        'COM10')
    end
    object cbBaud: TComboBox
      Left = 97
      Top = 45
      Width = 81
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899' IME 3.0'
      ItemHeight = 13
      ItemIndex = 2
      TabOrder = 1
      Text = '9600'
      Items.Strings = (
        '2400'
        '4800'
        '9600'
        '19200'
        '38400'
        '57600'
        '115200')
    end
    object cbData: TComboBox
      Left = 97
      Top = 71
      Width = 81
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899' IME 3.0'
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 2
      Text = '8'
      Items.Strings = (
        '7'
        '8')
    end
    object cbParity: TComboBox
      Left = 280
      Top = 17
      Width = 81
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899' IME 3.0'
      ItemHeight = 13
      TabOrder = 3
    end
    object cbStop: TComboBox
      Left = 280
      Top = 44
      Width = 81
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899' IME 3.0'
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      Text = '1'
      Items.Strings = (
        '1'
        '2')
    end
    object cbFlow: TComboBox
      Left = 280
      Top = 71
      Width = 81
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899' IME 3.0'
      ItemHeight = 13
      TabOrder = 5
    end
    object cbLPT: TComboBox
      Left = 96
      Top = 103
      Width = 81
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 6
      Text = 'LPT1'
      OnChange = cbLPTChange
      Items.Strings = (
        'LPT1'
        'LPT2')
    end
    object edDrive: TEdit
      Left = 97
      Top = 157
      Width = 136
      Height = 21
      TabOrder = 11
      Text = 'BTP-2002CP(S)'
    end
    object IP1: TEdit
      Left = 96
      Top = 130
      Width = 32
      Height = 21
      MaxLength = 3
      TabOrder = 7
      Text = '192'
      OnChange = IP1Change
      OnKeyPress = IP1KeyPress
    end
    object IP2: TEdit
      Left = 128
      Top = 130
      Width = 32
      Height = 21
      MaxLength = 3
      TabOrder = 8
      Text = '168'
      OnChange = IP2Change
      OnKeyPress = IP2KeyPress
    end
    object IP3: TEdit
      Left = 160
      Top = 130
      Width = 32
      Height = 21
      MaxLength = 3
      TabOrder = 9
      Text = '10'
      OnChange = IP3Change
      OnKeyPress = IP3KeyPress
    end
    object IP4: TEdit
      Left = 192
      Top = 130
      Width = 32
      Height = 21
      MaxLength = 3
      TabOrder = 10
      Text = '251'
      OnChange = IP4Change
      OnKeyPress = IP4KeyPress
    end
    object cbName: TComboBox
      Left = 280
      Top = 157
      Width = 81
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899' IME 3.0'
      ItemHeight = 13
      TabOrder = 12
    end
  end
  object ChkWrite: TCheckBox
    Left = 8
    Top = 282
    Width = 232
    Height = 17
    Caption = #25968#25454#20445#23384#21040#25991#20214'Test.txt,'#19981#21521#31471#21475#19979#21457
    TabOrder = 4
  end
  object OpenPort: TButton
    Left = 6
    Top = 305
    Width = 75
    Height = 25
    Caption = #25171#24320#31471#21475
    TabOrder = 5
    OnClick = OpenPortClick
  end
  object Aboutinquire: TButton
    Left = 87
    Top = 305
    Width = 75
    Height = 25
    Caption = #26597#35810#29366#24577
    Enabled = False
    TabOrder = 6
    OnClick = AboutinquireClick
  end
  object edQuery: TEdit
    Left = 168
    Top = 308
    Width = 201
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
  end
  object Print: TButton
    Left = 375
    Top = 306
    Width = 75
    Height = 25
    Caption = #25171#21360
    TabOrder = 7
    OnClick = PrintClick
  end
  object ClosePort: TButton
    Left = 457
    Top = 306
    Width = 75
    Height = 25
    Caption = #20851#38381#31471#21475
    TabOrder = 8
    OnClick = ClosePortClick
  end
  object GroupBox3: TGroupBox
    Left = 405
    Top = 4
    Width = 121
    Height = 273
    Caption = #31034#20363#35774#32622
    TabOrder = 3
    object Label10: TLabel
      Left = 19
      Top = 135
      Width = 28
      Height = 13
      Caption = #39029#23485':'
    end
    object Label11: TLabel
      Left = 56
      Top = 298
      Width = 24
      Height = -17
      Caption = '(mm)'
    end
    object Label12: TLabel
      Left = 79
      Top = 157
      Width = 24
      Height = 13
      Caption = '(mm)'
    end
    object pagewide: TComboBox
      Left = 19
      Top = 154
      Width = 54
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = '80 '
      Items.Strings = (
        '80 '
        '56')
    end
    object ModeSelect: TRadioGroup
      Left = 16
      Top = 24
      Width = 89
      Height = 81
      Caption = #27169#24335#36873#25321
      TabOrder = 0
    end
  end
  object PortChoice: TRadioGroup
    Left = 8
    Top = 4
    Width = 391
    Height = 77
    Caption = #31471#21475#36873#25321
    Columns = 3
    TabOrder = 0
    OnClick = PortChoiceClick
  end
end
