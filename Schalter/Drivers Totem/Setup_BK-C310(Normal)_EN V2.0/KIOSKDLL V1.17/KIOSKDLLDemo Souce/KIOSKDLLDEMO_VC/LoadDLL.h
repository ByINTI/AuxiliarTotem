#ifndef LOADDLL_H
#define LOADDLL_H
#pragma once


//---------------------------------------------------------
//The return value of function. 

//All is ok
const int KIOSK_SUCCESS                    = 1001;

//There is error.
const int KIOSK_FAIL                       = 1002;

//The handle is not good.
const int KIOSK_ERROR_INVALID_HANDLE       = 1101;

//The parameter is error.
const int KIOSK_ERROR_INVALID_PARAMETER    = 1102;

//The path is error.
const int KIOSK_ERROR_INVALID_PATH         = 1201;

//This is not bitmap.
const int KIOSK_ERROR_NOT_BITMAP           = 1202;

//The bitmap is not self-colored.
const int KIOSK_ERROR_NOT_MONO_BITMAP      = 1203;

//The bitmap is too big.
const int KIOSK_ERROR_BEYOND_AREA          = 1204;

//Error of file.
const int KIOSK_ERROR_FILE                 = 1301; 

// ---------------------------------------------------------
//Stop bits 
const int KIOSK_COM_ONESTOPBIT             = 0x00;
const int KIOSK_COM_TWOSTOPBITS            = 0x01;

// ---------------------------------------------------------
//Parity
const int KIOSK_COM_NOPARITY               = 0x00;        
const int KIOSK_COM_ODDPARITY              = 0x01;
const int KIOSK_COM_EVENPARITY             = 0x02;
const int KIOSK_COM_MARKPARITY             = 0x03;
const int KIOSK_COM_SPACEPARITY            = 0x04;

// ---------------------------------------------------------
//Flow control 
const int KIOSK_COM_DTR_DSR                = 0x00;
const int KIOSK_COM_RTS_CTS                = 0x01;
const int KIOSK_COM_XON_XOFF               = 0x02;
const int KIOSK_COM_NO_HANDSHAKE           = 0x03;

//---------------------------------------------------------
//mode of printing
const int KIOSK_PRINT_MODE_STANDARD        = 0x00;        
const int KIOSK_PRINT_MODE_PAGE            = 0x01;

//---------------------------------------------------------
//mode of page 
const int KIOSK_PAPER_SERIAL               = 0x00;
const int KIOSK_PAPER_SIGN                 = 0x01;

//---------------------------------------------------------
//mode of font.
const int KIOSK_FONT_TYPE_STANDARD         = 0x00;
const int KIOSK_FONT_TYPE_COMPRESSED       = 0x01;
const int KIOSK_FONT_TYPE_UDC              = 0x02;
const int KIOSK_FONT_TYPE_CHINESE          = 0x03;

//---------------------------------------------------------
//style of font.
const int KIOSK_FONT_STYLE_NORMAL          = 0x00;
const int KIOSK_FONT_STYLE_BOLD            = 0x08;
const int KIOSK_FONT_STYLE_THIN_UNDERLINE  = 0x80;
const int KIOSK_FONT_STYLE_THICK_UNDERLINE = 0x100;
const int KIOSK_FONT_STYLE_UPSIDEDOWN      = 0x200;
const int KIOSK_FONT_STYLE_REVERSE         = 0x400;
const int KIOSK_FONT_STYLE_CLOCKWISE_90    = 0x1000;

//---------------------------------------------------------
//mode of bitmap
const int KIOSK_BITMAP_MODE_8SINGLE_DENSITY  = 0x00;
const int KIOSK_BITMAP_MODE_8DOUBLE_DENSITY  = 0x01;
const int KIOSK_BITMAP_MODE_24SINGLE_DENSITY = 0x20;
const int KIOSK_BITMAP_MODE_24DOUBLE_DENSITY = 0x21;
  
//--------------------------------------------------------
//mode of bitmap 
const int KIOSK_BITMAP_PRINT_NORMAL          = 0x00;
const int KIOSK_BITMAP_PRINT_DOUBLE_WIDTH    = 0x01;
const int KIOSK_BITMAP_PRINT_DOUBLE_HEIGHT   = 0x02;
const int KIOSK_BITMAP_PRINT_QUADRUPLE       = 0x03;

