// PosdllDemoDlg.cpp : implementation file
//

#include "stdafx.h"
#include "PosdllDemo.h"
#include "PosdllDemoDlg.h"
#include "LoadDll.h"
#include "PrintSamples.h"
#include <windows.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

HANDLE g_hComm	= INVALID_HANDLE_VALUE;//�˿ھ��
bool IsPrinter	= false;//�ж��Ƿ��������������ӡ
int  m_iMode	= 0;//ҳģʽ���׼ģʽ
bool bSaveToTxt = false;//�Ƿ�ѡ�����ݱ��浽�ļ�Test.txt������˿��·�

extern HMODULE				g_hPosdll;//��̬����

extern POS_Open				VC_POS_Open;//�򿪶˿�
extern POS_EnumUSBPrinter	VC_POS_EnumUSBPrinter;
extern POS_Close			VC_POS_Close;//�رն˿�
extern POS_RTQueryStatus	VC_POS_RTQueryStatus;//ʵʱ״̬��ѯ
extern POS_NETQueryStatus	VC_POS_NETQueryStatus;//����ӿڵ�״̬��ѯ
extern POS_StartDoc			VC_POS_StartDoc;//����һ���ĵ�
extern POS_EndDoc			VC_POS_EndDoc;//����һ���ĵ�
extern POS_BeginSaveFile	VC_POS_BeginSaveFile;//�����������ݵ��ļ�
extern POS_EndSaveFile		VC_POS_EndSaveFile;//�����������ݵ��ļ�
extern POS_GetVersionInfo	VC_POS_GetVersionInfo;//��ȡ��ǰ��̬��汾

LANGID langID;


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
// CPosdllDemoDlg dialog

CPosdllDemoDlg::CPosdllDemoDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CPosdllDemoDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CPosdllDemoDlg)
	m_PortType = 0;
	m_ModeSelect = 0;
	m_strMsg = _T("");
	m_strDrvName = _T("");
	m_iTphWidth = 0;
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CPosdllDemoDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CPosdllDemoDlg)
	DDX_Control(pDX, IDC_COMB_PRINTER, m_Device);
	DDX_Control(pDX, IDC_PAGE_WIDTH, m_ctrlPageWidth);
	DDX_Control(pDX, IDC_DRV_NAME, m_ctrlDrvName);
	DDX_Control(pDX, IDC_IPADDRESS, m_ctrlIPAddr);
	DDX_Control(pDX, IDC_CLOSE_PORT, m_ctrlClosePort);
	DDX_Control(pDX, IDC_PRINT, m_ctrlPrint);
	DDX_Control(pDX, IDC_QUERY_STATUS, m_ctrlQueryStatus);
	DDX_Control(pDX, IDC_LPT_NAME, m_ctrlLPTName);
	DDX_Control(pDX, IDC_PARITY, m_ctrlParity);
	DDX_Control(pDX, IDC_FLOW_CONTROL, m_ctrlFlowControl);
	DDX_Control(pDX, IDC_STOPBITS, m_ctrlStopBits);
	DDX_Control(pDX, IDC_BAUDRATE, m_ctrlBaudrate);
	DDX_Control(pDX, IDC_DATABITS, m_ctrlDataBits);
	DDX_Control(pDX, IDC_COM_NAME, m_ctrlComName);
	DDX_Radio(pDX, IDC_PORT_COM, m_PortType);
	DDX_Radio(pDX, IDC_MODE_STANDARD, m_ModeSelect);
	DDX_Text(pDX, IDC_EDIT_STATUS, m_strMsg);
	DDX_Text(pDX, IDC_DRV_NAME, m_strDrvName);
	DDX_CBIndex(pDX, IDC_PAGE_WIDTH, m_iTphWidth);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CPosdllDemoDlg, CDialog)
	//{{AFX_MSG_MAP(CPosdllDemoDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_OPEN_PORT, OnOpenPort)
	ON_BN_CLICKED(IDC_PORT_COM, OnPortCom)
	ON_BN_CLICKED(IDC_PORT_LPT, OnPortLpt)
	ON_BN_CLICKED(IDC_PORT_USB, OnPortUsb)
	ON_BN_CLICKED(IDC_PORT_NET, OnPortNet)
	ON_BN_CLICKED(IDC_PORT_DRV, OnPortDrv)
	ON_BN_CLICKED(IDC_QUERY_STATUS, OnQueryStatus)
	ON_BN_CLICKED(IDC_PRINT, OnPrint)
	ON_BN_CLICKED(IDC_CLOSE_PORT, OnClosePort)
	ON_WM_DESTROY()
	ON_BN_CLICKED(IDC_MODE_STANDARD, OnModeStandard)
	ON_BN_CLICKED(IDC_MODE_PAGE, OnModePage)
	ON_BN_CLICKED(IDC_SAVE_TO_TXT, OnSaveToTxt)
	ON_WM_HELPINFO()
	ON_BN_CLICKED(IDC_PORT_CLASS, OnPortClass)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CPosdllDemoDlg message handlers

