Attribute VB_Name = "Module1"
'Public Declare Function EnumPrinters Lib "winspool.drv" Alias "EnumPrintersA" (ByVal flags As Long, name As String, ByVal Level As Long, pPrinterEnum As Byte, ByVal cdBuf As Long, pcbNeeded As Long, pcReturned As Long) As Long
Public Declare Function EnumPrinters Lib "winspool.drv" Alias "EnumPrintersA" (ByVal flags As Long, ByVal name As String, ByVal Level As Long, pPrinterEnum As Long, ByVal cdBuf As Long, pcbNeeded As Long, pcReturned As Long) As Long
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Public Declare Function StrToIntEx Lib "Shlwapi.dll" Alias "StrToIntExW" (ByVal pszString As String, ByVal Flag As Long, ByVal piRet As Long) As Boolean
Public Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Public Declare Function BringWindowToTop Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function OpenIcon Lib "user32" (ByVal hwnd As Long) As Long

Public Declare Function lstrcpy Lib "kernel32.dll" Alias "lstrcpyA" (ByVal lpString1 As String, ByVal lpString2 As Long) As Long
Public Declare Function lstrlen Lib "kernel32.dll" Alias "lstrlenA" (ByVal lpString As Long) As Long

Public Type DEVMODE
        dmDeviceName As String * 32
        dmSpecVersion As Integer
        dmDriverVersion As Integer
        dmSize As Integer
        dmDriverExtra As Integer
        dmFields As Long
        dmOrientation As Integer
        dmPaperSize As Integer
        dmPaperLength As Integer
        dmPaperWidth As Integer
        dmScale As Integer
        dmCopies As Integer
        dmDefaultSource As Integer
        dmPrintQuality As Integer
        dmColor As Integer
        dmDuplex As Integer
        dmYResolution As Integer
        dmTTOption As Integer
        dmCollate As Integer
        dmFormName As String * 32
        dmUnusedPadding As Integer
        dmBitsPerPel As Long
        dmPelsWidth As Long
        dmPelsHeight As Long
        dmDisplayFlags As Long
        dmDisplayFrequency As Long
End Type

Public Type ACL
        AclRevision As Byte
        Sbz1 As Byte
        AclSize As Integer
        AceCount As Integer
        Sbz2 As Integer
End Type

Public Type SECURITY_DESCRIPTOR
        Revision As Byte
        Sbz1 As Byte
        Control As Long
        Owner As Long
        Group As Long
        Sacl As ACL
        Dacl As ACL
End Type

Public Type PRINTER_INFO_2
        pServerName As String
        pPrinterName As String
        pShareName As String
        pPortName As String
        pDriverName As String
        pComment As String
        pLocation As String
        pDevMode As DEVMODE
        pSepFile As String
        pPrintProcessor As String
        pDatatype As String
        pParameters As String
        pSecurityDescriptor As SECURITY_DESCRIPTOR
        Attributes As Long
        Priority As Long
        DefaultPriority As Long
        StartTime As Long
        UntilTime As Long
        Status As Long
        cJobs As Long
        AveragePPM As Long
End Type

Public Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (hpvDest As Any, hpvSource As Any, ByVal cbCopy As Long)
Public Declare Sub FillMemory Lib "kernel32" Alias "RtlFillMemory" (hpvDest As Any, ByVal Length As Long, ByVal Fill As Byte)


'Open the serial port.
Public Declare Function KIOSK_OpenCom Lib "KIOSKDLL.dll" (ByVal lpName As String, ByVal nComBaudrate As Long, ByVal nComDataBits As Long, ByVal nComStopBits As Long, ByVal nComParity As Long, ByVal nFlowControl As Long) As Long

'Close the serial port.
Public Declare Function KIOSK_CloseCom Lib "KIOSKDLL.dll" (ByVal hPort As Long) As Long

'Open the LPT port.
Public Declare Function KIOSK_OpenLptByDrv Lib "KIOSKDLL.dll" (ByVal LPTAddress As Long) As Long

'Close the LPT port.
Public Declare Function KIOSK_CloseDrvLPT Lib "KIOSKDLL.dll" (ByVal nPortType As Long) As Long

'Open the USB port.
Public Declare Function KIOSK_OpenUsb Lib "KIOSKDLL.dll" () As Long

'Open the USB port by ID.
Public Declare Function KIOSK_OpenUsbByID Lib "KIOSKDLL.dll" (ByVal nID As Long) As Long

