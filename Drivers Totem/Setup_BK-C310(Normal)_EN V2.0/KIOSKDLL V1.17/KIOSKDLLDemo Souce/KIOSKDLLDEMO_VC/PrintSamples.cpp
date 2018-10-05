#include "StdAfx.h"
#include "PrintSamples.h"

#include "LoadDLL.h"

extern bool bSaveToTxt;   //the sign of saving data to file.             
extern HANDLE g_hPort;    //port handle.
extern int nPortType;     //nPortType:0-serial port;1-LPT port;2-USB port;3-driver port.

//******************************************************************************
//Declare the functions of using.
//Serial port operation.
extern		KIOSK_OpenCom							VC_KIOSK_OpenCom;  
extern		KIOSK_SetComTimeOuts					VC_KIOSK_SetComTimeOuts;                
extern		KIOSK_CloseCom							VC_KIOSK_CloseCom;

//LPT operation.
extern		KIOSK_OpenLptByDrv						VC_KIOSK_OpenLptByDrv;
extern		KIOSK_CloseDrvLPT						VC_KIOSK_CloseDrvLPT;

//USB port operation.
extern		KIOSK_OpenUsb							VC_KIOSK_OpenUsb;
extern		KIOSK_OpenUsbByID						VC_KIOSK_OpenUsbByID;
extern		KIOSK_SetUsbTimeOuts					VC_KIOSK_SetUsbTimeOuts;
extern		KIOSK_CloseUsb							VC_KIOSK_CloseUsb;

//Driver port operation.
extern		KIOSK_OpenDrv							VC_KIOSK_OpenDrv;
extern		KIOSK_StartDoc							VC_KIOSK_StartDoc;
extern		KIOSK_EndDoc							VC_KIOSK_EndDoc;
extern		KIOSK_CloseDrv							VC_KIOSK_CloseDrv;

//Write or read data functions.
extern		KIOSK_WriteData							VC_KIOSK_WriteData;
extern		KIOSK_ReadData							VC_KIOSK_ReadData;

//Function functions.
extern      KIOSK_SendFile							VC_KIOSK_SendFile;
extern		KIOSK_BeginSaveToFile					VC_KIOSK_BeginSaveToFile;
extern		KIOSK_EndSaveToFile						VC_KIOSK_EndSaveToFile;
extern		KIOSK_QueryStatus						VC_KIOSK_QueryStatus;
extern		KIOSK_RTQueryStatus						VC_KIOSK_RTQueryStatus;
extern		KIOSK_QueryASB							VC_KIOSK_QueryASB;
extern		KIOSK_GetVersionInfo					VC_KIOSK_GetVersionInfo;

//Command functions.
extern		KIOSK_EnableMacro						VC_KIOSK_EnableMacro;
extern		KIOSK_Reset								VC_KIOSK_Reset;
extern		KIOSK_SetPaperMode						VC_KIOSK_SetPaperMode;
extern		KIOSK_SetMode							VC_KIOSK_SetMode;
extern		KIOSK_SetMotionUnit						VC_KIOSK_SetMotionUnit;
extern		KIOSK_SetLineSpacing					VC_KIOSK_SetLineSpacing;
extern		KIOSK_SetRightSpacing					VC_KIOSK_SetRightSpacing;
extern		KIOSK_SetOppositePosition				VC_KIOSK_SetOppositePosition;
extern		KIOSK_SetTabs							VC_KIOSK_SetTabs;
extern		KIOSK_ExecuteTabs						VC_KIOSK_ExecuteTabs;
extern		KIOSK_PreDownloadBmpToRAM				VC_KIOSK_PreDownloadBmpToRAM;
extern		KIOSK_PreDownloadBmpToFlash				VC_KIOSK_PreDownloadBmpToFlash;
extern		KIOSK_SetCharSetAndCodePage				VC_KIOSK_SetCharSetAndCodePage;
extern		KIOSK_FontUDChar						VC_KIOSK_FontUDChar;
extern		KIOSK_FeedLine							VC_KIOSK_FeedLine;
extern		KIOSK_FeedLines							VC_KIOSK_FeedLines;
extern		KIOSK_MarkerFeedPaper					VC_KIOSK_MarkerFeedPaper;
extern		KIOSK_CutPaper							VC_KIOSK_CutPaper;
extern		KIOSK_MarkerCutPaper					VC_KIOSK_CutPaper;

//Standard mode functions.
extern		KIOSK_S_SetLeftMarginAndAreaWidth		VC_KIOSK_S_SetLeftMarginAndAreaWidth;
extern		KIOSK_S_SetAlignMode					VC_KIOSK_S_SetAlignMode;
extern		KIOSK_S_Textout							VC_KIOSK_S_Textout;
extern		KIOSK_S_DownloadPrintBmp				VC_KIOSK_S_DownloadPrintBmp;
extern		KIOSK_S_PrintBmpInRAM					VC_KIOSK_S_PrintBmpInRAM;
extern		KIOSK_S_PrintBmpInFlash					VC_KIOSK_S_PrintBmpInFlash;
extern		KIOSK_S_PrintBarcode					VC_KIOSK_S_PrintBarcode;

//Page mode functions.
extern		KIOSK_P_SetAreaAndDirection				VC_KIOSK_P_SetAreaAndDirection;
extern		KIOSK_P_Textout							VC_KIOSK_P_Textout;
extern		KIOSK_P_DownloadPrintBmp				VC_KIOSK_P_DownloadPrintBmp;
extern		KIOSK_P_PrintBmpInRAM					VC_KIOSK_P_PrintBmpInRAM;
extern		KIOSK_P_PrintBmpInFlash					VC_KIOSK_P_PrintBmpInFlash;
extern		KIOSK_P_PrintBarcode					VC_KIOSK_P_PrintBarcode;
extern		KIOSK_P_Print							VC_KIOSK_P_Print;
extern		KIOSK_P_Clear							VC_KIOSK_P_Clear;

//Special functions.
extern		KIOSK_S_TestPrint						VC_KIOSK_S_TestPrint;
extern		KIOSK_CountMode							VC_KIOSK_CountMode;
extern		KIOSK_SetPrintFromStart					VC_KIOSK_SetPrintFromStart;
extern		KIOSK_SetRaster							VC_KIOSK_SetRaster;
extern		KIOSK_P_Lineation						VC_KIOSK_P_Lineation;
extern		KIOSK_BarcodeSetPDF417					VC_KIOSK_BarcodeSetPDF417;
extern		KIOSK_SetChineseFont					VC_KIOSK_SetChineseFont;
extern		KIOSK_SetPresenter						VC_KIOSK_SetPresenter;
extern		KIOSK_SetBundler						VC_KIOSK_SetPresenter;
extern		KIOSK_SetBundlerInfo					VC_KIOSK_SetBundlerInfo;


