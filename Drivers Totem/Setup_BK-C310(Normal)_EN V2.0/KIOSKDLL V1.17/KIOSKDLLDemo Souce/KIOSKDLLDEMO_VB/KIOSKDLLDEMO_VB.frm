VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "KIOSKDLLDEMO_VB"
   ClientHeight    =   5850
   ClientLeft      =   5250
   ClientTop       =   4230
   ClientWidth     =   10980
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   5850
   ScaleWidth      =   10980
   Begin VB.CommandButton Command9 
      Caption         =   "PrintSample"
      Enabled         =   0   'False
      Height          =   375
      Left            =   8400
      TabIndex        =   58
      Top             =   4920
      Width           =   1095
   End
   Begin VB.CommandButton Command8 
      Caption         =   "PrintPDF417"
      Enabled         =   0   'False
      Height          =   375
      Left            =   7080
      TabIndex        =   57
      Top             =   4920
      Width           =   1095
   End
   Begin VB.Timer Timer1 
      Left            =   10440
      Top             =   4920
   End
   Begin VB.CommandButton Command5 
      Caption         =   "&Exit"
      Height          =   375
      Left            =   9720
      TabIndex        =   40
      Top             =   5400
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&Open Port"
      Height          =   375
      Left            =   120
      TabIndex        =   36
      Top             =   5400
      Width           =   1095
   End
   Begin VB.CommandButton Command2 
      Caption         =   "&Query Status"
      Enabled         =   0   'False
      Height          =   375
      Left            =   1440
      TabIndex        =   37
      Top             =   5400
      Width           =   1095
   End
   Begin VB.TextBox Text3 
      Enabled         =   0   'False
      Height          =   375
      Left            =   2760
      TabIndex        =   56
      TabStop         =   0   'False
      Text            =   "All is ok,version is V1.0"
      Top             =   5400
      Width           =   4095
   End
   Begin VB.CommandButton Command3 
      Caption         =   "&Print"
      Enabled         =   0   'False
      Height          =   375
      Left            =   7080
      TabIndex        =   38
      Top             =   5400
      Width           =   1095
   End
   Begin VB.CommandButton Command4 
      Caption         =   "C&lose Port"
      Enabled         =   0   'False
      Height          =   375
      Left            =   8400
      TabIndex        =   39
      Top             =   5400
      Width           =   1095
   End
   Begin VB.Frame Frame4 
      Caption         =   "Status Monitor"
      Height          =   4815
      Left            =   8520
      TabIndex        =   32
      Top             =   0
      Width           =   2415
      Begin VB.ListBox List1 
         Height          =   3375
         ItemData        =   "KIOSKDLLDEMO_VB.frx":0000
         Left            =   120
         List            =   "KIOSKDLLDEMO_VB.frx":0002
         TabIndex        =   55
         TabStop         =   0   'False
         Top             =   240
         Width           =   2175
      End
      Begin VB.CommandButton Command7 
         Caption         =   "Stop"
         Enabled         =   0   'False
         Height          =   375
         Left            =   480
         TabIndex        =   34
         Top             =   4320
         Width           =   1575
      End
      Begin VB.CommandButton Command6 
         Caption         =   "Start"
         Enabled         =   0   'False
         Height          =   375
         Left            =   480
         TabIndex        =   33
         Top             =   3840
         Width           =   1575
      End
   End
   Begin VB.Frame Frame3 
      Height          =   4815
      Left            =   5520
      TabIndex        =   16
      Top             =   0
      Width           =   2895
      Begin VB.ComboBox Combo10 
         Height          =   315
         ItemData        =   "KIOSKDLLDEMO_VB.frx":0004
         Left            =   1320
         List            =   "KIOSKDLLDEMO_VB.frx":000E
         Style           =   2  'Dropdown List
         TabIndex        =   31
         Top             =   4320
         Width           =   1335
      End
      Begin VB.ComboBox Combo9 
         Height          =   315
         ItemData        =   "KIOSKDLLDEMO_VB.frx":0022
         Left            =   1320
         List            =   "KIOSKDLLDEMO_VB.frx":002F
         Style           =   2  'Dropdown List
         TabIndex        =   30
         Top             =   3840
         Width           =   1335
      End
      Begin VB.Frame Frame8 
         Caption         =   "Bundler"
         Height          =   735
         Left            =   120
         TabIndex        =   27
         Top             =   3000
         Width           =   2655
         Begin VB.OptionButton Option13 
            Caption         =   "Present"
            Enabled         =   0   'False
            Height          =   375
            Left            =   1560
            TabIndex        =   29
            Top             =   240
            Width           =   975
         End
         Begin VB.OptionButton Option12 
            Caption         =   "Retract"
            Enabled         =   0   'False
            Height          =   375
            Left            =   120
            TabIndex        =   28
            Top             =   240
            Value           =   -1  'True
            Width           =   1215
         End
      End
      Begin VB.Frame Frame7 
         Caption         =   "Presenter"
         Height          =   1335
         Left            =   120
         TabIndex        =   23
         Top             =   1560
         Width           =   2655
         Begin VB.OptionButton Option11 
            Caption         =   "Paper Hold"
            Height          =   255
            Left            =   240
            TabIndex        =   26
            Top             =   960
            Width           =   2055
         End
         Begin VB.OptionButton Option10 
            Caption         =   "Paper Forward"
            Height          =   255
            Left            =   240
            TabIndex        =   25
            Top             =   600
            Width           =   1935
         End
         Begin VB.OptionButton Option9 
            Caption         =   "Retraction on"
            Height          =   255
            Left            =   240
            TabIndex        =   24
            Top             =   240
            Value           =   -1  'True
            Width           =   1935
         End
      End
      Begin VB.Frame Frame6 
         Caption         =   "Select"
         Height          =   615
         Left            =   120
         TabIndex        =   20
         Top             =   840
         Width           =   2655
         Begin VB.OptionButton Option8 
            Caption         =   "Bundler"
            Height          =   255
            Left            =   1440
            TabIndex        =   22
            Top             =   240
            Width           =   1095
         End
         Begin VB.OptionButton Option7 
            Caption         =   "Presenter"
            Height          =   255
            Left            =   240
            TabIndex        =   21
            Top             =   240
            Value           =   -1  'True
            Width           =   975
         End
      End
      Begin VB.Frame Frame5 
         Caption         =   "Select Mode"
         Height          =   615
         Left            =   120
         TabIndex        =   17
         Top             =   120
         Width           =   2655
         Begin VB.OptionButton Option6 
            Caption         =   "Page"
            Height          =   255
            Left            =   1560
            TabIndex        =   19
            Top             =   240
            Width           =   855
         End
         Begin VB.OptionButton Option5 
            Caption         =   "Standard"
            Height          =   255
            Left            =   240
            TabIndex        =   18
            Top             =   240
            Value           =   -1  'True
            Width           =   975
         End
      End
      Begin VB.Label LabelResolution 
         Caption         =   "Resolution:"
         Height          =   255
         Left            =   240
         TabIndex        =   52
         Top             =   4320
         Width           =   975
      End
      Begin VB.Label Label11 
         Caption         =   "Page width:"
         Height          =   255
         Left            =   240
         TabIndex        =   51
         Top             =   3840
         Width           =   975
      End
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Sending data to file but not to port."
      Height          =   255
      Left            =   120
      TabIndex        =   35
      Top             =   4920
      Width           =   3015
   End
   Begin VB.Frame Frame2 
      Caption         =   "Set Port"
      Height          =   3855
      Left            =   130
      TabIndex        =   5
      Top             =   960
      Width           =   5280
      Begin VB.ComboBox Combo8 
         Enabled         =   0   'False
         Height          =   315
         Left            =   1440
         TabIndex        =   15
         Text            =   "BK-S2162(S)"
         Top             =   3360
         Width           =   2655
      End
      Begin VB.TextBox Text2 
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
         Height          =   285
         Left            =   1440
         MaxLength       =   9
         TabIndex        =   14
         Text            =   "90000"
         Top             =   2880
         Width           =   1335
      End
      Begin VB.TextBox Text1 
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
         Height          =   285
         Left            =   1440
         MaxLength       =   9
         TabIndex        =   13
         Text            =   "3000"
         Top             =   2400
         Width           =   1335
      End
      Begin VB.ComboBox Combo7 
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "KIOSKDLLDEMO_VB.frx":0046
         Left            =   1440
         List            =   "KIOSKDLLDEMO_VB.frx":0050
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   1920
         Width           =   1335
      End
      Begin VB.ComboBox Combo6 
         Height          =   315
         ItemData        =   "KIOSKDLLDEMO_VB.frx":0064
         Left            =   3960
         List            =   "KIOSKDLLDEMO_VB.frx":006B
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   1440
         Width           =   1215
      End
      Begin VB.ComboBox Combo3 
         Height          =   315
         ItemData        =   "KIOSKDLLDEMO_VB.frx":0078
         Left            =   1440
         List            =   "KIOSKDLLDEMO_VB.frx":0082
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   1440
         Width           =   1215
      End
      Begin VB.ComboBox Combo5 
         Height          =   315
         ItemData        =   "KIOSKDLLDEMO_VB.frx":008C
         Left            =   3960
         List            =   "KIOSKDLLDEMO_VB.frx":0096
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   960
         Width           =   1215
      End
      Begin VB.ComboBox Combo2 
         Height          =   315
         ItemData        =   "KIOSKDLLDEMO_VB.frx":00A0
         Left            =   1440
         List            =   "KIOSKDLLDEMO_VB.frx":00B9
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   960
         Width           =   1215
      End
      Begin VB.ComboBox Combo4 
         Height          =   315
         ItemData        =   "KIOSKDLLDEMO_VB.frx":00EC
         Left            =   3960
         List            =   "KIOSKDLLDEMO_VB.frx":00FF
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   480
         Width           =   1215
      End
      Begin VB.ComboBox Combo1 
         Height          =   315
         ItemData        =   "KIOSKDLLDEMO_VB.frx":0121
         Left            =   1440
         List            =   "KIOSKDLLDEMO_VB.frx":0143
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   480
         Width           =   1215
      End
      Begin VB.Label Label14 
         Caption         =   "( Millisecond )"
         Height          =   255
         Left            =   2880
         TabIndex        =   54
         Top             =   2880
         Width           =   1095
      End
      Begin VB.Label Label13 
         Caption         =   "( Millisecond )"
         Height          =   255
         Left            =   2880
         TabIndex        =   53
         Top             =   2400
         Width           =   975
      End
      Begin VB.Label Label10 
         Caption         =   "Driver Name:"
         Height          =   255
         Left            =   360
         TabIndex        =   50
         Top             =   3360
         Width           =   975
      End
      Begin VB.Label Label9 
         Caption         =   "WriteTimeOut:"
         Height          =   255
         Left            =   240
         TabIndex        =   49
         Top             =   2880
         Width           =   1095
      End
      Begin VB.Label Label8 
         Caption         =   "ReadTimeOut:"
         Height          =   255
         Left            =   240
         TabIndex        =   48
         Top             =   2400
         Width           =   1095
      End
      Begin VB.Label Label7 
         Caption         =   "LPT Address:"
         Height          =   255
         Left            =   300
         TabIndex        =   47
         Top             =   1920
         Width           =   975
      End
      Begin VB.Label Label6 
         Caption         =   "Flow Control:"
         Height          =   255
         Left            =   2880
         TabIndex        =   46
         Top             =   1440
         Width           =   975
      End
      Begin VB.Label Label5 
         Caption         =   "Data Bits:"
         Height          =   255
         Left            =   580
         TabIndex        =   45
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label Label4 
         Caption         =   "Stop Bits:"
         Height          =   255
         Left            =   3120
         TabIndex        =   44
         Top             =   960
         Width           =   735
      End
      Begin VB.Label Label3 
         Caption         =   "Baudrate:"
         Height          =   255
         Left            =   580
         TabIndex        =   43
         Top             =   960
         Width           =   735
      End
      Begin VB.Label Label2 
         Caption         =   "Parity:"
         Height          =   255
         Index           =   0
         Left            =   3360
         TabIndex        =   42
         Top             =   480
         Width           =   495
      End
      Begin VB.Label Label1 
         Caption         =   "COM Name:"
         Height          =   255
         Index           =   0
         Left            =   400
         TabIndex        =   41
         Top             =   480
         Width           =   975
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Select Port"
      Height          =   855
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   5295
      Begin VB.OptionButton Option4 
         Caption         =   "Driver"
         Height          =   255
         Left            =   4320
         TabIndex        =   4
         Top             =   360
         Width           =   855
      End
      Begin VB.OptionButton Option3 
         Caption         =   "USB"
         Height          =   255
         Left            =   2880
         TabIndex        =   3
         Top             =   360
         Width           =   855
      End
      Begin VB.OptionButton Option2 
         Caption         =   "LPT"
         Height          =   255
         Left            =   1560
         TabIndex        =   2
         Top             =   360
         Width           =   855
      End
      Begin VB.OptionButton Option1 
         Caption         =   "COM"
         Height          =   255
         Left            =   240
         TabIndex        =   1
         Top             =   360
         Value           =   -1  'True
         Width           =   855
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim porttype As Long               'Port type
Dim printmode As Long              'Print mode
Dim printwidth As Long             'Paper width
Dim printresolution As Long        'Print DPI
Dim sendfile As Long               'Save data to file
Dim paperoutmode As Long           'Mode of paper out
Dim presentertype As Long          'Presenter setting
Dim bundlertype As Long            'Bundler setting
Dim StopThread As Boolean          'Flag of end thread
Dim g_hPort As Long                'Handle of port
Dim state_print As Long
Dim autoreturn As Long             'start status monitor