'Close the USB port.
Public Declare Function KIOSK_CloseUsb Lib "KIOSKDLL.dll" (ByVal hPort As Long) As Long

'Open the driver port.
Public Declare Function KIOSK_OpenDrv Lib "KIOSKDLL.dll" (ByVal drivername As String) As Long

'Close the driver port.
Public Declare Function KIOSK_CloseDrv Lib "KIOSKDLL.dll" (ByVal hPort As Long) As Long

'Start a document.
Public Declare Function KIOSK_StartDoc Lib "KIOSKDLL.dll" (ByVal hPort As Long) As Long

'End a document which is started.
Public Declare Function KIOSK_EndDoc Lib "KIOSKDLL.dll" (ByVal hPort As Long) As Integer

'Set the timeouts of serial port.
Public Declare Function KIOSK_SetComTimeOuts Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nWriteTimeoutMul As Long, ByVal nWriteTimeoutCon As Long, ByVal nReadTimeoutMul As Long, ByVal nReadTimeoutCon As Long) As Integer

'Set the timeouts of USB port.
Public Declare Function KIOSK_SetUsbTimeOuts Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal wReadTimeouts As Long, ByVal wWriteTimeouts As Long) As Integer

'Send data to port or file.
Public Declare Function KIOSK_WriteData Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nBytesToWrite As Integer) As Integer

'Read data from port or file.
Public Declare Function KIOSK_ReadData Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nStatus As Integer, ByVal pszBuffer As Long, ByVal nBytesToRead As Integer) As Long

'/*Function functions.*/
'Send file to print.
Public Declare Function KIOSK_SendFile Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal filename As String) As Integer

'Begin to save the data to file from now on.
Public Declare Function KIOSK_BeginSaveToFile Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal lpFileName As String, ByVal bToPrByValer As Boolean) As Integer

'Stop saving the data to file from now on.
Public Declare Function KIOSK_EndSaveToFile Lib "KIOSKDLL.dll" (ByVal hPort As Long) As Integer

'Query the status of printer.
Public Declare Function KIOSK_QueryStatus Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal pszStatus As Byte, ByVal nTimeouts As Long) As Integer

'Query the real-time status of printer.
Public Declare Function KIOSK_RTQueryStatus Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, pszStatus As Byte) As Long

Public Declare Function KIOSK_RTQueryStatusForT681 Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, pszStatus As Byte) As Long

'Automatic Status Back.
Public Declare Function KIOSK_QueryASB Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal bAutoReturn As Integer) As Integer

'Get the version of KIOSKDLL.
Public Declare Function KIOSK_GetVersionInfo Lib "KIOSKDLL.dll" () As Integer

'Stat or stop the macro definition.
Public Declare Function KIOSK_EnableMacro Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer) As Integer

'Reset the printer.
Public Declare Function KIOSK_Reset Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer) As Integer

'Set the mode of paper.
Public Declare Function KIOSK_SetPaperMode Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nMode As Integer) As Integer

'Set the mode of printing.
Public Declare Function KIOSK_SetMode Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nPrByValMode As Integer) As Integer

'Set tht units of motion.
Public Declare Function KIOSK_SetMotionUnit Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nHorizontalMU As Integer, ByVal nVerticalMU As Integer) As Integer

'Set the spacing of lines.
Public Declare Function KIOSK_SetLineSpacing Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nDistance As Integer) As Integer

'Set the right spacing of character.
Public Declare Function KIOSK_SetRightSpacing Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nDistance As Integer) As Integer

'Set the opposite positon.
Public Declare Function KIOSK_SetOppositePosition Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nPrByValMode As Integer, ByVal nHorizontalDist As Integer, ByVal nVerticalDist As Integer) As Integer

'Set the positon of tabs.
Public Declare Function KIOSK_SetTabs Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, pszPosition As String, ByVal nCount As Integer) As Integer

'Execute tabs.
Public Declare Function KIOSK_ExecuteTabs Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer) As Integer

'Pre-download one bit map to RAM by specifying it's ID.
Public Declare Function KIOSK_PreDownloadBmpToRAM Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal pszPaths As String, ByVal nTranslateMode As Integer, ByVal nID As Integer) As Integer

'Pre-download a group of bit map to Flash by specifying it's ID.
Public Declare Function KIOSK_PreDownloadBmpToFlash Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, pszPaths As String, ByVal nTranslateMode As Integer, ByVal nCount As Integer) As Long

