// VC_KIOSKDLLDlg.cpp : implementation file
//

#include "stdafx.h"
#include "VC_KIOSKDLL.h"
#include "VC_KIOSKDLLDlg.h"
#include "LoadDLL.h"
#include "PrintSamples.h"
#include <winspool.h>
//#Include <assert.h>


#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

//Define global veriables
HANDLE  g_hPort                         =	INVALID_HANDLE_VALUE;		   //Port-handle
bool    bSaveToTxt                      =	false;                         //Save to file
bool    IsPrinter	                    =	false;						   //It is Driver or not. 

//Serial port operation.
extern  KIOSK_OpenCom		            VC_KIOSK_OpenCom;                  //Open serial port
extern  KIOSK_SetComTimeOuts            VC_KIOSK_SetComTimeOuts;           //Set serial port timeouts
extern  KIOSK_CloseCom                  VC_KIOSK_CloseCom;                 //Close serial port

//LPT port operation.
extern  KIOSK_OpenLptByDrv              VC_KIOSK_OpenLptByDrv;             //Open drive LPT
extern	KIOSK_CloseDrvLPT				VC_KIOSK_CloseDrvLPT;              //Close drive LPT

//USB port operation.
extern  KIOSK_OpenUsb                   VC_KIOSK_OpenUsb;                  //Open USB 
extern  KIOSK_SetUsbTimeOuts            VC_KIOSK_SetUsbTimeOuts;           //Set USB timeouts 
extern  KIOSK_CloseUsb                  VC_KIOSK_CloseUsb;                 //Close USB

//Driver port operation.
extern  KIOSK_OpenDrv                   VC_KIOSK_OpenDrv;                  //Open driver
extern  KIOSK_StartDoc                  VC_KIOSK_StartDoc;                 //Start a document
extern  KIOSK_EndDoc                    VC_KIOSK_EndDoc;                   //End a document
extern  KIOSK_CloseDrv                  VC_KIOSK_CloseDrv;                 //Close driver

//Using functions. 
extern  KIOSK_WriteData                 VC_KIOSK_WriteData;                //Write data
extern  KIOSK_ReadData                  VC_KIOSK_ReadData;                 //Read data
extern  KIOSK_RTQueryStatus             VC_KIOSK_RTQueryStatus;            //Query status
extern  KIOSK_QueryASB                  VC_KIOSK_QueryASB;                 //Automation status back

extern  KIOSK_SetPresenter              VC_KIOSK_SetPresenter;             //Set Presenter
extern  KIOSK_SetBundler				VC_KIOSK_SetBundler;               //Set Bundler

extern  KIOSK_BeginSaveToFile           VC_KIOSK_BeginSaveToFile;           //Saving data to file.
extern  KIOSK_EndSaveToFile             VC_KIOSK_EndSaveToFile;             //Stop saving dara to file.
extern KIOSK_S_DownloadPrintBmp			VC_KIOSK_S_DownloadPrintBmp;
extern KIOSK_FeedLine						VC_KIOSK_FeedLine;
extern KIOSK_CutPaper                      VC_KIOSK_CutPaper; 
extern KIOSK_SetPaperMode					VC_KIOSK_SetPaperMode;  
extern		KIOSK_SetMode							VC_KIOSK_SetMode;
extern KIOSK_P_DownloadPrintBmp			VC_KIOSK_P_DownloadPrintBmp	;
extern KIOSK_P_Print						VC_KIOSK_P_Print	;
extern  KIOSK_SetUsbTimeOuts            VC_KIOSK_SetUsbTimeOuts;
extern KIOSK_Reset							VC_KIOSK_Reset;
extern KIOSK_P_PrintBmpInRAM				VC_KIOSK_P_PrintBmpInRAM;
extern KIOSK_P_PrintBmpInFlash				VC_KIOSK_P_PrintBmpInFlash;
extern KIOSK_PreDownloadBmpToRAM			VC_KIOSK_PreDownloadBmpToRAM;
extern KIOSK_PreDownloadBmpToFlash			VC_KIOSK_PreDownloadBmpToFlash;
extern KIOSK_S_PrintBmpInRAM				VC_KIOSK_S_PrintBmpInRAM;
extern KIOSK_S_PrintBmpInFlash				VC_KIOSK_S_PrintBmpInFlash;
extern KIOSK_PrintSelfTest                  VC_KIOSK_PrintSelfTest;
extern KIOSK_QueryStatus					VC_KIOSK_QueryStatus;
extern KIOSK_BarcodeSetPDF417				VC_KIOSK_BarcodeSetPDF417;
extern KIOSK_RTQueryStatusForT681			VC_KIOSK_RTQueryStatusForT681;

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CVC_KIOSKDLLDlg dialog

