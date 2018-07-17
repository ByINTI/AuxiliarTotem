Attribute VB_Name = "POSDLLFuncs"
Public downstand56 As Boolean
Public downstand80 As Boolean
Public hasdowntoFlash56 As Boolean
Public hasdowntoFlash80 As Boolean
Public save As Long
Public state6 As Long
Public a As Long
Public return1 As Long

Public Declare Function GetLastError Lib "kernel32" () As Long

Public Declare Function GetUserDefaultLangID Lib "kernel32" () As Integer

Public Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)

'System control

Public Declare Function POS_Open Lib "POSDLL.dll" (ByVal pszPortName As String, ByVal nComBaudrate As Long, ByVal nComDataBits As Long, ByVal nComStopBits As Long, ByVal nComParity As Long, ByVal nComFlowControl As Long) As Long

Public Declare Function POS_Close Lib "POSDLL.dll" () As Long

Public Declare Function POS_Reset Lib "POSDLL.dll" () As Long

Public Declare Function POS_BeginSaveFile Lib "POSDLL.dll" (ByVal lpFileName As String, ByVal bToPrinter As Boolean) As Long

Public Declare Function POS_EndSaveFile Lib "POSDLL.dll" () As Long

Public Declare Function POS_SetMode Lib "POSDLL.dll" (ByVal nPrintMode As Long) As Long

Public Declare Function POS_SetMotionUnit Lib "POSDLL.dll" (ByVal nHorizontalMU As Long, ByVal nVerticalMU As Long) As Long

Public Declare Function POS_SetCharSetAndCodePage Lib "POSDLL.dll" (ByVal nCharSet As Long, ByVal nCodePage As Long) As Long
    
Public Declare Function POS_FeedLine Lib "POSDLL.dll" () As Long

Public Declare Function POS_SetLineSpacing Lib "POSDLL.dll" (ByVal nDistance As Long) As Long

Public Declare Function POS_SetRightSpacing Lib "POSDLL.dll" (ByVal nDistance As Long) As Long

Public Declare Function POS_CutPaper Lib "POSDLL.dll" (ByVal nMode As Long, ByVal nDistance As Long) As Long

Public Declare Function POS_PreDownloadBmpToRAM Lib "POSDLL.dll" (ByVal pszPath As String, ByVal nID As Long) As Long

Public Declare Function POS_PreDownloadBmpsToFlash Lib "POSDLL.dll" (pszPaths As String, ByVal nCount As Long) As Long

'Public Declare Function POS_PreDownloadBmpsToFlash Lib "POSDLL.dll" (pszPath() As String, ByVal nCount As Long) As Long

Public Declare Function POS_QueryStatus Lib "POSDLL.dll" (ByVal pszStatus As String, ByVal nTimeouts As Long) As Long

Public Declare Function POS_RTQueryStatus Lib "POSDLL.dll" (address As Byte) As Long

Public Declare Function POS_NETQueryStatus Lib "POSDLL.dll" (ByVal pszPortName1 As String, address As Byte) As Long

Public Declare Function POS_KickOutDrawer Lib "POSDLL.dll" () As Long

Public Declare Function POS_StartDoc Lib "POSDLL.dll" () As Long

Public Declare Function POS_EndDoc Lib "POSDLL.dll" () As Long

Public Declare Function POS_EnumUSBPrinter Lib "POSDLL.dll" (ByVal cPrinterName As String) As Long


'The functions only support standard mode (or line mode)

Public Declare Function POS_S_SetAreaWidth Lib "POSDLL.dll" (ByVal nWidth As Long) As Long

Public Declare Function POS_S_TextOut Lib "POSDLL.dll" (ByVal pszString As String, ByVal nOrgx As Long, ByVal nWidthTimes As Long, ByVal nHeightTimes As Long, ByVal nFontType As Long, ByVal nFontStyle As Long) As Long

Public Declare Function POS_S_DownloadAndPrintBmp Lib "POSDLL.dll" (ByVal pszPath As String, ByVal nOrgx As Long, ByVal nMode As Long) As Long

Public Declare Function POS_S_PrintBmpInRAM Lib "POSDLL.dll" (ByVal nID As Long, ByVal nOrgx As Long, ByVal nMode As Long) As Long

