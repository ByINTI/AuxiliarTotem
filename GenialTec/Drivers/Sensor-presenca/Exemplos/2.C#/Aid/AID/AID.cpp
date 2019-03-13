/****************************************************************************************************/
/* General Overview                                                                                 */
/****************************************************************************************************/
/* Copyright (c)      2003 KOPF GmbH, Germany (All rights reserved)                                 */
/*                                                                                                  */
/* module name:       AID.cpp                                                                       */
/*                                                                                                  */
/* version:           V1.00                                                                         */
/*                                                                                                  */
/* abstract:          Interface Layer to FTDI-AI2                                                   */
/*                                                                                                  */
/****************************************************************************************************/

/****************************************************************************************************/
/* List Of Changes                                                                                  */
/****************************************************************************************************/
/*                                                                                                  */
/* classes of changes:                                                                              */
/*                                                                                                  */
/* N: new module                                            (V1.00)                                 */
/* F: functional development                                (V+.00)                                 */
/* E: error correction                                      (Vx.+0)                                 */
/* I: change because of changed interface to other modules  (Vx.+0)                                 */
/* O: optimization without functional change                (Vx.x+)                                 */
/*                                                                                                  */
/* list of changes (last change is above):                                                          */
/*                                                                                                  */
/* Class: N    V1.00   03.04.03 KOPF-M.S.                                                           */
/* descript.:  new created                                                                          */
/*                                                                                                  */
/****************************************************************************************************/

#include "stdafx.h"
#include "ftd2xx.h"

#define CAN_RX_BUFFER_SIZE 1000

// DLL internal Variables

HINSTANCE m_hmodule; 
FT_HANDLE ftHandle;

struct {
  DWORD id;
  BYTE  dlc;
  BYTE  data[8];
} CAN_rx_buffer[CAN_RX_BUFFER_SIZE];

WORD CAN_rx_buffer_write_pnt;  // points to the last written cell
WORD CAN_rx_buffer_read_pnt;   // points to the last read cell

// DLL internal functions

unsigned int FT_RX_Size();
unsigned int SSLP_Receive(void);

// FTD2XX.DLL Functions

typedef FT_STATUS (WINAPI *PtrToOpen)(PVOID, FT_HANDLE *); 
PtrToOpen m_pOpen; 

typedef FT_STATUS (WINAPI *PtrToOpenEx)(PVOID, DWORD, FT_HANDLE *); 
PtrToOpenEx m_pOpenEx; 

typedef FT_STATUS (WINAPI *PtrToListDevices)(PVOID, PVOID, DWORD);
PtrToListDevices m_pListDevices; 

typedef FT_STATUS (WINAPI *PtrToClose)(FT_HANDLE);
PtrToClose m_pClose;

typedef FT_STATUS (WINAPI *PtrToResetDevice)(FT_HANDLE);
PtrToResetDevice m_pResetDevice;

typedef FT_STATUS (WINAPI *PtrToRead)(FT_HANDLE, LPVOID, DWORD, LPDWORD);
PtrToRead m_pRead;

typedef FT_STATUS (WINAPI *PtrToWrite)(FT_HANDLE, LPVOID, DWORD, LPDWORD);
PtrToWrite m_pWrite;

typedef FT_STATUS (WINAPI *PtrToPurge)(FT_HANDLE, ULONG);
PtrToPurge m_pPurge;
	
typedef FT_STATUS (WINAPI *PtrToSetTimeouts)(FT_HANDLE, ULONG, ULONG);
PtrToSetTimeouts m_pSetTimeouts;

typedef FT_STATUS (WINAPI *PtrToGetQueueStatus)(FT_HANDLE, LPDWORD);
PtrToGetQueueStatus m_pGetQueueStatus;

typedef FT_STATUS (WINAPI *PtrToGetStatus)(FT_HANDLE, LPDWORD, LPDWORD, LPDWORD);
PtrToGetStatus m_pGetStatus;

typedef FT_STATUS (WINAPI *PtrToEE_Program)(FT_HANDLE, LPVOID);
PtrToEE_Program m_pEE_Program;

typedef FT_STATUS (WINAPI *PtrToEE_Read)(FT_HANDLE, LPVOID);
PtrToEE_Read m_pEE_Read;

typedef FT_STATUS (WINAPI *PtrToGetLatencyTimer)(FT_HANDLE, PUCHAR);
PtrToGetLatencyTimer m_pGetLatencyTimer;

typedef FT_STATUS (WINAPI *PtrToSetLatencyTimer)(FT_HANDLE, UCHAR);
PtrToSetLatencyTimer m_pSetLatencyTimer;