CVC_KIOSKDLLDlg::CVC_KIOSKDLLDlg( CWnd* pParent )
	: CDialog(CVC_KIOSKDLLDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CVC_KIOSKDLLDlg)
	m_PortCom      = 0;
	m_StandardMode = 0;
	m_strMsg	   = _T("");
	m_ReadTimeout  = 0;
	m_WriteTimeout = 0;
	m_SaveToFile   = FALSE;
	m_Select_Prs_Bund = 0;
	m_Presenter    = 0;
	m_Bundler      = 0;
	m_Mode         = 0;
	nPortType      = 0;
	nPaperOut      = 0;
	nPresenter     = 0;
	nBundler       = 0;
	
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CVC_KIOSKDLLDlg::DoDataExchange( CDataExchange * pDX )
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CVC_KIOSKDLLDlg)
	DDX_Control(pDX, IDC_BTN_SAMPLE, m_Sample);
	DDX_Control(pDX, IDC_BTN_PDF417, m_PDF417);
	DDX_Control(pDX, IDC_RADIO11, m_Bundler_Retract);
	DDX_Control(pDX, IDC_RADIO10, m_Bundler_Present);
	DDX_Control(pDX, IDC_RADIO16, m_Presenter_Hold);
	DDX_Control(pDX, IDC_RADIO15, m_Presenter_Forward);
	DDX_Control(pDX, IDC_RADIO14, m_Presenter_Retraction);
	DDX_Control(pDX, IDC_EDIT3, m_StatusASB);
	DDX_Control(pDX, IDC_COMBO1, m_DrvName);
	DDX_Control(pDX, IDC_EDIT2, m_ReadTimeOut);
	DDX_Control(pDX, IDC_EDIT4, m_WriteTimeOut);
	DDX_Control(pDX, IDC_BUTTON1, m_StatusStart);
	DDX_Control(pDX, IDC_BUTTON4, m_StatusStop);
	DDX_Control(pDX, IDC_COMBOBOXEX10, m_PageWidth);
	DDX_Control(pDX, IDC_COMBOBOXEX9, m_SelectDpi);
	DDX_Control(pDX, IDCANCEL, m_Exit);
	DDX_Control(pDX, IDC_BUTTON7, m_ClosePort);
	DDX_Control(pDX, IDC_BUTTON2, m_Print);
	DDX_Control(pDX, IDC_BUTTON3, m_OpenPort);
	DDX_Control(pDX, IDC_BUTTON5, m_QueryStatus);
	DDX_Control(pDX, IDC_COMBOBOXEX7, m_LptName);
	DDX_Control(pDX, IDC_COMBOBOXEX6, m_ShakeHands);
	DDX_Control(pDX, IDC_COMBOBOXEX5, m_StopBit);
	DDX_Control(pDX, IDC_COMBOBOXEX4, m_Parity);
	DDX_Control(pDX, IDC_COMBOBOXEX3, m_DataBit);
	DDX_Control(pDX, IDC_COMBOBOXEX2, m_BaudRate);
	DDX_Control(pDX, IDC_COMBOBOXEX1, m_ComName);
	DDX_Radio(pDX, IDC_RADIO1, m_PortCom);
	DDX_Radio(pDX, IDC_RADIO5, m_StandardMode);
	DDX_Text(pDX, IDC_EDIT1, m_strMsg);
	DDX_Radio(pDX, IDC_RADIO14, m_Presenter);
	DDX_Text(pDX, IDC_EDIT2, m_ReadTimeout);
	DDX_Text(pDX, IDC_EDIT4, m_WriteTimeout);
	DDX_Check(pDX, IDC_CHECK3, m_SaveToFile);
	DDX_Radio(pDX, IDC_RADIO8, m_Select_Prs_Bund);
	DDX_Radio(pDX, IDC_RADIO11, m_Bundler);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CVC_KIOSKDLLDlg, CDialog)
	//{{AFX_MSG_MAP(CVC_KIOSKDLLDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON3, OnPortOpen)
	ON_BN_CLICKED(IDC_RADIO2, OnOpenLPT)
	ON_BN_CLICKED(IDC_RADIO3, OnOpenUsb)
	ON_BN_CLICKED(IDC_RADIO4, OnOpenDrv)
	ON_BN_CLICKED(IDC_RADIO5, OnStandardMode)
	ON_BN_CLICKED(IDC_RADIO6, OnPageMode)
	ON_BN_CLICKED(IDC_RADIO14, OnPrsRetraction)
	ON_BN_CLICKED(IDC_RADIO15, OnPrsForward)
	ON_BN_CLICKED(IDC_RADIO16, OnPrsHold)
	ON_BN_CLICKED(IDC_RADIO11, OnBunRetract)
	ON_BN_CLICKED(IDC_RADIO10, OnBunPresent)
	ON_BN_CLICKED(IDC_CHECK3, OnSendToFile)
	ON_BN_CLICKED(IDC_BUTTON1, OnStatusStart)
	ON_BN_CLICKED(IDC_BUTTON4, OnStatusStop)
	ON_BN_CLICKED(IDC_BUTTON5, OnQueryStatus)
	ON_BN_CLICKED(IDC_RADIO1, OnOpenCom)
	ON_BN_CLICKED(IDC_BUTTON2, OnPrint)
	ON_BN_CLICKED(IDC_RADIO8, OnPresenter)
	ON_BN_CLICKED(IDC_RADIO9, OnBundler)
	ON_WM_HELPINFO()
	ON_BN_CLICKED(IDC_BUTTON7, OnClosePort)
	ON_BN_CLICKED(IDC_BUTTON6, OnButton6)
	ON_BN_CLICKED(IDC_BUTTON8, OnReset)
	ON_CBN_EDITCHANGE(IDC_COMBOBOXEX10, OnEditchangeComboboxex10)
	ON_BN_CLICKED(IDC_BTN_PDF417, OnBtnPdf417)
	ON_BN_CLICKED(IDC_BTN_SAMPLE, OnBtnSample)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CVC_KIOSKDLLDlg message handlers

BOOL CVC_KIOSKDLLDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);

	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			//pSysMenu->AppendMenu(MF_SEPARATOR);
			//pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);					   // Set big icon
	SetIcon(m_hIcon, FALSE);		           // Set small icon
	
	// TODO: Add extra initialization here
	/***************************Set default data**************************/
	m_ComName.SetCurSel(0);                    //Serial port Name              
	m_DataBit.SetCurSel(1);                    //Data bits
	m_StopBit.SetCurSel(0);                    //Stop bits
	m_Parity.SetCurSel(0);                     //Parity
	m_ShakeHands.SetCurSel(0);                 //Flow control
	m_BaudRate.SetCurSel(4);                   //Bits per second
	
	m_LptName.SetCurSel(0);                    //LPT Name 
	m_DrvName.SetCurSel(0);                    //Driver Name

	SetDlgItemText(IDC_EDIT4,"90000");         //Readtimeouts Setting
	SetDlgItemText(IDC_EDIT2,"3000");          //Writetimeouts Setting

	m_SelectDpi.SetCurSel(0);
	m_PageWidth.SetCurSel(1);
	
	/**************************EnableWidow Setting*************************/
	m_LptName.EnableWindow(false);
	m_ReadTimeOut.EnableWindow(true);
	m_WriteTimeOut.EnableWindow(true);
	m_DrvName.EnableWindow(false);
	m_StatusStart.EnableWindow(false);
	m_StatusStop.EnableWindow(false);
	m_Bundler_Retract.EnableWindow(false);
	m_Bundler_Present.EnableWindow(false);

	m_OpenPort.EnableWindow(true);
    m_ClosePort.EnableWindow(false);
	m_Print.EnableWindow(false);
    m_QueryStatus.EnableWindow(false);
	m_Exit.EnableWindow(true);

	m_PDF417.EnableWindow(FALSE);
	m_Sample.EnableWindow(FALSE);

	bThreadRunning=false;

	/**********************Get installed driver****************************/
	m_DrvName.ResetContent();
	UpdateData(TRUE);

	DWORD	dwNeed, dwReturn, dwTemp, i;
	int ret;
	CString	m_strprinter;
	PRINTER_INFO_2	* pPrinterInfo;
	PRINTER_INFO_2  * m_pPrinterInfo;
		
	m_pPrinterInfo = new PRINTER_INFO_2; 
	ret = EnumPrinters( PRINTER_ENUM_LOCAL,
						NULL,
						2,
						(LPBYTE)m_pPrinterInfo,
						sizeof(PRINTER_INFO_2),
						&dwNeed,
						&dwReturn );

	delete m_pPrinterInfo;

	if( ( m_pPrinterInfo = ( PRINTER_INFO_2 * )new BYTE[dwNeed] ) == NULL )
	{
		return FALSE;
	}

    ret =  EnumPrinters (PRINTER_ENUM_LOCAL,
						NULL,
						2,
						(LPBYTE)m_pPrinterInfo,
						dwNeed,
						&dwTemp,
						&dwReturn);
	CString str;
	
	for (i = 0; i < dwReturn; i++ )//Show Driver Name
	{
		pPrinterInfo = m_pPrinterInfo + i;

		str.Format("%s",pPrinterInfo->pPrinterName );

		if( ( str.Find( "Microcom", 0 ) >= 0 ) )
		{
			m_DrvName.AddString( pPrinterInfo->pPrinterName ); 
		}		
	}

	m_DrvName.SetCurSel(0);

	UpdateData(FALSE);

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CVC_KIOSKDLLDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CVC_KIOSKDLLDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		//Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		//Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
// the minimized window.
HCURSOR CVC_KIOSKDLLDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

