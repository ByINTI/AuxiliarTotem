VERSION 5.00
Begin VB.Form MainForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "POSDLLDemo"
   ClientHeight    =   5775
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7980
   DrawMode        =   4  'Mask Not Pen
   BeginProperty Font 
      Name            =   "宋体"
      Size            =   12
      Charset         =   134
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "MainForm"
   MaxButton       =   0   'False
   ScaleHeight     =   5775
   ScaleWidth      =   7980
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text6 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2760
      Locked          =   -1  'True
      TabIndex        =   30
      TabStop         =   0   'False
      Top             =   5280
      Width           =   2655
   End
   Begin VB.CheckBox Check1 
      Caption         =   "数据保存到文件Test.txt，不向端口下发"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   180
      Left            =   120
      TabIndex        =   20
      Top             =   4920
      Width           =   4815
   End
   Begin VB.Frame Frame3 
      Caption         =   "端口配置"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3255
      Left            =   120
      TabIndex        =   25
      Top             =   1560
      Width           =   5415
      Begin VB.ComboBox Combo9 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "MainForm.frx":0000
         Left            =   3840
         List            =   "MainForm.frx":0002
         Style           =   2  'Dropdown List
         TabIndex        =   41
         Top             =   2700
         Width           =   1455
      End
      Begin VB.TextBox Text5 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1200
         TabIndex        =   16
         Text            =   "BTP-2002CP(S)"
         Top             =   2700
         Width           =   2295
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1200
         MaxLength       =   3
         TabIndex        =   12
         Text            =   "192"
         Top             =   2220
         Width           =   450
      End
      Begin VB.TextBox Text2 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1680
         MaxLength       =   3
         TabIndex        =   13
         Text            =   "168"
         Top             =   2220
         Width           =   450
      End
      Begin VB.TextBox Text4 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2640
         MaxLength       =   3
         TabIndex        =   15
         Text            =   "251"
         Top             =   2220
         Width           =   450
      End
      Begin VB.TextBox Text3 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2160
         MaxLength       =   3
         TabIndex        =   14
         Text            =   "10"
         Top             =   2220
         Width           =   450
      End
      Begin VB.ComboBox Combo8 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "MainForm.frx":0004
         Left            =   1200
         List            =   "MainForm.frx":000E
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   1740
         Width           =   1455
      End
      Begin VB.ComboBox Combo7 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "MainForm.frx":001E
         Left            =   3840
         List            =   "MainForm.frx":0020
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   1260
         Width           =   1455
      End
      Begin VB.ComboBox Combo6 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "MainForm.frx":0022
         Left            =   3840
         List            =   "MainForm.frx":0024
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   300
         Width           =   1455
      End
      Begin VB.ComboBox Combo5 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "MainForm.frx":0026
         Left            =   3840
         List            =   "MainForm.frx":0030
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   780
         Width           =   1455
      End
      Begin VB.ComboBox Combo4 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "MainForm.frx":003A
         Left            =   1200
         List            =   "MainForm.frx":0044
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   1260
         Width           =   1455
      End
      Begin VB.ComboBox Combo1 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "MainForm.frx":004E
         Left            =   1200
         List            =   "MainForm.frx":0067
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   780
         Width           =   1455
      End
      Begin VB.ComboBox Combo3 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "MainForm.frx":009A
         Left            =   1200
         List            =   "MainForm.frx":00BC
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   300
         Width           =   1455
      End
      Begin VB.Label Label2 
         Alignment       =   1  'Right Justify
         Caption         =   "每秒位数："
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   39
         Top             =   840
         Width           =   975
      End
      Begin VB.Label Label12 
         Alignment       =   1  'Right Justify
         Caption         =   "驱动名称："
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   38
         Top             =   2760
         Width           =   1095
      End
      Begin VB.Label Label8 
         Alignment       =   1  'Right Justify
         Caption         =   "  IP地址："
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   37
         Top             =   2280
         Width           =   975
      End
      Begin VB.Label Label1 
         Alignment       =   1  'Right Justify
         Caption         =   "串口名称："
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   36
         Top             =   360
         Width           =   975
      End
      Begin VB.Label Label7 
         Alignment       =   1  'Right Justify
         Caption         =   "并口名称："
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   35
         Top             =   1800
         Width           =   975
      End
      Begin VB.Label Label3 
         Alignment       =   1  'Right Justify
         Caption         =   "数据位："
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   34
         Top             =   1320
         Width           =   975
      End
      Begin VB.Label Label4 
         Alignment       =   1  'Right Justify
         Caption         =   "停止位："
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2760
         TabIndex        =   31
         Top             =   840
         Width           =   1095
      End
      Begin VB.Label Label6 
         Alignment       =   1  'Right Justify
         Caption         =   "数据流控制："
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2760
         TabIndex        =   28
         Top             =   1320
         Width           =   1095
      End
      Begin VB.Label Label5 
         Alignment       =   1  'Right Justify
         Caption         =   "  校验位："
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2760
         TabIndex        =   27
         Top             =   360
         Width           =   1095
      End
   End
   Begin VB.CommandButton Command5 
      Caption         =   "关闭端口"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6720
      TabIndex        =   26
      Top             =   5280
      Width           =   1215
   End
   Begin VB.CommandButton Command4 
      Caption         =   "查询状态"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1440
      TabIndex        =   23
      Top             =   5280
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "打印"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5400
      TabIndex        =   24
      Top             =   5280
      Width           =   1215
   End
   Begin VB.Frame Frame2 
      Caption         =   "示例设置"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4695
      Left            =   5760
      TabIndex        =   22
      Top             =   120
      Width           =   2055
      Begin VB.Frame Frame4 
         Caption         =   "模式选择"
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1575
         Left            =   120
         TabIndex        =   32
         Top             =   600
         Width           =   1815
         Begin VB.OptionButton Option5 
            Caption         =   "页模式"
            BeginProperty Font 
               Name            =   "宋体"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   120
            TabIndex        =   33
            Top             =   960
            Width           =   975
         End
         Begin VB.OptionButton Option4 
            Caption         =   "标准模式"
            BeginProperty Font 
               Name            =   "宋体"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   120
            TabIndex        =   17
            Top             =   360
            Value           =   -1  'True
            Width           =   1095
         End
      End
      Begin VB.ComboBox Combo2 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "MainForm.frx":00FD
         Left            =   240
         List            =   "MainForm.frx":0107
         Style           =   2  'Dropdown List
         TabIndex        =   18
         Top             =   3600
         Width           =   975
      End
      Begin VB.Label Label9 
         Caption         =   "(mm)"
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   10.5
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1320
         TabIndex        =   42
         Top             =   3660
         Width           =   615
      End
      Begin VB.Label Label13 
         Caption         =   "页宽："
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   29
         Top             =   3240
         Width           =   1095
      End
   End
   Begin VB.CommandButton Command3 
      Caption         =   "打开端口"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   21
      Top             =   5280
      Width           =   1215
   End
   Begin VB.Frame Frame1 
      Caption         =   "端口选择"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1335
      Left            =   120
      TabIndex        =   19
      Top             =   120
      Width           =   5415
      Begin VB.OptionButton Option3 
         Caption         =   "USB 类模式"
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   3600
         TabIndex        =   40
         Top             =   720
         Width           =   1575
      End
      Begin VB.OptionButton Option8 
         Caption         =   "驱动程序"
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2040
         TabIndex        =   4
         Top             =   840
         Width           =   1455
      End
      Begin VB.OptionButton Option7 
         Caption         =   "网络接口"
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   3
         Top             =   840
         Width           =   1695
      End
      Begin VB.OptionButton Option6 
         Caption         =   "USB口"
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   3600
         TabIndex        =   2
         Top             =   360
         Width           =   1575
      End
      Begin VB.OptionButton Option2 
         Caption         =   "串口"
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   0
         Top             =   360
         Value           =   -1  'True
         Width           =   1575
      End
      Begin VB.OptionButton Option1 
         Caption         =   "并口"
         BeginProperty Font 
            Name            =   "宋体"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2040
         TabIndex        =   1
         Top             =   360
         Width           =   1455
      End
   End