'Select an international character and character code page/table.
Public Declare Function KIOSK_SetCharSetAndCodePage Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nCharSet As Integer, ByVal nCodePage As Integer) As Integer
 
 'User-defined character.
Public Declare Function KIOSK_FontUDChar Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nEnable As Integer, ByVal nCharCode As Integer, pCharBmpBuffer As String, ByVal nDotsOfWidth As Integer, ByVal nBytesOfHeight As Integer) As Integer

'Feed one line.
Public Declare Function KIOSK_FeedLine Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer) As Integer

'Feed paper forward.
Public Declare Function KIOSK_FeedLines Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nLines As Integer) As Integer

'Feed lines in the marker paper mode.
Public Declare Function KIOSK_MarkerFeedPaper Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer) As Integer
 
'Cut paper.
Public Declare Function KIOSK_CutPaper Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nMode As Integer, ByVal nDistance As Integer) As Integer

'Cut paper in the marker paper mode.
Public Declare Function KIOSK_MarkerCutPaper Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nDistance As Integer) As Integer

'Set the width of printing area.
Public Declare Function KIOSK_S_SetLeftMarginAndAreaWidth Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nDistance As Integer, ByVal nWidth As Integer) As Integer

'Set the aligned mode.
Public Declare Function KIOSK_S_SetAlignMode Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nMode As Integer) As Integer

'Write one character string at the specified position.
Public Declare Function KIOSK_S_Textout Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal pszData As String, ByVal nOrgx As Integer, ByVal nWidthTimes As Integer, ByVal nHeightTimes As Integer, ByVal nFontType As Integer, ByVal nFontStyle As Integer) As Integer

'Download a bit map and print it immediately at the specified position.
Public Declare Function KIOSK_S_DownloadPrintBmp Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal pszPath As String, ByVal nTranslateMode As Integer, ByVal nOrgx As Integer, ByVal nMode As Integer) As Integer

'Print a bit map in RAM by specifying it's ID.
Public Declare Function KIOSK_S_PrintBmpInRAM Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nID As Integer, ByVal nOrgx As Integer, ByVal nMode As Integer) As Integer

'Print a bit map in Flash by specifying it's ID.
Public Declare Function KIOSK_S_PrintBmpInFlash Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nID As Integer, ByVal nOrgx As Integer, ByVal nMode As Integer) As Integer

'Print bar code at the specified location, with setting the bar code's parameters.
Public Declare Function KIOSK_S_PrintBarcode Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal pszBuffer As String, ByVal nOrgx As Long, ByVal nType As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal nHriFontType As Long, ByVal nHriFontPosition As Long, ByVal nBytesOfBuffer As Long) As Long

'Set the width of printing area and the direction.
Public Declare Function KIOSK_P_SetAreaAndDirection Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nOrgx As Integer, ByVal nOrgy As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal nDirection As Integer) As Integer

'Write one character string at the specified position.
Public Declare Function KIOSK_P_Textout Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal pszData As String, ByVal nOrgx As Integer, ByVal nOrgy As Integer, ByVal nWidthTimes As Integer, ByVal nHeightTimes As Integer, ByVal nFontType As Integer, ByVal nFontStyle As Integer) As Integer

'Download a bit map and print it immediately at the specified position.
Public Declare Function KIOSK_P_DownloadPrintBmp Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, pszPath As String, ByVal nTranslateMode As Integer, ByVal nOrgx As Integer, ByVal nOrgy As Integer, ByVal nMode As Integer) As Integer

'Print a bit map in RAM by specifying it's ID.
Public Declare Function KIOSK_P_PrintBmpInRAM Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nID As Integer, ByVal nOrgx As Integer, ByVal nOrgy As Integer, ByVal nMode As Integer) As Integer
 
'Print a bit map in Flash by specifying it's ID.
Public Declare Function KIOSK_P_PrintBmpInFlash Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nID As Integer, ByVal nOrgx As Integer, ByVal nOrgy As Integer, ByVal nMode As Integer) As Integer

'Print bar code at the specified location, with setting the bar code's parameters.
Public Declare Function KIOSK_P_PrintBarcode Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal pszBuffer As String, ByVal nOrgx As Integer, ByVal nOrgy As Integer, ByVal nType As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal nHriFontType As Integer, ByVal nHriFontPosition As Integer, ByVal nBytesOfBuffer As Integer) As Integer