/*****************************************************************************
  Function:       ThreadForStatus
  Description:    Query status of printer
  Calls:          VC_KIOSK_QueryASB()
                  VC_KIOSK_ReadData()
  Called By:      OnStatusStart()    
******************************************************************************/
DWORD WINAPI ThreadForStatus( LPVOID pData )
{
	CVC_KIOSKDLLDlg	*pWnd;
	pWnd = ( CVC_KIOSKDLLDlg * )pData;
	//Start the Automatic Status Back..


	//Read data from port circularly.
	while( pWnd->bThreadRunning )
	{
		unsigned char buffer[4] = {0};		
		CString temp;

	if( VC_KIOSK_QueryASB( g_hPort, pWnd->nPortType, 1 ) != KIOSK_SUCCESS )
	{
		return 0;
	}
		switch( pWnd->nPortType )
		{		
		case 0:
			{
				//Read data from serial port.
				if( VC_KIOSK_ReadData( g_hPort, 0, 0, (char *)buffer, 4 ) == KIOSK_SUCCESS )
				{		
					temp.Format("%02X %02X %02X %02X \n", buffer[0], buffer[1], buffer[2], buffer[3] );

					//Show the result.
					int nLength = ::SendMessage( ::GetDlgItem(pWnd->m_hWnd,IDC_EDIT3 ), WM_GETTEXTLENGTH, 0, 0 );
					( ( CEdit* ) pWnd->GetDlgItem( IDC_EDIT3 ) )->SetSel( nLength, nLength );
					( ( CEdit*) pWnd->GetDlgItem( IDC_EDIT3 ) )->ReplaceSel( temp );
				}		
			}
			break;
        
		case 2:
			{
				//Read data from USB port.
				if( VC_KIOSK_ReadData( g_hPort, 2, 1, (char *)buffer, 4 ) == KIOSK_SUCCESS )
				{
					temp.Format("%02X %02X %02X %02X \n", buffer[0], buffer[1], buffer[2], buffer[3] );
	
					//Show the result.
					int nLength = ::SendMessage( ::GetDlgItem(pWnd->m_hWnd,IDC_EDIT3 ), WM_GETTEXTLENGTH, 0, 0 );
					( ( CEdit* ) pWnd->GetDlgItem( IDC_EDIT3 ) )->SetSel( nLength, nLength );
					( ( CEdit*) pWnd->GetDlgItem( IDC_EDIT3 ) )->ReplaceSel( temp );
				}
			}
			break;

		default :
			break;
		}	
		
		Sleep( 1000 );
	}

	//Stop the Automatic Status Back.
//	VC_KIOSK_QueryASB( g_hPort, pWnd->nPortType, 0 );

	return 0;
}

