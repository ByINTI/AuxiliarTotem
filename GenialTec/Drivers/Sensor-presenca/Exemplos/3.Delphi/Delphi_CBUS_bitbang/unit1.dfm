object Form1: TForm1
  Left = 241
  Top = 107
  Width = 449
  Height = 228
  AutoSize = True
  Caption = 'FT232R CBUS 0-3 I/O Test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 441
    Height = 201
    TabOrder = 0
    object Label1: TLabel
      Left = 160
      Top = 8
      Width = 34
      Height = 13
      Caption = 'Device'
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 8
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnDropDown = ComboBox1DropDown
    end
    object Memo1: TMemo
      Left = 8
      Top = 136
      Width = 425
      Height = 57
      Lines.Strings = (
        '')
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object Panel2: TPanel
      Left = 8
      Top = 40
      Width = 169
      Height = 84
      TabOrder = 2
      object Label2: TLabel
        Left = 8
        Top = 4
        Width = 13
        Height = 13
        Caption = 'C0'
      end
      object Label3: TLabel
        Left = 8
        Top = 24
        Width = 13
        Height = 13
        Caption = 'C1'
      end
      object Label4: TLabel
        Left = 8
        Top = 44
        Width = 13
        Height = 13
        Caption = 'C2'
      end
      object Label5: TLabel
        Left = 8
        Top = 64
        Width = 13
        Height = 13
        Caption = 'C3'
      end
      object CheckBox1: TCheckBox
        Left = 32
        Top = 2
        Width = 57
        Height = 17
        Caption = 'Output'
        TabOrder = 0
      end
      object CheckBox2: TCheckBox
        Left = 32
        Top = 22
        Width = 57
        Height = 17
        Caption = 'Output'
        TabOrder = 1
      end
      object CheckBox3: TCheckBox
        Left = 32
        Top = 42
        Width = 57
        Height = 17
        Caption = 'Output'
        TabOrder = 2
      end
      object CheckBox4: TCheckBox
        Left = 32
        Top = 62
        Width = 57
        Height = 17
        Caption = 'Output'
        TabOrder = 3
      end
      object Panel4: TPanel
        Left = 100
        Top = 22
        Width = 65
        Height = 18
        TabOrder = 4
        object RadioButton3: TRadioButton
          Left = 1
          Top = 1
          Width = 33
          Height = 16
          Caption = '0'
          TabOrder = 0
        end
        object RadioButton4: TRadioButton
          Left = 31
          Top = 1
          Width = 33
          Height = 16
          Caption = '1'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
      object Panel3: TPanel
        Left = 100
        Top = 2
        Width = 65
        Height = 18
        TabOrder = 5
        object RadioButton1: TRadioButton
          Left = 1
          Top = 1
          Width = 33
          Height = 16
          Caption = '0'
          TabOrder = 0
        end
        object RadioButton2: TRadioButton
          Left = 31
          Top = 1
          Width = 33
          Height = 16
          Caption = '1'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
      object Panel5: TPanel
        Left = 100
        Top = 42
        Width = 65
        Height = 18
        TabOrder = 6
        object RadioButton5: TRadioButton
          Left = 1
          Top = 1
          Width = 33
          Height = 16
          Caption = '0'
          TabOrder = 0
        end
        object RadioButton6: TRadioButton
          Left = 31
          Top = 1
          Width = 33
          Height = 16
          Caption = '1'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
      object Panel6: TPanel
        Left = 100
        Top = 62
        Width = 65
        Height = 18
        TabOrder = 7
        object RadioButton7: TRadioButton
          Left = 1
          Top = 1
          Width = 33
          Height = 16
          Caption = '0'
          TabOrder = 0
        end
        object RadioButton8: TRadioButton
          Left = 31
          Top = 1
          Width = 33
          Height = 16
          Caption = '1'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
    end
    object Panel7: TPanel
      Left = 180
      Top = 40
      Width = 173
      Height = 84
      TabOrder = 3
      object Label6: TLabel
        Left = 8
        Top = 4
        Width = 99
        Height = 13
        Caption = 'Current State of C0 : '
      end
      object Label7: TLabel
        Left = 8
        Top = 24
        Width = 99
        Height = 13
        Caption = 'Current State of C1 : '
      end
      object Label8: TLabel
        Left = 8
        Top = 44
        Width = 99
        Height = 13
        Caption = 'Current State of C2 : '
      end
      object Label9: TLabel
        Left = 8
        Top = 64
        Width = 99
        Height = 13
        Caption = 'Current State of C3 : '
      end
      object Label10: TLabel
        Left = 112
        Top = 4
        Width = 46
        Height = 13
        Caption = 'Unknown'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label11: TLabel
        Left = 112
        Top = 24
        Width = 46
        Height = 13
        Caption = 'Unknown'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label12: TLabel
        Left = 111
        Top = 44
        Width = 46
        Height = 13
        Caption = 'Unknown'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label13: TLabel
        Left = 111
        Top = 64
        Width = 46
        Height = 13
        Caption = 'Unknown'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
    end
    object Button1: TButton
      Left = 360
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Set Bits'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 360
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Read Bits'
      TabOrder = 5
      OnClick = Button2Click
    end
  end
end