typedef FT_STATUS (WINAPI *PtrToSetBitMode)(FT_HANDLE, UCHAR, UCHAR);
PtrToSetBitMode m_pSetBitMode;

typedef FT_STATUS (WINAPI *PtrToSetUSBParameters)(FT_HANDLE, DWORD, DWORD);
PtrToSetUSBParameters m_pSetUSBParameters;

// External AID.DLL functions 

unsigned int FT_ListDevices();
unsigned int FT_Open();
unsigned int FT_Close();
unsigned int FT_ResetDevice();
unsigned int FT_Read(UCHAR *data, unsigned long size);
unsigned int FT_Write(UCHAR *data, unsigned long size);
unsigned int FT_PurgeRX();
unsigned int FT_PurgeTX();
unsigned int FT_GetQueueStatus();
unsigned int FT_GetStatus(unsigned long *rxsize, unsigned long *txsize);
unsigned int FT_EE_Program(unsigned short power);
unsigned int FT_EE_ProgramToDefault();
unsigned int FT_EE_Read(unsigned short *vid, unsigned short *pid, unsigned short *power);
unsigned int FT_GetLatencyTimer(unsigned char *data);
unsigned int FT_SetLatencyTimer(unsigned char *data);
unsigned int FT_SetBitMode(UCHAR mask, UCHAR enable);
unsigned int FT_SetUSBParameters(unsigned long insize, unsigned long outsize);
unsigned int KCAN_Send(unsigned int channel, unsigned int id, unsigned int dlc, unsigned char *data);
unsigned int KCAN_Receive(unsigned int *channel, unsigned int *id, unsigned int *dlc, unsigned char *data);
unsigned int KCAN_Init(unsigned int baudrate);

// DLLMain

BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
	// Init of DLL internal variables
	CAN_rx_buffer_write_pnt=0;
	CAN_rx_buffer_read_pnt=0;

	// Init Access to FTD2XX.DLL
	m_hmodule = LoadLibrary("Ftd2xx.dll");	
	if(m_hmodule == NULL)
	{
		// Error
		return FALSE;
	}

	m_pListDevices = (PtrToListDevices)GetProcAddress(m_hmodule, "FT_ListDevices");
	m_pWrite = (PtrToWrite)GetProcAddress(m_hmodule, "FT_Write");
	m_pRead = (PtrToRead)GetProcAddress(m_hmodule, "FT_Read");
	m_pOpen = (PtrToOpen)GetProcAddress(m_hmodule, "FT_Open");
	m_pResetDevice = (PtrToResetDevice)GetProcAddress(m_hmodule, "FT_ResetDevice");
	m_pOpenEx = (PtrToOpenEx)GetProcAddress(m_hmodule, "FT_OpenEx");
	m_pListDevices = (PtrToListDevices)GetProcAddress(m_hmodule, "FT_ListDevices");
	m_pClose = (PtrToClose)GetProcAddress(m_hmodule, "FT_Close");
	m_pResetDevice = (PtrToResetDevice)GetProcAddress(m_hmodule, "FT_ResetDevice");
	m_pPurge = (PtrToPurge)GetProcAddress(m_hmodule, "FT_Purge");
	m_pSetTimeouts = (PtrToSetTimeouts)GetProcAddress(m_hmodule, "FT_SetTimeouts");
	m_pGetQueueStatus = (PtrToGetQueueStatus)GetProcAddress(m_hmodule, "FT_GetQueueStatus");
	m_pGetStatus = (PtrToGetStatus)GetProcAddress(m_hmodule, "FT_GetStatus");
	m_pSetBitMode = (PtrToSetBitMode)GetProcAddress(m_hmodule, "FT_SetBitMode");
	m_pEE_Program = (PtrToEE_Program)GetProcAddress(m_hmodule, "FT_EE_Program");
	m_pEE_Read = (PtrToEE_Read)GetProcAddress(m_hmodule, "FT_EE_Read");
	m_pGetLatencyTimer = (PtrToGetLatencyTimer)GetProcAddress(m_hmodule, "FT_GetLatencyTimer");
	m_pSetLatencyTimer = (PtrToSetLatencyTimer)GetProcAddress(m_hmodule, "FT_SetLatencyTimer");
	m_pSetUSBParameters = (PtrToSetUSBParameters)GetProcAddress(m_hmodule, "FT_SetUSBParameters");

    return TRUE;
}

unsigned int FT_ListDevices()
{
	DWORD i;
	(*m_pListDevices)(&i, NULL, FT_LIST_NUMBER_ONLY);
	return i;
}

unsigned int FT_Open()
{
	return (*m_pOpen)(0,&ftHandle);
}

unsigned int FT_Close()
{
	return (*m_pClose)(ftHandle);
}