void CVC_KIOSKDLLDlg::OnPortOpen() 
{
	UpdateData(true);
   
	if( !LoadKioskdll() )
	{
		//KIOSKDLL linking error
		AfxMessageBox("Link KIOSKDLL error!");
		return ;
	}

	//Serial port Setting
	if( nPortType == 0 )
	{
		CString PortName;       //Serial port name 
        int nComBaudrate;       //Bits per second 
        int nComByteSize;       //Data bits
        int nComStopBits;       //Parity
        int nComParity;         //Stop bits
        int nComFlowControl;    //Flow control
		
		m_ComName.GetLBText( m_ComName.GetCurSel(), PortName );//Get the name of serial port.
		
		//Data bits Setting
		nComByteSize = m_DataBit.GetCurSel()+7;
		int tmp = m_BaudRate.GetCurSel();
		switch( tmp )
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

		//Stop bits Setting
		tmp = m_StopBit.GetCurSel();
		
		if( tmp == 0 )//Stop bits is one
		{			
			nComStopBits = 0x00;
		}
		
		if( tmp == 1 )//Stop bits is two
		{   			
			nComStopBits = 0x01;
		}

		//Set Parity
		tmp = m_Parity.GetCurSel();

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

		//Flow control Setting
		tmp = m_ShakeHands.GetCurSel();
		
		if( tmp == 0 )//DTR/DSR
		{			
			nComFlowControl = 0x00;
		}		
          
		//Open the serial port.
		g_hPort = VC_KIOSK_OpenCom( PortName, nComBaudrate, nComByteSize, nComStopBits, nComParity, nComFlowControl );
	   
		if( g_hPort == INVALID_HANDLE_VALUE )
		{			
			m_strMsg = "Open COM failed!";
		
			UpdateData(false);
		}
		else
		{		
			//Set the timeouts of serial port.
			if( VC_KIOSK_SetComTimeOuts( g_hPort, 0, m_WriteTimeout, 0, m_ReadTimeout ) != KIOSK_SUCCESS )
			{	
				m_strMsg = "Open COM success,but set timeouts failed!";	

				UpdateData(false);
			}			

			//Enablewindow Setting
			m_OpenPort.EnableWindow(false);
			m_ClosePort.EnableWindow(true);
            m_QueryStatus.EnableWindow(true);
			m_StatusStart.EnableWindow(true);
			m_StatusStop.EnableWindow(false);
			m_Print.EnableWindow(true);	
			m_Exit.EnableWindow(true);	
			m_PDF417.EnableWindow(TRUE);
			m_Sample.EnableWindow(TRUE);

			m_strMsg = "Open COM success!";	
			UpdateData(false);
		}
	}

	//LPT Setting
	if( nPortType == 1 )
	{
		CString string;
	    DWORD LPTAddress;
		int tmp = m_LptName.GetCurSel();
		m_LptName.GetLBText( tmp, string );
		if( string == "0x0378")//Address is 0x0378
		{			
			LPTAddress = 0x0378;
		}
		else if( string == "0x0278")//Address is 0x0278
		{		
			LPTAddress = 0x0278;
		}

		//Open the LPT port.
		if( VC_KIOSK_OpenLptByDrv( LPTAddress ) != KIOSK_SUCCESS )
		{
			m_strMsg = "Open DrvLpt failed!";	

			UpdateData(false);
		}
		else
		{
			//Enablewindow Setting
			m_OpenPort.EnableWindow(false);
			m_ClosePort.EnableWindow(true);
			m_QueryStatus.EnableWindow(false);
			m_StatusStart.EnableWindow(false);
			m_StatusStop.EnableWindow(false);
			m_Print.EnableWindow(true);	
			m_Exit.EnableWindow(true);
			m_PDF417.EnableWindow(TRUE);
			m_Sample.EnableWindow(TRUE);

			m_strMsg = "Open DrvLpt success!";
			UpdateData(false);
		}
	}

	//USB Setting
	if( nPortType == 2 )
	{
		//Open the USB port.
		g_hPort = VC_KIOSK_OpenUsb();

		if( g_hPort == INVALID_HANDLE_VALUE )
		{
			m_strMsg = "Open USB failed!";
			UpdateData(false);
		}
		else
		{		
			//Set the tiomeouts of USB port.
			if( VC_KIOSK_SetUsbTimeOuts( g_hPort, ( WORD )m_ReadTimeout, ( WORD )m_WriteTimeout ) != KIOSK_SUCCESS )
			{
				m_strMsg = "Open USB success,but set timeouts failed!";	
				UpdateData(false);
			}	

			//Enablewindow Setting
			m_OpenPort.EnableWindow(false);
			m_ClosePort.EnableWindow(true);
			m_QueryStatus.EnableWindow(true);
			m_StatusStart.EnableWindow(true);
			m_StatusStop.EnableWindow(false);
			m_Print.EnableWindow(true);	
			m_Exit.EnableWindow(true);
			m_PDF417.EnableWindow(TRUE);
			m_Sample.EnableWindow(TRUE);

			m_strMsg = "Open USB success!";	
			UpdateData(false);
		}
	}

	//Driver Setting
	if( nPortType == 3 )
	{
		IsPrinter = true;

		UpdateData(TRUE);

		char namebuf[1024];
		CString printername;
		int index;
		int number;

		//Get the name of driver.
		number = m_DrvName.GetCount();

		if( number == 0 ) 
		{
			SetDlgItemText(IDC_EDIT1,"");
			return;
		}

		memset( namebuf, 0, 1024 );

		index = m_DrvName.GetCurSel();	

		m_DrvName.GetLBText( index, printername );

		strcpy( namebuf, printername );

		//Open the driver port.
		g_hPort = VC_KIOSK_OpenDrv( namebuf );

		if( g_hPort == INVALID_HANDLE_VALUE )
		{
			m_strMsg = "Open Driver failed!";	
			UpdateData(false);
		}
		else
		{
			//Enablewindow Setting
			m_OpenPort.EnableWindow(false);
			m_ClosePort.EnableWindow(true);
			m_QueryStatus.EnableWindow(false);
			m_StatusStop.EnableWindow(false);
			m_StatusStart.EnableWindow(false);
			m_Print.EnableWindow(true);	
			m_Exit.EnableWindow(true);
			m_PDF417.EnableWindow(TRUE);
			m_Sample.EnableWindow(TRUE);

			m_strMsg = "Open Driver success!";
			UpdateData(false);
		}
	}
}