End
Attribute VB_Name = "MainForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim index As Long '所选端口类型索引
Dim printtype As Long '示例设置模式选择类型
Dim printwidth As Long '示例设置纸张宽度类型
Dim State_1 As Long '驱动程序下文档开始
Dim State_2 As Long '驱动程序下文档结束
Dim State_3 As Long '打印完成提示信息
Dim State_4 As Long '动态库发布主版本号
Dim State_5 As Long '动态库发布次版本号
Dim State_6 As Long '动态库版本查询函数返回值
Dim state As Long '打开端口函数的句柄
Dim state2 As Long '关闭端口函数的句柄
Dim IP, IP1, IP2, IP3, IP4, IP5 As String
Dim langID As Integer


Private Sub Check1_Click() '数据保存到文件test.exe
    If Check1.Value = 1 Then
        save = 1             '选中“保存到文件test.exe”
    Else
        save = 0            '取消“保存到文件test.exe”
    End If
End Sub



Private Sub Command1_Click() '开始打印
Dim state2 As String
    printwidth = Combo2.ListIndex
    Select Case printtype
        Case 0 '标准模式
            If printwidth = 0 Then '80mm页宽
                If index = 4 Then '端口类型为驱动程序
                    State_1 = POS_StartDoc()
                    PrintInStandardMode80
                    State_2 = POS_EndDoc()
                Else '端口类型为驱动程序以外其他4种类型
                    If save = 1 Then
                        POS_BeginSaveFile "Test.txt", False '该参数为True同时发送到打印机，False不向打印机发送
                    Else
                        POS_EndSaveFile '结束数据保存到文件
                    End If
                    PrintInStandardMode80
                End If
            Else '56mm页宽
                If index = 4 Then '端口类型为驱动程序
                    State_1 = POS_StartDoc()
                    PrintInStandardMode56
                    State_2 = POS_EndDoc()
                Else '端口类型为驱动程序以外其他4种类型
                    If save = 1 Then
                        POS_BeginSaveFile "Test.txt", False '该参数为True同时发送到打印机，False不向打印机发送
                    Else
                        POS_EndSaveFile '结束数据保存到文件
                    End If
                    PrintInStandardMode56
                End If
            End If
        Case 1 '页模式
            If printwidth = 0 Then '80mm页宽
                If index = 4 Then '端口类型为驱动程序
                    State_1 = POS_StartDoc()
                    PrintInPageMode80
                    State_2 = POS_EndDoc()
                Else '端口类型为驱动程序以外其他4种类型
                    If save = 1 Then
                        POS_BeginSaveFile "Test.txt", False '该参数为True同时发送到打印机，False不向打印机发送
                    Else
                        POS_EndSaveFile '结束数据保存到文件
                    End If
                    PrintInPageMode80
                End If
            Else '56mm页宽
                If index = 4 Then '端口类型为驱动程序
                    State_1 = POS_StartDoc()
                    PrintInPageMode56
                    State_2 = POS_EndDoc()
                Else '端口类型为驱动程序以外其他4种类型
                    If save = 1 Then
                        POS_BeginSaveFile "Test.txt", False '该参数为True同时发送到打印机，False不向打印机发送
                    Else
                        POS_EndSaveFile '结束数据保存到文件
                    End If
                    PrintInPageMode56
                End If
            End If
    End Select
    If a = 1106 Then
        If langID = 2052 Then
            Text6.Text = "当前目录缺少'Look.bmp' ！"
        Else
            Text6.Text = "No such file 'Look.bmp' ！"
        End If
        
        a = 0
        Exit Sub
    End If
    If state6 = POS_SUCCESS Then
        If langID = 2052 Then
            Text6.Text = "打印成功！"
        Else
            Text6.Text = "Print success!"
        End If
    Else
        If langID = 2052 Then
            Text6.Text = "打印失败！"
        Else
            Text6.Text = "Print failed!"
        End If
        
        If state6 = 1002 Then
        Command3.Enabled = True
        Command1.Enabled = False
        Command4.Enabled = False
        Command5.Enabled = False
        End If
    End If
