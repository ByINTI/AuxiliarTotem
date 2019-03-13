unit iotst;

//====================================================
//==
//==
//==
//==
//==
//==
//==
//==
//==
//==
//==
//==
//====================================================

interface

Uses Windows,D2XXUNIT;

Type
  Names = Array[1..20] of string;
  Names_Ptr = ^Names;

// Exported Functions

function HexWrdToStr(Dval : integer) : string;

function HexDWrdToStr(Dval : longword) : string;

function HexByteToStr(Dval : integer) : string;

procedure List_Devs( My_Names_Ptr : Names_Ptr);

function write_value(enable,data : byte;DName : String) : boolean;

function read_value(var data : byte;DName : String) : boolean;

Var
  Saved_Handle: DWord;
  PortAIsOpen : boolean;

const USBBuffSize : integer = $4000;


implementation


function HexWrdToStr(Dval : integer) : string;
var i : integer;
retstr : string;
begin
retstr := '';
i := (Dval AND $F000) DIV $1000;
case i of
  0 : retstr := retstr + '0';
  1 : retstr := retstr + '1';
  2 : retstr := retstr + '2';
  3 : retstr := retstr + '3';
  4 : retstr := retstr + '4';
  5 : retstr := retstr + '5';
  6 : retstr := retstr + '6';
  7 : retstr := retstr + '7';
  8 : retstr := retstr + '8';
  9 : retstr := retstr + '9';
  10 : retstr := retstr + 'A';
  11 : retstr := retstr + 'B';
  12 : retstr := retstr + 'C';
  13 : retstr := retstr + 'D';
  14 : retstr := retstr + 'E';
  15 : retstr := retstr + 'F';
end;
i := (Dval AND $F00) DIV $100;
case i of
  0 : retstr := retstr + '0';
  1 : retstr := retstr + '1';
  2 : retstr := retstr + '2';
  3 : retstr := retstr + '3';
  4 : retstr := retstr + '4';
  5 : retstr := retstr + '5';
  6 : retstr := retstr + '6';
  7 : retstr := retstr + '7';
  8 : retstr := retstr + '8';
  9 : retstr := retstr + '9';
  10 : retstr := retstr + 'A';
  11 : retstr := retstr + 'B';
  12 : retstr := retstr + 'C';
  13 : retstr := retstr + 'D';
  14 : retstr := retstr + 'E';
  15 : retstr := retstr + 'F';
end;
i := (Dval AND $F0) DIV $10;
case i of
  0 : retstr := retstr + '0';
  1 : retstr := retstr + '1';
  2 : retstr := retstr + '2';
  3 : retstr := retstr + '3';
  4 : retstr := retstr + '4';
  5 : retstr := retstr + '5';
  6 : retstr := retstr + '6';
  7 : retstr := retstr + '7';
  8 : retstr := retstr + '8';
  9 : retstr := retstr + '9';
  10 : retstr := retstr + 'A';
  11 : retstr := retstr + 'B';
  12 : retstr := retstr + 'C';
  13 : retstr := retstr + 'D';
  14 : retstr := retstr + 'E';
  15 : retstr := retstr + 'F';
end;
i := Dval AND $F;
case i of
  0 : retstr := retstr + '0';
  1 : retstr := retstr + '1';
  2 : retstr := retstr + '2';
  3 : retstr := retstr + '3';
  4 : retstr := retstr + '4';
  5 : retstr := retstr + '5';
  6 : retstr := retstr + '6';
  7 : retstr := retstr + '7';
  8 : retstr := retstr + '8';
  9 : retstr := retstr + '9';
  10 : retstr := retstr + 'A';
  11 : retstr := retstr + 'B';
  12 : retstr := retstr + 'C';
  13 : retstr := retstr + 'D';
  14 : retstr := retstr + 'E';
  15 : retstr := retstr + 'F';
end;
HexWrdToStr := retstr;
end;

function HexDWrdToStr(Dval : longword) : string;
var i : longword;
tmpstr : string;
begin
i := Dval div $10000;
tmpstr := HexWrdToStr(i);
i := Dval AND $ffff;
tmpstr := tmpstr + HexWrdToStr(i);
HexDWrdToStr := tmpstr;
end;

function HexByteToStr(Dval : integer) : string;
var i : integer;
retstr : string;
begin
retstr := '';
i := (Dval AND $F0) DIV $10;
case i of
  0 : retstr := retstr + '0';
  1 : retstr := retstr + '1';
  2 : retstr := retstr + '2';
  3 : retstr := retstr + '3';
  4 : retstr := retstr + '4';
  5 : retstr := retstr + '5';
  6 : retstr := retstr + '6';
  7 : retstr := retstr + '7';
  8 : retstr := retstr + '8';
  9 : retstr := retstr + '9';
  10 : retstr := retstr + 'A';
  11 : retstr := retstr + 'B';
  12 : retstr := retstr + 'C';
  13 : retstr := retstr + 'D';
  14 : retstr := retstr + 'E';
  15 : retstr := retstr + 'F';