BOOL CPosdllDemoDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon

	langID = GetUserDefaultLangID();
	
	// TODO: Add extra initialization here
	if ( false == LoadPosdll() )
	{
		// �����̬�����ʧ��, ���˳�
		if (langID == CHINESE_SIMPLE)
		{
			AfxMessageBox("���ض�̬��ʧ�ܣ�");
		}
		else
		{
			AfxMessageBox("Load dll failed !");
		}
		
		CDialog::OnCancel();
		return false;
	}

	SetCtrlLang(langID);

	/*��ʼ��������ʾ*/
	m_ctrlIPAddr.SetAddress(192,168,10,251);
	m_ctrlIPAddr.EnableWindow(false);
	
	m_ctrlComName.SetCurSel(0);
	m_ctrlDataBits.SetCurSel(1);
	m_ctrlBaudrate.SetCurSel(2);
	m_ctrlStopBits.SetCurSel(0);
	m_ctrlParity.SetCurSel(2);
	m_ctrlFlowControl.SetCurSel(1);

	m_ctrlLPTName.SetCurSel(0);

	m_ctrlPageWidth.SetCurSel(1);

	SetDlgItemText(IDC_DRV_NAME,"BTP-2002CP(S)");

	int iMajor,iMinor;
	CString str,tmp;
	VC_POS_GetVersionInfo(&iMajor,&iMinor);
	if (langID == CHINESE_SIMPLE)
	{
		str = "һ���������汾��V";
	}
	else
	{
		str = "All OK, Version: V";
	}
	
	tmp.Format("%d.%d",iMajor,iMinor);
	str += tmp;
	SetDlgItemText(IDC_EDIT_STATUS,str);

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CPosdllDemoDlg::SetCtrlLang(int ID)
{
	switch (ID)
	{
	case CHINESE_SIMPLE:
		SetDlgItemText(IDC_STC_PORT, "�˿�ѡ��");
		SetDlgItemText(IDC_PORT_COM, "����");
		SetDlgItemText(IDC_PORT_LPT, "����");
		SetDlgItemText(IDC_PORT_USB, "USB��");
		SetDlgItemText(IDC_PORT_NET, "����ӿ�");
		SetDlgItemText(IDC_PORT_DRV, "��������");
		SetDlgItemText(IDC_PORT_CLASS, "USB Class");

		SetDlgItemText(IDC_STC_SET, "�˿�����");
		SetDlgItemText(IDC_STC_NAME, "�������ƣ�");
		SetDlgItemText(IDC_STC_RATE, "ÿ��λ����");
		SetDlgItemText(IDC_STC_DATA, "����λ��");
		SetDlgItemText(IDC_STC_PARITY, "У��λ��");
		SetDlgItemText(IDC_STC_STOP, "ֹͣλ��");
		SetDlgItemText(IDC_STC_SHAKE, "���������ƣ�");
		SetDlgItemText(IDC_STC_PRANAME, "�������ƣ�");
		SetDlgItemText(IDC_STC_IP, "IP��ַ��");
		SetDlgItemText(IDC_STC_DRVNAME, "�������ƣ�");

		SetDlgItemText(IDC_SAVE_TO_TXT, "���ݱ��浽�ļ�Test.txt������˿��·�");

		SetDlgItemText(IDC_OPEN_PORT, "�򿪶˿�");
		SetDlgItemText(IDC_QUERY_STATUS, "��ѯ״̬");
		SetDlgItemText(IDC_PRINT, "��ӡ");
		SetDlgItemText(IDC_CLOSE_PORT, "�رն˿�");

		SetDlgItemText(IDC_STC_Sample, "ʾ������");
		SetDlgItemText(IDC_STC_MODE, "ģʽѡ��");
		SetDlgItemText(IDC_MODE_STANDARD, "��׼ģʽ");
		SetDlgItemText(IDC_MODE_PAGE, "ҳģʽ");
		SetDlgItemText(IDC_STC_WIDTH, "ҳ��");

		m_ctrlParity.AddString("żУ��");
		m_ctrlParity.AddString("��У��");
		m_ctrlParity.AddString("��У��");

		m_ctrlFlowControl.AddString("XON/OFF");
		m_ctrlFlowControl.AddString("Ӳ��");
		m_ctrlFlowControl.AddString("��");
		break;
	default:
		SetDlgItemText(IDC_STC_PORT, "Port Option");
		SetDlgItemText(IDC_PORT_COM, "SerialPort");
		SetDlgItemText(IDC_PORT_LPT, "ParallelPort");
		SetDlgItemText(IDC_PORT_USB, "USB");
		SetDlgItemText(IDC_PORT_NET, "Ethernet");
		SetDlgItemText(IDC_PORT_DRV, "Driver");
		SetDlgItemText(IDC_PORT_CLASS, "USB Class");

		SetDlgItemText(IDC_STC_SET, "Configuration");
		SetDlgItemText(IDC_STC_NAME, "PortName:");
		SetDlgItemText(IDC_STC_RATE, "BaudRate:");
		SetDlgItemText(IDC_STC_DATA, "DataBits:");
		SetDlgItemText(IDC_STC_PARITY, "Parity:");
		SetDlgItemText(IDC_STC_STOP, "StopBits:");
		SetDlgItemText(IDC_STC_SHAKE, "HandShake:");
		SetDlgItemText(IDC_STC_PRANAME, "ParaName:");
		SetDlgItemText(IDC_STC_IP, "IP Addr:");
		SetDlgItemText(IDC_STC_DRVNAME, "DriverName:");

		SetDlgItemText(IDC_SAVE_TO_TXT, "Save data to Test.txt file, not to device");

		SetDlgItemText(IDC_OPEN_PORT, "OpenPort");
		SetDlgItemText(IDC_QUERY_STATUS, "QueryStatus");
		SetDlgItemText(IDC_PRINT, "Print");
		SetDlgItemText(IDC_CLOSE_PORT, "ClosePort");

		SetDlgItemText(IDC_STC_Sample, "SampleSetting");
		SetDlgItemText(IDC_STC_MODE, "Mode");
		SetDlgItemText(IDC_MODE_STANDARD, "Standard");
		SetDlgItemText(IDC_MODE_PAGE, "Page");
		SetDlgItemText(IDC_STC_WIDTH, "PageWidth:");

		m_ctrlParity.AddString("Even");
		m_ctrlParity.AddString("Odd");
		m_ctrlParity.AddString("None");

		m_ctrlFlowControl.AddString("XON/OFF");
		m_ctrlFlowControl.AddString("Hardware");
		m_ctrlFlowControl.AddString("None");
		break;
	}
}

void CPosdllDemoDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	CDialog::OnSysCommand(nID, lParam);
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CPosdllDemoDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CPosdllDemoDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CPosdllDemoDlg::OnPortCom() //�˿�ѡ��Ϊ����
{
	// TODO: Add your control notification handler code here
	m_ctrlComName.EnableWindow(true);
	m_ctrlDataBits.EnableWindow(true);
	m_ctrlBaudrate.EnableWindow(true);
	m_ctrlStopBits.EnableWindow(true);
	m_ctrlParity.EnableWindow(true);
	m_ctrlFlowControl.EnableWindow(true);

	m_ctrlLPTName.EnableWindow(false);

	m_ctrlIPAddr.EnableWindow(false);

	m_ctrlDrvName.EnableWindow(false);

	if (langID == CHINESE_SIMPLE)
	{
		SetDlgItemText(IDC_EDIT_STATUS,"�˿�ѡ��Ϊ����");
	}
	else
	{
		SetDlgItemText(IDC_EDIT_STATUS,"Serial port is selected");
	}
	
	VC_POS_Close();
	m_ctrlQueryStatus.EnableWindow(false);
	m_ctrlPrint.EnableWindow(false);
	m_ctrlClosePort.EnableWindow(false);
	GetDlgItem(IDC_OPEN_PORT)->EnableWindow(true);
}