End Sub


Private Sub Command3_Click() '打开端口
    Dim lpName, comname As String
    Dim lptname, laName1 As String
    Dim cptname, caName1 As String
    Dim nComBaudrate, baudrateindex As Long
    Dim nComDataBits, databits As Long
    Dim nComStopBits, stopbits As Long
    Dim nComParity, parity As Long
    Dim nParam, param As Long
    Dim drivername As String
    Dim m_Feed As String
    Dim state0 As String
    Dim cpName As String
    
    
    
    baudrateindex = Combo1.ListIndex
    comname = Combo3.ListIndex
    databits = Combo4.ListIndex
    stopbits = Combo5.ListIndex
    parity = Combo6.ListIndex
    param = Combo7.ListIndex
    lptname = Combo8.ListIndex
    cptname = Combo9.ListIndex
    drivername = CStr(Text5.Text)
    IP1 = CStr(Text1.Text)
    IP2 = CStr(Text2.Text)
    IP3 = CStr(Text3.Text)
    IP4 = CStr(Text4.Text)
    IP = IP1 + "." + IP2 + "." + IP3 + "." + IP4
    m_Feed = Chr(&HA&)
    
    state = 0
    If Combo1.ListIndex = -1 And index <> 0 Then
        If langID = 2052 Then
            Text6.Text = "请选择串口波特率！"
        Else
            Text6.Text = "Please selcete the baudrate!"
        End If
        
        Exit Sub
    End If
    
    Select Case baudrateindex '配置每秒位数
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
    
    Select Case comname '配置串口名
    Case 0
        lpName = "COM1"
    Case 1
        lpName = "COM2"
    Case 2
        lpName = "COM3"
    Case 3
        lpName = "COM4"
    Case 4
        lpName = "COM5"
    Case 5
        lpName = "COM6"
    Case 6
        lpName = "COM7"
    Case 7
        lpName = "COM8"
    Case 8
        lpName = "COM9"
    Case 9
        lpName = "COM10"
    End Select
    
    Select Case databits '配置数据位参数
    Case 0
        nComDataBits = 7
    Case 1
        nComDataBits = 8
    End Select
    
    Select Case stopbits '配置停止位参数
    Case 0
        nComStopBits = POS_COM_ONESTOPBIT
    Case 1
        nComStopBits = POS_COM_TWOSTOPBITS
    End Select
    
    Select Case parity '配置校验位参数
    Case 0
        nComParity = POS_COM_EVENPARITY
    Case 1
        nComParity = POS_COM_ODDPARITY
    Case 2
        nComParity = POS_COM_NOPARITY
    End Select
    
    Select Case param '配置数据流控制参数
    Case 0
        nParam = POS_COM_XON_XOFF
    Case 1
        nParam = POS_COM_RTS_CTS
    Case 2
        nParam = POS_COM_NO_HANDSHAKE
    End Select
    
    Select Case lptname '并口名
    Case 0
        lpName1 = "LPT1"
    Case 1
        lpName1 = "LPT2"
    End Select
    
    If Option1.Value Then
      index = 0
    ElseIf Option2.Value Then
      index = 1
    ElseIf Option6.Value Then
      index = 2
    ElseIf Option7.Value Then
      index = 3
    ElseIf Option8.Value Then
      index = 4
    End If
    
    
    Select Case index
    Case 0
        state = POS_Open(lpName1, 0, 0, 0, 0, POS_OPEN_PARALLEL_PORT) '打开并口
    Case 1
        state = POS_Open(lpName, nComBaudrate, nComDataBits, nComStopBits, nComParity, nParam) '打开串口
    Case 2
        state = POS_Open("BYUSB-0", 0, 0, 0, 0, POS_OPEN_BYUSB_PORT) '打开USB口
        If state = -1 Then
            state = POS_Open("BYUSB-1", 0, 0, 0, 0, POS_OPEN_BYUSB_PORT) '打开USB口
        End If
    Case 3
    If IP1 = "" Or IP2 = "" Or IP3 = "" Or IP4 = "" Then
        If langID = 2052 Then
            Text6.Text = "IP地址不能为空！"
        Else
            Text6.Text = "IP address can not be null!"
        End If
        
        Exit Sub
    Else
        state = POS_Open(IP, 0, 0, 0, 0, POS_OPEN_NETPORT) '打开网络接口
    End If
    Case 4
    If drivername = "" Then
        If langID = 2052 Then
            Text6.Text = "驱动程序名不能为空!"
        Else
            Text6.Text = "Driver name can not be null!"
        End If
        
        Exit Sub
    Else
        state = POS_Open(drivername, 0, 0, 0, 0, POS_OPEN_PRINTNAME) '打开驱动程序
    End If
    
    Case 5
        cpName = Combo9.Text
        state = POS_Open(cpName, 0, 0, 0, 0, POS_OPEN_CLASSPRINTER) '打开USB类模式
    End Select
    
   
    If state <> -1 Then
        Command1.Enabled = True
        If langID = 2052 Then
            state0 = "端口打开成功！"
        Else
            state0 = "Open port success!"
        End If
        
        Select Case index
        Case 0
        Command4.Enabled = False
        Command3.Enabled = False
        Case 1
        Command4.Enabled = True
        Command3.Enabled = False
        Case 2
        Command4.Enabled = True
        Command3.Enabled = False
        Case 3
        Command4.Enabled = True
        Command3.Enabled = False
        Case 4
        Command4.Enabled = False
        Command3.Enabled = False
        Case 5
        Command4.Enabled = True
        Command3.Enabled = False
     End Select
       Command5.Enabled = True
    Else
        If langID = 2052 Then
            state0 = "端口打开失败！"
        Else
            state0 = "Open port failed!"
        End If
        
        Command4.Enabled = False
        Command1.Enabled = False
        Command5.Enabled = False
    End If
    Text6.Text = state0
            