Public Declare Function POS_S_PrintBmpInFlash Lib "POSDLL.dll" (ByVal nID As Long, ByVal nOrgx As Long, ByVal nMode As Long) As Long

Public Declare Function POS_S_SetBarcode Lib "POSDLL.dll" (ByVal pszInfo As String, ByVal nOrgx As Long, ByVal nType As Long, ByVal nWidthX As Long, ByVal nheight As Long, ByVal nHriFontType As Long, ByVal nHriFontPosition As Long, ByVal nBytesOfInfo As Long) As Long

'The functions only support paper mode and (or) label mode

Public Declare Function POS_PL_SetArea Lib "POSDLL.dll" (ByVal nOrgx As Long, ByVal nOrgY As Long, ByVal nWidth As Long, ByVal nheight As Long, ByVal nDirection As Long) As Long

Public Declare Function POS_PL_TextOut Lib "POSDLL.dll" (ByVal pszString As String, ByVal nOrgx As Long, ByVal nOrgY As Long, ByVal nWidthTimes As Long, ByVal nHeightTimes As Long, ByVal nFontType As Long, ByVal nFontStyle As Long) As Long
                                                          
Public Declare Function POS_PL_DownloadAndPrintBmp Lib "POSDLL.dll" (ByVal pszPath As String, ByVal nOrgx As Long, ByVal nOrgY As Long, ByVal nMode As Long) As Long
                                                                                                                                    
Public Declare Function POS_PL_PrintBmpInRAM Lib "POSDLL.dll" (ByVal nID As Long, ByVal nOrgx As Long, ByVal nOrgY As Long, ByVal nMode As Long) As Long

Public Declare Function POS_PL_SetBarcode Lib "POSDLL.dll" (ByVal pszInfo As String, ByVal nOrgx As Long, ByVal nOrgY As Long, ByVal nType As Long, ByVal nWidthX As Long, ByVal nheight As Long, ByVal nHriFontType As Long, ByVal nHriFontPosition As Long, ByVal nBytesOfInfo As Long) As Long

Public Declare Function POS_PL_Clear Lib "POSDLL.dll" () As Long

Public Declare Function POS_PL_Print Lib "POSDLL.dll" () As Long

'Data transmission

Public Declare Function POS_WriteFile Lib "POSDLL.dll" (ByVal hPort As Long, ByRef pszData As Byte, ByVal nBytesToWrite As Long) As Long

Public Declare Function POS_ReadFile Lib "POSDLL.dll" (ByVal hPort As Long, ByVal pszData As String, ByVal nBytesToRead As String, ByVal nTimeouts As Long) As Long

Public Declare Function POS_SetHandle Lib "POSDLL.dll" (ByVal hNewHandle As Long) As Long

Public Declare Function POS_GetVersionInfo Lib "POSDLL.dll" (nMajor As Long, nMinor As Long) As Long

'The return value
Public Const POS_SUCCESS  As Long = 1001
Public Const POS_FAIL     As Long = 1002
Public Const POS_ERROR_INVALID_HANDLE        As Long = 1101
Public Const POS_ERROR_INVALID_PARAMETER     As Long = 1102
Public Const POS_ERROR_NOT_BITMAP            As Long = 1103
Public Const POS_ERROR_NOT_MONO_BITMAP       As Long = 1104
Public Const POS_ERROR_BEYONG_AREA           As Long = 1105
Public Const POS_ERROR_INVALID_PATH          As Long = 1106

'The number of stop bits options of serial port
Public Const POS_COM_ONESTOPBIT              As Long = 0
'Public Const POS_COM_ONE5STOPBITS            As Long = 1
Public Const POS_COM_TWOSTOPBITS             As Long = 2

'Parity options of serial port
Public Const POS_COM_NOPARITY      As Long = 0
Public Const POS_COM_ODDPARITY     As Long = 1
Public Const POS_COM_EVENPARITY    As Long = 2
Public Const POS_COM_MARKPARITY    As Long = 3
Public Const POS_COM_SPACEPARITY   As Long = 4

