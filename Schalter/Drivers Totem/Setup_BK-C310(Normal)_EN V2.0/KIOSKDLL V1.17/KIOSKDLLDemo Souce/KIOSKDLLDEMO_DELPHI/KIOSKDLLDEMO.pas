unit KIOSKDLLDEMO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, winspool, LoadDLL, StrUtils, Menus, ComCtrls,
  ShellApi,Mask;

type
  TMainForm = class(TForm)
    Openport: TButton;
    QueryStatus: TButton;
    Print: TButton;
    Close: TButton;
    nExit: TButton;
    strMsg: TEdit;
    Savetofile: TCheckBox;
    SelectPort: TRadioGroup;
    GroupBox1: TGroupBox;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    StaticText10: TStaticText;
    DriverName: TComboBox;
    WriteTimeOut: TEdit;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    GroupBox2: TGroupBox;
    ComName: TComboBox;
    DataBits: TComboBox;
    Parity: TComboBox;
    StopBits: TComboBox;
    FlowControl: TComboBox;
    LPTAddress: TComboBox;
    Baudrate: TComboBox;
    ReadTimeOut: TEdit;
    StandardMode: TRadioButton;
    PresenterMode: TRadioButton;
    RadioGroup4: TRadioGroup;
    StaticText13: TStaticText;
    StaticText14: TStaticText;
    GroupBox7: TGroupBox;
    Start: TButton;
    Stop: TButton;
    StatusMonitor: TMemo;
    SelectMode: TRadioGroup;
    Select: TRadioGroup;
    Presenter: TRadioGroup;
    Bundler: TRadioGroup;
    PageWidth: TComboBox;
    Resolution: TComboBox;
    PDF417: TButton;
    Sample: TButton;
    procedure SelectPortClick(Sender: TObject);
    procedure SelectModeClick(Sender: TObject);
    procedure SelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure StopClick(Sender: TObject);
    procedure nExitClick(Sender: TObject);
    procedure SavetofileClick(Sender: TObject);
    procedure OpenportClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure QueryStatusClick(Sender: TObject);
    procedure PresenterClick(Sender: TObject);
    procedure BundlerClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure ReadTimeOutKeyPress(Sender: TObject; var Key: Char);
    procedure WriteTimeOutKeyPress(Sender: TObject; var Key: Char);
    function FormHelp(Command: Word; Data: Integer;
    var CallHelp: Boolean): Boolean;
    procedure PDF417Click(Sender: TObject);
    procedure SampleClick(Sender: TObject);

  private
    { Private declarations }

    procedure PrintInStandardMode56_203DPI();
    procedure PrintInStandardMode56_300DPI();
    procedure PrintInPageMode56_203DPI();
    procedure PrintInPageMode56_300DPI();

    procedure PrintInStandardMode80_203DPI();
    procedure PrintInStandardMode80_300DPI();
    procedure PrintInPageMode80_203DPI();
    procedure PrintInPageMode80_300DPI();

    procedure PrintInStandardMode210_203DPI();
    procedure PrintInStandardMode210_300DPI();
    procedure PrintInPageMode210_203DPI();
    procedure PrintInPageMode210_300DPI();

    procedure PrintSample();
    function IsPrinting():Boolean;
    function PaperTackout():Boolean;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  ThreadRunning: bool;
  state: integer;
  nPortType: integer;               //Port Selecting
  Mode: integer;                    //Print Mode Selecting
  nPaperOut: integer;               //Paper Out Mode Selecting
  nPresenter: integer;              //Presenter  Setting
  nBundler: integer;                //Bundler  Setting
  nSaveToTxt: bool;                 //Sending data to file but not to port.

  PrinterInfo: PPrinterInfo2;
  PrinterNum : DWORD;
  Number: integer;
  tem: string;

implementation

uses StatusThread;

{$R *.dfm}

{******************************************************************************************************************************************
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
*******************************************************************************************************************************************}
procedure TMainForm.PrintInStandardMode56_203DPI();
var
  pBitImages: array[0..2] of string;