'Print data in page mode.
Public Declare Function KIOSK_P_Print Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer) As Integer

'Clear the buffer.
Public Declare Function KIOSK_P_Clear Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer) As Integer

'/*Special functions.*/
'Print the testing page.
Public Declare Function KIOSK_S_TestPrint Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer) As Integer

'Set the cout mode.
Public Declare Function KIOSK_CountMode Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nMode As Integer, ByVal nBits As Integer, ByVal nOrder As Integer, ByVal nSBound As Integer, ByVal nEBound As Integer, ByVal nSpace As Integer, ByVal nCycTime As Integer, ByVal nCount As Integer) As Integer

'Set the print position at the starting of line.
Public Declare Function KIOSK_SetPrintFromStart Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nMode As Integer) As Integer

'Print the raster.
Public Declare Function KIOSK_SetRaster Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, pszBmpPath As String, ByVal nTranslateMode As Integer, ByVal nMode As Integer) As Integer

'Set the lineation.
Public Declare Function KIOSK_P_Lineation Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nWidth As Integer, ByVal nSVCoordinate As Integer, ByVal nEHCoordinate As Integer, ByVal nEVCoordinate As Integer) As Integer

'Set the 417 bar code.
Public Declare Function KIOSK_BarcodeSetPDF417 Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, pszBuffer As String, ByVal nBytesOfBuffer As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal nColumns As Integer, ByVal nLines As Integer, ByVal nScaleH As Integer, ByVal nScaleV As Integer, ByVal nCorrectGrade As Integer) As Integer

'Set the chinese font.
Public Declare Function KIOSK_SetChineseFont Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, pszBuffer As String, ByVal nBytesOfBuffer As Integer, ByVal nEnable As Integer, ByVal nBigger As Integer, ByVal nLSpacing As Integer, ByVal nRSpacing As Integer, ByVal nUnderLine As Integer) As Integer

'Set the presenter.
Public Declare Function KIOSK_SetPresenter Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nMode As Integer, ByVal nTime As Integer) As Integer

'Set the bundler.
Public Declare Function KIOSK_SetBundler Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nMode As Integer, ByVal nTime As Integer) As Integer

'Set the action of bundler.
Public Declare Function KIOSK_SetBundlerInfo Lib "KIOSKDLL.dll" (ByVal hPort As Long, ByVal nPortType As Integer, ByVal nMode As Integer) As Integer



'Return Value
Public Const KIOSK_SUCCESS As Long = 1001

Public Const KIOSK_FAIL As Long = 1002

Public Const KIOSK_ERROR_INVALID_HANDLE As Long = 1101

Public Const KIOSK_ERROR_INVALID_PARAMETER As Long = 1102

Public Const KIOSK_ERROR_INVALID_PATH As Long = 1201

Public Const KIOSK_ERROR_NOT_BITMAP As Long = 1202

Public Const KIOSK_ERROR_NOT_MONO_BITMAP As Long = 1203

Public Const KIOSK_ERROR_BEYOND_AREA As Long = 1204

Public Const KIOSK_ERROR_FILE As Long = 1301

' ---------------------------------------------------------


Public Const KIOSK_COM_ONESTOPBIT As Long = &H0&
Public Const KIOSK_COM_TWOSTOPBITS As Long = &H1&

' ---------------------------------------------------------

Public Const KIOSK_COM_NOPARITY As Long = &H0&
Public Const KIOSK_COM_ODDPARITY As Long = &H1&
Public Const KIOSK_COM_EVENPARITY As Long = &H2&
Public Const KIOSK_COM_MARKPARITY As Long = &H3&
Public Const KIOSK_COM_SPACEPARITY As Long = &H4&

' ---------------------------------------------------------


Public Const KIOSK_COM_DTR_DSR As Long = &H0&

'---------------------------------------------------------

Public Const KIOSK_PRByVal_MODE_STANDARD As Long = &H0&
Public Const KIOSK_PRByVal_MODE_PAGE As Long = &H1&


'---------------------------------------------------------

Public Const KIOSK_PAPER_SERIAL As Long = &H0&
Public Const KIOSK_PAPER_SIGN As Long = &H1&

'---------------------------------------------------------

Public Const KIOSK_FONT_TYPE_STANDARD As Long = &H0&
Public Const KIOSK_FONT_TYPE_COMPRESSED As Long = &H1&
Public Const KIOSK_FONT_TYPE_UDC As Long = &H2&
Public Const KIOSK_FONT_TYPE_CHINESE As Long = &H3&

