unit PortIO;
//此模块用于实现打印机的各种通讯

interface

uses StrUtils,Windows, WinTypes, WinSvc, SysUtils, Dialogs,Printers,Common,Forms,WinSpool,ReadWriteIni,IniFiles;

const
  // Masks
  BIT0 = $01;
  BIT1 = $02;
  BIT2 = $04;
  BIT3 = $08;
  BIT4 = $10;
  BIT5 = $20;
  BIT6 = $40;
  BIT7 = $80;

  // Printer Port pin numbers
  ACK_PIN       = 10;
  BUSY_PIN      = 11;
  PAPEREND_PIN  = 12;
  SELECTOUT_PIN = 13;
  ERROR_PIN     = 15;
  STROBE_PIN    = 1;
  AUTOFD_PIN    = 14;
  INIT_PIN      = 16;
  SELECTIN_PIN  = 17;

  Timeout = 20000;

  MAX_LPT_PORTS = 8;

  LPTPORT1 = 0;
  LPTPORT2 = 1;
  LPTPORT3 = 2;
  LPTPORT4 = 3;
  COMPORT1 = 5;
  COMPORT2 = 6;
  COMPORT3 = 7;
  COMPORT4 = 8;
  COMPORT5 = 9;
  COMPORT6 = 10;
  COMPORT7 = 11;
  COMPORT8 = 12;
  USBPORT1 = 13;
  USBPORT2 = 14;
  USBPORT3 = 15;
  USBPORT4 = 16;
  USBPORT5 = 17;
  USBPORT6 = 18;
  USBPORT7 = 19;
  USBPORT8 = 20;
  USBPORT9 = 21;
  USBPORT10 = 22;
  USBPORT11 = 23;
  USBPORT12 = 24;
  USBPORT13 = 25;
  USBPORT14 = 26;
  USBPORT15 = 27;
  USBPORT16 = 28;
  DriverPort = 50;


  dcb_Binary              = $00000001;
  dcb_ParityCheck         = $00000002;
  dcb_OutxCtsFlow         = $00000004;
  dcb_OutxDsrFlow         = $00000008;
  dcb_DtrControlMask      = $00000030;
  dcb_DtrControlDisable   = $00000000;
  dcb_DtrControlEnable    = $00000010;
  dcb_DtrControlHandshake = $00000020;
  dcb_DsrSensivity        = $00000040;
  dcb_TXContinueOnXoff    = $00000080;
  dcb_OutX                = $00000100;
  dcb_InX                 = $00000200;
  dcb_ErrorChar           = $00000400;
  dcb_NullStrip           = $00000800;
  dcb_RtsControlMask      = $00003000;
  dcb_RtsControlDisable   = $00000000;
  dcb_RtsControlEnable    = $00001000;
  dcb_RtsControlHandshake = $00002000;
  dcb_RtsControlToggle    = $00003000;
  dcb_AbortOnError        = $00004000;
  dcb_Reserveds           = $FFFF8000;


function OpenComPort(ComName:string;Baudrate,Parity,ByteSize,StopBits,FlowControl:integer): boolean;
function SetWaitTime(WaitTime:integer):boolean;
function CloseCom(): boolean;

function OpenLPTPort(LPTAddr: Integer): boolean;
function CloseLPT(): boolean;

function OpenPort(PrinterCfg:TPrinterCfg): boolean;
function ClosePort(PrinterCfg:TPrinterCfg):boolean;

function WritePort(PortNo: Integer; s: string): boolean;

function  DLReadByte(Port: DWORD): BYTE; stdcall; external 'DLPortIO.dll' name 'DlPortReadPortUchar';
procedure DlWriteByte(Port: DWORD; Value: BYTE); stdcall; external 'DLPortIO.Dll' name 'DlPortWritePortUchar';

function GetPrinterInternalID(hdev:INTEGER):integer;stdcall;external 'ByUsbInt.dll';
function OpenDeviceByInternalID(iID:INTEGER):integer;stdcall;external 'ByUsbInt.dll';
function  OpenDeviceByName(pDeviceTypeName:pchar;iNumber:integer):integer;stdcall;external 'ByUsbInt.dll';
function  OpenDeviceX(x:integer):integer;stdcall;external 'ByUsbInt.dll';
procedure CloseDevice(m_handle:integer);stdcall;external 'ByUsbInt.dll';
function  uWrite(m_handle:integer;pipeNum:integer;buf:pchar;bufSize:integer):integer;stdcall;external 'ByUsbInt.dll';
function  uRead(m_handle:integer;pipeNum:integer;buf:pchar;bufSize:integer):integer;stdcall;external 'ByUsbInt.dll';
function  ResetPipes(m_handle:integer;pipe:integer):boolean;stdcall;external 'ByUsbInt.dll';
function  VendorRequest(m_handle:integer; request:pchar; buffer:pchar; bufferSize:integer; nBytes:integer):boolean;stdcall;external 'ByUsbInt.dll';
function  GetDescriptor(m_handle:integer; pDesc:pchar):boolean;stdcall;external 'ByUsbInt.dll';
//function  GetConfiguration(m_handle:integer):PVOID;stdcall;external 'ByUsbInt.dll';
function  GetPipeInfo(m_handle:integer;pInterface:pchar):boolean;stdcall;external 'ByUsbInt.dll';
function  AbortPipes(m_handle:integer;pipe:integer):boolean;stdcall;external 'ByUsbInt.dll';
function  SetInterface(m_handle:integer;intf:integer;altsetting:integer):boolean;stdcall;external 'ByUsbInt.dll';
function  GetDeviceStatus(m_handle:integer):boolean;stdcall;external 'ByUsbInt.dll';

