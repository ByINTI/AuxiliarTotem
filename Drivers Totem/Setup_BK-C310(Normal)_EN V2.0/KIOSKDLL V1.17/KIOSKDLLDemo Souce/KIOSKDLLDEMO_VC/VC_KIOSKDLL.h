// VC_KIOSKDLL.h : main header file for the VC_KIOSKDLL application
//

#if !defined(AFX_VC_KIOSKDLL_H__6955E553_E982_4F14_BC06_AEF536134CB2__INCLUDED_)
#define AFX_VC_KIOSKDLL_H__6955E553_E982_4F14_BC06_AEF536134CB2__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CVC_KIOSKDLLApp:
// See VC_KIOSKDLL.cpp for the implementation of this class
//

class CVC_KIOSKDLLApp : public CWinApp
{
public:
	CVC_KIOSKDLLApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CVC_KIOSKDLLApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CVC_KIOSKDLLApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_VC_KIOSKDLL_H__6955E553_E982_4F14_BC06_AEF536134CB2__INCLUDED_)
