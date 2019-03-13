unit KIOSKDLLDEMO_DELPHI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, LoadDLL,ExtCtrls,ComCtrls, Mask;

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
    ReadTimeOut: TEdit;
    WriteTimeOut: TEdit;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    StandardMode: TRadioButton;
    PresenterMode: TRadioButton;
    RadioGroup4: TRadioGroup;
    GroupBox2: TGroupBox;
    StaticText13: TStaticText;
    StaticText14: TStaticText;
    GroupBox7: TGroupBox;
    Start: TButton;
    Stop: TButton;
    ComName: TComboBox;
    DataBits: TComboBox;
    Parity: TComboBox;
    StopBits: TComboBox;
    FlowControl: TComboBox;
    LPTAddress: TComboBox;
    Baudrate: TComboBox;
    SelectMode: TRadioGroup;
    Select: TRadioGroup;
    Presenter: TRadioGroup;
    Bundler: TRadioGroup;
    PageWidth: TComboBox;
    Resolution: TComboBox;
    StatusMonitor: TMemo;
    procedure OpenportClick(Sender: TObject);
    procedure SelectPortClick(Sender: TObject);
    procedure SelectClick(Sender: TObject);
    procedure QueryStatusClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure nExitClick(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure StopClick(Sender: TObject);
   private
    { Private declarations }
    //function Format(const Format: string; const Args: array of const): string; overload;

    procedure Thread( status: boolean );

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

  public
    { Public declarations }
  end;   
var
  MainForm: TMainForm;
  ThreadRunning: bool;
  state: integer;
  nPortType: integer;
  statue: bool;


implementation

uses StatusThread;

{$R *.dfm}

procedure TMainForm.Thread(status: Boolean);
begin

end;
procedure TMainForm.PrintInStandardMode56_203DPI();
var
  pBitImages: array[0..2] of string;
begin
  pBitImages[0] := 'Kitty.bmp';
	pBitImages[1] := 'Look.bmp';
  if KIOSK_PreDownloadBmpToFlash( state, nPortType, pBitImages, 2 ) <> KIOSK_SUCCESS then
  begin
    strMsg.Text := 'Print failed!';

    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;

    state := 0;

    OpenPort.Enabled := true;
    QueryStatus.Enabled := false;
    Print.Enabled := false;
    Close.Enabled := false;
    nExit.Enabled := true;


    exit;
  end;

  KIOSK_Reset( state, nPortType );

	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_STANDARD );

  KIOSK_SetMotionUnit( state, nPortType, 180, 180 );

  KIOSK_S_SetLeftMarginAndAreaWidth( state, nPortType, 0, 640 );
	
	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetLineSpacing( state, nPortType, 95 );

	KIOSK_S_Textout( state, nPortType, 'SNBC KIOSK Printer', 20, 2, 2,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_SetLineSpacing( state, nPortType, 15 );
		
	KIOSK_FeedLines( state, nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------',
                   20, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------',
                   20, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state, nPortType, 2 );


	// Defferent right-spacing	
  KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 20, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 230, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );


	KIOSK_SetRightSpacing( state, nPortType, 1 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 20, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );
	
	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 230, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 20, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 230, 1, 1,
                   KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLines( state, nPortType, 2 );


	// Defferent font
	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout(  state, nPortType, 'FONTSTYLE-NORMAL', 20, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-BOLD', 20, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 20, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE );


	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 20, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE,	KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 20, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-90', 20, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	KIOSK_FeedLines( state, nPortType, 2 );


	// Print bar code
	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------', 20, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'Barcode - Code 128', 20, 1, 1,
		               KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 20, KIOSK_BARCODE_TYPE_CODE128,
                        2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_FeedLine( state, nPortType );


  KIOSK_S_Textout( state, nPortType, '-----------------------------------', 20, 1, 1,
						       KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '---------------Logo1---------------', 20, 1, 1,
						       KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

  KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 1, 50, KIOSK_BITMAP_PRINT_QUADRUPLE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '---------------Logo 2---------------', 20, 1, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 2, 50, KIOSK_BITMAP_PRINT_QUADRUPLE );

	KIOSK_FeedLines( state, nPortType, 12 );


	// Cut paper
	KIOSK_CutPaper( state, nPortType, 0, 0 );

  strMsg.Text := 'Print success!';
end;


procedure TMainForm.PrintInPageMode56_203DPI;
begin
  // Downloading images to RAM
	if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'kitty.bmp', 0 ) <> KIOSK_SUCCESS then// ID number is 0
  begin
    strMsg.Text := 'Print failed!';

    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;

    state := 0;
    OpenPort.Enabled := true;
    QueryStatus.Enabled := false;
    Print.Enabled := false;
    Close.Enabled := false;
    nExit.Enabled := true;

    exit;
  end;

	KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Look.bmp', 1 ); // ID number is 1

	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_PAGE );

	KIOSK_SetMotionUnit( state, nPortType, 180, 180 );

	KIOSK_P_SetAreaAndDirection( state, nPortType, 10, 10, 620, 1200, KIOSK_AREA_LEFT_TO_RIGHT );

	KIOSK_P_Clear( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

  KIOSK_SetLineSpacing( state, nPortType, 95 );

	KIOSK_P_Textout( state, nPortType, 'SNBC KIOSK Printer', 20, 80, 2, 2,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '-----------------------------------', 20, 120,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


	KIOSK_P_Textout( state, nPortType, '-----------------------------------', 20, 140,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );


	//Defferent right-spacing 	
	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 20, 180, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 200, 180, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 1 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 20, 210, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSKPrinter', 200, 210, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 2 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 220, 240, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 200, 240, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetRightSpacing( state, nPortType, 0 );


	// Different font
	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 20, 300, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-BOLD', 20, 340, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );


	KIOSK_P_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 20, 380, 1, 1, 
		                KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE );


	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 20, 420, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE,	KIOSK_FONT_STYLE_THIN_UNDERLINE );


	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 20, 460, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );



	// Print bar code
	KIOSK_P_Textout( state, nPortType, '-----------------------------------', 20, 500,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'Barcode - Code 128', 20, 530, 1, 1,
		               KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 20,600, KIOSK_BARCODE_TYPE_CODE128,
		                   2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 20 );
	


	KIOSK_P_Textout( state, nPortType, '-----------------------------------', 20, 650,1, 1, 
		                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout(state, nPortType, '---------------Logo 1---------------', 20, 670, 1, 1,
						      KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 0, 95,  740, KIOSK_BITMAP_PRINT_QUADRUPLE);

	KIOSK_P_Textout( state, nPortType, '---------------Logo 2---------------', 20, 760,1, 1,
						KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 1, 20, 850, KIOSK_BITMAP_PRINT_QUADRUPLE);


	KIOSK_P_Print( state, nPortType );

	KIOSK_P_Clear( state, nPortType );

	KIOSK_CutPaper( state, nPortType, KIOSK_PAPER_SERIAL, 50 );

  strMsg.Text := 'Print success!';

end;


procedure TMainForm.PrintInStandardMode56_300DPI;
var
  pBitImages: array[0..2] of string;
begin
  pBitImages[0] := 'Kitty.bmp';
	pBitImages[1] := 'Look.bmp';
  if KIOSK_PreDownloadBmpToFlash( state, nPortType, pBitImages, 2 ) <> KIOSK_SUCCESS then
  begin
    strMsg.Text := 'Print failed!';

    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;

    state := 0;
    OpenPort.Enabled := true;
    QueryStatus.Enabled := false;
    Print.Enabled := false;
    Close.Enabled := false;
    nExit.Enabled := true;

    exit;
  end;
  KIOSK_Reset( state, nPortType );

	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_STANDARD );

  KIOSK_SetMotionUnit( state, nPortType, 180, 180 );

  KIOSK_S_SetLeftMarginAndAreaWidth( state, nPortType, 0, 640 );
	
	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetLineSpacing( state, nPortType, 95 );

	KIOSK_S_Textout( state, nPortType, 'SNBC KIOSK Printer', 20, 2, 2,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_SetLineSpacing( state, nPortType, 15 );
		
	KIOSK_FeedLines( state, nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------',
                   20, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------',
                   20, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state, nPortType, 2 );


	// Defferent right-spacing	
  KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 20, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 230, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );


	KIOSK_SetRightSpacing( state, nPortType, 1 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 20, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );
	
	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 230, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'Right Spacing', 20, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_S_Textout( state, nPortType, 'KIOSK Printer', 230, 1, 1,
                   KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLines( state, nPortType, 2 );


	// Defferent font
	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout(  state, nPortType, 'FONTSTYLE-NORMAL', 20, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-BOLD', 20, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 20, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE );


	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 20, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE,	KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 20, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-90', 20, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	KIOSK_FeedLines( state, nPortType, 2 );


	// Print bar code
	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------', 20, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'Barcode - Code 128', 20, 1, 1,
		               KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 20, KIOSK_BARCODE_TYPE_CODE128,
                        2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_FeedLine( state, nPortType );


  KIOSK_S_Textout( state, nPortType, '-----------------------------------', 20, 1, 1,
						       KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '---------------Logo1---------------', 20, 1, 1,
						       KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

  KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 1, 50, KIOSK_BITMAP_PRINT_QUADRUPLE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '---------------Logo 2---------------', 20, 1, 1,
                   KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 2, 50, KIOSK_BITMAP_PRINT_QUADRUPLE );

	KIOSK_FeedLines( state, nPortType, 12 );


	// Cut paper
	KIOSK_CutPaper( state, nPortType, 0, 0 );

  strMsg.Text := 'Print success!';

end;


procedure TMainForm.PrintInPageMode56_300DPI;
begin
  // Downloading images to RAM
	if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'kitty.bmp', 0 ) <> KIOSK_SUCCESS then// ID number is 0
  begin
    strMsg.Text := 'Print failed!';

    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;

    state := 0;
    OpenPort.Enabled := true;
    QueryStatus.Enabled := false;
    Print.Enabled := false;
    Close.Enabled := false;
    nExit.Enabled := true;

    exit;
  end;

	KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Look.bmp', 1 ); // ID number is 1

	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_PAGE );

	KIOSK_SetMotionUnit( state, nPortType, 180, 180 );

	KIOSK_P_SetAreaAndDirection( state, nPortType, 10, 10, 620, 1200, KIOSK_AREA_LEFT_TO_RIGHT );

	KIOSK_P_Clear( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

  KIOSK_SetLineSpacing( state, nPortType, 95 );

	KIOSK_P_Textout( state, nPortType, 'SNBC KIOSK Printer', 20, 80, 2, 2,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '-----------------------------------', 20, 120,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


	KIOSK_P_Textout( state, nPortType, '-----------------------------------', 20, 140,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );


	//Defferent right-spacing 	
	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 20, 180, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 200, 180, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 1 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 20, 210, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSKPrinter', 200, 210, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 2 );

	KIOSK_P_Textout( state, nPortType, 'Right Spacing', 220, 240, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 200, 240, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetRightSpacing( state, nPortType, 0 );


	// Different font
	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 20, 300, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-BOLD', 20, 340, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );


	KIOSK_P_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 20, 380, 1, 1, 
		                KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE );


	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 20, 420, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE,	KIOSK_FONT_STYLE_THIN_UNDERLINE );


	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 20, 460, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );



	// Print bar code
	KIOSK_P_Textout( state, nPortType, '-----------------------------------', 20, 500,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'Barcode - Code 128', 20, 530, 1, 1,
		               KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 20,600, KIOSK_BARCODE_TYPE_CODE128,
		                   2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 20 );
	


	KIOSK_P_Textout( state, nPortType, '-----------------------------------', 20, 650,1, 1, 
		                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout(state, nPortType, '---------------Logo 1---------------', 20, 670, 1, 1,
						      KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 0, 95,  740, KIOSK_BITMAP_PRINT_QUADRUPLE);

	KIOSK_P_Textout( state, nPortType, '---------------Logo 2---------------', 20, 760,1, 1,
						KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 1, 20, 850, KIOSK_BITMAP_PRINT_QUADRUPLE);


	KIOSK_P_Print( state, nPortType );

	KIOSK_P_Clear( state, nPortType );

	KIOSK_CutPaper( state, nPortType, KIOSK_PAPER_SERIAL, 50 );

  strMsg.Text := 'Print success!';

end;


procedure TMainForm.PrintInStandardMode80_203DPI;
var
  pBitImages: array[0..2] of string;
begin
  pBitImages[0] := 'Kitty.bmp';
	pBitImages[1] := 'Look.bmp';
  if KIOSK_PreDownloadBmpToFlash( state, nPortType, pBitImages, 2 ) <> KIOSK_SUCCESS then
  begin
    strMsg.Text := 'Print failed!';

    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;

    state := 0;
    OpenPort.Enabled := true;
    QueryStatus.Enabled := false;
    Print.Enabled := false;
    Close.Enabled := false;
    nExit.Enabled := true;

    exit;
  end;
  KIOSK_Reset( state,nPortType );

	KIOSK_SetMode( state,nPortType, KIOSK_PRINT_MODE_STANDARD );
	
  KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

  KIOSK_S_SetLeftMarginAndAreaWidth( state, nPortType, 0, 640 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetLineSpacing( state, nPortType, 95 );

	KIOSK_S_Textout( state, nPortType, 'SNBC KIOSK Printer', 95, 2, 2,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_SetLineSpacing( state, nPortType, 24 );

	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state, nPortType, 2 );


	//Defferent right-spacing
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


	//Defferent font
	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 95, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-BOLD', 95, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 95, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE );


	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 95, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE,	KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 95, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-90', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	KIOSK_FeedLines( state, nPortType, 2 );
	

	//Print bar code
	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
		                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'Barcode - Code 128', 95, 1, 1,
		                KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 95, KIOSK_BARCODE_TYPE_CODE128,
		                   2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_FeedLine( state, nPortType );

  
	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
						KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '------------------Logo 1------------------', 95, 1, 1,
						KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 1, 100, KIOSK_BITMAP_PRINT_QUADRUPLE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '------------------Logo 2------------------', 95, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 2, 95, KIOSK_BITMAP_PRINT_QUADRUPLE );

	KIOSK_FeedLines( state, nPortType, 12 );


	//cut paper
	KIOSK_CutPaper( state, nPortType, 0, 0 );

  strMsg.Text := 'Print success!';

end;


procedure TMainForm.PrintInPageMode80_203DPI;
begin
  // Downloading images to RAM
	if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'kitty.bmp', 0 ) <> KIOSK_SUCCESS then// ID number is 0
  begin
    strMsg.Text := 'Print failed!';

    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;

    state := 0;
    OpenPort.Enabled := true;
    QueryStatus.Enabled := false;
    Print.Enabled := false;
    Close.Enabled := false;
    nExit.Enabled := true;

    exit;
  end;

	KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Look.bmp', 1 ); // ID number is 1

	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_PAGE );

  KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

	KIOSK_P_SetAreaAndDirection( state, nPortType, 10, 10, 620, 1200, KIOSK_AREA_LEFT_TO_RIGHT );

	KIOSK_P_Clear( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, 'SNBC KIOSK Printer', 95, 80, 2, 2,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '------------------------------------------', 95, 120,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


	KIOSK_P_Textout( state, nPortType, '------------------------------------------', 95, 140,1, 1,
		                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );



	//Defferent right-spacing
	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, 'BK-L216', 95, 180, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 200, 180, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 2 );

	KIOSK_P_Textout( state, nPortType, 'BK-L216', 95, 210, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSKPrinter', 200, 210, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 4 );

	KIOSK_P_Textout( state, nPortType, 'BK-L216', 95, 240, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 200, 240, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetRightSpacing( state, nPortType, 0 );


	//Defferent font
	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 95, 300, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_NORMAL ); //正常字体


	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-BOLD', 95, 340, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );



	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 95, 380, 1, 1,
		                KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE );



	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 95, 420, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE,	KIOSK_FONT_STYLE_THIN_UNDERLINE );


	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 95, 460, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );



	//Print code-bar
	KIOSK_P_Textout( state, nPortType, '-------------------------------------', 95, 500,1, 1,
		                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'Barcode - Code 128', 200, 530, 1, 1,
		                KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 95,600, KIOSK_BARCODE_TYPE_CODE128,
		                   2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 20 );

	

	KIOSK_P_Textout( state, nPortType, '-------------------------------------', 95, 650,1, 1,
		                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, '---------------Logo 1----------------', 95, 670, 1, 1,
						KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 0, 95,  740, KIOSK_BITMAP_PRINT_QUADRUPLE);


	KIOSK_P_Textout( state, nPortType, '---------------Logo 2----------------', 95, 760,1, 1,
						KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 1, 95, 850, KIOSK_BITMAP_PRINT_QUADRUPLE);

	KIOSK_P_Print( state, nPortType );

	KIOSK_P_Clear( state, nPortType );

	KIOSK_CutPaper( state, nPortType, KIOSK_PAPER_SERIAL, 50 );

  strMsg.Text := 'Print success!';