/******************************************************************************************************************************************
  Function:       PrintInStandardMode56_203DPI()
  Description:    print sample
  Calls:          VC_KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
				  VC_KIOSK_Reset()                       //Reset the printer.
				  VC_KIOSK_SetMode()                     //Set the mode of printing.
                  VC_KIOSK_SetMotionUnit()               //Set the units of motion.
                  VC_KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
                  VC_KIOSK_SetRightSpacing()             //Set the right spacing of character.
				  VC_KIOSK_SetLineSpacing()              //Set the spacing of lines.
				  VC_KIOSK_S_Textout()                   //Write one character string at the specified position.
				  VC_KIOSK_FeedLine()                    //Feed 1 line.
				  VC_KIOSK_FeedLines()                   //Feed paper forward.
				  VC_KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				  VC_KIOSK_S_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
				  VC_KIOSK_CutPaper()                    //Cut paper.
  Called By:      OnPrint()    
  Input:          g_hPort: port handle
                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
  Return:         Returns True if successful, False if not successful.
*******************************************************************************************************************************************/
BOOL PrintInStandardMode56_203DPI( HANDLE g_hPort, int nPortType )
{  
	static bool bIsFirst = true;

	//Download bit map.
	if( bIsFirst )
	{
		char * pBitImages[2];

		pBitImages[0] = "Kitty.bmp";
		pBitImages[1] = "Look.bmp";		

		//Pre-download a group of bit map to Flash by specifying it's ID.
		if( KIOSK_SUCCESS != VC_KIOSK_PreDownloadBmpToFlash( g_hPort, nPortType, pBitImages,2,2 ) )
		{
			return false;
		}

		bIsFirst = false;
	}

	/*Print setting.*/	
	VC_KIOSK_Reset( g_hPort,nPortType );
	
	VC_KIOSK_SetMode( g_hPort,nPortType, KIOSK_PRINT_MODE_STANDARD );
	
    VC_KIOSK_SetMotionUnit( g_hPort,nPortType, 180, 180 );
	
    VC_KIOSK_S_SetLeftMarginAndAreaWidth( g_hPort, nPortType, 0, 450 );
		
	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );
	
	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 95 );
	
	/*Text setting*/	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Microcom KIOSK Printer", 5, 2, 2,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 15 );
		
	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "-----------------------------------", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);
	
	VC_KIOSK_FeedLine( g_hPort,nPortType );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "-----------------------------------", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 2 );
	
	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Right Spacing", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "KIOSK Printer", 215, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 1 );
		
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Right Spacing", 5, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "KIOSK Printer", 215, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 2 );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Right Spacing", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "KIOSK Printer", 215, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLines( g_hPort, nPortType, 2 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 2 );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-NORMAL", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-BOLD", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType,"FONTSTYLE-UNDERLINE", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-UNDERLINE", 5, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );
	
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-REVERSE", 5, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );	

	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-90", 5, 1, 1, 	
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	VC_KIOSK_FeedLines( g_hPort, nPortType, 2 );
	
	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "-----------------------------------", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort, nPortType );	

	/*Bar code setting.*/	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Barcode - Code 128", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
	VC_KIOSK_S_PrintBarcode( g_hPort, nPortType, "{A*1234ABCDE*{C5678", 5, KIOSK_BARCODE_TYPE_CODE128,
	                         2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
    VC_KIOSK_S_Textout( g_hPort, nPortType, "-----------------------------------", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);
	
	VC_KIOSK_FeedLine( g_hPort, nPortType );

	/*Bit map setting.*/	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "---------------Logo1---------------", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );
	
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
	VC_KIOSK_S_PrintBmpInFlash( g_hPort, nPortType, 1, 50, KIOSK_BITMAP_PRINT_QUADRUPLE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );
		
	VC_KIOSK_S_Textout( g_hPort, nPortType, "---------------Logo2---------------", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
	VC_KIOSK_S_PrintBmpInFlash( g_hPort, nPortType, 2, 5, KIOSK_BITMAP_PRINT_QUADRUPLE );

	/*Print setting.*/
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
	VC_KIOSK_CutPaper( g_hPort, nPortType, 1, 0 );

	return true;
}

/******************************************************************************************************************************************
  Function:       PrintInPageMode56_203DPI()
  Description:    print sample
  Calls:          VC_KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
				  VC_KIOSK_Reset()                       //Reset the printer.
				  VC_KIOSK_SetMode()                     //Set the mode of printing.
                  VC_KIOSK_SetMotionUnit()               //Set the units of motion.
                  VC_KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
                  VC_KIOSK_P_Clear()                     //Clear the buffer.
				  VC_KIOSK_SetRightSpacing()             //Set the right spacing of character.
				  VC_KIOSK_SetLineSpacing()              //Set the spacing of lines.
				  VC_KIOSK_P_Textout()                   //Write one character string at the specified position.
				  VC_KIOSK_FeedLine()                    //Feed 1 line.
				  VC_KIOSK_FeedLines()                   //Feed paper forward.
				  VC_KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				  VC_KIOSK_P_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
				  VC_KIOSK_P_Clear()                     //Clear the buffer.
				  VC_KIOSK_CutPaper()                    //Cut paper.
  Called By:      OnPrint()    
  Input:          g_hPort: port handle
                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
  Return:         Returns True if successful, False if not successful.
*******************************************************************************************************************************************/
BOOL PrintInPageMode56_203DPI( HANDLE g_hPort, int nPortType )
{
	//Pre-download a bit map to RAM by specifying it's ID.
	if( VC_KIOSK_PreDownloadBmpToRAM( g_hPort, nPortType, "kitty.bmp",2,0 ) != KIOSK_SUCCESS ) 
	{
		return false;
	}
	VC_KIOSK_PreDownloadBmpToRAM( g_hPort, nPortType, "Look.bmp",2,1 ); 

	/*Print setting.*/	
	VC_KIOSK_Reset( g_hPort,nPortType );

	VC_KIOSK_SetMode( g_hPort, nPortType, KIOSK_PRINT_MODE_PAGE );

	VC_KIOSK_SetMotionUnit( g_hPort, nPortType, 180, 180 );
	
	VC_KIOSK_P_SetAreaAndDirection( g_hPort, nPortType, 5, 10, 450, 1200, KIOSK_AREA_LEFT_TO_RIGHT );

	//VC_KIOSK_P_Clear( g_hPort, nPortType );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

    VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 95 );

	/*Text setting*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "Microcom KIOSK Printer", 5, 80, 2, 2, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "-----------------------------------", 5, 120,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


	VC_KIOSK_P_Textout( g_hPort, nPortType, "-----------------------------------", 5, 140,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );
	
	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Right Spacing", 5, 180, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "KIOSK Printer", 215, 180, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType , 1 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Right Spacing", 5, 210, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "KIOSK Printer", 215, 210, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType , 2 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Right Spacing", 5, 240, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "KIOSK Printer", 215, 240, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 2 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-NORMAL", 5, 300, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-BOLD", 5, 330, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType,"FONTSTYLE-UNDERLINE", 5, 360, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-UNDERLINE", 5, 390, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-REVERSE", 5, 420, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	/*Bar code setting.*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "-------------------------------", 5, 460,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Barcode - Code 128", 5, 490, 1, 1, 
	                    KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_PrintBarcode( g_hPort, nPortType, "{A*1234ABCDE*{C5678", 5,560, KIOSK_BARCODE_TYPE_CODE128,
	                         2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );
	
	VC_KIOSK_P_Textout( g_hPort, nPortType, "-------------------------------", 5, 610,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	/*Bit map setting.*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "-------------Logo1-------------", 5, 630, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_PrintBmpInRAM( g_hPort, nPortType, 0, 5,  700, KIOSK_BITMAP_PRINT_QUADRUPLE);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "-------------Logo2-------------", 5, 720,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_PrintBmpInRAM( g_hPort, nPortType, 1, 5, 810, KIOSK_BITMAP_PRINT_QUADRUPLE);
	
	/*Print setting.*/
	VC_KIOSK_P_Print( g_hPort, nPortType );

	VC_KIOSK_P_Clear( g_hPort, nPortType );

	VC_KIOSK_CutPaper( g_hPort, nPortType, 1, 0 );

	return true;
}