End Sub

Private Sub Command4_Click() '查询状态
    Dim iReturn As Long
    Dim cStatus As Byte
    Dim strInfo As String
    
    strInfo = ""
    If index = 3 Then
    iReturn = POS_NETQueryStatus(IP, cStatus)
    Else
    
    iReturn = POS_RTQueryStatus(cStatus) '实时查询
    End If
    
    If iReturn <> POS_SUCCESS Then
        If langID = 2052 Then
            strInfo = "查询状态失败！"
        Else
            strInfo = "Query status failed!"
        End If
       
       Text6.Text = strInfo
       If iReturn = 1002 Then
       Command3.Enabled = True
       Command1.Enabled = False
       Command4.Enabled = False
       Command5.Enabled = False
       End If
       Exit Sub
    End If

    If (cStatus And &H1) <> &H1 Then
        If langID = 2052 Then
            strInfo = "有钱箱打开！"
        Else
            strInfo = "Cash drawer open!"
        End If
    End If
    
    If (cStatus And &H2) = &H2 Then
        If langID = 2052 Then
            strInfo = strInfo & "打印机脱机！"
        Else
            strInfo = strInfo & "Printer is offline!"
        End If
    End If
    
    If (cStatus And &H8) = &H8 Then
        If langID = 2052 Then
            strInfo = strInfo & "正在进纸！"
        Else
            strInfo = strInfo & "Paper feeding!"
        End If
    End If

    If (cStatus And &H4) = &H4 Then
        If langID = 2052 Then
            strInfo = strInfo & "上盖打开！"
        Else
            strInfo = strInfo & "Cover open!"
        End If
    End If
        
    If (cStatus And &H10) = &H10 Then
        If langID = 2052 Then
            strInfo = strInfo & "打印机出错！"
        Else
            strInfo = strInfo & "Printer error!"
        End If
    End If

    If (cStatus And &H20) = &H20 Then
        If langID = 2052 Then
            strInfo = strInfo & "切刀出错！"
        Else
            strInfo = strInfo & "Cutter error!"
        End If
    End If

    If (cStatus And &H40) = &H40 Then
        If langID = 2052 Then
            strInfo = strInfo & "纸将尽！"
        Else
            strInfo = strInfo & "Paper near end!"
        End If
    End If

    If (cStatus And &H80) = &H80 Then
        If langID = 2052 Then
            strInfo = strInfo & "缺纸！"
        Else
            strInfo = strInfo & "Paper end!"
        End If
    End If
   
    If strInfo = "" Then
        If langID = 2052 Then
            strInfo = "一切正常！"
        Else
            strInfo = "All OK!"
        End If
    End If
    
    Text6.Text = strInfo
    