end;


procedure TMainForm.PrintInStandardMode80_300DPI;
var
  pBitImages: array[0..2] of string;
begin
  pBitImages[0] := 'Kitty.bmp';
	pBitImages[1] := 'Look.bmp';
  if KIOSK_PreDownloadBmpToFlash( state, nPortType, pBitImages, 2 ) <> KIOSK_SUCCESS then
  begin
    strMsg.Text := 'Print failed!';

    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;

    state := 0;
    OpenPort.Enabled := true;
    QueryStatus.Enabled := false;
    Print.Enabled := false;
    Close.Enabled := false;
    nExit.Enabled := true;
    exit;
  end;
  KIOSK_Reset( state,nPortType );

	KIOSK_SetMode( state,nPortType, KIOSK_PRINT_MODE_STANDARD );
	
  KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

  KIOSK_S_SetLeftMarginAndAreaWidth( state, nPortType, 0, 640 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetLineSpacing( state, nPortType, 95 );

	KIOSK_S_Textout( state, nPortType, 'SNBC KIOSK Printer', 95, 2, 2,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_SetLineSpacing( state, nPortType, 24 );

	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state, nPortType, 2 );


	//Defferent right-spacing
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


	//Defferent font
	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 95, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-BOLD', 95, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType,'FONTSTYLE-UNDERLINE', 95, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE );


	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 95, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE,	KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 95, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_FeedLine( state, nPortType );


	KIOSK_S_Textout( state, nPortType, 'FONTSTYLE-90', 95, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_CLOCKWISE_90 );

	KIOSK_FeedLines( state, nPortType, 2 );
	

	//Print bar code
	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
		                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, 'Barcode - Code 128', 95, 1, 1,
		                KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 95, KIOSK_BARCODE_TYPE_CODE128,
		                   2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );

	KIOSK_FeedLine( state, nPortType );

  
	KIOSK_S_Textout( state, nPortType, '------------------------------------------', 95, 1, 1,
						KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '------------------Logo 1------------------', 95, 1, 1,
						KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 1, 100, KIOSK_BITMAP_PRINT_QUADRUPLE );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '------------------Logo 2------------------', 95, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 2, 95, KIOSK_BITMAP_PRINT_QUADRUPLE );

	KIOSK_FeedLines( state, nPortType, 12 );


	//cut paper
	KIOSK_CutPaper( state, nPortType, 0, 0 );

  strMsg.Text := 'Print success!';