Private Sub Check1_Click()
    If (Check1.Value = 1) Then  'Setting flag of saving data to file
        sendfile = 1
    Else
        sendfile = 0
    End If
End Sub

Private Sub Command1_Click()
    Dim state As Long
    Dim PortName As String            'Port name
    Dim nComBaudrate As Long          'Bits per second
    Dim nComByteSize  As Long         'Data bits
    Dim nComStopBits As Long          'Stop bits
    Dim nComParity As Long            'Parity
    Dim nComFlowControl As Long       'Flow control
    Dim nLptAddr As Long              'Lpt address
    Dim nReadTime As Long             'Read timeout
    Dim nWriteTime As Long            'Write timeout
    Dim nDrvName As String            'Name of printer driver
    Dim index As Integer              'List index
    
    'Series port setting
    If porttype = 0 Then
        PortName = Combo1.Text
        index = Combo2.ListIndex
        Select Case index
            Case 0
                nComBaudrate = 2400
            Case 1
                nComBaudrate = 4800
            Case 2
                nComBaudrate = 9600
            Case 3
                nComBaudrate = 19200
            Case 4
                nComBaudrate = 38400
            Case 5
                nComBaudrate = 57600
            Case 6
                nComBaudrate = 115200
        End Select
        
        index = Combo3.ListIndex
        Select Case index
            Case 0
                nComByteSize = 7
            Case 1
                nComByteSize = 8
        End Select
        
        nComParity = Combo4.ListIndex           'Set Parity
        nComStopBits = Combo5.ListIndex         'Stop bits Setting
        nComFlowControl = Combo6.ListIndex      'Flow control Setting
        nReadTime = Text1.Text
        nWriteTime = Text2.Text
        
        If g_hPort <> -1 Then  'If checking handle of port is not null,first close it.
            state = KIOSK_CloseCom(g_hPort)
        End If
        
        'Open series port
        g_hPort = KIOSK_OpenCom(PortName, nComBaudrate, nComByteSize, nComStopBits, nComParity, nComFlowControl)
        
        If g_hPort = -1 Then
            Text3.Text = "Open COM failed!"
            Exit Sub
        Else
           Text3.Text = "Open COM success!"
           
           state = KIOSK_SetComTimeOuts(g_hPort, 0, nWriteTime, 0, nReadTime) 'Set the timeouts of serial port.
           
           'Enablewindow Setting
           Command1.Enabled = False
           Command2.Enabled = True
           Command3.Enabled = True
           Command4.Enabled = True
           Command6.Enabled = True
           Command7.Enabled = False
           Command8.Enabled = True
           Command9.Enabled = True
        End If
    ElseIf porttype = 1 Then   'LPT setting
        Select Case Combo7.ListIndex
            Case 0
                lptaddr = &H278
            Case 1
                lptaddr = &H378
        End Select
        
        g_hPort = KIOSK_OpenLptByDrv(lptaddr)  'Open LPT
        
        If g_hPort <> KIOSK_SUCCESS Then
            Text3.Text = "Open LPT failed!"
            Exit Sub
        Else
           Text3.Text = "Open LPT success!"
           
           'Enablewindow Setting
           Command1.Enabled = False
           Command2.Enabled = False
           Command3.Enabled = True
           Command4.Enabled = True
           Command6.Enabled = False
           Command7.Enabled = False
           Command8.Enabled = True
           Command9.Enabled = True
        End If
    ElseIf porttype = 2 Then   'USB port setting
        nReadTime = Text1.Text
        nWriteTime = Text2.Text
        
        g_hPort = KIOSK_OpenUsb()    'Open USB port
        
        If g_hPort = -1 Then
            Text3.Text = "Open USB failed!"
            Exit Sub
        Else
           Text3.Text = "Open USB success!"
           
           state = KIOSK_SetUsbTimeOuts(g_hPort, nReadTime, nWriteTime)
           
           'Enablewindow Setting
           Command1.Enabled = False
           Command2.Enabled = True
           Command3.Enabled = True
           Command4.Enabled = True
           Command6.Enabled = True
           Command7.Enabled = False
           Command8.Enabled = True
           Command9.Enabled = True
        End If
        
    ElseIf porttype = 3 Then    'Driver Setting
        nDrvName = Combo8.Text
        
        g_hPort = KIOSK_OpenDrv(nDrvName)   'Open printer driver
        
        If g_hPort = -1 Then
            Text3.Text = "Open Driver failed!"
            Exit Sub
        Else
           Text3.Text = "Open Driver success!"
           
           'Enablewindow Setting
           Command1.Enabled = False
           Command2.Enabled = False
           Command3.Enabled = True
           Command4.Enabled = True
           Command6.Enabled = False
           Command7.Enabled = False
           Command8.Enabled = True
           Command9.Enabled = True
        End If
    
    End If
End Sub

Private Sub Command2_Click()    'Query status and parse data
    Dim buf As Byte
    Dim state As Long
    state = KIOSK_QueryASB(g_hPort, porttype, 0)  'Stop the Automatic Status Back first.
    If state <> KIOSK_SUCCESS Then
       Text3.Text = "Query status failed！"
       
       Command1.Enabled = True
       Command2.Enabled = False
       Command3.Enabled = False
       Command4.Enabled = False
       Command6.Enabled = False
       Command7.Enabled = False
       Exit Sub
    End If
       
    state = KIOSK_RTQueryStatus(g_hPort, porttype, buf)  'Query the real-time status of printer.
    
    If state <> KIOSK_SUCCESS Then
       Text3.Text = "Query status failed！"
       
       Command1.Enabled = True
       Command2.Enabled = False
       Command3.Enabled = False
       Command4.Enabled = False
       Command6.Enabled = False
       Command7.Enabled = False
       Exit Sub
    End If

    Text3.Text = ""
    If buf = 0 Then
        Text3.Text = "All is ok"
    End If
    
    If (buf And &H1) = &H1 Then
        Text3.Text = Text3.Text & "Head Up!"    'Head Up
    End If
    
    If (buf And &H2) = &H2 Then
        Text3.Text = Text3.Text & "Paper End！" 'Paper End
    End If
    
    If (buf And &H4) = &H4 Then
        Text3.Text = Text3.Text & "Cutter Error！" 'Cutter Error
    End If

    If (buf And &H8) = &H8 Then
        Text3.Text = Text3.Text & "TPH Too Hot！"  'TPH Too Hot
    End If
        
    If (buf And &H10) = &H10 Then
        Text3.Text = Text3.Text & "Paper Near End！" 'Paper Near End
    End If

    If (buf And &H20) = &H20 Then
        Text3.Text = Text3.Text & "Paper Jam！"    'Paper Jam
    End If

    If (buf And &H40) = &H40 Then
        Text3.Text = Text3.Text & "Presenter/Bundler Paper Jam！"  'Presenter/Bundler Paper Jam
    End If

    If (buf And &H80) = &H80 Then
        Text3.Text = Text3.Text & "Auto Feed Error！"   'Auto Feed Error
    End If


End Sub

