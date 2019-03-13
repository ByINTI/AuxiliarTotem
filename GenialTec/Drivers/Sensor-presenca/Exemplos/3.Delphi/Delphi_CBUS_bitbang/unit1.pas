unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, d2xxunit,iotst;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Memo1: TMemo;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel4: TPanel;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Panel3: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Panel5: TPanel;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Panel6: TPanel;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    Panel7: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure ComboBox1DropDown(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  My_Names : Names;

implementation

{$R *.dfm}


procedure GetNames;
Var i : integer;
Has_A : boolean;
begin
for i := 1 to 20 do My_Names[i] := '';
Form1.ComboBox1.Clear;
List_Devs(@My_Names);
i := 1;
if (My_Names[i] <> '' ) then
  begin
    repeat
    Form1.ComboBox1.Items.Add(My_Names[i]);
    i := i + 1;
    until (My_Names[i] = '');
  end;
end;



procedure TForm1.ComboBox1DropDown(Sender: TObject);
begin
GetNames;
end;

procedure TForm1.Button1Click(Sender: TObject);
var passed : boolean;
DName : string;
enable,data : byte;
begin
DName := form1.ComboBox1.Text;
if (DName <> '') then
  begin
  enable := 0;
  if form1.CheckBox1.Checked then enable := enable or $1;
  if form1.CheckBox2.Checked then enable := enable or $2;
  if form1.CheckBox3.Checked then enable := enable or $4;
  if form1.CheckBox4.Checked then enable := enable or $8;
  data := 0;
  if form1.RadioButton2.Checked then data := data or $1;
  if form1.RadioButton4.Checked then data := data or $2;
  if form1.RadioButton6.Checked then data := data or $4;
  if form1.RadioButton8.Checked then data := data or $8;
  passed := write_value(enable,data,DName);
  if passed then
    form1.Memo1.Lines.Add('Write All - Success')
  else
    form1.Memo1.Lines.Add('Write All - Failed');
  end
else
  begin
  form1.Memo1.Lines.Add('You must select an FT232R device');
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var passed : boolean;
DName : string;
data : byte;
begin
DName := form1.ComboBox1.Text;
if (DName <> '') then
  begin
  data := 0;
  passed := read_value(data,DName);
  if passed then
    begin
    form1.Memo1.Lines.Add('Read - Success');
    if (data AND 1) <> 0 then
      begin
      form1.Label10.Caption := 'High';
      form1.Label10.Font.Color := clRed;
      end
    else
      begin
      form1.Label10.Caption := 'Low';
      form1.Label10.Font.Color := clGreen;
      end;
    if (data AND 2) <> 0 then
      begin
      form1.Label11.Caption := 'High';
      form1.Label11.Font.Color := clRed;
      end
    else
      begin
      form1.Label11.Caption := 'Low';
      form1.Label11.Font.Color := clGreen;
      end;
    if (data AND 4) <> 0 then
      begin
      form1.Label12.Caption := 'High';
      form1.Label12.Font.Color := clRed;
      end
    else
      begin
      form1.Label12.Caption := 'Low';
      form1.Label12.Font.Color := clGreen;
      end;
    if (data AND 8) <> 0 then
      begin
      form1.Label13.Caption := 'High';
      form1.Label13.Font.Color := clRed;
      end
    else
      begin
      form1.Label13.Caption := 'Low';
      form1.Label13.Font.Color := clGreen;
      end;
    end
  else
    begin
    form1.Memo1.Lines.Add('Read - Failed');
    form1.Label10.Caption := 'Unknown';
    form1.Label10.Font.Color := clBlue;
    form1.Label11.Caption := 'Unknown';
    form1.Label11.Font.Color := clBlue;
    form1.Label12.Caption := 'Unknown';
    form1.Label12.Font.Color := clBlue;
    form1.Label13.Caption := 'Unknown';
    form1.Label13.Font.Color := clBlue;
    end;
  end
else
  begin
  form1.Memo1.Lines.Add('You must select an FT232R device');
  form1.Label10.Caption := 'Unknown';
  form1.Label10.Font.Color := clBlue;
  form1.Label11.Caption := 'Unknown';
  form1.Label11.Font.Color := clBlue;
  form1.Label12.Caption := 'Unknown';
  form1.Label12.Font.Color := clBlue;
  form1.Label13.Caption := 'Unknown';
  form1.Label13.Font.Color := clBlue;
  end;


end;

end.
