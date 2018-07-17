unit PosDllDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,PosdllFuncs,IniFiles,
  winspool, XPMan;
type
  TMainForm = class(TForm)
    PortSet: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    cbPortName: TComboBox;
    cbBaud: TComboBox;
    cbData: TComboBox;
    cbParity: TComboBox;
    cbStop: TComboBox;
    cbFlow: TComboBox;
    cbLPT: TComboBox;
    cbName : TComboBox;
    edDrive: TEdit;
    ChkWrite: TCheckBox;
    OpenPort: TButton;
    Aboutinquire: TButton;
    edQuery: TEdit;
    Print: TButton;
    ClosePort: TButton;
    GroupBox3: TGroupBox;
    Label10: TLabel;
    pagewide: TComboBox;
    IP1: TEdit;
    IP2: TEdit;
    IP3: TEdit;
    IP4: TEdit;
    PortChoice: TRadioGroup;
    ModeSelect: TRadioGroup;
    Label11: TLabel;
    Label12: TLabel;
    procedure FormResize(Sender: TObject);
    procedure IP4KeyPress(Sender: TObject; var Key: Char);
  //procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OpenPortClick(Sender: TObject);
    procedure AboutinquireClick(Sender: TObject);
    procedure ClosePortClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure IP1KeyPress(Sender: TObject; var Key: Char);
    procedure IP2KeyPress(Sender: TObject; var Key: Char);
    procedure IP3KeyPress(Sender: TObject; var Key: Char);
    procedure PortChoiceClick(Sender: TObject);
    procedure cbPortNameChange(Sender: TObject);
    procedure IP1Change(Sender: TObject);
    procedure IP2Change(Sender: TObject);
    procedure IP3Change(Sender: TObject);
    procedure IP4Change(Sender: TObject);
    procedure cbLPTChange(Sender: TObject);
  private
    { Private declarations }
    procedure PrintInStandardMode80();
    procedure PrintInPageMode80();
    procedure PrintInStandardMode56();
    procedure PrintInPageMode56();
    procedure SetCtrlLang(ID : Short);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  b_OpenPort :boolean;//是否打开端口.
  Portname,Portname1 : String;///端口名称
  baudRate1,StopBit,DataBit,HandShake,Paritytemp :Integer;
  ComName,LptName,UsbName: integer;
  Porttype :integer;
  state:integer;
  
  bHasDownToFlash56: Bool;
  bHasDownToFlash80: Bool;
  bHasDownToRAM56: Bool;
  bHasDownToRAM80: Bool;
  portid:integer;

  i_portIndex : integer;
  ipConst : String;        //网络接口输入的IP值
  iReturndate : integer;
  langID : Short;

implementation

{$R *.dfm}

procedure TMainForm.PrintInStandardMode80();   //80毫米标准模式样张函数
var
  strBitImages: array[0..2] of string;
  iCount: Integer;