Public Sub PrintSample()
    Dim state As Long
    
    printwidth = Combo9.ListIndex
    printresolution = Combo10.ListIndex
    
    
    If (porttype = 3) Then  'When it is driver
        state = KIOSK_StartDoc(g_hPort)
    End If
    
    If (sendfile = 1) Then
        state_print = KIOSK_BeginSaveToFile(g_hPort, "Test.dat", False)
    End If
    'StandardMode
    If (printmode = 0) Then
        'The page width is 56mm.
        If (printwidth = 0) Then
            'The resolution is 203dpi.
            If (printresolution = 0) Then
            
                state = PrintInStandardMode56_203DPI(g_hPort, porttype)
                If (porttype = 3) Then  'When it is driver
                    KIOSK_EndDoc (g_hPort)
                End If
                If (state_print = KIOSK_SUCCESS) Then
                    Text3.Text = "Print success!"
                Else
                    Text3.Text = "Print failed!"
                    state = ClosePort()
                    Exit Sub
                End If
            End If
                
            
            'The resolution is 300dpi.
            If (printresolution = 1) Then
                state = PrintInStandardMode56_300DPI(g_hPort, porttype)
                If (porttype = 3) Then  'When it is driver
                    KIOSK_EndDoc (g_hPort)
                End If
                If (state_print = KIOSK_SUCCESS) Then
                    Text3.Text = "Print success!"
                Else
                    Text3.Text = "Print failed!"
                    state = ClosePort()
                    Exit Sub
                End If
            End If
         End If
        
        'The page width is 80mm.
        If (printwidth = 1) Then
            'The resolution is 203dpi.
            If (printresolution = 0) Then
                state = PrintInStandardMode80_203DPI(g_hPort, porttype)
                If (porttype = 3) Then  'When it is driver
                    KIOSK_EndDoc (g_hPort)
                End If
                If (state_print = KIOSK_SUCCESS) Then
                    Text3.Text = "Print success!"
                Else
                    Text3.Text = "Print failed!"
                    state = ClosePort()
                    Exit Sub
                End If
            End If
                
            
            'The resolution is 300dpi.
            If (printresolution = 1) Then
                state = PrintInStandardMode80_300DPI(g_hPort, porttype)
                If (porttype = 3) Then  'When it is driver
                    KIOSK_EndDoc (g_hPort)
                End If
                If (state_print = KIOSK_SUCCESS) Then
                    Text3.Text = "Print success!"
                Else
                    Text3.Text = "Print failed!"
                    state = ClosePort()
                    Exit Sub
                End If
            End If
        End If
            
        
        'The page width is 210mm.
        If (printwidth = 2) Then
        
            'The resolution is 203dpi.
            If (printresolution = 0) Then
                state = PrintInStandardMode210_203DPI(g_hPort, porttype)
                If (porttype = 3) Then  'When it is driver
                    KIOSK_EndDoc (g_hPort)
                End If
                If (state_print = KIOSK_SUCCESS) Then
                    Text3.Text = "Print success!"
                Else
                    Text3.Text = "Print failed!"
                    state = ClosePort()
                    Exit Sub
                End If
            End If
            
            'The resolution is 300dpi.
            If (printresolution = 1) Then
                state = PrintInStandardMode210_300DPI(g_hPort, porttype)
                If (porttype = 3) Then  'When it is driver
                    KIOSK_EndDoc (g_hPort)
                End If
                If (state_print = KIOSK_SUCCESS) Then
                    Text3.Text = "Print success!"
                Else
                    Text3.Text = "Print failed!"
                    state = ClosePort()
                    Exit Sub
                End If
            End If
        End If
    End If
    
    'PageMode
    If (printmode = 1) Then
        'The page width is 56mm.
        If (printwidth = 0) Then
            'The resolution is 203dpi.
            If (printresolution = 0) Then
                state = PrintInPageMode56_203DPI(g_hPort, porttype)
                If (porttype = 3) Then  'When it is driver
                    KIOSK_EndDoc (g_hPort)
                End If
                If (state_print = KIOSK_SUCCESS) Then
                    Text3.Text = "Print success!"
                Else
                    Text3.Text = "Print failed!"
                    state = ClosePort()
                    Exit Sub
                End If
            End If
            
            'The resolution is 300dpi.
            If (printresolution = 1) Then
                state = PrintInPageMode56_300DPI(g_hPort, porttype)
                If (porttype = 3) Then  'When it is driver
                    KIOSK_EndDoc (g_hPort)
                End If
                If (state_print = KIOSK_SUCCESS) Then
                    Text3.Text = "Print success!"
                Else
                    Text3.Text = "Print failed!"
                    state = ClosePort()
                    Exit Sub
                End If
            End If
        End If
         
        
        'The page width is 80mm.
        If (printwidth = 1) Then
            'The resolution is 230dpi.
            If (printresolution = 0) Then
                state = PrintInPageMode80_203DPI(g_hPort, porttype)
                If (porttype = 3) Then  'When it is driver
                    KIOSK_EndDoc (g_hPort)
                End If
                If (state_print = KIOSK_SUCCESS) Then
                    Text3.Text = "Print success!"
                Else
                    Text3.Text = "Print failed!"
                    state = ClosePort()
                    Exit Sub
                End If
            End If
            
            'The resolution is 300dpi.
            If (printresolution = 1) Then
                state = PrintInPageMode80_300DPI(g_hPort, porttype)
                If (porttype = 3) Then  'When it is driver
                    KIOSK_EndDoc (g_hPort)
                End If
                If (state_print = KIOSK_SUCCESS) Then
                    Text3.Text = "Print success!"
                Else
                    Text3.Text = "Print failed!"
                
                    state = ClosePort()
                    Exit Sub
                End If
            End If
        End If
        
        'The page width is 210mm.
        If (printwidth = 2) Then
            'The resolution is 203dpi.
            If (printresolution = 0) Then
                state = PrintInPageMode210_203DPI(g_hPort, porttype)
                If (porttype = 3) Then  'When it is driver
                    KIOSK_EndDoc (g_hPort)
                End If
                If (state_print = KIOSK_SUCCESS) Then
                
                    Text3.Text = "Print success!"
                Else
                    Text3.Text = "Print failed!"
                    state = ClosePort()
                    Exit Sub
                End If
            End If
            
            'The resolution is 300dpi.
            If (printresolution = 1) Then
                state = PrintInPageMode210_300DPI(g_hPort, porttype)
                If (porttype = 3) Then  'When it is driver
                    KIOSK_EndDoc (g_hPort)
                End If
                If (state_print = KIOSK_SUCCESS) Then
                
                    Text3.Text = "Print success!"
                Else
                    Text3.Text = "Print failed!"
                    state = ClosePort()
                    Exit Sub
                End If
            End If
        End If
    End If
    
    If (porttype = 3) Then  'When it is driver
        state = KIOSK_StartDoc(g_hPort)
    End If
    If (paperoutmode = 0) Then
                
        Select Case presentertype
        'Set Presenter
        Case 0: 'Presenter Retraction_on
                If (KIOSK_SetPresenter(g_hPort, porttype, KIOSK_PRESENTER_Retraction_on, 3) <> KIOSK_SUCCESS) Then
                    If (porttype = 3) Then  'When it is driver
                        KIOSK_EndDoc (g_hPort)
                    End If
                    Text3.Text = "Set Presenter failed!"
                    Exit Sub
                End If
        Case 1: 'Presenter Paper_Forward
                If (KIOSK_SetPresenter(g_hPort, porttype, KIOSK_PRESENTER_Paper_Forward, 3) <> KIOSK_SUCCESS) Then
                    If (porttype = 3) Then  'When it is driver
                        KIOSK_EndDoc (g_hPort)
                    End If
                    Text3.Text = "Set Presenter failed!"
                    Exit Sub
                End If

        Case 2: 'Presenter Paper_Hold
                If (KIOSK_SetPresenter(g_hPort, porttype, KIOSK_PRESENTER_Paper_Hold, 3) <> KIOSK_SUCCESS) Then
                    If (porttype = 3) Then  'When it is driver
                        KIOSK_EndDoc (g_hPort)
                    End If
                    Text3.Text = "Set Presenter failed!"
                    Exit Sub
                End If
        End Select
    
    ElseIf (paperoutmode = 1) Then
    
        Select Case bundlertype
        'Set Bundler
        Case 0: 'Bundler Retract
                If (KIOSK_SetBundler(g_hPort, porttype, KIOSK_BUNDLER_Retract, 3) <> KIOSK_SUCCESS) Then
                    If (porttype = 3) Then  'When it is driver
                        KIOSK_EndDoc (g_hPort)
                    End If
                    Text3.Text = "Set Bundler failed!"
                    Exit Sub
                End If
        Case 1: 'Bundler Present
                If (KIOSK_SetBundler(g_hPort, porttype, KIOSK_BUNDLER_Present, 3) <> KIOSK_SUCCESS) Then
                    If (porttype = 3) Then  'When it is driver
                        KIOSK_EndDoc (g_hPort)
                    End If
                    Text3.Text = "Set Bundler failed!"
                    Exit Sub
                End If
       End Select
    End If
    If (porttype = 3) Then  'When it is driver
        KIOSK_EndDoc (g_hPort)
    End If
    
    If (sendfile = 1) Then 'Stop saving data to file.
        state_print = KIOSK_EndSaveToFile(g_hPort)
    End If
End Sub

Private Sub Command3_Click()
    PrintSample
End Sub

Private Sub Command4_Click()    'Close port
    Dim state As Long
    
    StopThread = True
    
    If (porttype = 0) Then  'Serial port Closing
         state = KIOSK_CloseCom(g_hPort)
         Text3.Text = "Close COM success!"
        
    ElseIf (porttype = 1) Then  'LPT port Closing
        state = KIOSK_CloseDrvLPT(1)
         Text3.Text = "Close LPT success!"
    ElseIf (porttype = 2) Then  'USB port Closing
        state = KIOSK_CloseUsb(g_hPort)
         Text3.Text = "Close USB success!"
    ElseIf (porttype = 3) Then  'Driver port Closing
        state = KIOSK_CloseDrv(g_hPort)
         Text3.Text = "Close Driver success!"
    End If
    
    'Enablewindow Setting
    Command1.Enabled = True
    Command2.Enabled = False
    Command3.Enabled = False
    Command4.Enabled = False
   
    Command6.Enabled = False
    Command7.Enabled = False
    Command8.Enabled = False
    Command9.Enabled = False
    Timer1.Enabled = Flase

End Sub

Public Function ClosePort() As Long     'Close port to function
    Dim state As Long
    
    StopThread = True
    
    If (porttype = 0) Then        'Serial port Closing
         state = KIOSK_CloseCom(g_hPort)
    ElseIf (porttype = 1) Then      'LPT port Closing
        state = KIOSK_CloseDrvLPT(1)
    ElseIf (porttype = 2) Then    'USB port Closing
        state = KIOSK_CloseUsb(g_hPort)
    ElseIf (porttype = 3) Then    'Driver port Closing
        state = KIOSK_CloseDrv(g_hPort)
    End If
    
    'Enablewindow Setting
    g_hPort = -1
    Command1.Enabled = True
    Command2.Enabled = False
    Command3.Enabled = False
    Command4.Enabled = False
    Command6.Enabled = False
    Command7.Enabled = False
End Function


Private Sub Command5_Click()
    Unload Form1
End Sub

Private Sub Command6_Click()
    Dim state As Long
    
    Command6.Enabled = False
    Command7.Enabled = True
    Command2.Enabled = False
    
    List1.Clear
    
    state = KIOSK_QueryASB(g_hPort, porttype, 1)  'Start-up ASB
    
    If state <> KIOSK_SUCCESS Then
        Exit Sub
    End If
    
    Timer1.Interval = 500
    Timer1.Enabled = True
End Sub

Private Sub Command7_Click()
    Dim state As Long
    Command6.Enabled = True
    Command7.Enabled = False
    StopThread = True
    Timer1.Enabled = Flase
    KIOSK_QueryASB g_hPort, porttype, 0
    Command2.Enabled = True

End Sub

Private Sub Command8_Click()
    Dim state As Integer
    state = KIOSK_BarcodeSetPDF417(g_hPort, porttype, "1234567890abcdefg", 17, 3, 10, 10, 5, 50, 5, 5)
End Sub

Public Function IsPrinting() As Boolean
    Dim cStatus As Byte
    Dim nRet As Integer
    cStatus = &H0
    
    nRet = KIOSK_RTQueryStatusForT681(g_hPort, porttype, cStatus)
    If nRet <> KIOSK_SUCCESS Then
        IsPrinting = False
        Exit Function
    End If
    
    If (cStatus And &H80) = &H80 Then
        IsPrinting = True
        Exit Function
    End If
    
    IsPrinting = False

