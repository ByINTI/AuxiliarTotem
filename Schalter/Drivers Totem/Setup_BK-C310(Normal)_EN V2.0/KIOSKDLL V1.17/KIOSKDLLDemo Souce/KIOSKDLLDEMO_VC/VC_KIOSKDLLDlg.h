// VC_KIOSKDLLDlg.h : header file
//

#if !defined(AFX_VC_KIOSKDLLDLG_H__66858CBE_3FA0_4833_B288_FD630943E6CA__INCLUDED_)
#define AFX_VC_KIOSKDLLDLG_H__66858CBE_3FA0_4833_B288_FD630943E6CA__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

typedef BOOL ( __stdcall * DriverOpen )( void );
typedef BOOL ( __stdcall * DriverOpenEx)(WORD wPortNumber, WORD wDeviceNumber, HINSTANCE hInstance,LPTSTR DriverPath);

/////////////////////////////////////////////////////////////////////////////
// CVC_KIOSKDLLDlg dialog

class CVC_KIOSKDLLDlg : public CDialog
{
// Construction
public:
	bool    bThreadRunning;
	int     nPortType;
	int     m_Mode;
	int     nPaperOut;
	int     nPresenter;
	int     nBundler;

	void PrintSample();
	BOOL IsPrinting();
	BOOL PaperTackout();

	CVC_KIOSKDLLDlg( CWnd * pParent = NULL );	// standard constructor	

// Dialog Data
	//{{AFX_DATA(CVC_KIOSKDLLDlg)
	enum { IDD = IDD_VC_KIOSKDLL_DIALOG };
	CButton	m_Sample;
	CButton	m_PDF417;
	CButton	m_Bundler_Retract;
	CButton	m_Bundler_Present;
	CButton	m_Presenter_Hold;
	CButton	m_Presenter_Forward;
	CButton	m_Presenter_Retraction;
	CEdit	m_StatusASB;
	CComboBox	m_DrvName;
	CEdit	m_ReadTimeOut;
	CEdit	m_WriteTimeOut;
	CButton	m_StatusStart;
	CButton	m_StatusStop;
	CComboBoxEx	m_PageWidth;
	CComboBoxEx	m_SelectDpi;
	CEdit	m_ID;
	CButton	m_Exit;
	CButton	m_ClosePort;
	CButton	m_Print;
	CButton	m_OpenPort;
	CButton	m_QueryStatus;
	CComboBoxEx	m_LptName;
	CComboBoxEx	m_ShakeHands;
	CComboBoxEx	m_StopBit;
	CComboBoxEx	m_Parity;
	CComboBoxEx	m_DataBit;
	CComboBoxEx	m_BaudRate;
	CComboBoxEx	m_ComName;
	int		m_PortCom;
	int		m_StandardMode;
	CString	m_strMsg;
	int		m_Presenter;
	int		m_ReadTimeout;
	int		m_WriteTimeout;
	BOOL	m_SaveToFile;
	int		m_Select_Prs_Bund;
	int		m_Bundler;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CVC_KIOSKDLLDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CVC_KIOSKDLLDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnPortOpen();
	afx_msg void OnOpenLPT();
	afx_msg void OnOpenUsb();
	afx_msg void OnOpenDrv();
	afx_msg void OnStandardMode();
	afx_msg void OnPageMode();
	afx_msg void OnPrsRetraction();
	afx_msg void OnPrsForward();
	afx_msg void OnPrsHold();
	afx_msg void OnBunRetract();
	afx_msg void OnBunPresent();
	afx_msg void OnSendToFile();
	afx_msg void OnStatusStart();
	afx_msg void OnStatusStop();
	afx_msg void OnQueryStatus();
	afx_msg void OnOpenCom();
	afx_msg void OnPrint();
	afx_msg void OnPresenter();
	afx_msg void OnBundler();
	afx_msg BOOL OnHelpInfo(HELPINFO* pHelpInfo);
	afx_msg void OnClosePort();
	afx_msg void OnButton6();
	afx_msg void OnReset();
	afx_msg void OnEditchangeComboboxex10();
	afx_msg void OnBtnPdf417();
	afx_msg void OnBtnSample();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_VC_KIOSKDLLDLG_H__66858CBE_3FA0_4833_B288_FD630943E6CA__INCLUDED_)