unsigned int FT_ResetDevice()
{
	return (*m_pResetDevice)(ftHandle);
}

unsigned int FT_Read(UCHAR *data, unsigned long size)
{
	unsigned long i;
	(*m_pRead)(ftHandle,data,size,&i);
	return i;
}

unsigned int FT_PurgeRX()
{
	return (*m_pPurge)(ftHandle,FT_PURGE_RX);
}

unsigned int FT_PurgeTX()
{
	return (*m_pPurge)(ftHandle,FT_PURGE_TX);
}

unsigned int FT_Write(UCHAR *data, unsigned long size)
{
	unsigned long i;
	return (*m_pWrite)(ftHandle,data,size,&i);
}

unsigned int FT_GetQueueStatus()
{
	unsigned long i;
	(*m_pGetQueueStatus)(ftHandle,&i);
	return i;
}

unsigned int FT_GetStatus(unsigned long *rxsize, unsigned long *txsize)
{
	unsigned long i;
	return (*m_pGetStatus)(ftHandle,rxsize,txsize,&i);
}

unsigned int FT_EE_Program(unsigned short power)
{
    FT_PROGRAM_DATA ftdata;
	char ManufacturerBuf[32];
	char ManufacturerIdBuf[16];
	char DescriptionBuf[64];
	char SerialNumberBuf[16];

	ftdata.Manufacturer=ManufacturerBuf;
	ftdata.ManufacturerId=ManufacturerIdBuf;
	ftdata.Description=DescriptionBuf;
	ftdata.SerialNumber=SerialNumberBuf;

	(*m_pEE_Read)(ftHandle,&ftdata);
	ftdata.MaxPower=power;
	(*m_pEE_Program)(ftHandle,&ftdata);
	return 0;
}

unsigned int FT_EE_ProgramToDefault()
{
	FT_PROGRAM_DATA ftdata={
		0x0403,
		0x6001,
		"FTDI",
		"FT",
		"USB HS Serial Converter",
		"FT000001",
		44,
		1,
		0,
		1,
		FALSE,
		FALSE,
		FALSE,
		FALSE,
		FALSE,
		FALSE,
		0
	};

	(*m_pEE_Program)(ftHandle,&ftdata);
	return 0;
}

unsigned int FT_EE_Read(unsigned short *vid, unsigned short *pid, unsigned short *power)
{
    FT_PROGRAM_DATA ftdata;
	char ManufacturerBuf[32];
	char ManufacturerIdBuf[16];
	char DescriptionBuf[64];
	char SerialNumberBuf[16];

	ftdata.Manufacturer=ManufacturerBuf;
	ftdata.ManufacturerId=ManufacturerIdBuf;
	ftdata.Description=DescriptionBuf;
	ftdata.SerialNumber=SerialNumberBuf;

	(*m_pEE_Read)(ftHandle,&ftdata);
    *vid=ftdata.VendorId;
	*pid=ftdata.ProductId;
	*power=ftdata.MaxPower;
	return 0;
}

unsigned int FT_GetLatencyTimer(unsigned char *data)
{
	return (*m_pGetLatencyTimer)(ftHandle,data);
}

unsigned int FT_SetLatencyTimer(unsigned char data)
{
	return (*m_pSetLatencyTimer)(ftHandle,data);
}

unsigned int FT_SetBitMode(UCHAR mask, UCHAR enable)
{
    return (*m_pSetBitMode)(ftHandle,mask,enable);
}

unsigned int FT_SetUSBParameters(unsigned long insize, unsigned long outsize)
{
	return (*m_pSetUSBParameters)(ftHandle,insize,outsize);
}

/****************************************************************************************************/
/* KCANSend                                                                                         */
/****************************************************************************************************/
/*                                                                                                  */
/* descript.: Send a CAN Transmit Request to AI                                                     */
/*                                                                                                  */
/*            Header      DIR PMT CH  ID              DLC DATA (8 Bytes)                            */
/*            $61 $00 $10 $30 $00 $CH $ID $ID $ID $ID $DL $DT ... $DT                               */
/*                                                                                                  */
/*                                                                                                  */
/* input parameter     typ     remark                                                               */
/* ------------------------------------------------------------------------------------------------ */
/* output parameter    typ     remark                                                               */
/* ------------------------------------------------------------------------------------------------ */
/* return code         typ     remark                                                               */
/* ------------------------------------------------------------------------------------------------ */
/****************************************************************************************************/
unsigned int KCAN_Send(unsigned int channel, unsigned int id, unsigned int dlc, unsigned char *data)
{
	unsigned long i;
	CHAR packet_header[10]={0x61,0x00,0x10,0x30,0x00,0x00,0x00,0x00,0x00,0x00};

	packet_header[5]=channel;

	packet_header[6]=id>>24;
	packet_header[7]=id>>16 &0xFF;
	packet_header[8]=id>>8  &0xFF;
	packet_header[9]=id     &0xFF;
	packet_header[10]=dlc;

   (*m_pWrite)(ftHandle,packet_header,11,&i);
   (*m_pWrite)(ftHandle,data,8,&i);
   return 0;
}