void CPosdllDemoDlg::OnPortLpt() //�˿�ѡ��Ϊ����
{
	// TODO: Add your control notification handler code here
	m_ctrlLPTName.EnableWindow(true);
	
	m_ctrlComName.EnableWindow(false);
	m_ctrlDataBits.EnableWindow(false);
	m_ctrlBaudrate.EnableWindow(false);
	m_ctrlStopBits.EnableWindow(false);
	m_ctrlParity.EnableWindow(false);
	m_ctrlFlowControl.EnableWindow(false);	

	m_ctrlIPAddr.EnableWindow(false);

	m_ctrlDrvName.EnableWindow(false);

	if (langID == CHINESE_SIMPLE)
	{
		SetDlgItemText(IDC_EDIT_STATUS,"�˿�ѡ��Ϊ����");
	}
	else
	{
		SetDlgItemText(IDC_EDIT_STATUS,"Parallel port is selected");
	}
	
	VC_POS_Close();
	m_ctrlQueryStatus.EnableWindow(false);
	m_ctrlPrint.EnableWindow(false);
	m_ctrlClosePort.EnableWindow(false);
	GetDlgItem(IDC_OPEN_PORT)->EnableWindow(true);
}

void CPosdllDemoDlg::OnPortUsb() //�˿�ѡ��ΪUSB��
{
	// TODO: Add your control notification handler code here
	m_ctrlComName.EnableWindow(false);
	m_ctrlDataBits.EnableWindow(false);
	m_ctrlBaudrate.EnableWindow(false);
	m_ctrlStopBits.EnableWindow(false);
	m_ctrlParity.EnableWindow(false);
	m_ctrlFlowControl.EnableWindow(false);	

	m_ctrlLPTName.EnableWindow(false);

	m_ctrlIPAddr.EnableWindow(false);

	m_ctrlDrvName.EnableWindow(false);

	if (langID == CHINESE_SIMPLE)
	{
		SetDlgItemText(IDC_EDIT_STATUS,"�˿�ѡ��ΪUSB��");
	}
	else
	{
		SetDlgItemText(IDC_EDIT_STATUS,"USB port is selected");
	}
	
	VC_POS_Close();
	m_ctrlQueryStatus.EnableWindow(false);
	m_ctrlPrint.EnableWindow(false);
	m_ctrlClosePort.EnableWindow(false);
	GetDlgItem(IDC_OPEN_PORT)->EnableWindow(true);
}

void CPosdllDemoDlg::OnPortNet() //�˿�ѡ��Ϊ����ӿ�
{
	// TODO: Add your control notification handler code here
	m_ctrlIPAddr.EnableWindow(true);
	
	m_ctrlComName.EnableWindow(false);
	m_ctrlDataBits.EnableWindow(false);
	m_ctrlBaudrate.EnableWindow(false);
	m_ctrlStopBits.EnableWindow(false);
	m_ctrlParity.EnableWindow(false);
	m_ctrlFlowControl.EnableWindow(false);	

	m_ctrlLPTName.EnableWindow(false);

	m_ctrlDrvName.EnableWindow(false);

	if (langID == CHINESE_SIMPLE)
	{
		SetDlgItemText(IDC_EDIT_STATUS,"�˿�ѡ��Ϊ����ӿ�");
	}
	else
	{
		SetDlgItemText(IDC_EDIT_STATUS,"Ethernet port is selected");
	}
	
	VC_POS_Close();
	m_ctrlQueryStatus.EnableWindow(false);
	m_ctrlPrint.EnableWindow(false);
	m_ctrlClosePort.EnableWindow(false);
	GetDlgItem(IDC_OPEN_PORT)->EnableWindow(true);
}