function GetDeviceStartUSBID(PrinterIndex,DPIIndex:integer):integer;
function GetDeviceUSBName(USBID:Integer):string;
function GetDeviceIndex(DeviceName:string):integer;
function GetDeviceUSBNameFromID(PrinterIndex,ComPortID:Integer):string;

//modifier:jiahuifeng 5-8
Function  ClosePrinterDriver(hprinter:THandle):boolean;
Function  OpenPrinterDriver(drivername:PChar):THandle;
Function  WritePrinterDriver(hprinter:THandle;databuf:PChar;length:integer):integer;
Function  GetCurrentPortName(drivername:PChar):string;

Function  NbySetDefaultPrinter(pPrinterName:pchar):bool;stdcall;external 'NbyAddPrinter.dll';
Function  NbyInstallPortMonitor(pInterfaceName:pchar):bool;stdcall;external 'NbyAddPrinter.dll';
Function  NbyChangePrnPort(PrinterName,pPortName:pchar):bool;stdcall;external 'NbyAddPrinter.dll';
Function  NbyAddPrinter(cPrinterName,cPortName:pchar):bool;stdcall;external 'NbyAddPrinter.dll';
Function  NbyGetPrnPort(PrinterName:pchar;pPortName:pchar):bool;stdcall;external 'NbyAddPrinter.dll';

  //驱动信息
  Type
    DriverInfor=Record
    hPrinter:THandle;
    DriverName:string;
    DriverPort:string;
  end;

const
 WRITE_PIPENUM = 0;
 READ_PIPENUM  = 1;
 
var
  HCom: THandle;          //串口句柄
  HUsb: Integer;          //并口支持
  printtofile:boolean;
  DriverParameter:DriverInfor;

implementation
uses
  PrinterCode;

const
  DRIVER_NAME  = 'DLPortIO';
  DISPLAY_NAME = 'DriverLINX Port I/O Driver';
  DRIVER_GROUP = 'SST miniport drivers';

type
  TDlPortReadPortUchar  = function(Port: DWORD): BYTE; stdcall;
  TDlPortWritePortUchar  = procedure(Port: DWORD; Value: BYTE); stdcall;

var
  FRunningWinNT: boolean;     // True when we're running Windows NT

  FLastError: string;

  // For the extended LPT functions
  //  FLPTNumber: byte;        // Current number of the printer port, default=1
  FLPTBase: word;          // The address of the current printer port (faster)

  // Used for the Windows NT version only
  FDrvPrevInst: boolean;         // DriverLINX driver already installed?
  FDrvPrevStart: boolean;        // DriverLINX driver already running?

  hSCMan: SC_HANDLE;       // For use with WinNT Service Control Manager

//modifier:jiahuifeng 5-8
Function  ClosePrinterDriver(hprinter:THandle):boolean;
begin
  if  hPrinter  <>  INVALID_HANDLE_VALUE  then
  begin
    ClosePrinter(hPrinter);
  end;
  Result  :=  True;
  Exit;
end;
//modifier:jiahuifeng 5-8
Function  OpenPrinterDriver(drivername:PChar):THandle;
var
  lpDefault:PPrinterDefaults;
  m_hPrinter:THandle;
begin
  //参数判断
  m_hPrinter  :=  INVALID_HANDLE_VALUE;
  lpDefault :=  new(PPrinterDefaults);
  lpDefault.DesiredAccess :=  PRINTER_ACCESS_USE;
  lpDefault.pDatatype :=  nil;
  lpDefault.pDevMode  :=  nil;
  OpenPrinter(drivername,m_hPrinter,lpDefault);
  Dispose(lpDefault);
  if m_hPrinter = INVALID_HANDLE_VALUE  then
  begin
    Result  :=  INVALID_HANDLE_VALUE;
    Exit;
  end;
  Result  :=  m_hPrinter;
  Exit;
end;

Function  GetCurrentPortName(drivername:PChar):string;
var
  lpDefault:PPrinterDefaults;
  m_hPrinter:THandle;
  dwNeeded,dwReturned:DWORD;
  buf:PORT_INFO_2;
  //buf:pchar;
  dkdkd:bool;
