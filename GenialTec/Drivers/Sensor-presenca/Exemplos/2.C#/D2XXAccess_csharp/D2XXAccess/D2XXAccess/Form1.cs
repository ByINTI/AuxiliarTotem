using System;
using System.Drawing;
using System.Collections;
using System.Windows.Forms;
using System.Data;
using System.Threading;
using System.Runtime.InteropServices;

using FT_HANDLE=System.UInt32;

namespace D2XXAccess
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class D2XXAccess : System.Windows.Forms.Form
	{
		enum FT_STATUS//:Uint32
		{
			FT_OK = 0,
			FT_INVALID_HANDLE,
			FT_DEVICE_NOT_FOUND,
			FT_DEVICE_NOT_OPENED,
			FT_IO_ERROR,
			FT_INSUFFICIENT_RESOURCES,
			FT_INVALID_PARAMETER,
			FT_INVALID_BAUD_RATE,
			FT_DEVICE_NOT_OPENED_FOR_ERASE,
			FT_DEVICE_NOT_OPENED_FOR_WRITE,
			FT_FAILED_TO_WRITE_DEVICE,
			FT_EEPROM_READ_FAILED,
			FT_EEPROM_WRITE_FAILED,
			FT_EEPROM_ERASE_FAILED,
			FT_EEPROM_NOT_PRESENT,
			FT_EEPROM_NOT_PROGRAMMED,
			FT_INVALID_ARGS,
			FT_OTHER_ERROR
		};

		public const UInt32 FT_BAUD_300 = 300;
		public const UInt32 FT_BAUD_600 = 600;
		public const UInt32 FT_BAUD_1200 = 1200;
		public const UInt32 FT_BAUD_2400 = 2400;
		public const UInt32 FT_BAUD_4800 = 4800;
		public const UInt32 FT_BAUD_9600 = 9600;
		public const UInt32 FT_BAUD_14400 = 14400;
		public const UInt32 FT_BAUD_19200 = 19200;
		public const UInt32 FT_BAUD_38400 = 38400;
		public const UInt32 FT_BAUD_57600 = 57600;
		public const UInt32 FT_BAUD_115200 = 115200;
		public const UInt32 FT_BAUD_230400 = 230400;
		public const UInt32 FT_BAUD_460800 = 460800;
		public const UInt32 FT_BAUD_921600 = 921600;

		public const UInt32 FT_LIST_NUMBER_ONLY = 0x80000000;
		public const UInt32 FT_LIST_BY_INDEX	= 0x40000000;
		public const UInt32 FT_LIST_ALL			= 0x20000000;
		public const UInt32 FT_OPEN_BY_SERIAL_NUMBER = 1;
		public const UInt32 FT_OPEN_BY_DESCRIPTION    = 2;

		// Word Lengths
		public const byte FT_BITS_8 = 8;
		public const byte FT_BITS_7 = 7;
		public const byte FT_BITS_6 = 6;
		public const byte FT_BITS_5 = 5;

		// Stop Bits
		public const byte FT_STOP_BITS_1 = 0;
		public const byte FT_STOP_BITS_1_5 = 1;
		public const byte FT_STOP_BITS_2 = 2;

		// Parity
		public const byte FT_PARITY_NONE = 0;
		public const byte FT_PARITY_ODD = 1;
		public const byte FT_PARITY_EVEN = 2;
		public const byte FT_PARITY_MARK = 3;
		public const byte FT_PARITY_SPACE = 4;

		// Flow Control
		public const UInt16 FT_FLOW_NONE = 0;
		public const UInt16 FT_FLOW_RTS_CTS = 0x0100;
		public const UInt16 FT_FLOW_DTR_DSR = 0x0200;
		public const UInt16 FT_FLOW_XON_XOFF = 0x0400;

		// Purge rx and tx buffers
		public const byte FT_PURGE_RX = 1;
		public const byte FT_PURGE_TX = 2;

		// Events
		public const UInt32 FT_EVENT_RXCHAR = 1;
		public const UInt32 FT_EVENT_MODEM_STATUS = 2;

		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_ListDevices(void * pvArg1, void * pvArg2, UInt32 dwFlags);	// FT_ListDevices by number only
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_ListDevices(UInt32 pvArg1, void * pvArg2, UInt32 dwFlags);	// FT_ListDevcies by serial number or description by index only
		[DllImport("FTD2XX.dll")]
		static extern FT_STATUS FT_Open(UInt32 uiPort, ref FT_HANDLE ftHandle);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_OpenEx(void * pvArg1, UInt32 dwFlags, ref FT_HANDLE ftHandle);
		[DllImport("FTD2XX.dll")]
		static extern FT_STATUS FT_Close(FT_HANDLE ftHandle);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_Read(FT_HANDLE ftHandle, void * lpBuffer, UInt32 dwBytesToRead, ref UInt32 lpdwBytesReturned);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_Write(FT_HANDLE ftHandle, void * lpBuffer, UInt32 dwBytesToRead, ref UInt32 lpdwBytesWritten);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetBaudRate(FT_HANDLE ftHandle, UInt32 dwBaudRate);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetDataCharacteristics(FT_HANDLE ftHandle, byte uWordLength, byte uStopBits, byte uParity);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetFlowControl(FT_HANDLE ftHandle, char usFlowControl, byte uXon, byte uXoff);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetDtr(FT_HANDLE ftHandle);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_ClrDtr(FT_HANDLE ftHandle);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetRts(FT_HANDLE ftHandle);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_ClrRts(FT_HANDLE ftHandle);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_GetModemStatus(FT_HANDLE ftHandle, ref UInt32 lpdwModemStatus);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetChars(FT_HANDLE ftHandle, byte uEventCh, byte uEventChEn, byte uErrorCh, byte uErrorChEn);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_Purge(FT_HANDLE ftHandle, UInt32 dwMask);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetTimeouts(FT_HANDLE ftHandle, UInt32 dwReadTimeout, UInt32 dwWriteTimeout);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_GetQueueStatus(FT_HANDLE ftHandle, ref UInt32 lpdwAmountInRxQueue);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetBreakOn(FT_HANDLE ftHandle);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetBreakOff(FT_HANDLE ftHandle);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_GetStatus(FT_HANDLE ftHandle, ref UInt32 lpdwAmountInRxQueue, ref UInt32 lpdwAmountInTxQueue, ref UInt32 lpdwEventStatus);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetEventNotification(FT_HANDLE ftHandle, UInt32 dwEventMask, void * pvArg);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_ResetDevice(FT_HANDLE ftHandle);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetDivisor(FT_HANDLE ftHandle, char usDivisor);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_GetLatencyTimer(FT_HANDLE ftHandle, ref byte pucTimer);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetLatencyTimer(FT_HANDLE ftHandle, byte ucTimer);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_GetBitMode(FT_HANDLE ftHandle, ref byte pucMode);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetBitMode(FT_HANDLE ftHandle, byte ucMask, byte ucEnable);
		[DllImport("FTD2XX.dll")]
		static extern unsafe FT_STATUS FT_SetUSBParameters(FT_HANDLE ftHandle, UInt32 dwInTransferSize, UInt32 dwOutTransferSize);

		private System.Windows.Forms.RadioButton radDescription;
		private System.Windows.Forms.RadioButton radNumber;
		private System.Windows.Forms.Button btnOpen;
		private System.Windows.Forms.Button btnClose;
		private System.Windows.Forms.Button btnWrite;
		private System.Windows.Forms.TextBox tbNumBytes;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.ListBox lbDataBytes;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.ComboBox cmbDevList;
		private System.Windows.Forms.RadioButton radSerial;

		protected UInt32 dwListDescFlags;
		protected UInt32 m_hPort;
		protected Thread pThreadRead;
		protected Thread pThreadWrite;
		protected bool fContinue;
	
		public D2XXAccess()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			base.Dispose( disposing );
		}
		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.radDescription = new System.Windows.Forms.RadioButton();
			this.radSerial = new System.Windows.Forms.RadioButton();
			this.radNumber = new System.Windows.Forms.RadioButton();
			this.cmbDevList = new System.Windows.Forms.ComboBox();
			this.btnOpen = new System.Windows.Forms.Button();
			this.btnClose = new System.Windows.Forms.Button();
			this.btnWrite = new System.Windows.Forms.Button();
			this.tbNumBytes = new System.Windows.Forms.TextBox();
			this.label1 = new System.Windows.Forms.Label();
			this.lbDataBytes = new System.Windows.Forms.ListBox();
			this.label2 = new System.Windows.Forms.Label();
			// 
			// radDescription
			// 
			this.radDescription.Location = new System.Drawing.Point(6, 2);
			this.radDescription.Size = new System.Drawing.Size(79, 15);
			this.radDescription.Text = "Description";
			this.radDescription.CheckedChanged += new System.EventHandler(this.radDescription_CheckedChanged);
			// 
			// radSerial
			// 
			this.radSerial.Location = new System.Drawing.Point(90, 2);
			this.radSerial.Size = new System.Drawing.Size(51, 15);
			this.radSerial.Text = "Serial";
			this.radSerial.CheckedChanged += new System.EventHandler(this.radSerial_CheckedChanged);
			// 
			// radNumber
			// 
			this.radNumber.Location = new System.Drawing.Point(143, 2);
			this.radNumber.Size = new System.Drawing.Size(67, 15);
			this.radNumber.Text = "Number";
			this.radNumber.CheckedChanged += new System.EventHandler(this.radNumber_CheckedChanged);
			// 
			// cmbDevList
			// 
			this.cmbDevList.Location = new System.Drawing.Point(6, 24);
			this.cmbDevList.Size = new System.Drawing.Size(127, 21);
			// 
			// btnOpen
			// 
			this.btnOpen.Location = new System.Drawing.Point(149, 27);
			this.btnOpen.Size = new System.Drawing.Size(52, 18);
			this.btnOpen.Text = "Open";
			this.btnOpen.Click += new System.EventHandler(this.btnOpen_Click);
			// 
			// btnClose
			// 
			this.btnClose.Location = new System.Drawing.Point(149, 46);
			this.btnClose.Size = new System.Drawing.Size(52, 18);
			this.btnClose.Text = "Close";
			this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
			// 
			// btnWrite
			// 
			this.btnWrite.Location = new System.Drawing.Point(7, 55);
			this.btnWrite.Size = new System.Drawing.Size(52, 18);
			this.btnWrite.Text = "Write";
			this.btnWrite.Click += new System.EventHandler(this.btnWrite_Click);
			// 
			// tbNumBytes
			// 
			this.tbNumBytes.Location = new System.Drawing.Point(66, 55);
			this.tbNumBytes.Size = new System.Drawing.Size(32, 20);
			this.tbNumBytes.Text = "255";
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(104, 58);
			this.label1.Size = new System.Drawing.Size(37, 14);
			this.label1.Text = "Bytes";
			// 
			// lbDataBytes
			// 
			this.lbDataBytes.Location = new System.Drawing.Point(6, 81);
			this.lbDataBytes.Size = new System.Drawing.Size(87, 132);
			// 
			// label2
			// 
			this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8F, System.Drawing.FontStyle.Regular);
			this.label2.Location = new System.Drawing.Point(106, 85);
			this.label2.Size = new System.Drawing.Size(96, 103);
			this.label2.Text = "Use Loopback Serial Cable to test application. Write upto 256 rolling count bytes" +
				" to port and display results in List.";
			// 
			// D2XXAccess
			// 
			this.ClientSize = new System.Drawing.Size(214, 221);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.lbDataBytes);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.tbNumBytes);
			this.Controls.Add(this.btnWrite);
			this.Controls.Add(this.btnClose);
			this.Controls.Add(this.btnOpen);
			this.Controls.Add(this.cmbDevList);
			this.Controls.Add(this.radNumber);
			this.Controls.Add(this.radSerial);
			this.Controls.Add(this.radDescription);
			this.Text = "D2XXAccess";
			this.Load += new System.EventHandler(this.D2XXAccess_Load);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>

		static void Main() 
		{
			Application.Run(new D2XXAccess());
		}

		private unsafe void ReadThread()
		{
			byte[] cBuf=new Byte[1];
			UInt32 dwRet = 0;
			FT_STATUS ftStatus = D2XXAccess.FT_STATUS.FT_OTHER_ERROR;

			while (fContinue == true)
			{
				if(m_hPort == 0) 
				{
					return;
				}
				fixed(byte *pBuf = cBuf)
				{
					ftStatus = FT_Read(m_hPort, pBuf, 1, ref dwRet);
				}

				if(dwRet == 1) 
				{
					lbDataBytes.Items.Add(BitConverter.ToString(cBuf, 0, 1));
				}
			}
		}
			
		private unsafe void btnOpen_Click(object sender, System.EventArgs e)
		{
			UInt32 dwOpenFlag;
			uint uiCurrentIndex;
			FT_STATUS ftStatus = D2XXAccess.FT_STATUS.FT_OTHER_ERROR;

			if (m_hPort == 0)
			{
				dwOpenFlag = dwListDescFlags & ~FT_LIST_BY_INDEX;
				dwOpenFlag = dwListDescFlags & ~FT_LIST_ALL;

				if (dwOpenFlag == 0)
				{
					uiCurrentIndex = (uint)cmbDevList.SelectedIndex;
					ftStatus = FT_Open(uiCurrentIndex, ref m_hPort);
				}
				else 
				{
					System.Text.ASCIIEncoding enc = new System.Text.ASCIIEncoding();
					byte[] sDevName = enc.GetBytes(cmbDevList.Text);
					fixed(byte *pBuf = sDevName)
					{
						ftStatus = FT_OpenEx(pBuf, dwOpenFlag, ref m_hPort);
					}
				}
			}

			if (ftStatus == D2XXAccess.FT_STATUS.FT_OK) 
			{
				// Set up the port
				FT_SetBaudRate(m_hPort, 9600);
				FT_Purge(m_hPort, FT_PURGE_RX | FT_PURGE_TX);
				FT_SetTimeouts(m_hPort, 3000, 3000);
				// Start up the read and write thread
				fContinue = true;
				pThreadRead = new Thread(new ThreadStart(ReadThread));
				pThreadRead.Start();
				// Enable buttons that can be pressed
				btnClose.Enabled = true;
				btnOpen.Enabled = false;
				btnWrite.Enabled = true;
				radDescription.Enabled = false;
				radSerial.Enabled = false;
				radNumber.Enabled = false;
			}
			else 
			{
				MessageBox.Show("Failed To Open Port" + Convert.ToString(ftStatus));
			}
		}

		private unsafe bool ListUnopenDevices()
		{
			FT_STATUS ftStatus = D2XXAccess.FT_STATUS.FT_OTHER_ERROR;
			UInt32 numDevs;
			int i;
			byte[] sDevName = new byte[64];
			int iCurrentIndex;
			void * p1;

			iCurrentIndex = cmbDevList.SelectedIndex;
			cmbDevList.Items.Clear();

			p1 = (void*)&numDevs;
			ftStatus = FT_ListDevices(p1, null, FT_LIST_NUMBER_ONLY);

			if(ftStatus == D2XXAccess.FT_STATUS.FT_OK) 
			{
				if (dwListDescFlags == FT_LIST_ALL) 
				{
					for (i = 0; i < numDevs ; i++) 
					{
						cmbDevList.Items.Add(i);
					}
				}
				else 
				{
					for (i = 0; i < numDevs ; i++) 
					{
						fixed(byte *pBuf = sDevName)
						{
							ftStatus = FT_ListDevices((UInt32)i, pBuf, dwListDescFlags);
							if (ftStatus == D2XXAccess.FT_STATUS.FT_OK)
							{
								string str;
								System.Text.ASCIIEncoding enc = new System.Text.ASCIIEncoding();
								str = enc.GetString(sDevName, 0, sDevName.Length);
								cmbDevList.Items.Add(str);
							}
							else
							{
								MessageBox.Show("Error list devices" + Convert.ToString(ftStatus), "Error");
								return false;
							}
						}
					}
				}
			}

			cmbDevList.SelectedIndex = iCurrentIndex;

			return true;
		}

		private void D2XXAccess_Load(object sender, System.EventArgs e)
		{
			m_hPort = 0;
			fContinue = false;
			dwListDescFlags = FT_LIST_ALL;
			radNumber.Checked = true;
			btnClose.Enabled = false;
			btnOpen.Enabled = true;
			btnWrite.Enabled = false;
			radDescription.Enabled = true;
			radSerial.Enabled = true;
			radNumber.Enabled = true;
			if (ListUnopenDevices() == false) 
			{
				MessageBox.Show("Error Listing Devices");
			}
		}

		private void radDescription_CheckedChanged(object sender, System.EventArgs e)
		{
			dwListDescFlags = FT_LIST_BY_INDEX | FT_OPEN_BY_DESCRIPTION;
			if (ListUnopenDevices() == false) 
			{
				MessageBox.Show("Error Listing Devices");
			}
		}

		private void radSerial_CheckedChanged(object sender, System.EventArgs e)
		{
			dwListDescFlags = FT_LIST_BY_INDEX | FT_OPEN_BY_SERIAL_NUMBER;
			if (ListUnopenDevices() == false) 
			{
				MessageBox.Show("Error Listing Devices");
			}
		}

		private void radNumber_CheckedChanged(object sender, System.EventArgs e)
		{
			dwListDescFlags = FT_LIST_ALL;
			if (ListUnopenDevices() == false) 
			{
				MessageBox.Show("Error Listing Devices");
			}
		}

		private unsafe void btnWrite_Click(object sender, System.EventArgs e)
		{
			UInt32 dwRet = 0;
			FT_STATUS ftStatus = D2XXAccess.FT_STATUS.FT_OTHER_ERROR;
			int i;
        	byte[] cBuf=new Byte[256];

			lbDataBytes.Items.Clear();
			for (i = 0; i <= cBuf.GetUpperBound(0); i++) 
			{
				cBuf[i] = (byte)i;
			}

			i = Convert.ToInt32(tbNumBytes.Text);

			fixed(byte *pBuf = cBuf)
			{
				ftStatus = FT_Write(m_hPort, pBuf, (uint)(i + 1), ref dwRet);
			}
			if (ftStatus != D2XXAccess.FT_STATUS.FT_OK) 
			{
				MessageBox.Show("Failed To Write " + Convert.ToString(ftStatus));
			}
		}

		private void btnClose_Click(object sender, System.EventArgs e)
		{
			if (m_hPort != 0) 
			{
				fContinue = false;
				// it will stop in 3 seconds - not sure if this is proper
				Thread.Sleep(3000);
				FT_Close(m_hPort);
				m_hPort = 0;
			}
			radNumber.Checked = true;
			btnClose.Enabled = false;
			btnOpen.Enabled = true;
			btnWrite.Enabled = false;
			radDescription.Enabled = true;
			radSerial.Enabled = true;
			radNumber.Enabled = true;
		}

	}
}
