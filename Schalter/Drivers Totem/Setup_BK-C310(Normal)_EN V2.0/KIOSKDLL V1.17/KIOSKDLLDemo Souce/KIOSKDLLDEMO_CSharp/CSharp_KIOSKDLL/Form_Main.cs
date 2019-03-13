using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

using System.Runtime.InteropServices;
using System.Drawing.Printing;
using System.Threading;

namespace CSharp_KIOSKDLL
{
    public partial class Form_Main : Form
    {
        public Form_Main()
        {
            InitializeComponent();
        }

        //Port type
        private const int PORT_TYPE_COM = 0x00;
        private const int PORT_TYPE_LPT = 0x01;
        private const int PORT_TYPE_USB = 0x02;
        private const int PORT_TYPE_DRV = 0x03;

        //Print mode
        private const int PRINT_MODE_STANDRAD = 0x00;
        private const int PRINT_MODE_PAGE = 0x01;

        //Page width
        private const int PAGE_WDITH_56 = 0x00;
        private const int PAGE_WDITH_80 = 0x01;
        private const int PAGE_WDITH_210 = 0x02;

        //Printer resolution
        private const int RESOLUTION_203_DPI = 0x00;
        private const int RESOLUTION_300_DPI = 0x01;

        //Presenter or bundler
        private const int PAPER_OUT_PRESENTER = 0x00;
        private const int PAPER_OUT_BUNDLER = 0x01;

        //Presenter mode
        private const int PRESENTER_RETRACT = 0x00;
        private const int PRESENTER_FORWARD = 0x01;
        private const int PRESENTER_HOLD = 0x02;

        //Bundler mode
        private const int BUNDLER_RETRACT = 0x00;
        private const int BUNDLER_PRESENT = 0x01;

        //Init variable
        private int nPortType = PORT_TYPE_COM;        
        private int nMode = PRINT_MODE_STANDRAD;
        private int nPaperOut = PAPER_OUT_PRESENTER;
        private int nPresenter = PRESENTER_RETRACT;
        private int nBundler = BUNDLER_RETRACT;
        
        private int hPort = -1;
        private bool IsPrinter = false;
        private bool bSaveToTxt = false;
        static bool bIsFirst = true;
        private bool bThreadRunning = false;

        #region	KIOSKDLL const declare
        
        //return value
        //Success
        private const int KIOSK_SUCCESS = 1001;

        //Fail
        private const int KIOSK_FAIL = 1002;

        //Invalid handle
        private const int KIOSK_ERROR_INVALID_HANDLE = 1101;

        //Invalid parameter
        private const int KIOSK_ERROR_INVALID_PARAMETER = 1102;

        //Invalid path
        private const int KIOSK_ERROR_INVALID_PATH = 1201;

        //File is not bitmap
        private const int KIOSK_ERROR_NOT_BITMAP = 1202;

        //Bitmap is not mono
        private const int KIOSK_ERROR_NOT_MONO_BITMAP = 1203;

        //Bitmap is too large
        private const int KIOSK_ERROR_BEYOND_AREA = 1204;

        //Operate file error
        private const int KIOSK_ERROR_FILE = 1301; 

        //Com stopbits
        private const int KIOSK_COM_ONESTOPBIT = 0x00;
        private const int KIOSK_COM_TWOSTOPBITS = 0x01;

        //Com parity
        private const int KIOSK_COM_NOPARITY = 0x00;
        private const int KIOSK_COM_ODDPARITY = 0x01;
        private const int KIOSK_COM_EVENPARITY = 0x02;
        private const int KIOSK_COM_MARKPARITY = 0x03;
        private const int KIOSK_COM_SPACEPARITY = 0x04;

        //Com flow control
        private const int KIOSK_COM_DTR_DSR = 0x00;
        private const int KIOSK_COM_RTS_CTS = 0x01;
        private const int KIOSK_COM_XON_XOFF = 0x02;
        private const int KIOSK_COM_NO_HANDSHAKE = 0x03;

        //Print mode
        private const int KIOSK_PRINT_MODE_STANDARD = 0x00;
        private const int KIOSK_PRINT_MODE_PAGE = 0x01;

        //Paper type
        private const int KIOSK_PAPER_SERIAL = 0x00;
        private const int KIOSK_PAPER_SIGN = 0x01;

        //Font type
        private const int KIOSK_FONT_TYPE_STANDARD = 0x00;
        private const int KIOSK_FONT_TYPE_COMPRESSED = 0x01;
        private const int KIOSK_FONT_TYPE_UDC = 0x02;
        private const int KIOSK_FONT_TYPE_CHINESE = 0x03;

        //Font style
        private const int KIOSK_FONT_STYLE_NORMAL = 0x00;
        private const int KIOSK_FONT_STYLE_BOLD = 0x08;
        private const int KIOSK_FONT_STYLE_THIN_UNDERLINE = 0x80;
        private const int KIOSK_FONT_STYLE_THICK_UNDERLINE = 0x100;
        private const int KIOSK_FONT_STYLE_UPSIDEDOWN = 0x200;
        private const int KIOSK_FONT_STYLE_REVERSE = 0x400;
        private const int KIOSK_FONT_STYLE_CLOCKWISE_90 = 0x1000;

        //Bitmap mode
        private const int KIOSK_BITMAP_MODE_8SINGLE_DENSITY = 0x00;
        private const int KIOSK_BITMAP_MODE_8DOUBLE_DENSITY = 0x01;
        private const int KIOSK_BITMAP_MODE_24SINGLE_DENSITY = 0x20;
        private const int KIOSK_BITMAP_MODE_24DOUBLE_DENSITY = 0x21;
          
        //Bitmap print mode
        private const int KIOSK_BITMAP_PRINT_NORMAL = 0x00;
        private const int KIOSK_BITMAP_PRINT_DOUBLE_WIDTH = 0x01;
        private const int KIOSK_BITMAP_PRINT_DOUBLE_HEIGHT = 0x02;
        private const int KIOSK_BITMAP_PRINT_QUADRUPLE = 0x03;

        //Bar code type
        private const int KIOSK_BARCODE_TYPE_UPC_A = 0x41;
        private const int KIOSK_BARCODE_TYPE_UPC_E = 0x42;
        private const int KIOSK_BARCODE_TYPE_JAN13 = 0x43;
        private const int KIOSK_BARCODE_TYPE_JAN8 = 0x44;
        private const int KIOSK_BARCODE_TYPE_CODE39 = 0x45;
        private const int KIOSK_BARCODE_TYPE_ITF = 0x46;
        private const int KIOSK_BARCODE_TYPE_CODEBAR = 0x47;
        private const int KIOSK_BARCODE_TYPE_CODE93 = 0x48;
        private const int KIOSK_BARCODE_TYPE_CODE128 = 0x49;

        //HRI position
        private const int KIOSK_HRI_POSITION_NONE = 0x00;
        private const int KIOSK_HRI_POSITION_ABOVE = 0x01;
        private const int KIOSK_HRI_POSITION_BELOW = 0x02;
        private const int KIOSK_HRI_POSITION_BOTH = 0x03;

        //Print direction in page mode
        private const int KIOSK_AREA_LEFT_TO_RIGHT = 0x00;
        private const int KIOSK_AREA_BOTTOM_TO_TOP = 0x01;
        private const int KIOSK_AREA_RIGHT_TO_LEFT = 0x02;
        private const int KIOSK_AREA_TOP_TO_BOTTOM = 0x03;

        //Presenter mode
        private const int KIOSK_PRESENTER_Retraction_on = 0x00;
        private const int KIOSK_PRESENTER_Paper_Forward = 0x01;
        private const int KIOSK_PRESENTER_Paper_Hold = 0x02;
        private const int KIOSK_PRESENTER_Close = 0x03;

        //Bundler mode
        private const int KIOSK_BUNDLER_Petract = 0x00;
        private const int KIOSK_BUNDLER_Present = 0x01;
        
        #endregion

        #region KIOSKDLL function declare
        #region Communication function
        //Communication function
        //COM
        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_OpenCom( string lpName, 
									             int nComBaudrate,  
									             int nComDataBits,  
									             int nComStopBits, 
									             int nComParity, 
									             int nFlowControl);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetComTimeOuts( int hPort, 
                                                        int nWriteTimeoutMul,
                                                        int nWriteTimeoutCon,
                                                        int nReadTimeoutMul,
                                                        int nReadTimeoutCon);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_CloseCom( int hPort );


        //Driver LPT
        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_OpenLptByDrv(ushort LPTAddress);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_CloseDrvLPT( int nPortType );

        //USB
        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_OpenUsb();

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_OpenUsbByID( int nID );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_CloseUsb( int hPort );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetUsbTimeOuts(int hPort, ushort wReadTimeouts, ushort wWriteTimeouts);
        
        //Driver
        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_OpenDrv( char[] drivername );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_CloseDrv( int hPort );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_StartDoc( int hPort );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_EndDoc( int hPort );


        //Write Read Port
        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_WriteData( int hPort, int nPortType, char[] pszData, int nBytesToWrite);

        [DllImport("KIOSKDLL.dll")]
        private static extern unsafe int KIOSK_ReadData(int hPort, int nPortType, int nStatus, byte* pszBuffer, int nBytesToRead);
        #endregion

        #region Assistant function
        //Assistant function
        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SendFile( int hPort, int nPortType, string filename );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_BeginSaveToFile(int hPort, string lpFileName, bool bToPrinter);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_EndSaveToFile(int hPort);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_QueryStatus(int hPort, int nPortType, string pszStatus, int nTimeouts);

        [DllImport("KIOSKDLL.dll")]
        private static extern unsafe int KIOSK_RTQueryStatus(int hPort, int nPortType, char* pszStatus);

        [DllImport("KIOSKDLL.dll")]
        private static extern unsafe int KIOSK_RTQueryStatusForT681(int hPort, int nPortType, char* pszStatus);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_QueryASB(int hPort, int nPortType,int Enable);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_QueryStatus_T(int hPort, int nPortType, string pszStatus, int nTimeouts);

        [DllImport("KIOSKDLL.dll")]
        private static extern unsafe int KIOSK_RTQueryStatus_T(int hPort, int nPortType, char* pszStatus);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_QueryASB_T(int hPort, int nPortType, int Enable);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_GetVersionInfo( IntPtr pnMajor,IntPtr pnMinor );
        
        #endregion

        #region Printer command function
        //Printer command function
        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_EnableMacro( int hPort, int nPortType, int nEnable );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_Reset( int hPort, int nPortType );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetPaperMode( int hPort,int nPortType,int nMode );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetMode( int hPort,int nPortType,int nPrintMode );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetMotionUnit( int hPort,int nPortType,int nHorizontalMU,int nVerticalMU );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetLineSpacing( int hPort,int nPortType,int nDistance );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetRightSpacing( int hPort,int nPortType,int nDistance ) ;

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetOppositePosition(int hPort,
                                                            int nPortType,
                                                            int nPrintMode,
                                                            int nHorizontalDist,
                                                            int nVerticalDist);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetTabs(int hPort, int nPortType, string pszPosition, int nCount);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_ExecuteTabs( int hPort,  int nPortType );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_PreDownloadBmpToRAM(int hPort, int nPortType, string pszPaths, int nTranslateMode, int nID);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_PreDownloadBmpToFlash(int hPort,
                                                                int nPortType,
                                                                string[] pszPaths,
                                                                int nTranslateMode,
                                                                int nCount);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetCharSetAndCodePage(int hPort,int nPortType,	int nCharSet,int nCodePage);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_FontUDChar( int hPort,
                                                    int nPortType,
                                                    int nEnable,
                                                    int DPI,
                                                    int nChar,
                                                    int nCharCode,
                                                    char[] pCharBmpBuffer,
                                                    int nDotsOfWidth,
                                                    int nBytesOfHeight );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_FeedLine( int hPort, int nPortType );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_FeedLines( int hPort,int nPortType,int nLines );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_MarkerFeedPaper( int hPort, int nPortType );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_CutPaper( int hPort, int nPortType, int nMode, int nDistance );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_MarkerCutPaper( int hPort, int nPortType, int nDistance );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_S_SetLeftMarginAndAreaWidth( int hPort,
                                                                     int nPortType,
                                                                     int nDistance,
                                                                     int nWidth );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_S_SetAlignMode( int hPort, int nPortType, int nMode);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_S_Textout(	int hPort,
                                                    int nPortType,
                                                    string pszData,     
                                                    int nOrgx,           
                                                    int nWidthTimes,     
                                                    int nHeightTimes,    
                                                    int nFontType,       
                                                    int nFontStyle );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_S_DownloadPrintBmp( int hPort, 
                                                            int nPortType,
                                                            string pszPath,
                                                            int nTranslateMode,
                                                            int nOrgx,        
                                                            int nMode);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_S_PrintBmpInRAM( int hPort, 
                                                         int nPortType,
                                                         int nID,     
                                                         int nOrgx,        
                                                         int nMode);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_S_PrintBmpInFlash( int hPort,
                                                           int nPortType,
                                                           int nID,         
                                                           int nOrgx,       
                                                           int nMode );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_S_PrintBarcode(	 int hPort,
                                                         int nPortType,
                                                         char[] pszBuffer,
                                                         int nOrgx,
                                                         int nType, 
                                                         int nWidth,
                                                         int nHeight,
                                                         int nHriFontType,
                                                         int nHriFontPosition,
                                                         int nBytesOfBuffer );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_P_SetAreaAndDirection( int hPort,
                                                               int nPortType,
                                                               int nOrgx,        
                                                               int nOrgy,        
                                                               int nWidth,       
                                                               int nHeight,      
                                                               int nDirection );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_P_Textout( int hPort,
                                                   int nPortType,
                                                   string pszData,     
                                                   int nOrgx, 
                                                   int nOrgy,          
                                                   int nWidthTimes,     
                                                   int nHeightTimes,    
                                                   int nFontType,       
                                                   int nFontStyle);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_P_DownloadPrintBmp( int hPort, 
                                                            int nPortType,
                                                            string pszPath,
                                                            int nTranslateMode,
                                                            int nOrgx,   
                                                            int nOrgy,     
                                                            int nMode );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_P_PrintBmpInRAM( int hPort,
                                                         int nPortType,
                                                         int nID,         
                                                         int nOrgx,  
                                                         int nOrgy,     
                                                         int nMode);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_P_PrintBmpInFlash( int hPort,
                                                           int nPortType,
                                                           int nID,         
                                                           int nOrgx,  
                                                           int nOrgy,     
                                                           int nMode );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_P_PrintBarcode( int hPort,
                                                        int nPortType,
                                                        char[] pszBuffer,
                                                        int nOrgx,
                                                        int nOrgy, 
                                                        int nType, 
                                                        int nWidth,
                                                        int nHeight,
                                                        int nHriFontType,
                                                        int nHriFontPosition,
                                                        int nBytesOfBuffer);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_P_Print( int hPort, int nPortType);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_P_Clear( int hPort, int nPortType);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_S_TestPrint( int hPort, int nPortType);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_CountMode( int hPort,
                                                   int nPortType,
                                                   int nBits,
                                                   int nOrder,
                                                   int nSBound,
                                                   int nEBound,
                                                   int nTimeSpace,
                                                   int nCycTime,
                                                   int nCount );
        
        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetPrintFromStart( int hPort,int nPortType,int nMode );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetRaster(int hPort, int nPortType, string pszBmpPath, int nTranslateMode, int nMode);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_P_Lineation( int hPort,
                                                     int nPortType,
                                                     int nWidth,
                                                     int nSHCoordinate,
                                                     int nSVCoordinate,
                                                     int nEHCoordinate,
                                                     int nEVCoordinate );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_BarcodeSetPDF417( int hPort,
                                                          int nPortType,
                                                          string  content,
                                                          int nBytesOfBuffer,
                                                          int nWidth, 
                                                          int nHeight,
                                                          int nColumns,
                                                          int nLines,
                                                          int nScaleH,
                                                          int nScaleV,
                                                          int nCorrectGrade );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetChineseFont( int hPort,
                                                        int nPortType,
                                                        string pszBuffer,
                                                        int nEnable,
                                                        int nBigger,
                                                        int nLSpacing,
                                                        int nRSpacing,
                                                        int nUnderLine );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetPresenter( int hPort, int nPortType, int nMode, int nTime);

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetBundler( int hPort, int nPortType, int nMode, int nTime );