begin
  //Pre-download a group of bit map to Flash by specifying it's ID.
  pBitImages[0] := 'Kitty.bmp';
	pBitImages[1] := 'Look.bmp';
  if KIOSK_PreDownloadBmpToFlash( state, nPortType, pBitImages, 2, 2 ) <> KIOSK_SUCCESS then
  begin
    CloseClick( Close );
    strMsg.Text := 'Print failed!';
    exit;
  end;

  //Print setting.
  KIOSK_Reset( state, nPortType );

	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_STANDARD );

  KIOSK_SetMotionUnit( state, nPortType, 180, 180 );

  KIOSK_S_SetLeftMarginAndAreaWidth( state, nPortType, 0, 640 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetLineSpacing( state, nPortType, 95 );

  //Text setting
  KIOSK_S_Textout( state, nPortType, 'Microcom KIOSK Printer', 5, 2, 2,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_SetLineSpacing( state, nPortType, 15 );
		
	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state,nPortType, 2 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 215, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 1 );

  KIOSK_S_Textout( state, nPortType, 'Right Spacing', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );
	
	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 215, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 215, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);
	
	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-BOLD', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );


	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD,	KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-90', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

  //Bar code setting.
	KIOSK_S_Textout( state, nPortType, 'Barcode - Code 128', 5, 1, 1,
	                 KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine(state, nPortType );

	KIOSK_S_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 5, KIOSK_BARCODE_TYPE_CODE128,
	                      2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_FeedLine( state, nPortType );

  KIOSK_S_Textout( state, nPortType, '-----------------------------------', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

  //Bit map setting.
	KIOSK_S_Textout( state, nPortType, '---------------Logo1---------------', 5, 1, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 1, 50, KIOSK_BITMAP_PRINT_QUADRUPLE );

	KIOSK_FeedLine( state, nPortType ); //Feed 1 line.

	KIOSK_S_Textout( state, nPortType, '---------------Logo2---------------', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType ); //Feed 1 line.

	KIOSK_S_PrintBmpInFlash( state, nPortType, 2, 5, KIOSK_BITMAP_PRINT_QUADRUPLE );

  //Print setting.
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	
	KIOSK_CutPaper( state, nPortType, 1, 0 );

  strMsg.Text := 'Print success!';
end;

{******************************************************************************************************************************************
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
*******************************************************************************************************************************************}
procedure TMainForm.PrintInPageMode56_203DPI();
begin
  //Pre-download a bit map to RAM by specifying it's ID.
	if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'kitty.bmp', 2, 0 ) <> KIOSK_SUCCESS then
  begin
    CloseClick( Close );
    strMsg.Text := 'Print failed!';
    exit;
  end;
	KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Look.bmp', 2, 1 );

  //Print setting.
  KIOSK_Reset( state, nPortType );

	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_PAGE );

	KIOSK_SetMotionUnit( state, nPortType, 180, 180 );
	
	KIOSK_P_SetAreaAndDirection( state, nPortType, 5, 10, 640, 1200, KIOSK_AREA_LEFT_TO_RIGHT );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

  KIOSK_SetLineSpacing( state, nPortType, 95 );

  //Text setting
	KIOSK_P_Textout( state, nPortType, 'Microcom KIOSK Printer', 5, 80, 2, 2,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '-----------------------------------', 5, 120,1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


	KIOSK_P_Textout( state, nPortType, '-----------------------------------', 5, 140,1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 5, 180, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 215, 180, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 1 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 5, 210, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 215, 210, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 2 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 5, 240, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 215, 240, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 5, 300, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-BOLD', 5, 330, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 5, 360, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

  KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 5, 390, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD,	KIOSK_FONT_STYLE_THIN_UNDERLINE );

  KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 5, 420, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

  //Bar code setting.
  KIOSK_P_Textout( state, nPortType, '-------------------------------', 5, 460,1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'Barcode - Code 128', 5, 490, 1, 1,
                   KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 5,560, KIOSK_BARCODE_TYPE_CODE128,
	                      2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

  //Bit map setting.
	KIOSK_P_Textout( state, nPortType, '-------------------------------', 5, 610,1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, '-------------Logo1-------------', 5, 630, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 0, 5,  700, KIOSK_BITMAP_PRINT_QUADRUPLE);

	KIOSK_P_Textout( state, nPortType, '-------------Logo2-------------', 5, 720,1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 1, 5, 810, KIOSK_BITMAP_PRINT_QUADRUPLE);

  //Print setting.
	KIOSK_P_Print( state, nPortType );

	KIOSK_P_Clear( state, nPortType );
  
	KIOSK_CutPaper( state, nPortType, 1, 0 );

  strMsg.Text := 'Print success!';

end;

{******************************************************************************************************************************************
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
*******************************************************************************************************************************************}
procedure TMainForm.PrintInStandardMode56_300DPI();
var
  pBitImages: array[0..2] of string;
begin
  //Pre-download a group of bit map to Flash by specifying it's ID.
  pBitImages[0] := 'Kitty.bmp';
	pBitImages[1] := 'Look.bmp';
  if KIOSK_PreDownloadBmpToFlash( state, nPortType, pBitImages, 2, 2 ) <> KIOSK_SUCCESS then
  begin
    CloseClick( Close );
    strMsg.Text := 'Print failed!';
    exit;
  end;

  //Print setting.
  KIOSK_Reset( state, nPortType );

  KIOSK_SetMode( state,nPortType, KIOSK_PRINT_MODE_STANDARD );

	KIOSK_SetMotionUnit( state, nPortType, 180, 180 );

  KIOSK_S_SetLeftMarginAndAreaWidth( state, nPortType, 0, 640 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetLineSpacing( state, nPortType, 95 );

  //Text setting
	KIOSK_S_Textout( state, nPortType, 'Microcom KIOSK Printer', 5, 2, 2,
	KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_SetLineSpacing( state, nPortType, 15 );

	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------', 5, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------', 5, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state,nPortType, 2 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 5, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 215, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

  KIOSK_SetRightSpacing( state, nPortType, 1 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 5, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 215, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 5, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 215, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);
	
	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 5, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-BOLD', 5, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 5, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 5, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,	KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 5, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-90', 5, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

  //Bar code setting.
	KIOSK_S_Textout( state, nPortType, '-----------------------------------', 5, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'Barcode - Code 128', 5, 1, 1,
                   KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 5, KIOSK_BARCODE_TYPE_CODE128,
		                     2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_FeedLine( state, nPortType );


  KIOSK_S_Textout( state, nPortType, '-----------------------------------', 5, 1, 1,
						       KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

  //Bit map setting.
	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '---------------Logo1---------------', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 1, 50, KIOSK_BITMAP_PRINT_QUADRUPLE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '---------------Logo2---------------', 5, 1, 1,
	                 KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 2, 50, KIOSK_BITMAP_PRINT_QUADRUPLE );

  //Print setting.
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	
	KIOSK_CutPaper( state, nPortType, 1, 0 );
  strMsg.Text := 'Print success!';
end;

{******************************************************************************************************************************************
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
*******************************************************************************************************************************************}
procedure TMainForm.PrintInPageMode56_300DPI();
begin
  //Pre-download a bit map to RAM by specifying it's ID.
	if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'kitty.bmp', 2, 0 ) <> KIOSK_SUCCESS then
  begin
    CloseClick( Close );
    strMsg.Text := 'Print failed!';
    exit;
  end;
	KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Look.bmp', 2, 1 );

  //Print setting.
  KIOSK_Reset( state, nPortType );

	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_PAGE );

	KIOSK_SetMotionUnit( state, nPortType, 180, 180 );
	
	KIOSK_P_SetAreaAndDirection( state, nPortType, 5, 10, 640, 1200, KIOSK_AREA_LEFT_TO_RIGHT );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

  KIOSK_SetLineSpacing( state, nPortType, 95 );

  //Text setting
	KIOSK_P_Textout( state, nPortType, 'Microcom KIOSK Printer', 5, 80, 2, 2,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '-----------------------------------', 5, 120,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


	KIOSK_P_Textout( state, nPortType, '-----------------------------------', 5, 140,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 5, 180, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 215, 180, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 1 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 5, 210, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 215, 210, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 2 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 5, 240, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 215, 240, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

  KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 5, 300, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-BOLD', 5, 330, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 5, 360, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 5, 390, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,	KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 5, 420, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

  //Bar code setting.
	KIOSK_P_Textout( state, nPortType, '-------------------------------', 5, 460,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'Barcode - Code 128', 5, 490, 1, 1,
		               KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 5,560, KIOSK_BARCODE_TYPE_CODE128,
		                    2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );
	


	KIOSK_P_Textout( state, nPortType, '-------------------------------', 5, 610,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, '-------------Logo1-------------', 5, 630, 1, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 0, 5,  700, KIOSK_BITMAP_PRINT_QUADRUPLE);

	KIOSK_P_Textout( state, nPortType, '-------------Logo2-------------', 5, 720,1, 1,
						       KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 1, 5, 810, KIOSK_BITMAP_PRINT_QUADRUPLE);

  //Print setting.
	KIOSK_P_Print( state, nPortType );

	KIOSK_P_Clear( state, nPortType );
  
	KIOSK_CutPaper( state, nPortType, 1, 0 );

  strMsg.Text := 'Print success!';

end;

{******************************************************************************************************************************************
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
*******************************************************************************************************************************************}
procedure TMainForm.PrintInStandardMode80_203DPI();
var
  pBitImages: array[0..2] of string;
begin
  //Pre-download a group of bit map to Flash by specifying it's ID.
  pBitImages[0] := 'Kitty.bmp';
	pBitImages[1] := 'Look.bmp';
  if KIOSK_PreDownloadBmpToFlash( state, nPortType, pBitImages, 2, 2 ) <> KIOSK_SUCCESS then
  begin
    CloseClick( Close );
    strMsg.Text := 'Print failed!';
    exit;
  end;

  //Print setting.
  KIOSK_Reset( state, nPortType );

	KIOSK_SetMode( state,nPortType, KIOSK_PRINT_MODE_STANDARD );

	KIOSK_SetMotionUnit( state,nPortType, 203, 203 );

  KIOSK_S_SetLeftMarginAndAreaWidth( state, nPortType, 0, 640 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetLineSpacing( state, nPortType, 95 );

  //Text setting
	KIOSK_S_Textout( state, nPortType, 'Microcom KIOSK Printer', 125, 2, 2,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_SetLineSpacing( state, nPortType, 24 );
		
	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 330, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );
	
	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 330, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 4 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 330, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLines( state, nPortType, 2);

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-BOLD', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,	KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-90', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	KIOSK_FeedLines( state, nPortType, 2 );

	//Bar code setting.
	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'Barcode - Code 128', 95, 1, 1,
		               KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );//Feed 1 line.

	KIOSK_S_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 95, KIOSK_BARCODE_TYPE_CODE128,
		                    2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_FeedLine( state, nPortType );
  
	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
						       KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

  //Bit map setting.
	KIOSK_S_Textout( state, nPortType, '------------------Logo 1------------------', 95, 1, 1,
						       KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 1, 100, KIOSK_BITMAP_PRINT_QUADRUPLE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '------------------Logo 2------------------', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 2, 95, KIOSK_BITMAP_PRINT_QUADRUPLE );

  //Print setting.
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	
	KIOSK_CutPaper( state, nPortType, 1, 0 );

  strMsg.Text := 'Print success!';
end;

{******************************************************************************************************************************************
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
*******************************************************************************************************************************************}
procedure TMainForm.PrintInPageMode80_203DPI();
begin
  //Pre-download a bit map to RAM by specifying it's ID.
	if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'kitty.bmp', 2, 0 ) <> KIOSK_SUCCESS then
  begin
    CloseClick( Close );
    strMsg.Text := 'Print failed!';
    exit;
  end;
	KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Look.bmp', 2, 1 );

  //Print setting.
  KIOSK_Reset( state, nPortType );

	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_PAGE );

	KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

	KIOSK_P_SetAreaAndDirection( state, nPortType, 0, 10, 640, 1200, KIOSK_AREA_LEFT_TO_RIGHT );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

  //Text setting
	KIOSK_P_Textout( state, nPortType, 'Microcom KIOSK Printer', 125, 80, 2, 2,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, '------------------------------------------', 95, 120,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	KIOSK_P_Textout( state, nPortType, '------------------------------------------', 95, 140,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 95, 180, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 330, 180, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 2 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 95, 210, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 330, 210, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 4 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 95, 240, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 330, 240, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 95, 300, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-BOLD', 95, 330, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 95, 360, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 95, 390, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,	KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 95, 420, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	//Bar code setting.
	KIOSK_P_Textout( state, nPortType, '------------------------------------', 95, 480,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'Barcode - Code 128', 95, 505, 1, 1,
		               KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 95,580, KIOSK_BARCODE_TYPE_CODE128,
		                    2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_P_Textout( state, nPortType, '------------------------------------', 95, 630,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

  //Bit map setting.
	KIOSK_P_Textout( state, nPortType, '---------------Logo 1---------------', 95, 650, 1, 1,
						       KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 0, 95,  720, KIOSK_BITMAP_PRINT_QUADRUPLE);

	KIOSK_P_Textout( state, nPortType, '---------------Logo 2---------------', 95, 740,1, 1,
						       KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 1, 95, 830, KIOSK_BITMAP_PRINT_QUADRUPLE);

  //Print setting.
	KIOSK_P_Print( state, nPortType );

	KIOSK_P_Clear( state, nPortType );
  
	KIOSK_CutPaper( state, nPortType, 1, 0 );

  strMsg.Text := 'Print success!';
end;

{******************************************************************************************************************************************
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
*******************************************************************************************************************************************}
procedure TMainForm.PrintInStandardMode80_300DPI();
var
  pBitImages: array[0..2] of string;
begin
  //Pre-download a group of bit map to Flash by specifying it's ID.
  pBitImages[0] := 'Kitty.bmp';
	pBitImages[1] := 'Look.bmp';
  if KIOSK_PreDownloadBmpToFlash( state, nPortType, pBitImages, 2, 2 ) <> KIOSK_SUCCESS then
  begin
    CloseClick( Close );
     strMsg.Text := 'Print failed!';
    exit;
  end;

  //Print setting.
  KIOSK_Reset( state, nPortType );

	KIOSK_SetMode( state,nPortType, KIOSK_PRINT_MODE_STANDARD );

	KIOSK_SetMotionUnit( state,nPortType, 203, 203 );

  KIOSK_S_SetLeftMarginAndAreaWidth( state, nPortType, 0, 640 );
	
	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetLineSpacing( state, nPortType, 95 );

  //Text setting
	KIOSK_S_Textout( state, nPortType, 'Microcom KIOSK Printer', 125, 2, 2,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_SetLineSpacing( state, nPortType, 24 );

	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 330, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );   

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 330, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 4 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 330, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);
	
	KIOSK_FeedLines( state, nPortType, 2);

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-BOLD', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,	KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-90', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
		                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

  //Bar code setting.
	KIOSK_S_Textout( state, nPortType, 'Barcode - Code 128', 95, 1, 1,
		                KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 95, KIOSK_BARCODE_TYPE_CODE128,
		                   2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
						       KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

  //Bit map setting.
	KIOSK_S_Textout(state, nPortType, '------------------Logo 1------------------', 95, 1, 1,
						      KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 1, 100, KIOSK_BITMAP_PRINT_QUADRUPLE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '------------------Logo 2------------------', 95, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 2, 95, KIOSK_BITMAP_PRINT_QUADRUPLE );

  //Print setting.
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	
	KIOSK_CutPaper( state, nPortType, 1, 0 );

  strMsg.Text := 'Print success!';
end;

{******************************************************************************************************************************************
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
*******************************************************************************************************************************************}
procedure TMainForm.PrintInPageMode80_300DPI();
begin
  //Pre-download a bit map to RAM by specifying it's ID.
	if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'kitty.bmp', 2, 0 ) <> KIOSK_SUCCESS then
  begin
    CloseClick( Close );
    strMsg.Text := 'Print failed!';
    exit;
  end;
	KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Look.bmp', 2, 1 );

  //Print setting.
  KIOSK_Reset( state, nPortType );

	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_PAGE );

	KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

	KIOSK_P_SetAreaAndDirection( state, nPortType, 0, 10, 640, 1200, KIOSK_AREA_LEFT_TO_RIGHT );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

  //Text setting
	KIOSK_P_Textout( state, nPortType, 'Microcom KIOSK Printer', 125, 80, 2, 2,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, '------------------------------------------', 95, 120,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	KIOSK_P_Textout( state, nPortType, '------------------------------------------', 95, 140,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 95, 180, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 200, 180, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 2 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 95, 210, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 200, 210, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 4 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 95, 240, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 200, 240, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 95, 300, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-BOLD', 95, 330, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 95, 360, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 95, 390, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,	KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 95, 420, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_P_Textout( state, nPortType, '------------------------------------', 95, 480,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

  //Bar code setting.
	KIOSK_P_Textout( state, nPortType, 'Barcode - Code 128', 95, 505, 1, 1,
		               KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 95,580, KIOSK_BARCODE_TYPE_CODE128,
		                   2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_P_Textout( state, nPortType, '------------------------------------', 95, 630,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

  //Bit map setting.
	KIOSK_P_Textout( state, nPortType, '---------------Logo 1---------------', 95, 650, 1, 1,
						       KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 0, 95,  720, KIOSK_BITMAP_PRINT_QUADRUPLE);


	KIOSK_P_Textout( state, nPortType, '---------------Logo 2---------------', 95, 740,1, 1,
						       KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 1, 95, 830, KIOSK_BITMAP_PRINT_QUADRUPLE);

  //Print setting.
	KIOSK_P_Print( state, nPortType );

	KIOSK_P_Clear( state, nPortType );
  
	KIOSK_CutPaper( state, nPortType, 1, 0 );

  strMsg.Text := 'Print success!';
end;

{******************************************************************************************************************************************
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
*******************************************************************************************************************************************}
procedure TMainForm.PrintInStandardMode210_203DPI();
begin
  //Pre-download a group of bit map to RAM by specifying it's ID.
	if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Map.bmp', 2, 0 ) <> KIOSK_SUCCESS then
  begin
    CloseClick( Close );
    strMsg.Text := 'Print failed!';
    exit;
  end;

  //Print setting.
	KIOSK_SetMode( state,nPortType, KIOSK_PRINT_MODE_STANDARD );

  KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

  KIOSK_S_SetLeftMarginAndAreaWidth( state, nPortType, 100, 1500 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetLineSpacing( state, nPortType, 20 );

	KIOSK_FeedLines( state,nPortType, 2 );

  //Text setting.
	KIOSK_S_Textout( state, nPortType, 'Microcom', 0, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_S_Textout( state, nPortType, 'Microcom Corporation',
                   800, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetLineSpacing( state, nPortType, 20 );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------------------------------------------------------------------------------------------------',
						       0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'Microcom KIOSK Printer', 500, 3, 3,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state,nPortType, 5 );

	KIOSK_SetLineSpacing( state, nPortType, 40 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, '  In order to providing the user who use the KIOSK printer to carry on two of developments, KIOSKDLL were developed by the Microcom Corporation',
		               0, 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state,nPortType, 1 );

	KIOSK_S_Textout( state, nPortType, '  We supply this sample to show our KIOSKDLL''s function. You can also rewoke the resident sample by yourself.',
		               0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetLineSpacing( state, nPortType, 15 );

	KIOSK_FeedLines( state, nPortType, 4 );

	KIOSK_S_Textout( state, nPortType, 'Support port:',0, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'COM', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_S_Textout( state, nPortType, 'LPT', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'USB', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_S_Textout( state, nPortType, 'Driver', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLines( state, nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Support system:',0, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'Windows 2000', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'Windows 2003',800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

  KIOSK_FeedLines( state, nPortType , 2 );

	KIOSK_S_Textout( state, nPortType, 'Windows XP',440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'Windows Vista', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Support bar code:', 0, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'UPC-A',440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'UPC-E', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'JAN13', 1200, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'JAN8', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'CODE39', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'ITF', 1200, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'CODEBAR', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'CODE93', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'CODE128', 1200, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'PDF417', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLines( state, nPortType, 3 );

  KIOSK_S_Textout( state, nPortType, 'Support equipment:', 0, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, '814M', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_FeedLines( state,nPortType, 2 );

	
  //Bit map setting.
	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Print   Bitmap:', 0, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_PrintBmpInRAM( state, nPortType, 0, 500, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );

  //Bar code setting
	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Print   Bar Code:', 0, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

  KIOSK_S_Textout( state, nPortType, 'Barcode - Code 128', 440, 2, 1,
                   KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 440, KIOSK_BARCODE_TYPE_CODE128,
		                    3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------------------------------------------------------------------------------------------------',
						       0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'YOUR THERMAL PRINTER PARTNER', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

  //Print setting.
  KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );
	
	KIOSK_CutPaper( state, nPortType, 1, 0 );

  strMsg.Text := 'Print success!';
end;

{******************************************************************************************************************************************
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
*******************************************************************************************************************************************}
procedure TMainForm.PrintInPageMode210_203DPI();
begin
  //Pre-download a bit map to RAM by specifying it's ID.
  if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Map.bmp',2, 0 ) <> KIOSK_SUCCESS then
	begin
    CloseClick( Close );
    strMsg.Text := 'Print failed!';
    exit;
  end;

  //Print setting.
  KIOSK_Reset( state, nPortType );

	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_PAGE );

	KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

	KIOSK_P_SetAreaAndDirection( state, nPortType, 95, 0, 1500, 2400, KIOSK_AREA_LEFT_TO_RIGHT );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

  //Text setting.
	KIOSK_P_Textout( state, nPortType, 'Microcom', 0, 100, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'Microcom Corporation',
                   800, 100,1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, '-----------------------------------------------------------------------------------------------------------------------------',
		                0, 150,1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'Microcom KIOSK Printer',500, 250,3, 3,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetLineSpacing( state, nPortType, 40 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, '  In order to providing the user who use the KIOSK printer to carry on two of developments, KIOSKDLL were developed by the Microcom Corporation',
		                0, 350 , 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '  We supply this sample to show our KIOSKDLL''s function. You can also rewoke the resident sample by yourself.',
		                0, 500, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetLineSpacing( state, nPortType, 15 );

	KIOSK_P_Textout( state, nPortType, 'Support port:', 0, 630, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'COM', 440, 630, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'LPT', 800, 630, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'USB', 440, 660, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'Driver', 800, 660, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'Support system:', 0, 730, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'Windows 2000', 440, 730, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Windows 2003', 800, 730, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Windows XP', 440, 760, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Windows Vista', 800, 760, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Support bar code:', 0, 820, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'UPC-A', 440, 820, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'UPC-E', 800, 820, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'JAN13', 1200, 820, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'JAN8', 440, 865, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODE39', 800, 865, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'ITF', 1200, 865, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODEBAR', 440, 910, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODE93', 800, 910, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODE128', 1200,910, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'PDF417', 440, 955, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

  KIOSK_P_Textout( state, nPortType, 'Support equipment:', 0, 1020, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '814M', 440, 1020, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	
  //Bit map setting.
	KIOSK_P_Textout( state, nPortType, 'Print   Bitmap:', 0, 1280, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

 	KIOSK_P_PrintBmpInRAM( state, nPortType, 0, 500, 1380, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );

  //Bar code setting.
	KIOSK_P_Textout( state, nPortType, 'Print   Bar Code:', 0, 1440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

  KIOSK_P_Textout( state, nPortType, 'Barcode - Code 128', 440, 1440, 2, 1,
                   KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 440, 1555,  KIOSK_BARCODE_TYPE_CODE128,
		                    3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_P_Textout( state, nPortType, '-----------------------------------------------------------------------------------------------------------------------------',
						       0, 1630, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);


	KIOSK_P_Textout( state, nPortType, 'YOUR THERMAL PRINTER PARTNER', 800, 1645, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

  //Print setting.
	KIOSK_P_Print( state, nPortType );

	KIOSK_P_Clear( state, nPortType );

	KIOSK_CutPaper( state, nPortType, 0, 0 );
                                            
  strMsg.Text := 'Print success!';
end;

{******************************************************************************************************************************************
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
*******************************************************************************************************************************************}
procedure TMainForm.PrintInStandardMode210_300DPI();
begin
  //Pre-download a group of bit map to RAM by specifying it's ID.
	if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Map.bmp', 2, 0 ) <> KIOSK_SUCCESS then
  begin
    CloseClick( Close );
    strMsg.Text := 'Print failed!';
    exit;
  end;

  //Print setting.
	KIOSK_SetMode( state,nPortType, KIOSK_PRINT_MODE_STANDARD );

  KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

  KIOSK_S_SetLeftMarginAndAreaWidth( state, nPortType, 100, 1500 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetLineSpacing( state, nPortType, 20 );

	KIOSK_FeedLines( state,nPortType, 2 );

  //Text setting.
	KIOSK_S_Textout( state, nPortType, 'Microcom', 0, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_S_Textout( state, nPortType, 'Microcom Corporation',
                   950, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetLineSpacing( state, nPortType, 20 );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------',
						       0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'Microcom KIOSK Printer', 500, 3, 3,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLines( state,nPortType, 5 );

	KIOSK_SetLineSpacing( state, nPortType, 40 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, '  In order to providing the user who use the KIOSK printer to carry on two of developments, KIOSKDLL were developed by the Microcom Corporation',
		                0, 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state,nPortType, 1 );

	KIOSK_S_Textout( state, nPortType, '  We supply this sample to show our KIOSKDLL''s function. You can also rewoke the resident sample by yourself.',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetLineSpacing( state, nPortType, 15 );

	KIOSK_FeedLines( state, nPortType, 4 );

	KIOSK_S_Textout( state, nPortType, 'Support port:',  0, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'COM', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_S_Textout( state, nPortType, 'LPT', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'USB', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_S_Textout( state, nPortType, 'Driver', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLines( state, nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Support system:', 0, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'Windows 2000', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'Windows 2003', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

  KIOSK_FeedLines( state, nPortType , 2 );

	KIOSK_S_Textout( state, nPortType, 'Windows XP', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'Windows Vista', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Support bar code:', 0, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'UPC-A', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'UPC-E', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'JAN13', 1200, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'JAN8', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'CODE39', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'ITF', 1200, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'CODEBAR', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'CODE93', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'CODE128', 1200, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'PDF417', 440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLines( state, nPortType, 3 );

  KIOSK_S_Textout( state, nPortType, 'Support equipment:', 0, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, '814M', 40, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_FeedLines( state,nPortType, 2 );

  //Bit map setting.
	KIOSK_S_Textout( state, nPortType, 'Print   Bitmap:', 0, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_PrintBmpInRAM( state, nPortType, 0, 500, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );

	KIOSK_FeedLines( state,nPortType, 3 );

  //Bar code setting.
	KIOSK_S_Textout( state, nPortType, 'Print   Bar Code:', 0, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );
  
  KIOSK_S_Textout( state, nPortType, 'Barcode - Code 128', 440, 2, 1,
                   KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 440, KIOSK_BARCODE_TYPE_CODE128,
		                    3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------',
						       0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'YOUR THERMAL PRINTER PARTNER', 800, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

  //Print setting.
  KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	KIOSK_FeedLine( state, nPortType );
	
	KIOSK_CutPaper( state, nPortType, 1, 0 );

  strMsg.Text := 'Print success!';
end;

{******************************************************************************************************************************************
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
*******************************************************************************************************************************************}
procedure TMainForm.PrintInPageMode210_300DPI();
begin
  //Pre-download a bit map to RAM by specifying it's ID.
  if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Map.bmp', 2, 0 ) <> KIOSK_SUCCESS then
	begin
    CloseClick( Close );
    strMsg.Text := 'Print failed!';
    exit;
  end;

  //Print setting.
  KIOSK_Reset( state, nPortType );

	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_PAGE );

	KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

	KIOSK_P_SetAreaAndDirection( state, nPortType, 95, 0, 1500, 2400, KIOSK_AREA_LEFT_TO_RIGHT );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

  //Text setting.
	KIOSK_P_Textout( state, nPortType, 'Microcom', 0, 100, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'Microcom Corporation',
                   950, 100,1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------',
		                0, 150,1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'Microcom KIOSK Printer', 500, 250,3, 3,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetLineSpacing( state, nPortType, 40 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, '  In order to providing the user who use the KIOSK printer to carry on two of developments, KIOSKDLL were developed by the Microcom Corporation',
		                0, 350 , 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '  We supply this sample to show our KIOSKDLL''s function. You can also rewoke the resident sample by yourself.',
		                0, 500, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetLineSpacing( state, nPortType, 15 );

	KIOSK_P_Textout( state, nPortType, 'Support port:', 0, 630, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'COM', 440, 630, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'LPT', 800, 630, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'USB', 440, 660, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'Driver', 800, 660, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'Support system:', 0, 730, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'Windows 2000', 440, 730, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Windows 2003', 800, 730, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Windows XP', 440, 760, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Windows Vista', 800, 760, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Support bar code:', 0, 820, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'UPC-A', 440, 820, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'UPC-E', 800, 820, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'JAN13', 1200, 820, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );


	KIOSK_P_Textout( state, nPortType, 'JAN8', 440, 865, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODE39', 800, 865, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'ITF', 1200, 865, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODEBAR', 440, 910, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODE93', 800, 910, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODE128', 1200,910, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'PDF417', 440, 955, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

  KIOSK_P_Textout( state, nPortType, 'Support equipment:', 0, 1020, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '814M', 440, 1020, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

  //Bit map setting.
	KIOSK_P_Textout( state, nPortType, 'Print   Bitmap:', 0, 1280, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 0, 500, 1380, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );

  //Bar code setting.
	KIOSK_P_Textout( state, nPortType, 'Print   Bar Code:', 0, 1440, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

  KIOSK_P_Textout( state, nPortType, 'Barcode - Code 128', 440, 1440, 2, 1,
                   KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 440, 1555,  KIOSK_BARCODE_TYPE_CODE128,
		                    3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_P_Textout( state, nPortType, '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------',
						       0, 1630, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'YOUR THERMAL PRINTER PARTNER', 800, 1645, 2, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

  //Print setting.
	KIOSK_P_Print( state, nPortType );

	KIOSK_P_Clear( state, nPortType );
	
	KIOSK_CutPaper( state, nPortType, 0, 0 );

  strMsg.Text := 'Print success!';
end;

{******************************************************************************************************************************************
  Function:       SearchPrinterDriver()
  Description:    Search the printer driver.
  Called By:      TMainForm.FormCreate(Sender: TObject);
  Input:          PrinterInfo: Information of driver.
                  PrinterNum: Number of driver.
  Return:         Returns True if successful, False if not successful.
*******************************************************************************************************************************************}
function SearchPrinterDriver(var PrinterInfo: PPrinterInfo2;  var PrinterNum:DWORD):boolean;
var
  len,BytesTemp         :DWORD;
  BytesNeed,BytesReturn :DWORD;
begin
  Result  :=  False;

  len := sizeof(PRINTER_INFO_2);
  GetMem(PrinterInfo,len + 1);
  if(PrinterInfo  = Nil)  then  Exit;
  FillMemory(PrinterInfo,len,$00);

  BytesNeed :=  0;
  EnumPrinters( PRINTER_ENUM_LOCAL,Nil,2,PrinterInfo,len,BytesNeed,BytesReturn);

  FreeMem(PrinterInfo);
  PrinterInfo :=  Nil;

  if(BytesNeed = 0)  then Exit;

  GetMem(PrinterInfo,BytesNeed + 1);
  if(PrinterInfo  = Nil)  then  Exit;
  FillMemory(PrinterInfo,BytesNeed,$00);

  //enumerate priters.
  Result  :=  EnumPrinters( PRINTER_ENUM_LOCAL,Nil,2,PrinterInfo,
                            BytesNeed,BytesTemp,BytesReturn);

  PrinterNum  :=  BytesReturn;
end;

{******************************************************************************************************************************************
  Function:       TMainForm.FormCreate(Sender: TObject);
  Description:    Search the installed driver.
  Called:         SearchPrinterDriver().
*******************************************************************************************************************************************}
procedure TMainForm.FormCreate(Sender: TObject);
begin
  if SearchPrinterDriver( PrinterInfo, PrinterNum ) = false then
  begin
    Exit;
  end;
  for Number := 0 to PrinterNum - 1 do
  begin
    //Filter the printers' names.
    if AnsiStartsText( 'Microcom',PrinterInfo.pPrinterName )then
    begin
      DriverName.AddItem( PrinterInfo.pPrinterName, DriverName );
    end;
    inc(PrinterInfo);
  end;
  DriverName.ItemIndex := 0;
end;


function TMainForm.FormHelp(Command: Word; Data: Integer;
 var CallHelp: Boolean): Boolean;
var
  m_hHelpWnd:THANDLE;
begin
  m_hHelpWnd  :=  0;
  m_hHelpWnd  :=  FindWindow(nil,'KIOSKDLL Help');
  if(m_hHelpWnd = 0)then
  begin
    //Execute the "KIOSKDLLDEMO.chm".
    ShellExecute(self.Handle,'open','KIOSKDLL.chm','', '',SW_SHOW);
  end
  else
  begin
    BringWindowToTop(m_hHelpWnd);
    OpenIcon(m_hHelpWnd);
  end;   
end;

procedure TMainForm.OpenportClick(Sender: TObject);
var
  nComName: pchar;     //serial port name
  nBaudrate,nDataBits, nParity: integer;
  nLptAddress: Word;   //Address of LPT port.
  nDriverName: pchar;  //Name of driver.
  Address: string;
begin
  //Serial port Setting
  if nPortType = 0 then
  begin
    state := 0;
    //Port's name Setting
    case ComName.ItemIndex of
      0: nComName := 'COM1';
      1: nComName := 'COM2';
      2: nComName := 'COM3';
      3: nComName := 'COM4';
      4: nComName := 'COM5';
      5: nComName := 'COM6';
      6: nComName := 'COM7';
      7: nComName := 'COM8';
      8: nComName := 'COM9';
      9: nComName := 'COM10';
    end;
    //Baudrate Setting
    case Baudrate.ItemIndex of
      0: nBaudrate := 2400;
      1: nBaudrate := 4800;
      2: nBaudrate := 9600;
      3: nBaudrate := 19200;
      4: nBaudrate := 38400;
      5: nBaudrate := 57600;
      6: nBaudrate := 115200;
     end;
     //Data bits Setting
     case DataBits.ItemIndex of
      0: nDataBits := 7;
      1: nDataBits := 8;
     end;
     state := KIOSK_OpenCom( nComName, nBaudrate, nDataBits, StopBits.ItemIndex, Parity.ItemIndex, FlowControl.ItemIndex);
     if state <> -1 then
     begin
       //Set timeouts of serial port
       if KIOSK_SetComTimeOuts( state, 0, StrToInt(WriteTimeOut.Text), 0, StrToInt(ReadTimeOut.Text ) ) <> KIOSK_SUCCESS then
       begin
          strMsg.Text := 'Open COM success,but set timeouts failed!';
       end;
       strMsg.Text := 'Open COM success!';
       //Enablewindow Setting

       Start.Enabled       := true;
       OpenPort.Enabled    := false;
       QueryStatus.Enabled := true;
       Print.Enabled       := true;
       Close.Enabled       := true;
       nExit.Enabled       := true;
       PDF417.Enabled      := true;
       Sample.Enabled      := true;
     end
     else
     begin
       strMsg.Text := 'Open COM failed!';
     end;
  end
  //LPT Setting
  else if nPortType = 1 then
  begin
    Address := LPTAddress.Text;
    //Address is 0x0378
    if Address = '0x0378' then
    begin
      nLPTAddress := $378;
    end;
    //Address is 0x0278
    if Address = '0x0278' then      
    begin
      nLPTAddress := $278;
    end;
    //Opem LPT port.
    state := KIOSK_OpenLptByDrv( nLPTAddress );
    if state = KIOSK_SUCCESS then
    begin
       strMsg.Text := 'Open LPT success!';

       //Enablewindow Setting
       Start.Enabled       := false;
       Stop.Enabled        := false;
       OpenPort.Enabled    := false;
       QueryStatus.Enabled := false;
       Print.Enabled       := true;
       Close.Enabled       := true;
       nExit.Enabled       := true;
       PDF417.Enabled      := true;
       Sample.Enabled      := true;
     end
     else
     begin
       strMsg.Text := 'Open LPT failed!';
     end;
  end
  //USB Setting
  else if nPortType = 2 then
  begin
    state := 0;
    //Open USB port.
    state := KIOSK_OpenUsb();
    if state <> -1 then
    begin
      //Set the tiomeouts of USB port.
      if KIOSK_SetUsbTimeOuts( state, StrToInt( WriteTimeOut.Text ), StrToInt( ReadTimeOut.Text ) ) <> KIOSK_SUCCESS then
      begin
         strMsg.Text := 'Open USB success,but set timeouts failed!';
      end;
      strMsg.Text := 'Open USB success!';

      //Enablewindow Setting
      Start.Enabled       := true;
      Stop.Enabled        := false;
      OpenPort.Enabled    := false;
      QueryStatus.Enabled := true;
      Print.Enabled       := true;
      Close.Enabled       := true;
      nExit.Enabled       := true;
      PDF417.Enabled      := true;
      Sample.Enabled      := true;
    end
    else
    begin
      strMsg.Text := 'Open USB failed!';
    end;
  end
  //Driver Setting
  else
  begin
    //Driver's name Setting
    state := 0;
    nDriverName := pchar ( DriverName.Text );
    //Open driver port.
    state := KIOSK_OpenDrv( nDriverName );

    if state <> -1 then
    begin
      strMsg.Text := 'Open Driver success!';

      //Enablewindow Setting
      Start.Enabled       := false;
      Stop.Enabled        := false;
      OpenPort.Enabled    := false;
      QueryStatus.Enabled := false;
      Print.Enabled       := true;
      Close.Enabled       := true;
      nExit.Enabled       := true;
      PDF417.Enabled      := true;
      Sample.Enabled      := true;
    end
    else
    begin
      strMsg.Text := 'Open Driver failed!';
    end;
  end;
end;

procedure TMainForm.PrintSample();
var
  nPagewidth, DPI: integer;
begin
  nPagewidth:= Pagewidth.ItemIndex;
  DPI := Resolution.ItemIndex;
  if nPortType = 3 then
  begin
    //When it is driver.
    KIOSK_StartDoc( state );
  end;

  //Saving data to "Test.dat".
  if nSaveToTxt then
  begin
    KIOSK_BeginSaveToFile( state, 'Test.dat', false );
  end;

  //Standard mode
  if Mode = 0 then                        
  begin
    if nPagewidth = 0 then//The page width is 56mm.
    begin
       if DPI = 0 then//The resolution is 203dpi.
       begin
         PrintInStandardMode56_203DPI();
       end
       else
       begin
         PrintInStandardMode56_300DPI();//The resolution is 300dpi.
       end;
    end
    else if nPagewidth = 1 then//The page width is 80mm
    begin
      if DPI = 0 then//The resolution is 203dpi.
      begin
        PrintInStandardMode80_203DPI();
      end
      else
      begin
        PrintInStandardMode80_300DPI();//The resolution is 300dpi.
      end;
    end
    else//The page width is 210mm.
    begin
      if DPI = 0 then//The resolution is 203dpi.
      begin
        PrintInStandardMode210_203DPI();
      end
      else
      begin
        PrintInStandardMode210_300DPI();//The resolution is 300dpi.
      end;
    end;
  end
  else//Page mode
  begin
    if nPagewidth = 0 then//The page width is 56mm.
    begin
      if DPI = 0 then//The resolution is 203dpi.
      begin
        PrintInPageMode56_203DPI();
      end
      else
      begin
        PrintInPageMode56_300DPI();//The resolution is 300dpi.
      end;
    end
    else if nPagewidth = 1 then//The page width is 80mm.
    begin
      if DPI = 0 then//The resolution is 203dpi.
      begin
        PrintInPageMode80_203DPI();
      end
      else
      begin
        PrintInPageMode80_300DPI();//The resolution is 300dpi.
      end;
    end
    else//The page width is 210mm
    begin
      if DPI = 0 then//The resolution is 203dpi.
      begin
        PrintInPageMode210_203DPI();
      end
      else
      begin
        PrintInPageMode210_300DPI();//The resolution is 300dpi.
      end;
    end;
  end;

  //Presenter or Bundler Setting  
  if nPaperOut = 0 then
  begin
    if nPresenter = 0 then//Presenter Setting
    begin
      //Presenter Retraction_on
      if KIOSK_SetPresenter( state, nPortType, KIOSK_PRESENTER_Retraction_on, 3 ) <> KIOSK_SUCCESS then
      begin
         ShowMessage('Set Presenter failed!');
      end;
    end
    else if nPresenter = 1 then
    begin
      //Presenter Paper_Forward
      if KIOSK_SetPresenter( state, nPortType, KIOSK_PRESENTER_Paper_Forward, 3 ) <> KIOSK_SUCCESS then
      begin
        ShowMessage('Set Presenter failed!');
      end;
    end
    else
    begin
      //Presenter Paper_Hold
      if KIOSK_SetPresenter( state, nPortType, KIOSK_PRESENTER_Paper_Hold, 3 ) <> KIOSK_SUCCESS then
      begin
        ShowMessage('Set Presenter failed!');
      end;
    end;
  end
  else //Bundler Setting
  begin
    if nBundler = 0 then//Bundler Retract
    begin
      if KIOSK_SetBundler( state, nPortType, KIOSK_BUNDLER_Retract, 3 )<> KIOSK_SUCCESS then
      begin
        ShowMessage('Set Bundler failed!');
      end;
    end
    else
    begin//Bundler Present
      if KIOSK_SetBundler( state, nPortType, KIOSK_BUNDLER_Present, 3 )<> KIOSK_SUCCESS then
      begin
        ShowMessage('Set Bundler failed!');
      end;
    end;
  end;

  //Stop saving data to file.
  if nSaveToTxt then
  begin
    KIOSK_EndSaveToFile(state);
  end;

  //When it is driver.
  if nPortType = 3 then
  begin
    KIOSK_EndDoc( state );
  end;
end;

procedure TMainForm.PrintClick(Sender: TObject);
begin
  PrintSample();
end;

procedure TMainForm.StartClick(Sender: TObject);
begin
  //Enablewindow Setting
  Start.Enabled := false;
  Stop.Enabled  := true;
  QueryStatus.Enabled := false;

  //Thread Creating
  ThreadRunning := true;
  StatusMonitor.Text := '';
  TStatusThread.Create( false );
end;

procedure TMainForm.StopClick(Sender: TObject);
begin
   //Enablewindow Setting
  Start.Enabled := true;
  Stop.Enabled  := false;
  QueryStatus.Enabled := true;

  //Thread Stopping
  ThreadRunning := false;
  //Stop the Automatic Status Back.
  KIOSK_QueryASB( state, nPortType, 0 );
end;
 
procedure TMainForm.WriteTimeOutKeyPress(Sender: TObject; var Key: Char);
begin //Filter the chars.
  if not (key in ['0'..'9',#8]) then
  begin
    Key:=#0;
  end;
end;

procedure TMainForm.QueryStatusClick(Sender: TObject);
var
  bits: array [0..7] of Integer;
  nStatus: Char;
  i: Integer;
  Return: Integer;
  strInfo: string;
begin
  //Stop the Automatic Status Back first.
  KIOSK_QueryASB( state, nPortType, 0 );
  strInfo := '';

  //Query real-time status of printer.
  if KIOSK_RTQueryStatus( state, nPortType, @nStatus ) <> KIOSK_SUCCESS then
  begin
    CloseClick( Close );
    strMsg.Text := 'Query status failed!';
    Exit;
  end
  else
  begin
    if( integer(nStatus) = 0 )then
    begin
      strMsg.Text := 'All is ok!';
    end
    else
    begin
      for i := 0 to 7 do
      begin
        bits[i]:= ( Integer( nStatus) shr i ) And 1;
      end;
      //Status Showing
      if Bits[0] = 1 then//Head Up
		 	strInfo := strInfo + 'Head Up!';
      
		  if Bits[1] = 1 then//Paper End
      strInfo := strInfo + 'Paper End!';
      
      if Bits[2] = 1 then//Cutter Error
      strInfo := strInfo + 'Cutter Error!';

      if Bits[3] = 1 then//TPH Too Hot
      strInfo := strInfo + 'TPH Too Hot!';
      
      if Bits[4] = 1 then//Paper Near End
      strInfo := strInfo + 'Paper Near End!';
      
      if Bits[5] = 1 then//Paper Jam
      strInfo := strInfo + 'Paper Jam!';

      if Bits[6] = 1 then //Presenter/Bundler Paper Jam
      strInfo := strInfo + 'Presenter/Bundler Paper Jam!';

      if Bits[7] = 1 then//Auto Feed Error
      strInfo := strInfo + 'Auto Feed Error!';

      strMsg.Text := strInfo;
    end;
  end;
end;

procedure TMainForm.ReadTimeOutKeyPress(Sender: TObject; var Key: Char);
begin //Filter the chars.
  if not (key in ['0'..'9',#8]) then
  begin
    Key:=#0;
  end;
end;

procedure TMainForm.PDF417Click(Sender: TObject);
begin
  KIOSK_BarcodeSetPDF417(state, nPortType, '1234567890abcdefg', 17, 3, 10, 10, 5, 50, 5, 5);
end;

procedure TMainForm.SampleClick(Sender: TObject);
var
  nRet: Boolean;
  i: Integer;
begin

  //打印三次样张
  for i := 0 to 2 do
  begin
    PrintSample();

    //等待打印机完成打印
    while True do
    begin
      sleep(100);

      nRet := IsPrinting();
      if nRet = false then
      begin
        continue;
      end;

      break;
    end;

    //打印完成后，查询纸是否被取走，取走后发送下一张数据
    while True do
    begin
      sleep(100);

      nRet := PaperTackout();
      if nRet = true then
      begin
        break;
      end;
    end;

  end;

end;

function TMainForm.IsPrinting():Boolean;
var
  cStatus: Byte;
  i : Integer;
  bits: array [0..7] of Integer;
begin
  if KIOSK_RTQueryStatusForT681( state, nPortType, @cStatus ) <> KIOSK_SUCCESS then
  begin
    Result := False;
    exit;
  end;

  for i := 0 to 7 do
  begin
    bits[i]:= ( Integer( cStatus) shr i ) And 1;
  end;

  if Bits[7] = 1 then
  begin
    Result := True;
    exit;
  end;
	
  Result := False;

end;

function TMainForm.PaperTackout():Boolean;
var
  cStatus: Char;
  i : Integer;
  bits: array [0..7] of Integer;
begin
  if KIOSK_RTQueryStatusForT681( state, nPortType, @cStatus ) <> KIOSK_SUCCESS then
  begin
    Result := True;
    exit;
  end;

  for i := 0 to 7 do
  begin
    bits[i]:= ( Integer( cStatus) shr i ) And 1;
  end;
	
	if Bits[6] = 1 then
  begin
    Result := False;
    exit;
  end;
	
  Result := True;

end;

procedure TMainForm.CloseClick(Sender: TObject);
begin
  //Enablewindow Setting
  ThreadRunning       := false;
  Start.Enabled       := false;
  Stop.Enabled        := false;
  OpenPort.Enabled    := true;
  QueryStatus.Enabled := false;
  Print.Enabled       := false;
  Close.Enabled       := false;
  nExit.Enabled       := true;
  PDF417.Enabled      := false;
  Sample.Enabled      := false;

  //Serial port Closing
  if nPortType = 0 then
  begin
    if state > 0 then
    begin
      if KIOSK_CloseCom( state )<> KIOSK_SUCCESS then
      begin
        strMsg.Text := 'Close COM failed!';
        state := 0;
      end
      else
      begin
        strMsg.Text := 'Close COM success!';
      end;
    end
    else
    begin
      strMsg.Text := 'Close COM success!';
    end;
  end
  //LPT port Closing
  else if nPortType = 1 then
  begin
    if state > 0 then
    begin
      if KIOSK_CloseDrvLPT( nPortType ) <> KIOSK_SUCCESS then
      begin
        strMsg.Text := 'Close LPT failed!';
        state := 0
      end
      else
      begin
        strMsg.Text := 'Close LPT success!';
      end;
    end
    else
    begin
      strMsg.Text := 'Close LPT success!';
    end;
  end
  //USB port Closing
  else if nPortType = 2 then
  begin
    if state > 0 then
    begin
      if KIOSK_CloseUSB( state ) <> KIOSK_SUCCESS then
      begin
        strMsg.Text := 'Close USB failed!';
        state := 0
      end
      else
      begin
        strMsg.Text := 'Close USB success!';
      end;
    end
    else
    begin
      strMsg.Text := 'Close USB success!';
    end;
  end
  //Driver port Closing
  else
  begin
    if state > 0 then
    begin
      if KIOSK_CloseDrv( state ) <> KIOSK_SUCCESS then
      begin
        strMsg.Text := 'Close Driver failed!';
        state := 0
      end
      else
      begin
        strMsg.Text := 'Close Driver success!';
      end;
    end
    else
    begin
      strMsg.Text := 'Close Driver success!';
    end;
  end;
end;

procedure TMainForm.nExitClick(Sender: TObject);
begin
  screen.forms[0].close;//Exit
end;

procedure TMainForm.SelectPortClick(Sender: TObject);
begin
   //Close port first when state is bigger than 0.
   if state > 0 then
   begin
    case nPortType of
     0: KIOSK_CloseCom( state );        //Close the serial port.
     1: KIOSK_CloseDrvLPT( nPortType ); //Close the LPT port.
     2: KIOSK_CloseUSB( state );        //Close the USB port.
     3: KIOSK_CloseDrv( state );        //Close the Driver port.
    end;
     state := 0;
   end;
   nPortType := SelectPort.ItemIndex;
   //Serial port Selecting
   if nPortType = 0 then
   begin
    //EnableWidow Setting
    ComName.Enabled     := true;
    Baudrate.Enabled    := true;
    DataBits.Enabled    := true;
    Parity.Enabled      := true;
    StopBits.Enabled    := true;
    FlowControl.Enabled := true;

    LPTAddress.Enabled  := false;
    ReadTimeOut.Enabled := true;
    ReadTimeOut.Text    := '3000';
    WriteTimeOut.Enabled:= true;
    WriteTimeOut.Text   := '90000';
    DriverName.Enabled  := false;

    SelectMode.Enabled  := true;
    Select.Enabled      := true;
    Presenter.Enabled   := true;
    Bundler.Enabled     := false;
    Pagewidth.Enabled   := true;
    Resolution.Enabled  := true;

    Start.Enabled       := false;
    Stop.Enabled        := false;

    Savetofile.Enabled  := true;

    OpenPort.Enabled    := true;
    QueryStatus.Enabled := false;
    strMsg.Enabled      := true;
    Print.Enabled       := false;
    Close.Enabled       := false;
    nExit.Enabled        := true;
   end
   else if nPortType = 1 then //LPT port Selecting
   begin
    //EnableWidow Setting
    ComName.Enabled     := false;
    Baudrate.Enabled    := false;
    DataBits.Enabled    := false;
    Parity.Enabled      := false;
    StopBits.Enabled    := false;
    FlowControl.Enabled := false;

    LPTAddress.Enabled  := true;
    ReadTimeOut.Enabled := false;
    WriteTimeOut.Enabled:= false;
    DriverName.Enabled  := false;

    SelectMode.Enabled  := true;
    Select.Enabled      := true;
    Presenter.Enabled   := true;
    Bundler.Enabled     := false;
    Pagewidth.Enabled   := true;
    Resolution.Enabled  := true;

    Start.Enabled       := false;
    Stop.Enabled        := false;

    Savetofile.Enabled  := true;

    OpenPort.Enabled    := true;
    QueryStatus.Enabled := false;
    strMsg.Enabled      := true;
    Print.Enabled       := false;
    Close.Enabled       := false;
    nExit.Enabled        := true;
   end
   else if nPortType = 2 then //USB port Selecting
   begin
    //EnableWidow Setting
    ComName.Enabled     := false;
    Baudrate.Enabled    := false;
    DataBits.Enabled    := false;
    Parity.Enabled      := false;
    StopBits.Enabled    := false;
    FlowControl.Enabled := false;

    LPTAddress.Enabled  := false;
    ReadTimeOut.Enabled := true;
    ReadTimeOut.Text    := '2000';
    WriteTimeOut.Enabled:= true;
    WriteTimeOut.Text   := '2000';
    DriverName.Enabled  := false;

    SelectMode.Enabled  := true;
    Select.Enabled      := true;
    Presenter.Enabled   := true;
    Bundler.Enabled     := false;
    Pagewidth.Enabled   := true;
    Resolution.Enabled  := true;

    Start.Enabled       := false;
    Stop.Enabled        := false;

    Savetofile.Enabled  := true;

    OpenPort.Enabled    := true;
    QueryStatus.Enabled := false;
    strMsg.Enabled      := true;
    Print.Enabled       := false;
    Close.Enabled       := false;
    nExit.Enabled       := true;
   end
   else //Driver port Selecting
   begin
    //EnableWidow Setting
    ComName.Enabled     := false;
    Baudrate.Enabled    := false;
    DataBits.Enabled    := false;
    Parity.Enabled      := false;
    StopBits.Enabled    := false;
    FlowControl.Enabled := false;

    LPTAddress.Enabled  := false;
    ReadTimeOut.Enabled := false;
    WriteTimeOut.Enabled:= false;
    DriverName.Enabled  := true;

    SelectMode.Enabled  := true;
    Select.Enabled      := true;
    Presenter.Enabled   := true;
    Bundler.Enabled     := false;
    Pagewidth.Enabled   := true;
    Resolution.Enabled  := true;

    Start.Enabled       := false;
    Stop.Enabled        := false;

    Savetofile.Enabled  := true;

    OpenPort.Enabled    := true;
    QueryStatus.Enabled := false;
    strMsg.Enabled      := true;
    Print.Enabled       := false;
    Close.Enabled       := false;
    nExit.Enabled       := true;
   end;
end;

procedure TMainForm.SelectModeClick(Sender: TObject);
begin
  case SelectMode.ItemIndex of
    0: Mode := 0;//StandardMode Selecting
    1: Mode := 1;//PageMode Selecting
  end;
end;

procedure TMainForm.SavetofileClick(Sender: TObject);
begin
  //'Sending data to file but not to port.' Selecting
  if nSaveToTxt then
  begin
    nSaveToTxt := false;
  end
  else
  begin
    nSaveToTxt := true;
  end;
end;

procedure TMainForm.SelectClick(Sender: TObject);
begin
  nPaperOut := Select.ItemIndex;
  if Select.ItemIndex = 0 then//Presenter Selecting
  begin
    Presenter.Enabled := true;
    Bundler.Enabled   := false;
  end
  else //Bundler Selecting
  begin
    Presenter.Enabled := false;
    Bundler.Enabled := true;
  end;
end;

procedure TMainForm.PresenterClick(Sender: TObject);
begin
   case Presenter.ItemIndex of
   0: nPresenter := 0;//Presenter Retraction_on
   1: nPresenter := 1;//Presenter Paper_Forward
   2: nPresenter := 2;//Presenter Paper_Hold
  end;
end;

procedure TMainForm.BundlerClick(Sender: TObject);
begin
   case Bundler.ItemIndex of
   0: nBundler := 0; //Bundler Retract
   1: nBundler := 1; //Bundler Present
  end;
end;  
end.



