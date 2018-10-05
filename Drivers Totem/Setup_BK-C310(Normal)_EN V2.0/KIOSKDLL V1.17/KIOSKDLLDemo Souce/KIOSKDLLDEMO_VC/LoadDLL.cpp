#include "StdAfx.h"
#include "LoadDLL.h"

HINSTANCE hKIOSKdll  =  NULL; //instance handle.

//*******************************Define the functions****************************************

//Serial port operation.
KIOSK_OpenCom						VC_KIOSK_OpenCom						= NULL;
KIOSK_SetComTimeOuts				VC_KIOSK_SetComTimeOuts					= NULL;
KIOSK_CloseCom						VC_KIOSK_CloseCom						= NULL;

//LPT operation.
KIOSK_OpenLptByDrv					VC_KIOSK_OpenLptByDrv					= NULL;
KIOSK_CloseDrvLPT					VC_KIOSK_CloseDrvLPT					= NULL;

//USB port operation.
KIOSK_OpenUsb						VC_KIOSK_OpenUsb						= NULL;
KIOSK_OpenUsbByID					VC_KIOSK_OpenUsbByID					= NULL;
KIOSK_SetUsbTimeOuts				VC_KIOSK_SetUsbTimeOuts					= NULL;
KIOSK_CloseUsb						VC_KIOSK_CloseUsb						= NULL;

//Driver port operation.
KIOSK_OpenDrv						VC_KIOSK_OpenDrv						= NULL;
KIOSK_StartDoc						VC_KIOSK_StartDoc						= NULL;
KIOSK_EndDoc						VC_KIOSK_EndDoc							= NULL;
KIOSK_CloseDrv						VC_KIOSK_CloseDrv						= NULL;

//Write or read data functions.
KIOSK_WriteData						VC_KIOSK_WriteData						= NULL;
KIOSK_ReadData						VC_KIOSK_ReadData						= NULL;
 
//Function functions.
KIOSK_SendFile						VC_KIOSK_SendFile						= NULL;
KIOSK_BeginSaveToFile				VC_KIOSK_BeginSaveToFile				= NULL;
KIOSK_EndSaveToFile					VC_KIOSK_EndSaveToFile					= NULL;
KIOSK_QueryStatus					VC_KIOSK_QueryStatus					= NULL;
KIOSK_RTQueryStatus					VC_KIOSK_RTQueryStatus					= NULL;
KIOSK_QueryASB					    VC_KIOSK_QueryASB						= NULL;
KIOSK_GetVersionInfo				VC_KIOSK_GetVersionInfo					= NULL;

//Command functions.
KIOSK_EnableMacro					VC_KIOSK_EnableMacro					= NULL;
KIOSK_Reset							VC_KIOSK_Reset							= NULL;
KIOSK_SetPaperMode					VC_KIOSK_SetPaperMode					= NULL;
KIOSK_SetMode						VC_KIOSK_SetMode						= NULL;
KIOSK_SetMotionUnit					VC_KIOSK_SetMotionUnit					= NULL;
KIOSK_SetLineSpacing				VC_KIOSK_SetLineSpacing					= NULL;
KIOSK_SetRightSpacing				VC_KIOSK_SetRightSpacing				= NULL;
KIOSK_SetOppositePosition			VC_KIOSK_SetOppositePosition			= NULL;
KIOSK_SetTabs						VC_KIOSK_SetTabs						= NULL;
KIOSK_ExecuteTabs					VC_KIOSK_ExecuteTabs					= NULL; 
KIOSK_PreDownloadBmpToRAM			VC_KIOSK_PreDownloadBmpToRAM			= NULL;
KIOSK_PreDownloadBmpToFlash			VC_KIOSK_PreDownloadBmpToFlash			= NULL;
KIOSK_SetCharSetAndCodePage			VC_KIOSK_SetCharSetAndCodePage			= NULL;
KIOSK_FontUDChar					VC_KIOSK_FontUDChar						= NULL;
KIOSK_FeedLine						VC_KIOSK_FeedLine						= NULL;
KIOSK_FeedLines						VC_KIOSK_FeedLines						= NULL;
KIOSK_MarkerFeedPaper               VC_KIOSK_MarkerFeedPaper				= NULL;
KIOSK_CutPaper                      VC_KIOSK_CutPaper                       = NULL;
KIOSK_MarkerCutPaper                VC_KIOSK_MarkerCutPaper                 = NULL;