//--------------------------------------------------------
//mode of bar code 
const int KIOSK_BARCODE_TYPE_UPC_A           = 0x41;
const int KIOSK_BARCODE_TYPE_UPC_E           = 0x42;
const int KIOSK_BARCODE_TYPE_JAN13           = 0x43;
const int KIOSK_BARCODE_TYPE_JAN8            = 0x44;
const int KIOSK_BARCODE_TYPE_CODE39          = 0x45;
const int KIOSK_BARCODE_TYPE_ITF             = 0x46;
const int KIOSK_BARCODE_TYPE_CODEBAR         = 0x47;
const int KIOSK_BARCODE_TYPE_CODE93          = 0x48;
const int KIOSK_BARCODE_TYPE_CODE128         = 0x49;

//---------------------------------------------------------
//Set the position of hir font.
const int KIOSK_HRI_POSITION_NONE            = 0x00;
const int KIOSK_HRI_POSITION_ABOVE           = 0x01;
const int KIOSK_HRI_POSITION_BELOW           = 0x02;
const int KIOSK_HRI_POSITION_BOTH            = 0x03;

//---------------------------------------------------------
//Set the area and direction of printing.
const int KIOSK_AREA_LEFT_TO_RIGHT           = 0x00;
const int KIOSK_AREA_BOTTOM_TO_TOP           = 0x01;
const int KIOSK_AREA_RIGHT_TO_LEFT           = 0x02;
const int KIOSK_AREA_TOP_TO_BOTTOM           = 0x03;

//---------------------------------------------------------
//Set the mode of Presenter
const int KIOSK_PRESENTER_Retraction_on      = 0x00;
const int KIOSK_PRESENTER_Paper_Forward      = 0x01;
const int KIOSK_PRESENTER_Paper_Hold         = 0x02;

//---------------------------------------------------------
//Set the mode of Bundler
const int KIOSK_BUNDLER_Retract              = 0x00;
const int KIOSK_BUNDLER_Present              = 0x01;

typedef HANDLE ( __stdcall *KIOSK_OpenCom )( LPCTSTR lpName, 
											 int nComBaudrate,  
											 int nComDataBits,  
											 int nComStopBits, 
											 int nComParity, 
											 int nFlowControl );

typedef int ( __stdcall *KIOSK_SetComTimeOuts )( HANDLE hPort, 
												 int nWriteTimeoutMul,
												 int nWriteTimeoutCon,
												 int nReadTimeoutMul,
												 int nReadTimeoutCon);

typedef int ( __stdcall *  KIOSK_CloseCom )( HANDLE hPort );


typedef int ( __stdcall * KIOSK_OpenLptByDrv )( WORD LPTAddress ); 

typedef int ( __stdcall * KIOSK_CloseDrvLPT)( int nPortType );


typedef HANDLE ( __stdcall * KIOSK_OpenUsb )( void );

typedef HANDLE ( __stdcall * KIOSK_OpenUsbByID)( int nID );

typedef int ( __stdcall * KIOSK_CloseUsb)( HANDLE hPort );

typedef int ( __stdcall * KIOSK_SetUsbTimeOuts)( HANDLE hPort, WORD wReadTimeouts, WORD wWriteTimeouts);


typedef HANDLE( __stdcall * KIOSK_OpenDrv)( char * drivername );

typedef int ( __stdcall * KIOSK_CloseDrv )( HANDLE hPort );

typedef int ( __stdcall * KIOSK_StartDoc )( HANDLE hPort );

typedef int ( __stdcall * KIOSK_EndDoc ) ( HANDLE hPort );


typedef int ( __stdcall * KIOSK_WriteData )( HANDLE hPort, int nPortType, char * pszData, int nBytesToWrite);

typedef int ( __stdcall * KIOSK_ReadData ) ( HANDLE hPort, int nPortType, int nStatus, char * pszBuffer, int nBytesToRead );


typedef int ( __stdcall * KIOSK_SendFile )( HANDLE hPort, int nPortType, char * filename );

typedef int ( __stdcall * KIOSK_BeginSaveToFile)(HANDLE hPort, LPCTSTR lpFileName, BOOL bToPrinter );

typedef int ( __stdcall * KIOSK_EndSaveToFile)(HANDLE hPort);

typedef int ( __stdcall * KIOSK_QueryStatus )(  HANDLE hPort, int nPortType, char * pszStatus,int nTimeouts);

typedef int ( __stdcall * KIOSK_QueryASB)( HANDLE hPort, int nPortType, int Enalbe );

typedef int ( __stdcall * KIOSK_GetVersionInfo ) ( int *pnMajor,   int *pnMinor);


