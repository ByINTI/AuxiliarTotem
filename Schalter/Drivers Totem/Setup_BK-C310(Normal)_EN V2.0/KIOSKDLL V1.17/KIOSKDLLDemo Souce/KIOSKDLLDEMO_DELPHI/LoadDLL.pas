unit LoadDLL;

interface

uses
   Classes;

type
  PInt = ^Integer;
  //Serial port operation.
	//Open the serial port.
  function KIOSK_OpenCom( lpName: pchar; nComBaudrate: integer; nComDataBits: integer;  nComStopBits: integer; nComParity: integer; nFlowControl: integer): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the timeouts of serial port.
  function KIOSK_SetComTimeOuts( hPort: integer; nWriteTimeoutMul: integer; nWriteTimeoutCon: integer ; nReadTimeoutMul: integer; nReadTimeoutCon: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Close the serial port.
  function KIOSK_CloseCom( hPort: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //LPT port operation.
	//Open the LPT port.
  function KIOSK_OpenLptByDrv( LPTAddress: word ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Close the LPT port.
  function KIOSK_CloseDrvLPT( nPortType: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //USB port operation.
	//Open the USB port.
  function KIOSK_OpenUsb():Integer; stdcall; external 'KIOSKDLL.dll';

  //Open the USB port by ID.
  function KIOSK_OpenUsbByID( nID: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the timeouts of USB port.
  function KIOSK_SetUsbTimeOuts( hPort: integer; wReadTimeouts: integer; wWriteTimeouts: integer ):Integer; stdcall; external 'KIOSKDLL.dll';

  //Close the USB port.
  function KIOSK_CloseUsb( hPort: integer ):Integer; stdcall; external 'KIOSKDLL.dll';

  //Driver port operation.
	//Open the driver port.
  function KIOSK_OpenDrv( drivername: pchar ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Start a document.
  function KIOSK_StartDoc( hPort: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //End a document which is started.
  function KIOSK_EndDoc( hPort: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Close the driver port.
  function KIOSK_CloseDrv( hPort: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Send data to port or file.
  function KIOSK_WriteData( hPort: integer; nPortType: integer;pszData: pchar;nBytesToWrite: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Read data from port or file.
  function KIOSK_ReadData( hPort: integer; nPortType: integer; nStatus: integer; pszBuffer: pchar; nBytesToRead: integer ): Integer; stdcall; external 'KIOSKDLL.dll';


  //Function functions.
	//Send file to print.
  function KIOSK_SendFile( hPort: integer; nPortType: integer; filename: pchar ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Begin to save the data to file from now on.
  function KIOSK_BeginSaveToFile( hPort: integer; lpFileName: pchar; bToPrinter: boolean ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Stop saving the data to file from now on.
  function KIOSK_EndSaveToFile(hPort: integer): Integer; stdcall; external 'KIOSKDLL.dll';

  //Query the status of printer.
  function KIOSK_QueryStatus( hPort: integer; nPortType: integer; pszStatus: pchar; nTimeouts: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Query the real-time status of printer.
  function KIOSK_RTQueryStatus( hPort: integer; nPortType: integer ; pszStatus: pchar ): Integer; stdcall; external 'KIOSKDLL.dll';

  function KIOSK_RTQueryStatusForT681( hPort: integer; nPortType: integer ; pszStatus: pchar ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Automatic Status Back.
  function KIOSK_QueryASB( hPort: integer; nPortType: integer; Enable: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Get the version of KIOSKDLL.
  function KIOSK_GetVersionInfo( pnMajor: pint; pnMinor: pint ): Integer; stdcall; external 'KIOSKDLL.dll';


  //Stat or stop the macro definition.
  function KIOSK_EnableMacro( hPort: integer; nPortType: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Reset the printer.
  function KIOSK_Reset( hPort: integer; nPortType: integer ):Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the mode of paper.
  function KIOSK_SetPaperMode( hPort: integer; nPortType: integer; nMode: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the mode of printing.
  function KIOSK_SetMode( hPort: integer; nPortType: integer; nPrintMode: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set tht units of motion.
  function KIOSK_SetMotionUnit( hPort: integer; nPortType: integer; nHorizontalMU: integer ; nVerticalMU: integer ):Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the spacing of lines.
  function KIOSK_SetLineSpacing( hPort: integer; nPortType: integer; nDistance: integer ):Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the right spacing of character.
  function KIOSK_SetRightSpacing( hPort: integer; nPortType: integer; nDistance: integer  ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the opposite positon.
  function KIOSK_SetOppositePosition( hPort: integer; nPortType: integer; nPrintMode: integer; nHorizontalDist: integer; nVerticalDist: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the positon of tabs.
  function KIOSK_SetTabs( hPort: integer; nPortType: integer; pszPosition: pchar; nCount: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Execute tabs.
  function KIOSK_ExecuteTabs( hPort: integer; nPortType: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Pre-download one bit map to RAM by specifying it's ID.
  function KIOSK_PreDownloadBmpToRAM( hPort: integer; nPortType: integer; pszPath: pchar; nTranslateMode: integer; nID: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Pre-download a group of bit map to Flash by specifying it's ID.
  function KIOSK_PreDownloadBmpToFlash( hPort: integer; nPortType: integer; pszPaths: array of string;nTranslateMode: integer; nCount: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Select an international character and character code page/table.
  function KIOSK_SetCharSetAndCodePage( hPort: integer; nPortType: integer; nCharSet: integer; nCodePage: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //User-defined character.
  function KIOSK_FontUDChar( hPort: integer; nPortType: integer; nEnable: integer; nCharCode: integer; DPI: integer; nChar: integer; pCharBmpBuffer: pchar; nDotsOfWidth: integer;nBytesOfHeight: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Feed one line.
  function KIOSK_FeedLine( hPort: integer; nPortType: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Feed paper forward.
  function KIOSK_FeedLines( hPort: integer; nPortType: integer;  nLines: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Feed lines in the marker paper mode.
  function KIOSK_MarkerFeedPaper( hPort: integer; nPortType: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Cut paper.
  function KIOSK_CutPaper( hPort: integer; nPortType: integer; nMode: integer; nDistance: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Cut paper in the marker paper mode.
  function KIOSK_MarkerCutPaper( hPort: integer; nPortType: integer; nDistance: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the width of printing area.
  function KIOSK_S_SetLeftMarginAndAreaWidth( hPort: integer; nPortType: integer; nDistance: integer; nWidth: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the aligned mode.
  function KIOSK_S_SetAlignMode( hPort: integer; nPortType: integer; nMode: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Write one character string at the specified position.
  function KIOSK_S_Textout( hPort: integer; nPortType: integer; pszData: pchar; nOrgx: integer; nWidthTimes: integer; nHeightTimes: integer; nFontType: integer; nFontStyle: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Download a bit map and print it immediately at the specified position.
  function KIOSK_S_DownloadPrintBmp( hPort: integer; nPortType: integer; pszPath: integer;nTranslateMode: integer; nOrgx: integer; nMode: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Print a bit map in RAM by specifying it's ID.
  function KIOSK_S_PrintBmpInRAM( hPort: integer; nPortType: integer; nID: integer; nOrgx: integer; nMode: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Print a bit map in Flash by specifying it's ID.
  function KIOSK_S_PrintBmpInFlash( hPort: integer; nPortType: integer; nID: integer; nOrgx: integer; nMode: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Print bar code at the specified location, with setting the bar code's parameters.
  function KIOSK_S_PrintBarcode( hPort: integer; nPortType: integer; pszBuffer: pchar; nOrgx: integer; nType: integer; nWidth: integer; nHeight: integer; nHriFontType: integer; nHriFontPosition: integer; nBytesOfBuffer: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the width of printing area and the direction.
  function KIOSK_P_SetAreaAndDirection( hPort: integer; nPortType: integer; nOrgx: integer; nOrgy: integer; nWidth: integer; nHeight: integer; nDirection: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Write one character string at the specified position.
  function KIOSK_P_Textout( hPort: integer; nPortType: integer; pszData: pchar; nOrgx: integer; nOrgy: integer; nWidthTimes: integer; nHeightTimes: integer; nFontType: integer; nFontStyle: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Download a bit map and print it immediately at the specified position.
  function KIOSK_P_DownloadPrintBmp( hPort: integer; nPortType: integer; pszPath: pchar; nTranslateMode: integer; nOrgx: integer; nOrgy: integer; nMode: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Print a bit map in RAM by specifying it's ID.
  function KIOSK_P_PrintBmpInRAM( hPort: integer; nPortType: integer; nIDinteger: integer; nOrgx: integer; nOrgy: integer; nMode: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Print a bit map in Flash by specifying it's ID.
  function KIOSK_P_PrintBmpInFlash( hPort: integer; nPortType: integer; nID: integer; nOrgx: integer; nOrgy: integer; nMode: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Print bar code at the specified location, with setting the bar code's parameters.
  function KIOSK_P_PrintBarcode( hPort: integer; nPortType: integer; pszBuffer: pchar; nOrgx: integer; nOrgy: integer; nType: integer; nWidth: integer; nHeight: integer; nHriFontType: integer; nHriFontPosition: integer; nBytesOfBuffer: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Print data in page mode.
  function KIOSK_P_Print( hPort: integer; nPortType: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Clear the buffer.
  function KIOSK_P_Clear( hPort: integer; nPortType: integer ): Integer; stdcall; external 'KIOSKDLL.dll';


  //Special functions.
	//Print the testing page.
  function KIOSK_S_TestPrint( hPort: integer; nPortType: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the cout mode.
  function KIOSK_SetPrintFromStart( hPort: integer; nPortType: integer; nMode: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the print position at the starting of line.
  function KIOSK_SetRaster( hPort: integer; nPortType: integer; pszBmpPath: pchar; nMode: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Print the raster.
  function KIOSK_CountMode( hPort: integer; nPortType: integer; nBits: integer; nOrder: integer; nSBound: integer; nEBound: integer; nTimeSpace: integer; nCycTime: integer; nCount: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the lineation.
  function KIOSK_P_Lineation( hPort: integer; nPortType: integer; nWidth: integer; nSHCoordinate: integer; nSVCoordinate: integer; nEHCoordinate: integer; nEVCoordinate: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the 417 bar code.
  function KIOSK_BarcodeSetPDF417( hPort: integer; nPortType: integer; pszBuffer: pchar; nBytesOfBuffer: integer; nWidth: integer; nHeight: integer; nLines: integer; nColumns: integer; nScaleH: integer; nScaleV: integer; nCorrectGrade: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the chinese font.
  function KIOSK_SetChineseFont( hPort: integer; nPortType: integer; pszBuffer: pchar; nEnablehPort: integer; nBigger: integer; nLSpacing: integer; nRSpacing: integer; nUnderLine: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the presenter.
  function KIOSK_SetPresenter( hPort: integer; nPortType: integer; nMode: integer; nTime: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the bundler.
  function KIOSK_SetBundler( hPort: integer; nPortType: integer; nMode: integer; nTime: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Set the action of bundler.
  function KIOSK_SetBundlerInfo( hPort: integer; nPortType: integer; nMode: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Query the status of printer.
  function KIOSK_QueryStatus_T( hPort: integer; nPortType: integer; pszStatus: pchar; nTimeouts: integer ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Query the real-time status of printer.
  function KIOSK_RTQueryStatus_T( hPort: integer; nPortType: integer ; pszStatus: pchar ): Integer; stdcall; external 'KIOSKDLL.dll';

  //Automatic Status Back.
  function KIOSK_QueryASB_T( hPort: integer; nPortType: integer; Enable: integer ): Integer; stdcall; external 'KIOSKDLL.dll';


  //The return value of function.
  const  KIOSK_SUCCESS                     = 1001; //All is ok
  const  KIOSK_FAIL                        = 1002; //There is error.
  const  KIOSK_ERROR_INVALID_HANDLE        = 1101; //The handle is not good.
  const  KIOSK_ERROR_INVALID_PARAMETER     = 1102; //The parameter is error.
  const  KIOSK_ERROR_INVALID_PATH          = 1201; //The path is error.
  const  KIOSK_ERROR_NOT_BITMAP            = 1202; //This is not bitmap.
  const  KIOSK_ERROR_NOT_MONO_BITMAP       = 1203; //The bitmap is not self-colored.
  const  KIOSK_ERROR_BEYOND_AREA           = 1204; //The bitmap is too big.
  const  KIOSK_ERROR_FILE                  = 1301; //Error of file.

  //Stop options of serial port
  const  KIOSK_COM_ONESTOPBIT              = $0;
  const  KIOSK_COM_TWOSTOPBITS             = $1;

  //Parity options of serial port
  const  KIOSK_COM_NOPARITY                = $0;
  const  KIOSK_COM_ODDPARITY               = $1;
  const  KIOSK_COM_EVENPARITY              = $2;
  const  KIOSK_COM_MARKPARITY              = $3;
  const  KIOSK_COM_SPACEPARITY             = $4;

  //Flow control options of serial port
  const  KIOSK_COM_DTR_DSR                 = $0;
  const  KIOSK_COM_RTS_CTS                 = $1;
  const  KIOSK_COM_XON_XOFF                = $2;
  const  KIOSK_COM_NO_HANDSHAKE            = $3;

  // Print mode options
  const  KIOSK_PRINT_MODE_STANDARD         = $0;
  const  KIOSK_PRINT_MODE_PAGE             = $1;

  //Paper mode options
  const  KIOSK_PAPER_SERIAL                = $0;
  const  KIOSK_PAPER_SIGN                  = $1;

  // Font type options
  const  KIOSK_FONT_TYPE_STANDARD          = $0;
  const  KIOSK_FONT_TYPE_COMPRESSED        = $1;
  const  KIOSK_FONT_TYPE_UDC               = $2;
  const  KIOSK_FONT_TYPE_CHINESE           = 43;

  // Font style options
  const  KIOSK_FONT_STYLE_NORMAL           = $0;
  const  KIOSK_FONT_STYLE_BOLD             = $8;
  const  KIOSK_FONT_STYLE_THIN_UNDERLINE   = $80;
  const  KIOSK_FONT_STYLE_THICK_UNDERLINE  = $100;
  const  KIOSK_FONT_STYLE_UPSIDEDOWN       = $200;
  const  KIOSK_FONT_STYLE_REVERSE          = $400;
  const  KIOSK_FONT_STYLE_CLOCKWISE_90     = $1000;

  // Mode options of bit-image -- for download and print
  const  KIOSK_BITMAP_MODE_8SINGLE_DENSITY  = $0;
  const  KIOSK_BITMAP_MODE_8DOUBLE_DENSITY  = $1;
  const  KIOSK_BITMAP_MODE_24SINGLE_DENSITY = $20;
  const  KIOSK_BITMAP_MODE_24DOUBLE_DENSITY = $21;
  
  // Mode options of printing bit image in RAM or Flash
  const  KIOSK_BITMAP_PRINT_NORMAL          = $0;
  const  KIOSK_BITMAP_PRINT_DOUBLE_WIDTH    = $1;
  const  KIOSK_BITMAP_PRINT_DOUBLE_HEIGHT   = $2;
  const  KIOSK_BITMAP_PRINT_QUADRUPLE       = $3;

  // Barcode's type
  const  KIOSK_BARCODE_TYPE_UPC_A           = $41;
  const  KIOSK_BARCODE_TYPE_UPC_E           = $42;
  const  KIOSK_BARCODE_TYPE_JAN13           = $43;
  const  KIOSK_BARCODE_TYPE_JAN8            = $44;
  const  KIOSK_BARCODE_TYPE_CODE39          = $45;
  const  KIOSK_BARCODE_TYPE_ITF             = $46;
  const  KIOSK_BARCODE_TYPE_CODEBAR         = $47;
  const  KIOSK_BARCODE_TYPE_CODE93          = $48;
  const  KIOSK_BARCODE_TYPE_CODE128         = $49;

  // Barcode HRI's position
  const  KIOSK_HRI_POSITION_NONE            = $0;
  const  KIOSK_HRI_POSITION_ABOVE           = $1;
  const  KIOSK_HRI_POSITION_BELOW           = $2;
  const  KIOSK_HRI_POSITION_BOTH            = $3;

  // Specify the area direction of paper 
  const  KIOSK_AREA_LEFT_TO_RIGHT           = $0;
  const  KIOSK_AREA_BOTTOM_TO_TOP           = $1;
  const  KIOSK_AREA_RIGHT_TO_LEFT           = $2;
  const  KIOSK_AREA_TOP_TO_BOTTOM           = $3;

  // Presenter mode options
  const  KIOSK_PRESENTER_Retraction_on      = $0;
  const  KIOSK_PRESENTER_Paper_Forward      = $1;
  const  KIOSK_PRESENTER_Paper_Hold         = $2;
  const  KIOSK_PRESENTER_Close              = $3;

  // Bundler mode options
  const  KIOSK_BUNDLER_Retract              = $0;
  const  KIOSK_BUNDLER_Present              = $1;
implementation

end.