/******************************************************************************************************************************************
  Function:       PrintInStandardMode56_300DPI()
  Description:    print sample
  Calls:          VC_KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
				  VC_KIOSK_Reset()                       //Reset the printer.
				  VC_KIOSK_SetMode()                     //Set the mode of printing.
                  VC_KIOSK_SetMotionUnit()               //Set the units of motion.
                  VC_KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
                  VC_KIOSK_SetRightSpacing()             //Set the right spacing of character.
				  VC_KIOSK_SetLineSpacing()              //Set the spacing of lines.
				  VC_KIOSK_S_Textout()                   //Write one character string at the specified position.
				  VC_KIOSK_FeedLine()                    //Feed 1 line.
				  VC_KIOSK_FeedLines()                   //Feed paper forward.
				  VC_KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				  VC_KIOSK_S_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
				  VC_KIOSK_CutPaper()                    //Cut paper.
  Called By:      OnPrint()    
  Input:          g_hPort: port handle
                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
  Return:         Returns True if successful, False if not successful.
*******************************************************************************************************************************************/
BOOL PrintInStandardMode56_300DPI( HANDLE g_hPort, int nPortType )
{
	static bool bIsFirst = true;

	//Download bit map.
	if( bIsFirst )
	{
		char * pBitImages[2];

		pBitImages[0] = "Kitty.bmp";
		pBitImages[1] = "Look.bmp";		

		//Pre-download a group of bit map to Flash by specifying it's ID.
		if( KIOSK_SUCCESS != VC_KIOSK_PreDownloadBmpToFlash( g_hPort, nPortType, pBitImages,2, 2 ) )
		{
 			return false;
		}

		bIsFirst = false;
	}

	/*Print setting.*/	
	VC_KIOSK_Reset( g_hPort,nPortType );
		
	VC_KIOSK_SetMode( g_hPort,nPortType, KIOSK_PRINT_MODE_STANDARD );
	
    VC_KIOSK_SetMotionUnit( g_hPort,nPortType, 180, 180 );

    VC_KIOSK_S_SetLeftMarginAndAreaWidth( g_hPort, nPortType, 0, 670 );
	
	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 95 );

	/*Text setting*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Microcom KIOSK Printer", 5, 2, 2,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 15 );
		
	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "-----------------------------------", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "-----------------------------------", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 2 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Right Spacing", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_S_Textout( g_hPort, nPortType, "KIOSK Printer", 215, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 1 ); 

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Right Spacing", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "KIOSK Printer", 215, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 2 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Right Spacing", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_S_Textout( g_hPort, nPortType, "KIOSK Printer", 215, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);
	
	VC_KIOSK_FeedLines( g_hPort, nPortType, 2 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 2 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-NORMAL", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-BOLD", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType,"FONTSTYLE-UNDERLINE", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-UNDERLINE", 5, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-REVERSE", 5, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-90", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	VC_KIOSK_FeedLines( g_hPort, nPortType, 2 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "-----------------------------------", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	/*Bar code setting.*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Barcode - Code 128", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine(g_hPort, nPortType );

	VC_KIOSK_S_PrintBarcode( g_hPort, nPortType, "{A*1234ABCDE*{C5678", 5, KIOSK_BARCODE_TYPE_CODE128,
	                         2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
    VC_KIOSK_S_Textout( g_hPort, nPortType, "-----------------------------------", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	/*Bit map setting.*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "---------------Logo1---------------", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_PrintBmpInFlash( g_hPort, nPortType, 1, 50, KIOSK_BITMAP_PRINT_QUADRUPLE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "---------------Logo2---------------", 5, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_PrintBmpInFlash( g_hPort, nPortType, 2, 50, KIOSK_BITMAP_PRINT_QUADRUPLE );

	/*Print setting.*/
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
	VC_KIOSK_CutPaper( g_hPort, nPortType, 1, 0 );

	return true;
}

/******************************************************************************************************************************************
  Function:       PrintInPageMode56_300DPI()
  Description:    print sample
  Calls:          VC_KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
				  VC_KIOSK_Reset()                       //Reset the printer.
				  VC_KIOSK_SetMode()                     //Set the mode of printing.
                  VC_KIOSK_SetMotionUnit()               //Set the units of motion.
                  VC_KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
                  VC_KIOSK_P_Clear()                     //Clear the buffer.
				  VC_KIOSK_SetRightSpacing()             //Set the right spacing of character.
				  VC_KIOSK_SetLineSpacing()              //Set the spacing of lines.
				  VC_KIOSK_P_Textout()                   //Write one character string at the specified position.
				  VC_KIOSK_FeedLine()                    //Feed 1 line.
				  VC_KIOSK_FeedLines()                   //Feed paper forward.
				  VC_KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				  VC_KIOSK_P_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
				  VC_KIOSK_P_Clear()                     //Clear the buffer.
				  VC_KIOSK_CutPaper()                    //Cut paper.
  Called By:      OnPrint()    
  Input:          g_hPort: port handle
                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
  Return:         Returns True if successful, False if not successful.
*******************************************************************************************************************************************/
BOOL PrintInPageMode56_300DPI( HANDLE g_hPort, int nPortType )
{
	//Pre-download a bit map to RAM by specifying it's ID.
	if( VC_KIOSK_PreDownloadBmpToRAM( g_hPort, nPortType, "kitty.bmp", 2,0 ) != KIOSK_SUCCESS ) 
	{
		return false;
	}
	VC_KIOSK_PreDownloadBmpToRAM( g_hPort, nPortType, "Look.bmp",2,1 ); 
	
	/*Print setting.*/	
	VC_KIOSK_Reset( g_hPort,nPortType );

	VC_KIOSK_SetMode( g_hPort, nPortType, KIOSK_PRINT_MODE_PAGE );

	VC_KIOSK_SetMotionUnit( g_hPort, nPortType, 180, 180 );
	
	VC_KIOSK_P_SetAreaAndDirection( g_hPort, nPortType, 5, 10, 670, 1200, KIOSK_AREA_LEFT_TO_RIGHT );

	//VC_KIOSK_P_Clear( g_hPort, nPortType );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

    VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 95 );

	/*Text setting*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "Microcom KIOSK Printer", 5, 80, 2, 2, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "-----------------------------------", 5, 120,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "-----------------------------------", 5, 140,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Right Spacing", 5, 180, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "KIOSK Printer", 215, 180, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType , 1 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Right Spacing", 5, 210, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "KIOSK Printer", 215, 210, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType , 2 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Right Spacing", 5, 240, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "KIOSK Printer", 215, 240, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 2 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-NORMAL", 5, 300, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-BOLD", 5, 330, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType,"FONTSTYLE-UNDERLINE", 5, 360, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-UNDERLINE", 5, 390, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-REVERSE", 5, 420, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "-------------------------------", 5, 460,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	/*Bar code setting.*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "Barcode - Code 128", 5, 490, 1, 1, 
	                    KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_PrintBarcode( g_hPort, nPortType, "{A*1234ABCDE*{C5678", 5,560, KIOSK_BARCODE_TYPE_CODE128,
	                         2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "-------------------------------", 5, 610,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	/*Bit map setting.*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "-------------Logo1-------------", 5, 630, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_PrintBmpInRAM( g_hPort, nPortType, 0, 5,  700, KIOSK_BITMAP_PRINT_QUADRUPLE);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "-------------Logo2-------------", 5, 720,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_PrintBmpInRAM( g_hPort, nPortType, 1, 5, 810, KIOSK_BITMAP_PRINT_QUADRUPLE);

	/*Print setting*/
	VC_KIOSK_P_Print( g_hPort, nPortType );

	VC_KIOSK_P_Clear( g_hPort, nPortType );

	VC_KIOSK_CutPaper( g_hPort, nPortType, 1, 0 );

	return true;
}