typedef int ( __stdcall * KIOSK_EnableMacro)( HANDLE hPort, int nPortType, int nEnable );

typedef int ( __stdcall * KIOSK_Reset)(HANDLE hPort, int nPortType);

typedef int ( __stdcall * KIOSK_SetPaperMode)(HANDLE hPort,int nPortType,int nMode);

typedef int ( __stdcall * KIOSK_SetMode)(HANDLE hPort,int nPortType,int nPrintMode );

typedef int ( __stdcall * KIOSK_SetMotionUnit)( HANDLE hPort,int nPortType,int nHorizontalMU,int nVerticalMU );

typedef int ( __stdcall * KIOSK_SetLineSpacing) ( HANDLE hPort,int nPortType,int nDistance);

typedef int ( __stdcall * KIOSK_SetRightSpacing)( HANDLE hPort,int nPortType,int nDistance) ;

typedef int ( __stdcall * KIOSK_SetOppositePosition)(HANDLE hPort,
													int nPortType,
													int nPrintMode,
													int nHorizontalDist,
													int nVerticalDist  );

typedef int ( __stdcall * KIOSK_SetTabs )( HANDLE hPort, int nPortType,	char * pszPosition, int nCount );

typedef int ( __stdcall * KIOSK_ExecuteTabs)( HANDLE hPort,  int nPortType );

typedef int ( __stdcall * KIOSK_PreDownloadBmpToRAM)( HANDLE hPort, int nPortType, char * pszPaths, int nTranslateMode,  int nID );

typedef int ( __stdcall * KIOSK_PreDownloadBmpToFlash )( HANDLE hPort,
														int nPortType,
														char * pszPaths[], 
														 int nTranslateMode,
														int nCount );

typedef int ( __stdcall * KIOSK_SetCharSetAndCodePage)(HANDLE hPort,int nPortType,	int nCharSet,int nCodePage);

typedef int ( __stdcall * KIOSK_FontUDChar)( HANDLE hPort,
											int nPortType,
											int nEnable,
											int DPI,
											int nChar,
											int nCharCode,
											char *pCharBmpBuffer,
											int nDotsOfWidth,
											int nBytesOfHeight );

typedef int ( __stdcall * KIOSK_FeedLine)(HANDLE hPort, int nPortType);

typedef int ( __stdcall * KIOSK_FeedLines)(HANDLE hPort,int nPortType,int nLines);

typedef int ( __stdcall * KIOSK_MarkerFeedPaper)( HANDLE hPort, int nPortType );

typedef int ( __stdcall * KIOSK_CutPaper)( HANDLE hPort, int nPortType, int nMode, int nDistance );

typedef int ( __stdcall * KIOSK_MarkerCutPaper)(HANDLE hPort, int nPortType, int nDistance );

typedef int ( __stdcall * KIOSK_S_SetLeftMarginAndAreaWidth)(HANDLE hPort,
															 int nPortType,
															 int nDistance,
															 int nWidth );

typedef int ( __stdcall * KIOSK_S_SetAlignMode)( HANDLE hPort, int nPortType, int nMode);

typedef int ( __stdcall * KIOSK_S_Textout)(	HANDLE hPort,
											int nPortType,
											char *pszData,     
											int nOrgx,           
											int nWidthTimes,     
											int nHeightTimes,    
											int nFontType,       
											int nFontStyle );

typedef int ( __stdcall * KIOSK_S_DownloadPrintBmp)(HANDLE hPort, 
													 int nPortType,
													 char *pszPath, 
													 int nTranslateMode, 
													 int nOrgx,        
													 int nMode);

typedef int ( __stdcall *KIOSK_S_PrintBmpInRAM)( HANDLE hPort, 
												 int nPortType,
												 int nID,     
												 int nOrgx,        
												 int nMode);

typedef int ( __stdcall * KIOSK_S_PrintBmpInFlash)( HANDLE hPort,
													 int nPortType,
													 int nID,         
													 int nOrgx,       
													 int nMode );

typedef int (__stdcall * KIOSK_S_PrintBarcode)(	 HANDLE hPort,
												 int nPortType,
												 char *pszBuffer,
												 int nOrgx,
												 int nType, 
												 int nWidth,
												 int nHeight,
												 int nHriFontType,
												 int nHriFontPosition,
												 int nBytesOfBuffer );

typedef int (__stdcall * KIOSK_P_SetAreaAndDirection)( HANDLE hPort,
													  int nPortType,
													  int nOrgx,        
													  int nOrgy,        
													  int nWidth,       
													  int nHeight,      
													  int nDirection );