        [DllImport("KIOSKDLL.dll")]
        private static extern int KIOSK_SetBundlerInfo( int hPort,int nPortType,int nMode );

        #endregion

        #endregion

        #region Print function
        #region 56mm_203DPI_Standard_Mode
        /******************************************************************************************************************************************
          Function:       PrintInStandardMode56_203DPI()
          Description:    print sample
          Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit image to Flash by specifying it's ID.
				          KIOSK_Reset()                       //Reset the printer.
				          KIOSK_SetMode()                     //Set the mode of printing.
                          KIOSK_SetMotionUnit()               //Set the units of motion.
                          KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
                          KIOSK_SetRightSpacing()             //Set the right spacing of character.
				          KIOSK_SetLineSpacing()              //Set the spacing of lines.
				          KIOSK_S_Textout()                   //Write one character string at the specified position.
				          KIOSK_FeedLine()                    //Feed 1 line.
				          KIOSK_FeedLines()                   //Feed paper forward.
				          KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				          KIOSK_S_PrintBmpInFlash()           //Print a bit image in Flash by specifying it's ID.
				          KIOSK_CutPaper()                    //Cut paper.
          Called By:      button_Print_Click(object sender, EventArgs e)    
          Input:          hPort: port handle
                          nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
          Return:         Returns True if successful, False if not successful.
        *******************************************************************************************************************************************/
        bool PrintInStandardMode56_203DPI( int hPort, int nPortType )
        {  
            bIsFirst = true;
	        
	        if( bIsFirst )
	        {
		        // Downloading images to Flash
                string[] pBitImages = { "Kitty.bmp", "Look.bmp" };

                //Pre-download a group of bit image to Flash by specifying it's ID
		        if( KIOSK_SUCCESS != KIOSK_PreDownloadBmpToFlash( hPort, nPortType, pBitImages, 2, 2 ) )
		        {
			        return false;
		        }

		        bIsFirst = false;
	        }

            /*Print setting.*/
	        KIOSK_Reset( hPort,nPortType );

	        KIOSK_SetMode( hPort,nPortType, KIOSK_PRINT_MODE_STANDARD );
        	
	        if( KIOSK_SUCCESS != KIOSK_SetMotionUnit( hPort,nPortType, 180, 180 ) )
	        {
		        return false;
	        }	

            KIOSK_S_SetLeftMarginAndAreaWidth( hPort, nPortType, 0, 450 );
        	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_SetLineSpacing( hPort, nPortType, 95 );

            /*Text setting*/
	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 62, 2, 2,
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	        KIOSK_SetLineSpacing( hPort, nPortType, 15 );
        		
	        KIOSK_FeedLines( hPort,nPortType, 3 );

	        KIOSK_S_Textout( hPort, nPortType, "-----------------------------------", 5, 1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "-----------------------------------", 5, 1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLines( hPort,nPortType, 2 );


	        // Different right-spacing	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_S_Textout( hPort, nPortType, "Right Spacing", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 215, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_SetRightSpacing( hPort, nPortType, 1 ); 

	        KIOSK_S_Textout( hPort, nPortType, "Right Spacing", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );
        	
	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 215, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_SetRightSpacing( hPort, nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "Right Spacing", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 215, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);
        	
	        KIOSK_FeedLines( hPort, nPortType, 2 );


	        // Different font
	        KIOSK_SetRightSpacing( hPort, nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-NORMAL", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-BOLD", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType,"FONTSTYLE-UNDERLINE", 5, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);


	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-UNDERLINE", 5, 1, 1,
                               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-REVERSE", 5, 1, 1,
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-90", 5, 1, 1, 
		                         KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	        KIOSK_FeedLines( hPort, nPortType, 2 );	
        	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_S_Textout( hPort, nPortType, "-----------------------------------", 5, 1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine( hPort, nPortType );

            /*Bar code setting.*/
	        KIOSK_S_Textout( hPort, nPortType, "Barcode - Code 128", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine(hPort, nPortType );

	        KIOSK_S_PrintBarcode( hPort, nPortType, "{A*1234ABCDE*{C5678".ToCharArray(), 5, KIOSK_BARCODE_TYPE_CODE128,
		                             2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	        KIOSK_FeedLine( hPort, nPortType );

        	
            KIOSK_S_Textout( hPort, nPortType, "-----------------------------------", 5, 1, 1, 
						        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);	

	        KIOSK_FeedLine( hPort, nPortType );

            /*Bitmap setting.*/
	        KIOSK_S_Textout(hPort, nPortType, "---------------Logo1---------------", 5, 1, 1, 
						        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_PrintBmpInFlash( hPort, nPortType, 1, 50, KIOSK_BITMAP_PRINT_QUADRUPLE );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "---------------Logo2---------------", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_PrintBmpInFlash( hPort, nPortType, 2, 5, KIOSK_BITMAP_PRINT_QUADRUPLE );

            /*Print setting.*/
	        KIOSK_FeedLine( hPort, nPortType );
	        KIOSK_FeedLine( hPort, nPortType );
	        KIOSK_FeedLine( hPort, nPortType );
	        KIOSK_FeedLine( hPort, nPortType );

	        // Cut paper
	        KIOSK_CutPaper( hPort, nPortType, 1, 0 );
	        return true;
        }
        #endregion

        #region 56mm_203DPI_Page_Mode
        /******************************************************************************************************************************************
          Function:       PrintInPageMode56_203DPI()
          Description:    print sample
          Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit image to Flash by specifying it's ID.
				          KIOSK_Reset()                       //Reset the printer.
				          KIOSK_SetMode()                     //Set the mode of printing.
                          KIOSK_SetMotionUnit()               //Set the units of motion.
                          KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
                          KIOSK_P_Clear()                     //Clear the buffer.
				          KIOSK_SetRightSpacing()             //Set the right spacing of character.
				          KIOSK_SetLineSpacing()              //Set the spacing of lines.
				          KIOSK_P_Textout()                   //Write one character string at the specified position.
				          KIOSK_FeedLine()                    //Feed 1 line.
				          KIOSK_FeedLines()                   //Feed paper forward.
				          KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				          KIOSK_P_PrintBmpInFlash()           //Print a bit image in Flash by specifying it's ID.
				          KIOSK_P_Clear()                     //Clear the buffer.
				          KIOSK_CutPaper()                    //Cut paper.
          Called By:      button_Print_Click(object sender, EventArgs e)   
          Input:          hPort: port handle
                          nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
          Return:         Returns True if successful, False if not successful.
        *******************************************************************************************************************************************/
        bool PrintInPageMode56_203DPI(int hPort, int nPortType)
        {
            bIsFirst = true;
	
	        // Downloading images to RAM
            if (KIOSK_PreDownloadBmpToRAM(hPort, nPortType, "kitty.bmp", 2, 0) != KIOSK_SUCCESS) // ID number is 0
	        {
		        return false;
	        }

            KIOSK_PreDownloadBmpToRAM(hPort, nPortType, "Look.bmp", 2, 1); // ID number is 1

            /*Print setting.*/
            KIOSK_Reset(hPort, nPortType);
            KIOSK_SetMode( hPort, nPortType, KIOSK_PRINT_MODE_PAGE );

	        KIOSK_SetMotionUnit( hPort, nPortType, 180, 180 );
        	
	        KIOSK_P_SetAreaAndDirection( hPort, nPortType, 5, 10, 450, 1200, KIOSK_AREA_LEFT_TO_RIGHT );

	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

            KIOSK_SetLineSpacing( hPort, nPortType, 95 );

            /*Text setting*/
	        KIOSK_P_Textout( hPort, nPortType, "KIOSK Printer", 62, 80, 2, 2, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_P_Textout( hPort, nPortType, "-----------------------------------", 5, 120,1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


	        KIOSK_P_Textout( hPort, nPortType, "-----------------------------------", 5, 140,1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        //Different right-spacing 	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_P_Textout( hPort, nPortType, "Right Spacing", 5, 180, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_P_Textout( hPort, nPortType, "KIOSK Printer", 215, 180, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_SetRightSpacing( hPort, nPortType , 1 );

	        KIOSK_P_Textout( hPort, nPortType, "Right Spacing", 5, 210, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_P_Textout( hPort, nPortType, "KIOSK Printer", 215, 210, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_SetRightSpacing( hPort, nPortType , 2 );

	        KIOSK_P_Textout( hPort, nPortType, "Right Spacing", 5, 240, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_P_Textout( hPort, nPortType, "KIOSK Printer", 215, 240, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );


	        // Different font
	        KIOSK_SetRightSpacing( hPort, nPortType, 2 );

	        KIOSK_P_Textout( hPort, nPortType, "FONTSTYLE-NORMAL", 5, 300, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL); 


	        KIOSK_P_Textout( hPort, nPortType, "FONTSTYLE-BOLD", 5, 330, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );


	        KIOSK_P_Textout( hPort, nPortType,"FONTSTYLE-UNDERLINE", 5, 360, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);


	        KIOSK_P_Textout( hPort, nPortType, "FONTSTYLE-UNDERLINE", 5, 390, 1, 1,
                               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);



	        KIOSK_P_Textout( hPort, nPortType, "FONTSTYLE-REVERSE", 5, 420, 1, 1,
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_P_Textout( hPort, nPortType, "-------------------------------", 5, 460,1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            /*Bar code setting.*/
	        KIOSK_P_Textout( hPort, nPortType, "Barcode - Code 128", 5, 490, 1, 1, 
		                        KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_P_PrintBarcode( hPort, nPortType, "{A*1234ABCDE*{C5678".ToCharArray(), 5,560, KIOSK_BARCODE_TYPE_CODE128,
		                           2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );
        	


	        KIOSK_P_Textout( hPort, nPortType, "-------------------------------", 5, 610,1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            /*Bitmap setting.*/
	        KIOSK_P_Textout(hPort, nPortType, "-------------Logo1-------------", 5, 630, 1, 1, 
						        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_P_PrintBmpInRAM( hPort, nPortType, 0, 5,  700, KIOSK_BITMAP_PRINT_QUADRUPLE);

	        KIOSK_P_Textout(hPort, nPortType, "-------------Logo2-------------", 5, 720,1, 1, 
						        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_P_PrintBmpInRAM( hPort, nPortType, 1, 5, 810, KIOSK_BITMAP_PRINT_QUADRUPLE);

            /*Print setting.*/
	        KIOSK_P_Print( hPort, nPortType );

	        KIOSK_P_Clear( hPort, nPortType );

	        KIOSK_CutPaper( hPort, nPortType, 1, 0 );
	        return true;
        }
        #endregion

        #region 56mm_300DPI_Standard_Mode
        /******************************************************************************************************************************************
          Function:       PrintInStandardMode56_300DPI()
          Description:    print sample
          Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit image to Flash by specifying it's ID.
				          KIOSK_Reset()                       //Reset the printer.
				          KIOSK_SetMode()                     //Set the mode of printing.
                          KIOSK_SetMotionUnit()               //Set the units of motion.
                          KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
                          KIOSK_SetRightSpacing()             //Set the right spacing of character.
				          KIOSK_SetLineSpacing()              //Set the spacing of lines.
				          KIOSK_S_Textout()                   //Write one character string at the specified position.
				          KIOSK_FeedLine()                    //Feed 1 line.
				          KIOSK_FeedLines()                   //Feed paper forward.
				          KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				          KIOSK_S_PrintBmpInFlash()           //Print a bit image in Flash by specifying it's ID.
				          KIOSK_CutPaper()                    //Cut paper.
          Called By:      button_Print_Click(object sender, EventArgs e)    
          Input:          hPort: port handle
                          nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
          Return:         Returns True if successful, False if not successful.
        *******************************************************************************************************************************************/
        bool PrintInStandardMode56_300DPI(int hPort, int nPortType)
        {
	        bIsFirst = true;

            if( bIsFirst )
	        {
		        // Downloading images to Flash
                string[] pBitImages = { "Kitty.bmp", "Look.bmp" };

                if (KIOSK_SUCCESS != KIOSK_PreDownloadBmpToFlash(hPort, nPortType, pBitImages, 2, 2))
		        {
			        return false;
		        }

		        bIsFirst = false;
	        }

            /*Print setting.*/
	        KIOSK_Reset( hPort,nPortType );

	        KIOSK_SetMode( hPort,nPortType, KIOSK_PRINT_MODE_STANDARD );
        	
	        if( KIOSK_SUCCESS != KIOSK_SetMotionUnit( hPort,nPortType, 180, 180 ) )
	        {
		        return false;
	        }	

            KIOSK_S_SetLeftMarginAndAreaWidth( hPort, nPortType, 0, 670 );
        	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_SetLineSpacing( hPort, nPortType, 95 );
            
            /*Text setting*/
	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 62, 2, 2,
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	        KIOSK_SetLineSpacing( hPort, nPortType, 15 );
        		
	        KIOSK_FeedLines( hPort,nPortType, 3 );

	        KIOSK_S_Textout( hPort, nPortType, "-----------------------------------", 5, 1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "-----------------------------------", 5, 1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLines( hPort,nPortType, 2 );


	        // Different right-spacing	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_S_Textout( hPort, nPortType, "Right Spacing", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 215, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_SetRightSpacing( hPort, nPortType, 1 ); 

	        KIOSK_S_Textout( hPort, nPortType, "Right Spacing", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );
        	
	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 215, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_SetRightSpacing( hPort, nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "Right Spacing", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 215, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);
        	
	        KIOSK_FeedLines( hPort, nPortType, 2 );


	        // Different font
	        KIOSK_SetRightSpacing( hPort, nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-NORMAL", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-BOLD", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType,"FONTSTYLE-UNDERLINE", 5, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);


	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-UNDERLINE", 5, 1, 1,
                               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-REVERSE", 5, 1, 1,
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-90", 5, 1, 1, 
		                         KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	        KIOSK_FeedLines( hPort, nPortType, 2 );	
        	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_S_Textout( hPort, nPortType, "-----------------------------------", 5, 1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine( hPort, nPortType );
            
            /*Bar code setting.*/
	        KIOSK_S_Textout( hPort, nPortType, "Barcode - Code 128", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine(hPort, nPortType );

	        KIOSK_S_PrintBarcode( hPort, nPortType, "{A*1234ABCDE*{C5678".ToCharArray(), 5, KIOSK_BARCODE_TYPE_CODE128,
		                             2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	        KIOSK_FeedLine( hPort, nPortType );

        	
            KIOSK_S_Textout( hPort, nPortType, "-----------------------------------", 5, 1, 1, 
						        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);	

	        KIOSK_FeedLine( hPort, nPortType );
            
            /*Bitmap setting.*/
	        KIOSK_S_Textout(hPort, nPortType, "---------------Logo1---------------", 5, 1, 1, 
						        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_PrintBmpInFlash( hPort, nPortType, 1, 50, KIOSK_BITMAP_PRINT_QUADRUPLE );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "---------------Logo2---------------", 5, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_PrintBmpInFlash( hPort, nPortType, 2, 50, KIOSK_BITMAP_PRINT_QUADRUPLE );
           
            /*Print setting.*/
	        KIOSK_FeedLine( hPort, nPortType );
	        KIOSK_FeedLine( hPort, nPortType );
	        KIOSK_FeedLine( hPort, nPortType );
	        KIOSK_FeedLine( hPort, nPortType );

	        // Cut paper
	        KIOSK_CutPaper( hPort, nPortType, 1, 0 );
	        return true;
        }
        #endregion

        #region 56mm_300DPI_Page_Mode
        /******************************************************************************************************************************************
          Function:       PrintInPageMode56_300DPI()
          Description:    print sample
          Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit image to Flash by specifying it's ID.
				          KIOSK_Reset()                       //Reset the printer.
				          KIOSK_SetMode()                     //Set the mode of printing.
                          KIOSK_SetMotionUnit()               //Set the units of motion.
                          KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
                          KIOSK_P_Clear()                     //Clear the buffer.
				          KIOSK_SetRightSpacing()             //Set the right spacing of character.
				          KIOSK_SetLineSpacing()              //Set the spacing of lines.
				          KIOSK_P_Textout()                   //Write one character string at the specified position.
				          KIOSK_FeedLine()                    //Feed 1 line.
				          KIOSK_FeedLines()                   //Feed paper forward.
				          KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				          KIOSK_P_PrintBmpInFlash()           //Print a bit image in Flash by specifying it's ID.
				          KIOSK_P_Clear()                     //Clear the buffer.
				          KIOSK_CutPaper()                    //Cut paper.
          Called By:      button_Print_Click(object sender, EventArgs e)    
          Input:          hPort: port handle
                          nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
          Return:         Returns True if successful, False if not successful.
        *******************************************************************************************************************************************/
        bool PrintInPageMode56_300DPI(int hPort, int nPortType)
        {
            bIsFirst = true;

            // Downloading images to RAM
            if (KIOSK_PreDownloadBmpToRAM(hPort, nPortType, "kitty.bmp", 2, 0) != KIOSK_SUCCESS) // ID number is 0
            {
                return false;
            }

            KIOSK_PreDownloadBmpToRAM(hPort, nPortType, "Look.bmp", 2, 1); // ID number is 1

            /*Print setting.*/
            KIOSK_Reset(hPort, nPortType);
            KIOSK_SetMode(hPort, nPortType, KIOSK_PRINT_MODE_PAGE);

            KIOSK_SetMotionUnit(hPort, nPortType, 180, 180);

            KIOSK_P_SetAreaAndDirection(hPort, nPortType, 5, 10, 670, 1200, KIOSK_AREA_LEFT_TO_RIGHT);

            KIOSK_SetRightSpacing(hPort, nPortType, 0);

            KIOSK_SetLineSpacing(hPort, nPortType, 95);

            /*Text setting*/
            KIOSK_P_Textout(hPort, nPortType, "KIOSK Printer", 62, 80, 2, 2,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "-----------------------------------", 5, 120, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


            KIOSK_P_Textout(hPort, nPortType, "-----------------------------------", 5, 140, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            //Different right-spacing 	
            KIOSK_SetRightSpacing(hPort, nPortType, 0);

            KIOSK_P_Textout(hPort, nPortType, "Right Spacing", 5, 180, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "KIOSK Printer", 215, 180, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_SetRightSpacing(hPort, nPortType, 1);

            KIOSK_P_Textout(hPort, nPortType, "Right Spacing", 5, 210, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "KIOSK Printer", 215, 210, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_SetRightSpacing(hPort, nPortType, 2);

            KIOSK_P_Textout(hPort, nPortType, "Right Spacing", 5, 240, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "KIOSK Printer", 215, 240, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_SetRightSpacing(hPort, nPortType, 0);


            // Different font
            KIOSK_SetRightSpacing(hPort, nPortType, 2);

            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-NORMAL", 5, 300, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);


            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-BOLD", 5, 330, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-UNDERLINE", 5, 360, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);


            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-UNDERLINE", 5, 390, 1, 1,
                               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);



            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-REVERSE", 5, 420, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE);

            KIOSK_P_Textout(hPort, nPortType, "-------------------------------", 5, 460, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);
            
            /*Bar code setting.*/
            KIOSK_P_Textout(hPort, nPortType, "Barcode - Code 128", 5, 490, 1, 1,
                                KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_PrintBarcode(hPort, nPortType, "{A*1234ABCDE*{C5678".ToCharArray(), 5, 560, KIOSK_BARCODE_TYPE_CODE128,
                                   2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19);

            KIOSK_P_Textout(hPort, nPortType, "-------------------------------", 5, 610, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            /*Bitmap setting.*/
            KIOSK_P_Textout(hPort, nPortType, "-------------Logo1-------------", 5, 630, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_PrintBmpInRAM(hPort, nPortType, 0, 5, 700, KIOSK_BITMAP_PRINT_QUADRUPLE);

            KIOSK_P_Textout(hPort, nPortType, "-------------Logo2-------------", 5, 720, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_PrintBmpInRAM(hPort, nPortType, 1, 5, 810, KIOSK_BITMAP_PRINT_QUADRUPLE);

            /*Print setting*/
            KIOSK_P_Print(hPort, nPortType);

            KIOSK_P_Clear(hPort, nPortType);

            KIOSK_CutPaper(hPort, nPortType, 1, 0);
            return true;
        }
        #endregion

        #region 80mm_203DPI_Standard_Mode
        /******************************************************************************************************************************************
          Function:       PrintInStandardMode80_203DPI()
          Description:    print sample
          Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit image to Flash by specifying it's ID.
				          KIOSK_Reset()                       //Reset the printer.
				          KIOSK_SetMode()                     //Set the mode of printing.
                          KIOSK_SetMotionUnit()               //Set the units of motion.
                          KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
                          KIOSK_SetRightSpacing()             //Set the right spacing of character.
				          KIOSK_SetLineSpacing()              //Set the spacing of lines.
				          KIOSK_S_Textout()                   //Write one character string at the specified position.
				          KIOSK_FeedLine()                    //Feed 1 line.
				          KIOSK_FeedLines()                   //Feed paper forward.
				          KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				          KIOSK_S_PrintBmpInFlash()           //Print a bit image in Flash by specifying it's ID.
				          KIOSK_CutPaper()                    //Cut paper.
          Called By:      button_Print_Click(object sender, EventArgs e)    
          Input:          hPort: port handle
                          nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
          Return:         Returns True if successful, False if not successful.
        *******************************************************************************************************************************************/
        bool PrintInStandardMode80_203DPI(int hPort, int nPortType)
        {
            bIsFirst = true;

	        if( bIsFirst )
	        {
		        //Download images to Flash.
                string[] pBitImages = { "Kitty.bmp", "Look.bmp" };

                if (KIOSK_SUCCESS != KIOSK_PreDownloadBmpToFlash(hPort, nPortType, pBitImages, 2, 2))
		        {
			        return false;
		        }

		        bIsFirst = false;
	        }

            /*Print setting.*/
	        KIOSK_Reset( hPort,nPortType );

	        KIOSK_SetMode( hPort,nPortType, KIOSK_PRINT_MODE_STANDARD );
        	
	        if( KIOSK_SUCCESS != KIOSK_SetMotionUnit( hPort,nPortType, 203, 203 ) )
	        {
		        return false;
	        }	

            KIOSK_S_SetLeftMarginAndAreaWidth( hPort, nPortType, 0, 640 );
        	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_SetLineSpacing( hPort, nPortType, 95 );

            /*Text setting*/
	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 182, 2, 2,
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	        KIOSK_SetLineSpacing( hPort, nPortType, 24 );
        		
	        KIOSK_FeedLines( hPort,nPortType, 3 );

	        KIOSK_S_Textout( hPort, nPortType, "------------------------------------------", 95, 1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "------------------------------------------", 95, 1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLines( hPort,nPortType, 2 );

	        //Different right-spacing	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_S_Textout( hPort, nPortType, "Right Spacing", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 330, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_SetRightSpacing( hPort, nPortType, 2 ); 

	        KIOSK_S_Textout( hPort, nPortType, "Right Spacing", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );
        	
	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 330, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_SetRightSpacing( hPort, nPortType, 4 );

	        KIOSK_S_Textout( hPort, nPortType, "Right Spacing", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 330, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);
        	
	        KIOSK_FeedLines( hPort, nPortType, 2);


	        //Different font
	        KIOSK_SetRightSpacing( hPort, nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-NORMAL", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-BOLD", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType,"FONTSTYLE-UNDERLINE", 95, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);


	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-UNDERLINE", 95, 1, 1,
                               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-REVERSE", 95, 1, 1,
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-90", 95, 1, 1, 
		                         KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	        KIOSK_FeedLines( hPort, nPortType, 2 );	

	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_S_Textout( hPort, nPortType, "------------------------------------------", 95, 1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine( hPort, nPortType );

            /*Bar code setting.*/
	        KIOSK_S_Textout( hPort, nPortType, "Barcode - Code 128", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine(hPort, nPortType );

	        KIOSK_S_PrintBarcode( hPort, nPortType, "{A*1234ABCDE*{C5678".ToCharArray(), 95, KIOSK_BARCODE_TYPE_CODE128,
		                           2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	        KIOSK_FeedLine( hPort, nPortType );

          
	        KIOSK_S_Textout( hPort, nPortType, "------------------------------------------", 95, 1, 1, 
						        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);	

	        KIOSK_FeedLine( hPort, nPortType );

            /*Bitmap setting.*/
	        KIOSK_S_Textout(hPort, nPortType, "------------------Logo 1------------------", 95, 1, 1, 
						        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_PrintBmpInFlash( hPort, nPortType, 1, 100, KIOSK_BITMAP_PRINT_QUADRUPLE );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "------------------Logo 2------------------", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_PrintBmpInFlash( hPort, nPortType, 2, 95, KIOSK_BITMAP_PRINT_QUADRUPLE );

            /*Print setting.*/
	        KIOSK_FeedLine( hPort, nPortType );
	        KIOSK_FeedLine( hPort, nPortType );
	        KIOSK_FeedLine( hPort, nPortType );
	        KIOSK_FeedLine( hPort, nPortType );

	        // Cut paper
	        KIOSK_CutPaper( hPort, nPortType, 1, 0 );
	        return true;
        }
        #endregion

        #region 80mm_203DPI_Page_Mode
        /******************************************************************************************************************************************
          Function:       PrintInPageMode80_203DPI()
          Description:    print sample
          Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit image to Flash by specifying it's ID.
				          KIOSK_Reset()                       //Reset the printer.
				          KIOSK_SetMode()                     //Set the mode of printing.
                          KIOSK_SetMotionUnit()               //Set the units of motion.
                          KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
                          KIOSK_P_Clear()                     //Clear the buffer.
				          KIOSK_SetRightSpacing()             //Set the right spacing of character.
				          KIOSK_SetLineSpacing()              //Set the spacing of lines.
				          KIOSK_P_Textout()                   //Write one character string at the specified position.
				          KIOSK_FeedLine()                    //Feed 1 line.
				          KIOSK_FeedLines()                   //Feed paper forward.
				          KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				          KIOSK_P_PrintBmpInFlash()           //Print a bit image in Flash by specifying it's ID.
				          KIOSK_P_Clear()                     //Clear the buffer.
				          KIOSK_CutPaper()                    //Cut paper.
          Called By:      button_Print_Click(object sender, EventArgs e)    
          Input:          hPort: port handle
                          nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
          Return:         Returns True if successful, False if not successful.
        *******************************************************************************************************************************************/
        bool PrintInPageMode80_203DPI(int hPort, int nPortType)
        {
            bIsFirst = true;

            //Download images to RAM
            if (KIOSK_PreDownloadBmpToRAM(hPort, nPortType, "kitty.bmp", 2, 0) != KIOSK_SUCCESS) // ID number is 0
            {
                return false;
            }

            KIOSK_PreDownloadBmpToRAM(hPort, nPortType, "Look.bmp", 2, 1); // ID number is 1

            /*Print setting.*/
            KIOSK_Reset(hPort, nPortType);
            KIOSK_SetMode(hPort, nPortType, KIOSK_PRINT_MODE_PAGE);

            KIOSK_SetMotionUnit(hPort, nPortType, 203, 203);

            KIOSK_P_SetAreaAndDirection(hPort, nPortType, 0, 10, 640, 1200, KIOSK_AREA_LEFT_TO_RIGHT);

            KIOSK_SetRightSpacing(hPort, nPortType, 0);

            /*Text setting*/
            KIOSK_P_Textout(hPort, nPortType, "KIOSK Printer", 182, 80, 2, 2,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

            KIOSK_P_Textout(hPort, nPortType, "------------------------------------------", 95, 120, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


            KIOSK_P_Textout(hPort, nPortType, "------------------------------------------", 95, 140, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            //Different right-spacing
            KIOSK_SetRightSpacing(hPort, nPortType, 0);

            KIOSK_P_Textout(hPort, nPortType, "Right Spacing", 95, 180, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "KIOSK Printer", 330, 180, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_SetRightSpacing(hPort, nPortType, 2);

            KIOSK_P_Textout(hPort, nPortType, "Right Spacing", 95, 210, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "KIOSKPrinter", 330, 210, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_SetRightSpacing(hPort, nPortType, 4);

            KIOSK_P_Textout(hPort, nPortType, "Right Spacing", 95, 240, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "KIOSK Printer", 330, 240, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_SetRightSpacing(hPort, nPortType, 0);

            //Different font
            KIOSK_SetRightSpacing(hPort, nPortType, 2);

            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-NORMAL", 95, 300, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL); //Normal font


            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-BOLD", 95, 330, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-UNDERLINE", 95, 360, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);


            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-UNDERLINE", 95, 390, 1, 1,
                               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);


            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-REVERSE", 95, 420, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE);

            KIOSK_P_Textout(hPort, nPortType, "------------------------------------", 95, 480, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            /*Bar code setting.*/
            KIOSK_P_Textout(hPort, nPortType, "Barcode - Code 128", 95, 505, 1, 1,
                                KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_PrintBarcode(hPort, nPortType, "{A*1234ABCDE*{C5678".ToCharArray(), 95, 580, KIOSK_BARCODE_TYPE_CODE128,
                                   2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19);



            KIOSK_P_Textout(hPort, nPortType, "------------------------------------", 95, 630, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            /*Bitmap setting.*/
            KIOSK_P_Textout(hPort, nPortType, "---------------Logo 1---------------", 95, 650, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_PrintBmpInRAM(hPort, nPortType, 0, 95, 720, KIOSK_BITMAP_PRINT_QUADRUPLE);


            KIOSK_P_Textout(hPort, nPortType, "---------------Logo 2---------------", 95, 740, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_PrintBmpInRAM(hPort, nPortType, 1, 95, 830, KIOSK_BITMAP_PRINT_QUADRUPLE);

            /*Print setting.*/
            KIOSK_P_Print(hPort, nPortType);

            KIOSK_P_Clear(hPort, nPortType);

            KIOSK_CutPaper(hPort, nPortType, 1, 0);
            return true;
        }
        #endregion

        #region 80mm_300DPI_Standard_Mode
        /******************************************************************************************************************************************
          Function:       PrintInStandardMode80_300DPI()
          Description:    print sample
          Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit image to Flash by specifying it's ID.
				          KIOSK_Reset()                       //Reset the printer.
				          KIOSK_SetMode()                     //Set the mode of printing.
                          KIOSK_SetMotionUnit()               //Set the units of motion.
                          KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
                          KIOSK_SetRightSpacing()             //Set the right spacing of character.
				          KIOSK_SetLineSpacing()              //Set the spacing of lines.
				          KIOSK_S_Textout()                   //Write one character string at the specified position.
				          KIOSK_FeedLine()                    //Feed 1 line.
				          KIOSK_FeedLines()                   //Feed paper forward.
				          KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				          KIOSK_S_PrintBmpInFlash()           //Print a bit image in Flash by specifying it's ID.
				          KIOSK_CutPaper()                    //Cut paper.
          Called By:      button_Print_Click(object sender, EventArgs e)   
          Input:          hPort: port handle
                          nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
          Return:         Returns True if successful, False if not successful.
        *******************************************************************************************************************************************/
        bool PrintInStandardMode80_300DPI(int hPort, int nPortType)
        {
	        bIsFirst = true;

            if( bIsFirst )
	        {
		        //Download images to Flash.
                string[] pBitImages = { "Kitty.bmp", "Look.bmp" };

                if (KIOSK_SUCCESS != KIOSK_PreDownloadBmpToFlash(hPort, nPortType, pBitImages, 2, 2))
		        {
			        return false;
		        }

		        bIsFirst = false;
	        }

            /*Print setting.*/
	        KIOSK_Reset( hPort,nPortType );

	        KIOSK_SetMode( hPort,nPortType, KIOSK_PRINT_MODE_STANDARD );
        	
	        if( KIOSK_SUCCESS != KIOSK_SetMotionUnit( hPort,nPortType, 203, 203 ) )
	        {
		        return false;
	        }	

            KIOSK_S_SetLeftMarginAndAreaWidth( hPort, nPortType, 0, 640 );
        	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_SetLineSpacing( hPort, nPortType, 95 );

            /*Text setting*/
	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 182, 2, 2,
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	        KIOSK_SetLineSpacing( hPort, nPortType, 24 );
        		
	        KIOSK_FeedLines( hPort,nPortType, 3 );

	        KIOSK_S_Textout( hPort, nPortType, "------------------------------------------", 95, 1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "------------------------------------------", 95, 1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLines( hPort,nPortType, 2 );

	        //Different right-spacing	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_S_Textout( hPort, nPortType, "Right Spacing", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 330, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_SetRightSpacing( hPort, nPortType, 2 ); 

	        KIOSK_S_Textout( hPort, nPortType, "Right Spacing", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );
        	
	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 330, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_SetRightSpacing( hPort, nPortType, 4 );

	        KIOSK_S_Textout( hPort, nPortType, "Right Spacing", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 330, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);
        	
	        KIOSK_FeedLines( hPort, nPortType, 2);

	        //Different font
	        KIOSK_SetRightSpacing( hPort, nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-NORMAL", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-BOLD", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType,"FONTSTYLE-UNDERLINE", 95, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);


	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-UNDERLINE", 95, 1, 1,
                               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-REVERSE", 95, 1, 1,
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_FeedLine( hPort, nPortType );


	        KIOSK_S_Textout( hPort, nPortType, "FONTSTYLE-90", 95, 1, 1, 
		                         KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	        KIOSK_FeedLines( hPort, nPortType, 2 );	
        	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_S_Textout( hPort, nPortType, "------------------------------------------", 95, 1, 1, 
		                          KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine( hPort, nPortType );

            /*Bar code setting.*/
	        KIOSK_S_Textout( hPort, nPortType, "Barcode - Code 128", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine(hPort, nPortType );

	        KIOSK_S_PrintBarcode( hPort, nPortType, "{A*1234ABCDE*{C5678".ToCharArray(), 95, KIOSK_BARCODE_TYPE_CODE128,
		                           2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "------------------------------------------", 95, 1, 1, 
						        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);	

	        KIOSK_FeedLine( hPort, nPortType );

            /*Bitmap setting.*/
	        KIOSK_S_Textout(hPort, nPortType, "------------------Logo 1------------------", 95, 1, 1, 
						        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_PrintBmpInFlash( hPort, nPortType, 1, 100, KIOSK_BITMAP_PRINT_QUADRUPLE );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "------------------Logo 2------------------", 95, 1, 1, 
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort, nPortType );

	        KIOSK_S_PrintBmpInFlash( hPort, nPortType, 2, 95, KIOSK_BITMAP_PRINT_QUADRUPLE );

            /*Print setting*/
	        KIOSK_FeedLine( hPort, nPortType );
	        KIOSK_FeedLine( hPort, nPortType );
	        KIOSK_FeedLine( hPort, nPortType );
	        KIOSK_FeedLine( hPort, nPortType );

	        // Cut paper
	        KIOSK_CutPaper( hPort, nPortType, 1, 0 );
	        return true;
        }
        #endregion

        #region 80mm_300DPI_Page_Mode
        /******************************************************************************************************************************************
          Function:       PrintInPageMode80_300DPI()
          Description:    print sample
          Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit image to Flash by specifying it's ID.
				          KIOSK_Reset()                       //Reset the printer.
				          KIOSK_SetMode()                     //Set the mode of printing.
                          KIOSK_SetMotionUnit()               //Set the units of motion.
                          KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
                          KIOSK_P_Clear()                     //Clear the buffer.
				          KIOSK_SetRightSpacing()             //Set the right spacing of character.
				          KIOSK_SetLineSpacing()              //Set the spacing of lines.
				          KIOSK_P_Textout()                   //Write one character string at the specified position.
				          KIOSK_FeedLine()                    //Feed 1 line.
				          KIOSK_FeedLines()                   //Feed paper forward.
				          KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				          KIOSK_P_PrintBmpInFlash()           //Print a bit image in Flash by specifying it's ID.
				          KIOSK_P_Clear()                     //Clear the buffer.
				          KIOSK_CutPaper()                    //Cut paper.
          Called By:      button_Print_Click(object sender, EventArgs e)   
          Input:          hPort: port handle
                          nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
          Return:         Returns True if successful, False if not successful.
        *******************************************************************************************************************************************/

        bool PrintInPageMode80_300DPI(int hPort, int nPortType)
        {
            bIsFirst = true;

            //Download images to RAM
            if (KIOSK_PreDownloadBmpToRAM(hPort, nPortType, "kitty.bmp", 2, 0) != KIOSK_SUCCESS) // ID number is 0
            {
                return false;
            }

            KIOSK_PreDownloadBmpToRAM(hPort, nPortType, "Look.bmp", 2, 1); // ID number is 1

            /*Print setting.*/
            KIOSK_Reset(hPort, nPortType);
            KIOSK_SetMode(hPort, nPortType, KIOSK_PRINT_MODE_PAGE);

            KIOSK_SetMotionUnit(hPort, nPortType, 203, 203);

            KIOSK_P_SetAreaAndDirection(hPort, nPortType, 0, 10, 640, 1200, KIOSK_AREA_LEFT_TO_RIGHT);

            KIOSK_SetRightSpacing(hPort, nPortType, 0);

            /*Text setting*/
            KIOSK_P_Textout(hPort, nPortType, "KIOSK Printer", 182, 80, 2, 2,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

            KIOSK_P_Textout(hPort, nPortType, "------------------------------------------", 95, 120, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


            KIOSK_P_Textout(hPort, nPortType, "------------------------------------------", 95, 140, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            //Different right-spacing
            KIOSK_SetRightSpacing(hPort, nPortType, 0);

            KIOSK_P_Textout(hPort, nPortType, "Right Spacing", 95, 180, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "KIOSK Printer", 330, 180, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_SetRightSpacing(hPort, nPortType, 2);

            KIOSK_P_Textout(hPort, nPortType, "Right Spacing", 95, 210, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "KIOSKPrinter", 330, 210, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_SetRightSpacing(hPort, nPortType, 4);

            KIOSK_P_Textout(hPort, nPortType, "Right Spacing", 95, 240, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "KIOSK Printer", 330, 240, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_SetRightSpacing(hPort, nPortType, 0);


            //Different font
            KIOSK_SetRightSpacing(hPort, nPortType, 2);

            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-NORMAL", 95, 300, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL); //Normal font


            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-BOLD", 95, 330, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-UNDERLINE", 95, 360, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);


            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-UNDERLINE", 95, 390, 1, 1,
                               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);


            KIOSK_P_Textout(hPort, nPortType, "FONTSTYLE-REVERSE", 95, 420, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE);

            KIOSK_P_Textout(hPort, nPortType, "------------------------------------", 95, 480, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            /*Bar code setting.*/
            KIOSK_P_Textout(hPort, nPortType, "Barcode - Code 128", 95, 505, 1, 1,
                                KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_PrintBarcode(hPort, nPortType, "{A*1234ABCDE*{C5678".ToCharArray(), 95, 580, KIOSK_BARCODE_TYPE_CODE128,
                                   2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19);



            KIOSK_P_Textout(hPort, nPortType, "------------------------------------", 95, 630, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            /*Bitmap setting.*/
            KIOSK_P_Textout(hPort, nPortType, "---------------Logo 1---------------", 95, 650, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_PrintBmpInRAM(hPort, nPortType, 0, 95, 720, KIOSK_BITMAP_PRINT_QUADRUPLE);


            KIOSK_P_Textout(hPort, nPortType, "---------------Logo 2---------------", 95, 740, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_PrintBmpInRAM(hPort, nPortType, 1, 95, 830, KIOSK_BITMAP_PRINT_QUADRUPLE);

            /*Print setting.*/
            KIOSK_P_Print(hPort, nPortType);

            KIOSK_P_Clear(hPort, nPortType);

            KIOSK_CutPaper(hPort, nPortType, 1, 0);
            return true;
        }
        #endregion

        #region 210mm_203DPI_Standard_Mode
        /******************************************************************************************************************************************
          Function:       PrintInStandardMode210_203DPI()
          Description:    print sample
          Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit image to Flash by specifying it's ID.
				          KIOSK_Reset()                       //Reset the printer.
				          KIOSK_SetMode()                     //Set the mode of printing.
                          KIOSK_SetMotionUnit()               //Set the units of motion.
                          KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
                          KIOSK_SetRightSpacing()             //Set the right spacing of character.
				          KIOSK_SetLineSpacing()              //Set the spacing of lines.
				          KIOSK_S_Textout()                   //Write one character string at the specified position.
				          KIOSK_FeedLine()                    //Feed 1 line.
				          KIOSK_FeedLines()                   //Feed paper forward.
				          KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				          KIOSK_S_PrintBmpInFlash()           //Print a bit image in Flash by specifying it's ID.
				          KIOSK_CutPaper()                    //Cut paper.
          Called By:      button_Print_Click(object sender, EventArgs e)    
          Input:          hPort: port handle
                          nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
          Return:         Returns True if successful, False if not successful.
        *******************************************************************************************************************************************/

        bool PrintInStandardMode210_203DPI(int hPort, int nPortType)
        {
            bIsFirst = true;

	        if( bIsFirst )
	        {
		        // Downloading images to Flash
                string[] pBitImages ={ "Map.bmp" };

                if (KIOSK_SUCCESS != KIOSK_PreDownloadBmpToFlash(hPort, nPortType, pBitImages, 2, 1))
		        {
			        return false;
		        }

		        bIsFirst = false;
	        }

            /*Print setting.*/
	        KIOSK_Reset( hPort,nPortType );

	        KIOSK_SetMode( hPort,nPortType, KIOSK_PRINT_MODE_STANDARD );
        	
	        if( KIOSK_SUCCESS != KIOSK_SetMotionUnit( hPort,nPortType, 203, 203 ) )
	        {
		        return false;
	        }	

            KIOSK_S_SetLeftMarginAndAreaWidth( hPort, nPortType, 100, 1500 );
        	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_SetLineSpacing( hPort, nPortType, 20 );

	        KIOSK_FeedLines( hPort,nPortType, 2 );

            /*Text setting*/
            KIOSK_S_Textout(hPort, nPortType, "Sample", 0, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_S_Textout(hPort, nPortType, "The method of calling functions of exported from KIOSKDLL", 800, 1, 1,
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_SetLineSpacing( hPort, nPortType, 20 );

	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "-----------------------------------------------------------------------------------------------------------------------------", 
						        0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine( hPort,nPortType );
	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 500, 3, 3,
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );        	

	        KIOSK_FeedLines( hPort,nPortType, 5 );
        	
	        KIOSK_SetLineSpacing( hPort, nPortType, 40 );

	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

            KIOSK_S_Textout(hPort, nPortType, "  In order to providing the user who use the KIOSK printer to carry on second development, we developed KIOSKDLL which supplys command to printer with DLL mode. This is good help for programmer to use KISSKDLL.", 
		                        0, 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLines( hPort,nPortType, 1 );

	        KIOSK_S_Textout( hPort, nPortType, "  We supply this sample to show our KIOSKDLL's function. You can also rewoke the resident sample by yourself.", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );        	

	        KIOSK_SetLineSpacing( hPort, nPortType, 15 );

	        KIOSK_FeedLines( hPort,nPortType, 4 );

	        KIOSK_S_Textout( hPort, nPortType, "Support port:",
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_S_Textout( hPort, nPortType, "COM", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	        KIOSK_S_Textout( hPort, nPortType, "LPT", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	        KIOSK_FeedLines( hPort,nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "USB", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	        KIOSK_S_Textout( hPort, nPortType, "Driver", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );


	        KIOSK_FeedLines( hPort,nPortType, 3 );


	        KIOSK_S_Textout( hPort, nPortType, "Support system:", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_S_Textout( hPort, nPortType, "Windows 2000", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "Windows 2003", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

            KIOSK_FeedLines( hPort,nPortType , 2 );

	        KIOSK_S_Textout( hPort, nPortType, "Windows XP", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "Windows Vista", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );



	        KIOSK_FeedLines( hPort,nPortType, 3 );

	        KIOSK_S_Textout( hPort, nPortType, "Support bar code:",
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_S_Textout( hPort, nPortType, "UPC-A", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "UPC-E", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "JAN13", 
		                        1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_FeedLine( hPort,nPortType );
	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "JAN8", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "CODE39", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "ITF", 
		                        1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_FeedLine( hPort,nPortType );
	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "CODEBAR", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "CODE93", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "CODE128", 
		                        1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_FeedLines( hPort,nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "PDF417", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );
        	
	        KIOSK_FeedLines( hPort,nPortType, 3 );

            KIOSK_S_Textout( hPort, nPortType, "Support equipment:", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_S_Textout( hPort, nPortType, "BK-T080", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_S_Textout( hPort, nPortType, "BK-W080", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_S_Textout( hPort, nPortType, "BK-S216", 
		                        1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_FeedLines( hPort,nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "BK-L216II", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_S_Textout( hPort, nPortType, "BK-W056", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_FeedLines( hPort,nPortType, 3 );

	        KIOSK_S_Textout( hPort, nPortType, "Paper   width:", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_S_Textout( hPort, nPortType, "210mm(216mm max)", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLines( hPort,nPortType, 3 );

	        KIOSK_S_Textout( hPort, nPortType, "Print   speed:", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_S_Textout( hPort, nPortType, "Max.125mm/s(203DPI)", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLines( hPort,nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "Max.100mm/s(300DPI)", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLines( hPort,nPortType, 3 );

            /*Bitmap setting.*/
	        KIOSK_S_Textout( hPort, nPortType, "Print   Bitmap:", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_PrintBmpInFlash( hPort, nPortType, 1, 500, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );

	        KIOSK_FeedLines( hPort,nPortType, 3 );
            
            /*Bar code setting.*/
	        KIOSK_S_Textout( hPort, nPortType, "Print   Bar Code:", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

            KIOSK_S_Textout( hPort, nPortType, "Barcode - Code 128",
		                        440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine(hPort, nPortType );
	        KIOSK_FeedLine(hPort, nPortType );

	        KIOSK_S_PrintBarcode( hPort, nPortType, "{A*1234ABCDE*{C5678".ToCharArray(), 440, KIOSK_BARCODE_TYPE_CODE128,
		                            3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	        KIOSK_FeedLines( hPort,nPortType, 3 );

	        KIOSK_S_Textout( hPort, nPortType, "-----------------------------------------------------------------------------------------------------------------------------", 
						        0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine( hPort,nPortType );

            KIOSK_S_Textout(hPort, nPortType, "Your thermal printer partner", 
						        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            /*Print setting.*/
	        KIOSK_FeedLine( hPort,nPortType );
	        KIOSK_FeedLine( hPort,nPortType );
	        KIOSK_FeedLine( hPort,nPortType );
	        KIOSK_FeedLine( hPort,nPortType );
        	
	        //Cut paper
	        KIOSK_CutPaper( hPort, nPortType, 1, 0 );

	        return true;
        }
        #endregion

        #region 210mm_203DPI_Page_mode
        /******************************************************************************************************************************************
          Function:       PrintInPageMode210_203DPI()
          Description:    print sample
          Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit image to Flash by specifying it's ID.
				          KIOSK_Reset()                       //Reset the printer.
				          KIOSK_SetMode()                     //Set the mode of printing.
                          KIOSK_SetMotionUnit()               //Set the units of motion.
                          KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
                          KIOSK_P_Clear()                     //Clear the buffer.
				          KIOSK_SetRightSpacing()             //Set the right spacing of character.
				          KIOSK_SetLineSpacing()              //Set the spacing of lines.
				          KIOSK_P_Textout()                   //Write one character string at the specified position.
				          KIOSK_FeedLine()                    //Feed 1 line.
				          KIOSK_FeedLines()                   //Feed paper forward.
				          KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				          KIOSK_P_PrintBmpInFlash()           //Print a bit image in Flash by specifying it's ID.
				          KIOSK_P_Clear()                     //Clear the buffer.
				          KIOSK_CutPaper()                    //Cut paper.
          Called By:      button_Print_Click(object sender, EventArgs e)    
          Input:          hPort: port handle
                          nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
          Return:         Returns True if successful, False if not successful.
        *******************************************************************************************************************************************/
        bool PrintInPageMode210_203DPI(int hPort, int nPortType)
        {
            //Download images to RAM
            if (KIOSK_PreDownloadBmpToRAM(hPort, nPortType, "Map.bmp", 2, 0) != KIOSK_SUCCESS) // ID number is 0
            {
                return false;
            }

            /*Print setting.*/
            KIOSK_Reset(hPort, nPortType);
            KIOSK_SetMode(hPort, nPortType, KIOSK_PRINT_MODE_PAGE);

            KIOSK_SetMotionUnit(hPort, nPortType, 203, 203);

            KIOSK_P_SetAreaAndDirection(hPort, nPortType, 95, 0, 1500, 2400, KIOSK_AREA_LEFT_TO_RIGHT);

            KIOSK_SetRightSpacing(hPort, nPortType, 0);

            /*Text setting*/
            KIOSK_P_Textout(hPort, nPortType, "Sample", 0, 100, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "The method of calling functions of exported from KIOSKDLL", 800, 100, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "-----------------------------------------------------------------------------------------------------------------------------",
                                0, 150, 1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "KIOSK Printer",
                                500, 250, 3, 3, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

            KIOSK_SetLineSpacing(hPort, nPortType, 40);

            KIOSK_SetRightSpacing(hPort, nPortType, 0);

            KIOSK_P_Textout(hPort, nPortType, "  In order to providing the user who use the KIOSK printer to carry on second development, we developed KIOSKDLL which supplys command to printer with DLL mode. This is good help for programmer to use KISSKDLL.",
                                0, 350, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "  We supply this sample to show our KIOSKDLL's function. You can also rewoke the resident sample by yourself.",
                                0, 500, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_SetLineSpacing(hPort, nPortType, 15);

            KIOSK_P_Textout(hPort, nPortType, "Support port:",
                                0, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "COM",
                                440, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

            KIOSK_P_Textout(hPort, nPortType, "LPT",
                                800, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

            KIOSK_P_Textout(hPort, nPortType, "USB",
                                440, 660, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

            KIOSK_P_Textout(hPort, nPortType, "Driver",
                                800, 660, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

            KIOSK_P_Textout(hPort, nPortType, "Support system:",
                                0, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "Windows 2000",
                                440, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "Windows 2003",
                                800, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "Windows XP",
                                440, 760, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "Windows Vista",
                                800, 760, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "Support bar code:",
                                0, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "UPC-A",
                                440, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "UPC-E",
                                800, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "JAN13",
                                1200, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "JAN8",
                                440, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "CODE39",
                                800, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "ITF",
                                1200, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "CODEBAR",
                                440, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "CODE93",
                                800, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "CODE128",
                                1200, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);


            KIOSK_P_Textout(hPort, nPortType, "PDF417",
                                440, 955, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "Support equipment:",
                                0, 1020, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "BK-T080",
                                440, 1020, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE);

            KIOSK_P_Textout(hPort, nPortType, "BK-W080",
                                800, 1020, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE);

            KIOSK_P_Textout(hPort, nPortType, "BK-S216",
                                1200, 1020, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE);

            KIOSK_P_Textout(hPort, nPortType, "BK-L216II",
                                440, 1065, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE);

            KIOSK_P_Textout(hPort, nPortType, "BK-W056",
                                800, 1065, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE);

            KIOSK_P_Textout(hPort, nPortType, "Paper   width:",
                                0, 1125, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "210mm(216mm max)",
                                440, 1125, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "Print   speed:",
                                0, 1185, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "Max.125mm/s(203DPI)",
                                440, 1185, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);


            KIOSK_P_Textout(hPort, nPortType, "Max.100mm/s(300DPI)",
                                440, 1220, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            /*Bitmap setting.*/
            KIOSK_P_Textout(hPort, nPortType, "Print   Bitmap:",
                                0, 1280, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_PrintBmpInFlash(hPort, nPortType, 1, 500, 1380, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH);

            /*Bar code setting.*/
            KIOSK_P_Textout(hPort, nPortType, "Print   Bar Code:",
                                0, 1440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "Barcode - Code 128",
                                440, 1440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_PrintBarcode(hPort, nPortType, "{A*1234ABCDE*{C5678".ToCharArray(), 440, 1555, KIOSK_BARCODE_TYPE_CODE128,
                                    3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19);

            KIOSK_P_Textout(hPort, nPortType, "-----------------------------------------------------------------------------------------------------------------------------",
                                0, 1630, 1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "Your thermal printer partner",
                                800, 1645, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);
            
            /*Print setting.*/
            KIOSK_P_Print(hPort, nPortType);

            KIOSK_P_Clear(hPort, nPortType);

            KIOSK_CutPaper(hPort, nPortType, 0, 0);
            return true;
        }
        #endregion

        #region 210mm_300DPI_Standard_Mode
        /******************************************************************************************************************************************
          Function:       PrintInStandardMode210_300DPI()
          Description:    print sample
          Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit image to Flash by specifying it's ID.
				          KIOSK_Reset()                       //Reset the printer.
				          KIOSK_SetMode()                     //Set the mode of printing.
                          KIOSK_SetMotionUnit()               //Set the units of motion.
                          KIOSK_S_SetLeftMarginAndAreaWidth() //Set the width of printing area.
                          KIOSK_SetRightSpacing()             //Set the right spacing of character.
				          KIOSK_SetLineSpacing()              //Set the spacing of lines.
				          KIOSK_S_Textout()                   //Write one character string at the specified position.
				          KIOSK_FeedLine()                    //Feed 1 line.
				          KIOSK_FeedLines()                   //Feed paper forward.
				          KIOSK_S_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				          KIOSK_S_PrintBmpInFlash()           //Print a bit image in Flash by specifying it's ID.
				          KIOSK_CutPaper()                    //Cut paper.
          Called By:      button_Print_Click(object sender, EventArgs e)    
          Input:          hPort: port handle
                          nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
          Return:         Returns True if successful, False if not successful.
        *******************************************************************************************************************************************/
        bool PrintInStandardMode210_300DPI(int hPort, int nPortType)
        {
            bIsFirst = true;
	        
	        if( bIsFirst )
	        {
		        // Downloading images to Flash
                string[] pBitImages = { "Map.bmp" };

                if (KIOSK_SUCCESS != KIOSK_PreDownloadBmpToFlash(hPort, nPortType, pBitImages, 2, 1))
		        {
			        return false;
		        }

		        bIsFirst = false;
	        }

            /*Print setting.*/
	        KIOSK_Reset( hPort,nPortType );

	        KIOSK_SetMode( hPort,nPortType, KIOSK_PRINT_MODE_STANDARD );
        	
	        if( KIOSK_SUCCESS != KIOSK_SetMotionUnit( hPort,nPortType, 203, 203 ) )
	        {
		        return false;
	        }	

            KIOSK_S_SetLeftMarginAndAreaWidth( hPort, nPortType, 100, 1500 );
        	
	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

	        KIOSK_SetLineSpacing( hPort, nPortType, 20 );

	        KIOSK_FeedLines( hPort,nPortType, 2 );

            /*Text setting*/
            KIOSK_S_Textout(hPort, nPortType, "Sample", 0, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_S_Textout(hPort, nPortType, "The method of calling functions of exported from KIOSKDLL", 950, 1, 1,
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_SetLineSpacing( hPort, nPortType, 20 );

	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_Textout( hPort, nPortType, 
	        			"---------------------------------------------------------------------------------------------------------------------------------------------------------------------------", 
						        0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine( hPort,nPortType );
	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "KIOSK Printer", 500, 3, 3,
		                        KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );                  	

	        KIOSK_FeedLines( hPort,nPortType, 5 );
        	
	        KIOSK_SetLineSpacing( hPort, nPortType, 40 );

	        KIOSK_SetRightSpacing( hPort, nPortType, 0 );

            KIOSK_S_Textout(hPort, nPortType, "  In order to providing the user who use the KIOSK printer to carry on second development, we developed KIOSKDLL which supplys command to printer with DLL mode. This is good help for programmer to use KISSKDLL.", 
		                        0, 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLines( hPort,nPortType, 1 );

	        KIOSK_S_Textout( hPort, nPortType, "  We supply this sample to show our KIOSKDLL's function. You can also rewoke the resident sample by yourself.", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );       	

	        KIOSK_SetLineSpacing( hPort, nPortType, 15 );

	        KIOSK_FeedLines( hPort,nPortType, 4 );

	        KIOSK_S_Textout( hPort, nPortType, "Support port:",
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_S_Textout( hPort, nPortType, "COM", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	        KIOSK_S_Textout( hPort, nPortType, "LPT", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	        KIOSK_FeedLines( hPort,nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "USB", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	        KIOSK_S_Textout( hPort, nPortType, "Driver", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	        KIOSK_FeedLines( hPort,nPortType, 3 );

	        KIOSK_S_Textout( hPort, nPortType, "Support system:", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_S_Textout( hPort, nPortType, "Windows 2000", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "Windows 2003", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

            KIOSK_FeedLines( hPort,nPortType , 2 );

	        KIOSK_S_Textout( hPort, nPortType, "Windows XP", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "Windows Vista", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	        KIOSK_FeedLines( hPort,nPortType, 3 );

	        KIOSK_S_Textout( hPort, nPortType, "Support bar code:",
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_S_Textout( hPort, nPortType, "UPC-A", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "UPC-E", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "JAN13", 
		                        1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_FeedLine( hPort,nPortType );
	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "JAN8", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "CODE39", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "ITF", 
		                        1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_FeedLine( hPort,nPortType );
	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_Textout( hPort, nPortType, "CODEBAR", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "CODE93", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_S_Textout( hPort, nPortType, "CODE128", 
		                        1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	        KIOSK_FeedLines( hPort,nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "PDF417", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );
        	
	        KIOSK_FeedLines( hPort,nPortType, 3 );

            KIOSK_S_Textout( hPort, nPortType, "Support equipment:", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_S_Textout( hPort, nPortType, "BK-T080", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_S_Textout( hPort, nPortType, "BK-W080", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_S_Textout( hPort, nPortType, "BK-S216", 
		                        1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_FeedLines( hPort,nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "BK-L216II", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_S_Textout( hPort, nPortType, "BK-W056", 
		                        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	        KIOSK_FeedLines( hPort,nPortType, 3 );

	        KIOSK_S_Textout( hPort, nPortType, "Paper   width:", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_S_Textout( hPort, nPortType, "210mm(216mm max)", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLines( hPort,nPortType, 3 );

	        KIOSK_S_Textout( hPort, nPortType, "Print   speed:", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_S_Textout( hPort, nPortType, "Max.125mm/s(203DPI)", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLines( hPort,nPortType, 2 );

	        KIOSK_S_Textout( hPort, nPortType, "Max.100mm/s(300DPI)", 
		                        440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLines( hPort,nPortType, 3 );

            /*Bitmap setting.*/
	        KIOSK_S_Textout( hPort, nPortType, "Print   Bitmap:", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	        KIOSK_FeedLine( hPort,nPortType );

	        KIOSK_S_PrintBmpInFlash( hPort, nPortType, 1, 500, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );

	        KIOSK_FeedLines( hPort,nPortType, 3 );

            /*Bar code setting.*/
	        KIOSK_S_Textout( hPort, nPortType, "Print   Bar Code:", 
		                        0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

            KIOSK_S_Textout( hPort, nPortType, "Barcode - Code 128",
		                        440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine(hPort, nPortType );

	        KIOSK_S_PrintBarcode( hPort, nPortType, "{A*1234ABCDE*{C5678".ToCharArray(), 440, KIOSK_BARCODE_TYPE_CODE128,
		                            3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	        KIOSK_FeedLines( hPort,nPortType, 3 );

	        KIOSK_S_Textout( hPort, nPortType, "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------", 
						        0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	        KIOSK_FeedLine( hPort,nPortType );

            KIOSK_S_Textout(hPort, nPortType, "Your thermal printer partner", 
						        800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            /*Print setting*/
	        KIOSK_FeedLine( hPort,nPortType );
	        KIOSK_FeedLine( hPort,nPortType );
	        KIOSK_FeedLine( hPort,nPortType );
	        KIOSK_FeedLine( hPort,nPortType );
        	
	        //Cut paper
	        KIOSK_CutPaper( hPort, nPortType, 1, 0 );

	        return true;
        }
        #endregion

        #region 210mm_300DPI_Page_Mode
        /******************************************************************************************************************************************
          Function:       PrintInPageMode210_300DPI()
          Description:    print sample
          Calls:          KIOSK_PreDownloadBmpToFlash()       //Pre-download a group of bit image to Flash by specifying it's ID.
				          KIOSK_Reset()                       //Reset the printer.
				          KIOSK_SetMode()                     //Set the mode of printing.
                          KIOSK_SetMotionUnit()               //Set the units of motion.
                          KIOSK_P_SetAreaAndDirection()       //Set the width of printing area and the direction.
                          KIOSK_P_Clear()                     //Clear the buffer.
				          KIOSK_SetRightSpacing()             //Set the right spacing of character.
				          KIOSK_SetLineSpacing()              //Set the spacing of lines.
				          KIOSK_P_Textout()                   //Write one character string at the specified position.
				          KIOSK_FeedLine()                    //Feed 1 line.
				          KIOSK_FeedLines()                   //Feed paper forward.
				          KIOSK_P_PrintBarcode()              //Print bar code at the specified location, with setting the bar code's parameters.
				          KIOSK_P_PrintBmpInFlash()           //Print a bit image in Flash by specifying it's ID.
				          KIOSK_P_Clear()                     //Clear the buffer.
				          KIOSK_CutPaper()                    //Cut paper.
          Called By:      button_Print_Click(object sender, EventArgs e)    
          Input:          hPort: port handle
                          nPortType: 0-serial port;1-LPT port;2-USB port;3-driver port
          Return:         Returns True if successful, False if not successful.
        *******************************************************************************************************************************************/
        bool PrintInPageMode210_300DPI(int hPort, int nPortType)
        {
            //Download images to RAM
            if (KIOSK_PreDownloadBmpToRAM(hPort, nPortType, "Map.bmp", 2, 0) != KIOSK_SUCCESS) // ID number is 0
            {
                return false;
            }

            /*Print setting.*/
            KIOSK_Reset(hPort, nPortType);
            KIOSK_SetMode(hPort, nPortType, KIOSK_PRINT_MODE_PAGE);

            KIOSK_SetMotionUnit(hPort, nPortType, 203, 203);

            KIOSK_P_SetAreaAndDirection(hPort, nPortType, 95, 0, 1500, 2400, KIOSK_AREA_LEFT_TO_RIGHT);

            KIOSK_SetRightSpacing(hPort, nPortType, 0);

            /*Text setting*/
            KIOSK_P_Textout(hPort, nPortType, "Sample", 0, 100, 1, 1,
                                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "The method of calling functions of exported from KIOSKDLL", 950, 100, 1, 1,
                                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------",
                                0, 150, 1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "KIOSK Printer",
                                500, 250, 3, 3, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

            KIOSK_SetLineSpacing(hPort, nPortType, 40);

            KIOSK_SetRightSpacing(hPort, nPortType, 0);

            KIOSK_P_Textout(hPort, nPortType, "  In order to providing the user who use the KIOSK printer to carry on second development, we developed KIOSKDLL which supplys command to printer with DLL mode. This is good help for programmer to use KISSKDLL.",
                                0, 350, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "  We supply this sample to show our KIOSKDLL's function. You can also rewoke the resident sample by yourself.",
                                0, 500, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_SetLineSpacing(hPort, nPortType, 15);

            KIOSK_P_Textout(hPort, nPortType, "Support port:",
                                0, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "COM",
                                440, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

            KIOSK_P_Textout(hPort, nPortType, "LPT",
                                800, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

            KIOSK_P_Textout(hPort, nPortType, "USB",
                                440, 660, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

            KIOSK_P_Textout(hPort, nPortType, "Driver",
                                800, 660, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

            KIOSK_P_Textout(hPort, nPortType, "Support system:",
                                0, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "Windows 2000",
                                440, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "Windows 2003",
                                800, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "Windows XP",
                                440, 760, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "Windows Vista",
                                800, 760, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "Support bar code:",
                                0, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "UPC-A",
                                440, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "UPC-E",
                                800, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "JAN13",
                                1200, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "JAN8",
                                440, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "CODE39",
                                800, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "ITF",
                                1200, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "CODEBAR",
                                440, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "CODE93",
                                800, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "CODE128",
                                1200, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "PDF417",
                                440, 955, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE);

            KIOSK_P_Textout(hPort, nPortType, "Support equipment:",
                                0, 1020, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "BK-T080",
                                440, 1020, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE);

            KIOSK_P_Textout(hPort, nPortType, "BK-W080",
                                800, 1020, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE);

            KIOSK_P_Textout(hPort, nPortType, "BK-S216",
                                1200, 1020, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE);

            KIOSK_P_Textout(hPort, nPortType, "BK-L216II",
                                440, 1065, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE);

            KIOSK_P_Textout(hPort, nPortType, "BK-W056",
                                800, 1065, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE);

            KIOSK_P_Textout(hPort, nPortType, "Paper   width:",
                                0, 1125, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "210mm(216mm max)",
                                440, 1125, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "Print   speed:",
                                0, 1185, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "Max.125mm/s(203DPI)",
                                440, 1185, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "Max.100mm/s(300DPI)",
                                440, 1220, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            /*Bitmap setting.*/
            KIOSK_P_Textout(hPort, nPortType, "Print   Bitmap:",
                                0, 1280, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_PrintBmpInFlash(hPort, nPortType, 1, 500, 1380, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH);

            /*Bar code setting.*/
            KIOSK_P_Textout(hPort, nPortType, "Print   Bar Code:",
                                0, 1440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "Barcode - Code 128",
                                440, 1440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_PrintBarcode(hPort, nPortType, "{A*1234ABCDE*{C5678".ToCharArray(), 440, 1555, KIOSK_BARCODE_TYPE_CODE128,
                                    3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19);

            KIOSK_P_Textout(hPort, nPortType, "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------",
                                0, 1630, 1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            KIOSK_P_Textout(hPort, nPortType, "Your thermal printer partner",
                                800, 1645, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

            /*Print setting.*/
            KIOSK_P_Print(hPort, nPortType);

            KIOSK_P_Clear(hPort, nPortType);

            KIOSK_CutPaper(hPort, nPortType, 0, 0);       
            return true;
        }
        #endregion

        #endregion        

        private void button_Open_Click(object sender, EventArgs e)
        {
	        //Open COM
            if (nPortType == PORT_TYPE_COM)
	        {
		        string PortName;        //Port name 
                int nComBaudrate;       //Bits per second 
                int nComByteSize;       //Data bits
                int nComStopBits;       //Parity
                int nComParity;         //Stop bits
                int nComFlowControl;    //Flow control

		        //Get COM name
                PortName = comboBox_ComName.Text;
        		
		        //Set Data bits
                nComByteSize = comboBox_DataBits.SelectedIndex + 7;
		        
                switch (comboBox_Baudrate.SelectedIndex)
		        {		
		        case 0:
			        nComBaudrate = 2400;
			        break;

		        case 1:
			        nComBaudrate = 4800;
			        break;

		        case 2:
			        nComBaudrate = 9600;
			        break;

		        case 3:
			        nComBaudrate = 19200;
			        break;

		        case 4:
			        nComBaudrate = 38400;
			        break;

		        case 5:
			        nComBaudrate = 57600;
			        break;

		        case 6:
			        nComBaudrate = 115200;
			        break;

		        default:
			        nComBaudrate = 38400;
			        break;
		        }

		        //Set Stop bits
		        if( comboBox_StopBits.SelectedIndex == 0 )//Stop bits is 1
		        {
			        nComStopBits = 0x00;
		        }
                else//Stop bits is 2
		        {
			        nComStopBits = 0x01;
		        }

		        //Set Parity
                int tmp = 0;
                tmp = comboBox_Parity.SelectedIndex;

		        if( tmp == 0 )//NONE
		        {
			        nComParity = 0x00;
		        }
		        else if( tmp == 1 )//ODD
		        {
			        nComParity = 0x01;
		        }
		        else if( tmp == 2 )//EVEN
		        {
			        nComParity = 0x02;
		        }
		        else if( tmp == 3 )//MARK
		        {
			        nComParity = 0x03;
		        }
		        else//SPACE
		        {
			        nComParity = 0x00;
		        }

		        //Set flow control
                nComFlowControl = comboBox_FlowControl.SelectedIndex;

                hPort = KIOSK_OpenCom(PortName, nComBaudrate, nComByteSize, nComStopBits, nComParity, nComFlowControl);
        	   
	            if( hPort == -1 )
		        {
                    textBox_Msg.Text = "Open COM failed!";
		        }
		        else
		        {
                    int WriteTimeout = 0;
                    int ReadTimeout = 0;
                    WriteTimeout = Convert.ToInt32(textBox_WriteTimeOut.Text);
                    ReadTimeout = Convert.ToInt32(textBox_ReadTimeOut.Text);

                    if (KIOSK_SetComTimeOuts(hPort, 90000, WriteTimeout, ReadTimeout, ReadTimeout) != KIOSK_SUCCESS)
			        {	
				        textBox_Msg.Text = "Open COM success,but set timeouts error!";
                        return;
			        }

                    textBox_Msg.Text = "Open COM success!";	

                    button_Open.Enabled = false;
                    button_Query.Enabled = true;
			        button_Print.Enabled = true;
                    button_Close.Enabled = true;
                    button_Start.Enabled = true;
                    button_PDF417.Enabled = true;
                    button_PrintSample.Enabled = true;
		        }
	        }

	        //Open LPT
            if (nPortType == PORT_TYPE_LPT)
            {
                ushort LPTAddress = 0;

                int tmp = comboBox_LPTAddress.SelectedIndex;
                if( tmp == 0 )
                {
                    LPTAddress = 0x0378; //LPT 1
                }
                if( tmp == 1)
                {
                    LPTAddress = 0x0278; //LPT 2
                }

                hPort = KIOSK_OpenLptByDrv( LPTAddress );

                if ( hPort == -1 )
                {
                    textBox_Msg.Text = "Open DrvLpt failed!";
                }
                else
                {
                    textBox_Msg.Text = "Open DrvLpt success!";

                    button_Open.Enabled = false;
                    button_Print.Enabled = true;
                    button_Close.Enabled = true;
                    button_PDF417.Enabled = true;
                    button_PrintSample.Enabled = true;
                }
            }
           
            //Open USB
            if (nPortType == PORT_TYPE_USB)
            {
                hPort = KIOSK_OpenUsb();

                if( hPort == -1 )
                {
                    textBox_Msg.Text = "Open USB failed!";
                }
                else
                {
                    ushort WriteTimeout = 0;
                    ushort ReadTimeout = 0;
                    WriteTimeout = Convert.ToUInt16(textBox_WriteTimeOut.Text);
                    ReadTimeout = Convert.ToUInt16(textBox_ReadTimeOut.Text);

                    if (KIOSK_SetUsbTimeOuts(hPort, ReadTimeout, WriteTimeout) != KIOSK_SUCCESS)
                    {
                        textBox_Msg.Text = "Open USB success,but set timeouts error!";
                        return;
                    }
                    textBox_Msg.Text = "Open USB success!";

                    button_Open.Enabled = false;
                    button_Query.Enabled = true;
                    button_Print.Enabled = true;
                    button_Close.Enabled = true;
                    button_Start.Enabled = true;
                    button_PDF417.Enabled = true;
                    button_PrintSample.Enabled = true;
                }
            }

            //Open driver
	        if( nPortType == PORT_TYPE_DRV )
	        {
		        IsPrinter = true;

		        string printername;

                if (0 == comboBox_DriverName.Items.Count)
                {
                    textBox_Msg.Text = "";
                    return;
                }

		        //Get driver name 
                printername = comboBox_DriverName.Text;

                hPort = KIOSK_OpenDrv(printername.ToCharArray());

		        if( hPort == -1 )
		        {
			        textBox_Msg.Text = "Open Drv failed!";
		        }
		        else
		        {
			        textBox_Msg.Text = "Open Drv success!";	

			        button_Open.Enabled = false;
                    button_Print.Enabled = true;
                    button_Close.Enabled = true;
                    button_PDF417.Enabled = true;
                    button_PrintSample.Enabled = true;
		        }
	        }
        }

        private void Form_Main_Load(object sender, EventArgs e)
        {
            comboBox_ComName.SelectedIndex = 0;
            comboBox_Parity.SelectedIndex = 0;
            comboBox_Baudrate.SelectedIndex = 4;
            comboBox_StopBits.SelectedIndex = 0;
            comboBox_DataBits.SelectedIndex = 1;
            comboBox_FlowControl.SelectedIndex = 0;
            comboBox_LPTAddress.SelectedIndex = 0;
            comboBox_PageWidth.SelectedIndex = 1;
            comboBox_DPI.SelectedIndex = 0;

            PrintDocument prtdoc = new PrintDocument();
            string strDefaultPrinter = prtdoc.PrinterSettings.PrinterName;
            foreach (String strPrinter in PrinterSettings.InstalledPrinters)				
            {
                if (strPrinter.Contains("BK"))
                {
                    comboBox_DriverName.Items.Add(strPrinter);
                }

                if (comboBox_DriverName.Items.Count != 0)
                {
                    comboBox_DriverName.SelectedIndex = 0;
                }
            }
            if (comboBox_DriverName.Items.Count == 0)
            {
                textBox_Msg.Text = "Don't install printer";
            }
        }

        private void button_Exit_Click(object sender, EventArgs e)
        {
            bThreadRunning = false;
            Close();
        }

        private void button_Close_Click(object sender, EventArgs e)
        {
            bThreadRunning = false;
            button_Open.Enabled = true;
            button_Query.Enabled = false;
            button_Print.Enabled = false;
            button_Close.Enabled = false;
            button_Start.Enabled = false;
            button_Stop.Enabled = false;
            button_PDF417.Enabled = false;
            button_PrintSample.Enabled = false;

            //COM
            if (nPortType == PORT_TYPE_COM)
            {
                if (hPort != -1)
                {
                    if (KIOSK_CloseCom(hPort) != KIOSK_SUCCESS)
                    {
                        textBox_Msg.Text = "Close COM error!";
                    }
                }

                textBox_Msg.Text = "Close Com success!";
            }

            //LPT
            if (nPortType == PORT_TYPE_LPT)
            {
                if (KIOSK_CloseDrvLPT(1) != KIOSK_SUCCESS)
                {
                    textBox_Msg.Text = "Close DrvLpt error!";
                }
                else
                {
                    textBox_Msg.Text = "Close DrvLpt success!";
                }
            }


            //USB
            if (nPortType == PORT_TYPE_USB)
            {
                if (hPort != -1)
                {
                    if (KIOSK_CloseUsb(hPort) != KIOSK_SUCCESS)
                    {
                        textBox_Msg.Text = "Close USB error!";
                    }
                }

                textBox_Msg.Text = "Close USB success!";
            }

            //Driver
            if (nPortType == PORT_TYPE_DRV)
            {
                if (hPort != -1)
                {
                    if (KIOSK_CloseDrv(hPort) != KIOSK_SUCCESS)
                    {
                        textBox_Msg.Text = "Close Drv error!";
                    }
                }

                textBox_Msg.Text = "Close Drv success!";

                IsPrinter = false;
            }

            hPort = -1;
        }

        private bool PrintSample()
        {
            int PageWidth = comboBox_PageWidth.SelectedIndex;
            int DPI = comboBox_DPI.SelectedIndex;

            if (IsPrinter)  //When it is driver
            {
                KIOSK_StartDoc(hPort);
            }

            //Send data to "Test.dat"
            if (bSaveToTxt)
            {
                KIOSK_BeginSaveToFile(hPort, "Test.dat", false);
            }

            //StandardMode
            if (nMode == 0)
            {
                //56mm
                if (PageWidth == 0)
                {
                    //203dpi
                    if (DPI == 0)
                    {
                        if (PrintInStandardMode56_203DPI(hPort, nPortType))
                        {
                            textBox_Msg.Text = "Print success!";
                        }
                        else
                        {
                            textBox_Msg.Text = "Print failed!";
                            bThreadRunning = false;
                            return false;
                        }
                    }
                    //300dpi
                    if (DPI == 1)
                    {
                        if (PrintInStandardMode56_300DPI(hPort, nPortType))
                        {
                            textBox_Msg.Text = "Print success!";
                        }
                        else
                        {
                            textBox_Msg.Text = "Print failed!";
                            bThreadRunning = false;
                            return false;
                        }
                    }
                }
                //80mm
                if (PageWidth == 1)
                {
                    //203dpi
                    if (DPI == 0)
                    {
                        if (PrintInStandardMode80_203DPI(hPort, nPortType))
                        {
                            textBox_Msg.Text = "Print success!";
                        }
                        else
                        {
                            textBox_Msg.Text = "Print failed!";
                            bThreadRunning = false;

                            return false;
                        }
                    }
                    //300dpi
                    if (DPI == 1)
                    {
                        if (PrintInStandardMode80_300DPI(hPort, nPortType))
                        {
                            textBox_Msg.Text = "Print success!";
                        }
                        else
                        {
                            textBox_Msg.Text = "Print failed!";
                            bThreadRunning = false;

                            return false;
                        }
                    }
                }
                //210mm
                if (PageWidth == 2)
                {
                    //203dpi
                    if (DPI == 0)
                    {
                        if (PrintInStandardMode210_203DPI(hPort, nPortType))
                        {
                            textBox_Msg.Text = "Print success!";
                        }
                        else
                        {
                            textBox_Msg.Text = "Print failed!";
                            bThreadRunning = false;

                            return false;
                        }
                    }
                    //300dpi
                    if (DPI == 1)
                    {
                        if (PrintInStandardMode210_300DPI(hPort, nPortType))
                        {
                            textBox_Msg.Text = "Print success!";
                        }
                        else
                        {
                            textBox_Msg.Text = "Print failed!";
                            bThreadRunning = false;

                            return false;
                        }
                    }
                }
            }

            //PageMode
            if (nMode == 1)
            {
                //56mm
                if (PageWidth == 0)
                {
                    //203dpi
                    if (DPI == 0)
                    {
                        if (PrintInPageMode56_203DPI(hPort, nPortType))
                        {
                            textBox_Msg.Text = "Print success!";
                        }
                        else
                        {
                            textBox_Msg.Text = "Print fail!";
                            bThreadRunning = false;

                            return false;
                        }
                    }
                    //300dpi
                    if (DPI == 1)
                    {
                        if (PrintInPageMode56_300DPI(hPort, nPortType))
                        {
                            textBox_Msg.Text = "Print success!";
                        }
                        else
                        {
                            textBox_Msg.Text = "Print failed!";
                            bThreadRunning = false;

                            return false;
                        }
                    }
                }
                //80mm
                if (PageWidth == 1)
                {
                    //230dpi
                    if (DPI == 0)
                    {
                        if (PrintInPageMode80_203DPI(hPort, nPortType))
                        {
                            textBox_Msg.Text = "Print success!";
                        }
                        else
                        {
                            textBox_Msg.Text = "Print failed!";
                            bThreadRunning = false;

                            return false;
                        }
                    }
                    //300dpi
                    if (DPI == 1)
                    {
                        if (PrintInPageMode80_300DPI(hPort, nPortType))
                        {
                            textBox_Msg.Text = "Print success!";
                        }
                        else
                        {
                            textBox_Msg.Text = "Print failed!";
                            bThreadRunning = false;

                            return false;
                        }
                    }
                }
                //210mm
                if (PageWidth == 2)
                {
                    //203dpi
                    if (DPI == 0)
                    {
                        if (PrintInPageMode210_203DPI(hPort, nPortType))
                        {
                            textBox_Msg.Text = "Print success!";
                        }
                        else
                        {
                            textBox_Msg.Text = "Print failed!";
                            bThreadRunning = false;
                            return false;
                        }
                    }
                    //300dpi
                    if (DPI == 1)
                    {
                        if (PrintInPageMode210_300DPI(hPort, nPortType))
                        {
                            textBox_Msg.Text = "Print success!";
                        }
                        else
                        {
                            textBox_Msg.Text = "Print fail!";
                            bThreadRunning = false;

                            return false;
                        }
                    }
                }
            }

            if (nPaperOut == 0)
            {
                switch (nPresenter)
                {
                    //Set Presenter
                    case 0:
                        {
                            if (KIOSK_SetPresenter(hPort, nPortType, KIOSK_PRESENTER_Retraction_on, 3) != KIOSK_SUCCESS)
                            {
                                textBox_Msg.Text = "Set Presenter fail!";
                            }
                        }
                        break;

                    case 1:
                        {
                            if (KIOSK_SetPresenter(hPort, nPortType, KIOSK_PRESENTER_Paper_Forward, 3) != KIOSK_SUCCESS)
                            {
                                textBox_Msg.Text = "Set Presenter fail!";
                            }
                        }
                        break;

                    case 2:
                        {
                            if (KIOSK_SetPresenter(hPort, nPortType, KIOSK_PRESENTER_Paper_Hold, 3) != KIOSK_SUCCESS)
                            {
                                textBox_Msg.Text = "Set Presenter fail!";
                            }
                        }
                        break;
                }
            }
            else if (nPaperOut == 1)
            {
                switch (nBundler)
                {
                    //Set Bundler
                    case 0:
                        {
                            if (KIOSK_SetBundler(hPort, nPortType, KIOSK_BUNDLER_Petract, 3) != KIOSK_SUCCESS)
                            {
                                textBox_Msg.Text = "Set Bundler fail!";
                            }
                        }
                        break;

                    case 1:
                        {
                            if (KIOSK_SetBundler(hPort, nPortType, KIOSK_BUNDLER_Present, 3) != KIOSK_SUCCESS)
                            {
                                textBox_Msg.Text = "Set Bundler fail!";
                            }
                        }
                        break;
                }
            }

            // Stop saving data to file.
            if (bSaveToTxt)
            {
                KIOSK_EndSaveToFile(hPort);
            }

            if (IsPrinter) //When it is driver 
            {
                KIOSK_EndDoc(hPort);
            }

            return true;
        }

        private void button_Print_Click(object sender, EventArgs e)
        {
            if (!PrintSample())
            {
                button_Close_Click(sender, e);
            }
        }

        private void radioButton_COM_Click(object sender, EventArgs e)
        {
            comboBox_ComName.Enabled = true;
            comboBox_Parity.Enabled = true;
            comboBox_Baudrate.Enabled = true;
            comboBox_StopBits.Enabled = true;
            comboBox_DataBits.Enabled = true;
            comboBox_FlowControl.Enabled = true;

            comboBox_LPTAddress.Enabled = false;

            textBox_ReadTimeOut.Enabled = true;
            textBox_WriteTimeOut.Enabled = true;
            textBox_ReadTimeOut.Text = "3000";
            textBox_WriteTimeOut.Text = "90000";

            comboBox_DriverName.Enabled = false;

            if (hPort != -1)
            {
                button_Close_Click(sender, e);
            }

            nPortType = PORT_TYPE_COM;
        }

        private void radioButton_LPT_Click(object sender, EventArgs e)
        {
            comboBox_ComName.Enabled = false;
            comboBox_Parity.Enabled = false;
            comboBox_Baudrate.Enabled = false;
            comboBox_StopBits.Enabled = false;
            comboBox_DataBits.Enabled = false;
            comboBox_FlowControl.Enabled = false;

            comboBox_LPTAddress.Enabled = true;

            textBox_ReadTimeOut.Enabled = false;
            textBox_WriteTimeOut.Enabled = false;

            comboBox_DriverName.Enabled = false;

            if (hPort != -1)
            {
                button_Close_Click(sender, e);
            }

            nPortType = PORT_TYPE_LPT;
        }

        private void radioButton_USB_Click(object sender, EventArgs e)
        {
            comboBox_ComName.Enabled = false;
            comboBox_Parity.Enabled = false;
            comboBox_Baudrate.Enabled = false;
            comboBox_StopBits.Enabled = false;
            comboBox_DataBits.Enabled = false;
            comboBox_FlowControl.Enabled = false;

            comboBox_LPTAddress.Enabled = false;

            textBox_ReadTimeOut.Enabled = true;
            textBox_WriteTimeOut.Enabled = true;
            textBox_ReadTimeOut.Text = "2000";
            textBox_WriteTimeOut.Text = "2000";

            comboBox_DriverName.Enabled = false;

            if (hPort != -1)
            {
                button_Close_Click(sender, e);
            }

            nPortType = PORT_TYPE_USB;
        }

        private void radioButton_DRV_Click(object sender, EventArgs e)
        {
            comboBox_ComName.Enabled = false;
            comboBox_Parity.Enabled = false;
            comboBox_Baudrate.Enabled = false;
            comboBox_StopBits.Enabled = false;
            comboBox_DataBits.Enabled = false;
            comboBox_FlowControl.Enabled = false;

            comboBox_LPTAddress.Enabled = false;

            textBox_ReadTimeOut.Enabled = false;
            textBox_WriteTimeOut.Enabled = false;

            comboBox_DriverName.Enabled = true;

            if (hPort != -1)
            {
                button_Close_Click(sender, e);
            }

            nPortType = PORT_TYPE_DRV;
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            bSaveToTxt = !bSaveToTxt;
        }

        public unsafe void ThreadForStatus()
        {
	        if( KIOSK_QueryASB( hPort, nPortType, 1) != KIOSK_SUCCESS )
	        {
		        return;
	        }

	        while(bThreadRunning )
	        {
		        //Query status
                byte[] buffer = new byte[5];
                int result = -1;
                fixed (byte* p = buffer)
                {
                    switch (nPortType)
                    {
                        case PORT_TYPE_COM:
                            result = KIOSK_ReadData(hPort, 0, 0, p, 4);
                            break;

                        case PORT_TYPE_USB:
                            result = KIOSK_ReadData(hPort, 2, 1, p, 4);
                            break;
                    }
                }
                if (result == KIOSK_SUCCESS)
                {
                    //show status
                    string temp = "";
                    temp = String.Format("{0:X2} {1:X2} {2:X2} {3:X2} \r\n", (int)buffer[0], (int)buffer[1], (int)buffer[2], (int)buffer[3]);
                    textBox_Status.Text += temp;                    
                }
                Thread.Sleep(1000);
	        }
            if (KIOSK_QueryASB(hPort, nPortType, 0) != KIOSK_SUCCESS)
            {
                return;
            }
	        return;
        }
        
        private void button_Start_Click(object sender, EventArgs e)
        {
            textBox_Status.Clear();
            button_Query.Enabled = false;
            button_Start.Enabled = false;
            button_Stop.Enabled = true;

            bThreadRunning = true;

            CheckForIllegalCrossThreadCalls = false;
            ThreadStart threadDelegate = new ThreadStart(ThreadForStatus);
            Thread newThread = new Thread(threadDelegate);
            newThread.Start();
        }

        private void button_Stop_Click(object sender, EventArgs e)
        {
            button_Query.Enabled = true;
            button_Start.Enabled = true;
            button_Stop.Enabled = false;

            //Stop thread
            bThreadRunning = false;
        }

        private unsafe void button_Query_Click(object sender, EventArgs e)
        {
            KIOSK_QueryASB(hPort, nPortType, 0);
            char Status = (char)0x00;
	        if( ( nPortType == PORT_TYPE_COM ) || ( nPortType == PORT_TYPE_USB ) )
	        {
		        //Query status
		        if( KIOSK_RTQueryStatus( hPort, nPortType, &Status ) != KIOSK_SUCCESS )
		        {
                    textBox_Msg.Text = "Query status failed!";

			        button_Close_Click(sender,e);
		        }
		        else
		        {
			        int[] nBits = new int[8];
			        for( int i = 0; i < 8; i++ )
			        {
				        nBits[i] = ( Status >> i ) & 0x01;
			        }
			        if( Status == 0 )
			        {
				        textBox_Msg.Text = "All is ok";
			        }
			        else
			        {
				        textBox_Msg.Text = "";
				        if( nBits[0] == 1 ) 
				        {
					        textBox_Msg.Text += "Head Up!";
				        }
        				
				        if( nBits[1] == 1 )
				        {
					        textBox_Msg.Text += "Paper End!";
				        }
        				
				        if( nBits[2] == 1 )
				        {
					        textBox_Msg.Text += "Cutter Error!";
				        }

				        if( nBits[3] == 1 )
				        {
					        textBox_Msg.Text += "TPH Too Hot!";
				        }
        				
				        if( nBits[4] == 1 )
				        {
					        textBox_Msg.Text += "Paper Near End!";
				        }
        				
				        if( nBits[5] == 1 )
				        {
					        textBox_Msg.Text += "Paper Jam!";
				        }
        				
				        if( nBits[6] == 1 )
				        {
					        textBox_Msg.Text += "Presenter/Bundler Paper Jam!";
				        }
        				
				        if( nBits[7] == 1 )
				        {
					        textBox_Msg.Text += "Auto Feed Error!";
				        }
			        }
		        }
	        }
        }

        private void radioButton_Standard_Click(object sender, EventArgs e)
        {
            nMode = PRINT_MODE_STANDRAD;
        }

        private void radioButton_Page_Click(object sender, EventArgs e)
        {
            nMode = PRINT_MODE_PAGE;
        }

        private void radioButton_Presenter_Click(object sender, EventArgs e)
        {
            nPaperOut = PAPER_OUT_PRESENTER;

            radioButton_Retract.Enabled = true;
            radioButton_Forward.Enabled = true;
            radioButton_Hold.Enabled = true;

            radioButton_Rectract.Enabled = false;
            radioButton_Present.Enabled = false;
        }

        private void radioButton_Bundler_Click(object sender, EventArgs e)
        {
            nPaperOut = PAPER_OUT_BUNDLER;

            radioButton_Retract.Enabled = false;
            radioButton_Forward.Enabled = false;
            radioButton_Hold.Enabled = false;

            radioButton_Rectract.Enabled = true;
            radioButton_Present.Enabled = true;
        }

        private void radioButton_Retract_Click(object sender, EventArgs e)
        {
            nPresenter = PRESENTER_RETRACT;
        }

        private void radioButton_Forward_Click(object sender, EventArgs e)
        {
            nPresenter = PRESENTER_FORWARD;
        }

        private void radioButton_Hold_Click(object sender, EventArgs e)
        {
            nPresenter = PRESENTER_HOLD;
        }

        private void radioButton_Rectract_Click(object sender, EventArgs e)
        {
            nBundler = BUNDLER_RETRACT;
        }

        private void radioButton_Present_Click(object sender, EventArgs e)
        {
            nBundler = BUNDLER_PRESENT;
        }

        private void Form_Main_Deactivate(object sender, EventArgs e)
        {
            bThreadRunning = false;
        }

        private void textBox_ReadTimeOut_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((e.KeyChar < 48 || e.KeyChar > 57) && e.KeyChar != 8)
                e.Handled = true;
        }

        private void textBox_WriteTimeOut_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((e.KeyChar < 48 || e.KeyChar > 57) && e.KeyChar != 8)
                e.Handled = true;
        }

        private void Form_Main_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.F1)
            {
                Help.ShowHelp(this, Application.StartupPath + "\\KIOSKDLLDemo.chm");
            }
        }

        private void btnPrintPdf417Code_Click(object sender, EventArgs e)
        {

            //simple sample

            KIOSK_BarcodeSetPDF417(hPort, nPortType, "1234567890abcdefg", 17, 3, 10, 10, 5, 50, 5, 5);

            return;
        }

        private unsafe bool PaperTackout()
        {
            char cStatus = (char)0x00;
            if (KIOSK_RTQueryStatusForT681(hPort, nPortType, &cStatus) != KIOSK_SUCCESS)
            {
                return true;
            }

            if ((cStatus & 0x40) == 0x40)
            {
                return false;
            }
            
            return true;
        }

        private unsafe bool IsPrinting()
        {
            char cStatus = (char)0x00;
            if (KIOSK_RTQueryStatusForT681(hPort, nPortType, &cStatus) != KIOSK_SUCCESS)
            {
                return false;
            }

            if ((cStatus & 0x80) == 0x80)
            {
                return true;
            }

            return false;
        }

        private void button_PrintSample_Click(object sender, EventArgs e)
        {
            //打印三次样张
            for (int i = 0; i < 3; i++)
            {
                PrintSample();

                //等待打印机打印完成
                while (true)
                {
                    Thread.Sleep(100);
                    if (IsPrinting())
                    {                        
                        continue;
                    }
                    break;
                }

                //打印完成后，查询纸是否被取走，取走后发送下一张数据
                while (true)
                {
                    Thread.Sleep(100);
                    if (PaperTackout())
                    {
                        break;
                    }                    
                }
            }
        }

        private void comboBox_ComName_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}