' Flow control options of serial port
Public Const POS_COM_DTR_DSR      As Long = 0
Public Const POS_COM_RTS_CTS      As Long = 1
Public Const POS_COM_XON_XOFF     As Long = 2
Public Const POS_COM_NO_HANDSHAKE As Long = 3
Public Const POS_OPEN_PARALLEL_PORT As Long = 18
Public Const POS_OPEN_BYUSB_PORT As Long = 19
Public Const POS_OPEN_PRINTNAME As Long = 20
Public Const POS_OPEN_NETPORT   As Long = 21
Public Const POS_OPEN_CLASSPRINTER As Long = 22

' Mode options of the way of paper leaving away from printer
Public Const POS_PAPER_OUT_MODE_CUT      As Long = 0
Public Const POS_PAPER_OUT_MODE_PEEL     As Long = 1
Public Const POS_PAPER_OUT_MODE_TEAR     As Long = 2
Public Const POS_PAPER_OUT_MODE_OTHER    As Long = 3

' Print mode options
Public Const POS_PRINT_MODE_STANDARD            As Long = 0
Public Const POS_PRINT_MODE_PAGE                As Long = 1
Public Const POS_PRINT_MODE_BLACK_MARK_LABEL    As Long = 2
Public Const POS_PRINT_MODE_WHITE_MARK_LABEL    As Long = 3

' Font type options
Public Const POS_FONT_TYPE_STANDARD             As Long = 0
Public Const POS_FONT_TYPE_COMPRESSED           As Long = 1
Public Const POS_FONT_TYPE_UDC                  As Long = 2
Public Const POS_FONT_TYPE_CHINESE              As Long = 3

' Font style options
Public Const POS_FONT_STYLE_NORMAL            As Long = &H0&
Public Const POS_FONT_STYLE_BOLD              As Long = &H8&
Public Const POS_FONT_STYLE_THIN_UNDERLINE    As Long = &H80&
Public Const POS_FONT_STYLE_THICK_UNDERLINE   As Long = &H100&
Public Const POS_FONT_STYLE_UPSIDEDOWN        As Long = &H200&
Public Const POS_FONT_STYLE_REVERSE           As Long = &H400&
Public Const POS_FONT_STYLE_SMOOTH            As Long = &H800&
Public Const POS_FONT_STYLE_CLOCKWISE_90      As Long = &H1000&

' Specify the area direction of paper or lable
Public Const POS_AREA_LEFT_TO_RIGHT    As Long = 0
Public Const POS_AREA_BOTTOM_TO_TOP    As Long = 1
Public Const POS_AREA_RIGHT_TO_LEFT    As Long = 2
Public Const POS_AREA_TOP_TO_BOTTOM    As Long = 3

' Cut mode options
Public Const POS_CUT_MODE_FULL         As Long = 0
Public Const POS_CUT_MODE_PARTIAL      As Long = 1

' Mode options of printing bit image in RAM or Flash
Public Const POS_BITMAP_PRINT_NORMAL        As Long = 0
Public Const POS_BITMAP_PRINT_DOUBLE_WIDTH  As Long = 1
Public Const POS_BITMAP_PRINT_DOUBLE_HEIGHT As Long = 2
Public Const POS_BITMAP_PRINT_QUADRUPLE     As Long = 3

' Mode options of bit-image -- for download and print
Public Const POS_BITMAP_MODE_8SINGLE_DENSITY  As Long = &H0&
Public Const POS_BITMAP_MODE_8DOUBLE_DENSITY  As Long = &H1&
Public Const POS_BITMAP_MODE_24SINGLE_DENSITY As Long = &H20&
Public Const POS_BITMAP_MODE_24DOUBLE_DENSITY As Long = &H21&

' Barcode's type
Public Const POS_BARCODE_TYPE_UPC_A           As Long = &H41&
Public Const POS_BARCODE_TYPE_UPC_E           As Long = &H42&
Public Const POS_BARCODE_TYPE_JAN13           As Long = &H43&
Public Const POS_BARCODE_TYPE_JAN8            As Long = &H44&
Public Const POS_BARCODE_TYPE_CODE39          As Long = &H45&
Public Const POS_BARCODE_TYPE_ITF             As Long = &H46&
Public Const POS_BARCODE_TYPE_CODEBAR         As Long = &H47&
Public Const POS_BARCODE_TYPE_CODE93          As Long = &H48&
Public Const POS_BARCODE_TYPE_CODE128         As Long = &H49&

