unit StatusThread;

interface

uses
  Classes {$IFDEF MSWINDOWS} , Windows {$ENDIF},KIOSKDLLDEMO,LoadDLL,SysUtils ;

type
  TStatusThread = class(TThread)
  private
    procedure SetName;
  protected
    procedure Execute; override;
  end;

implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TStatusThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{$IFDEF MSWINDOWS}
type
  TThreadNameInfo = record
    FType: LongWord;     // must be 0x1000
    FName: PChar;        // pointer to name (in user address space)
    FThreadID: LongWord; // thread ID (-1 indicates caller thread)
    FFlags: LongWord;    // reserved for future use, must be zero
  end;

type    Tbuffer = array of byte;

{$ENDIF}

{ TStatusThread }

procedure TStatusThread.SetName;
{$IFDEF MSWINDOWS}
var
  ThreadNameInfo: TThreadNameInfo;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  ThreadNameInfo.FType := $1000;
  ThreadNameInfo.FName := 'StatusMonitor';
  ThreadNameInfo.FThreadID := $FFFFFFFF;
  ThreadNameInfo.FFlags := 0;

  try
    RaiseException( $406D1388, 0, sizeof(ThreadNameInfo) div sizeof(LongWord), @ThreadNameInfo );
  except
  end;
{$ENDIF}
end;

procedure TStatusThread.Execute;
var
  buffer: Tbuffer;
  //temp: string;
begin
  SetName;
  { Place thread code here }
  //SetLength( buffer, 4 );
  if KIOSK_QueryASB( state, nPortType,1 ) <> KIOSK_SUCCESS then
  begin
    ThreadRunning := false;
  end;
  while ThreadRunning do
  begin
    SetLength( buffer, 4 );
    if nPortType = 0 then
    begin
      if KIOSK_ReadData( state, nPortType, 0, pchar( buffer ), 4 ) = KIOSK_SUCCESS then
      begin
        MainForm.StatusMonitor.SelText := Format('%0.2x %0.2x %0.2x %0.2x',[buffer[0],buffer[1],buffer[2],buffer[3]] );
        MainForm.StatusMonitor.SelText := #13#10;
      end;
    end;
    if nPortType = 2 then
    begin
      if KIOSK_ReadData( state, nPortType, 1, pchar( buffer ), 4 ) = KIOSK_SUCCESS then
      begin
        MainForm.StatusMonitor.SelText := Format('%0.2x %0.2x %0.2x %0.2x',[buffer[0],buffer[1],buffer[2],buffer[3]] );
        MainForm.StatusMonitor.SelText := #13#10;
      end;
    end;
    Sleep( 1000 );
    buffer := nil;
  end;
  KIOSK_QueryASB( state, nPortType, 0 );
end;
end.