End Function

Public Function PaperTackout() As Boolean
    Dim cStatus As Byte
    Dim nRet As Integer
    cStatus = &H0
    
    nRet = KIOSK_RTQueryStatusForT681(g_hPort, porttype, cStatus)
    If nRet <> KIOSK_SUCCESS Then
        PaperTackout = True
        Exit Function
    End If
    
    If (cStatus And &H40) = &H40 Then
        PaperTackout = False
        Exit Function
    End If
    
    PaperTackout = True
    
End Function

Private Sub Command9_Click()
    Dim i As Integer
    Dim bRet As Boolean
    
    '打印三次样张
    For i = 0 To 2
        PrintSample
        
        '等待打印机完成打印
        Do While True
            Sleep (100)
            bRet = IsPrinting()
            If bRet = True Then
                GoTo NextLoop
            End If
            
            Exit Do
NextLoop:
        Loop
        
        '打印完成后，查询纸是否被取走，取走后发送下一张数据
        Do While True
            Sleep (100)
            bRet = PaperTackout()
            If bRet = True Then
                Exit Do
            End If
        Loop
    Next i
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim hHelpWnd As Long

    If KeyCode = vbKeyF1 Then
        hHelpWnd = FindWindow(vbNullString, "KIOSKDLLDEMO")
        If hHelpWnd = 0 Then
            ShellExecute Me.hwnd, "Open", "KIOSKDLLDEMO.chm", vbNullString, vbNullString, vbNormalFocus
        Else
            BringWindowToTop hHelpWnd
            OpenIcon hHelpWnd
        End If
    End If
End Sub

Private Sub Form_Load()   'Initializtion
    Combo1.ListIndex = 0
    Combo2.ListIndex = 4
    Combo3.ListIndex = 1
    Combo4.ListIndex = 0
    Combo5.ListIndex = 0
    Combo6.ListIndex = 0
    Combo7.ListIndex = 0
   'Combo8.ListIndex = 0
    Combo9.ListIndex = 1
    Combo10.ListIndex = 0
    porttype = 0
    sendfile = 0
    Me.KeyPreview = True
    autoreturn = 0
End Sub



Private Sub Option1_Click()   'Selected series port
    Dim state As Long
    Combo1.Enabled = True
    Combo2.Enabled = True
    Combo3.Enabled = True
    Combo4.Enabled = True
    Combo5.Enabled = True
    Combo6.Enabled = True
    Combo7.Enabled = False
    Combo8.Enabled = False
    Text1.Enabled = True
    Text2.Enabled = True
    Text1.Text = "3000"
    Text2.Text = "90000"
    state = ClosePort()
    porttype = 0
    
End Sub

Private Sub Option10_Click()
    presentertype = 1
End Sub

Private Sub Option11_Click()
    presentertype = 2
End Sub

Private Sub Option12_Click()
    bundlertype = 0
End Sub

Private Sub Option13_Click()
    bundlertype = 1
End Sub

Private Sub Option2_Click()
    Dim state As Long
    Combo1.Enabled = False
    Combo2.Enabled = False
    Combo3.Enabled = False
    Combo4.Enabled = False
    Combo5.Enabled = False
    Combo6.Enabled = False
    Combo7.Enabled = True
    Combo8.Enabled = False
    Text1.Enabled = False
    Text2.Enabled = False
    state = ClosePort()
    porttype = 1
        
End Sub

Private Sub Option3_Click()
    Dim state As Long
    Combo1.Enabled = False
    Combo2.Enabled = False
    Combo3.Enabled = False
    Combo4.Enabled = False
    Combo5.Enabled = False
    Combo6.Enabled = False
    Combo7.Enabled = False
    Combo8.Enabled = False
    Text1.Enabled = True
    Text2.Enabled = True
    Text1.Text = "2000"
    Text2.Text = "2000"
    
    If g_hPort <> -1 Then
        state = ClosePort()
    End If
    porttype = 2
End Sub