/******************************************************************************************************************************************
  Function:       PrintInStandardMode80_203DPI()
  Description:    print sample
  Calls:          VC_KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
				  VC_KIOSK_Reset()                       //Reset the printer.
				  VC_KIOSK_SetMode()                     //Set the mode of printing.
                  VC_KIOSK_SetMotionUnit()               //Set the units of motion.
                  VC_KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
                  VC_KIOSK_SetRightSpacing()             //Set the right spacing of character.
				  VC_KIOSK_SetLineSpacing()              //Set the spacing of lines.
				  VC_KIOSK_S_Textout()                   //Write one character string at the specified position.
				  VC_KIOSK_FeedLine()                    //Feed 1 line.
				  VC_KIOSK_FeedLines()                   //Feed paper forward.
				  VC_KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				  VC_KIOSK_S_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
				  VC_KIOSK_CutPaper()                    //Cut paper.
  Called By:      OnPrint()    
  Input:          g_hPort: port handle
                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
  Return:         Returns True if successful, False if not successful.
*******************************************************************************************************************************************/
BOOL PrintInStandardMode80_203DPI( HANDLE g_hPort, int nPortType )
{
	static bool bIsFirst = true;
	int rtn;

	//Download bit map.
 	if( bIsFirst )
 	{
		char * pBitImages[2];
 
		pBitImages[0] = "Kitty.bmp";
		pBitImages[1] = "Look.bmp";		

 		//Pre-download a group of bit map to Flash by specifying it's ID.
 		if( KIOSK_SUCCESS !=(rtn= VC_KIOSK_PreDownloadBmpToFlash( g_hPort, nPortType, pBitImages,2,2 )) )
 		{
 			return false;
 		}
 
		bIsFirst = false;
 	}

	/*Print setting.*/	
	VC_KIOSK_Reset( g_hPort,nPortType );
	
	VC_KIOSK_SetMode( g_hPort,nPortType, KIOSK_PRINT_MODE_STANDARD );
	
    VC_KIOSK_SetMotionUnit( g_hPort,nPortType, 203, 203 ) ;

    VC_KIOSK_S_SetLeftMarginAndAreaWidth( g_hPort, nPortType, 0, 640 );
	
	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 95 );

	/*Text setting*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Microcom KIOSK Printer", 125, 2, 2,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 24 );
		
	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "------------------------------------------", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "------------------------------------------", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 2 );
	
	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Right Spacing", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_S_Textout( g_hPort, nPortType, "KIOSK Printer", 330, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 2 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Right Spacing", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "KIOSK Printer", 330, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 4 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Right Spacing", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_S_Textout( g_hPort, nPortType, "KIOSK Printer", 330, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);
	
	VC_KIOSK_FeedLines( g_hPort, nPortType, 2);

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 2 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-NORMAL", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-BOLD", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType,"FONTSTYLE-UNDERLINE", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-UNDERLINE", 95, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-REVERSE", 95, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-90", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	VC_KIOSK_FeedLines( g_hPort, nPortType, 2 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "------------------------------------------", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	/*Bar code setting.*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Barcode - Code 128", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine(g_hPort, nPortType );

	VC_KIOSK_S_PrintBarcode( g_hPort, nPortType, "{A*1234ABCDE*{C5678", 95, KIOSK_BARCODE_TYPE_CODE128,
	                         2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	VC_KIOSK_FeedLine( g_hPort, nPortType );
  
	VC_KIOSK_S_Textout( g_hPort, nPortType, "------------------------------------------", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	/*Bit map setting.*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "------------------Logo 1------------------", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_PrintBmpInFlash( g_hPort, nPortType, 1, 100, KIOSK_BITMAP_PRINT_QUADRUPLE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "------------------Logo 2------------------", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_PrintBmpInFlash( g_hPort, nPortType, 2, 95, KIOSK_BITMAP_PRINT_QUADRUPLE );
	

	/*Print setting.*/
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	VC_KIOSK_FeedLine( g_hPort, nPortType );

	
	VC_KIOSK_CutPaper( g_hPort, nPortType, 1, 0 );

	return true;
}