begin
   iReturndate:=POS_SetMotionUnit(180, 180);
  if iReturndate<>1001 then
  begin
    if langID = 2052 then
    begin
      edQuery.Text:='打印失败！';
    end
    else
    begin
      edQuery.Text:='Print failed!';
    end;

     OpenPort.Enabled:=true;
     Aboutinquire.Enabled:=false;
     Print.Enabled:=False;
     ClosePort.Enabled:=False;
     cbName.Enabled := False;
     exit;
  end;

  // 预下载位图到 Flash，如果掉电不会丢失

  strBitImages[0] := 'Kitty.bmp';
  strBitImages[1] := 'Look.bmp';
  iCount := 2;

  if bHasDownToFlash80 = False then
  begin
    POS_PreDownloadBmpsToFlash(strBitImages, iCount);
    bHasDownToFlash80 := True;
 {   if PortChoice.ItemIndex=1 then
    begin
      Print.Enabled:=False;
    end;
 }
  end;

  //POS_EnumUSBPrinter(cPrinterName)；

	POS_SetMode(POS_PRINT_MODE_STANDARD);

	POS_SetRightSpacing(0);

	POS_SetLineSpacing(100);
	POS_S_TextOut('Beiyang POS Printer', 50, 2, 3, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
		
	POS_SetLineSpacing(35);

	POS_FeedLine();
	POS_FeedLine();

	POS_S_TextOut('SNBC POS Thermal Printer', 20, 1, 1, POS_FONT_TYPE_CHINESE,
		POS_FONT_STYLE_THICK_UNDERLINE);
	POS_FeedLine();
	POS_S_TextOut('SNBC POS Thermal Printer', 20, 1, 1, POS_FONT_TYPE_CHINESE,
		POS_FONT_STYLE_THIN_UNDERLINE);
	POS_FeedLine();
	POS_FeedLine();

	POS_SetLineSpacing(24);

	// 不同的字符右间距

	POS_SetRightSpacing(0);
	POS_S_TextOut('BTP-2000CP', 20, 1, 1, POS_FONT_TYPE_STANDARD, 
		POS_FONT_STYLE_NORMAL);
	POS_S_TextOut('POS Thermal Printer', 200, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();

	POS_SetRightSpacing(2);
	POS_S_TextOut('BTP-2001CP', 20, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_S_TextOut('POS Thermal Printer', 200, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();

	POS_SetRightSpacing(4);
	POS_S_TextOut('BTP-2002CP', 20, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_S_TextOut('POS Thermal Printer', 200, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();
	POS_FeedLine();

	// 不同的字符风格

	POS_SetRightSpacing(2);
	POS_S_TextOut('Normal font print', 20, 1, 1, POS_FONT_TYPE_CHINESE,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();
  POS_S_TextOut('Reverse display font print', 20, 1, 1, POS_FONT_TYPE_CHINESE,
		POS_FONT_STYLE_REVERSE);
	POS_FeedLine();
	POS_S_TextOut('Clockwise rotate 90 print', 20, 1, 1, POS_FONT_TYPE_CHINESE,
		POS_FONT_STYLE_CLOCKWISE_90);
	POS_FeedLine();
	POS_S_TextOut('Inverted font print', 20, 1, 1, POS_FONT_TYPE_CHINESE,
		POS_FONT_STYLE_UPSIDEDOWN);
	POS_FeedLine();
	POS_FeedLine();
	

	// 打印条码

	POS_SetRightSpacing(0);

	POS_S_TextOut('----------------------------------', 50, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();

	POS_S_TextOut('Barcode - Code 128', 160, 1, 1, POS_FONT_TYPE_COMPRESSED,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();
	POS_FeedLine();

	POS_S_SetBarcode('{A*1234ABCDE*{C5678', 40, POS_BARCODE_TYPE_CODE128,
    2, 50, POS_FONT_TYPE_COMPRESSED, POS_HRI_POSITION_BOTH, 19);
	POS_FeedLine();
	
	POS_S_TextOut('----------------------------------', 50, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);	
	POS_FeedLine();

	// 打印已下载到 Flash 中的位图

	POS_FeedLine();
	POS_S_TextOut('-------------> Logo 1', 20, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();
	POS_S_PrintBmpInFlash(1, 20, POS_BITMAP_PRINT_NORMAL);

	POS_FeedLine();
	POS_S_TextOut('-------------> Logo 2', 20, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();
	POS_S_PrintBmpInFlash(2, 20, POS_BITMAP_PRINT_NORMAL);

	POS_FeedLine();
	POS_FeedLine();
  POS_FeedLine();
	POS_FeedLine();
  POS_FeedLine();
	POS_FeedLine();
  POS_FeedLine();
	POS_FeedLine();
  POS_FeedLine();
	POS_FeedLine();
  POS_FeedLine();
	POS_FeedLine();

	// 切纸
	POS_CutPaper(POS_CUT_MODE_FULL, 0);
  if langID = 2052 then
  begin
    edQuery.Text:='打印成功!';
  end
  else
  begin
    edQuery.Text:='Print success!';
  end;
end;

procedure TMainForm.PrintInPageMode80();     //80毫米的页模式样张函数
begin
   iReturndate:=POS_SetMotionUnit(180, 180);
  if iReturndate<>1001 then
  begin
    if langID = 2052 then
    begin
      edQuery.Text:='打印失败！';
    end
    else
    begin
      edQuery.Text:='Print failed!';
    end;

     OpenPort.Enabled:=true;
     Aboutinquire.Enabled:=false;
     Print.Enabled:=False;
     ClosePort.Enabled:=False;
     cbName.Enabled := False;
     exit;
  end;

   // 预下载位图到 RAM，如果掉电则丢失
  if bHasDownToRAM80 = False then
  begin
    POS_PreDownloadBmpToRAM('Kitty.bmp', 0);      // ID 号为 0
		POS_PreDownloadBmpToRAM('Look.bmp', 1);     // ID 号为 1
   // bHasDownToRAM80 := True;
  end;

  //POS_SetMotionUnit(180, 180);
	POS_SetMode(POS_PRINT_MODE_PAGE);	

	POS_PL_SetArea(10, 10, 620, 800, POS_AREA_BOTTOM_TO_TOP);
	POS_PL_Clear();

	POS_SetRightSpacing(0);

	POS_PL_TextOut('Beiyang POS Thermal Printer', 20, 80, 2, 2, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_THICK_UNDERLINE);

	// 不同字符右间距

	POS_SetRightSpacing(0);
	POS_PL_TextOut('BTP-2000CP', 30, 140, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_PL_TextOut('POS Thermal Printer', 300, 140, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);

	POS_SetRightSpacing(4);
	POS_PL_TextOut('BTP-2001CP', 30, 180, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_PL_TextOut('POS Thermal Printer', 300, 180, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);

	POS_SetRightSpacing(8);
	POS_PL_TextOut('BTP-2002CP', 30, 220, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_PL_TextOut('POS Thermal Printer', 300, 220, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);

	POS_SetRightSpacing(0);

	POS_PL_TextOut('********************', 110, 260, 2, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);

	// 打印条码

	POS_PL_TextOut('Barcode - Code 128', 260, 290, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_PL_SetBarcode('{A*123ABC*{C34567890', 40, 360, POS_BARCODE_TYPE_CODE128, 3, 50,
		POS_FONT_TYPE_COMPRESSED, POS_HRI_POSITION_BELOW, 20);

	// 打印已经下载到 RAM 中的位图

	POS_PL_PrintBmpInRAM(0, 50, 450, POS_BITMAP_PRINT_NORMAL);
	POS_PL_PrintBmpInRAM(0, 230, 450, POS_BITMAP_PRINT_NORMAL);
	POS_PL_PrintBmpInRAM(1, 410, 450, POS_BITMAP_PRINT_NORMAL);
	POS_PL_PrintBmpInRAM(1, 590, 450, POS_BITMAP_PRINT_NORMAL);

	POS_PL_Print();
	POS_PL_Clear();
	POS_CutPaper(POS_CUT_MODE_PARTIAL, 150);
  if langID = 2052 then
  begin
    edQuery.Text:='打印成功!';
  end
  else
  begin
    edQuery.Text:='Print success!';
  end;

{  if PortChoice.ItemIndex=1 then
    begin
      Print.Enabled:=False;
    end;
 }
end;

procedure TMainForm.PrintInStandardMode56();    //56毫米标准模式样张函数
var
  strBitImages: array[0..2] of string;
  iCount: Integer;
begin
 iReturndate:=POS_SetMotionUnit(180, 180);
  if iReturndate<>1001 then
  begin
    if langID = 2052 then
    begin
      edQuery.Text:='打印失败！';
    end
    else
    begin
      edQuery.Text:='Print failed!';
    end;

     OpenPort.Enabled:=true;
     Aboutinquire.Enabled:=false;
     Print.Enabled:=False;
     ClosePort.Enabled:=False;
     cbName.Enabled := False;
     exit;
  end;

  // 预下载位图到 Flash，如果掉电不会丢失

  strBitImages[0] := 'Kitty.bmp';
  strBitImages[1] := 'Look.bmp';
  iCount := 2;

  if bHasDownToFlash56 = False then
  begin
    POS_PreDownloadBmpsToFlash(strBitImages, iCount);
    bHasDownToFlash56 := True;
  end;

  //POS_SetMotionUnit(180, 180);
	POS_SetMode(POS_PRINT_MODE_STANDARD);

	POS_SetRightSpacing(0);

	POS_SetLineSpacing(100);
	POS_S_TextOut('Beiyang POS Thermal Printer', 30, 1, 2, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);

	POS_SetLineSpacing(35);

	POS_FeedLine();
	POS_FeedLine();
	POS_S_TextOut('SNBC POS Thermal Printer', 20, 1, 1, POS_FONT_TYPE_CHINESE,
		POS_FONT_STYLE_THICK_UNDERLINE);
	POS_FeedLine();
	POS_S_TextOut('SNBC POS Thermal Printer', 20, 1, 1, POS_FONT_TYPE_CHINESE,
		POS_FONT_STYLE_THIN_UNDERLINE);
	POS_FeedLine();
	POS_FeedLine();

  POS_SetLineSpacing(24);

	// 不同的字符右间距

	POS_SetRightSpacing(0);
	POS_S_TextOut('BTP-2000CP', 20, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_S_TextOut('POS Printer', 200, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();

	POS_SetRightSpacing(2);
	POS_S_TextOut('BTP-2001CP', 20, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_S_TextOut('POS Printer', 200, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();

	POS_SetRightSpacing(4);
	POS_S_TextOut('BTP-2002CP', 20, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_S_TextOut('POS Printer', 200, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();
	POS_FeedLine();

	// 不同的字体格式

	POS_SetRightSpacing(5);
	POS_S_TextOut('Normal font print', 20, 1, 1, POS_FONT_TYPE_CHINESE,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();
  POS_S_TextOut('Reverse display font print', 20, 1, 1, POS_FONT_TYPE_CHINESE,
		POS_FONT_STYLE_REVERSE);
	POS_FeedLine();
	POS_S_TextOut('Clockwise rotate 90 print', 20, 1, 1, POS_FONT_TYPE_CHINESE,
		POS_FONT_STYLE_CLOCKWISE_90);
	POS_FeedLine();
	POS_S_TextOut('Inverted font print', 20, 1, 1, POS_FONT_TYPE_CHINESE,
		POS_FONT_STYLE_UPSIDEDOWN);
	POS_FeedLine();
	POS_FeedLine();

	// 打印条码

	POS_SetRightSpacing(0);

	POS_S_TextOut('-----------------------', 50, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);

	POS_FeedLine();

	POS_S_TextOut('Barcode - Code 128', 100, 1, 1, POS_FONT_TYPE_COMPRESSED,
		POS_FONT_STYLE_NORMAL);

	POS_FeedLine();

	POS_S_SetBarcode('{A*123AB{C567', 50, POS_BARCODE_TYPE_CODE128, 2, 50,
    POS_FONT_TYPE_COMPRESSED, POS_HRI_POSITION_BOTH, 13);

	POS_S_TextOut('-----------------------', 50, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);

	POS_FeedLine();

	// 打印已下载到 Flash 中的位图

	POS_FeedLine();
	POS_S_TextOut('-------------> Logo 1', 20, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();
	POS_S_PrintBmpInFlash(1, 20, POS_BITMAP_PRINT_NORMAL);
	POS_FeedLine();

	POS_S_TextOut('-------------> Logo 2', 20, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_FeedLine();
	POS_S_PrintBmpInFlash(2, 20, POS_BITMAP_PRINT_NORMAL);

	POS_FeedLine();
	POS_FeedLine();
  POS_FeedLine();
	POS_FeedLine();
  POS_FeedLine();
	POS_FeedLine();
  POS_FeedLine();
	POS_FeedLine();
  POS_FeedLine();
	POS_FeedLine();
  POS_FeedLine();
	POS_FeedLine();

	// 切纸
	POS_CutPaper(POS_CUT_MODE_FULL, 0);
  if langID = 2052 then
  begin
    edQuery.Text:='打印成功!';
  end
  else
  begin
    edQuery.Text:='Print success!';
  end;

{  if PortChoice.ItemIndex=1 then
    begin
      Print.Enabled:=False;
    end;

 }
end;

procedure TMainForm.PrintInPageMode56();    //56毫米页模式样张函数
begin
  iReturndate:=POS_SetMotionUnit(180, 180);
  if iReturndate<>1001 then
    begin
    if langID = 2052 then
    begin
      edQuery.Text:='打印失败！';
    end
    else
    begin
      edQuery.Text:='Print failed!';
    end;
    
     OpenPort.Enabled:=true;
     Aboutinquire.Enabled:=false;
     Print.Enabled:=False;
     ClosePort.Enabled:=False;
     cbName.Enabled := False;
     exit;
    end;

  // 预下载位图到 RAM，如果掉电则丢失
  if bHasDownToRAM56 = False then
    begin
      POS_PreDownloadBmpToRAM('Kitty.bmp', 0);      // ID 号为 0
		  POS_PreDownloadBmpToRAM('Look.bmp', 1);     // ID 号为 1
    //bHasDownToRAM56 := True;
    end;

  //POS_SetMotionUnit(180, 180);
	POS_SetMode(POS_PRINT_MODE_PAGE);

	POS_PL_SetArea(10, 10, 440, 800, POS_AREA_BOTTOM_TO_TOP);

	POS_PL_Clear();

	POS_SetRightSpacing(0);

	POS_PL_TextOut('Beiyang POS Thermal Printer', 0, 50, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_THICK_UNDERLINE);

	// 不同字符右间距

	POS_SetRightSpacing(0);
	POS_PL_TextOut('BTP-2000CP', 5, 80, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_PL_TextOut('POS Thermal Printer', 230, 80, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);


	POS_SetRightSpacing(4);
	POS_PL_TextOut('BTP-2001CP', 5, 110, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_PL_TextOut('POS Thermal Printer', 230, 110, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);

	POS_SetRightSpacing(8);
	POS_PL_TextOut('BTP-2002CP', 5, 140, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	POS_PL_TextOut('POS Thermal Printer', 230, 140, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);
	
	POS_SetRightSpacing(0);
	POS_SetLineSpacing(0);

	POS_PL_TextOut('********************', 70, 170, 2, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);

	// 打印条码

	POS_PL_TextOut('Barcode - Code 128', 180, 195, 1, 1, POS_FONT_TYPE_STANDARD,
		POS_FONT_STYLE_NORMAL);

	POS_PL_SetBarcode('{A*12345ABC*{C90', 5, 260, POS_BARCODE_TYPE_CODE128, 3, 50,
    POS_FONT_TYPE_COMPRESSED, POS_HRI_POSITION_BELOW, 16);
	
	// 打印已经下载到 RAM 中的位图

	POS_PL_PrintBmpInRAM(0, 50, 330, POS_BITMAP_PRINT_NORMAL);
//	POS_PL_PrintBmpInRAM(0, 230, 370, POS_BITMAP_PRINT_NORMAL);
	POS_PL_PrintBmpInRAM(1, 410, 330, POS_BITMAP_PRINT_NORMAL);
//	POS_PL_PrintBmpInRAM(1, 590, 370, POS_BITMAP_PRINT_NORMAL);

	POS_PL_Print();

	POS_PL_Clear();

	POS_CutPaper(POS_CUT_MODE_PARTIAL, 150);
  if langID = 2052 then
  begin
    edQuery.Text:='打印成功!';
  end
  else
  begin
    edQuery.Text:='Print success!';
  end;
{  if PortChoice.ItemIndex=1 then
    begin
      Print.Enabled:=False;
    end;

 }
end;
//调用函数完成状态查询的功能----------------------------------------------------
procedure TMainForm.AboutinquireClick(Sender: TObject);
var
  bits: array [0..7] of Integer;
  chStatus: Char;
  i: Integer;
  iReturn: Integer;
  strInfo: string;
begin
  if state <= 0  then
  begin
    if langID = 2052 then
    begin
      edQuery.Text :='端口未打开';
    end
    else
    begin
      edQuery.Text:='Port not open!';
    end;

    exit;
  end;
  strInfo := '';
   if PortChoice.ItemIndex=1 then
     iReturn:=POS_NETQueryStatus(PChar(ipConst),@chStatus)
   else
   begin
     iReturn := POS_RTQueryStatus(@chStatus);
   end;
  If iReturn <> POS_SUCCESS Then
  begin
    if langID = 2052 then
    begin
      strInfo := '查询状态失败！';
    end
    else
    begin
      strInfo := 'Query status failed!';
    end;

    edQuery.Text := strInfo;
    OpenPort.Enabled:=true;
    Aboutinquire.Enabled:=false;
    Print.Enabled:=False;
    ClosePort.Enabled:=False;
    cbName.Enabled := False;
    exit;
  End;

  If (Integer(chStatus) = 1) then
  begin
    if langID = 2052 then
    begin
      edQuery.Text := '一切正常！';
    end
    else
    begin
      edQuery.Text := 'All OK!';
    end;

    exit;
  end;

  for i := 0 to 7 do
  begin
    bits[i] := (Integer(chStatus) shr i) And 1;
  end;

  if bits[0] = 0 then
  begin
    if langID = 2052 then
    begin
      strInfo := '有钱箱打开！';
    end
    else
    begin
      strInfo := 'Cash drawer open!';
    end;
  end;


	if bits[1] = 1 then
  begin
    if langID = 2052 then
    begin
      strInfo := strInfo + '打印机脱机！';
    end
    else
    begin
      strInfo := strInfo + 'Printer offline!';
    end;
  end;


	if bits[2] = 1 then
  begin
    if langID = 2052 then
    begin
      strInfo := strInfo + '上盖打开！';
    end
    else
    begin
      strInfo := strInfo + 'Cover open!';
    end;
  end;


  if bits[3] = 1 then
  begin
    if langID = 2052 then
    begin
      strInfo := Strinfo + '正在进纸！';
    end
    else
    begin
      strInfo := Strinfo + 'Paper feeding!';
    end;
  end;


	if bits[4] = 1 then
  begin
    if langID = 2052 then
    begin
      strInfo := strInfo + '打印机出错！';
    end
    else
    begin
      strInfo := strInfo + 'Priner error!';
    end;
  end;


	if bits[5] = 1 then
  begin
    if langID = 2052 then
    begin
      strInfo := strInfo + '切刀出错！';
    end
    else
    begin
      strInfo := strInfo + 'Cutter error!';
    end;
  end;


	if bits[6] = 1 then
  begin
    if langID = 2052 then
    begin
      strInfo := strInfo + '纸将尽！';
    end
    else
    begin
      strInfo := strInfo + 'Paper near end!';
    end;
  end;


	if bits[7] = 1 then
  begin
    if langID = 2052 then
    begin
      strInfo := strInfo + '缺纸！';
    end
    else
    begin
      strInfo := strInfo + 'Paper end!';
    end;
  end;


  if strInfo = '' then
  begin
    if langID = 2052 then
    begin
      strInfo := '一切正常!';
    end
    else
    begin
      strInfo := 'All OK!';
    end;
  end;


  edQuery.Text:= strInfo;
end;
//调用函数完成状态查询的功能----------------------------------------------------
//------------------------------------------------------------------------------
//如果改变选择项首先将已打开的端口关闭------------------------------------------
procedure TMainForm.cbLPTChange(Sender: TObject);
begin
    if  state  > 0 then
  begin
    POS_Close();
    state := 0;
  end;
end;

procedure TMainForm.cbPortNameChange(Sender: TObject);
begin
 if  state  > 0 then
  begin
    POS_Close();
    state := 0;
  end;
end;
//如果改变选择项首先将已打开的端口关闭------------------------------------------
//******************************************************************************
//端口关闭的操作----------------------------------------------------------------
procedure TMainForm.ClosePortClick(Sender: TObject);
begin
  POS_Close();
  state := 0;
  if state<=0 then
  begin
    if langID = 2052 then
    begin
      edQuery.Text:='端口关闭成功！';
    end
    else
    begin
      edQuery.Text:='Close port success!';
    end;

     OpenPort.Enabled:=true;
  end;
  if state>0 then
  begin
    if langID = 2052 then
    begin
      edQuery.Text:='端口关闭失败！';
    end
    else
    begin
      edQuery.Text:='Close port failed!';
    end;

  end;
  ClosePort.Enabled:=False;
  Aboutinquire.Enabled:=False;
  print.Enabled:=False;
  cbName.Enabled := False;
end;


procedure TMainForm.SetCtrlLang(ID : Short);
begin
  if ID = 2052 then
  begin
    PortChoice.Caption := '端口选择';
    PortChoice.Items.Add('串口');
    PortChoice.Items.Add('网络接口');
    PortChoice.Items.Add('并口');
    PortChoice.Items.Add('驱动程序');
    PortChoice.Items.Add('USB口');
    PortChoice.Items.Add('USB Class');


    PortSet.Caption := '端口配置';
    Label1.Caption := '端口名称：';
    Label2.Caption := '每秒位数：';
    Label3.Caption := '数据位：';
    Label6.Caption := '并口名称：';
    Label7.Caption := 'IP地址：';
    Label9.Caption := '驱动名称：';
    Label5.Caption := '校验位：';
    Label4.Caption := '停止位：';
    Label8.Caption := '数据流控制：';

    ChkWrite.Caption := '数据保存到文件Test.txt,不向端口下发';
    OpenPort.Caption := '打开端口';
    Aboutinquire.Caption := '查询状态';
    Print.Caption := '打印';
    ClosePort.Caption := '关闭端口';

    GroupBox3.Caption := '示例设置';
    ModeSelect.Caption := '模式选择';
    ModeSelect.Items.Add('标准模式');
    ModeSelect.Items.Add('页模式');
    Label10.Caption := '页宽：';

    cbParity.Items.Add('无校验');
    cbParity.Items.Add('奇校验');
    cbParity.Items.Add('偶校验');
    cbFlow.Items.Add('XON/OFF');
    cbFlow.Items.Add('硬件');
    cbFlow.Items.Add('无');

  end
  else
  begin
    PortChoice.Caption := 'Port Option';
    PortChoice.Items.Add('SerialPort');
    PortChoice.Items.Add('Ethernet');
    PortChoice.Items.Add('ParallelPort');
    PortChoice.Items.Add('Driver');
    PortChoice.Items.Add('USB');
    PortChoice.Items.Add('USB Class');

    PortSet.Caption := 'Configuration';
    Label1.Caption := 'PortName:';
    Label2.Caption := 'BaudRate:';
    Label3.Caption := 'DataBits:';
    Label6.Caption := 'ParaName:';
    Label7.Caption := 'IP Addr:';
    Label9.Caption := 'DriverName:';
    Label5.Caption := 'Parity:';
    Label4.Caption := 'StopBits:';
    Label8.Caption := 'HandShake:';

    ChkWrite.Caption := 'Save data to Test.txt file, not to device';
    OpenPort.Caption := 'OpenPort';
    Aboutinquire.Caption := 'QueryStatus';
    Print.Caption := 'Print';
    ClosePort.Caption := 'ClosePort';
    GroupBox3.Caption := 'SampleSetting';
    ModeSelect.Caption := 'Mode';
    ModeSelect.Items.Add('Standard');
    ModeSelect.Items.Add('Page');
    Label10.Caption := 'PageWidth:';

    cbParity.Items.Add('None');
    cbParity.Items.Add('Odd');
    cbParity.Items.Add('Even');
    cbFlow.Items.Add('XON/OFF');
    cbFlow.Items.Add('Hardware');
    cbFlow.Items.Add('None');

  end;

  PortChoice.ItemIndex := 0;
  ModeSelect.ItemIndex := 0;

  cbParity.ItemIndex := 0;
  cbFlow.ItemIndex := 1;
end;

//端口关闭的操作----------------------------------------------------------------
//******************************************************************************
//调用版本说明函数，反应版本信息------------------------------------------------
procedure TMainForm.FormCreate(Sender: TObject);
var
    m_version,aaa : String;
    X,Y:integer;
    p1,p2:Pinteger;
begin
    langID := GetUserDefaultLangID();
    SetCtrlLang(langID); 
    p1:=@X;
    p2:=@Y;
    if langID = 2052 then
    begin
      m_version := Format('一切正常，版本号--%d',[POS_GetVersionInfo(@X,@Y)]);
      edQuery.Text :='一切正常，版本号V'+IntToStr(X)+'.'+IntToStr(Y);
    end
    else
    begin
      m_version := Format('All OK, version--%d',[POS_GetVersionInfo(@X,@Y)]);
      edQuery.Text :='All OK, version V'+IntToStr(X)+'.'+IntToStr(Y);
    end;

    cbLPT.Enabled:=False;
    edDrive.Enabled:=False;
    IP1.Enabled:=False;
    IP2.Enabled:=False;
    IP3.Enabled:=False;
    IP4.Enabled:=False;
    ClosePort.Enabled:=False;
    Print.Enabled:=False;
    cbName.Enabled := False;
end;
procedure TMainForm.FormResize(Sender: TObject);
begin

end;

//调用版本说明函数，反应版本信息------------------------------------------------
//******************************************************************************
//网络接口的输入操作------------------------------------------------------------
procedure TMainForm.IP1Change(Sender: TObject);
begin
if IP1.Text<>'' then
  begin
    if (StrToInt(IP1.Text)>255)or (StrToInt(IP1.Text)<0) then
    begin
     IP1.Text:='255';
    end;
  end;
end;

procedure TMainForm.IP1KeyPress(Sender: TObject; var Key: Char);
begin
  begin
  //选中的内容删除
    IP1.SetSelTextBuf('');
  //若输入‘'.',则输出焦点移动到下一个控件
  if(Key = '.') then
  begin
    IP2.SetFocus();
    Key :=  #0;
    Exit;
  end;
  if(length(IP1.Text) >= 3) and (Key <> #8) then
  begin
    Key := #0;
    MessageBeep(1);
    exit;
  end;
  if not (Key in ['0'..'9',#8]) then
  begin
    Key := #0;
    MessageBeep(1);
  end;
end;
end;

procedure TMainForm.IP2Change(Sender: TObject);
begin
  if IP2.Text<>'' then
  begin
    if (StrToInt(IP2.Text)>255)or (StrToInt(IP2.Text)<0) then
    begin
     IP2.Text:='255';
    end;
  end;
end;

procedure TMainForm.IP2KeyPress(Sender: TObject; var Key: Char);
begin
  begin
  //选中的内容删除
    IP2.SetSelTextBuf('');
  //若输入‘'.',则输出焦点移动到下一个控件
  if(Key = '.') then
  begin
    IP3.SetFocus();
    Key :=  #0;
    Exit;
  end;
  if(length(IP2.Text) >= 3) and (Key <> #8) then
  begin
    Key := #0;
    MessageBeep(1);
    exit;
  end;
  if not (Key in ['0'..'9',#8]) then
  begin
    Key := #0;
    MessageBeep(1);
  end;
end;

end;
procedure TMainForm.IP3Change(Sender: TObject);
begin
  if IP3.Text<>'' then
  begin
    if (StrToInt(IP3.Text)>255)or (StrToInt(IP3.Text)<0) then
    begin
     IP3.Text:='255';
    end;
  end;
end;

procedure TMainForm.IP3KeyPress(Sender: TObject; var Key: Char);
begin
  begin
  //选中的内容删除
    IP3.SetSelTextBuf('');
  //若输入‘'.',则输出焦点移动到下一个控件
  if(Key = '.') then
  begin
    IP4.SetFocus();
    Key :=  #0;
    Exit;
  end;
  if(length(IP3.Text) >= 3) and (Key <> #8) then
  begin
    Key := #0;
    MessageBeep(1);
    exit;
  end;
  if not (Key in ['0'..'9',#8]) then
  begin
    Key := #0;
    MessageBeep(1);
  end;
end;
end;
procedure TMainForm.IP4Change(Sender: TObject);
begin
  if IP4.Text<>'' then
  begin
    if (StrToInt(IP4.Text)>255)or (StrToInt(IP4.Text)<0) then
    begin
     IP4.Text:='255';
    end;
  end;
end;

procedure TMainForm.IP4KeyPress(Sender: TObject; var Key: Char);
begin
  begin
  //选中的内容删除
    IP4.SetSelTextBuf('');
  //若输入‘'.',则输出焦点移动到下一个控件
  if(Key = '.') then
  begin
    ChkWrite.SetFocus();
    Key :=  #0;
    Exit;
  end;
  if(length(IP4.Text) >= 3) and (Key <> #8) then
  begin
    Key := #0;
    MessageBeep(1);
    exit;
  end;
  if not (Key in ['0'..'9',#8]) then
  begin
    Key := #0;
    MessageBeep(1);
  end;
end;

end;

//网络接口的输入操作------------------------------------------------------------
//******************************************************************************
//打开端口操作过程打开所有端口的函数调用过程------------------------------------
procedure TMainForm.OpenPortClick(Sender: TObject);
var
  baudrate:integer;        //波特率
  portName : pchar;        //端口名称
  i_DriverData : pchar;   //加入的驱动
  I_cbData  : integer;    //数据位变量
  i_PrinterName : pchar;
begin
  if state > 0 then
  begin
    POS_Close();
    state := 0;
    ClosePort.Enabled:=False;
  end;
  if i_portIndex = 0 then          //串口操作
  begin
//将串品各个参数置为真
// 将其它端口参数置为不能用
    case cbPortName.ItemIndex of
      0: portName := 'COM1';
      1: portName := 'COM2';
      2: portName := 'COM3';
      3: portName := 'COM4';
      4: portName := 'COM5';
      5: portName := 'COM6';
      6: portName := 'COM7';
      7: portName := 'COM8';
      8: portName := 'COM9';
      9: portName := 'COM10';
    end;
    case cbBaud.ItemIndex of
      0: baudrate := 2400;
      1: baudrate := 4800;
      2: baudrate := 9600;
      3: baudrate := 19200;
      4: baudrate := 38400;
      5: baudrate := 57600;
      6: baudrate := 115200;
    end;
    case cbData.ItemIndex of
      0: I_cbData:=7;
      1: I_cbData:=8;
    end;
    state := POS_Open(portName, baudrate, I_cbData, POS_COM_ONESTOPBIT, cbParity.ItemIndex, cbFlow.ItemIndex);
//判断端口是否打开--------------------------------------------------------------
   { if state <> -1 then
    begin
      Print.Enabled := true;
      edQuery.Text := '打开端口成功！';
    end
    else
     begin
      Print.Enabled := true;
      edQuery.Text := '打开端口失败！';
    end }
//判断端口是否打开--------------------------------------------------------------
  end
  else if i_portIndex = 1 then  //网络接口操作输入IP从而来确定自身需要的操作
  begin
    if langID = 2052 then
    begin
      edQuery.Text:='选择了网络口';
    end
    else
    begin
      edQuery.Text:='Ethernet is selected';
    end;

    ipConst:=(IP1.Text+'.'+IP2.Text+'.'+IP3.Text+'.'+IP4.Text);
    if (IP1.Text='')or (IP2.Text='')or (IP3.Text='') or (IP4.Text='') then
  begin
    if langID = 2052 then
    begin
      edQuery.Text:='IP地址不能为空';
    end
    else
    begin
      edQuery.Text:='IP can not be null';
    end;

    exit;
  end;
    state := POS_Open(PChar(ipConst),0,0,0,0,$15);
  end
  else if i_portIndex =2  then  //并口操作此处只列举两个并口根据需要可以添加
  begin
     case cbLPT.ItemIndex of
       0:  portName:='LPT1';
       1:  portName:='LPT2';
     end;
    state := POS_Open(portName,0, 0,0,0,$12);
  end
  else if i_portIndex = 3 then  //驱动操作手动的输入已安装的打印机驱动
  begin
    if edDrive.Text='' then
    begin
      if langID = 2052 then
      begin
        edQuery.text:='驱动程序名不能为空！';
      end
      else
      begin
        edQuery.text:='Driver name can not be null!';
      end;

      exit;
    end;
    i_DriverData:=PAnsiChar(edDrive.Text);
  //state := POS_Open('BTP-2002CP(S)',0,0,0,0,$14); //当时默认操作的一个打印机驱动
    state := POS_Open(i_DriverData,0,0,0,0,$14);    //输入的驱动必须是已经存在的打印机
  end
  else if i_portIndex = 4 then  //网络接口操作输入IP从而来确定自身需要的操作
  begin
    if langID = 2052 then
    begin
      edQuery.Text:='选择了USB口';
    end
    else
    begin
      edQuery.Text:='USB port is selected';
    end;

    state := POS_Open('BYUSB-0', 0, 0, 0, 0, $13);  //USB接口操作
  end
  else
  begin
    i_PrinterName := PAnsiChar(cbName.Text);
    state := POS_Open(i_PrinterName, 0, 0, 0, 0, $16);  //USB接口操作
  end;

//判断端口是否打开--------------------------------------------------------------
   if state <> -1 then
    begin
      Print.Enabled := true;
      if langID = 2052 then
      begin
        edQuery.Text := '端口打开成功！';
      end
      else
      begin
        edQuery.Text := 'Open port success!';
      end;

      OpenPort.Enabled:=False;
      ClosePort.Enabled:=True;
      if i_portIndex =2 then
      begin
         Aboutinquire.Enabled:=False;
      end;
      if i_portIndex <>2 then
      begin
        Aboutinquire.Enabled:=true;
      end;
      Print.Enabled:=True;
      ClosePort.Enabled:=True;
    end
    else
     begin
      Print.Enabled := true;
      if langID = 2052 then
      begin
        edQuery.Text := '端口打开失败！';
      end
      else
      begin
        edQuery.Text := 'Open port failed!';
      end;

      Aboutinquire.Enabled:=False;
      Print.Enabled:=False;
      ClosePort.Enabled:=False;
    end;
//判断端口是否打开--------------------------------------------------------------

end;
//根据选择的不同来显示介面，根据端口选择的不同来显示介面信息--------------------
procedure TMainForm.PortChoiceClick(Sender: TObject);
var
  i,j : Integer;
  cPrinterNames: array[0..1024] of char;
  P:PChar;
begin
  if  state  > 0 then
  begin
    POS_Close();
    state := 0;
    OpenPort.Enabled:=true;
    ClosePort.Enabled:=False;
    Print.Enabled:=False;
    Aboutinquire.Enabled:=False;
  end;
  i_portIndex :=  PortChoice.ItemIndex;
  if i_portIndex = 0 then
  begin
    cbLPT.Enabled:=False;
    edDrive.Enabled:=False;
    IP1.Enabled:=False;
    IP2.Enabled:=False;
    IP3.Enabled:=False;
    IP4.Enabled:=False;
    cbPortName.Enabled:=true;
    cbData.Enabled:=true;
    cbBaud.Enabled:=True;
    cbStop.Enabled:=true;
    cbParity.Enabled:=true;
    cbFlow.Enabled:=True;
    cbName.Enabled := False;
    if langID = 2052 then
    begin
      edQuery.Text:='端口选择为串口';
    end
    else
    begin
      edQuery.Text:='Serial port is selected';
    end;

    //将串品各个参数置为真
    // 将其它端口参数置为不能用
  end
  else if i_portIndex = 1 then
  begin
    cbLPT.Enabled:=False;
    edDrive.Enabled:=False;
    IP1.Enabled:=true;
    IP2.Enabled:=true;
    IP3.Enabled:=true;
    IP4.Enabled:=true;
    cbPortName.Enabled:=False;
    cbData.Enabled:=False;
    cbBaud.Enabled:=False;
    cbStop.Enabled:=False;
    cbParity.Enabled:=False;
    cbFlow.Enabled:=False;
    cbName.Enabled := False;
    if langID = 2052 then
    begin
      edQuery.Text:='端口选择为网络接口';
    end
    else
    begin
      edQuery.Text:='Ethernet is selected';
    end;

  end
  else if i_portIndex =2  then
  begin
    if langID = 2052 then
    begin
      edQuery.Text:='端口选择为并口';
    end
    else
    begin
      edQuery.Text:='Parallel port is selected';
    end;

    cbLPT.Enabled:=True;
    edDrive.Enabled:=False;
    IP1.Enabled:=False;
    IP2.Enabled:=False;
    IP3.Enabled:=False;
    IP4.Enabled:=False;
    cbPortName.Enabled:=False;
    cbData.Enabled:=False;
    cbBaud.Enabled:=False;
    cbStop.Enabled:=False;
    cbParity.Enabled:=False;
    cbFlow.Enabled:=False;
    cbName.Enabled := False;
  end
  else if i_portIndex = 3 then
  begin
    if langID = 2052 then
    begin
      edQuery.Text:='端口选择为驱动程序';
    end
    else
    begin
      edQuery.Text:='Printer driver is selected';
    end;

    cbLPT.Enabled:=False;
    edDrive.Enabled:=True;
    IP1.Enabled:=False;
    IP2.Enabled:=False;
    IP3.Enabled:=False;
    IP4.Enabled:=False;
    cbPortName.Enabled:=False;
    cbData.Enabled:=False;
    cbBaud.Enabled:=False;
    cbStop.Enabled:=False;
    cbParity.Enabled:=False;
    cbFlow.Enabled:=False;
    cbName.Enabled := False;
  end
  else if i_portIndex = 4 then
  begin
    if langID = 2052 then
    begin
      edQuery.Text:='端口选择为USB口';
    end
    else
    begin
      edQuery.Text:='USB port is selected';
    end;

    cbLPT.Enabled:=False;
    edDrive.Enabled:=False;
    IP1.Enabled:=False;
    IP2.Enabled:=False;
    IP3.Enabled:=False;
    IP4.Enabled:=False;
    cbPortName.Enabled:=False;
    cbData.Enabled:=False;
    cbBaud.Enabled:=False;
    cbStop.Enabled:=False;
    cbParity.Enabled:=False;
    cbFlow.Enabled:=False;
    cbName.Enabled := False;
  end
  else
  begin
    if langID = 2052 then
    begin
      edQuery.Text:='端口选择为USB 类模式';
    end
    else
    begin
      edQuery.Text:='USB class is selected';
    end;

    cbLPT.Enabled:=False;
    edDrive.Enabled:=False;
    IP1.Enabled:=False;
    IP2.Enabled:=False;
    IP3.Enabled:=False;
    IP4.Enabled:=False;
    cbPortName.Enabled:=False;
    cbData.Enabled:=False;
    cbBaud.Enabled:=False;
    cbStop.Enabled:=False;
    cbParity.Enabled:=False;
    cbFlow.Enabled:=False;
    cbName.Enabled := True;

    cPrinterNames:='';
    i := POS_EnumUSBPrinter(cPrinterNames);
    if i<=0 then
    exit;

    for j := 0 to sizeof(cPrinterNames) - 1 do
    begin
      if cPrinterNames[j] = '@' then
      cPrinterNames[j] := #$0;
    end;

    p := cPrinterNames;
    for j := 0 to i - 1 do
    begin
      cbName.Items.Add(P);
      P := P + strlen(P);
      P := P + 1;
    end;

    cbName.ItemIndex := 0;

  end;
end;
//根据选择的不同来显示介面，根据端口选择的不同来显示介面信息--------------------
//******************************************************************************
//打印的具体操作----------------------------------------------------------------
procedure TMainForm.PrintClick(Sender: TObject);
var
    printwidth: integer;
    printtype :integer;
    //驱动中的变量----------------------------
    {DocInfo:DOC_INFO_1;
    hport : Thandle;
    i: Integer;
    buf : array[1..50] of char;
    dwBytesWritten :DWORD;     }
    //驱动中的变量-----------------------------
begin
    if ChkWrite.Checked  then
      begin
       POS_BeginSaveFile(PAnsiChar(ExtractFilePath(paramstr(0))+'Test.txt'),false);
      end;
    printtype := ModeSelect.ItemIndex;
    printwidth := pagewide.ItemIndex;
    if i_portIndex =  3 then
      begin
        POS_StartDoc();
      end;
    if printtype = 0 then
      begin
        if printwidth = 0 then
          PrintInStandardMode80()
        else   PrintInStandardMode56();
      end
    else
    begin
      if printwidth = 0 then
         PrintInPageMode80()
      else
         PrintInPageMode56();
    end;
   if i_portIndex=3 then
      begin
         if POS_EndDoc()=true then
          begin
            if langID = 2052 then
            begin
              edQuery.Text:='打印成功！';
            end
            else
            begin
              edQuery.Text:='Print success!';
            end;
          end;
   {if ChkWrite.Checked  then
      begin
        POS_EndSaveFile();
      end;    }
  end;
	 { DocInfo.pDocName := 'My Document';
    DocInfo.pOutputFile := nil;
    DocInfo.pDatatype := 'RAW';
    OpenPrinter('BTP-2002CP(S)',hport,Nil);
    StartDocPrinter(hPort, 1, @DocInfo);
    for i := 1 to 50 do
    begin
      buf[i] := #$32;
    end;
    buf[50] := #$0a;
    dwBytesWritten := 0;
    WritePrinter(hPort,@buf,50,dwBytesWritten);
    EndDocPrinter(hPort);
   end; } //此处为通过下发指令来令打印机通过驱动打印出所需的样张

end;

end.
//打印的具体操作----------------------------------------------------------------