End Sub

Private Sub Command5_Click() '关闭端口
Dim state1 As String
   state2 = POS_Close()
   If state2 = 1001 Then
        Command1.Enabled = False
        Command5.Enabled = False
        Command3.Enabled = True
        If langID = 2052 Then
            state1 = "端口关闭成功！"
        Else
            state1 = "Close port success!"
        End If
        
        Select Case index
        Case 1
        Command4.Enabled = False
        Case 2
        Command4.Enabled = False
        Case 3
        Command4.Enabled = False
        End Select
    Else
        If langID = 2052 Then
            state1 = "端口关闭失败！"
        Else
            state1 = "Close port failed!"
        End If
        
    End If
    Text6.Text = state1
End Sub

Private Sub Form_Load() '程序运行时的初始界面设置
    langID = GetUserDefaultLangID()
    SetCtrlLang (langID)
    index = 0
    printtype = 0
    Combo1.ListIndex = 2
    Combo2.ListIndex = 0
    Combo3.ListIndex = 0
    Combo4.ListIndex = 1
    Combo5.ListIndex = 0
    Combo6.ListIndex = 2
    Combo7.ListIndex = 1
    Combo8.ListIndex = 0
    'Combo9.ListIndex = 0
    downstand56 = True
    downstand80 = True
    hasdowntoFlash56 = False
    hasdowntoFlash80 = False
    Command1.Enabled = False
    Command4.Enabled = False
    Command5.Enabled = False
    Option2_Click
    State_6 = POS_GetVersionInfo(State_4, State_5)
    
    If langID = 2052 Then
        Text6.Text = "一切正常，版本号V" + CStr(State_4) + "." + CStr(State_5)
    Else
        Text6.Text = "All OK, Version: V" + CStr(State_4) + "." + CStr(State_5)
    End If
    
End Sub