/****************************************************************************************************/
/* KCANReceive                                                                                      */
/****************************************************************************************************/
/*                                                                                                  */
/* descript.: Receive all CAN Messages from AI                                                      */
/*                                                                                                  */
/*            Header      DIR PMT CH  ID              DLC DATA (8 Bytes)                            */
/*            $61 $00 $10 $31 $00 $CH $ID $ID $ID $ID $DL $DT ... $DT                               */
/*                                                                                                  */
/*                                                                                                  */
/* input parameter     typ     remark                                                               */
/* ------------------------------------------------------------------------------------------------ */
/* output parameter    typ     remark                                                               */
/* ------------------------------------------------------------------------------------------------ */
/* return code         typ     remark                                                               */
/* ------------------------------------------------------------------------------------------------ */
/****************************************************************************************************/
unsigned int KCAN_Receive(unsigned int *channel, unsigned int *id, unsigned int *dlc, unsigned char *data)
{
	SSLP_Receive();

	if (CAN_rx_buffer_read_pnt!=CAN_rx_buffer_write_pnt) {
		CAN_rx_buffer_read_pnt++;
		if (CAN_rx_buffer_read_pnt>=CAN_RX_BUFFER_SIZE)
			CAN_rx_buffer_read_pnt=0;
		*channel  =0;
		*id       =CAN_rx_buffer[CAN_rx_buffer_read_pnt].id;
		*dlc      =CAN_rx_buffer[CAN_rx_buffer_read_pnt].dlc;
		memcpy(data,&CAN_rx_buffer[CAN_rx_buffer_read_pnt].data,8);
		return 0;					// No Error - Frame available
	}
	else {
		return 1;					// Error
	}
}

unsigned int KCAN_Init(unsigned int baudrate)
{
	(*m_pOpen)(0,&ftHandle);
	return (0);
}

/****************************************************************************************************/
/* SSLP_Receive                                                                                     */
/****************************************************************************************************/
/*                                                                                                  */
/* descript.: Receive SSLP Messages from AI                                                         */
/*                                                                                                  */
/*            Header      DIR PMT CH  ID              DLC DATA (8 Bytes)                            */
/*            $61 $00 $10 $31 $00 $CH $ID $ID $ID $ID $DL $DT ... $DT                               */
/*                                                                                                  */
/*                                                                                                  */
/* input parameter     typ     remark                                                               */
/* ------------------------------------------------------------------------------------------------ */
/* output parameter    typ     remark                                                               */
/* ------------------------------------------------------------------------------------------------ */
/* return code         typ     remark                                                               */
/* ------------------------------------------------------------------------------------------------ */
/****************************************************************************************************/
unsigned int SSLP_Receive(void)
{
	unsigned long byte_read;
	WORD size;

	BYTE data[30];

	while (FT_RX_Size()>0)								// SOF as minimum available
	{
		(*m_pRead)(ftHandle,data,1,&byte_read);	
		if (data[0]==0x61) {
			(*m_pRead)(ftHandle,data,2,&byte_read);		// Read SIZE
			size=data[0]<<8|data[1];
			if (size<30)
			{
				(*m_pRead)(ftHandle,data,size,&byte_read);		// Read DIR/PMT/DATA
				switch (data[0])
				{
					case 0x31:															// CAN RX Frame
						CAN_rx_buffer_write_pnt++;
						if (CAN_rx_buffer_write_pnt>=CAN_RX_BUFFER_SIZE)
							CAN_rx_buffer_write_pnt=0;
						CAN_rx_buffer[CAN_rx_buffer_write_pnt].id=data[3]<<24 |
																  data[4]<<16 |
																  data[5]<<8  |
																  data[6];
						CAN_rx_buffer[CAN_rx_buffer_write_pnt].dlc=data[7];
						memcpy(&CAN_rx_buffer[CAN_rx_buffer_write_pnt].data,&data[8],8);	// copy can data
						break;
					case 0x33:

						break;
				}
			}
		}
	}
	return(0);
}

unsigned int FT_RX_Size()
{
	unsigned long rx_cnt;
	(*m_pGetQueueStatus)(ftHandle,&rx_cnt);
	return rx_cnt;
}