typedef int ( __stdcall * KIOSK_P_Textout)(  HANDLE hPort,
											 int nPortType,  
											 char *pszData,     
											 int nOrgx, 
											 int nOrgy,          
											 int nWidthTimes,     
											 int nHeightTimes,    
											 int nFontType,       
											 int nFontStyle);

typedef int ( __stdcall * KIOSK_P_DownloadPrintBmp)( HANDLE hPort, 
													 int nPortType,
													 char *pszPath, 
													 int nTranslateMode, 
													 int nOrgx,   
													 int nOrgy,     
													 int nMode );

typedef int ( __stdcall * KIOSK_P_PrintBmpInRAM)( HANDLE hPort,
												 int nPortType,
												 int nID,         
												 int nOrgx,  
												 int nOrgy,     
												 int nMode);

typedef int ( __stdcall * KIOSK_P_PrintBmpInFlash)(	 HANDLE hPort,
													 int nPortType,
													 int nID,         
													 int nOrgx,  
													 int nOrgy,     
													 int nMode );

typedef int ( __stdcall * KIOSK_P_PrintBarcode)(HANDLE hPort,
												int nPortType,
												char *pszBuffer,
												int nOrgx,
												int nOrgy, 
												int nType, 
												int nWidth,
												int nHeight,
												int nHriFontType,
												int nHriFontPosition,
												int nBytesOfBuffer);

typedef int ( WINAPI * KIOSK_P_Print)( HANDLE hPort, int nPortType);

typedef int ( __stdcall * KIOSK_P_Clear)( HANDLE hPort, int nPortType);

typedef int ( __stdcall * KIOSK_S_TestPrint)( HANDLE hPort, int nPortType);

typedef int ( __stdcall * KIOSK_CountMode)( HANDLE hPort,
											int nPortType,
											int nBits,
											int nOrder,
											int nSBound,
											int nEBound,
											int nTimeSpace,
											int nCycTime,
											int nCount );

typedef int ( __stdcall * KIOSK_SetPrintFromStart)(	HANDLE hPort,int nPortType,int nMode );

typedef int ( __stdcall * KIOSK_SetRaster )( HANDLE hPort, int nPortType, char *pszBmpPath, int nTranslateMode, int nMode );

typedef int (__stdcall * KIOSK_P_Lineation)( HANDLE hPort,
											int nPortType,
											int nWidth,
											int nSHCoordinate,
											int nSVCoordinate,
											int nEHCoordinate,
											int nEVCoordinate );

typedef int ( __stdcall * KIOSK_BarcodeSetPDF417)(HANDLE hPort,
												int nPortType,
												char * pszBuffer,
												int nBytesOfBuffer,
												int nWidth, 
												int nHeight,
												int nColumns,
												int nLines,
												int nScaleH,
												int nScaleV,
												int nCorrectGrade );

typedef  int (__stdcall * KIOSK_SetChineseFont)(HANDLE hPort,
												int nPortType,
												char * pszBuffer,
												int nEnable,
												int nBigger,
												int nLSpacing,
												int nRSpacing,
												int nUnderLine );

typedef int ( __stdcall * KIOSK_SetPresenter)(	HANDLE hPort, int nPortType, int nMode, int nTime);

typedef int (__stdcall * KIOSK_SetBundler)( HANDLE hPort, int nPortType, int nMode, int nTime );

typedef int( __stdcall * KIOSK_SetBundlerInfo )( HANDLE hPort,int nPortType,int nMode );

typedef int( __stdcall * KIOSK_RTQueryStatus_T)(HANDLE hPort, int nPortType, char * pszStatus);

typedef int( __stdcall * KIOSK_QueryASB_T)( HANDLE hPort, int nPortType, int Enable);

typedef int( __stdcall * KIOSK_QueryStatus_T)(HANDLE hPort, int nPortType, char * pszStatus, int nTimeouts);
typedef int (__stdcall * KIOSK_PrintSelfTest)(HANDLE hPort, int nPortType);

typedef int ( __stdcall * KIOSK_RTQueryStatus)( HANDLE hPort, int nPortType, char * pszStatus);
typedef int (__stdcall * KIOSK_RTQueryStatusForT681)(HANDLE hPort, int nPortType, char * pszStatus );

//*********************************************************
//Load or unload kioskdll.

bool LoadKioskdll(void);

bool UnloadKioskdll(void);

#endif