Public Sub SetCtrlLang(ID As Integer)

    Select Case ID
    Case 2052
        Frame1.Caption = "端口选择"
        Option2.Caption = "串口"
        Option1.Caption = "并口"
        Option6.Caption = "USB口"
        Option7.Caption = "网络接口"
        Option8.Caption = "驱动程序"
        Option3.Caption = "USB类模式"
        
        Frame3.Caption = "端口配置"
        Label1.Caption = "串口名称："
        Label2.Caption = "每秒位数："
        Label3.Caption = "数据位："
        Label7.Caption = "并口名称："
        Label8.Caption = "IP地址："
        Label12.Caption = "驱动名称："
        Label5.Caption = "校验位："
        Label4.Caption = "停止位："
        Label6.Caption = "数据流控制："
        
        Check1.Caption = "数据保存到文件Test.txt，不向端口下发"
        Command3.Caption = "打开端口"
        Command4.Caption = "查询状态"
        Command1.Caption = "打印"
        Command5.Caption = "关闭端口"
        
        Frame2.Caption = "示例设置"
        Frame4.Caption = "模式选择"
        Option4.Caption = "标准模式"
        Option5.Caption = "页模式"
        Label13.Caption = "页宽："
        
        Combo6.AddItem ("偶校验")
        Combo6.AddItem ("奇校验")
        Combo6.AddItem ("无")
        
        Combo7.AddItem ("XON/OFF")
        Combo7.AddItem ("硬件")
        Combo7.AddItem ("无")
    Case Is <> 2052
        Frame1.Caption = "PortOption"
        Option2.Caption = "SerialPort"
        Option1.Caption = "ParallelPort"
        Option6.Caption = "USB"
        Option7.Caption = "Ethernet"
        Option8.Caption = "Driver"
        Option3.Caption = "USB Class"
        Frame3.Caption = "Configuration"
        Label1.Caption = "PortName:"
        Label2.Caption = "BaudRate:"
        Label3.Caption = "DataBits:"
        Label7.Caption = "ParaName:"
        Label8.Caption = "IP Addr:"
        Label12.Caption = "DriverName:"
        Label5.Caption = "Parity:"
        Label4.Caption = "StopBits:"
        Label6.Caption = "HandShake:"
        
        Check1.Caption = "Save data to Test.txt file, not to device"
        Command3.Caption = "OpenPort"
        Command4.Caption = "QueryStatus"
        Command1.Caption = "Print"
        Command5.Caption = "ClosePort"
        
        Frame2.Caption = "SampleSetting"
        Frame4.Caption = "Mode"
        Option4.Caption = "Standard"
        Option5.Caption = "Page"
        Label13.Caption = "PageWidth:"
        
        Combo6.AddItem ("Even")
        Combo6.AddItem ("Odd")
        Combo6.AddItem ("None")
        
        Combo7.AddItem ("XON/OFF")
        Combo7.AddItem ("Hardware")
        Combo7.AddItem ("None")
    End Select
    
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    POS_Close
End Sub

Private Sub Option1_Click() '选择端口为并口时的界面显示
    Label1.Enabled = False
    Combo1.Enabled = False
    Label2.Enabled = False
    Combo2.Enabled = True
    Label3.Enabled = False
    Combo3.Enabled = False
    Label4.Enabled = False
    Combo4.Enabled = False
    Label5.Enabled = False
    Combo5.Enabled = False
    Label6.Enabled = False
    Combo6.Enabled = False
    Label7.Enabled = True
    Combo7.Enabled = False
    Label8.Enabled = False
    Combo8.Enabled = True
    Combo9.Enabled = False
    Label12.Enabled = False
    Label13.Enabled = True
    Text1.Enabled = False
    Text2.Enabled = False
    Text3.Enabled = False
    Text4.Enabled = False
    Text5.Enabled = False
    index = 0
    POS_Close
    Command3.Enabled = True
    Command1.Enabled = False
    Command4.Enabled = False
    Command5.Enabled = False

    If langID = 2052 Then
        Text6.Text = "端口选择为并口"
    Else
        Text6.Text = "Parallel port is selected"
    End If
    
End Sub