/******************************************************************************************************************************************
  Function:       PrintInPageMode80_203DPI()
  Description:    print sample
  Calls:          VC_KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
				  VC_KIOSK_Reset()                       //Reset the printer.
				  VC_KIOSK_SetMode()                     //Set the mode of printing.
                  VC_KIOSK_SetMotionUnit()               //Set the units of motion.
                  VC_KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
                  VC_KIOSK_P_Clear()                     //Clear the buffer.
				  VC_KIOSK_SetRightSpacing()             //Set the right spacing of character.
				  VC_KIOSK_SetLineSpacing()              //Set the spacing of lines.
				  VC_KIOSK_P_Textout()                   //Write one character string at the specified position.
				  VC_KIOSK_FeedLine()                    //Feed 1 line.
				  VC_KIOSK_FeedLines()                   //Feed paper forward.
				  VC_KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				  VC_KIOSK_P_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
				  VC_KIOSK_P_Clear()                     //Clear the buffer.
				  VC_KIOSK_CutPaper()                    //Cut paper.
  Called By:      OnPrint()    
  Input:          g_hPort: port handle
                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
  Return:         Returns True if successful, False if not successful.
*******************************************************************************************************************************************/
BOOL PrintInPageMode80_203DPI( HANDLE g_hPort, int nPortType )
{
	//Pre-download a bit map to RAM by specifying it's ID.
	/*if( VC_KIOSK_PreDownloadBmpToRAM( g_hPort, nPortType, "F:\\Kitty.bmp", 2,0 ) != KIOSK_SUCCESS ) 
	{
		return false;
	}

	if(VC_KIOSK_PreDownloadBmpToRAM( g_hPort, nPortType, "F:\\Look.bmp", 2,1 ) != KIOSK_SUCCESS)
	{

		return false;
	}*/

	/*Print setting.*/
	VC_KIOSK_Reset( g_hPort,nPortType );

	VC_KIOSK_SetMode( g_hPort, nPortType, KIOSK_PRINT_MODE_PAGE );

	VC_KIOSK_SetMotionUnit( g_hPort, nPortType, 203, 203 );
	
	VC_KIOSK_P_SetAreaAndDirection( g_hPort, nPortType, 0, 10, 640, 1200, KIOSK_AREA_LEFT_TO_RIGHT );

	//VC_KIOSK_P_Clear( g_hPort, nPortType );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	/*Text setting*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "Microcom KIOSK Printer", 125, 80, 2, 2, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "------------------------------------------", 95, 120,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "------------------------------------------", 95, 140,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Right Spacing", 95, 180, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "KIOSK Printer", 330, 180, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType , 2 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Right Spacing", 95, 210, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "KIOSKPrinter", 330, 210, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType , 4 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Right Spacing", 95, 240, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "KIOSK Printer", 330, 240, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 2 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-NORMAL", 95, 300, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL ); 

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-BOLD", 95, 330, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType,"FONTSTYLE-UNDERLINE", 95, 360, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-UNDERLINE", 95, 390, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-REVERSE", 95, 420, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "------------------------------------", 95, 480,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	/*Bar code setting.*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "Barcode - Code 128", 95, 505, 1, 1, 
	                    KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_PrintBarcode( g_hPort, nPortType, "{A*1234ABCDE*{C5678", 95,580, KIOSK_BARCODE_TYPE_CODE128,
 	                         2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );
	
	VC_KIOSK_P_Textout( g_hPort, nPortType, "------------------------------------", 95, 630,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	/*Bit map setting.*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "---------------Logo 1---------------", 95, 650, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_PrintBmpInRAM( g_hPort, nPortType, 0, 95,  720, KIOSK_BITMAP_PRINT_QUADRUPLE);
	
	VC_KIOSK_P_Textout( g_hPort, nPortType, "---------------Logo 2---------------", 95, 740,1, 1, 
		KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );
	
	VC_KIOSK_P_PrintBmpInRAM( g_hPort, nPortType, 1, 95, 830, KIOSK_BITMAP_PRINT_QUADRUPLE);	

	/*Print setting.*/
	VC_KIOSK_P_Print( g_hPort, nPortType );

	VC_KIOSK_P_Clear( g_hPort, nPortType );

	VC_KIOSK_CutPaper( g_hPort, nPortType, 1, 0 );

	return true;
}

/******************************************************************************************************************************************
  Function:       PrintInStandardMode80_300DPI()
  Description:    print sample
  Calls:          VC_KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
				  VC_KIOSK_Reset()                       //Reset the printer.
				  VC_KIOSK_SetMode()                     //Set the mode of printing.
                  VC_KIOSK_SetMotionUnit()               //Set the units of motion.
                  VC_KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
                  VC_KIOSK_SetRightSpacing()             //Set the right spacing of character.
				  VC_KIOSK_SetLineSpacing()              //Set the spacing of lines.
				  VC_KIOSK_S_Textout()                   //Write one character string at the specified position.
				  VC_KIOSK_FeedLine()                    //Feed 1 line.
				  VC_KIOSK_FeedLines()                   //Feed paper forward.
				  VC_KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				  VC_KIOSK_S_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
				  VC_KIOSK_CutPaper()                    //Cut paper.
  Called By:      OnPrint()    
  Input:          g_hPort: port handle
                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
  Return:         Returns True if successful, False if not successful.
*******************************************************************************************************************************************/
BOOL PrintInStandardMode80_300DPI( HANDLE g_hPort, int nPortType )
{
	static bool bIsFirst = true;

	//Download bit map.
	if( bIsFirst )
	{		
		char * pBitImages[2];

		pBitImages[0] = "Kitty.bmp";
		pBitImages[1] = "Look.bmp";		

		//Pre-download a group of bit map to Flash by specifying it's ID.
		if( KIOSK_SUCCESS != VC_KIOSK_PreDownloadBmpToFlash( g_hPort, nPortType, pBitImages,2,2 ) )
		{
			return false;
		}

		bIsFirst = false;
	}

	/*Print setting.*/	
	VC_KIOSK_Reset( g_hPort,nPortType );
		
	VC_KIOSK_SetMode( g_hPort,nPortType, KIOSK_PRINT_MODE_STANDARD );
	
	VC_KIOSK_SetMotionUnit( g_hPort,nPortType, 203, 203 );

    VC_KIOSK_S_SetLeftMarginAndAreaWidth( g_hPort, nPortType, 0, 640 );
	
	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 95 );

	/*Text setting*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Microcom KIOSK Printer", 125, 2, 2,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 24 );
		
	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "------------------------------------------", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "------------------------------------------", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 2 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Right Spacing", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_S_Textout( g_hPort, nPortType, "KIOSK Printer", 330, 1, 1, 
		                KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 2 ); 

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Right Spacing", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );
	
	VC_KIOSK_S_Textout( g_hPort, nPortType, "KIOSK Printer", 330, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 4 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Right Spacing", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_S_Textout( g_hPort, nPortType, "KIOSK Printer", 330, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);
	
	VC_KIOSK_FeedLines( g_hPort, nPortType, 2);

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 2 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-NORMAL", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-BOLD", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType,"FONTSTYLE-UNDERLINE", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-UNDERLINE", 95, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-REVERSE", 95, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "FONTSTYLE-90", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	VC_KIOSK_FeedLines( g_hPort, nPortType, 2 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "------------------------------------------", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	/*Bar code setting.*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Barcode - Code 128", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine(g_hPort, nPortType );

	VC_KIOSK_S_PrintBarcode( g_hPort, nPortType, "{A*1234ABCDE*{C5678", 95, KIOSK_BARCODE_TYPE_CODE128,
		                     2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "------------------------------------------", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);	

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	/*Bit map setting.*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "------------------Logo 1------------------", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_PrintBmpInFlash( g_hPort, nPortType, 1, 100, KIOSK_BITMAP_PRINT_QUADRUPLE );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "------------------Logo 2------------------", 95, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_PrintBmpInFlash( g_hPort, nPortType, 2, 95, KIOSK_BITMAP_PRINT_QUADRUPLE );

	/*Print setting*/
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	VC_KIOSK_FeedLine( g_hPort, nPortType );
	
	VC_KIOSK_CutPaper( g_hPort, nPortType, 1, 0 );

	return TRUE;
}