void CPosdllDemoDlg::OnPortDrv() //�˿�ѡ��Ϊ��������
{
	// TODO: Add your control notification handler code here
	m_ctrlDrvName.EnableWindow(true);
	
	m_ctrlComName.EnableWindow(false);
	m_ctrlDataBits.EnableWindow(false);
	m_ctrlBaudrate.EnableWindow(false);
	m_ctrlStopBits.EnableWindow(false);
	m_ctrlParity.EnableWindow(false);
	m_ctrlFlowControl.EnableWindow(false);	

	m_ctrlLPTName.EnableWindow(false);

	m_ctrlIPAddr.EnableWindow(false);	

	if (langID == CHINESE_SIMPLE)
	{
		SetDlgItemText(IDC_EDIT_STATUS,"�˿�ѡ��Ϊ��������");
	}
	else
	{
		SetDlgItemText(IDC_EDIT_STATUS,"Printer driver is selected");
	}
	
	VC_POS_Close();
	m_ctrlQueryStatus.EnableWindow(false);
	m_ctrlPrint.EnableWindow(false);
	m_ctrlClosePort.EnableWindow(false);
	GetDlgItem(IDC_OPEN_PORT)->EnableWindow(true);
}

void CPosdllDemoDlg::OnOpenPort() //�򿪶˿�
{
	// TODO: Add your control notification handler code here
	UpdateData(true);

	if(0 == m_PortType) //Ҫ�򿪵Ķ˿�Ϊ����
	{	
		CString strPortName;

		int iBaudrate;
		int iDataBits;
		int iStopBits;
		int iParity;
		int iFlowControl;

		m_ctrlComName.GetLBText(m_ctrlComName.GetCurSel(),strPortName);
		iDataBits = m_ctrlDataBits.GetCurSel()+7;//����Ϊ0��ʾ����λΪ7��Ϊ1��ʾ8����������ĵ�
		int tmp = m_ctrlStopBits.GetCurSel();//��������ĵ�
		if(0 == tmp)//ֹͣλΪ1
		{
			iStopBits = 0;
		}
		if(1 == tmp)//ֹͣλΪ2
		{
			iStopBits = 2;
		}
		int temp = m_ctrlParity.GetCurSel();//��������ĵ�
		if(0 == temp)//żУ��
		{
			iParity = 2;
		}
		else if(1 == temp)//��У��
		{
			iParity = 1;
		}
		else//��У��
		{
			iParity = 0;
		}
		int iRet = m_ctrlFlowControl.GetCurSel();//��������ĵ�
		if(0 == iRet)//Xon/Xoff
		{
			iFlowControl = 2;
		}else if(1 == iRet)//POS_COM_RTS_CTS
		{
			iFlowControl = 1;
		}
		else//POS_COM_NO_HANDSHAKE
		{
			iFlowControl = 3;
		}

		switch(m_ctrlBaudrate.GetCurSel())
		{		
		case 0:
			iBaudrate = 2400;
			break;

		case 1:
			iBaudrate = 4800;
			break;

		case 2:
			iBaudrate = 9600;
			break;

		case 3:
			iBaudrate = 19200;
			break;

		case 4:
			iBaudrate = 38400;
			break;

		case 5:
			iBaudrate = 57600;
			break;

		case 6:
			iBaudrate = 115200;
			break;

		default:
			iBaudrate = 9600;
			break;
		}

		g_hComm = VC_POS_Open(strPortName,iBaudrate,iDataBits,iStopBits,iParity,iFlowControl);
	}
	
	if(1 == m_PortType) //Ҫ�򿪵Ķ˿�Ϊ����
	{
		IsPrinter = false;

		CString strPortName;
		m_ctrlLPTName.GetLBText(m_ctrlLPTName.GetCurSel(),strPortName);
		g_hComm = VC_POS_Open(strPortName,0,0,0,0,POS_OPEN_PARALLEL_PORT);
	}

	if(2 == m_PortType) //Ҫ�򿪵Ķ˿�ΪUSB��
	{
		IsPrinter = false;

		g_hComm = VC_POS_Open("BYUSB-0",0,0,0,0,POS_OPEN_BYUSB_PORT);
		if (g_hComm == INVALID_HANDLE_VALUE)
		{
			g_hComm = VC_POS_Open("BYUSB-1",0,0,0,0,POS_OPEN_BYUSB_PORT);
		}
	}

	if (5 == m_PortType)//USB ��ģʽ
	{
		IsPrinter = false;

		CString str;
		int n = m_Device.GetLBTextLen( m_Device.GetCurSel() );
		m_Device.GetLBText( m_Device.GetCurSel(), str.GetBuffer(n) );
		g_hComm = VC_POS_Open((LPTSTR)(LPCTSTR)str, 0, 0, 0, 0, POS_OPEN_CLASSPRINTER);
	}


	if(3 == m_PortType) //Ҫ�򿪵Ķ˿�Ϊ����ӿ�
	{
		if(m_ctrlIPAddr.IsBlank())
		{
			if (langID == CHINESE_SIMPLE)
			{
				m_strMsg = "IP��ַ����Ϊ�գ�";
			}
			else
			{
				m_strMsg = "IP address can not be null";
			}
			
			m_ctrlIPAddr.SetFocus();
			UpdateData(false);
			return;
		}
		else
		{
			IsPrinter = false;

			CString tmp;
			BYTE  nField1, nField2, nField3, nField4;

			m_ctrlIPAddr.GetAddress(nField1, nField2, nField3, nField4);
			
			tmp.Format("%d",nField1);
			strNetPortName = tmp;
			strNetPortName += ".";

			tmp.Format("%d",nField2);
			strNetPortName += tmp;
			strNetPortName += ".";

			tmp.Format("%d",nField3);
			strNetPortName += tmp;
			strNetPortName += ".";

			tmp.Format("%d",nField4);
			strNetPortName += tmp;

			g_hComm = VC_POS_Open(strNetPortName,0,0,0,0,POS_OPEN_NETPORT);
		}
	}

	if(4 == m_PortType) //Ҫ�򿪵Ķ˿�Ϊ��������
	{
		if("" == m_strDrvName)
		{
			if (langID == CHINESE_SIMPLE)
			{
				m_strMsg = "��������������Ϊ�գ�";
			}
			else
			{
				m_strMsg = "Driver name can not be null";
			}
			
			m_ctrlDrvName.SetFocus();
			UpdateData(false);
			return;
		}
		else
		{
			IsPrinter = true;
			g_hComm = VC_POS_Open(m_strDrvName,0,0,0,0,POS_OPEN_PRINTNAME);
		}
	}

	if (g_hComm != INVALID_HANDLE_VALUE) //�жϴ򿪶˿ں�������ֵ
	{
		GetDlgItem(IDC_OPEN_PORT)->EnableWindow(false);
		if (langID == CHINESE_SIMPLE)
		{
			m_strMsg = "�˿ڴ򿪳ɹ���";
		}
		else
		{
			m_strMsg = "Open port success!";
		}
		
		m_ctrlPrint.EnableWindow(true);
		m_ctrlClosePort.EnableWindow(true);
		if(m_PortType != 1 && m_PortType != 4)//���ں���������ӿڲ�֧��״̬��ѯ
		{
			m_ctrlQueryStatus.EnableWindow(true);
		}
	}
	else
	{
		if (langID == CHINESE_SIMPLE)
		{
			m_strMsg = "�˿ڴ�ʧ�ܣ�";
		}
		else
		{
			m_strMsg = "Open port failed!";
		}
		
		m_ctrlQueryStatus.EnableWindow(false);
		m_ctrlPrint.EnableWindow(false);
		m_ctrlClosePort.EnableWindow(false);
	}

	UpdateData(false);
	m_strMsg = "";
}