begin
 { //参数判断
  m_hPrinter  :=  INVALID_HANDLE_VALUE;
  lpDefault :=  new(PPrinterDefaults);


  //lpDefault:=allocmem(sizeof(PPrinterDefaults));
  //lpDefault.DesiredAccess :=  PRINTER_ACCESS_USE;

  lpDefault.DesiredAccess :=  PRINTER_ALL_ACCESS;
  lpDefault.pDatatype :=  'RAW';
  lpDefault.pDevMode  :=  nil;

  if not OpenPrinter(drivername,m_hPrinter,lpDefault) then
  //if not OpenPrinter(drivername,m_hPrinter,nil) then
  begin
    Dispose(lpDefault);
  end
  else //正确打开
  begin
    GetPrinter(m_hPrinter, 2, @buf, 0, @dwNeeded);

    GetPrinter(m_hPrinter, 2, @buf, dwNeeded, @dwReturned);
    result:=buf.pPortName;
    //freemem(buf);
  end; //完－－正确打开    }

end;
//modifier:jiahuifeng 5.8
Function  WritePrinterDriver(hprinter:THandle;databuf:PChar;length:integer):integer;
var
  DocInfo:DOC_INFO_1;
	nsize:DWORD;
  nReturn:boolean;
begin
  {DocInfo.pDocName  :=  'BTP-Transfer Document';
	DocInfo.pOutputFile :=  0;
	DocInfo.pDatatype :=  'RAW';
  if  StartDocPrinter(hPrinter,1,@DocInfo) <=  0 then
  begin
    ClosePrinter(hPrinter);
    Result  :=  -1;
    Exit;
  end;
  if StartPagePrinter(hPrinter) = False then
  begin
    ClosePrinter(hPrinter);
    Result  :=  -1;
    Exit;
  end;  }


	nReturn := WritePrinter(hprinter,databuf,length,nsize);
	if(nReturn  = False)  then
	begin
		Result  :=-1;
    Exit;
	end;
	if(nsize <> length) then
	begin
		Result  :=-1;
    Exit;
	end;

 {	if  EndPagePrinter(hprinter) = False then
  begin
    ClosePrinter(hPrinter);
    Result  :=  -1;
    Exit;
  end;

	if  EndDocPrinter( hprinter) = False  then
  begin
    ClosePrinter(hPrinter);
    Result  :=  -1;
    Exit;
  end; }
  Result  :=  nSize;
  Exit;
end;

function OpenPort(PrinterCfg:TPrinterCfg): boolean;
var
  m_usbid:integer;
begin
   if (PrinterCfg.ComPort >= COMPORT1) and (PrinterCfg.ComPort <= COMPORT8) then //串口
   begin
     Result := OpenComPort('Com'+IntToStr(PrinterCfg.ComPort-4),PrinterCfg.BaudRate,PrinterCfg.Parity,
                 PrinterCfg.ByteSize,PrinterCfg.StopBits,PrinterCfg.FlowControl);
   end
   //modifier:jiahuifeng 5-8
   else if (PrinterCfg.ComPort=99) then
   begin

    DriverParameter.DriverName  :='BTP-Transfer';
    if DriverParameter.hPrinter <> INVALID_HANDLE_VALUE then
    begin
      ClosePrinterDriver(DriverParameter.hPrinter);
    end;
    DriverParameter.hPrinter  :=  INVALID_HANDLE_VALUE;
    DriverParameter.hPrinter  :=  OpenPrinterDriver(PAnsiChar(DriverParameter.DriverName));
    if  (DriverParameter.hPrinter  <> INVALID_HANDLE_VALUE) and (DriverParameter.hPrinter  >0)  then
    begin
      //MessageDlg('错误'+DriverParameter.DriverName,mtInformation,[mbOK],0);
      //Exit;
      Result:=true;
    end
    else
    begin
      Result:=false;
    end;
   end
   else if (PrinterCfg.ComPort >= LPTPORT1) and (PrinterCfg.ComPort <= LPTPORT4) then //并口
   begin
   //  ClosePort(PrinterCfg);
     Result := OpenLPTPort(PrinterCfg.LPTAddr);
     ClosePort(PrinterCfg);
     Result := OpenLPTPort(PrinterCfg.LPTAddr);
     ClosePort(PrinterCfg);
   end
   else if (PrinterCfg.ComPort >= USBPORT1) and (PrinterCfg.ComPort <= USBPORT16) then //USB
   begin
     HUsb := -1;
     //HUsb := OpenDeviceX(PrinterCfg.ComPort-13);
     m_usbid := GetDeviceStartUSBID(m_Global_PrinterIndex,PrinterCfg.DPI)+(PrinterCfg.ComPort - USBPORT1);
     HUsb := OpenDeviceByInternalID(m_usbid);
     if HUsb = -1 then
     begin
//       HUsb := nUsbPortIndex;
//       HUsb := OpenDeviceX(nUsbPortIndex);
       Result := FALSE;
       EXIT;
     end;
     Result := TRUE;
   end;
end;

function ClosePort(PrinterCfg:TPrinterCfg):boolean;
begin
   if (PrinterCfg.ComPort >= COMPORT1) and (PrinterCfg.ComPort <= COMPORT8) then
   begin
     Result := CloseCom();
   end
   else if (PrinterCfg.ComPort >= LPTPORT1) and (PrinterCfg.ComPort <= LPTPORT4) then //并口
   begin
     Result :=  CloseLPT();
   end
   else if (PrinterCfg.ComPort >= USBPORT1) and (PrinterCfg.ComPort <= USBPORT16) then //usb口
   begin
     CloseDevice(HUsb);
     HUsb := -1;
   end;
end;

//***********************************************//
// 函数：OpenComPort                             //
// 功能：打开指定串口                            //
// 参数：ComName 串口名称 string类型  com1       //
//       Baudrate 波特率  integer类型 38400      //
//       Parity  校验方式 integer类型            //
//           ODDPARITY:1;EVENPARITY:2;NOPARITY:0 //
//       ByteSize 数据位  integer类型 8 7        //
//       StopBits 停止位  integer类型            //
//           ONESTOPBIT:0  TWOSTOPBITS:2         //
//       FlowControl 流控制  integer类型         //
//        0:硬件（RTS/CTS） 1:软件(XON/XOFF)     //
// 返回值：bool类型，true为成功，false为失败     //
//***********************************************//
function OpenComPort(ComName:string;Baudrate,Parity,ByteSize,StopBits,FlowControl:integer): boolean;
var
  PortDCB: TDCB;
  CommTimeouts: TCOMMTIMEOUTS;
begin
  Result := True;
  CloseHandle(HCom);  //强行关闭通讯句柄
  HCom := INVALID_HANDLE_VALUE;
  HCom := CreateFile(pchar(ComName),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,0,0);
  if HCom = INVALID_HANDLE_VALUE then
  begin
    CloseHandle(HCom);
    HCom := INVALID_HANDLE_VALUE;
    Result := False;
    exit;
  end;

  //对串行口进行配置
  PortDCB.DCBlength := sizeof(DCB);
  if not GetCommState(hCom, PortDCB) then
  begin
    CloseHandle(HCom);
    HCom := INVALID_HANDLE_VALUE;
    Result := False;
    exit;
  end;

  PortDCB.BaudRate := BaudRate;
  PortDCB.Parity   := Parity;
  PortDCB.ByteSize := ByteSize;
  if StopBits = 0 then PortDCB.StopBits := ONESTOPBIT;

  PortDCB.Flags := 0;
  case FlowControl of
  1:
    begin
      PortDCB.Flags := PortDCB.Flags or dcb_OutxCtsFlow or dcb_RtsControlEnable;
    end;
  0:
    begin
      PortDCB.Flags := PortDCB.Flags or dcb_OutX or dcb_InX;
      PortDCB.XONChar := #17;
      PortDCB.XOFFChar:= #19;
    end;
  end;
  
  if not SetCommState(hCom, PortDCB) then
  begin
    CloseHandle(HCom);
    HCom := INVALID_HANDLE_VALUE;
    Result := False;
    exit;
  end;

  //设置超时
  if not GetCommTimeouts(hCom, CommTimeouts) then begin
    CloseHandle(HCom);
    HCom := INVALID_HANDLE_VALUE;    
    Result := False;
    exit;
  end;
  CommTimeouts.ReadIntervalTimeout         := $ffffffff;
  CommTimeouts.ReadTotalTimeoutMultiplier  := 0;
  CommTimeouts.ReadTotalTimeoutConstant    := 0;
  CommTimeouts.WriteTotalTimeoutMultiplier := 1000;
  CommTimeouts.WriteTotalTimeoutConstant   := 1000;

  if not SetCommTimeouts(hCom, CommTimeouts) then begin
    CloseHandle(HCom);
    HCom := INVALID_HANDLE_VALUE;
    Result := False;
    exit;
  end;
end;

//设置超时时间
function SetWaitTime(WaitTime:integer):boolean;
var
  CommTimeouts: TCOMMTIMEOUTS;
begin
  Result := True;
  if hCom = INVALID_HANDLE_VALUE then
  begin
    Result := False;
    exit;
  end;
  //设置超时时间
  if not GetCommTimeouts(hCom, CommTimeouts) then begin
    CloseHandle(HCom);
    HCom := INVALID_HANDLE_VALUE;
    Result := False;
    exit;
  end;
  CommTimeouts.ReadIntervalTimeout         := $ffffffff;
  CommTimeouts.ReadTotalTimeoutMultiplier  := 0;
  CommTimeouts.ReadTotalTimeoutConstant    := 0;
  CommTimeouts.WriteTotalTimeoutMultiplier := WaitTime;
  CommTimeouts.WriteTotalTimeoutConstant   := WaitTime;

  if not SetCommTimeouts(hCom, CommTimeouts) then begin
    CloseHandle(HCom);
    HCom := INVALID_HANDLE_VALUE;    
    Result := False;
    exit;
  end;
end;

//关闭串口
function CloseCom(): boolean;
begin
  Result := CloseHandle(hCom);
  hCom := INVALID_HANDLE_VALUE;
end;

procedure SetLPTNumber(LPTAddr: Integer);
begin
  // Note that we don't make sure it is within the range 1..FLPTCount
  // because there _might_ (can someone claify this?) be a port numbered
  // as #2, where it may be the _only_ port installed on the system.
  FLPTBase := LPTAddr;
 //   for i := 1 to MAX_LPT_PORTS do
 //   FLPTAddress[i] := LPT1Addr;
end;

function LPTDriverInit(LPTAddr: Integer): boolean;
var
  os: OSVERSIONINFO;
begin
   // Are we running Windows NT?
   os.dwOSVersionInfoSize := sizeof(OSVERSIONINFO);
   GetVersionEx(os);
   FRunningWinNT := (os.dwPlatformId = VER_PLATFORM_WIN32_NT);

   // No errors yet
   FLastError := '';

   //**  Set up the Printer Port stuff

   // Detect the printer ports available
   //DetectPorts();

   // Set the default LPT number
   SetLPTNumber(LPTAddr);

   Result := True;
end;

function DriverOpened: boolean;
begin
  Result := True;
end;

function DriverStop: boolean;
var
  hService: SC_HANDLE;
  dwStatus: DWORD;
  sStatus: SERVICE_STATUS;
begin

  // If we didn't start the driver, then don't stop it.
  // Pretend we stopped it, by indicating success.
  if FDrvPrevStart then begin
    Result := True;
    exit;
  end;

  hService :=INVALID_HANDLE_VALUE;
  // Get a handle to the service to stop
  hService := OpenService(
              hSCMan,
              DRIVER_NAME,
              SERVICE_STOP or SERVICE_QUERY_STATUS);

  if hService <> INVALID_HANDLE_VALUE then begin
     // Stop the driver, then close the service

     if not ControlService(hService, SERVICE_CONTROL_STOP, sStatus) then
       dwStatus := GetLastError;

     // Close the service
     CloseServiceHandle(hService);
  end else
    dwStatus := GetLastError;

  if dwStatus <> 0 then
    FLastError := Format('DriverStop: Error #%d', [dwStatus]);

  Result := (dwStatus = 0); // Success == 0
end;

function DriverRemove: boolean;
var
  hService: SC_HANDLE;
  dwStatus: DWORD;
begin
  // If we didn't install the driver, then don't remove it.
  // Pretend we removed it, by indicating success.
   if FDrvPrevStart then begin
     Result := True;
     exit;
   end;
  hService :=INVALID_HANDLE_VALUE;
  // Get a handle to the service to remove
  hService := OpenService(
                hSCMan,
                DRIVER_NAME,
                SERVICE_ALL_ACCESS);
//                DELETE);

  if hService <> INVALID_HANDLE_VALUE then begin
     // Remove the driver then close the service again
     if not DeleteService(hService) then
        dwStatus := GetLastError;
      // Close the service
     CloseServiceHandle(hService);
  end else
     dwStatus := GetLastError;

  if dwStatus <> 0 then
    FLastError := Format('DriverRemove: Error #%d', [dwStatus]);

  Result := (dwStatus = 0); // Success == 0
end;

function ConnectSCM: boolean;
var
  dwStatus: DWORD;
  scAccess: DWORD;
begin
  dwStatus := 0;
  // Try and connect as administrator
  scAccess := SC_MANAGER_CONNECT or
              SC_MANAGER_QUERY_LOCK_STATUS or
              SC_MANAGER_ENUMERATE_SERVICE or
              SC_MANAGER_CREATE_SERVICE;      // Admin only

  // Connect to the SCM
  hSCMan := OpenSCManager(nil, nil, scAccess);

  // If we're not in administrator mode, try and reconnect
  if (hSCMan = 0) and (GetLastError = ERROR_ACCESS_DENIED) then begin
    scAccess := SC_MANAGER_CONNECT or
                SC_MANAGER_QUERY_LOCK_STATUS or
                SC_MANAGER_ENUMERATE_SERVICE;

    // Connect to the SCM
    hSCMan := OpenSCManager(nil, nil, scAccess);
   end;

   // Did it succeed?
   if hSCMan =INVALID_HANDLE_VALUE then begin
     // Failed, save error information
     dwStatus := GetLastError;
     FLastError := Format('ConnectSCM: Error #%d', [dwStatus]);
   end;

   Result := (dwStatus = 0); // Success == 0
end;

procedure DisconnectSCM;
begin
  if hSCMan <> INVALID_HANDLE_VALUE then begin
    // Disconnect from our local Service Control Manager
    CloseServiceHandle(hSCMan);
    hSCMan := 0;
  end;
end;

function DriverInstall: boolean;
var
  hService: SC_HANDLE;
  dwStatus: DWORD;
  DriverPath: string;
begin

  FDrvPrevInst := false; // Assume the driver wasn't installed previously

  // Path including filename
  DriverPath := m_Global_ApplicationDir + '\'+DRIVER_NAME + '.SYS';//SysPath + DRIVER_NAME + '.SYS';


  // Is the DriverLINX driver already in the SCM? If so,
  // indicate success and set FDrvPrevInst to true.
  hService := OpenService(hSCMan, DRIVER_NAME, SERVICE_QUERY_STATUS);
  if hService <> 0 then begin
    FDrvPrevInst := true;            // Driver previously installed, don't remove
    CloseServiceHandle(hService); // Close the service
    Result := True;
    exit;
  end;

  // Add to our Service Control Manager's database
  hService := CreateService(
               hSCMan,
               DRIVER_NAME,
               DISPLAY_NAME,
               SERVICE_START or SERVICE_STOP or SERVICE_QUERY_STATUS,
               SERVICE_KERNEL_DRIVER,
               SERVICE_DEMAND_START,
               SERVICE_ERROR_NORMAL,
               pChar(DriverPath),
               DRIVER_GROUP,
               nil, nil, nil, nil);

   if hService <> INVALID_HANDLE_VALUE then
     dwStatus := GetLastError
   else
     // Close the service for now...
     CloseServiceHandle(hService);

   if dwStatus <> 0 then
     FLastError := Format('DriverInstall: Error #%d', [dwStatus]);

   Result := (dwStatus = 0); // Success == 0
end;

procedure CloseDriver;
begin
   // If we're running Windows NT, stop the driver then remove it
   if FRunningWinNT then begin
      if not DriverStop then exit;
      if not DriverRemove then exit;
      DisconnectSCM;
   end;
end;

function DriverStart: boolean;
var
  hService: SC_HANDLE;
  dwStatus: DWORD;
  sStatus: SERVICE_STATUS;
  ServiceArgVectors: pchar;
begin

   FDrvPrevStart := false; // Assume the driver was not already running

   hService := OpenService(hSCMan, DRIVER_NAME, SERVICE_QUERY_STATUS);
   if (hService <> INVALID_HANDLE_VALUE) and (QueryServiceStatus(hService, sStatus)) then begin
     // Got the service status, now check it
     if sStatus.dwCurrentState = SERVICE_RUNNING then begin
       FDrvPrevStart := true;           // Driver was previously started
       CloseServiceHandle(hService); // Close service
       Result := True;
       exit;
     end else if sStatus.dwCurrentState = SERVICE_STOPPED then begin
       // Driver was stopped. Start the driver.
       CloseServiceHandle(hService);
       hService := OpenService(hSCMan, DRIVER_NAME, SERVICE_START);
       if not StartService(hService, 0, ServiceArgVectors) then
         dwStatus := GetLastError;
       CloseServiceHandle(hService); // Close service
     end else
       dwStatus := 0; // Can't run the service
   end else
      dwStatus := GetLastError;

   if dwStatus <> 0 then
     FLastError := Format('DriverStart: Error #%d', [dwStatus]);

   Result := (dwStatus = 0); // Success == 0
end;

procedure OpenDriver;
begin
  // If we're running Windows NT, install the driver then start it
  if FRunningWinNT then begin
    // Connect to the Service Control Manager
    if not ConnectSCM then exit;

    // Install the driver
    if not DriverInstall then begin
      // Driver install failed, so disconnect from the SCM
      DisconnectSCM;
      exit;
    end;

    // Start the driver
    if not DriverStart then begin
      // Driver start failed, so remove it then disconnect from SCM
      DriverRemove;
      DisconnectSCM;
      exit;
    end;
  end;
end;

// 打开并口
function OpenLPTPort(LPTAddr: Integer): boolean;
begin
  LPTDriverInit(LPTAddr);

  if DriverOpened then CloseDriver;

  OpenDriver;

  if not DriverOpened then begin
    Result := False;
    exit;
  end;

  Result := True;
end;

function CloseLPT(): boolean;
begin
  CloseDriver;
  Result := True;
end;

//---------------------------------------------------------------------------
// ReadPort()
//---------------------------------------------------------------------------
function ReadPort(Address: WORD): BYTE;
begin
  Result := DLReadByte(Address)
end;

//---------------------------------------------------------------------------
// WritePort()
//---------------------------------------------------------------------------
procedure LWritePort(Address: WORD; Data: BYTE);
begin
  DlWriteByte(Address, Data);
end;

function GetPin(Pin: byte): boolean;
begin
  case Pin of
    1:  Result := (ReadPort(FLPTBase+2) and BIT0) = 0;  // Inverted
    2:  Result := (ReadPort(FLPTBase) and BIT0) <> 0;
    3:  Result := (ReadPort(FLPTBase) and BIT1) <> 0;
    4:  Result := (ReadPort(FLPTBase) and BIT2) <> 0;
    5:  Result := (ReadPort(FLPTBase) and BIT3) <> 0;
    6:  Result := (ReadPort(FLPTBase) and BIT4) <> 0;
    7:  Result := (ReadPort(FLPTBase) and BIT5) <> 0;
    8:  Result := (ReadPort(FLPTBase) and BIT6) <> 0;
    9:  Result := (ReadPort(FLPTBase) and BIT7) <> 0;
    10: Result := (ReadPort(FLPTBase+1) and BIT6) <> 0;
    11: Result := (ReadPort(FLPTBase+1) and BIT7) = 0;  // Inverted
    12: Result := (ReadPort(FLPTBase+1) and BIT5) <> 0;
    13: Result := (ReadPort(FLPTBase+1) and BIT4) <> 0;
    14: Result := (ReadPort(FLPTBase+2) and BIT1) = 0;  // Inverted
    15: Result := (ReadPort(FLPTBase+1) and BIT3) <> 0;
    16: Result := (ReadPort(FLPTBase+2) and BIT2) <> 0;
    17: Result := (ReadPort(FLPTBase+2) and BIT3) = 0;  // Inverted
  else
    Result := false;  // pins 18-25 (GND), and other invalid pins
  end;
end;

function LPTBusy: boolean;
begin
  result := GetPin(BUSY_PIN);
end;

function LPTError: boolean;
begin
  result := GetPin(ERROR_PIN);
end;

function LPTPaperEnd: boolean;
begin
  result := GetPin(PAPEREND_PIN);
end;



function LPTPrintChar(c: char): boolean;
var
  i: Integer;
begin
  // Write data to Base+0
  LWritePort(FLPTBase, ord(c));
  // Write 0Dh to Base+2.
  LWritePort(FLPTBase+2, $0D);
  // Make sure there's a delay of at least one microsecond
  i := 0;
  repeat
    i := i + 1
  until i < 5000;
  // Write 0Ch to Base+2.
  LWritePort(FLPTBase+2, $0C);
  // Input from Base+1 and check if Bit 7 is 1.
  // Return this status as whether the character was printed
  Result := (ReadPort(FLPTBase+1) and BIT7) <> 0;
end;

//写数据到串并口
function WritePort(PortNo: Integer; s: string): boolean;
var
  myIniFile:TIniFile;
  folderName,FileName,fasong,tishi:string;
  Count: DWORD;
  Ticks: DWORD;
  i: Integer;
  hfile:integer;
  send_success:boolean;
  sign_success:boolean;
  sign_exit:boolean;
  lwBytesWritten: Longword;
  p:pchar;
  //fasong,tishi:string;
begin
  sign_exit := False;
  Result := True;
  if Printtofile then
  begin
    if not FileExists('e:\temp.txt') then hfile := FileCreate('e:\temp.txt')
    else hfile := FileOpen('e:\temp.txt',fmOpenWrite);
    FileSeek(hfile,0,2);
    FileWrite(hfile,S[1],length(s));
    FileClose(hfile);
    exit;
  end;

  if(PortNo >= LPTPORT1) and (PortNo <= COMPORT8) then
  begin

          if m_Global_SysRecord.LanguageID=0 then //简体中文
          begin
            fasong:='发送出错，需要重新发送吗？';
            tishi:='提示';
          end
          else if m_Global_SysRecord.LanguageID=1 then   //英文
          begin
            fasong:='Send data error,send again?';
            tishi:='error';
          end
          else
          begin
            fasong:='髮送錯誤，需要重新髮送嗎？';
            tishi:='提示';
          end;  
    //逐个字节处理
    for i:=1 to length(s) do
    begin
      send_success := False;
      while send_success = false do    //while  send_success = false
      begin
        Result := True;
        if (PortNo >= COMPORT1) and (PortNo <= COMPORT8) then
        begin
          WriteFile(hCom, s[i], 1 ,Count, nil);
          if count <> 1 then
          begin
            Result := false;
          end;
        end   //完－－串口


        else if (PortNo >= LPTPORT1) and (PortNo <= LPTPORT4) then//并口
        begin

         {  folderName:=GetLanguageFolderName(m_Global_SysRecord.LanguageID);
            Filename:=ExtractFilePath(Paramstr(0))+'Language'+'\'+foldername+ '.lan';;
            myinifile := Tinifile.Create(Filename);
            fasong:=myIniFile.ReadString('PortIO','message1','');
            tishi:=myIniFile.ReadString('All','tishi','');  }
          sign_success := true;
          if not DriverOpened then exit;
          Ticks := GetTickCount() + Timeout;
          while LPTBusy  or (not LPTError) or LPTPaperEnd do
          begin
            if GetTickCount > Ticks then
            begin
              sign_success := false;  //用于确定是否发送数据
              Result := False;
              break;
            end;
          end;
          //发送数据
          if sign_success = true then
          begin
            LPTPrintChar(s[i]);
          end;
        end; //完－－并口
        if Result = False then
        begin
          if Application.MessageBox(pchar(fasong),pchar(tishi),MB_ICONQUESTION+MB_YESNO) = IDYES then
         // if Application.MessageBox('发送？','提示',MB_ICONQUESTION+MB_YESNO) = IDYES then
          begin
            Result := True;
            send_success := false;
            sign_exit  := false;
          end else
          begin
            send_success := true;
            sign_exit  := true;    //结束发送
          end;  // if Application.MessageBox('发送出错,需要重新发送吗?','提示',MB_ICONQUESTION+MB_YESNO) = IDYES then
        end else    //Result = true
        begin
          send_success := true;
          sign_exit  := false;     //继续发送下一个
        end; //完－－Result = true
      end; //完－－send_success = false
      if sign_exit = true then exit;
    end;           //完－－for
    //myinifile.Destroy;
  end

  else if PortNo=99 then //驱动
  begin
    WritePrinterDriver(DriverParameter.hPrinter,pchar(s),length(s));
  end
  else if (PortNo >= USBPORT1) and (PortNo <= USBPORT16) then
  begin

    PrintBuftest:=PrintBuftest+s;
    if leftstr(s,1)='E' then
    begin
      lwBytesWritten := uWrite(HUsb,WRITE_PIPENUM, pchar(Printbuftest),length(PrintBuftest));
      if lwBytesWritten<>length(s) then
      begin
        //result := False;
        exit;
      end;
    end;
    //p := @s[i];

  end;
end;

function GetDeviceStartUSBID(PrinterIndex,DPIIndex:integer):integer;
begin
  if(PrinterIndex = PRINTER_2100E) then
  begin
    Result := USB_2100E2ID;
    //if (PRINTER_DPI[DPIIndex] = 203) then Result := USB_2100E2ID
    //else Result := USB_2100E3ID;
  end
  else if (PrinterIndex = PRINTER_2200E) then
  begin
    Result := USB_2200EID;
  end
  else if (PrinterIndex = PRINTER_2300E) then
  begin
    Result := USB_2300EID;
  end
  else if (PrinterIndex = PRINTER_6200I) then
  begin
    Result := USB_6200IID;
  end
  else
  begin
    Result := USB_6300IID;
    //if (PRINTER_DPI[DPIIndex] = 203) then Result := USB_6200I2ID
    //else Result := USB_6200I3ID;
  end;
end;

function GetDeviceUSBName(USBID:Integer):string;
begin
  Result := '';
  if(USBID >= USB_2100E2ID) and (USBID < USB_2100E3ID) then
  begin
    //Result := 'BTP-2100E2(U) '+IntToStr(USBID-USB_2100E2ID);
    Result := 'BTP-2100E(203DPI) - '+IntToStr(USBID-USB_2100E2ID+1);
  end
  else if(USBID >= USB_2100E3ID) and (USBID < USB_6200IID) then
  begin
    //Result := 'BTP-2100E3(U) '+IntToStr(USBID-USB_2100E3ID);
    //Result := 'Device '+IntToStr(USBID-USB_2100E3ID+1);
    Result := 'BTP-2100E(300DPI) - '+IntToStr(USBID-USB_2100E3ID+1);
  end
  else if (USBID>=USB_2200EID) and (USBID<USB_2300EID) then//2200E
  begin
    Result := 'BTP-2200E - '+IntToStr(USBID-USB_2200EID+1);
  end
  else if (USBID>=USB_2300EID) and (USBID<USB_6300IID) then//2300E
  begin
    Result := 'BTP-2300E - '+IntToStr(USBID-USB_2300EID+1);
  end

  else if(USBID >= USB_6200IID) and (USBID < 120) then
  begin
    //Result := 'BTP-6200I2(U) '+IntToStr(USBID-USB_6200I2ID);
    Result := 'BTP-6200I - '+IntToStr(USBID-USB_6200IID+1);
  end
  else  if(USBID >= USB_6300IID) and (USBID < 304) then
  begin
    //Result := 'BTP-6200I3(U) '+IntToStr(USBID-USB_6200I3ID);
    Result := 'BTP-6300I - '+IntToStr(USBID-USB_6300IID+1);
  end;
end;

function GetDeviceIndex(DeviceName:string):integer;
begin
  Result := -1;
  if Pos('203',DeviceName)>0 then
  begin
    if Pos('- 1',DeviceName)>0 then Result := 1
    else if Pos('- 2',DeviceName)>0 then Result := 2
    else if Pos('- 3',DeviceName)>0 then Result := 3
    else if Pos('- 4',DeviceName)>0 then Result := 4
    else if Pos('- 5',DeviceName)>0 then Result := 5
    else if Pos('- 6',DeviceName)>0 then Result := 6
    else if Pos('- 7',DeviceName)>0 then Result := 7
    else if Pos('- 8',DeviceName)>0 then Result := 8;
  end
  else if Pos('300',DeviceName)>0 then
  begin
    if Pos('- 1',DeviceName)>0 then Result := 9
    else if Pos('- 2',DeviceName)>0 then Result := 10
    else if Pos('- 3',DeviceName)>0 then Result := 11
    else if Pos('- 4',DeviceName)>0 then Result := 12
    else if Pos('- 5',DeviceName)>0 then Result := 13
    else if Pos('- 6',DeviceName)>0 then Result := 14
    else if Pos('- 7',DeviceName)>0 then Result := 15
    else if Pos('- 8',DeviceName)>0 then Result := 16;
  end;
end;

function GetDeviceUSBNameFromID(PrinterIndex,ComPortID:Integer):string;
begin
  Result := '';
  if(PrinterIndex = PRINTER_2100E) then
  begin
    if(ComPortID >= USBPORT1) and (ComPortID <= USBPORT8) then
      Result := 'BTP-2100E(203DPI) - '+IntToStr(ComPortID-USBPORT1+1)
    else if(ComPortID >= USBPORT9) and (ComPortID <= USBPORT16) then
      Result := 'BTP-2100E(300DPI) - '+IntToStr(ComPortID-USBPORT9+1);
  end
  else if(PrinterIndex = PRINTER_6200I) then
  begin
    if(ComPortID >= USBPORT1) and (ComPortID <= USBPORT8) then
      Result := 'BTP-6200I(203DPI) - '+IntToStr(ComPortID-USBPORT1+1)
    else if(ComPortID >= USBPORT9) and (ComPortID <= USBPORT16) then
      Result := 'BTP-6200I(300DPI) - '+IntToStr(ComPortID-USBPORT9+1);
  end;
end;

end.