' Barcode HRI's position
Public Const POS_HRI_POSITION_NONE  As Long = &H0&
Public Const POS_HRI_POSITION_ABOVE  As Long = &H1&
Public Const POS_HRI_POSITION_BELOW As Long = &H2&
Public Const POS_HRI_POSITION_BOTH As Long = &H3&


Public Function PrintInStandardMode80() As Long


    return1 = POS_SetMotionUnit(180, 180)
    If return1 <> 1001 Then
    state6 = return1
    Exit Function
    End If
    POS_SetMode POS_PRINT_MODE_STANDARD
    
    POS_SetRightSpacing 0

    POS_SetLineSpacing 100
    POS_S_TextOut "Beiyang POS Printer", 50, 2, 3, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
        
    POS_SetLineSpacing 35

    POS_FeedLine
    POS_FeedLine

    POS_S_TextOut "SNBC POS Thermal Printer", 20, 1, 1, POS_FONT_TYPE_CHINESE, POS_FONT_STYLE_THICK_UNDERLINE
    POS_FeedLine
    POS_S_TextOut "SNBC POS Thermal Printer", 20, 1, 1, POS_FONT_TYPE_CHINESE, POS_FONT_STYLE_THIN_UNDERLINE
    POS_FeedLine
    POS_FeedLine

    POS_SetLineSpacing 24

    ' 不同的字符右间距
    
    POS_SetRightSpacing 0
    POS_S_TextOut "BTP-2000CP", 20, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_S_TextOut "POS Thermal Printer", 200, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_FeedLine

    POS_SetRightSpacing 2
    POS_S_TextOut "BTP-2001CP", 20, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_S_TextOut "POS Thermal Printer", 200, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_FeedLine

    POS_SetRightSpacing 4
    POS_S_TextOut "BTP-2002CP", 20, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_S_TextOut "POS Thermal Printer", 200, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_FeedLine
    POS_FeedLine

    ' 不同的字符风格

    POS_SetRightSpacing 2
    POS_S_TextOut "Normal font print", 20, 1, 1, POS_FONT_TYPE_CHINESE, POS_FONT_STYLE_NORMAL
    POS_FeedLine
    POS_S_TextOut "Reverse display font print", 20, 1, 1, POS_FONT_TYPE_CHINESE, POS_FONT_STYLE_REVERSE
    POS_FeedLine
    POS_S_TextOut "Clockwise rotate 90 print", 20, 1, 1, POS_FONT_TYPE_CHINESE, POS_FONT_STYLE_CLOCKWISE_90
    POS_FeedLine
    
    POS_S_TextOut "Inverted font print", 20, 1, 1, POS_FONT_TYPE_CHINESE, POS_FONT_STYLE_UPSIDEDOWN
    POS_FeedLine
    POS_FeedLine
    

    ' 打印条码

    POS_SetRightSpacing 0

    POS_S_TextOut "----------------------------------", 50, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_FeedLine

    POS_S_TextOut "Barcode - Code 128", 160, 1, 1, POS_FONT_TYPE_COMPRESSED, POS_FONT_STYLE_NORMAL
    POS_FeedLine
    POS_FeedLine

    POS_S_SetBarcode "{A*1234ABCDE*{C5678", 40, POS_BARCODE_TYPE_CODE128, 2, 50, POS_FONT_TYPE_COMPRESSED, POS_HRI_POSITION_BOTH, 19
    POS_FeedLine
    
    POS_S_TextOut "----------------------------------", 50, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_FeedLine
    
    ' 下载位图到Flash
    
    Dim m_BmpPath As String
    m_BmpPath = "Look.bmp"
    If hasdowntoFlash80 = False Then
       a = POS_PreDownloadBmpsToFlash(m_BmpPath, 1)
       hasdowntoFlash80 = True
    End If

    ' 打印已下载到 Flash 中的位图

    POS_FeedLine
    POS_S_TextOut "-------------> Logo 1", 20, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_FeedLine
    POS_S_PrintBmpInFlash 1, 20, POS_BITMAP_PRINT_NORMAL

    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine

    state6 = POS_CutPaper(POS_CUT_MODE_FULL, 0)
    