void CPosdllDemoDlg::OnQueryStatus() //��ѯ״̬
{
	// TODO: Add your control notification handler code here
	char Status = 0;
	int nRet;
	if(3 == m_PortType)
	{
		nRet = VC_POS_NETQueryStatus((LPSTR)(LPCTSTR)strNetPortName,&Status);
	}
	else
	{
		nRet = VC_POS_RTQueryStatus(&Status);
	}
	if(POS_FAIL == nRet)
	{
		if (langID == CHINESE_SIMPLE)
		{
			m_strMsg = "��ѯ״̬ʧ�ܣ�";
		}
		else
		{
			m_strMsg = "Query status failed!";
		}
		
		GetDlgItem(IDC_OPEN_PORT)->EnableWindow(true);
		GetDlgItem(IDC_QUERY_STATUS)->EnableWindow(false);
		GetDlgItem(IDC_PRINT)->EnableWindow(false);
		GetDlgItem(IDC_CLOSE_PORT)->EnableWindow(false);
	}
	else
	{	
		int iBits[8];
		for (int i = 0; i < 8; i++)
		{
			iBits[i] = (Status >> i) & 0x01;
		}
		if(Status == 1)
		{
			if (langID == CHINESE_SIMPLE)
			{
				m_strMsg = "һ��������";
			}
			else
			{
				m_strMsg = "All OK!";
			}
		}
		else
		{
			m_strMsg = "";
			if (iBits[0] == 0)
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg += "��Ǯ��򿪣�";
				}
				else
				{
					m_strMsg = "Cash drawer open!";
				}				
			}
			
			if (iBits[1] == 1)
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg += "��ӡ���ѻ���";
				}
				else
				{
					m_strMsg = "Printer is offline!";
				}				
			}
			
			if (iBits[2] == 1)
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg += "�ϸǴ򿪣�";
				}
				else
				{
					m_strMsg = "Cover open!";
				}				
			}

			if (iBits[3] == 1)
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg += "���ڽ�ֽ��";
				}
				else
				{
					m_strMsg = "Paper feeding!";
				}				
			}
			
			if (iBits[4] == 1)
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg += "��ӡ������";
				}
				else
				{
					m_strMsg = "Printer error!";
				}				
			}
			
			if (iBits[5] == 1)
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg += "�е�����";
				}
				else
				{
					m_strMsg += "Cutter error";
				}					
			}
			
			if (iBits[6] == 1)
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg += "ֽ������";
				}
				else
				{
					m_strMsg += "Paper near end!";
				}				
			}
			
			if (iBits[7] == 1)
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg += "ȱֽ��";
				}
				else
				{
					m_strMsg += "Paper end!";
				}				
			}
		}
	}

	UpdateData(false);
}