Private Sub Option4_Click()
    
    Dim longbuffer() As Long
    Dim printinfo() As PRINTER_INFO_2
    Dim numbytes As Long
    Dim numneeded As Long
    Dim numprinters As Long
    Dim c As Integer, retval As Long

    numbytes = 3076
    ReDim longbuffer(0 To numbytes / 4) As Long
    retval = EnumPrinters(2, "", 2, longbuffer(0), numbytes, numneeded, numprinters)
    numbytes = numneeded
    ReDim longbuffer(0 To numbytes / 4) As Long
    retval = EnumPrinters(2, "", 2, longbuffer(0), numbytes, numneeded, numprinters)
    
    ReDim printinfo(0 To numprinters - 1) As PRINTER_INFO_2
    
    For c = 0 To numprinters - 1
        printinfo(c).pPrinterName = Space(lstrlen(longbuffer(21 * c + 1)))
        retval = lstrcpy(printinfo(c).pPrinterName, longbuffer(21 * c + 1))
        
        If (InStr(1, printinfo(c).pPrinterName, "Microcom") = 1) Then
            Combo8.AddItem printinfo(c).pPrinterName
            Combo8.ListIndex = 0
        End If
    Next c

    
    Combo1.Enabled = False
    Combo2.Enabled = False
    Combo3.Enabled = False
    Combo4.Enabled = False
    Combo5.Enabled = False
    Combo6.Enabled = False
    Combo7.Enabled = False
    Combo8.Enabled = True
    Text1.Enabled = False
    Text2.Enabled = False
    state = ClosePort()
    porttype = 3
     
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  Function:       PrintInStandardMode56_203DPI()
'  Description:    Print sample
'  Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
'                  KIOSK_Reset()                       //Reset the printer.
'                  KIOSK_SetMode()                     //Set the mode of printing.
'                  KIOSK_SetMotionUnit()               //Set the units of motion.
'                  KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
'                  KIOSK_SetRightSpacing()             //Set the right spacing of character.
'                  KIOSK_SetLineSpacing()              //Set the spacing of lines.
'                  KIOSK_S_Textout()                   //Write one character string at the specified position.
'                  KIOSK_FeedLine()                    //Feed 1 line.
'                  KIOSK_FeedLines()                   //Feed paper forward.
'                  KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
'                  KIOSK_S_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
'                  KIOSK_CutPaper()                    //Cut paper.
'  Called By:      OnPrint()
'  Input:          g_hPort: port handle
'                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
'  Return:         Returns True if successful, False if not successful.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Function PrintInStandardMode56_203DPI(ByVal g_hPort As Long, ByVal porttype As Integer) As Long
    Dim bIsFirst As Boolean
    Dim state As Integer
    
    'Download bit map.
    bIsFirst = True
    
    If (bIsFirst = True) Then
        'Pre-download a group of bit map to Flash by specifying it's ID.
        state_print = KIOSK_PreDownloadBmpToFlash(g_hPort, porttype, "kitty.bmp", 2, 1)
        bIsFirst = False
    End If

    'Print setting.
    state_print = KIOSK_Reset(g_hPort, porttype)   'Reset printer
    
    KIOSK_SetMode g_hPort, porttype, KIOSK_PRINT_MODE_STANDARD  'Setting print mode
    
    '''''''Next,setting printing content'''''''''
    
    KIOSK_SetMotionUnit g_hPort, porttype, 180, 180

    KIOSK_S_SetLeftMarginAndAreaWidth g_hPort, porttype, 0, 450
    
    KIOSK_SetRightSpacing g_hPort, porttype, 0

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 95)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 62, 2, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 15)
        
    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "-----------------------------------", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_FeedLine(g_hPort, porttype)

    'Text setting
    state = KIOSK_S_Textout(g_hPort, porttype, "-----------------------------------", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)
  
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_S_Textout(g_hPort, porttype, "Right Spacing", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 215, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_SetRightSpacing(g_hPort, porttype, 1)

    state = KIOSK_S_Textout(g_hPort, porttype, "Right Spacing", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)
    
    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 215, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)
    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_S_Textout(g_hPort, porttype, "Right Spacing", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 215, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)
    
    state = KIOSK_FeedLines(g_hPort, porttype, 2)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-NORMAL", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-BOLD", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 5, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE)


    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 5, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-REVERSE", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-90", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)
    

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_S_Textout(g_hPort, porttype, "-----------------------------------", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    'Bar code setting.
    state = KIOSK_S_Textout(g_hPort, porttype, "Barcode - Code 128", 5, 1, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_PrintBarcode(g_hPort, porttype, "{A*1234ABCDE*{C5678", 5, KIOSK_BARCODE_TYPE_CODE128, 2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19)

    state = KIOSK_FeedLine(g_hPort, porttype)

    
    state = KIOSK_S_Textout(g_hPort, porttype, "-----------------------------------", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    'Bit map setting.
    state = KIOSK_S_Textout(g_hPort, porttype, "---------------Logo1---------------", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_PrintBmpInFlash(g_hPort, porttype, 1, 50, KIOSK_BITMAP_PRINT_QUADRUPLE)

    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    
    'Cut paper
    state_print = KIOSK_CutPaper(g_hPort, porttype, 1, 0)
    
End Function

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  Function:       PrintInPageMode56_203DPI()
'  Description:    Print sample
'  Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
'                  KIOSK_Reset()                       //Reset the printer.
'                  KIOSK_SetMode()                     //Set the mode of printing.
'                  KIOSK_SetMotionUnit()               //Set the units of motion.
'                  KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
'                  KIOSK_P_Clear()                     //Clear the buffer.
'                  KIOSK_SetRightSpacing()             //Set the right spacing of character.
'                  KIOSK_SetLineSpacing()              //Set the spacing of lines.
'                  KIOSK_P_Textout()                   //Write one character string at the specified position.
'                  KIOSK_FeedLine()                    //Feed 1 line.
'                  KIOSK_FeedLines()                   //Feed paper forward.
'                  KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
'                  KIOSK_P_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
'                  KIOSK_P_Clear()                     //Clear the buffer.
'                  KIOSK_CutPaper()                    //Cut paper.
'  Called By:      OnPrint()
'  Input:          g_hPort: port handle
'                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
'  Return:         Returns True if successful, False if not successful.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Function PrintInPageMode56_203DPI(ByVal g_hPort As Long, ByVal porttype As Integer) As Long
    Dim bIsFirst As Boolean
    Dim state As Integer
    
    bIsFirst = True

    'Downloading images to RAM
    state_print = KIOSK_PreDownloadBmpToRAM(g_hPort, porttype, "kitty.bmp", 2, 0)

    state = KIOSK_PreDownloadBmpToRAM(g_hPort, porttype, "Look.bmp", 2, 1) 'Pre-download a bit map to RAM by specifying it's ID.
    
    state = KIOSK_Reset(g_hPort, porttype)

    state = KIOSK_SetMode(g_hPort, porttype, KIOSK_PRINT_MODE_PAGE)

    state = KIOSK_SetMotionUnit(g_hPort, porttype, 180, 180)
    
    state = KIOSK_P_SetAreaAndDirection(g_hPort, porttype, 5, 10, 450, 1200, KIOSK_AREA_LEFT_TO_RIGHT)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 95)

    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 62, 80, 2, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "-----------------------------------", 5, 120, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "-----------------------------------", 5, 140, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    'Defferent right-spacing
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_P_Textout(g_hPort, porttype, "Right Spacing", 5, 180, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 215, 180, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 1)

    state = KIOSK_P_Textout(g_hPort, porttype, "Right Spacing", 5, 210, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 215, 210, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_P_Textout(g_hPort, porttype, "Right Spacing", 5, 240, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 215, 240, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    'DIfferent font
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-NORMAL", 5, 300, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-BOLD", 5, 330, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 5, 360, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 5, 390, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-REVERSE", 5, 420, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE)

    ' Print bar code
    state = KIOSK_P_Textout(g_hPort, porttype, "-------------------------------", 5, 460, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "Barcode - Code 128", 5, 490, 1, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBarcode(g_hPort, porttype, "{A*1234ABCDE*{C5678", 5, 560, KIOSK_BARCODE_TYPE_CODE128, 2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19)
    
    state = KIOSK_P_Textout(g_hPort, porttype, "-------------------------------", 5, 610, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "-------------Logo1-------------", 5, 630, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBmpInRAM(g_hPort, porttype, 0, 5, 700, KIOSK_BITMAP_PRINT_QUADRUPLE)

    state = KIOSK_P_Textout(g_hPort, porttype, "-------------Logo2-------------", 5, 720, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBmpInRAM(g_hPort, porttype, 1, 5, 810, KIOSK_BITMAP_PRINT_QUADRUPLE)
   
    state = KIOSK_P_Print(g_hPort, porttype)

    state = KIOSK_P_Clear(g_hPort, porttype)

    state_print = KIOSK_CutPaper(g_hPort, porttype, 1, 0)

    ' Stop saving data to file.

End Function

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  Function:       PrintInStandardMode56_300DPI()
'  Description:    Print sample
'  Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
'                  KIOSK_Reset()                       //Reset the printer.
'                  KIOSK_SetMode()                     //Set the mode of printing.
'                  KIOSK_SetMotionUnit()               //Set the units of motion.
'                  KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
'                  KIOSK_SetRightSpacing()             //Set the right spacing of character.
'                  KIOSK_SetLineSpacing()              //Set the spacing of lines.
'                  KIOSK_S_Textout()                   //Write one character string at the specified position.
'                  KIOSK_FeedLine()                    //Feed 1 line.
'                  KIOSK_FeedLines()                   //Feed paper forward.
'                  KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
'                  KIOSK_S_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
'                  KIOSK_CutPaper()                    //Cut paper.
'  Called By:      OnPrint()
'  Input:          g_hPort: port handle
'                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
'  Return:         Returns True if successful, False if not successful.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Function PrintInStandardMode56_300DPI(ByVal g_hPort As Long, ByVal porttype As Integer) As Long
    Dim bIsFirst As Boolean
    Dim state As Integer
    
    bIsFirst = True
    
    If (bIsFirst = True) Then
        state_print = KIOSK_PreDownloadBmpToFlash(g_hPort, porttype, "kitty.bmp", 2, 1) 'Pre-download a group of bit map to Flash by specifying it's ID.
        bIsFirst = False
    End If
    
    
    state_print = KIOSK_Reset(g_hPort, porttype)

    state = KIOSK_SetMode(g_hPort, porttype, KIOSK_PRINT_MODE_STANDARD)
    
    state = KIOSK_SetMotionUnit(g_hPort, porttype, 180, 180)

    state = KIOSK_S_SetLeftMarginAndAreaWidth(g_hPort, porttype, 0, 670)
    
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 95)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 62, 2, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 15)
        
    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "-----------------------------------", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "-----------------------------------", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)

    ' Defferent right-spacing
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_S_Textout(g_hPort, porttype, "Right Spacing", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 215, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 1)

    state = KIOSK_S_Textout(g_hPort, porttype, "Right Spacing", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)
    
    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 215, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_S_Textout(g_hPort, porttype, "Right Spacing", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 215, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)
    
    state = KIOSK_FeedLines(g_hPort, porttype, 2)

    'Defferent font
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-NORMAL", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-BOLD", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 5, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 5, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-REVERSE", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-90", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)
    

    ' Print bar code
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_S_Textout(g_hPort, porttype, "-----------------------------------", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "Barcode - Code 128", 5, 1, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_PrintBarcode(g_hPort, porttype, "{A*1234ABCDE*{C5678", 5, KIOSK_BARCODE_TYPE_CODE128, 2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19)

    state = KIOSK_FeedLine(g_hPort, porttype)

    
    state = KIOSK_S_Textout(g_hPort, porttype, "-----------------------------------", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "---------------Logo1---------------", 5, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_PrintBmpInFlash(g_hPort, porttype, 1, 50, KIOSK_BITMAP_PRINT_QUADRUPLE)

    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)

    ' Cut paper
    state_print = KIOSK_CutPaper(g_hPort, porttype, 1, 0)

End Function

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  Function:       PrintInPageMode56_300DPI()
'  Description:    Print sample
'  Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
'                  KIOSK_Reset()                       //Reset the printer.
'                  KIOSK_SetMode()                     //Set the mode of printing.
'                  KIOSK_SetMotionUnit()               //Set the units of motion.
'                  KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
'                  KIOSK_P_Clear()                     //Clear the buffer.
'                  KIOSK_SetRightSpacing()             //Set the right spacing of character.
'                  KIOSK_SetLineSpacing()              //Set the spacing of lines.
'                  KIOSK_P_Textout()                   //Write one character string at the specified position.
'                  KIOSK_FeedLine()                    //Feed 1 line.
'                  KIOSK_FeedLines()                   //Feed paper forward.
'                  KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
'                  KIOSK_P_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
'                  KIOSK_P_Clear()                     //Clear the buffer.
'                  KIOSK_CutPaper()                    //Cut paper.
'  Called By:      OnPrint()
'  Input:          g_hPort: port handle
'                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
'  Return:         Returns True if successful, False if not successful.
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Function PrintInPageMode56_300DPI(ByVal g_hPort As Long, ByVal porttype As Integer) As Long
    Dim bIsFirst As Boolean
    Dim state As Integer
    
    bIsFirst = True

    'Pre-download a bit map to RAM by specifying it's ID.
    state_print = KIOSK_PreDownloadBmpToRAM(g_hPort, porttype, "kitty.bmp", 2, 0)

    state = KIOSK_PreDownloadBmpToRAM(g_hPort, porttype, "Look.bmp", 2, 1) 'ID number is 1
    
    state = KIOSK_Reset(g_hPort, porttype)

    state = KIOSK_SetMode(g_hPort, porttype, KIOSK_PRINT_MODE_PAGE)

    state = KIOSK_SetMotionUnit(g_hPort, porttype, 180, 180)
    
    state = KIOSK_P_SetAreaAndDirection(g_hPort, porttype, 5, 10, 670, 1200, KIOSK_AREA_LEFT_TO_RIGHT)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 95)

    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 62, 80, 2, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "-----------------------------------", 5, 120, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "-----------------------------------", 5, 140, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    'Defferent right-spacing
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_P_Textout(g_hPort, porttype, "Right Spacing", 5, 180, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 215, 180, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 1)

    state = KIOSK_P_Textout(g_hPort, porttype, "Right Spacing", 5, 210, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 215, 210, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_P_Textout(g_hPort, porttype, "Right Spacing", 5, 240, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 215, 240, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    ' DIfferent font
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-NORMAL", 5, 300, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-BOLD", 5, 330, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 5, 360, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 5, 390, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-REVERSE", 5, 420, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE)

    ' Print bar code
    state = KIOSK_P_Textout(g_hPort, porttype, "-------------------------------", 5, 460, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "Barcode - Code 128", 5, 490, 1, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBarcode(g_hPort, porttype, "{A*1234ABCDE*{C5678", 5, 560, KIOSK_BARCODE_TYPE_CODE128, 2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19)
    
    state = KIOSK_P_Textout(g_hPort, porttype, "-------------------------------", 5, 610, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "-------------Logo1-------------", 5, 630, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBmpInRAM(g_hPort, porttype, 0, 5, 700, KIOSK_BITMAP_PRINT_QUADRUPLE)

    state = KIOSK_P_Textout(g_hPort, porttype, "-------------Logo2-------------", 5, 720, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBmpInRAM(g_hPort, porttype, 1, 5, 810, KIOSK_BITMAP_PRINT_QUADRUPLE)
    
    state = KIOSK_P_Print(g_hPort, porttype)

    state = KIOSK_P_Clear(g_hPort, porttype)

    state_print = KIOSK_CutPaper(g_hPort, porttype, 1, 0)

    ' Stop saving data to file.
  
End Function

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  Function:       PrintInStandardMode80_203DPI()
'  Description:    Print sample
'  Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
'                  KIOSK_Reset()                       //Reset the printer.
'                  KIOSK_SetMode()                     //Set the mode of printing.
'                  KIOSK_SetMotionUnit()               //Set the units of motion.
'                  KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
'                  KIOSK_SetRightSpacing()             //Set the right spacing of character.
'                  KIOSK_SetLineSpacing()              //Set the spacing of lines.
'                  KIOSK_S_Textout()                   //Write one character string at the specified position.
'                  KIOSK_FeedLine()                    //Feed 1 line.
'                  KIOSK_FeedLines()                   //Feed paper forward.
'                  KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
'                  KIOSK_S_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
'                  KIOSK_CutPaper()                    //Cut paper.
'  Called By:      OnPrint()
'  Input:          g_hPort: port handle
'                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
'  Return:         Returns True if successful, False if not successful.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Function PrintInStandardMode80_203DPI(ByVal g_hPort As Long, ByVal porttype As Integer) As Long
    Dim bIsFirst As Boolean
    Dim state As Integer
    Dim bmp As String
    
    bmp = "Kitty.bmp"
    
    bIsFirst = True
    
    If (bIsFirst = True) Then
        state_print = KIOSK_PreDownloadBmpToFlash(g_hPort, porttype, bmp, 2, 1) 'Pre-download a group of bit map to Flash by specifying it's ID.
        If state_print <> 1001 Then
            Exit Function
        End If
        bIsFirst = False
    End If


    state_print = KIOSK_Reset(g_hPort, porttype)

    state = KIOSK_SetMode(g_hPort, porttype, KIOSK_PRINT_MODE_STANDARD)
    
    state = KIOSK_SetMotionUnit(g_hPort, porttype, 203, 203)

    state = KIOSK_S_SetLeftMarginAndAreaWidth(g_hPort, porttype, 0, 640)
    
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 95)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 182, 2, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 24)
        
    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "------------------------------------------", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "------------------------------------------", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)


    'Defferent right-spacing
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_S_Textout(g_hPort, porttype, "Right Spacing", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 330, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_S_Textout(g_hPort, porttype, "Right Spacing", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)
    
    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 330, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 4)

    state = KIOSK_S_Textout(g_hPort, porttype, "Right Spacing", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 330, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)
    
    state = KIOSK_FeedLines(g_hPort, porttype, 2)


    'Defferent font
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-NORMAL", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-BOLD", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 95, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 95, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-REVERSE", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-90", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)

    'Print bar code
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_S_Textout(g_hPort, porttype, "------------------------------------------", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "Barcode - Code 128", 95, 1, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_PrintBarcode(g_hPort, porttype, "{A*1234ABCDE*{C5678", 95, KIOSK_BARCODE_TYPE_CODE128, 2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19)

    state = KIOSK_FeedLine(g_hPort, porttype)

  
    state = KIOSK_S_Textout(g_hPort, porttype, "------------------------------------------", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "------------------Logo 1------------------", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_PrintBmpInFlash(g_hPort, porttype, 1, 100, KIOSK_BITMAP_PRINT_QUADRUPLE)

    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)

    ' Cut paper
    state_print = KIOSK_CutPaper(g_hPort, porttype, 1, 0)
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  Function:       PrintInPageMode80_203DPI()
'  Description:    Print sample
'  Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
'                  KIOSK_Reset()                       //Reset the printer.
'                  KIOSK_SetMode()                     //Set the mode of printing.
'                  KIOSK_SetMotionUnit()               //Set the units of motion.
'                  KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
'                  KIOSK_P_Clear()                     //Clear the buffer.
'                  KIOSK_SetRightSpacing()             //Set the right spacing of character.
'                  KIOSK_SetLineSpacing()              //Set the spacing of lines.
'                  KIOSK_P_Textout()                   //Write one character string at the specified position.
'                  KIOSK_FeedLine()                    //Feed 1 line.
'                  KIOSK_FeedLines()                   //Feed paper forward.
'                  KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
'                  KIOSK_P_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
'                  KIOSK_P_Clear()                     //Clear the buffer.
'                  KIOSK_CutPaper()                    //Cut paper.
'  Called By:      OnPrint()
'  Input:          g_hPort: port handle
'                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
'  Return:         Returns True if successful, False if not successful.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Function PrintInPageMode80_203DPI(ByVal g_hPort As Long, ByVal porttype As Integer) As Long
    Dim bIsFirst As Boolean
    Dim state As Integer
    
    bIsFirst = True

    'Pre-download a bit map to RAM by specifying it's ID.
    state_print = KIOSK_PreDownloadBmpToRAM(g_hPort, porttype, "kitty.bmp", 2, 0)
   
    state = KIOSK_PreDownloadBmpToRAM(g_hPort, porttype, "Look.bmp", 2, 1)
    
    state = KIOSK_Reset(g_hPort, porttype)

    state = KIOSK_SetMode(g_hPort, porttype, KIOSK_PRINT_MODE_PAGE)

    state = KIOSK_SetMotionUnit(g_hPort, porttype, 203, 203)
    
    state = KIOSK_P_SetAreaAndDirection(g_hPort, porttype, 0, 10, 640, 1200, KIOSK_AREA_LEFT_TO_RIGHT)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 182, 80, 2, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "------------------------------------------", 95, 120, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "------------------------------------------", 95, 140, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    'Defferent Right - spacing
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_P_Textout(g_hPort, porttype, "814M", 95, 180, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 200, 180, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)


    'Defferent font
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-NORMAL", 95, 300, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-BOLD", 95, 330, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 95, 360, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 95, 390, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-REVERSE", 95, 420, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE)

    'Print code-bar
    state = KIOSK_P_Textout(g_hPort, porttype, "------------------------------------", 95, 480, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "Barcode - Code 128", 95, 505, 1, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBarcode(g_hPort, porttype, "{A*1234ABCDE*{C5678", 95, 580, KIOSK_BARCODE_TYPE_CODE128, 2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19)
        
    state = KIOSK_P_Textout(g_hPort, porttype, "------------------------------------", 95, 630, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "---------------Logo 1---------------", 95, 650, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBmpInRAM(g_hPort, porttype, 0, 95, 720, KIOSK_BITMAP_PRINT_QUADRUPLE)

    state = KIOSK_P_Textout(g_hPort, porttype, "---------------Logo 2---------------", 95, 740, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBmpInRAM(g_hPort, porttype, 1, 95, 830, KIOSK_BITMAP_PRINT_QUADRUPLE)

    state = KIOSK_P_Print(g_hPort, porttype)

    state = KIOSK_P_Clear(g_hPort, porttype)

    state_print = KIOSK_CutPaper(g_hPort, porttype, 1, 0)

End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  Function:       PrintInStandardMode80_300DPI()
'  Description:    Print sample
'  Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
'                  KIOSK_Reset()                       //Reset the printer.
'                  KIOSK_SetMode()                     //Set the mode of printing.
'                  KIOSK_SetMotionUnit()               //Set the units of motion.
'                  KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
'                  KIOSK_SetRightSpacing()             //Set the right spacing of character.
'                  KIOSK_SetLineSpacing()              //Set the spacing of lines.
'                  KIOSK_S_Textout()                   //Write one character string at the specified position.
'                  KIOSK_FeedLine()                    //Feed 1 line.
'                  KIOSK_FeedLines()                   //Feed paper forward.
'                  KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
'                  KIOSK_S_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
'                  KIOSK_CutPaper()                    //Cut paper.
'  Called By:      OnPrint()
'  Input:          g_hPort: port handle
'                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
'  Return:         Returns True if successful, False if not successful.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Function PrintInStandardMode80_300DPI(ByVal g_hPort As Long, ByVal porttype As Integer) As Long
    Dim bIsFirst As Boolean
    Dim state As Integer
    
    bIsFirst = True

    If (bIsFirst = True) Then
        state_print = KIOSK_PreDownloadBmpToFlash(g_hPort, porttype, "Kitty.bmp", 2, 1) 'Pre-download a group of bit map to Flash by specifying it's ID.
        bIsFirst = False
    End If

    state_print = KIOSK_Reset(g_hPort, porttype)

    state = KIOSK_SetMode(g_hPort, porttype, KIOSK_PRINT_MODE_STANDARD)
    
    state = KIOSK_SetMotionUnit(g_hPort, porttype, 203, 203)

    state = KIOSK_S_SetLeftMarginAndAreaWidth(g_hPort, porttype, 0, 640)
    
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 95)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 182, 2, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 24)
        
    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "------------------------------------------", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "------------------------------------------", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)


    'Defferent right-spacing
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_S_Textout(g_hPort, porttype, "Right Spacing", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 330, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_S_Textout(g_hPort, porttype, "Right Spacing", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)
    
    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 330, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 4)

    state = KIOSK_S_Textout(g_hPort, porttype, "Right Spacing", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 330, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)
    
    state = KIOSK_FeedLines(g_hPort, porttype, 2)


    'Defferent font
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-NORMAL", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-BOLD", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 95, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE)


    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 95, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-REVERSE", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE)

    state = KIOSK_FeedLine(g_hPort, porttype)


    state = KIOSK_S_Textout(g_hPort, porttype, "FONTSTYLE-90", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)
    

    'Print code-bar
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_S_Textout(g_hPort, porttype, "------------------------------------------", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "Barcode - Code 128", 95, 1, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_PrintBarcode(g_hPort, porttype, "{A*1234ABCDE*{C5678", 95, KIOSK_BARCODE_TYPE_CODE128, 2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19)

    state = KIOSK_FeedLine(g_hPort, porttype)

  


    state = KIOSK_S_Textout(g_hPort, porttype, "------------------------------------------", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "------------------Logo 1------------------", 95, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_PrintBmpInFlash(g_hPort, porttype, 1, 100, KIOSK_BITMAP_PRINT_QUADRUPLE)

    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)

    'Cut paper
    state_print = KIOSK_CutPaper(g_hPort, porttype, 1, 0)
End Function

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  Function:       PrintInPageMode80_300DPI()
'  Description:    Print sample
'  Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
'                  KIOSK_Reset()                       //Reset the printer.
'                  KIOSK_SetMode()                     //Set the mode of printing.
'                  KIOSK_SetMotionUnit()               //Set the units of motion.
'                  KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
'                  KIOSK_P_Clear()                     //Clear the buffer.
'                  KIOSK_SetRightSpacing()             //Set the right spacing of character.
'                  KIOSK_SetLineSpacing()              //Set the spacing of lines.
'                  KIOSK_P_Textout()                   //Write one character string at the specified position.
'                  KIOSK_FeedLine()                    //Feed 1 line.
'                  KIOSK_FeedLines()                   //Feed paper forward.
'                  KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
'                  KIOSK_P_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
'                  KIOSK_P_Clear()                     //Clear the buffer.
'                  KIOSK_CutPaper()                    //Cut paper.
'  Called By:      OnPrint()
'  Input:          g_hPort: port handle
'                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
'  Return:         Returns True if successful, False if not successful.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Function PrintInPageMode80_300DPI(ByVal g_hPort As Long, ByVal porttype As Integer) As Long
    Dim bIsFirst As Boolean
    Dim state As Integer
    
    bIsFirst = True

    'Pre-download a bit map to RAM by specifying it's ID.
    state_print = KIOSK_PreDownloadBmpToRAM(g_hPort, porttype, "kitty.bmp", 2, 0)

    state = KIOSK_PreDownloadBmpToRAM(g_hPort, porttype, "Look.bmp", 2, 1)
    
    state = KIOSK_Reset(g_hPort, porttype)

    state = KIOSK_SetMode(g_hPort, porttype, KIOSK_PRINT_MODE_PAGE)

    state = KIOSK_SetMotionUnit(g_hPort, porttype, 203, 203)
    
    state = KIOSK_P_SetAreaAndDirection(g_hPort, porttype, 0, 10, 640, 1200, KIOSK_AREA_LEFT_TO_RIGHT)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 182, 80, 2, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "------------------------------------------", 95, 120, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)


    state = KIOSK_P_Textout(g_hPort, porttype, "------------------------------------------", 95, 140, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)


    'Defferent right-spacing
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_P_Textout(g_hPort, porttype, "814M", 95, 180, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 200, 180, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)


    'Defferent font
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 2)

    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-NORMAL", 95, 300, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_NORMAL)


    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-BOLD", 95, 330, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)


    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 95, 360, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE)


    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-UNDERLINE", 95, 390, 1, 1, KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THIN_UNDERLINE)


    state = KIOSK_P_Textout(g_hPort, porttype, "FONTSTYLE-REVERSE", 95, 420, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE)


    'Print code-bar
    state = KIOSK_P_Textout(g_hPort, porttype, "------------------------------------", 95, 480, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "Barcode - Code 128", 95, 505, 1, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBarcode(g_hPort, porttype, "{A*1234ABCDE*{C5678", 95, 580, KIOSK_BARCODE_TYPE_CODE128, 2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19)
    
    
    
    state = KIOSK_P_Textout(g_hPort, porttype, "------------------------------------", 95, 630, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "---------------Logo 1---------------", 95, 650, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBmpInRAM(g_hPort, porttype, 0, 95, 720, KIOSK_BITMAP_PRINT_QUADRUPLE)


    state = KIOSK_P_Textout(g_hPort, porttype, "---------------Logo 2---------------", 95, 740, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBmpInRAM(g_hPort, porttype, 1, 95, 830, KIOSK_BITMAP_PRINT_QUADRUPLE)

    state = KIOSK_P_Print(g_hPort, porttype)

    state = KIOSK_P_Clear(g_hPort, porttype)

    state_print = KIOSK_CutPaper(g_hPort, porttype, 1, 0)

End Function

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  Function:       PrintInStandardMode210_203DPI()
'  Description:    Print sample
'  Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
'                  KIOSK_Reset()                       //Reset the printer.
'                  KIOSK_SetMode()                     //Set the mode of printing.
'                  KIOSK_SetMotionUnit()               //Set the units of motion.
'                  KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
'                  KIOSK_SetRightSpacing()             //Set the right spacing of character.
'                  KIOSK_SetLineSpacing()              //Set the spacing of lines.
'                  KIOSK_S_Textout()                   //Write one character string at the specified position.
'                  KIOSK_FeedLine()                    //Feed 1 line.
'                  KIOSK_FeedLines()                   //Feed paper forward.
'                  KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
'                  KIOSK_S_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
'                  KIOSK_CutPaper()                    //Cut paper.
'  Called By:      OnPrint()
'  Input:          g_hPort: port handle
'                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
'  Return:         Returns True if successful, False if not successful.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Function PrintInStandardMode210_203DPI(ByVal g_hPort As Long, ByVal porttype As Integer) As Long

    Dim bIsFirst As Boolean
    Dim state As Integer
    
    bIsFirst = True
 
    If (bIsFirst = True) Then
        state_print = KIOSK_PreDownloadBmpToFlash(g_hPort, porttype, "Map.bmp", 2, 1) 'Pre-download a group of bit map to Flash by specifying it's ID.
        bIsFirst = False
    End If

    'Print setting.
    state_print = KIOSK_Reset(g_hPort, porttype)

    state = KIOSK_SetMode(g_hPort, porttype, KIOSK_PRINT_MODE_STANDARD)
    
    state = KIOSK_SetMotionUnit(g_hPort, porttype, 203, 203)

    state = KIOSK_S_SetLeftMarginAndAreaWidth(g_hPort, porttype, 100, 1500)
    
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 20)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)

    'Text setting
    state = KIOSK_S_Textout(g_hPort, porttype, "Sample", 0, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_S_Textout(g_hPort, porttype, "The method of calling functions of exported from KIOSKDLL", 800, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 20)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "-----------------------------------------------------------------------------------------------------------------------------", 0, 1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 500, 3, 3, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_FeedLines(g_hPort, porttype, 5)
    
    state = KIOSK_SetLineSpacing(g_hPort, porttype, 40)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_S_Textout(g_hPort, porttype, "  In order to providing the user who use the KIOSK printer to carry on second development, we developed KIOSKDLL which supplys command to printer with DLL mode. This is good help for programmer to use KISSKDLL.", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLines(g_hPort, porttype, 1)

    state = KIOSK_S_Textout(g_hPort, porttype, "  We supply this sample to show our KIOSKDLL's function. You can also rewoke the resident sample by yourself.", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 15)

    state = KIOSK_FeedLines(g_hPort, porttype, 4)

    state = KIOSK_S_Textout(g_hPort, porttype, "Support port:", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "COM", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_S_Textout(g_hPort, porttype, "LPT", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)

    state = KIOSK_S_Textout(g_hPort, porttype, "USB", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_S_Textout(g_hPort, porttype, "Driver", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)
    
    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "Support system:", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "Windows 2000", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "Windows 2003", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)

    state = KIOSK_S_Textout(g_hPort, porttype, "Windows XP", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "Windows Vista", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "Support bar code:", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "UPC-A", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "UPC-E", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "JAN13", 1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "JAN8", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "CODE39", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "ITF", 1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "CODEBAR", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "CODE93", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "CODE128", 1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)

    state = KIOSK_S_Textout(g_hPort, porttype, "PDF417", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)
    
    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "Support equipment:", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "814M", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)

    'Print bitmap in Flash
    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "Print   Bitmap:", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_PrintBmpInFlash(g_hPort, porttype, 1, 500, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH)

    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "Print   Bar Code:", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "Barcode - Code 128", 440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_PrintBarcode(g_hPort, porttype, "{A*1234ABCDE*{C5678", 440, KIOSK_BARCODE_TYPE_CODE128, 3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19)

    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "-----------------------------------------------------------------------------------------------------------------------------", 0, 1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "Your thermal printer partner", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    
    'Cut paper
    state_print = KIOSK_CutPaper(g_hPort, porttype, 1, 0)
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  Function:       PrintInPageMode210_203DPI()
'  Description:    Print sample
'  Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
'                  KIOSK_Reset()                       //Reset the printer.
'                  KIOSK_SetMode()                     //Set the mode of printing.
'                  KIOSK_SetMotionUnit()               //Set the units of motion.
'                  KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
'                  KIOSK_P_Clear()                     //Clear the buffer.
'                  KIOSK_SetRightSpacing()             //Set the right spacing of character.
'                  KIOSK_SetLineSpacing()              //Set the spacing of lines.
'                  KIOSK_P_Textout()                   //Write one character string at the specified position.
'                  KIOSK_FeedLine()                    //Feed 1 line.
'                  KIOSK_FeedLines()                   //Feed paper forward.
'                  KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
'                  KIOSK_P_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
'                  KIOSK_P_Clear()                     //Clear the buffer.
'                  KIOSK_CutPaper()                    //Cut paper.
'  Called By:      OnPrint()
'  Input:          g_hPort: port handle
'                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
'  Return:         Returns True if successful, False if not successful.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Function PrintInPageMode210_203DPI(ByVal g_hPort As Long, ByVal porttype As Integer) As Long
Dim bIsFirst As Boolean
    Dim state As Integer
    
    bIsFirst = True
    
    'Pre-download a bit map to RAM by specifying it's ID.
    state_print = KIOSK_PreDownloadBmpToRAM(g_hPort, porttype, "Map.bmp", 2, 0)
    
    state = KIOSK_Reset(g_hPort, porttype)
    
    state = KIOSK_SetMode(g_hPort, porttype, KIOSK_PRINT_MODE_PAGE)

    state = KIOSK_SetMotionUnit(g_hPort, porttype, 203, 203)
    
    state = KIOSK_P_SetAreaAndDirection(g_hPort, porttype, 95, 0, 1500, 2400, KIOSK_AREA_LEFT_TO_RIGHT)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)


    state = KIOSK_P_Textout(g_hPort, porttype, "Sample", 0, 100, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "The method of calling functions of exported from KIOSKDLL", 800, 100, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    
    state = KIOSK_P_Textout(g_hPort, porttype, "-----------------------------------------------------------------------------------------------------------------------------", 0, 150, 1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)



    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 500, 250, 3, 3, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)




    state = KIOSK_SetLineSpacing(g_hPort, porttype, 40)

     state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_P_Textout(g_hPort, porttype, "  In order to providing the user who use the KIOSK printer to carry on second development, we developed KIOSKDLL which supplys command to printer with DLL mode. This is good help for programmer to use KISSKDLL.", 0, 350, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "  We supply this sample to show our KIOSKDLL's function. You can also rewoke the resident sample by yourself.", 0, 500, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)



    state = KIOSK_SetLineSpacing(g_hPort, porttype, 15)

     state = KIOSK_P_Textout(g_hPort, porttype, "Support port:", 0, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "COM", 440, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "LPT", 800, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "USB", 440, 660, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "Driver", 800, 660, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)




    state = KIOSK_P_Textout(g_hPort, porttype, "Support system:", 0, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "Windows 2000", 440, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "Windows 2003", 800, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "Windows XP", 440, 760, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "Windows Vista", 800, 760, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)




    state = KIOSK_P_Textout(g_hPort, porttype, "Support bar code:", 0, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "UPC-A", 440, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "UPC-E", 800, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "JAN13", 1200, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)


    state = KIOSK_P_Textout(g_hPort, porttype, "JAN8", 440, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "CODE39", 800, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "ITF", 1200, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)


    state = KIOSK_P_Textout(g_hPort, porttype, "CODEBAR", 440, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "CODE93", 800, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "CODE128", 1200, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)


    state = KIOSK_P_Textout(g_hPort, porttype, "PDF417", 440, 955, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)




    state = KIOSK_P_Textout(g_hPort, porttype, "Support equipment:", 0, 1020, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "814M", 440, 1020, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE)


    state = KIOSK_P_Textout(g_hPort, porttype, "Print   Bitmap:", 0, 1280, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)


    state = KIOSK_P_PrintBmpInRAM(g_hPort, porttype, 0, 500, 1380, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH)



    state = KIOSK_P_Textout(g_hPort, porttype, "Print   Bar Code:", 0, 1440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "Barcode - Code 128", 440, 1440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBarcode(g_hPort, porttype, "{A*1234ABCDE*{C5678", 440, 1555, KIOSK_BARCODE_TYPE_CODE128, 3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19)



    state = KIOSK_P_Textout(g_hPort, porttype, "-----------------------------------------------------------------------------------------------------------------------------", 0, 1630, 1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)


    state = KIOSK_P_Textout(g_hPort, porttype, "Your thermal printer partner", 800, 1645, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)


    state = KIOSK_P_Print(g_hPort, porttype)

     state = KIOSK_P_Clear(g_hPort, porttype)

    state_print = KIOSK_CutPaper(g_hPort, porttype, 1, 5)

    
End Function

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  Function:       PrintInStandardMode210_300DPI()
'  Description:    Print sample
'  Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
'                  KIOSK_Reset()                       //Reset the printer.
'                  KIOSK_SetMode()                     //Set the mode of printing.
'                  KIOSK_SetMotionUnit()               //Set the units of motion.
'                  KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
'                  KIOSK_SetRightSpacing()             //Set the right spacing of character.
'                  KIOSK_SetLineSpacing()              //Set the spacing of lines.
'                  KIOSK_S_Textout()                   //Write one character string at the specified position.
'                  KIOSK_FeedLine()                    //Feed 1 line.
'                  KIOSK_FeedLines()                   //Feed paper forward.
'                  KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
'                  KIOSK_S_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
'                  KIOSK_CutPaper()                    //Cut paper.
'  Called By:      OnPrint()
'  Input:          g_hPort: port handle
'                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
'  Return:         Returns True if successful, False if not successful.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Function PrintInStandardMode210_300DPI(ByVal g_hPort As Long, ByVal porttype As Integer) As Long
    Dim bIsFirst As Boolean
    Dim state As Integer
    
    bIsFirst = True
 
    If (bIsFirst = True) Then
        state_print = KIOSK_PreDownloadBmpToFlash(g_hPort, porttype, "Map.bmp", 2, 1) 'Pre-download a group of bit map to Flash by specifying it's ID.
        bIsFirst = False
    End If

    state_print = KIOSK_Reset(g_hPort, porttype)

    state = KIOSK_SetMode(g_hPort, porttype, KIOSK_PRINT_MODE_STANDARD)
    
    state = KIOSK_SetMotionUnit(g_hPort, porttype, 203, 203)

    state = KIOSK_S_SetLeftMarginAndAreaWidth(g_hPort, porttype, 100, 1500)
    
    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 20)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)


  
    state = KIOSK_S_Textout(g_hPort, porttype, "Sample", 0, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_S_Textout(g_hPort, porttype, "The method of calling functions of exported from KIOSKDLL", 950, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 20)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------", 0, 1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)




    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "KIOSK Printer", 500, 3, 3, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)


    

    state = KIOSK_FeedLines(g_hPort, porttype, 5)
    
    state = KIOSK_SetLineSpacing(g_hPort, porttype, 40)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_S_Textout(g_hPort, porttype, "  In order to providing the user who use the KIOSK printer to carry on second development, we developed KIOSKDLL which supplys command to printer with DLL mode. This is good help for programmer to use KISSKDLL.", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLines(g_hPort, porttype, 1)

    state = KIOSK_S_Textout(g_hPort, porttype, "  We supply this sample to show our KIOSKDLL's function. You can also rewoke the resident sample by yourself.", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    
    

    state = KIOSK_SetLineSpacing(g_hPort, porttype, 15)

    state = KIOSK_FeedLines(g_hPort, porttype, 4)

    state = KIOSK_S_Textout(g_hPort, porttype, "Support port:", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "COM", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_S_Textout(g_hPort, porttype, "LPT", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)

    state = KIOSK_S_Textout(g_hPort, porttype, "USB", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_S_Textout(g_hPort, porttype, "Driver", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)




    state = KIOSK_FeedLines(g_hPort, porttype, 3)


    state = KIOSK_S_Textout(g_hPort, porttype, "Support system:", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "Windows 2000", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "Windows 2003", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)

     state = KIOSK_S_Textout(g_hPort, porttype, "Windows XP", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, state = KIOSK_FONT_STYLE_THIN_UNDERLINE)

     state = KIOSK_S_Textout(g_hPort, porttype, "Windows Vista", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)




    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "Support bar code:", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "UPC-A", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "UPC-E", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "JAN13", 1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "JAN8", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "CODE39", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "ITF", 1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "CODEBAR", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "CODE93", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_S_Textout(g_hPort, porttype, "CODE128", 1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)

    state = KIOSK_S_Textout(g_hPort, porttype, "PDF417", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)



    
    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "Support equipment:", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "814M", 440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE)

    state = KIOSK_FeedLines(g_hPort, porttype, 2)


    'Print bitmap in Flash
    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "Print   Bitmap:", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_PrintBmpInFlash(g_hPort, porttype, 1, 500, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH)




    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "Print   Bar Code:", 0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_S_Textout(g_hPort, porttype, "Barcode - Code 128", 440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_PrintBarcode(g_hPort, porttype, "{A*1234ABCDE*{C5678", 440, KIOSK_BARCODE_TYPE_CODE128, 3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19)




    state = KIOSK_FeedLines(g_hPort, porttype, 3)

    state = KIOSK_S_Textout(g_hPort, porttype, "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------", 0, 1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)

    state = KIOSK_S_Textout(g_hPort, porttype, "Your thermal printer partner", 800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    state = KIOSK_FeedLine(g_hPort, porttype)
    
    'Cut paper
    state_print = KIOSK_CutPaper(g_hPort, porttype, 1, 0)

End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  Function:       PrintInPageMode210_300DPI()
'  Description:    Print sample
'  Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
'                  KIOSK_Reset()                       //Reset the printer.
'                  KIOSK_SetMode()                     //Set the mode of printing.
'                  KIOSK_SetMotionUnit()               //Set the units of motion.
'                  KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
'                  KIOSK_P_Clear()                     //Clear the buffer.
'                  KIOSK_SetRightSpacing()             //Set the right spacing of character.
'                  KIOSK_SetLineSpacing()              //Set the spacing of lines.
'                  KIOSK_P_Textout()                   //Write one character string at the specified position.
'                  KIOSK_FeedLine()                    //Feed 1 line.
'                  KIOSK_FeedLines()                   //Feed paper forward.
'                  KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
'                  KIOSK_P_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
'                  KIOSK_P_Clear()                     //Clear the buffer.
'                  KIOSK_CutPaper()                    //Cut paper.
'  Called By:      OnPrint()
'  Input:          g_hPort: port handle
'                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
'  Return:         Returns True if successful, False if not successful.

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Function PrintInPageMode210_300DPI(ByVal g_hPort As Long, ByVal porttype As Integer) As Long


   Dim bIsFirst As Boolean
    Dim state As Integer
    
    bIsFirst = True
    
    'Pre-download a bit map to RAM by specifying it's ID.
    state_print = KIOSK_PreDownloadBmpToRAM(g_hPort, porttype, "Map.bmp", 2, 0)
    
    state = KIOSK_Reset(g_hPort, porttype)
    
    state = KIOSK_SetMode(g_hPort, porttype, KIOSK_PRINT_MODE_PAGE)

    state = KIOSK_SetMotionUnit(g_hPort, porttype, 203, 203)
    
    state = KIOSK_P_SetAreaAndDirection(g_hPort, porttype, 95, 0, 1500, 2400, KIOSK_AREA_LEFT_TO_RIGHT)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)


    state = KIOSK_P_Textout(g_hPort, porttype, "Sample", 0, 100, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "The method of calling functions of exported from KIOSKDLL", 950, 100, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    
    state = KIOSK_P_Textout(g_hPort, porttype, "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------", 0, 150, 1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)



    state = KIOSK_P_Textout(g_hPort, porttype, "KIOSK Printer", 500, 250, 3, 3, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)




    state = KIOSK_SetLineSpacing(g_hPort, porttype, 40)

    state = KIOSK_SetRightSpacing(g_hPort, porttype, 0)

    state = KIOSK_P_Textout(g_hPort, porttype, "  In order to providing the user who use the KIOSK printer to carry on second development, we developed KIOSKDLL which supplys command to printer with DLL mode. This is good help for programmer to use KISSKDLL.", 0, 350, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "  We supply this sample to show our KIOSKDLL's function. You can also rewoke the resident sample by yourself.", 0, 500, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)



    state = KIOSK_SetLineSpacing(g_hPort, porttype, 15)

    state = KIOSK_P_Textout(g_hPort, porttype, "Support port:", 0, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "COM", 440, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "LPT", 800, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "USB", 440, 660, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)

    state = KIOSK_P_Textout(g_hPort, porttype, "Driver", 800, 660, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD)




    state = KIOSK_P_Textout(g_hPort, porttype, "Support system:", 0, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "Windows 2000", 440, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "Windows 2003", 800, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "Windows XP", 440, 760, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "Windows Vista", 800, 760, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE)




    state = KIOSK_P_Textout(g_hPort, porttype, "Support bar code:", 0, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "UPC-A", 440, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "UPC-E", 800, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "JAN13", 1200, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)


    state = KIOSK_P_Textout(g_hPort, porttype, "JAN8", 440, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "CODE39", 800, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "ITF", 1200, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)


    state = KIOSK_P_Textout(g_hPort, porttype, "CODEBAR", 440, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "CODE93", 800, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)

    state = KIOSK_P_Textout(g_hPort, porttype, "CODE128", 1200, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)


    state = KIOSK_P_Textout(g_hPort, porttype, "PDF417", 440, 955, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE)




    state = KIOSK_P_Textout(g_hPort, porttype, "Support equipment:", 0, 1020, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "814M", 440, 1020, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE)


    state = KIOSK_P_Textout(g_hPort, porttype, "Print   Bitmap:", 0, 1280, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)


    state = KIOSK_P_PrintBmpInRAM(g_hPort, porttype, 0, 500, 1380, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH)




    state = KIOSK_P_Textout(g_hPort, porttype, "Print   Bar Code:", 0, 1440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_Textout(g_hPort, porttype, "Barcode - Code 128", 440, 1440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL)

    state = KIOSK_P_PrintBarcode(g_hPort, porttype, "{A*1234ABCDE*{C5678", 440, 1555, KIOSK_BARCODE_TYPE_CODE128, 3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19)


    state = KIOSK_P_Textout(g_hPort, porttype, "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------", 0, 1630, 1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)


    state = KIOSK_P_Textout(g_hPort, porttype, "Your thermal printer partner", 800, 1645, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL)


    state = KIOSK_P_Print(g_hPort, porttype)

    state = KIOSK_P_Clear(g_hPort, porttype)

    state_print = KIOSK_CutPaper(g_hPort, porttype, 1, 5)

End Function

Private Sub Option5_Click()
    printmode = 0
End Sub

Private Sub Option6_Click()
    printmode = 1
End Sub

Private Sub Option7_Click()
    Option9.Enabled = True
    Option10.Enabled = True
    Option11.Enabled = True
    Option12.Enabled = False
    Option13.Enabled = False
    paperoutmode = 0
End Sub

Private Sub Option8_Click()
    Option9.Enabled = False
    Option10.Enabled = False
    Option11.Enabled = False
    Option12.Enabled = True
    Option13.Enabled = True
    paperoutmode = 1
End Sub

Private Sub Option9_Click()
    presentertype = 0
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
        Case 48 To 57 '0-9
           Exit Sub
        Case 8         '退格键
           Exit Sub
        Case Else
           KeyAscii = 0
    End Select
End Sub

Private Sub Text2_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
        Case 48 To 57 '0-9
           Exit Sub
        Case 8         '退格键
           Exit Sub
        Case Else
           KeyAscii = 0
    End Select
End Sub

Private Sub Text1_GotFocus()
    Text1.SetFocus
    Text1.SelStart = 0
    Text1.SelLength = Len(Text1.Text)
End Sub
Private Sub Text2_GotFocus()
    Text2.SetFocus
    Text2.SelStart = 0
    Text2.SelLength = Len(Text2.Text)
End Sub
Private Sub Timer1_Timer()
    Dim state As Long
    Dim StatusBufferAddress As Long
    Dim StatusBuffer(4) As Byte
    StatusBufferAddress = VarPtr(StatusBuffer(0))
    Dim str1
    Dim str2
    Dim str3
    Dim str4
        
    'Clear read buffer
    StatusBuffer(0) = 0
    StatusBuffer(1) = 0
    StatusBuffer(2) = 0
    StatusBuffer(3) = 0
        
    Select Case porttype
        Case 0
            state = KIOSK_ReadData(g_hPort, 0, 0, StatusBufferAddress, 4)   'Read ASB data
        Case 2
            state = KIOSK_ReadData(g_hPort, 2, 1, StatusBufferAddress, 4)   'Read ASB data
    End Select
        
    If state = KIOSK_SUCCESS Then

        str1 = Hex(StatusBuffer(0))    'Change buffer data to string
        If Len(str1) = 1 Then
            str1 = "0" + str1
        End If
        str2 = Hex(StatusBuffer(1))
        If Len(str2) = 1 Then
            str2 = "0" + str2
        End If
        str3 = Hex(StatusBuffer(2))
        If Len(str3) = 1 Then
            str3 = "0" + str3
        End If
        str4 = Hex(StatusBuffer(3))
        If Len(str4) = 1 Then
            str4 = "0" + str4
        End If
        
        List1.AddItem (str1 + "  " + str2 + "  " + str3 + "  " + str4) & vbCrLf
    End If
    Sleep (500)
    'Loop
End Sub