void CVC_KIOSKDLLDlg::PrintSample()
{
	UpdateData(true);

	int PageWidth = m_PageWidth.GetCurSel();
	int DPI = m_SelectDpi.GetCurSel();

	if( IsPrinter )//When it's driver.
	{		
		VC_KIOSK_StartDoc( g_hPort );	
	}

	//Saving data to "Test.dat".
	if( bSaveToTxt )
	{
		VC_KIOSK_BeginSaveToFile(g_hPort,"Test.dat", false);
	}

	//StandardMode
	if( m_Mode == 0 )
	{		
		if( PageWidth == 0 )//The page width is 56mm.
		{			
			if( DPI == 0 )//The resolution is 203dpi.
			{
				if( PrintInStandardMode56_203DPI( g_hPort, nPortType ) )
				{
					m_strMsg = "Print success!";
					UpdateData(false);
				}
				else
				{							
					bThreadRunning = false;

					OnClosePort();
					m_strMsg = "Print failed!";
					UpdateData(false);
				}
			}
			
			if( DPI == 1 )//The resolution is 300dpi.
			{
				if( PrintInStandardMode56_300DPI( g_hPort, nPortType ) )
				{
					m_strMsg = "Print success!";
					UpdateData(false);
				}
				else
				{
                    bThreadRunning = false;

					OnClosePort();  
					m_strMsg = "Print failed!";
				    UpdateData(false);
				}
			}
		}
		
		if( PageWidth == 1 )//The page width is 80mm.
		{			
			if( DPI == 0 )//The resolution is 203dpi.
			{
				if( PrintInStandardMode80_203DPI( g_hPort, nPortType ) )
				{
					m_strMsg = "Print success!";
					UpdateData(false);
				}
				else
				{
					bThreadRunning = false;

					OnClosePort();     
					m_strMsg = "Print failed!";
					UpdateData(false);
				}
			}			
			if( DPI == 1 )//The resolution is 300dpi.
			{
				if( PrintInStandardMode80_300DPI( g_hPort, nPortType ) )
				{
					m_strMsg = "Print success!";
					UpdateData(false);
				}
				else
				{
                    bThreadRunning = false;

					OnClosePort();
					m_strMsg = "Print failed!";
					UpdateData(false);
				}
			}
		}
		
		if( PageWidth == 2 )//The page width is 210mm.
		{			
			if( DPI == 0 )//The resolution is 203dpi.
			{
				if( PrintInStandardMode210_203DPI( g_hPort, nPortType ) )
				{
					m_strMsg = "Print success!";
					UpdateData(false);
				}
				else
				{
                    bThreadRunning = false;
					
				    OnClosePort();
					m_strMsg = "Print failed!";
					UpdateData(false);
				}
			}
			
			if( DPI == 1 )//The resolution is 300dpi.
			{
				if( PrintInStandardMode210_300DPI( g_hPort, nPortType ) )
				{
					m_strMsg = "Print success!";
					UpdateData(false);
				}
				else
				{
                    bThreadRunning = false;
					
					OnClosePort();
					m_strMsg = "Print failed!";
					UpdateData(false);
				}
			}
		}		
	}

	//PageMode
	if( m_Mode == 1 )
	{		
		if( PageWidth == 0 )//The page width is 56mm.
		{			
			if( DPI == 0 )//The resolution is 203dpi.
			{
				if( PrintInPageMode56_203DPI( g_hPort, nPortType ) )
				{
					m_strMsg = "Print success!";
					UpdateData(false);
				}
				else
				{
                    bThreadRunning = false;	
				
					OnClosePort();
					m_strMsg = "Print failed!";
					UpdateData(false);
				}
			}			
			if( DPI == 1 )//The resolution is 300dpi.
			{
				if( PrintInPageMode56_300DPI( g_hPort, nPortType ) )
				{
					m_strMsg = "Print success!";
					UpdateData(false);
				}
				else
				{
                    bThreadRunning = false;
				
					OnClosePort();
					m_strMsg = "Print failed!";
					UpdateData(false);
				}
			}
		}
		
		if( PageWidth == 1 )//The page width is 80mm.
		{			
			if( DPI == 0 )//The resolution is 230dpi.
			{
				if( PrintInPageMode80_203DPI( g_hPort, nPortType ) )
				{
					m_strMsg = "Print success!";
					UpdateData(false);
				}
				else
				{
                    bThreadRunning = false;
					
					OnClosePort();
					m_strMsg = "Print failed!";
					UpdateData(false);
				}
			}			
			if( DPI == 1 )//The resolution is 300dpi.
			{
				if( PrintInPageMode80_300DPI( g_hPort, nPortType ) )
				{
					m_strMsg = "Print success!";
					UpdateData(false);
				}
				else
				{
					bThreadRunning = false;
				
				    OnClosePort();
					m_strMsg = "Print failed!";
					UpdateData(false);
				}
			}
		}		
		if( PageWidth == 2 )//The page width is 210mm.
		{			
			if( DPI == 0 )//The resolution is 203dpi.
			{
 				if( PrintInPageMode210_203DPI( g_hPort, nPortType ) )
				{
					m_strMsg = "Print success!";
					UpdateData(false);
				}
				else
				{	
					bThreadRunning = false;

					OnClosePort();	
					m_strMsg = "Print failed!";
					UpdateData(false);
				}
			}			
			if( DPI == 1 )//The resolution is 300dpi.
			{
				if( PrintInPageMode210_300DPI( g_hPort, nPortType ) )
				{
					m_strMsg = "Print success!";
					UpdateData(false);
				}
				else
				{
				    bThreadRunning = false;
			
					OnClosePort();
					m_strMsg = "Print failed!";
					UpdateData(false);
				}
			}
		}		
	}

	//Presenter or Bundler Setting 
	if( nPaperOut == 0 )	
	{		
		switch( nPresenter )//Presenter Setting
		{		
		case 0://Presenter Retraction_on
			{				
				if( VC_KIOSK_SetPresenter( g_hPort, nPortType, KIOSK_PRESENTER_Retraction_on, 3 ) != KIOSK_SUCCESS )
				{
					AfxMessageBox("Set Presenter failed!");
				}
			}
			break;

		case 1://Presenter Paper_Forward
			{   				
				if( VC_KIOSK_SetPresenter( g_hPort, nPortType, KIOSK_PRESENTER_Paper_Forward, 3 ) != KIOSK_SUCCESS )
				{
					AfxMessageBox("Set Presenter failed!");
				}			
			}
			break;

		case 2://Presenter Paper_Hold
			{				
				if( VC_KIOSK_SetPresenter( g_hPort, nPortType, KIOSK_PRESENTER_Paper_Hold, 3 ) != KIOSK_SUCCESS )
				{
					AfxMessageBox("Set Presenter failed!");
				}
			}
			break;

		default :
			break;
		}
	}
	else if( nPaperOut == 1 )//Bundler Setting
	{		
		switch( nBundler )
		{		
		case 0://Bundler Retract
			{				
				if( VC_KIOSK_SetBundler( g_hPort, nPortType, KIOSK_BUNDLER_Retract, 3 ) != KIOSK_SUCCESS )
				{	
					AfxMessageBox("Set Bundler failed!");
				}
			}		
			break;

		case 1://Bundler Present
			{				
				if( VC_KIOSK_SetBundler( g_hPort, nPortType, KIOSK_BUNDLER_Present, 3 ) != KIOSK_SUCCESS )
				{
					AfxMessageBox("Set Bundler failed!");
				}
			}		
			break;

		default :
			break;
		}
	}
	
	if( bSaveToTxt )//Stop saving data to file.
	{
		VC_KIOSK_EndSaveToFile(g_hPort);
	}

	if( IsPrinter )//When it's driver.
	{		
		VC_KIOSK_EndDoc( g_hPort);
	}

	UpdateData(false);
}

void CVC_KIOSKDLLDlg::OnPrint() 
{
	PrintSample();
}