void CPosdllDemoDlg::OnPrint() 
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	if(IsPrinter)  //���ѡ�������������ӡ
	{
		VC_POS_StartDoc();
	}
			
	if (m_iMode == 0) //��׼ģʽ
	{
		if (m_iTphWidth == 0) //ֽ��56mm
		{
			if (PrintInStandardMode56())
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg = "��ӡ�ɹ���";
				}
				else
				{
					m_strMsg = "Print success!";
				}					
			}
			else
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg = "��ӡʧ�ܣ�";
				}
				else
				{
					m_strMsg = "Print failed!";
				}
				
				GetDlgItem(IDC_OPEN_PORT)->EnableWindow(true);
				GetDlgItem(IDC_QUERY_STATUS)->EnableWindow(false);
				GetDlgItem(IDC_PRINT)->EnableWindow(false);
				GetDlgItem(IDC_CLOSE_PORT)->EnableWindow(false);
			}
		}
		else //ֽ��80mm
		{
			if (PrintInStandardMode80())
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg = "��ӡ�ɹ���";
				}
				else
				{
					m_strMsg = "Print success!";
				}
				
			}
			else
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg = "��ӡʧ�ܣ�";
				}
				else
				{
					m_strMsg = "Print failed!";
				}
				GetDlgItem(IDC_OPEN_PORT)->EnableWindow(true);
				GetDlgItem(IDC_QUERY_STATUS)->EnableWindow(false);
				GetDlgItem(IDC_PRINT)->EnableWindow(false);
				GetDlgItem(IDC_CLOSE_PORT)->EnableWindow(false);
			}
		}
	}
	else //ҳģʽ
	{
		if (m_iTphWidth == 0) //ֽ��56mm
		{
			if (PrintInPageMode56())
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg = "��ӡ�ɹ���";
				}
				else
				{
					m_strMsg = "Print success!";
				}
			}
			else
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg = "��ӡʧ�ܣ�";
				}
				else
				{
					m_strMsg = "Print failed!";
				}
				GetDlgItem(IDC_OPEN_PORT)->EnableWindow(true);
				GetDlgItem(IDC_QUERY_STATUS)->EnableWindow(false);
				GetDlgItem(IDC_PRINT)->EnableWindow(false);
				GetDlgItem(IDC_CLOSE_PORT)->EnableWindow(false);
			}
		}
		else //ֽ��80mm
		{
			if (PrintInPageMode80())
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg = "��ӡ�ɹ���";
				}
				else
				{
					m_strMsg = "Print success!";
				}
			}
			else
			{
				if (langID == CHINESE_SIMPLE)
				{
					m_strMsg = "��ӡʧ�ܣ�";
				}
				else
				{
					m_strMsg = "Print failed!";
				}
				GetDlgItem(IDC_OPEN_PORT)->EnableWindow(true);
				GetDlgItem(IDC_QUERY_STATUS)->EnableWindow(false);
				GetDlgItem(IDC_PRINT)->EnableWindow(false);
				GetDlgItem(IDC_CLOSE_PORT)->EnableWindow(false);
			}
		}
	}
	
	if(IsPrinter) //���ѡ�������������ӡ
	{
		VC_POS_EndDoc();
	}

	UpdateData(false);
}