'---------------------------------------------------------

Public Const KIOSK_FONT_STYLE_NORMAL As Long = &H0&
Public Const KIOSK_FONT_STYLE_BOLD As Long = &H8&
Public Const KIOSK_FONT_STYLE_THIN_UNDERLINE As Long = &H80&
Public Const KIOSK_FONT_STYLE_THICK_UNDERLINE As Long = &H100&
Public Const KIOSK_FONT_STYLE_UPSIDEDOWN As Long = &H200&
Public Const KIOSK_FONT_STYLE_REVERSE As Long = &H400&
Public Const KIOSK_FONT_STYLE_CLOCKWISE_90 As Long = &H1000&

'---------------------------------------------------------

Public Const KIOSK_BITMAP_PRINT_NORMAL As Long = &H0&
Public Const KIOSK_BITMAP_PRINT_DOUBLE_WIDTH As Long = &H1&
Public Const KIOSK_BITMAP_PRINT_DOUBLE_HEIGHT As Long = &H2&
Public Const KIOSK_BITMAP_PRINT_QUADRUPLE As Long = &H3&
'---------------------------------------------------------

Public Const KIOSK_BITMAP_MODE_8SINGLE_DENSITY As Long = &H0&
Public Const KIOSK_BITMAP_MODE_8DOUBLE_DENSITY As Long = &H1&
Public Const KIOSK_BITMAP_MODE_24SINGLE_DENSITY As Long = &H20&
Public Const KIOSK_BITMAP_MODE_24DOUBLE_DENSITY As Long = &H21&
  
'--------------------------------------------------------

Public Const KIOSK_BITMAP_PRByVal_NORMAL As Long = &H0&
Public Const KIOSK_BITMAP_PRByVal_DOUBLE_WIDTH As Long = &H1&
Public Const KIOSK_BITMAP_PRByVal_DOUBLE_HEIGHT As Long = &H2&
Public Const KIOSK_BITMAP_PRByVal_QUADRUPLE As Long = &H3&

'--------------------------------------------------------

Public Const KIOSK_BARCODE_TYPE_UPC_A As Long = &H41&
Public Const KIOSK_BARCODE_TYPE_UPC_E As Long = &H42&
Public Const KIOSK_BARCODE_TYPE_JAN13 As Long = &H43&
Public Const KIOSK_BARCODE_TYPE_JAN8 As Long = &H44&
Public Const KIOSK_BARCODE_TYPE_CODE39 As Long = &H45&
Public Const KIOSK_BARCODE_TYPE_ITF As Long = &H46&
Public Const KIOSK_BARCODE_TYPE_CODEBAR As Long = &H47&
Public Const KIOSK_BARCODE_TYPE_CODE93 As Long = &H48&
Public Const KIOSK_BARCODE_TYPE_CODE128 As Long = &H49&

'---------------------------------------------------------

Public Const KIOSK_HRI_POSITION_NONE As Long = &H0&
Public Const KIOSK_HRI_POSITION_ABOVE As Long = &H1&
Public Const KIOSK_HRI_POSITION_BELOW As Long = &H2&
Public Const KIOSK_HRI_POSITION_BOTH As Long = &H3&

'---------------------------------------------------------

Public Const KIOSK_AREA_LEFT_TO_RIGHT As Long = &H0&
Public Const KIOSK_AREA_BOTTOM_TO_TOP As Long = &H1&
Public Const KIOSK_AREA_RIGHT_TO_LEFT As Long = &H2&
Public Const KIOSK_AREA_TOP_TO_BOTTOM As Long = &H3&

'---------------------------------------------------------
'Presenter
Public Const KIOSK_PRESENTER_Retraction_on As Long = &H0&
Public Const KIOSK_PRESENTER_Paper_Forward As Long = &H1&
Public Const KIOSK_PRESENTER_Paper_Hold As Long = &H2&

'---------------------------------------------------------
'Bundler
Public Const KIOSK_BUNDLER_Retract As Long = &H0&
Public Const KIOSK_BUNDLER_Present As Long = &H1&

'Print mode
Public Const KIOSK_PRINT_MODE_STANDARD    As Long = &H0&
Public Const KIOSK_PRINT_MODE_PAGE        As Long = &H1&