End Function

Public Function PrintInPageMode80() As Long

    ' 预下载位图到 RAM，如果掉电则丢失
    a = POS_PreDownloadBmpToRAM("Kitty.bmp", 0)     ' ID 号为 0
    If a <> 1001 Then
        state6 = a
        Exit Function
    End If

       
    POS_SetMotionUnit 180, 180
    POS_SetMode POS_PRINT_MODE_PAGE

    POS_PL_SetArea 10, 10, 620, 800, POS_AREA_BOTTOM_TO_TOP
    POS_PL_Clear

    POS_SetRightSpacing 0

    POS_PL_TextOut "Beiyang POS Thermal Printer", 20, 80, 2, 2, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_THICK_UNDERLINE

    ' 不同字符右间距

    POS_SetRightSpacing 0
    POS_PL_TextOut "BTP-2000CP", 30, 140, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_PL_TextOut "POS Thermal Printer", 300, 140, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL

    POS_SetRightSpacing 4
    POS_PL_TextOut "BTP-2001CP", 30, 180, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_PL_TextOut "POS Thermal Printer", 300, 180, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL

    POS_SetRightSpacing 8
    POS_PL_TextOut "BTP-2002CP", 30, 220, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_PL_TextOut "POS Thermal Printer", 300, 220, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL

    POS_SetRightSpacing 0

    POS_PL_TextOut "********************", 110, 260, 2, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL

    ' 打印条码

    POS_PL_TextOut "Barcode - Code 128", 260, 290, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_PL_SetBarcode "{A*123ABC*{C34567890", 40, 360, POS_BARCODE_TYPE_CODE128, 3, 50, POS_FONT_TYPE_COMPRESSED, POS_HRI_POSITION_BELOW, 20
    
    ' 打印已经下载到 RAM 中的位图

    POS_PL_PrintBmpInRAM 0, 50, 450, POS_BITMAP_PRINT_NORMAL

    POS_PL_Print
    POS_PL_Clear
   state6 = POS_CutPaper(POS_CUT_MODE_PARTIAL, 150)
   
End Function