void CPosdllDemoDlg::OnClosePort() //�رն˿�
{
	// TODO: Add your control notification handler code here
	int nRet;
	nRet = VC_POS_Close();
	if(POS_FAIL == nRet)
	{
		if (langID == CHINESE_SIMPLE)
		{
			m_strMsg = "�˿ڹر�ʧ�ܣ�";
		}
		else
		{
			m_strMsg = "Close port failed!";
		}		
	}
	else if(POS_ERROR_INVALID_HANDLE == nRet)
	{
		if (langID == CHINESE_SIMPLE)
		{
			m_strMsg = "�˿ڹر�ʧ�ܣ�";
		}
		else
		{
			m_strMsg = "Close port failed!";
		}
	}
	else
	{
		GetDlgItem(IDC_OPEN_PORT)->EnableWindow(true);
		if (langID == CHINESE_SIMPLE)
		{
			m_strMsg = "�˿ڹرճɹ���";
		}
		else
		{
			m_strMsg = "Close port success!";
		}
		
		m_ctrlQueryStatus.EnableWindow(false);
		m_ctrlPrint.EnableWindow(false);
		m_ctrlClosePort.EnableWindow(false);
		m_Device.EnableWindow(FALSE);
	}

	UpdateData(false);
}

void CPosdllDemoDlg::OnDestroy() //���ڹر�
{
	CDialog::OnDestroy();
	
	// TODO: Add your message handler code here
	if(INVALID_HANDLE_VALUE != g_hComm)
	{
		VC_POS_Close();
	}
	if(g_hPosdll)
	{
		UnloadPosdll();
	}
}

void CPosdllDemoDlg::OnModeStandard() //��׼ģʽ
{
	// TODO: Add your control notification handler code here
	m_iMode = 0;
}

void CPosdllDemoDlg::OnModePage() //ҳģʽ
{
	// TODO: Add your control notification handler code here
	m_iMode = 1;
}

void CPosdllDemoDlg::OnSaveToTxt() //���ݱ��浽�ļ�Test.txt������˿��·�
{
	// TODO: Add your control notification handler code here
	if(bSaveToTxt)
	{
		bSaveToTxt = false;
	}
	else
	{
		bSaveToTxt = true;
	}
}

BOOL CPosdllDemoDlg::OnHelpInfo(HELPINFO* pHelpInfo) 
{
	// TODO: Add your message handler code here and/or call default
	//����F1���Զ�Ѱ�Ұ����ļ�
	return 0;
}

void CPosdllDemoDlg::OnOK() 
{
	// TODO: Add extra validation here
	//CDialog::OnOK();
	//���λس��رճ�����
}

void CPosdllDemoDlg::OnPortClass() 
{
	// TODO: Add your control notification handler code here
	char cPrinterNames[1024] = {0};
	int i = VC_POS_EnumUSBPrinter(cPrinterNames);
	if (i <= 0)
	{
		return;
	}

	int strLen=strlen(cPrinterNames);
	int j=0;
	for(;j<strLen;j++)
	{
		if(cPrinterNames[j]=='@')
		{
			cPrinterNames[j]=0;
		}
	}
	
	char* p=cPrinterNames;
	for (j=1;j<=i;j++)
	{
		m_Device.AddString(p);
		p+=strlen(p);
		p++;
	}

	m_Device.SetCurSel(0);

	m_Device.EnableWindow(TRUE);
}
