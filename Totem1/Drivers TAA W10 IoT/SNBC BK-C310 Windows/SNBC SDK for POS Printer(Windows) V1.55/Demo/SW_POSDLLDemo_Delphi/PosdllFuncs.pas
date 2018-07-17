unit PosdllFuncs;

interface

uses
  Classes;

type
  PInt = ^Integer;

function POS_Open(pszPortName: pchar; nComBaudrate: integer; nComDataBits: integer; nComStopBits: integer; nComParity: Integer; nComFlowControl: Integer): Integer; stdcall; external 'POSDLL.dll';

function POS_Close(): Integer; stdcall; external 'POSDLL.dll';

function POS_Reset(): Integer; stdcall; external 'POSDLL.dll';

function POS_SetMode(nPrintMode:integer):integer;stdcall;external 'POSDLL.dll';

function POS_SetMotionUnit(nHorizontalMU: integer; nVerticalMU: integer): integer; stdcall; external 'POSDLL.dll';

function POS_SetCharSetAndCodePage(nCharSet: Integer; nCodePage: Integer): integer; stdcall; external 'POSDLL.dll';

function POS_FeedLine(): Integer; stdcall; external 'POSDLL.dll';

function POS_SetLineSpacing(nDistance:integer):integer;stdcall;external 'POSDLL.dll';

function POS_SetRightSpacing(nMode:integer):integer;stdcall;external 'POSDLL.dll';

function POS_CutPaper(nMode:integer;nDistance:integer):integer;stdcall;external 'POSDLL.dll';

function POS_PreDownloadBmpToRAM(pszPath:pchar;nID:integer):integer;stdcall;external 'POSDLL.dll';

function POS_PreDownloadBmpsToFlash(pszPath:array of string; nCount:integer):integer;stdcall;external 'POSDLL.dll';

function POS_QueryStatus(pszStatus: PChar; nTimeouts: Integer): Integer; stdcall; external 'POSDLL.dll';

function POS_RTQueryStatus(pszStatus: PChar):integer; stdcall;external 'POSDLL.dll';

function POS_KickOutDrawer(nID: Integer; nOnTimes: Integer; nOffTimes: Integer): Integer; stdcall; external 'POSDLL.dll';

function POS_EnumUSBPrinter(cPrinterName:PChar):Integer; stdcall;external 'POSDLL.dll';
//The functions only support standard mode (or line mode)

function POS_S_SetAreaWidth(nWidth: Integer): Integer; stdcall; external 'POSDLL.dll';

function POS_S_TextOut(pszString:pchar;nOrgx:integer;nWidthTimes:integer;nHeightTimes:integer;nFontType:integer;nFontStyle:integer):integer;stdcall;external 'POSDLL.dll';

function POS_S_DownloadAndPrintBmp(pszPath: PChar; nOrgx: Integer; nMode: Integer): Integer; stdcall; external 'POSDLL.dll';

function POS_S_PrintBmpInRAM(nID:integer;nOrgx:integer;nMode:integer):integer;stdcall;external 'POSDLL.dll';

function POS_S_PrintBmpInFlash(nID:integer;nOrgx:integer;nMode:integer):integer;stdcall;external 'POSDLL.dll';

function POS_S_SetBarcode(pszInfo:pchar;nOrgx:integer;nType:integer;nWidthX:integer;nheight:integer;nHriFontType:integer;HriFontPosition:integer;nBytesOfInfo:integer):integer;stdcall;external 'POSDLL.dll';

//The functions only support paper mode and (or) label mode

function POS_PL_SetArea(nOrgx:integer;nOrgY:integer;nWidth:integer;nheight:integer;nDirection:integer):integer;stdcall;external 'POSDLL.dll';

function POS_PL_TextOut(pszString:pchar;nOrgx:integer;nOrgY:integer;nWidthTimes:integer;nHeightTimes:integer;nFontType:integer;nFontStyle:integer):integer;stdcall;external 'POSDLL.dll';

function POS_PL_DownloadAndPrintBmp(pszPath: PChar; nOrgx: Integer; nOrgy: Integer; nMode: Integer): Integer; stdcall; external 'POSDLL.dll';

function POS_PL_PrintBmpInRAM(nID:integer;nOrgx:integer;nOrgY:integer;nMode:integer):integer;stdcall;external 'POSDLL.dll';

function POS_PL_SetBarcode(pszInfo:pchar;nOrgx:integer;nOrgY:integer;nType:integer;nWidthX:integer;nheight:integer;nHriFontType:integer;HriFontPosition:integer;nBytesOfInfo:integer):integer;stdcall;external 'POSDLL.dll';

function POS_PL_Clear():integer;stdcall;external 'POSDLL.dll';

function POS_PL_Print():integer;stdcall;external 'POSDLL.dll';

// The functions for debug

function POS_WriteFile(hPort: Integer; pszData: PChar; nBytesToWrite: Integer): Integer; stdcall; external 'POSDLL.dll';

function POS_ReadFile(hPort: Integer; pszData: PChar; nBytesToRead: Integer; nTimeouts: Integer): Integer; stdcall; external 'POSDLL.dll';

function POS_SetHandle(hNewHandle: Integer): Integer; stdcall; external 'POSDLL.dll';