end;
i := Dval AND $F;
case i of
  0 : retstr := retstr + '0';
  1 : retstr := retstr + '1';
  2 : retstr := retstr + '2';
  3 : retstr := retstr + '3';
  4 : retstr := retstr + '4';
  5 : retstr := retstr + '5';
  6 : retstr := retstr + '6';
  7 : retstr := retstr + '7';
  8 : retstr := retstr + '8';
  9 : retstr := retstr + '9';
  10 : retstr := retstr + 'A';
  11 : retstr := retstr + 'B';
  12 : retstr := retstr + 'C';
  13 : retstr := retstr + 'D';
  14 : retstr := retstr + 'E';
  15 : retstr := retstr + 'F';
end;
HexByteToStr := retstr;
end;

function OpenPort(PortName : string) : boolean;
Var res : FT_Result;
NoOfDevs,i,J : integer;
Name : String;
DualName : string;
done : boolean;
begin
PortAIsOpen := False;
OpenPort := False;
Name := '';
Dualname := PortName;
res := GetFTDeviceCount;
if res <> Ft_OK then exit;
NoOfDevs := FT_Device_Count;
j := 0;
if NoOfDevs > 0 then
  begin
    repeat
      repeat
      res := GetFTDeviceDescription(J);
      if (res <> Ft_OK) then  J := J + 1;
      until (res = Ft_OK) OR (J=NoOfDevs);
    if res <> Ft_OK then exit;
    done := false;
    i := 1;
 //   Name := '';
 //     repeat
 //     if ORD(FT_Device_String_Buffer[i]) <> 0 then
 //       begin
        Name := FT_Device_String;
        //Name := Name + FT_Device_String_Buffer[i];
 //       end
 //     else
 //       begin
 //       done := true;
 //       end;
 //     i := i + 1;
 //     until done;
    J := J + 1;
    until (J = NoOfDevs) or (name = DualName);
  end;

if (name = DualName) then
  begin
  res := Open_USB_Device_By_Device_Description(name);
  if res <> Ft_OK then exit;
  OpenPort := true;
  res := Get_USB_Device_QueueStatus;
  if res <> Ft_OK then exit;
  PortAIsOpen := true;
  end
else
  begin
  OpenPort := false;
  end;

end;


procedure List_Devs( My_Names_Ptr : Names_Ptr);
Var res : FT_Result;
NoOfDevs,i,J,k : integer;
Name : String;
done : boolean;
begin
PortAIsOpen := False;
Name := '';
res := GetFTDeviceCount;
if res <> Ft_OK then exit;
NoOfDevs := FT_Device_Count;
j := 0;
k := 1;
if NoOfDevs > 0 then
  begin
    repeat
    res := GetFTDeviceDescription(J);
   if res = Ft_OK then
      begin
      My_Names_Ptr[k]:= FT_Device_String;
      k := k + 1;
      end;
    J := J + 1;
    until (J = NoOfDevs);
  end;

end;


procedure ClosePort;
Var res : FT_Result;
begin
if PortAIsOpen then
  res := Close_USB_Device;
PortAIsOpen := False;
end;


function Init_Controller(DName : String) : boolean;
var passed : boolean;
res : FT_Result;
begin
Init_Controller := false;
passed := OpenPort(DName);
if passed then
  begin
  res := Set_USB_Device_LatencyTimer(16);
  if (res = FT_OK) then Init_Controller := true;
  end;
end;

function write_value(enable,data : byte;DName : String) : boolean;
var passed : boolean;
tmpval : byte;
res : FT_Result;
begin
write_value := false;
passed := Init_Controller(DName);
if passed then
  begin
  tmpval := data AND $F;
  tmpval := tmpval OR ((enable AND $F) * 16);
  res := Set_USB_Device_BitMode(tmpval,$20); // enable CBitBang
  if (res = FT_OK) then write_value := true;
  closeport;
  end;

end;


function read_value(var data : byte;DName : String) : boolean;
var passed : boolean;
tmpval : byte;
res : FT_Result;
begin
read_value := false;
passed := Init_Controller(DName);
if passed then
  begin
  res := Get_USB_Device_BitMode(data);
  if (res = FT_OK) then read_value := true;
  closeport;
  end;
end;


end.