void CVC_KIOSKDLLDlg::OnOpenCom() 
{
    //EnableWidow Setting
	UpdateData(true);
	m_ComName.EnableWindow(true);                                
	m_DataBit.EnableWindow(true);                   
	m_StopBit.EnableWindow(true);                    
	m_Parity.EnableWindow(true);                     
	m_ShakeHands.EnableWindow(true);                 
	m_BaudRate.EnableWindow(true); 

	m_LptName.EnableWindow(false);

	m_ReadTimeOut.EnableWindow(true);
	m_WriteTimeOut.EnableWindow(true);
	m_DrvName.EnableWindow(false);
	m_StatusStop.EnableWindow(false);
	m_StatusStart.EnableWindow(true);

	m_OpenPort.EnableWindow(true);
	m_ClosePort.EnableWindow(false);
	m_Print.EnableWindow(false);
	m_QueryStatus.EnableWindow(false);
	m_Exit.EnableWindow(true);

	SetDlgItemText(IDC_EDIT4,"90000");      //Read-timeouts Setting
	SetDlgItemText(IDC_EDIT2,"3000");      //Write-timeouts Setting

	//Close port first when the handle is not "INVALID_HANDLE_VALUE".
	if( g_hPort != INVALID_HANDLE_VALUE )
	{
		switch( nPortType )
		{
		case 0: 
			{ 
				//Close the serial port.
				VC_KIOSK_CloseCom( g_hPort );
			}
			break;
		case 1:
			{
				//Close the LPT port.
				VC_KIOSK_CloseDrvLPT( 1 );
			}
			break;
		case 2:
			{
				//Close the USB port.
				VC_KIOSK_CloseUsb( g_hPort );
			}
			break;
		case 3:
			{
				//Close the driver port.
				VC_KIOSK_CloseDrv( g_hPort );
			}
			break;
		default :
			break;
		}
	}
	g_hPort = INVALID_HANDLE_VALUE;
	nPortType = 0;	
}

void CVC_KIOSKDLLDlg::OnOpenLPT() 
{
	//Enablewindow Setting
	UpdateData(true);
	m_ComName.EnableWindow(false);                                
	m_DataBit.EnableWindow(false);                   
	m_StopBit.EnableWindow(false);                    
	m_Parity.EnableWindow(false);                     
	m_ShakeHands.EnableWindow(false);                 
	m_BaudRate.EnableWindow(false); 

	m_LptName.EnableWindow(true);

	m_ReadTimeOut.EnableWindow(false);
	m_WriteTimeOut.EnableWindow(false);
	m_DrvName.EnableWindow(false);
	m_StatusStop.EnableWindow(false);
	m_StatusStart.EnableWindow(false);

	m_OpenPort.EnableWindow(true);
	m_ClosePort.EnableWindow(false);
	m_Print.EnableWindow(false);
	m_QueryStatus.EnableWindow(false);
	m_Exit.EnableWindow(true);

	//Close port first when the handle is not "INVALID_HANDLE_VALUE".
	if( g_hPort != INVALID_HANDLE_VALUE )
	{
		switch( nPortType )
		{
		case 0: 
			{ 
				//Close the serial port.
				VC_KIOSK_CloseCom( g_hPort );
			}
			break;
		case 1:
			{
				//Close the LPT port.
				VC_KIOSK_CloseDrvLPT( 1 );
			}
			break;
		case 2:
			{
				//Close the USB port.
				VC_KIOSK_CloseUsb( g_hPort );
			}
			break;
		case 3:
			{
				//Close the driver port.
				VC_KIOSK_CloseDrv( g_hPort );
			}
			break;
		default :
			break;
		}
	}

	g_hPort = INVALID_HANDLE_VALUE;
	nPortType = 1;
}

void CVC_KIOSKDLLDlg::OnOpenUsb() 
{
    //Enablewindow Setting
	UpdateData(true);
	m_ComName.EnableWindow(false);                                
	m_DataBit.EnableWindow(false);                   
	m_StopBit.EnableWindow(false);                    
	m_Parity.EnableWindow(false);                     
	m_ShakeHands.EnableWindow(false);                 
	m_BaudRate.EnableWindow(false); 

	m_LptName.EnableWindow(false);

	m_ReadTimeOut.EnableWindow(true);
	m_WriteTimeOut.EnableWindow(true);
	m_DrvName.EnableWindow(false);
	m_StatusStop.EnableWindow(false);
	m_StatusStart.EnableWindow(true);

	m_OpenPort.EnableWindow(true);
	m_ClosePort.EnableWindow(false);
	m_Print.EnableWindow(false);
	m_QueryStatus.EnableWindow(false);
	m_Exit.EnableWindow(true);
    
	SetDlgItemText(IDC_EDIT4,"2000");       //Read-timeouts Setting
	SetDlgItemText(IDC_EDIT2,"2000");      //Write-timeouts Setting

	//Close port first when the handle is not "INVALID_HANDLE_VALUE".
	if( g_hPort != INVALID_HANDLE_VALUE )
	{
		switch( nPortType )
		{
		case 0: 
			{ 
				//Close the serial port.
				VC_KIOSK_CloseCom( g_hPort );
			}
			break;
		case 1:
			{
				//Close the LPT port.
				VC_KIOSK_CloseDrvLPT( 1 );
			}
			break;
		case 2:
			{
				//Close the USB port.
				VC_KIOSK_CloseUsb( g_hPort );
			}
			break;
		case 3:
			{
				//Close the driver port.
				VC_KIOSK_CloseDrv( g_hPort );
			}
			break;
		default :
			break;
		}
	}

	g_hPort = INVALID_HANDLE_VALUE;
	nPortType = 2;	
}

void CVC_KIOSKDLLDlg::OnOpenDrv() 
{
	//Enablewindow Setting
	UpdateData(true);
	m_ComName.EnableWindow(false);                                
	m_DataBit.EnableWindow(false);                   
	m_StopBit.EnableWindow(false);                    
	m_Parity.EnableWindow(false);                     
	m_ShakeHands.EnableWindow(false);                 
	m_BaudRate.EnableWindow(false); 

	m_LptName.EnableWindow(false);

	m_ReadTimeOut.EnableWindow(false);
	m_WriteTimeOut.EnableWindow(false);
	m_DrvName.EnableWindow(true);
	m_StatusStop.EnableWindow(false);
	m_StatusStart.EnableWindow(false);

	m_OpenPort.EnableWindow(true);
	m_ClosePort.EnableWindow(false);
	m_Print.EnableWindow(false);
	m_QueryStatus.EnableWindow(false);
	m_Exit.EnableWindow(true);

	//Close port first when the handle is not "INVALID_HANDLE_VALUE".
	if( g_hPort != INVALID_HANDLE_VALUE )
	{
		switch( nPortType )
		{
		case 0: 
			{ 
				//Close the serial port.
				VC_KIOSK_CloseCom( g_hPort );
			}
			break;
		case 1:
			{
				//Close the LPT port.
				VC_KIOSK_CloseDrvLPT( 1 );
			}
			break;
		case 2:
			{
				//Close the USB port.
				VC_KIOSK_CloseUsb( g_hPort );
			}
			break;
		case 3:
			{
				//Close the driver port.
				VC_KIOSK_CloseDrv( g_hPort );
			}
			break;
		default :
			break;
		}
	}

	g_hPort = INVALID_HANDLE_VALUE;    
	nPortType = 3;	
}