/******************************************************************************************************************************************
  Function:       PrintInPageMode80_300DPI()
  Description:    print sample
  Calls:          VC_KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
				  VC_KIOSK_Reset()                       //Reset the printer.
				  VC_KIOSK_SetMode()                     //Set the mode of printing.
                  VC_KIOSK_SetMotionUnit()               //Set the units of motion.
                  VC_KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
                  VC_KIOSK_P_Clear()                     //Clear the buffer.
				  VC_KIOSK_SetRightSpacing()             //Set the right spacing of character.
				  VC_KIOSK_SetLineSpacing()              //Set the spacing of lines.
				  VC_KIOSK_P_Textout()                   //Write one character string at the specified position.
				  VC_KIOSK_FeedLine()                    //Feed 1 line.
				  VC_KIOSK_FeedLines()                   //Feed paper forward.
				  VC_KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				  VC_KIOSK_P_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
				  VC_KIOSK_P_Clear()                     //Clear the buffer.
				  VC_KIOSK_CutPaper()                    //Cut paper.
  Called By:      OnPrint()    
  Input:          g_hPort: port handle
                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
  Return:         Returns True if successful, False if not successful.
*******************************************************************************************************************************************/
BOOL PrintInPageMode80_300DPI( HANDLE g_hPort, int nPortType )
{
	//Pre-download a bit map to RAM by specifying it's ID.
	if( VC_KIOSK_PreDownloadBmpToRAM( g_hPort, nPortType, "F:\\Kitty.bmp",2, 0 ) != KIOSK_SUCCESS ) 
	{
		return false;
	}

	VC_KIOSK_PreDownloadBmpToRAM( g_hPort, nPortType, "F:\\Look.bmp", 2,1 ); 

	/*Print setting.*/	
	VC_KIOSK_Reset( g_hPort,nPortType );

	VC_KIOSK_SetMode( g_hPort, nPortType, KIOSK_PRINT_MODE_PAGE );

	VC_KIOSK_SetMotionUnit( g_hPort, nPortType, 203, 203 );
	
	VC_KIOSK_P_SetAreaAndDirection( g_hPort, nPortType, 0, 10, 640, 1200, KIOSK_AREA_LEFT_TO_RIGHT );

	//VC_KIOSK_P_Clear( g_hPort, nPortType );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	/*Text setting*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "Microcom KIOSK Printer", 125, 80, 2, 2, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "------------------------------------------", 95, 120,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "------------------------------------------", 95, 140,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Right Spacing", 95, 180, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "KIOSK Printer", 330, 180, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType , 2 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Right Spacing", 95, 210, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "KIOSKPrinter", 330, 210, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType , 4 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Right Spacing", 95, 240, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "KIOSK Printer", 330, 240, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 2 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-NORMAL", 95, 300, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-BOLD", 95, 330, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType,"FONTSTYLE-UNDERLINE", 95, 360, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-UNDERLINE", 95, 390, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "FONTSTYLE-REVERSE", 95, 420, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "------------------------------------", 95, 480,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	/*Bar code setting.*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "Barcode - Code 128", 95, 505, 1, 1, 
	                    KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_PrintBarcode( g_hPort, nPortType, "{A*1234ABCDE*{C5678", 95,580, KIOSK_BARCODE_TYPE_CODE128,
	                         2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );	
	
	VC_KIOSK_P_Textout( g_hPort, nPortType, "------------------------------------", 95, 630,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	/*Bit map setting.*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "---------------Logo 1---------------", 95, 650, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_PrintBmpInRAM( g_hPort, nPortType, 0, 95,  720, KIOSK_BITMAP_PRINT_QUADRUPLE);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "---------------Logo 2---------------", 95, 740,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_PrintBmpInRAM( g_hPort, nPortType, 1, 95, 830, KIOSK_BITMAP_PRINT_QUADRUPLE);

	/*Print setting.*/
	VC_KIOSK_P_Print( g_hPort, nPortType );

	VC_KIOSK_P_Clear( g_hPort, nPortType );

	VC_KIOSK_CutPaper( g_hPort, nPortType, 1, 0 );

	return true;
}

/******************************************************************************************************************************************
  Function:       PrintInStandardMode210_203DPI()
  Description:    print sample
  Calls:          VC_KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
				  VC_KIOSK_Reset()                       //Reset the printer.
				  VC_KIOSK_SetMode()                     //Set the mode of printing.
                  VC_KIOSK_SetMotionUnit()               //Set the units of motion.
                  VC_KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
                  VC_KIOSK_SetRightSpacing()             //Set the right spacing of character.
				  VC_KIOSK_SetLineSpacing()              //Set the spacing of lines.
				  VC_KIOSK_S_Textout()                   //Write one character string at the specified position.
				  VC_KIOSK_FeedLine()                    //Feed 1 line.
				  VC_KIOSK_FeedLines()                   //Feed paper forward.
				  VC_KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				  VC_KIOSK_S_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
				  VC_KIOSK_CutPaper()                    //Cut paper.
  Called By:      OnPrint()    
  Input:          g_hPort: port handle
                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
  Return:         Returns True if successful, False if not successful.
*******************************************************************************************************************************************/
BOOL PrintInStandardMode210_203DPI( HANDLE g_hPort, int nPortType )
{
	static bool bIsFirst = true;

	//Download bit map.
	if( bIsFirst )
	{
		char * pBitImages[1];

		pBitImages[0] = "Map.bmp";

		//Pre-download a group of bit map to Flash by specifying it's ID.
		if( KIOSK_SUCCESS != VC_KIOSK_PreDownloadBmpToFlash( g_hPort, nPortType, pBitImages, 2,1 ) )
		{
			return false;
		}

		bIsFirst = false;
	}

	/*Print setting.*/	
	VC_KIOSK_Reset( g_hPort,nPortType );
	
	VC_KIOSK_SetMode( g_hPort,nPortType, KIOSK_PRINT_MODE_STANDARD );
	
	VC_KIOSK_SetMotionUnit( g_hPort,nPortType, 203, 203 );

    VC_KIOSK_S_SetLeftMarginAndAreaWidth( g_hPort, nPortType, 100, 1500 );
	
	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 20 );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 2 );

	/*Text setting*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Microcom", 0, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Microcom Corporation", 800, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 20 );

	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "-----------------------------------------------------------------------------------------------------------------------------", 
	                    0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort,nPortType );
	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Microcom KIOSK Printer", 500, 3, 3,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 5 );
	
	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 40 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "  In order to providing the user who use the KIOSK printer to carry on two of developments, KIOSKDLL were developed by the Microcom Corporation", 
	                    0, 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 1 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "  We supply this sample to show our KIOSKDLL's function. You can also rewoke the resident sample by yourself.", 
	                    0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );
	
    VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 15 );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 4 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Support port:", 0, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "COM", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "LPT", 800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 2 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "USB", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Driver", 800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Support system:", 0, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Windows 2000", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Windows 2003", 800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

    VC_KIOSK_FeedLines( g_hPort,nPortType , 2 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Windows XP", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Windows Vista", 800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Support bar code:", 0, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "UPC-A", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "UPC-E", 800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "JAN13", 1200, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_FeedLine( g_hPort,nPortType );
	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "JAN8", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "CODE39", 800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "ITF", 1200, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_FeedLine( g_hPort,nPortType );
	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "CODEBAR", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "CODE93", 800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "CODE128", 1200, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 2 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "PDF417", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

    VC_KIOSK_S_Textout( g_hPort, nPortType, "Support equipment:", 0, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "814M", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

	/*Bit map setting.*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Print   Bitmap:", 0, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_PrintBmpInFlash( g_hPort, nPortType, 1, 500, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

	/*Bar code setting.*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Print   Bar Code:", 0, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

    VC_KIOSK_S_Textout( g_hPort, nPortType, "Barcode - Code 128", 440, 2, 1, 
		                KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort, nPortType );
	VC_KIOSK_FeedLine( g_hPort, nPortType );

	VC_KIOSK_S_PrintBarcode( g_hPort, nPortType, "{A*1234ABCDE*{C5678", 440, KIOSK_BARCODE_TYPE_CODE128,
	                         3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "-----------------------------------------------------------------------------------------------------------------------------", 
	                    0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "YOUR THERMAL PRINTER PARTNER", 800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	/*Print setting.*/
	VC_KIOSK_FeedLine( g_hPort,nPortType );
	VC_KIOSK_FeedLine( g_hPort,nPortType );
	VC_KIOSK_FeedLine( g_hPort,nPortType );
	VC_KIOSK_FeedLine( g_hPort,nPortType );	
	
	VC_KIOSK_CutPaper( g_hPort, nPortType, 1, 0 );

	return true;
}