Private Sub Option2_Click() '选择端口为串口的界面显示
    Label1.Enabled = True
    Combo1.Enabled = True
    Label2.Enabled = True
    Combo2.Enabled = True
    Label3.Enabled = True
    Combo3.Enabled = True
    Label4.Enabled = True
    Combo4.Enabled = True
    Label5.Enabled = True
    Combo5.Enabled = True
    Label6.Enabled = True
    Combo6.Enabled = True
    Label7.Enabled = False
    Combo7.Enabled = True
    Label8.Enabled = False
    Combo8.Enabled = False
    Combo9.Enabled = False
    Label12.Enabled = False
    Label13.Enabled = True
    Text1.Enabled = False
    Text2.Enabled = False
    Text3.Enabled = False
    Text4.Enabled = False
    Text5.Enabled = False
    index = 1
    POS_Close
    Command3.Enabled = True
    Command1.Enabled = False
    Command4.Enabled = False
    Command5.Enabled = False

    If langID = 2052 Then
        Text6.Text = "端口选择为串口"
    Else
        Text6.Text = "Serial port is selected"
    End If
    
End Sub

Private Sub Option3_Click()  '选择端口为usb class口时的界面显示
    Label1.Enabled = False
    Combo1.Enabled = False
    Label2.Enabled = False
    Combo2.Enabled = False
    Label3.Enabled = False
    Combo3.Enabled = False
    Label4.Enabled = False
    Combo4.Enabled = False
    Label5.Enabled = False
    Combo5.Enabled = False
    Label6.Enabled = False
    Combo6.Enabled = False
    Label7.Enabled = False
    Combo7.Enabled = False
    Label8.Enabled = False
    Combo8.Enabled = False
    Combo9.Enabled = True
    Label12.Enabled = True
    Label13.Enabled = True
    Text1.Enabled = False
    Text2.Enabled = False
    Text3.Enabled = False
    Text4.Enabled = False
    Text5.Enabled = False
    Command3.Enabled = True
    Command1.Enabled = False
    Command4.Enabled = False
    Command5.Enabled = False
  
    If langID = 2052 Then
        Text6.Text = "端口选择为USB 类模式"
    Else
        Text6.Text = "USB class is selected"
    End If

    Dim i As Long
    Dim j As Integer
    Dim cPrinterNames As String * 1024
    Dim Name() As String
    
    
    i = POS_EnumUSBPrinter(cPrinterNames)
    
    If i <= 0 Then
        Exit Sub
    End If

    Name = Split(cPrinterNames, "@", i + 1)
    Do While j < i
        Combo9.AddItem (Name(j))
        j = j + 1
    Loop
    
    Combo9.ListIndex = 0
    index = 5

End Sub

Private Sub Option6_Click() '选择端口为usb口时的界面显示
    Label1.Enabled = False
    Combo1.Enabled = False
    Label2.Enabled = False
    Combo2.Enabled = True
    Label3.Enabled = False
    Combo3.Enabled = False
    Label4.Enabled = False
    Combo4.Enabled = False
    Label5.Enabled = False
    Combo5.Enabled = False
    Label6.Enabled = False
    Combo6.Enabled = False
    Label7.Enabled = False
    Combo7.Enabled = False
    Label8.Enabled = False
    Combo8.Enabled = False
    Combo9.Enabled = False
    Label12.Enabled = False
    Label13.Enabled = True
    Text1.Enabled = False
    Text2.Enabled = False
    Text3.Enabled = False
    Text4.Enabled = False
    Text5.Enabled = False
    index = 2
    POS_Close
    Command3.Enabled = True
    Command1.Enabled = False
    Command4.Enabled = False
    Command5.Enabled = False

    If langID = 2052 Then
        Text6.Text = "端口选择为USB口"
    Else
        Text6.Text = "USB port is selected"
    End If
    
End Sub

Private Sub Option4_Click() '选择标准模式
    printtype = 0
End Sub

Private Sub Option5_Click() '选择页模式
    printtype = 1
End Sub

Private Sub Option7_Click() '选择端口为网络接口时的界面显示
    Label1.Enabled = False
    Combo1.Enabled = False
    Label2.Enabled = False
    Combo2.Enabled = True
    Label3.Enabled = False
    Combo3.Enabled = False
    Label4.Enabled = False
    Combo4.Enabled = False
    Label5.Enabled = False
    Combo5.Enabled = False
    Label6.Enabled = False
    Combo6.Enabled = False
    Label7.Enabled = False
    Combo7.Enabled = False
    Label8.Enabled = True
    Combo8.Enabled = False
    Combo9.Enabled = False
    Label12.Enabled = False
    Label13.Enabled = True
    Text1.Enabled = True
    Text2.Enabled = True
    Text3.Enabled = True
    Text4.Enabled = True
    Text5.Enabled = False
    index = 3
    POS_Close
    Command3.Enabled = True
    Command1.Enabled = False
    Command4.Enabled = False
    Command5.Enabled = False

    If langID = 2052 Then
        Text6.Text = "端口选择为网络接口"
    Else
        Text6.Text = "Ethernet is selected"
    End If