void CVC_KIOSKDLLDlg::OnStandardMode() 
{
	UpdateData(true);
	m_Mode = 0;	//StandardMode Selecting
}

void CVC_KIOSKDLLDlg::OnPageMode() 
{
	UpdateData(true);
	m_Mode = 1;//PageMode Selecting
}

void CVC_KIOSKDLLDlg::OnPrsRetraction() 
{
	UpdateData(true);
	nPresenter = 0;//Presenter Retraction_on Selecting
}

void CVC_KIOSKDLLDlg::OnPrsForward() 
{
	UpdateData(true);
	nPresenter = 1;//Presenter Paper_Forward Selecting
}

void CVC_KIOSKDLLDlg::OnPrsHold() 
{
	UpdateData(true);
	nPresenter = 2;//Presenter Paper_Hold Selecting
}

void CVC_KIOSKDLLDlg::OnBunRetract() 
{
	UpdateData(true);
  	nBundler = 0;//Bundler Retract Selecting
}

void CVC_KIOSKDLLDlg::OnBunPresent() 
{
	UpdateData(true);
	nBundler = 1;//Bundler Present Selecting
}

void CVC_KIOSKDLLDlg::OnSendToFile() 
{
	UpdateData(true);

	//"Sending data to file but not to port." Selecting
	if( bSaveToTxt )
	{
		bSaveToTxt = false;
	}
	else
	{
		bSaveToTxt = true;
	}
}

void CVC_KIOSKDLLDlg::OnStatusStart() 
{
	//Enablewindow Setting
	UpdateData(true);
	m_StatusStop.EnableWindow(true);
	m_StatusStart.EnableWindow(false);
	m_QueryStatus.EnableWindow(false);

	SetDlgItemText(IDC_EDIT3,"");
	bThreadRunning = true;
	DWORD ThreadID;

	//Thread Creating
	CreateThread( NULL, 0, ThreadForStatus, this, 0, &ThreadID);
}

void CVC_KIOSKDLLDlg::OnStatusStop() 
{
	//Enablewindow Setting
	UpdateData(true);
	m_StatusStop.EnableWindow(false);
	m_StatusStart.EnableWindow(true);
	m_QueryStatus.EnableWindow(true);
	
	//Tread Stopping
	bThreadRunning=false;

	//Stop the Automatic Status Back.
	VC_KIOSK_QueryASB( g_hPort, nPortType, 0 );
}

void CVC_KIOSKDLLDlg::OnQueryStatus() 
{
    UpdateData(true);

	char Status = 0;
	if( ( nPortType == 0 ) || ( nPortType == 2 ) )
	{
		//Stop the Automatic Status Back first.
		VC_KIOSK_QueryASB( g_hPort, nPortType, 1 );

		//Query the real-time status of printer.
		if( VC_KIOSK_RTQueryStatus( g_hPort, nPortType, &Status ) != KIOSK_SUCCESS )
		{
			OnClosePort();
			m_strMsg = "Query status failed!";
			UpdateData(false);
		}
		else
		{
			int nBits[8];
			for( int i = 0; i < 8; i++ )
			{
				nBits[i] = ( Status >> i ) & 0x01;
			}
			if( Status == 0 )
			{
				m_strMsg = "All is ok";
				UpdateData(false);
			}
			else
			{				
				m_strMsg = "";
				if( nBits[0] == 1 ) //Head Up
				{					 
					m_strMsg += "Head Up!";
				}
				
				if( nBits[1] == 1 )//Paper End
				{					
					m_strMsg += "Paper End!";
				}
				
				if( nBits[2] == 1 )//Cutter Error
				{					
					m_strMsg += "Cutter Error!";
				}

				if( nBits[3] == 1 )//TPH Too Hot
				{					
					m_strMsg += "TPH Too Hot!";
				}
				
				if( nBits[4] == 1 )//Paper Near End
				{					
					m_strMsg += "Paper Near End!";
				}
				
				if( nBits[5] == 1 )//Paper Jam
				{					
					m_strMsg += "Paper Jam!";
				}
				
				if( nBits[6] == 1 )//Presenter/Bundler Paper Jam
				{					
					m_strMsg += "Presenter/Bundler Paper Jam!";
				}
				
				if( nBits[7] == 1 )//Auto Feed Error
				{					
					m_strMsg += "Auto Feed Error!";
				}
			}
		}
	}

	UpdateData(false);
}

void CVC_KIOSKDLLDlg::OnPresenter() 
{
	//Enablewindow Setting
	UpdateData(true);
	m_Bundler_Retract.EnableWindow(false);
	m_Bundler_Present.EnableWindow(false);
	m_Presenter_Retraction.EnableWindow(true);
	m_Presenter_Forward.EnableWindow(true);
	m_Presenter_Hold.EnableWindow(true);
 
	nPaperOut = 0;//Presenter Selecting
}
 
void CVC_KIOSKDLLDlg::OnBundler() 
{
	//Enablewindow Setting
	UpdateData(true);
	m_Bundler_Retract.EnableWindow(true);
	m_Bundler_Present.EnableWindow(true);
	m_Presenter_Retraction.EnableWindow(false);
	m_Presenter_Forward.EnableWindow(false);
	m_Presenter_Hold.EnableWindow(false);

	nPaperOut = 1; //Bundler Selecting   
}

BOOL CVC_KIOSKDLLDlg::OnHelpInfo(HELPINFO* pHelpInfo) 
{
	HANDLE m_hHelpWnd;

	if( GetKeyState (VK_F1) < 0 ) 
    { 
		//Execute the "KIOSKDLLDEMO.chm".
		m_hHelpWnd = FindWindow( NULL, "KIOSKDLLDEMO");
		ShellExecute( this->m_hWnd, "open","KIOSKDLLDEMO.chm", NULL, NULL, SW_SHOW );

		return 1;
    } 	
}