Public Function PrintInStandardMode56() As Long

    return1 = POS_SetMotionUnit(180, 180)
    If return1 <> 1001 Then
    state6 = return1
    Exit Function
    End If

    POS_SetMode POS_PRINT_MODE_STANDARD
    
    POS_SetRightSpacing 0

    POS_SetLineSpacing 100
    POS_S_TextOut "Beiyang POS Thermal Printer", 30, 1, 2, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
        
    POS_SetLineSpacing 35

    POS_FeedLine
    POS_FeedLine

    POS_S_TextOut "SNBC POS Thermal Printer", 20, 1, 1, POS_FONT_TYPE_CHINESE, POS_FONT_STYLE_THICK_UNDERLINE
    POS_FeedLine
    POS_S_TextOut "SNBC POS Thermal Printer", 20, 1, 1, POS_FONT_TYPE_CHINESE, POS_FONT_STYLE_THIN_UNDERLINE
    POS_FeedLine
    POS_FeedLine

    POS_SetLineSpacing 24

    ' 不同的字符右间距
    
    POS_SetRightSpacing 0
    POS_S_TextOut "BTP-2000CP", 20, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_S_TextOut "POS Printer", 200, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_FeedLine

    POS_SetRightSpacing 2
    POS_S_TextOut "BTP-2001CP", 20, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_S_TextOut "POS Printer", 200, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_FeedLine

    POS_SetRightSpacing 4
    POS_S_TextOut "BTP-2002CP", 20, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_S_TextOut "POS Printer", 200, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_FeedLine
    POS_FeedLine

    ' 不同的字符风格

    POS_SetRightSpacing 5
    POS_S_TextOut "Normal font print", 20, 1, 1, POS_FONT_TYPE_CHINESE, POS_FONT_STYLE_NORMAL
    POS_FeedLine
    POS_S_TextOut "Reverse display font print", 20, 1, 1, POS_FONT_TYPE_CHINESE, POS_FONT_STYLE_REVERSE
    POS_FeedLine
    POS_S_TextOut "Clockwise rotate 90 print", 20, 1, 1, POS_FONT_TYPE_CHINESE, POS_FONT_STYLE_CLOCKWISE_90
    POS_FeedLine
    POS_S_TextOut "Inverted font print", 20, 1, 1, POS_FONT_TYPE_CHINESE, POS_FONT_STYLE_UPSIDEDOWN
    POS_FeedLine
    POS_FeedLine
    

    ' 打印条码

    POS_SetRightSpacing 0

    POS_S_TextOut "-----------------------", 50, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL

    POS_FeedLine

    POS_S_TextOut "Barcode - Code 128", 100, 1, 1, POS_FONT_TYPE_COMPRESSED, POS_FONT_STYLE_NORMAL

    POS_FeedLine

    POS_S_SetBarcode "{A*123AB{C567", 50, POS_BARCODE_TYPE_CODE128, 2, 50, POS_FONT_TYPE_COMPRESSED, POS_HRI_POSITION_BOTH, 13
    
    POS_S_TextOut "-----------------------", 50, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL

    POS_FeedLine
    
    ' 下载位图到Flash
    
    Dim m_BmpPath As String
    m_BmpPath = "Look.bmp"

     If hasdowntoFlash56 = False Then
       a = POS_PreDownloadBmpsToFlash(m_BmpPath, 1)
       hasdowntoFlash56 = True
     End If


    ' 打印已下载到 Flash 中的位图

    POS_FeedLine
    POS_S_TextOut "-------------> Logo 1", 20, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_FeedLine
    POS_S_PrintBmpInFlash 1, 20, POS_BITMAP_PRINT_NORMAL
    POS_FeedLine

    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine
    POS_FeedLine

    state6 = POS_CutPaper(POS_CUT_MODE_FULL, 0)
    
End Function

Public Function PrintInPageMode56() As Long
   
    ' 预下载位图到 RAM，如果掉电则丢失
    a = POS_PreDownloadBmpToRAM("Kitty.bmp", 0)     ' ID 号为 0
    If a <> 1001 Then
    state6 = a
    Exit Function
    End If

    
    POS_SetMotionUnit 180, 180
    POS_SetMode POS_PRINT_MODE_PAGE

    POS_PL_SetArea 10, 10, 440, 800, POS_AREA_BOTTOM_TO_TOP
'    POS_PL_Clear

    POS_SetRightSpacing 0

    POS_PL_TextOut "Beiyang POS Thermal Printer", 0, 50, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_THICK_UNDERLINE

    ' 不同字符右间距

    POS_SetRightSpacing 0
    POS_PL_TextOut "BTP-2000CP", 5, 80, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_PL_TextOut "POS Thermal Printer", 230, 80, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL

    POS_SetRightSpacing 4
    POS_PL_TextOut "BTP-2001CP", 5, 110, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_PL_TextOut "POS Thermal Printer", 230, 110, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL

    POS_SetRightSpacing 8
    POS_PL_TextOut "BTP-2002CP", 5, 140, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_PL_TextOut "POS Thermal Printer", 230, 140, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL

    POS_SetRightSpacing 0

    POS_PL_TextOut "********************", 70, 170, 2, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL

    ' 打印条码

    POS_PL_TextOut "Barcode - Code 128", 180, 195, 1, 1, POS_FONT_TYPE_STANDARD, POS_FONT_STYLE_NORMAL
    POS_PL_SetBarcode "{A*12345ABC*{C90", 5, 260, POS_BARCODE_TYPE_CODE128, 3, 50, POS_FONT_TYPE_COMPRESSED, POS_HRI_POSITION_BELOW, 16
    
    ' 打印已经下载到 RAM 中的位图

    POS_PL_PrintBmpInRAM 0, 50, 330, POS_BITMAP_PRINT_NORMAL

    POS_PL_Print

    POS_PL_Clear

    state6 = POS_CutPaper(POS_CUT_MODE_PARTIAL, 150)
    
End Function