End Sub

Private Sub Option8_Click() '选择端口为驱动程序时的界面显示
    Label1.Enabled = False
    Combo1.Enabled = False
    Label2.Enabled = False
    Combo2.Enabled = True
    Label3.Enabled = False
    Combo3.Enabled = False
    Label4.Enabled = False
    Combo4.Enabled = False
    Label5.Enabled = False
    Combo5.Enabled = False
    Label6.Enabled = False
    Combo6.Enabled = False
    Label7.Enabled = False
    Combo7.Enabled = False
    Label8.Enabled = False
    Combo8.Enabled = False
    Combo9.Enabled = False
    Label12.Enabled = True
    Label13.Enabled = True
    Text1.Enabled = False
    Text2.Enabled = False
    Text3.Enabled = False
    Text4.Enabled = False
    Text5.Enabled = True
    index = 4
    POS_Close
    Command3.Enabled = True
    Command1.Enabled = False
    Command4.Enabled = False
    Command5.Enabled = False

    If langID = 2052 Then
        Text6.Text = "端口选择为驱动程序"
    Else
        Text6.Text = "Driver is selected"
    End If

End Sub

Private Sub Text1_GotFocus()
    Text1.SetFocus
    Text1.SelStart = 0
    Text1.SelLength = Len(Text1.Text)
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer) '过滤IP地址只能输入0-9
  Select Case KeyAscii
        Case 48 To 57 '0-9
          Exit Sub
        Case 8         '退格键
           Exit Sub
        Case 46         '点击“.”切换到下一IP段
           Text2.SetFocus
           Text2.SelStart = 0
           Text2.SelLength = Len(Text2.Text)
           KeyAscii = 0
           
        Case Else
           KeyAscii = 0
  End Select

        
End Sub

Private Sub Text1_Change()
If Text1.Text <> "" Then
    If CLng(Text1.Text) > 255 Then
        Text1.Text = 255
    End If
 End If
End Sub

Private Sub Text2_GotFocus()
    Text2.SetFocus
    Text2.SelStart = 0
    Text2.SelLength = Len(Text2.Text)

End Sub

Private Sub Text2_KeyPress(KeyAscii As Integer) '过滤IP地址只能输入0-9
  Select Case KeyAscii
        Case 48 To 57 '0-9
           Exit Sub
        Case 8         '退格键
           Exit Sub
        Case 46         '点击“.”切换到下一IP段
           Text3.SetFocus
           Text3.SelStart = 0
           Text3.SelLength = Len(Text2.Text)
            KeyAscii = 0
        Case Else
           KeyAscii = 0
        
  End Select

End Sub

Private Sub Text2_Change()
If Text2.Text <> "" Then
    If CLng(Text2.Text) > 255 Then
        Text2.Text = 255
    End If
 End If
End Sub

Private Sub Text3_GotFocus()
    Text3.SetFocus
    Text3.SelStart = 0
    Text3.SelLength = Len(Text3.Text)

End Sub

Private Sub Text3_KeyPress(KeyAscii As Integer) '过滤IP地址只能输入0-9
  Select Case KeyAscii
        Case 48 To 57 '0-9
           Exit Sub
        Case 8         '退格键
           Exit Sub
        Case 46         '点击“.”切换到下一IP段
           Text4.SetFocus
           Text4.SelStart = 0
           Text4.SelLength = Len(Text2.Text)
            KeyAscii = 0
        Case Else
           KeyAscii = 0
        
  End Select

End Sub

Private Sub Text3_Change()
If Text3.Text <> "" Then
    If CLng(Text3.Text) > 255 Then
        Text3.Text = 255
    End If
 End If
End Sub

Private Sub Text4_GotFocus()
    Text4.SetFocus
    Text4.SelStart = 0
    Text4.SelLength = Len(Text4.Text)

End Sub

Private Sub Text4_KeyPress(KeyAscii As Integer) '过滤IP地址只能输入0-9
  Select Case KeyAscii
        Case 48 To 57 '0-9
           Exit Sub
        Case 8         '退格键
           Exit Sub
        Case Else
           KeyAscii = 0
        
  End Select

End Sub

Private Sub Text4_Change()
If Text4.Text <> "" Then
    If CLng(Text4.Text) > 255 Then
        Text4.Text = 255
    End If
 End If
End Sub

Private Sub Text5_GotFocus()
    Text5.SetFocus
    Text5.SelStart = 0
    Text5.SelLength = Len(Text5.Text)
End Sub