void CVC_KIOSKDLLDlg::OnClosePort() 
{
	//Enablewindow Setting
	UpdateData(true);	
	bThreadRunning = false;
	m_OpenPort.EnableWindow(true);
	m_ClosePort.EnableWindow(false);
	m_Print.EnableWindow(false);
	m_StatusStart.EnableWindow(false);
	m_StatusStop.EnableWindow(false);
	m_QueryStatus.EnableWindow(false);	
	m_Exit.EnableWindow(true);
	m_PDF417.EnableWindow(FALSE);
	m_Sample.EnableWindow(FALSE);
	
	if( nPortType == 0 )//Serial port Closing
	{
		if( g_hPort != INVALID_HANDLE_VALUE )
		{
			if( VC_KIOSK_CloseCom( g_hPort ) != KIOSK_SUCCESS )
			{
				m_strMsg = "Close COM failed!";
				UpdateData(false);
			}
		}
		m_strMsg = "Close COM success!";
		UpdateData(false);
	}
	
	if( nPortType == 1 )//LPT port Closing
	{
		if( VC_KIOSK_CloseDrvLPT( 1 ) != KIOSK_SUCCESS )
		{
			m_strMsg = "Close DrvLpt failed!";
			UpdateData(false);
		}
		else
		{
			m_strMsg = "Close DrvLpt success!";
			UpdateData(false);
		}
	}
	
	if( nPortType == 2 )//USB port Closing
	{
		if( g_hPort != INVALID_HANDLE_VALUE )
		{
			if( VC_KIOSK_CloseUsb( g_hPort ) != KIOSK_SUCCESS )
			{
				m_strMsg = "Close USB failed!";
				UpdateData(false);
			}
		}

		m_strMsg = "Close USB success!";
		UpdateData(false);
	}
	
	if( nPortType == 3 )//Driver port Closing
    {
		if( g_hPort != INVALID_HANDLE_VALUE )
		{
			if( VC_KIOSK_CloseDrv( g_hPort ) != KIOSK_SUCCESS )
			{
				m_strMsg = "Close Driver failed!";
				UpdateData(false);
			}
		}
		
		m_strMsg = "Close Driver success!";
		UpdateData(false);

		IsPrinter = false;
	}
	
 	g_hPort = INVALID_HANDLE_VALUE;		
}

void CVC_KIOSKDLLDlg::OnButton6() 
{
	// TODO: Add your control notification handler code here
	char buff[32] = {0x00};
	if( !LoadKioskdll() )
	{
		//KIOSKDLL linking error
		AfxMessageBox("Link KIOSKDLL error!");
		return ;
	}
	HANDLE hand;
	for(int i = 0;i < 100;i++)
	{
	if((hand = VC_KIOSK_OpenUsb()/*VC_KIOSK_OpenCom( "COM4", 9600, 8, 0x00, 0x00, 0x00 )*/) == INVALID_HANDLE_VALUE)
	{

		MessageBox("failed");
		return;
	}

	//VC_KIOSK_SetComTimeOuts(hand,0,2000,0,3000);
	if(VC_KIOSK_QueryASB(hand,2,1) != KIOSK_SUCCESS)
	{

	MessageBox("failed");
	return ;
	}

	if(VC_KIOSK_ReadData(hand,2,1,buff,10) != KIOSK_SUCCESS)
	{

	MessageBox("read failed");
	return;
	}
	
	if(VC_KIOSK_CloseUsb(hand) != KIOSK_SUCCESS)
	{

		MessageBox("failed");
		return ;
	}

	}
	

}

void CVC_KIOSKDLLDlg::OnReset() 
{
		//for(int i =0;i<20;i++)
	//{	
		VC_KIOSK_SetPresenter(g_hPort,2,KIOSK_PRESENTER_Paper_Hold,2);
			char readBuff[50] = {0x1D,0x56,0x00};
		char pszBuff[7] = {0x00}; 	pszBuff[0] = 0x10;
		pszBuff[1] = 0x04;
		pszBuff[2] = 0x0a;
		pszBuff[3] = 0x0a;
		pszBuff[4] = 0x92;
		pszBuff[5] = 0x9a;
		pszBuff[6] = 0x35;
		//VC_KIOSK_SetUsbTimeOuts(g_hPort,3000,3000);
		VC_KIOSK_WriteData(g_hPort,2,readBuff,3);
			VC_KIOSK_SetPresenter(g_hPort,2,KIOSK_PRESENTER_Retraction_on,3);
		int a = VC_KIOSK_WriteData(g_hPort,2,pszBuff,3);
	//	Sleep(20);
	//}
//	a = VC_KIOSK_ReadData(g_hPort,2,0,readBuff,25);
	
}

void CVC_KIOSKDLLDlg::OnEditchangeComboboxex10() 
{
	// TODO: Add your control notification handler code here
	
}

void CVC_KIOSKDLLDlg::OnBtnPdf417() 
{
	// TODO: Add your control notification handler code here
	VC_KIOSK_BarcodeSetPDF417(g_hPort, nPortType, "1234567890abcdefg", 17, 3, 10, 10, 5, 50, 5, 5);
}

BOOL CVC_KIOSKDLLDlg::IsPrinting()
{
	char cStatus = (char)0x00;
	if (VC_KIOSK_RTQueryStatusForT681(g_hPort, nPortType, &cStatus) != KIOSK_SUCCESS)
	{
		return FALSE;
	}
	
	if ((cStatus & 0x80) == 0x80)
	{
		return TRUE;
	}
	
    return FALSE;
}

BOOL CVC_KIOSKDLLDlg::PaperTackout()
{
	char cStatus = (char)0x00;
	if (VC_KIOSK_RTQueryStatusForT681(g_hPort, nPortType, &cStatus) != KIOSK_SUCCESS)
	{
		return TRUE;
	}
	
	if ((cStatus & 0x40) == 0x40)
	{
		return FALSE;
	}
	
    return TRUE;
}

void CVC_KIOSKDLLDlg::OnBtnSample() 
{
	// TODO: Add your control notification handler code here

	//打印三次样张
    for (int i = 0; i < 3; i++)
    {
        PrintSample();

		//等待打印机完成打印
        while (TRUE)
        {
            Sleep(100);
            if (IsPrinting())
            {                        
                continue;
            }
            break;
        }

		//打印完成后，查询纸是否被取走，取走后发送下一张数据
        while (TRUE)
        {
            Sleep(100);
            if (PaperTackout())
            {
                break;
            }                    
        }
    }
}