end;


procedure TMainForm.PrintInPageMode80_300DPI;
begin
  // Downloading images to RAM
	if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'kitty.bmp', 0 ) <> KIOSK_SUCCESS then// ID number is 0
  begin
    strMsg.Text := 'Print failed!';

    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;

    state := 0;

    OpenPort.Enabled := true;
    QueryStatus.Enabled := false;
    Print.Enabled := false;
    Close.Enabled := false;
    nExit.Enabled := true;

    exit;
  end;

	KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Look.bmp', 1 ); // ID number is 1

	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_PAGE );

  KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

	KIOSK_P_SetAreaAndDirection( state, nPortType, 10, 10, 620, 1200, KIOSK_AREA_LEFT_TO_RIGHT );

	KIOSK_P_Clear( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, 'SNBC KIOSK Printer', 95, 80, 2, 2,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '------------------------------------------', 95, 120,1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


	KIOSK_P_Textout( state, nPortType, '------------------------------------------', 95, 140,1, 1,
		                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );



	//Defferent right-spacing
	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, 'BK-L216', 95, 180, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 200, 180, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 2 );

	KIOSK_P_Textout( state, nPortType, 'BK-L216', 95, 210, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSKPrinter', 200, 210, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_SetRightSpacing( state, nPortType , 4 );

	KIOSK_P_Textout( state, nPortType, 'BK-L216', 95, 240, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'KIOSK Printer', 200, 240, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetRightSpacing( state, nPortType, 0 );


	//Defferent font
	KIOSK_SetRightSpacing( state, nPortType, 2 );

	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-NORMAL', 95, 300, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_NORMAL ); //正常字体


	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-BOLD', 95, 340, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD,KIOSK_FONT_STYLE_BOLD );



	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 95, 380, 1, 1,
		                KIOSK_FONT_TYPE_CHINESE, KIOSK_FONT_STYLE_THICK_UNDERLINE );



	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-UNDERLINE', 95, 420, 1, 1,
		               KIOSK_FONT_TYPE_CHINESE,	KIOSK_FONT_STYLE_THIN_UNDERLINE );


	KIOSK_P_Textout( state, nPortType, 'FONTSTYLE-REVERSE', 95, 460, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );



	//Print code-bar
	KIOSK_P_Textout( state, nPortType, '-------------------------------------', 95, 500,1, 1,
		                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, 'Barcode - Code 128', 200, 530, 1, 1,
		                KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 95,600, KIOSK_BARCODE_TYPE_CODE128,
		                   2, 50, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 20 );

	

	KIOSK_P_Textout( state, nPortType, '-------------------------------------', 95, 650,1, 1,
		                  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_P_Textout( state, nPortType, '---------------Logo 1----------------', 95, 670, 1, 1,
						KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 0, 95,  740, KIOSK_BITMAP_PRINT_QUADRUPLE);


	KIOSK_P_Textout( state, nPortType, '---------------Logo 2----------------', 95, 760,1, 1,
						KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_PrintBmpInRAM( state, nPortType, 1, 95, 850, KIOSK_BITMAP_PRINT_QUADRUPLE);

	KIOSK_P_Print( state, nPortType );

	KIOSK_P_Clear( state, nPortType );

	KIOSK_CutPaper( state, nPortType, KIOSK_PAPER_SERIAL, 50 );

  strMsg.Text := 'Print success!';
end;


procedure TMainForm.PrintInStandardMode210_203DPI;
var
  pBitImages: array[0..1] of string;
begin
  pBitImages[0] := 'Map.bmp';
  if KIOSK_PreDownloadBmpToFlash( state, nPortType, pBitImages, 2 ) <> KIOSK_SUCCESS then
  begin
    strMsg.Text := 'Print failed!';

    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;

    state := 0;
    OpenPort.Enabled := true;
    QueryStatus.Enabled := false;
    Print.Enabled := false;
    Close.Enabled := false;
    nExit.Enabled := true;

    exit;
  end;
  KIOSK_Reset( state,nPortType );

	KIOSK_SetMode( state,nPortType, KIOSK_PRINT_MODE_STANDARD );

  KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

  KIOSK_S_SetLeftMarginAndAreaWidth( state, nPortType, 100, 1500 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetLineSpacing( state, nPortType, 20 );

	KIOSK_FeedLines( state,nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'SNBC', 0, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_S_Textout( state, nPortType, 'Shandong New Beiyang Technology Information Company Co.Ltd',
                   800, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetLineSpacing( state, nPortType, 20 );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------------------------------------------------------------------------------------------------',
						       0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);


	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'SNBC KIOSK Printer', 500, 3, 3,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );


	

	KIOSK_FeedLines( state,nPortType, 5 );
	
	KIOSK_SetLineSpacing( state, nPortType, 40 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, '  In order to providing the user who use the KIOSK printer to carry on two of developments, KIOSKDLL were developed by the Shandong New Beiyang Technology Information Company Co.Ltd.',
		                0, 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state,nPortType, 1 );

	KIOSK_S_Textout( state, nPortType, '  We supply this sample to show our KIOSKDLL''s function. You can also rewoke the resident sample by yourself.',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );



	KIOSK_SetLineSpacing( state, nPortType, 15 );

	KIOSK_FeedLines( state, nPortType, 4 );

	KIOSK_S_Textout( state, nPortType, 'Support port:',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'COM',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_S_Textout( state, nPortType, 'LPT', 
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'USB',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_S_Textout( state, nPortType, 'Driver',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );


	KIOSK_FeedLines( state, nPortType, 3 );


	KIOSK_S_Textout( state, nPortType, 'Support system:', 
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'Windows 2000',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'Windows 2003',
		               800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

  KIOSK_FeedLines( state, nPortType , 2 );

	KIOSK_S_Textout( state, nPortType, 'Windows XP',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'Windows Vista',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );



	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Support bar code:',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'UPC-A',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'UPC-C',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'JAN13',
		                1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'JAN8',
                   440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'CODE39',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'ITF',
		                1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'CODEBAR',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'CODE93',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'CODE128',
		                1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'PDF417',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );




	KIOSK_FeedLines( state, nPortType, 3 );

  KIOSK_S_Textout( state, nPortType, 'Support equipment:',
		               0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'BK-T080',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_S_Textout( state, nPortType, 'BK-W080',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_S_Textout( state, nPortType, 'BK-S216',
		                1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_FeedLines( state,nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'BK-L216II',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_S_Textout( state, nPortType, 'BK-W056',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );



	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Paper   width:',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, '210mm(216mm max)',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );



	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Print   speed:',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'Max.125mm/s(203DPI)',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state,nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'Max.100mm/s(300DPI)',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );


    //Print bitmap in Flash
	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Print   Bitmap:',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 1, 500, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );



	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Print   Bar Code:',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

  KIOSK_S_Textout( state, nPortType, 'Barcode - Code 128',
		                440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 440, KIOSK_BARCODE_TYPE_CODE128,
		                    3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );



	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Addr : No.169 Huoju Rd,Hi-Tech Zone, WeiHai,Shandong,China',
		                440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'Tel  : 0086-631-5375888',
		                440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'Fax  : 0086-631-5675777',
		                440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'Post Code: 264209',
		                440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'Http://www.newbeiyuang.com',
		                440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );


	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------------------------------------------------------------------------------------------------',
						0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'YOUR THERMAL PRINTER PARTNER',
						850, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);


	KIOSK_FeedLines( state, nPortType, 5 );
	
	//Cut paper
	KIOSK_CutPaper( state, nPortType, 1, 50 );

  strMsg.Text := 'Print success!';
end;

procedure TMainForm.PrintInPageMode210_203DPI;
begin

  if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Map.bmp', 0 ) <> KIOSK_SUCCESS then // ID 号为 0
	begin
    strMsg.Text := 'Print failed!';

    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;

    state := 0;
    OpenPort.Enabled := true;
    QueryStatus.Enabled := false;
    Print.Enabled := false;
    Close.Enabled := false;
    nExit.Enabled := true;

    exit;
  end;
	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_PAGE );

	KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

	KIOSK_P_SetAreaAndDirection( state, nPortType, 95, 0, 1500, 2400, KIOSK_AREA_LEFT_TO_RIGHT );

	KIOSK_P_Clear( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 0 );


	KIOSK_P_Textout( state, nPortType, 'SNBC', 0, 100, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'Shandong New Beiyang Technology Information Company Co.Ltd',
                   800, 100,1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


	KIOSK_P_Textout( state, nPortType, '-----------------------------------------------------------------------------------------------------------------------------',
		                0, 150,1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);



	KIOSK_P_Textout( state, nPortType, 'SNBC KIOSK Printer',
		                500, 250,3, 3, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);




	KIOSK_SetLineSpacing( state, nPortType, 40 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, '  In order to providing the user who use the KIOSK printer to carry on two of developments, KIOSKDLL were developed by the Shandong New Beiyang Technology Information Company Co.Ltd.',
		                0, 350 , 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '  We supply this sample to show our KIOSKDLL''s function. You can also rewoke the resident sample by yourself.',
		                0, 500, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );



	KIOSK_SetLineSpacing( state, nPortType, 15 );

	KIOSK_P_Textout( state, nPortType, 'Support port:',
		                0, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'COM',
		                440, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'LPT',
		                800, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'USB',
		                440, 660, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'Driver',
		                800, 660, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );




	KIOSK_P_Textout( state, nPortType, 'Support system:',
		                0, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'Windows 2000',
		                440, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Windows 2003',
		                800, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Windows XP',
		                440, 760, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Windows Vista',
		                800, 760, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );



	KIOSK_P_Textout( state, nPortType, 'Support bar code:',
		                0, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'UPC-A',
		                440, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'UPC-C',
		                800, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'JAN13',
		                1200, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );


	KIOSK_P_Textout( state, nPortType, 'JAN8',
		                440, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODE39',
		                800, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'ITF',
		                1200, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );


	KIOSK_P_Textout( state, nPortType, 'CODEBAR',
		                440, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODE93',
		                800, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODE128',
		                1200,910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'PDF417',
		                440, 955, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );




  KIOSK_P_Textout( state, nPortType, 'Support equipment:',
		                0, 1120, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'BK-T080',
		                440, 1120, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_P_Textout( state, nPortType, 'BK-W080',
		                800, 1120, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_P_Textout( state, nPortType, 'BK-S216',
		                1200, 1120, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );


	KIOSK_P_Textout( state, nPortType, 'BK-L216II',
		                440, 1165, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_P_Textout( state, nPortType, 'BK-W056',
		                800, 1165, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );



	KIOSK_P_Textout( state, nPortType, 'Paper   width:',
		                0, 1225, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '210mm(216mm max)',
		                440, 1225, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );




	KIOSK_P_Textout( state, nPortType, 'Print   speed:',
		                0, 1285, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'Max.125mm/s(203DPI)',
		                440, 1285, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_Textout( state, nPortType, 'Max.100mm/s(300DPI)',
		                440, 1320, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );



	KIOSK_P_Textout( state, nPortType, 'Print   Bitmap:',
		                0, 1380, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_PrintBmpInFlash( state, nPortType, 1, 500, 1380, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );




	KIOSK_P_Textout( state, nPortType, 'Print   Bar Code:',
		                0, 1540, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

  KIOSK_P_Textout( state, nPortType, 'Barcode - Code 128',
		                440, 1540, 2, 1, KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);


	KIOSK_P_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 440, 1555,  KIOSK_BARCODE_TYPE_CODE128,
		                    3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );



	KIOSK_P_Textout( state, nPortType, 'Addr : No.169 Huoju Rd,Hi-Tech Zone, WeiHai,Shandong,China',
		                440, 1730, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_Textout( state, nPortType, 'Tel  : 0086-631-5375888',
		                440, 1745, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_Textout( state, nPortType, 'Fax  : 0086-631-5675777',
		                440, 1760, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_Textout( state, nPortType, 'Post Code: 264209',
		                440, 1775, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_Textout( state, nPortType, 'Http://www.newbeiyuang.com',
		                440, 1790, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );



	KIOSK_P_Textout( state, nPortType, '-----------------------------------------------------------------------------------------------------------------------------',
					        	0, 1905, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);



	KIOSK_P_Textout( state, nPortType, 'YOUR THERMAL PRINTER PARTNER',
						       850, 1920, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);


	KIOSK_P_Print( state, nPortType );

	KIOSK_P_Clear( state, nPortType );

	KIOSK_CutPaper( state, nPortType, KIOSK_PAPER_SERIAL, 50 );

end;


procedure TMainForm.PrintInStandardMode210_300DPI;
var
  pBitImages: array[0..1] of string;
begin
  pBitImages[0] := 'Map.bmp';
  if KIOSK_PreDownloadBmpToFlash( state, nPortType, pBitImages, 2 ) <> KIOSK_SUCCESS then
  begin
    strMsg.Text := 'Print failed!';

    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;

    state := 0;
    OpenPort.Enabled := true;
    QueryStatus.Enabled := false;
    Print.Enabled := false;
    Close.Enabled := false;
    nExit.Enabled := true;

    exit;
  end;
  KIOSK_Reset( state,nPortType );

	KIOSK_SetMode( state,nPortType, KIOSK_PRINT_MODE_STANDARD );

  KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

  KIOSK_S_SetLeftMarginAndAreaWidth( state, nPortType, 100, 1500 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_SetLineSpacing( state, nPortType, 20 );

	KIOSK_FeedLines( state,nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'SNBC', 0, 1, 1,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_S_Textout( state, nPortType, 'Shandong New Beiyang Technology Information Company Co.Ltd',
                   800, 1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_SetLineSpacing( state, nPortType, 20 );

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------------------------------------------------------------------------------------------------',
						       0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);


	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'SNBC KIOSK Printer', 500, 3, 3,
		                KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );


	

	KIOSK_FeedLines( state,nPortType, 5 );
	
	KIOSK_SetLineSpacing( state, nPortType, 40 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_S_Textout( state, nPortType, '  In order to providing the user who use the KIOSK printer to carry on two of developments, KIOSKDLL were developed by the Shandong New Beiyang Technology Information Company Co.Ltd.',
		                0, 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state,nPortType, 1 );

	KIOSK_S_Textout( state, nPortType, '  We supply this sample to show our KIOSKDLL''s function. You can also rewoke the resident sample by yourself.',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	


	KIOSK_SetLineSpacing( state, nPortType, 15 );

	KIOSK_FeedLines( state, nPortType, 4 );

	KIOSK_S_Textout( state, nPortType, 'Support port:',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'COM',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_S_Textout( state, nPortType, 'LPT', 
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'USB',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_S_Textout( state, nPortType, 'Driver',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );


	KIOSK_FeedLines( state, nPortType, 3 );


	KIOSK_S_Textout( state, nPortType, 'Support system:', 
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'Windows 2000',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'Windows 2003',
		               800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

  KIOSK_FeedLines( state, nPortType , 2 );

	KIOSK_S_Textout( state, nPortType, 'Windows XP',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'Windows Vista',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );



	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Support bar code:',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'UPC-A',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'UPC-C',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'JAN13',
		                1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'JAN8',
                   440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'CODE39',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'ITF',
		                1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLine( state,nPortType );
	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'CODEBAR',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'CODE93',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_S_Textout( state, nPortType, 'CODE128',
		                1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_FeedLines( state, nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'PDF417',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );




	KIOSK_FeedLines( state, nPortType, 3 );

  KIOSK_S_Textout( state, nPortType, 'Support equipment:',
		               0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'BK-T080',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_S_Textout( state, nPortType, 'BK-W080',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_S_Textout( state, nPortType, 'BK-S216',
		                1200, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_FeedLines( state,nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'BK-L216II',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_S_Textout( state, nPortType, 'BK-W056',
		                800, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );



	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Paper   width:',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, '210mm(216mm max)',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );



	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Print   speed:',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_S_Textout( state, nPortType, 'Max.125mm/s(203DPI)',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLines( state,nPortType, 2 );

	KIOSK_S_Textout( state, nPortType, 'Max.100mm/s(300DPI)',
		                440, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );


    //Print bitmap in Flash
	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Print   Bitmap:',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_PrintBmpInFlash( state, nPortType, 1, 500, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );



	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Print   Bar Code:',
		                0, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

  KIOSK_S_Textout( state, nPortType, 'Barcode - Code 128',
		                440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state, nPortType );

	KIOSK_S_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 440, KIOSK_BARCODE_TYPE_CODE128,
		                    3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );



	KIOSK_FeedLines( state,nPortType, 3 );

	KIOSK_S_Textout( state, nPortType, 'Addr : No.169 Huoju Rd,Hi-Tech Zone, WeiHai,Shandong,China',
		                440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'Tel  : 0086-631-5375888',
		                440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'Fax  : 0086-631-5675777',
		                440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'Post Code: 264209',
		                440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'Http://www.newbeiyuang.com',
		                440, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_FeedLine( state,nPortType );


	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, '-----------------------------------------------------------------------------------------------------------------------------',
						0, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);

	KIOSK_FeedLine( state,nPortType );

	KIOSK_S_Textout( state, nPortType, 'YOUR THERMAL PRINTER PARTNER',
						850, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);


	KIOSK_FeedLines( state, nPortType, 5 );
	
	//Cut paper
	KIOSK_CutPaper( state, nPortType, 1, 50 );

  strMsg.Text := 'Print success!';
end;


procedure TMainForm.PrintInPageMode210_300DPI;
begin
  if KIOSK_PreDownloadBmpToRAM( state, nPortType, 'Map.bmp', 0 ) <> KIOSK_SUCCESS then // ID 号为 0
	begin
    strMsg.Text := 'Print failed!';

    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;

    state := 0;
    OpenPort.Enabled := true;
    QueryStatus.Enabled := false;
    Print.Enabled := false;
    Close.Enabled := false;
    nExit.Enabled := true;        

    exit;
  end;
	KIOSK_SetMode( state, nPortType, KIOSK_PRINT_MODE_PAGE );

	KIOSK_SetMotionUnit( state, nPortType, 203, 203 );

	KIOSK_P_SetAreaAndDirection( state, nPortType, 95, 0, 1500, 2400, KIOSK_AREA_LEFT_TO_RIGHT );

	KIOSK_P_Clear( state, nPortType );

	KIOSK_SetRightSpacing( state, nPortType, 0 );


	KIOSK_P_Textout( state, nPortType, 'SNBC', 0, 100, 1, 1,
		               KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'Shandong New Beiyang Technology Information Company Co.Ltd',
                   800, 100,1, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD);


	KIOSK_P_Textout( state, nPortType, '-----------------------------------------------------------------------------------------------------------------------------',
		                0, 150,1, 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);



	KIOSK_P_Textout( state, nPortType, 'SNBC KIOSK Printer',
		                500, 250,3, 3, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);




	KIOSK_SetLineSpacing( state, nPortType, 40 );

	KIOSK_SetRightSpacing( state, nPortType, 0 );

	KIOSK_P_Textout( state, nPortType, '  In order to providing the user who use the KIOSK printer to carry on two of developments, KIOSKDLL were developed by the Shandong New Beiyang Technology Information Company Co.Ltd.',
		                0, 350 , 2, 1,  KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '  We supply this sample to show our KIOSKDLL''s function. You can also rewoke the resident sample by yourself.',
		                0, 500, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );



	KIOSK_SetLineSpacing( state, nPortType, 15 );

	KIOSK_P_Textout( state, nPortType, 'Support port:',
		                0, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'COM',
		                440, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'LPT',
		                800, 630, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'USB',
		                440, 660, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );

	KIOSK_P_Textout( state, nPortType, 'Driver',
		                800, 660, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_BOLD );




	KIOSK_P_Textout( state, nPortType, 'Support system:',
		                0, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'Windows 2000',
		                440, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Windows 2003',
		                800, 730, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Windows XP',
		                440, 760, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'Windows Vista',
		                800, 760, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THIN_UNDERLINE );



	KIOSK_P_Textout( state, nPortType, 'Support bar code:',
		                0, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'UPC-A',
		                440, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'UPC-C',
		                800, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'JAN13',
		                1200, 820, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );


	KIOSK_P_Textout( state, nPortType, 'JAN8',
		                440, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODE39',
		                800, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'ITF',
		                1200, 865, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );


	KIOSK_P_Textout( state, nPortType, 'CODEBAR',
		                440, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODE93',
		                800, 910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'CODE128',
		                1200,910, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );

	KIOSK_P_Textout( state, nPortType, 'PDF417',
		                440, 955, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_THICK_UNDERLINE );




  KIOSK_P_Textout( state, nPortType, 'Support equipment:',
		                0, 1120, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'BK-T080',
		                440, 1120, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_P_Textout( state, nPortType, 'BK-W080',
		                800, 1120, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_P_Textout( state, nPortType, 'BK-S216',
		                1200, 1120, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );


	KIOSK_P_Textout( state, nPortType, 'BK-L216II',
		                440, 1165, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );

	KIOSK_P_Textout( state, nPortType, 'BK-W056',
		                800, 1165, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_REVERSE );



	KIOSK_P_Textout( state, nPortType, 'Paper   width:',
		                0, 1225, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, '210mm(216mm max)',
		                440, 1225, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );




	KIOSK_P_Textout( state, nPortType, 'Print   speed:',
		                0, 1285, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

	KIOSK_P_Textout( state, nPortType, 'Max.125mm/s(203DPI)',
		                440, 1285, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_Textout( state, nPortType, 'Max.100mm/s(300DPI)',
		                440, 1320, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );



	KIOSK_P_Textout( state, nPortType, 'Print   Bitmap:',
		                0, 1380, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_PrintBmpInFlash( state, nPortType, 1, 500, 1380, KIOSK_BITMAP_PRINT_DOUBLE_WIDTH );




	KIOSK_P_Textout( state, nPortType, 'Print   Bar Code:',
		                0, 1540, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL );

  KIOSK_P_Textout( state, nPortType, 'Barcode - Code 128',
		                440, 1540, 2, 1, KIOSK_FONT_TYPE_COMPRESSED,KIOSK_FONT_STYLE_NORMAL);


	KIOSK_P_PrintBarcode( state, nPortType, '{A*1234ABCDE*{C5678', 440, 1555,  KIOSK_BARCODE_TYPE_CODE128,
		                    3, 80, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_HRI_POSITION_BOTH, 19 );



	KIOSK_P_Textout( state, nPortType, 'Addr : No.169 Huoju Rd,Hi-Tech Zone, WeiHai,Shandong,China',
		                440, 1730, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_Textout( state, nPortType, 'Tel  : 0086-631-5375888',
		                440, 1745, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_Textout( state, nPortType, 'Fax  : 0086-631-5675777',
		                440, 1760, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_Textout( state, nPortType, 'Post Code: 264209',
		                440, 1775, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );


	KIOSK_P_Textout( state, nPortType, 'Http://www.newbeiyuang.com',
		                440, 1790, 2, 1, KIOSK_FONT_TYPE_COMPRESSED, KIOSK_FONT_STYLE_NORMAL );



	KIOSK_P_Textout( state, nPortType, '-----------------------------------------------------------------------------------------------------------------------------',
					        	0, 1905, 1 , 2, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);



	KIOSK_P_Textout( state, nPortType, 'YOUR THERMAL PRINTER PARTNER',
						       850, 1920, 2, 1, KIOSK_FONT_TYPE_STANDARD, KIOSK_FONT_STYLE_NORMAL);


	KIOSK_P_Print( state, nPortType );

	KIOSK_P_Clear( state, nPortType );

	KIOSK_CutPaper( state, nPortType, KIOSK_PAPER_SERIAL, 50 );
end;


//Open port
procedure TMainForm.OpenportClick(Sender: TObject);
var
  nComName: pchar;
  nBaudrate,nDataBits, nParity: integer;
  nLptAddress: Word;
  nDriverName: pchar;

begin
  if state > 0 then
  begin
    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;
    state := 0;
  end;
  
  if nPortType = 0 then   //Open COM
  begin
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
    case Baudrate.ItemIndex of
      0: nBaudrate := 2400;
      1: nBaudrate := 4800;
      2: nBaudrate := 9600;
      3: nBaudrate := 19200;
      4: nBaudrate := 38400;
      5: nBaudrate := 57600;
     end;
     case DataBits.ItemIndex of
      0: nDataBits := 7;
      1: nDataBits := 8;
     end;
     state := KIOSK_OpenCom( nComName, nBaudrate, nDataBits, StopBits.ItemIndex, Parity.ItemIndex, FlowControl.ItemIndex);
     if state <> -1 then
     begin
       strMsg.Text := 'Open COM success!';

       Start.Enabled       := true;
       OpenPort.Enabled    := false;
       QueryStatus.Enabled := true;
       Print.Enabled       := true;
       Close.Enabled       := true;
       nExit.Enabled        := true;
     end
     else
     begin
       strMsg.Text := 'Open COM failed!';
     end;
  end
  else if nPortType = 1 then//Open LPT
  begin
    if LPTAddress.ItemIndex = 0 then
    begin
      nLPTAddress := $378;
    end
    else
    begin
      nLPTAddress := $278;
    end;
    state := KIOSK_OpenLptByDrv( nLPTAddress );
    if state = KIOSK_SUCCESS then
    begin
       strMsg.Text := 'Open LPT success!';

       Start.Enabled       := false;
       Stop.Enabled        := false;
       OpenPort.Enabled    := false;
       QueryStatus.Enabled := false;
       Print.Enabled       := true;
       Close.Enabled       := true;
       nExit.Enabled        := true;
     end
     else
     begin
       strMsg.Text := 'Open LPT failed!';
     end;
  end
  else if nPortType = 2 then//Open USB
  begin
    state := KIOSK_OpenUsb();
    if state <> -1 then
    begin
      strMsg.Text := 'Open USB success!';
      Start.Enabled       := true;
      Stop.Enabled        := false;
      OpenPort.Enabled    := false;
      QueryStatus.Enabled := true;
      Print.Enabled       := true;
      Close.Enabled       := true;
      nExit.Enabled        := true;
    end
    else
    begin
      strMsg.Text := 'Open USB failed!';
    end;
  end
  else                      //Open Driver
  begin
    state := KIOSK_OpenDrv( 'BK-L216II(200)(U) 1' );    //过滤成nDriverName
    if state <> -1 then
    begin
      strMsg.Text := 'Open Driver success!';

      Start.Enabled       := false;
      Stop.Enabled        := false;
      OpenPort.Enabled    := false;
      QueryStatus.Enabled := false;
      Print.Enabled       := true;
      Close.Enabled       := true;
      nExit.Enabled        := true;
    end
    else
    begin
      strMsg.Text := 'Open Driver failed!';
    end;
  end;
end;


// Close port
procedure TMainForm.CloseClick(Sender: TObject);
begin
  Start.Enabled       := false;
  Stop.Enabled        := false;
  OpenPort.Enabled    := true;
  QueryStatus.Enabled := false;
  Print.Enabled       := false;
  Close.Enabled       := false;
  nExit.Enabled        := true;
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


// Query status
procedure TMainForm.QueryStatusClick(Sender: TObject);
var
  bits: array [0..7] of Integer;
  nStatus: Char;
  i: Integer;
  Return: Integer;
  strInfo: string;
begin
  strInfo := '';
  Return := KIOSK_RTQueryStatus( state, nPortType, @nStatus );
  if Return <> KIOSK_SUCCESS then
  begin
    strInfo := 'Query status fail!';
    case nPortType of
      0: KIOSK_CloseCom( state );
      1: KIOSK_CloseDrvLPT( nPortType );
      2: KIOSK_CloseUsb( state );
      3: KIOSK_CloseDrv( state );
    end;

    state := 0;

    Start.Enabled        := false;
    OpenPort.Enabled     := true;
    QueryStatus.Enabled  := false;
    Print.Enabled        := false;
    Close.Enabled        := false;
    nExit.Enabled        := true;
  end
  else
  begin
    if( integer(nStatus) = 0 )then
    begin
      strInfo := 'All is ok!';
    end
    else
    begin
      for i := 0 to 7 do
      begin
        bits[i]:= ( Integer( nStatus) shr i ) And 1;
      end;

      if Bits[0] = 1 then
		 	strInfo := strInfo + 'Head Up!';

		  if Bits[1] = 1 then
      strInfo := strInfo + 'Paper End!';

      if Bits[2] = 1 then
      strInfo := strInfo + 'Cutter Error!';

      if Bits[3] = 1 then
      strInfo := strInfo + 'TPH Too Hot!';

      if Bits[4] = 1 then
      strInfo := strInfo + 'Paper Near End!';

      if Bits[5] = 1 then
      strInfo := strInfo + 'Paper Jam!';

      if Bits[6] = 1 then
      strInfo := strInfo + 'Presenter/Bundler Paper Jam!';

      if Bits[7] = 1 then
      strInfo := strInfo + 'Auto Feed Error!';

      strMsg.Text := strInfo;
    end;

  end;
end;


// Print
procedure TMainForm.PrintClick(Sender: TObject);
begin
  if nPortType = 3 then
  begin
    KIOSK_StartDoc( state );
  end;
  if nPortType = 2 then
  begin
    KIOSK_SetUsbTimeOuts( state, 200, 200 );
  end;

  if SaveToFile.Checked then
  begin
    KIOSK_BeginSaveToFile( 'Test.text', false );
  end;

  if SelectMode.ItemIndex = 0 then        //Standard mode
  begin
    if Pagewidth.ItemIndex = 0 then       //56mm
    begin
       if Resolution.ItemIndex = 0 then   //203dpi
       begin
         PrintInStandardMode56_203DPI();
       end
       else
       begin
         PrintInStandardMode56_300DPI();  //300dpi
       end;
    end
    else if Pagewidth.ItemIndex = 1 then  //80mm
    begin
      if Resolution.ItemIndex = 0 then    //203dpi
       begin
         PrintInStandardMode80_203DPI();
       end
       else
       begin
         PrintInStandardMode80_300DPI();  //300dpi
       end;
    end
    else                                  //210mm
    begin
      if Resolution.ItemIndex = 0 then    //203dpi
       begin
         PrintInStandardMode210_203DPI();
       end
       else
       begin
         PrintInStandardMode210_300DPI();  //300dpi
       end;
    end;
  end
  else                                    //Page mode
  begin
    if Pagewidth.ItemIndex = 0 then       //56mm
    begin
       if Resolution.ItemIndex = 0 then   //203dpi
       begin
         PrintInPageMode56_203DPI();
       end
       else
       begin
         PrintInPageMode56_300DPI();      //300dpi
       end;
    end
    else if Pagewidth.ItemIndex = 1 then  //80mm
    begin
      if Resolution.ItemIndex = 0 then    //203dpi
       begin
         PrintInPageMode80_203DPI();
       end
       else
       begin
         PrintInPageMode80_300DPI();      //300dpi
       end;
    end
    else                                  //210mm
    begin
      if Resolution.ItemIndex = 0 then    //203dpi
       begin
         PrintInPageMode210_203DPI();
       end
       else
       begin
         PrintInPageMode210_300DPI();     //300dpi
       end;
    end;
  end;

  if SaveToFile.Checked then
  begin
    KIOSK_EndSaveToFile();
  end;
  // Set presenter
  if Select.ItemIndex = 0 then
  begin
    if Presenter.ItemIndex = 0 then
    begin
      if KIOSK_SetPresenter( state, nPortType, KIOSK_PRESENTER_Retraction_on, 3 ) <> KIOSK_SUCCESS then
      begin
         ShowMessage('Set Presenter fail!');
      end;
    end
    else if Presenter.ItemIndex = 1 then
    begin
      if KIOSK_SetPresenter( state, nPortType, KIOSK_PRESENTER_Paper_Forward, 3 ) <> KIOSK_SUCCESS then
      begin
        ShowMessage('Set Presenter fail!');
      end;
    end
    else
    begin
      if KIOSK_SetPresenter( state, nPortType, KIOSK_PRESENTER_Paper_Hold, 3 ) <> KIOSK_SUCCESS then
      begin
        ShowMessage('Set Presenter fail!');
      end;
    end;
  end
  //Set bundler
  else
  begin
    if Bundler.ItemIndex = 0 then
    begin
      if KIOSK_SetBundler( state, nPortType, KIOSK_BUNDLER_Retract, 3 )<> KIOSK_SUCCESS then
      begin
        ShowMessage('Set Bundler fail!');
      end;
    end
    else
    begin
      if KIOSK_SetBundler( state, nPortType, KIOSK_BUNDLER_Present, 3 )<> KIOSK_SUCCESS then
      begin
        ShowMessage('Set Bundler fail!');
      end;
    end;
  end;

  if nPortType = 3 then
  begin
    KIOSK_EndDoc( state );
  end;
end;


//Select presenter or bundler.
procedure TMainForm.SelectClick(Sender: TObject);
begin

  if Select.ItemIndex = 0 then
  begin
    Presenter.Enabled := true;
    Bundler.Enabled   := false;
  end
  else
  begin
    Presenter.Enabled := false;
    Bundler.Enabled := true;
  end;
end;


//Exit
procedure TMainForm.nExitClick(Sender: TObject);
begin
  screen.forms[0].close;
end;


// Select port.
procedure TMainForm.SelectPortClick(Sender: TObject);
begin
   nPortType := SelectPort.ItemIndex;
   if nPortType = 0 then        //Select COM
   begin
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
   else if nPortType = 1 then    //Select LPT
   begin
    ComName.Enabled     := false;
    Baudrate.Enabled    := false;
    DataBits.Enabled    := false;
    Parity.Enabled      := false;
    StopBits.Enabled    := false;
    FlowControl.Enabled := true;

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
   else if nPortType = 2 then       //Select USB
   begin
    ComName.Enabled     := false;
    Baudrate.Enabled    := false;
    DataBits.Enabled    := false;
    Parity.Enabled      := false;
    StopBits.Enabled    := false;
    FlowControl.Enabled := true;

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
    nExit.Enabled        := true;
   end
   else                                //Select Driver
   begin
    ComName.Enabled     := false;
    Baudrate.Enabled    := false;
    DataBits.Enabled    := false;
    Parity.Enabled      := false;
    StopBits.Enabled    := false;
    FlowControl.Enabled := true;

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


//Start status monitor
procedure TMainForm.StartClick( Sender: TObject );
begin
  Start.Enabled := false;
  Stop.Enabled  := true;

  ThreadRunning := true;
  TStatusThread.Create( false );
end;

//Stop status monitor
procedure TMainForm.StopClick(Sender: TObject);
begin
  Start.Enabled := true;
  Stop.Enabled  := false;

  ThreadRunning := false;
end;

end.