//Standard mode functions.
KIOSK_S_SetLeftMarginAndAreaWidth   VC_KIOSK_S_SetLeftMarginAndAreaWidth    = NULL;
KIOSK_S_SetAlignMode				VC_KIOSK_S_SetAlignMode					= NULL;
KIOSK_S_Textout						VC_KIOSK_S_Textout						= NULL;
KIOSK_S_DownloadPrintBmp			VC_KIOSK_S_DownloadPrintBmp				= NULL;
KIOSK_S_PrintBmpInRAM				VC_KIOSK_S_PrintBmpInRAM				= NULL;
KIOSK_S_PrintBmpInFlash				VC_KIOSK_S_PrintBmpInFlash				= NULL;
KIOSK_S_PrintBarcode				VC_KIOSK_S_PrintBarcode					= NULL;

//Page mode functions.
KIOSK_P_SetAreaAndDirection			VC_KIOSK_P_SetAreaAndDirection			= NULL;
KIOSK_P_Textout						VC_KIOSK_P_Textout						= NULL;
KIOSK_P_DownloadPrintBmp			VC_KIOSK_P_DownloadPrintBmp				= NULL;
KIOSK_P_PrintBmpInRAM				VC_KIOSK_P_PrintBmpInRAM				= NULL;
KIOSK_P_PrintBmpInFlash				VC_KIOSK_P_PrintBmpInFlash				= NULL;
KIOSK_P_PrintBarcode				VC_KIOSK_P_PrintBarcode					= NULL;
KIOSK_P_Print						VC_KIOSK_P_Print						= NULL;
KIOSK_P_Clear						VC_KIOSK_P_Clear						= NULL;

//Special functions.
KIOSK_S_TestPrint					VC_KIOSK_S_TestPrint					= NULL;
KIOSK_CountMode						VC_KIOSK_CountMode						= NULL;
KIOSK_SetPrintFromStart				VC_KIOSK_SetPrintFromStart				= NULL;
KIOSK_SetRaster						VC_KIOSK_SetRaster						= NULL;
KIOSK_P_Lineation					VC_KIOSK_P_Lineation					= NULL;
KIOSK_BarcodeSetPDF417				VC_KIOSK_BarcodeSetPDF417				= NULL;
KIOSK_SetChineseFont				VC_KIOSK_SetChineseFont					= NULL;
KIOSK_SetPresenter					VC_KIOSK_SetPresenter					= NULL;
KIOSK_SetBundler					VC_KIOSK_SetBundler						= NULL;
KIOSK_SetBundlerInfo				VC_KIOSK_SetBundlerInfo					= NULL;