/******************************************************************************************************************************************
  Function:       PrintInPageMode210_203DPI()
  Description:    print sample
  Calls:          VC_KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
				  VC_KIOSK_Reset()                       //Reset the printer.
				  VC_KIOSK_SetMode()                     //Set the mode of printing.
                  VC_KIOSK_SetMotionUnit()               //Set the units of motion.
                  VC_KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
                  VC_KIOSK_P_Clear()                     //Clear the buffer.
				  VC_KIOSK_SetRightSpacing()             //Set the right spacing of character.
				  VC_KIOSK_SetLineSpacing()              //Set the spacing of lines.
				  VC_KIOSK_P_Textout()                   //Write one character string at the specified position.
				  VC_KIOSK_FeedLine()                    //Feed 1 line.
				  VC_KIOSK_FeedLines()                   //Feed paper forward.
				  VC_KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				  VC_KIOSK_P_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
				  VC_KIOSK_P_Clear()                     //Clear the buffer.
				  VC_KIOSK_CutPaper()                    //Cut paper.
  Called By:      OnPrint()    
  Input:          g_hPort: port handle
                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
  Return:         Returns True if successful, False if not successful.
*******************************************************************************************************************************************/
BOOL PrintInPageMode210_203DPI( HANDLE g_hPort, int nPortType )
{
	//Pre-download a bit map to RAM by specifying it's ID.
	if( VC_KIOSK_PreDownloadBmpToRAM( g_hPort, nPortType, "F:\\Map.bmp",2,0 ) != KIOSK_SUCCESS )
	{
		return false;
	}

	/*Print setting.*/	
	VC_KIOSK_Reset( g_hPort,nPortType );

	VC_KIOSK_SetMode( g_hPort, nPortType, KIOSK_PRINT_MODE_PAGE );

	VC_KIOSK_SetMotionUnit( g_hPort, nPortType, 203, 203 );
	
	VC_KIOSK_P_SetAreaAndDirection( g_hPort, nPortType, 95, 0, 1500, 2400, KIOSK_AREA_LEFT_TO_RIGHT );

	//VC_KIOSK_P_Clear( g_hPort, nPortType );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	/*Text setting*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "Microcom", 0, 100, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Microcom Corporation", 800, 100,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);
	
	VC_KIOSK_P_Textout( g_hPort, nPortType, "-----------------------------------------------------------------------------------------------------------------------------", 
	                    0, 150,1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Microcom KIOSK Printer", 500, 250, 3, 3, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 40 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "  In order to providing the user who use the KIOSK printer to carry on two of developments, KIOSKDLL were developed by the Microcom Corporation", 
	                    0, 350 , 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "  We supply this sample to show our KIOSKDLL's function. You can also rewoke the resident sample by yourself.", 
	                    0, 500, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 15 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Support port:", 0, 630, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "COM", 440, 630, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "LPT", 800, 630, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "USB", 440, 660, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Driver", 800, 660, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Support system:", 0, 730, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Windows 2000",	440, 730, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Windows 2003", 800, 730, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Windows XP", 440, 760, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Windows Vista", 800, 760, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Support bar code:", 0, 820, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "UPC-A", 440, 820, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "UPC-E", 800, 820, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "JAN13", 1200, 820, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "JAN8", 440, 865, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "CODE39", 800, 865, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "ITF", 1200, 865, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "CODEBAR", 440, 910, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "CODE93", 800, 910, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "CODE128", 1200,910, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "PDF417", 440, 955, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

    VC_KIOSK_P_Textout( g_hPort, nPortType, "Support equipment:", 0, 1020, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "814M", 440, 1020, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	/*Bit map setting.*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "Print   Bitmap:", 0, 1280, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_PrintBmpInRAM( g_hPort, nPortType, 0, 500, 1380, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );

	/*Bar code setting.*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "Print   Bar Code:", 0, 1440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

    VC_KIOSK_P_Textout( g_hPort, nPortType, "Barcode - Code 128", 440, 1440, 2, 1, 
		                KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_P_PrintBarcode( g_hPort, nPortType, "{A*1234ABCDE*{C5678", 440, 1555,  KIOSK_BARCODE_TYPE_CODE128,
	                         3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "-----------------------------------------------------------------------------------------------------------------------------", 
	                    0, 1630, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "YOUR THERMAL PRINTER PARTNER", 800, 1645, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	/*Print setting.*/
	VC_KIOSK_P_Print( g_hPort, nPortType );

	VC_KIOSK_P_Clear( g_hPort, nPortType );

	
	VC_KIOSK_CutPaper( g_hPort, nPortType, 0, 0 );

	return true;
}

/******************************************************************************************************************************************
  Function:       PrintInStandardMode210_300DPI()
  Description:    print sample
  Calls:          VC_KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
				  VC_KIOSK_Reset()                       //Reset the printer.
				  VC_KIOSK_SetMode()                     //Set the mode of printing.
                  VC_KIOSK_SetMotionUnit()               //Set the units of motion.
                  VC_KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
                  VC_KIOSK_SetRightSpacing()             //Set the right spacing of character.
				  VC_KIOSK_SetLineSpacing()              //Set the spacing of lines.
				  VC_KIOSK_S_Textout()                   //Write one character string at the specified position.
				  VC_KIOSK_FeedLine()                    //Feed 1 line.
				  VC_KIOSK_FeedLines()                   //Feed paper forward.
				  VC_KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				  VC_KIOSK_S_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
				  VC_KIOSK_CutPaper()                    //Cut paper.
  Called By:      OnPrint()    
  Input:          g_hPort: port handle
                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
  Return:         Returns True if successful, False if not successful.
*******************************************************************************************************************************************/
BOOL PrintInStandardMode210_300DPI( HANDLE g_hPort, int nPortType )
{
	static bool bIsFirst = true;

	//Download bit map.
	if( bIsFirst )
	{
		char * pBitImages[1];

		pBitImages[0] = "Map.bmp";

		//Pre-download a group of bit map to Flash by specifying it's ID.
		if( KIOSK_SUCCESS != VC_KIOSK_PreDownloadBmpToFlash( g_hPort, nPortType, pBitImages,2, 1 ) )
		{
			return false;
		}

		bIsFirst = false;
	}

	/*Print setting.*/	
	VC_KIOSK_Reset( g_hPort,nPortType );
	
	VC_KIOSK_SetMode( g_hPort,nPortType, KIOSK_PRINT_MODE_STANDARD );
	
	VC_KIOSK_SetMotionUnit( g_hPort,nPortType, 203, 203 );

    VC_KIOSK_S_SetLeftMarginAndAreaWidth( g_hPort, nPortType, 100, 1500 );
	
	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 20 );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 2 );

    /*Text setting*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Microcom", 0, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Microcom Corporation", 950, 1, 1,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 20 );

	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------", 
	                    0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort,nPortType );
	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Microcom KIOSK Printer", 500, 3, 3,
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );
	
	VC_KIOSK_FeedLines( g_hPort,nPortType, 5 );
	
	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 40 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "  In order to providing the user who use the KIOSK printer to carry on two of developments, KIOSKDLL were developed by the Microcom Corporation", 
	                    0, 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 1 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "  We supply this sample to show our KIOSKDLL's function. You can also rewoke the resident sample by yourself.", 
	                    0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 15 );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 4 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Support port:", 0, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "COM", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "LPT", 800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 2 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "USB", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Driver", 800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Support system:", 0, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Windows 2000", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Windows 2003",	800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

    VC_KIOSK_FeedLines( g_hPort,nPortType , 2 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Windows XP", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Windows Vista", 800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "Support bar code:", 0, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "UPC-A", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "UPC-E", 800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "JAN13", 1200, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_FeedLine( g_hPort,nPortType );
	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "JAN8",	440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "CODE39", 800, 2, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "ITF", 1200, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_FeedLine( g_hPort,nPortType );
	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "CODEBAR", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "CODE93", 800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "CODE128", 1200, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 2 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "PDF417", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

    VC_KIOSK_S_Textout( g_hPort, nPortType, "Support equipment:", 0, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "814M", 440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 2 );

	/*Bit map setting.*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Print   Bitmap:", 0, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_PrintBmpInFlash( g_hPort, nPortType, 1, 500, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

	/*Bar code setting.*/
	VC_KIOSK_S_Textout( g_hPort, nPortType, "Print   Bar Code:", 0, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

    VC_KIOSK_S_Textout( g_hPort, nPortType, "Barcode - Code 128", 440, 2, 1, 
		                KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine(g_hPort, nPortType );

	VC_KIOSK_S_PrintBarcode( g_hPort, nPortType, "{A*1234ABCDE*{C5678", 440, KIOSK_BARCODE_TYPE_CODE128,
	                         3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	VC_KIOSK_FeedLines( g_hPort,nPortType, 3 );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------", 
	                    0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_FeedLine( g_hPort,nPortType );

	VC_KIOSK_S_Textout( g_hPort, nPortType, "YOUR THERMAL PRINTER PARTNER",	800, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	/*Print setting*/
	VC_KIOSK_FeedLine( g_hPort,nPortType );
	VC_KIOSK_FeedLine( g_hPort,nPortType );
	VC_KIOSK_FeedLine( g_hPort,nPortType );
	VC_KIOSK_FeedLine( g_hPort,nPortType );	
	
	VC_KIOSK_CutPaper( g_hPort, nPortType, 1, 0 );

	return true;
}

/******************************************************************************************************************************************
  Function:       PrintInPageMode210_300DPI()
  Description:    print sample
  Calls:          VC_KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit map to Flash by specifying it's ID.
				  VC_KIOSK_Reset()                       //Reset the printer.
				  VC_KIOSK_SetMode()                     //Set the mode of printing.
                  VC_KIOSK_SetMotionUnit()               //Set the units of motion.
                  VC_KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
                  VC_KIOSK_P_Clear()                     //Clear the buffer.
				  VC_KIOSK_SetRightSpacing()             //Set the right spacing of character.
				  VC_KIOSK_SetLineSpacing()              //Set the spacing of lines.
				  VC_KIOSK_P_Textout()                   //Write one character string at the specified position.
				  VC_KIOSK_FeedLine()                    //Feed 1 line.
				  VC_KIOSK_FeedLines()                   //Feed paper forward.
				  VC_KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				  VC_KIOSK_P_PrintBmpInFlash()           //Print a bit map in Flash by specifying it's ID.
				  VC_KIOSK_P_Clear()                     //Clear the buffer.
				  VC_KIOSK_CutPaper()                    //Cut paper.
  Called By:      OnPrint()    
  Input:          g_hPort: port handle
                  nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
  Return:         Returns True if successful, False if not successful.
*******************************************************************************************************************************************/
BOOL PrintInPageMode210_300DPI( HANDLE g_hPort, int nPortType )
{
	//Pre-download a bit map to RAM by specifying it's ID.
	if( VC_KIOSK_PreDownloadBmpToRAM( g_hPort, nPortType, "Map.bmp",2, 0 ) != KIOSK_SUCCESS ) 
	{
		return false;
	}

	/*Print setting.*/
	VC_KIOSK_Reset( g_hPort,nPortType );

	VC_KIOSK_SetMode( g_hPort, nPortType, KIOSK_PRINT_MODE_PAGE );

	VC_KIOSK_SetMotionUnit( g_hPort, nPortType, 203, 203 );
	
	VC_KIOSK_P_SetAreaAndDirection( g_hPort, nPortType, 95, 0, 1500, 2400, KIOSK_AREA_LEFT_TO_RIGHT );

	//VC_KIOSK_P_Clear( g_hPort, nPortType );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	/*Text setting*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "Microcom", 0, 100, 1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Microcom Corporation", 950, 100,1, 1, 
	                    KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);
	
	VC_KIOSK_P_Textout( g_hPort, nPortType, "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------", 
	                    0, 150,1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Microcom KIOSK Printer", 500, 250,3, 3, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 40 );

	VC_KIOSK_SetRightSpacing( g_hPort, nPortType, 0 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "  In order to providing the user who use the KIOSK printer to carry on two of developments, KIOSKDLL were developed by the Microcom Corporation", 
	                    0, 350 , 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "  We supply this sample to show our KIOSKDLL's function. You can also rewoke the resident sample by yourself.", 
	                    0, 500, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_SetLineSpacing( g_hPort, nPortType, 15 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Support port:", 0, 630, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "COM", 440, 630, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "LPT", 800, 630, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "USB", 440, 660, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Driver", 800, 660, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Support system:", 0, 730, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Windows 2000", 440, 730, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Windows 2003", 800, 730, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Windows XP", 440, 760, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Windows Vista", 800, 760, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "Support bar code:", 0, 820, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "UPC-A", 440, 820, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "UPC-E", 800, 820, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "JAN13", 1200, 820, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "JAN8", 440, 865, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "CODE39", 800, 865, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "ITF", 1200, 865, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "CODEBAR", 440, 910, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "CODE93", 800, 910, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "CODE128", 1200,910, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "PDF417", 440, 955, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

    VC_KIOSK_P_Textout( g_hPort, nPortType, "Support equipment:", 0, 1020, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "814M", 440, 1020, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	/*Bit map setting.*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "Print   Bitmap:", 0, 1280, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	VC_KIOSK_P_PrintBmpInRAM( g_hPort, nPortType, 0, 500, 1380, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );

	/*Bar code setting.*/
	VC_KIOSK_P_Textout( g_hPort, nPortType, "Print   Bar Code:", 0, 1440, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

    VC_KIOSK_P_Textout( g_hPort, nPortType, "Barcode - Code 128", 440, 1440, 2, 1, 
		                KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_P_PrintBarcode( g_hPort, nPortType, "{A*1234ABCDE*{C5678", 440, 1555,  KIOSK_BARCODE_TYPE_CODE128,
	                         3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	VC_KIOSK_P_Textout( g_hPort, nPortType, "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------", 
	                    0, 1630, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	VC_KIOSK_P_Textout( g_hPort, nPortType, "YOUR THERMAL PRINTER PARTNER", 800, 1645, 2, 1, 
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	/*Print setting.*/
	VC_KIOSK_P_Print( g_hPort, nPortType );

	VC_KIOSK_P_Clear( g_hPort, nPortType );

	
	VC_KIOSK_CutPaper( g_hPort, nPortType, 0, 0 );

	return true;
}