function POS_GetVersionInfo(pnMajor: PInt; pnMinor: PInt): Integer; stdcall; external 'POSDLL.dll';
function POS_StartDoc():Boolean; stdcall; external 'POSDLL.dll';
function POS_EndDoc():Boolean; stdcall; external 'POSDLL.dll';
function POS_NETQueryStatus( ipAddress :pchar; pszStatus:pchar ):Integer; stdcall; external 'POSDLL.dll';

procedure POS_BeginSaveFile(lpFileName :pchar;bToPrinter:boolean); stdcall; external 'POSDLL.dll';
procedure POS_EndSaveFile();stdcall; external 'POSDLL.dll';
// The return value of function.
Const POS_SUCCESS =  1001;
Const POS_FAIL  =   1002;
Const POS_ERROR_INVALID_HANDLE      = 1101;
Const POS_ERROR_INVALID_PARAMETER   = 1102;
Const POS_ERROR_NOT_BITMAP          = 1103;
Const POS_ERROR_NOT_MONO_BITMAP     = 1104;
Const POS_ERROR_BEYONG_AREA         = 1105;
Const POS_ERROR_INVALID_PATH        = 1106;
Const POS_COM_ONESTOPBIT            = 0;
Const POS_COM_ONE5STOPBITS          = 1;
Const POS_COM_TWOSTOPBITS           = 2;

//Parity options of serial port
Const POS_COM_NOPARITY       = 0;
Const POS_COM_ODDPARITY      = 1;
Const POS_COM_EVENPARITY     = 2;
Const POS_COM_MARKPARITY     = 3;
Const POS_COM_SPACEPARITY    = 4;

// Flow control options of serial port
Const POS_COM_DTR_DSR       = 0;
Const POS_COM_RTS_CTS       = 1;
Const POS_COM_XON_XOFF      = 2;

// Mode options of the way of paper leaving away from printer
Const POS_PAPER_OUT_MODE_CUT       = 0;
Const POS_PAPER_OUT_MODE_PEEL      = 1;
Const POS_PAPER_OUT_MODE_TEAR      = 2;
Const POS_PAPER_OUT_MODE_OTHER     = 3;

// Print mode options
Const POS_PRINT_MODE_STANDARD             = 0;
Const POS_PRINT_MODE_PAGE                 = 1;
Const POS_PRINT_MODE_BLACK_MARK_LABEL     = 2;
Const POS_PRINT_MODE_WHITE_MARK_LABEL     = 3;

// Font type options
Const POS_FONT_TYPE_STANDARD              = 0;
Const POS_FONT_TYPE_COMPRESSED            = 1;
Const POS_FONT_TYPE_UDC                   = 2;
Const POS_FONT_TYPE_CHINESE               = 3;

// Font style options
Const POS_FONT_STYLE_NORMAL             = $0;
Const POS_FONT_STYLE_BOLD               = $8;
Const POS_FONT_STYLE_THIN_UNDERLINE     = $80;
Const POS_FONT_STYLE_THICK_UNDERLINE    = $100;
Const POS_FONT_STYLE_UPSIDEDOWN         = $200 ;
Const POS_FONT_STYLE_REVERSE            = $400 ;
Const POS_FONT_STYLE_SMOOTH             = $800;
Const POS_FONT_STYLE_CLOCKWISE_90       = $1000;

// Specify the area direction of paper or lable
Const POS_AREA_LEFT_TO_RIGHT     = 0;
Const POS_AREA_BOTTOM_TO_TOP     = 1;
Const POS_AREA_RIGHT_TO_LEFT     = 2;
Const POS_AREA_TOP_TO_BOTTOM     = 3;

// Cut mode options
Const POS_CUT_MODE_FULL          = 0;
Const POS_CUT_MODE_PARTIAL       = 1;

// Mode options of printing bit image in RAM or Flash
Const POS_BITMAP_PRINT_NORMAL         = 0;
Const POS_BITMAP_PRINT_DOUBLE_WIDTH   = 1;
Const POS_BITMAP_PRINT_DOUBLE_HEIGHT  = 2;
Const POS_BITMAP_PRINT_QUADRUPLE      = 3;

// Mode options of bit-image -- for download and print
Const POS_BITMAP_MODE_8SINGLE_DENSITY   = $0;
Const POS_BITMAP_MODE_8DOUBLE_DENSITY   = $1;
Const POS_BITMAP_MODE_24SINGLE_DENSITY  = $20;
Const POS_BITMAP_MODE_24DOUBLE_DENSITY  = $21;

// Barcode's type
Const POS_BARCODE_TYPE_UPC_A            = $41;
Const POS_BARCODE_TYPE_UPC_E            = $42;
Const POS_BARCODE_TYPE_JAN13            = $43;
Const POS_BARCODE_TYPE_JAN8             = $44;
Const POS_BARCODE_TYPE_CODE39           = $45;
Const POS_BARCODE_TYPE_ITF              = $46;
Const POS_BARCODE_TYPE_CODEBAR          = $47;
Const POS_BARCODE_TYPE_CODE93           = $48;
Const POS_BARCODE_TYPE_CODE128          = $49;

// Barcode HRI's position
Const POS_HRI_POSITION_NONE         = $0;
Const POS_HRI_POSITION_ABOVE        = $1;
Const POS_HRI_POSITION_BELOW        = $2;
Const POS_HRI_POSITION_BOTH         = $3;

implementation

end.