KIOSK_RTQueryStatus_T				VC_KIOSK_RTQueryStatus_T				= NULL;
KIOSK_QueryASB_T					VC_KIOSK_QueryASB_T						= NULL;
KIOSK_QueryStatus_T					VC_KIOSK_QueryStatus_T					= NULL;
KIOSK_PrintSelfTest                 VC_KIOSK_PrintSelfTest                  = NULL;
KIOSK_RTQueryStatusForT681			VC_KIOSK_RTQueryStatusForT681			= NULL;
/***********************************************************************************
  Function:       LoadKioskdll();
  Description:    Loading the functions of KIOSKDLL.
  Calls:          The functions of KIOSKDLL.
  Called By:      OnPortOpen();  
  Return:         Returns True if successful, False if not successful.
************************************************************************************/
bool LoadKioskdll( void )
{
	hKIOSKdll = LoadLibrary("KIOSKDLL.dll");
    if( !hKIOSKdll )
	{
		return false;
	}	

	/*Serial port operation.*/
	//Open the serial port.
	VC_KIOSK_OpenCom = ( KIOSK_OpenCom )GetProcAddress( hKIOSKdll,"KIOSK_OpenCom" );
	if( VC_KIOSK_OpenCom == NULL )
	{
		return false;
	}

	//Set the timeouts of serial port.
	VC_KIOSK_SetComTimeOuts = ( KIOSK_SetComTimeOuts )GetProcAddress( hKIOSKdll,"KIOSK_SetComTimeOuts" );
	if( VC_KIOSK_SetComTimeOuts == NULL )
	{
		return false;
	}

	//Close the serial port.
	VC_KIOSK_CloseCom = ( KIOSK_CloseCom )GetProcAddress( hKIOSKdll,"KIOSK_CloseCom" );
	if( VC_KIOSK_CloseCom == NULL )
	{
		return false;
	}

	/*LPT port operation.*/
	//Open the LPT port.
	VC_KIOSK_OpenLptByDrv = ( KIOSK_OpenLptByDrv )GetProcAddress( hKIOSKdll,"KIOSK_OpenLptByDrv" );
	if( VC_KIOSK_OpenLptByDrv == NULL )
	{
		return false;
	}

	//Close the LPT port.
	VC_KIOSK_CloseDrvLPT = ( KIOSK_CloseDrvLPT )GetProcAddress( hKIOSKdll,"KIOSK_CloseDrvLPT" );
	if( VC_KIOSK_CloseDrvLPT == NULL )
	{
		return false;
	}

	/*USB port operation.*/
	//Open the USB port.
 	VC_KIOSK_OpenUsb = ( KIOSK_OpenUsb )GetProcAddress( hKIOSKdll,"KIOSK_OpenUsb" );
	if( VC_KIOSK_OpenUsb == NULL )
	{
		return false;
	}

	//Open the USB port by ID.
	VC_KIOSK_OpenUsbByID = ( KIOSK_OpenUsbByID )GetProcAddress( hKIOSKdll,"KIOSK_OpenUsbByID" );
	if( VC_KIOSK_OpenUsbByID == NULL )
	{
		return false;
	}

	//Set the timeouts of USB port.
	VC_KIOSK_SetUsbTimeOuts = ( KIOSK_SetUsbTimeOuts )GetProcAddress( hKIOSKdll,"KIOSK_SetUsbTimeOuts" );
	if( VC_KIOSK_SetUsbTimeOuts == NULL )
	{
		return false;
	}

	//Close the USB port.
	VC_KIOSK_CloseUsb = ( KIOSK_CloseUsb )GetProcAddress( hKIOSKdll,"KIOSK_CloseUsb" );
	if( VC_KIOSK_CloseUsb == NULL )
	{
		return false;
	}

	/*Driver port operation.*/
	//Open the driver port.
	VC_KIOSK_OpenDrv = ( KIOSK_OpenDrv )GetProcAddress( hKIOSKdll,"KIOSK_OpenDrv" );
	if( VC_KIOSK_OpenDrv == NULL )
	{
		return false;
	}

	//Start a document.
	VC_KIOSK_StartDoc = ( KIOSK_StartDoc )GetProcAddress( hKIOSKdll,"KIOSK_StartDoc" );
	if( VC_KIOSK_StartDoc == NULL )
	{
		return false;
	}

	//End a document which is started.
	VC_KIOSK_EndDoc = ( KIOSK_EndDoc )GetProcAddress( hKIOSKdll,"KIOSK_EndDoc" );
	if( VC_KIOSK_EndDoc == NULL )
	{
		return false;
	}

	//Close the driver port.
	VC_KIOSK_CloseDrv = ( KIOSK_CloseDrv )GetProcAddress( hKIOSKdll,"KIOSK_CloseDrv" );
	if( VC_KIOSK_CloseDrv == NULL )
	{
		return false;
	}

    //Send data to port or file.
	VC_KIOSK_WriteData = ( KIOSK_WriteData )GetProcAddress( hKIOSKdll,"KIOSK_WriteData" );
	if( VC_KIOSK_WriteData == NULL )
	{
		return false;
	}

	//Read data from port or file.
	VC_KIOSK_ReadData = ( KIOSK_ReadData )GetProcAddress( hKIOSKdll,"KIOSK_ReadData" );
	if( VC_KIOSK_ReadData == NULL )
	{
		return false;
	}

	/*Function functions.*/
	//Send file to print.
	VC_KIOSK_SendFile = ( KIOSK_SendFile )GetProcAddress( hKIOSKdll,"KIOSK_SendFile" );
	if( VC_KIOSK_SendFile == NULL )
	{
		return false;
	}

	//Begin to save the data to file from now on.
	VC_KIOSK_BeginSaveToFile = ( KIOSK_BeginSaveToFile )GetProcAddress( hKIOSKdll,"KIOSK_BeginSaveToFile" );
	if( VC_KIOSK_BeginSaveToFile == NULL )
	{
		return false;
	}

	//Stop saving the data to file from now on.
	VC_KIOSK_EndSaveToFile = ( KIOSK_EndSaveToFile )GetProcAddress( hKIOSKdll,"KIOSK_EndSaveToFile" );
	if( VC_KIOSK_EndSaveToFile == NULL )
	{
		return false;
	}

	//Query the status of printer.
	VC_KIOSK_QueryStatus = ( KIOSK_QueryStatus )GetProcAddress( hKIOSKdll,"KIOSK_QueryStatus" );
	if( VC_KIOSK_QueryStatus == NULL )
	{
		return false;
	}

	//Query the real-time status of printer.
    	VC_KIOSK_RTQueryStatus = ( KIOSK_RTQueryStatus )GetProcAddress( hKIOSKdll,"KIOSK_RTQueryStatus" );
	if( VC_KIOSK_RTQueryStatus == NULL )
	{
		return false;
	}

	//Automatic Status Back.
	VC_KIOSK_QueryASB = ( KIOSK_QueryASB )GetProcAddress( hKIOSKdll,"KIOSK_QueryASB" );
	if( VC_KIOSK_QueryASB == NULL )
	{
		return false;
	}

	//Get the version of KIOSKDLL.
	VC_KIOSK_GetVersionInfo = ( KIOSK_GetVersionInfo )GetProcAddress( hKIOSKdll,"KIOSK_GetVersionInfo" );
	if( VC_KIOSK_GetVersionInfo == NULL )
	{
		return false;
	}

	//Stat or stop the macro definition.
  	VC_KIOSK_EnableMacro = ( KIOSK_EnableMacro )GetProcAddress( hKIOSKdll,"KIOSK_EnableMacro" );
	if( VC_KIOSK_EnableMacro == NULL )
	{
		return false;
	}

	//Reset the printer.
	VC_KIOSK_Reset = ( KIOSK_Reset )GetProcAddress( hKIOSKdll,"KIOSK_Reset" );
	if( VC_KIOSK_Reset == NULL )
	{
		return false;
	}

	//Set the mode of paper.
	VC_KIOSK_SetPaperMode = ( KIOSK_SetPaperMode )GetProcAddress( hKIOSKdll,"KIOSK_SetPaperMode" );
	if( VC_KIOSK_SetPaperMode == NULL )
	{
		return false;
	}

	//Set the mode of printing.
	VC_KIOSK_SetMode = ( KIOSK_SetMode )GetProcAddress( hKIOSKdll,"KIOSK_SetMode" );
	if( VC_KIOSK_SetMode == NULL )
	{
		return false;
	}

	//Set tht units of motion.
	VC_KIOSK_SetMotionUnit = ( KIOSK_SetMotionUnit )GetProcAddress( hKIOSKdll,"KIOSK_SetMotionUnit" );
    	if( VC_KIOSK_SetMotionUnit == NULL )
	{
		return false;
	}

	//Set the spacing of lines.
	VC_KIOSK_SetLineSpacing = ( KIOSK_SetLineSpacing )GetProcAddress( hKIOSKdll,"KIOSK_SetLineSpacing" );
	if( VC_KIOSK_SetLineSpacing == NULL )
	{
		return false;
	}

	//Set the right spacing of character.
	VC_KIOSK_SetRightSpacing = ( KIOSK_SetRightSpacing )GetProcAddress( hKIOSKdll,"KIOSK_SetRightSpacing" );
	if( VC_KIOSK_SetRightSpacing == NULL )
	{
		return false;
	}

	//Set the opposite positon.
	VC_KIOSK_SetOppositePosition = ( KIOSK_SetOppositePosition )GetProcAddress( hKIOSKdll,"KIOSK_SetOppositePosition" );
	if( VC_KIOSK_SetOppositePosition == NULL )
	{
		return false;
	}

	//Set the positon of tabs.
	VC_KIOSK_SetTabs = ( KIOSK_SetTabs )GetProcAddress( hKIOSKdll,"KIOSK_SetTabs" );
	if( VC_KIOSK_SetTabs == NULL )
	{
		return false;
	}

	//Execute tabs.
	VC_KIOSK_ExecuteTabs = ( KIOSK_ExecuteTabs )GetProcAddress( hKIOSKdll,"KIOSK_ExecuteTabs" );
	if( VC_KIOSK_OpenCom == NULL )
	{
		return false;
	}

	//Pre-download one bit map to RAM by specifying it's ID.
	VC_KIOSK_PreDownloadBmpToRAM = ( KIOSK_PreDownloadBmpToRAM )GetProcAddress( hKIOSKdll,"KIOSK_PreDownloadBmpToRAM" );
	if( VC_KIOSK_PreDownloadBmpToRAM == NULL )
	{
		return false;
	}

	//Pre-download a group of bit map to Flash by specifying it's ID.
	VC_KIOSK_PreDownloadBmpToFlash = ( KIOSK_PreDownloadBmpToFlash )GetProcAddress( hKIOSKdll,"KIOSK_PreDownloadBmpToFlash" );
	if( VC_KIOSK_PreDownloadBmpToFlash == NULL )
	{
		return false;
	}

	//Select an international character and character code page/table. 
	VC_KIOSK_SetCharSetAndCodePage = ( KIOSK_SetCharSetAndCodePage )GetProcAddress( hKIOSKdll,"KIOSK_SetCharSetAndCodePage" );
	if( VC_KIOSK_SetCharSetAndCodePage == NULL )
	{
		return false;
	}

	//User-defined character.
	VC_KIOSK_FontUDChar = ( KIOSK_FontUDChar )GetProcAddress( hKIOSKdll,"KIOSK_FontUDChar" );
	if( VC_KIOSK_FontUDChar == NULL )
	{
		return false;
	}

	//Feed one line.
	VC_KIOSK_FeedLine = ( KIOSK_FeedLine )GetProcAddress( hKIOSKdll,"KIOSK_FeedLine" );
	if( VC_KIOSK_FeedLine == NULL )
	{
		return false;
	}

	//Feed paper forward.
	VC_KIOSK_FeedLines = ( KIOSK_FeedLines )GetProcAddress( hKIOSKdll,"KIOSK_FeedLines" );
	if( VC_KIOSK_FeedLines == NULL )
	{
		return false;
	}

	//Feed lines in the marker paper mode.
	VC_KIOSK_MarkerFeedPaper = ( KIOSK_MarkerFeedPaper )GetProcAddress( hKIOSKdll,"KIOSK_MarkerFeedPaper" );
	if( VC_KIOSK_MarkerFeedPaper == NULL )
	{
		return false;
	}

	//Cut paper.
	VC_KIOSK_CutPaper = ( KIOSK_CutPaper )GetProcAddress( hKIOSKdll,"KIOSK_CutPaper" );
	if( VC_KIOSK_CutPaper == NULL )
	{
		return false;
	}

	//Cut paper in the marker paper mode.
	VC_KIOSK_MarkerCutPaper = ( KIOSK_MarkerCutPaper )GetProcAddress( hKIOSKdll,"KIOSK_MarkerCutPaper" );
	if( VC_KIOSK_MarkerCutPaper == NULL )
	{
		return false;
	}

	//Set the width of printing area.
	VC_KIOSK_S_SetLeftMarginAndAreaWidth = ( KIOSK_S_SetLeftMarginAndAreaWidth )GetProcAddress( hKIOSKdll,"KIOSK_S_SetLeftMarginAndAreaWidth" );
	if( VC_KIOSK_S_SetLeftMarginAndAreaWidth == NULL )
	{
		return false;
	}

	//Set the aligned mode.
	VC_KIOSK_S_SetAlignMode = ( KIOSK_S_SetAlignMode )GetProcAddress( hKIOSKdll,"KIOSK_S_SetAlignMode" );
	if( VC_KIOSK_S_SetAlignMode == NULL )
	{
		return false;
	}

	//Write one character string at the specified position.
	VC_KIOSK_S_Textout = ( KIOSK_S_Textout )GetProcAddress( hKIOSKdll,"KIOSK_S_Textout" );
	if( VC_KIOSK_S_Textout == NULL )
	{
		return false;
	}

	//Download a bit map and print it immediately at the specified position.
	VC_KIOSK_S_DownloadPrintBmp = ( KIOSK_S_DownloadPrintBmp )GetProcAddress( hKIOSKdll,"KIOSK_S_DownloadPrintBmp" );
	if( VC_KIOSK_S_DownloadPrintBmp == NULL )
	{
		return false;
	}

	//Print a bit map in RAM by specifying it's ID.
	VC_KIOSK_S_PrintBmpInRAM = ( KIOSK_S_PrintBmpInRAM )GetProcAddress( hKIOSKdll,"KIOSK_S_PrintBmpInRAM" );
	if( VC_KIOSK_S_PrintBmpInRAM == NULL )
	{
		return false;
	}

	//Print a bit map in Flash by specifying it's ID.
	VC_KIOSK_S_PrintBmpInFlash = ( KIOSK_S_PrintBmpInFlash )GetProcAddress( hKIOSKdll,"KIOSK_S_PrintBmpInFlash" );
	if( VC_KIOSK_S_PrintBmpInFlash == NULL )
	{
		return false;
	}

	//Print bar code at the specified location, with setting the bar code's parameters.
	VC_KIOSK_S_PrintBarcode = ( KIOSK_S_PrintBarcode )GetProcAddress( hKIOSKdll,"KIOSK_S_PrintBarcode" );
	if( VC_KIOSK_OpenCom == NULL )
	{
		return false;
	}

	//Set the width of printing area and the direction.
	VC_KIOSK_P_SetAreaAndDirection = ( KIOSK_P_SetAreaAndDirection )GetProcAddress( hKIOSKdll,"KIOSK_P_SetAreaAndDirection" );
	if( VC_KIOSK_P_SetAreaAndDirection == NULL )
	{
		return false;
	}

	//Write one character string at the specified position.
	VC_KIOSK_P_Textout = ( KIOSK_P_Textout )GetProcAddress( hKIOSKdll,"KIOSK_P_Textout" );
	if( VC_KIOSK_P_Textout == NULL )
	{
		return false;
	}

	//Download a bit map and print it immediately at the specified position.
	VC_KIOSK_P_DownloadPrintBmp = ( KIOSK_P_DownloadPrintBmp )GetProcAddress( hKIOSKdll,"KIOSK_P_DownloadPrintBmp" );
	if( VC_KIOSK_P_DownloadPrintBmp == NULL )
	{
		return false;
	}

	//Print a bit map in RAM by specifying it's ID.
	VC_KIOSK_P_PrintBmpInRAM = ( KIOSK_P_PrintBmpInRAM )GetProcAddress( hKIOSKdll,"KIOSK_P_PrintBmpInRAM" );
	if( VC_KIOSK_P_PrintBmpInRAM == NULL )
	{
		return false;
	}

	//Print a bit map in Flash by specifying it's ID.
	VC_KIOSK_P_PrintBmpInFlash = ( KIOSK_P_PrintBmpInFlash )GetProcAddress( hKIOSKdll,"KIOSK_P_PrintBmpInFlash" );
	if( VC_KIOSK_P_PrintBmpInFlash == NULL )
	{
		return false;
	}

	//Print bar code at the specified location, with setting the bar code's parameters.
	VC_KIOSK_P_PrintBarcode = ( KIOSK_P_PrintBarcode )GetProcAddress( hKIOSKdll,"KIOSK_P_PrintBarcode" );
	if( VC_KIOSK_P_PrintBarcode == NULL )
	{
		return false;
	}

	//Print data in page mode.
	VC_KIOSK_P_Print = ( KIOSK_P_Print )GetProcAddress( hKIOSKdll,"KIOSK_P_Print" );
	if( VC_KIOSK_P_Print == NULL )
	{
		return false;
	}

	//Clear the buffer.
	VC_KIOSK_P_Clear = ( KIOSK_P_Clear )GetProcAddress( hKIOSKdll,"KIOSK_P_Clear" );
	if( VC_KIOSK_P_Clear == NULL )
	{
		return false;
	}

	/*Special functions.*/
	//Print the testing page.
	VC_KIOSK_S_TestPrint = ( KIOSK_S_TestPrint )GetProcAddress( hKIOSKdll,"KIOSK_S_TestPrint" );
	if( VC_KIOSK_S_TestPrint == NULL )
	{
		return false;
	}

	//Set the cout mode.
	VC_KIOSK_CountMode = ( KIOSK_CountMode )GetProcAddress( hKIOSKdll,"KIOSK_CountMode" );
	if( VC_KIOSK_CountMode == NULL )
	{
		return false;
	}

	//Set the print position at the starting of line.
	VC_KIOSK_SetPrintFromStart = ( KIOSK_SetPrintFromStart )GetProcAddress( hKIOSKdll,"KIOSK_SetPrintFromStart" );
	if( VC_KIOSK_SetPrintFromStart == NULL )
	{
		return false;
	}

	//Print the raster.
	VC_KIOSK_SetRaster = ( KIOSK_SetRaster )GetProcAddress( hKIOSKdll,"KIOSK_SetRaster" );
	if( VC_KIOSK_SetRaster == NULL )
	{
		return false;
	}

	//Set the lineation.
	VC_KIOSK_P_Lineation = ( KIOSK_P_Lineation )GetProcAddress( hKIOSKdll,"KIOSK_P_Lineation" );
	if( VC_KIOSK_P_Lineation == NULL )
	{
		return false;
	}

	//Set the 417 bar code.
	VC_KIOSK_BarcodeSetPDF417 = ( KIOSK_BarcodeSetPDF417 )GetProcAddress( hKIOSKdll,"KIOSK_BarcodeSetPDF417" );
	if( VC_KIOSK_BarcodeSetPDF417 == NULL )
	{
		return false;
	}

	//Set the chinese font.
	VC_KIOSK_SetChineseFont = ( KIOSK_SetChineseFont )GetProcAddress( hKIOSKdll,"KIOSK_SetChineseFont" );
	if( VC_KIOSK_SetChineseFont == NULL )
	{
		return false;
	}

	//Set the presenter.
	VC_KIOSK_SetPresenter = ( KIOSK_SetPresenter )GetProcAddress( hKIOSKdll,"KIOSK_SetPresenter" );
	if( VC_KIOSK_SetPresenter == NULL )
	{
		return false;
	}

	//Set the bundler.
	VC_KIOSK_SetBundler = ( KIOSK_SetBundler )GetProcAddress( hKIOSKdll,"KIOSK_SetBundler" );
	if( VC_KIOSK_SetBundler == NULL )
	{
		return false;
	}

	//Set the action of bundler.
	VC_KIOSK_SetBundlerInfo = ( KIOSK_SetBundlerInfo )GetProcAddress( hKIOSKdll,"KIOSK_SetBundlerInfo" );
	if( VC_KIOSK_SetBundlerInfo == NULL )
	{
		return false;
	}

	VC_KIOSK_RTQueryStatusForT681 = (KIOSK_RTQueryStatusForT681)GetProcAddress(hKIOSKdll, "KIOSK_RTQueryStatusForT681");
	if (VC_KIOSK_RTQueryStatusForT681 == NULL)
	{
		return false;
	}
	//Query the real-time status of printer.
// 	VC_KIOSK_RTQueryStatus_T = ( KIOSK_RTQueryStatus_T )GetProcAddress( hKIOSKdll,"KIOSK_RTQueryStatus_T" );
// 	if( VC_KIOSK_RTQueryStatus_T == NULL )
// 	{
// 		return false;
// 	}

	//Automatic Status Back.
// 	VC_KIOSK_QueryASB_T = ( KIOSK_QueryASB_T )GetProcAddress( hKIOSKdll,"KIOSK_QueryASB_T" );
// 	if( VC_KIOSK_QueryASB_T == NULL )
// 	{
// 		return false;
// 	}
// 
// 	//Query the status of printer.
// 	VC_KIOSK_QueryStatus_T = ( KIOSK_QueryStatus_T )GetProcAddress( hKIOSKdll,"KIOSK_QueryStatus_T" );
// 	if( VC_KIOSK_QueryStatus_T == NULL )
// 	{
// 		return false;
// 	}
}

/************************************************************************************
  Function:       UnloadKioskdll()
  Description:    Unloading the KIOSKDLL.
  Return:         Returns True if successful, False if not successful.
************************************************************************************/
bool UnloadKioskdll( void )
{
	if( NULL == hKIOSKdll )
	{
		return false;
	}

	FreeLibrary( hKIOSKdll );
    hKIOSKdll = NULL;

	return true;
}