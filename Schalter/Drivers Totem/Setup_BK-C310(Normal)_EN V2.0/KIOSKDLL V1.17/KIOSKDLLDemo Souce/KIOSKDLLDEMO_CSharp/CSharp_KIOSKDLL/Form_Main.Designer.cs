namespace CSharp_KIOSKDLL
{
    partial class Form_Main
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.radioButton_DRV = new System.Windows.Forms.RadioButton();
            this.radioButton_USB = new System.Windows.Forms.RadioButton();
            this.radioButton_LPT = new System.Windows.Forms.RadioButton();
            this.radioButton_COM = new System.Windows.Forms.RadioButton();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.label12 = new System.Windows.Forms.Label();
            this.label11 = new System.Windows.Forms.Label();
            this.textBox_WriteTimeOut = new System.Windows.Forms.TextBox();
            this.textBox_ReadTimeOut = new System.Windows.Forms.TextBox();
            this.label10 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.comboBox_DriverName = new System.Windows.Forms.ComboBox();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.comboBox_LPTAddress = new System.Windows.Forms.ComboBox();
            this.comboBox_FlowControl = new System.Windows.Forms.ComboBox();
            this.comboBox_DataBits = new System.Windows.Forms.ComboBox();
            this.comboBox_StopBits = new System.Windows.Forms.ComboBox();
            this.comboBox_Baudrate = new System.Windows.Forms.ComboBox();
            this.comboBox_Parity = new System.Windows.Forms.ComboBox();
            this.comboBox_ComName = new System.Windows.Forms.ComboBox();
            this.checkBox1 = new System.Windows.Forms.CheckBox();
            this.button_Open = new System.Windows.Forms.Button();
            this.button_Query = new System.Windows.Forms.Button();
            this.textBox_Msg = new System.Windows.Forms.TextBox();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.comboBox_DPI = new System.Windows.Forms.ComboBox();
            this.comboBox_PageWidth = new System.Windows.Forms.ComboBox();
            this.label14 = new System.Windows.Forms.Label();
            this.label13 = new System.Windows.Forms.Label();
            this.groupBox7 = new System.Windows.Forms.GroupBox();
            this.radioButton_Present = new System.Windows.Forms.RadioButton();
            this.radioButton_Rectract = new System.Windows.Forms.RadioButton();
            this.groupBox6 = new System.Windows.Forms.GroupBox();
            this.radioButton_Hold = new System.Windows.Forms.RadioButton();
            this.radioButton_Forward = new System.Windows.Forms.RadioButton();
            this.radioButton_Retract = new System.Windows.Forms.RadioButton();
            this.groupBox5 = new System.Windows.Forms.GroupBox();
            this.radioButton_Bundler = new System.Windows.Forms.RadioButton();
            this.radioButton_Presenter = new System.Windows.Forms.RadioButton();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.radioButton_Page = new System.Windows.Forms.RadioButton();
            this.radioButton_Standard = new System.Windows.Forms.RadioButton();
            this.groupBox8 = new System.Windows.Forms.GroupBox();
            this.button_Stop = new System.Windows.Forms.Button();
            this.button_Start = new System.Windows.Forms.Button();
            this.textBox_Status = new System.Windows.Forms.TextBox();
            this.button_Print = new System.Windows.Forms.Button();
            this.button_Close = new System.Windows.Forms.Button();
            this.button_Exit = new System.Windows.Forms.Button();
            this.button_PDF417 = new System.Windows.Forms.Button();
            this.button_PrintSample = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox7.SuspendLayout();
            this.groupBox6.SuspendLayout();
            this.groupBox5.SuspendLayout();
            this.groupBox4.SuspendLayout();
            this.groupBox8.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.radioButton_DRV);
            this.groupBox1.Controls.Add(this.radioButton_USB);
            this.groupBox1.Controls.Add(this.radioButton_LPT);
            this.groupBox1.Controls.Add(this.radioButton_COM);
            this.groupBox1.Location = new System.Drawing.Point(12, 13);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(348, 67);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Port Selecting";
            // 
            // radioButton_DRV
            // 
            this.radioButton_DRV.AutoSize = true;
            this.radioButton_DRV.Location = new System.Drawing.Point(282, 30);
            this.radioButton_DRV.Name = "radioButton_DRV";
            this.radioButton_DRV.Size = new System.Drawing.Size(53, 17);
            this.radioButton_DRV.TabIndex = 3;
            this.radioButton_DRV.Text = "Driver";
            this.radioButton_DRV.UseVisualStyleBackColor = true;
            this.radioButton_DRV.Click += new System.EventHandler(this.radioButton_DRV_Click);
            // 
            // radioButton_USB
            // 
            this.radioButton_USB.AutoSize = true;
            this.radioButton_USB.Location = new System.Drawing.Point(190, 30);
            this.radioButton_USB.Name = "radioButton_USB";
            this.radioButton_USB.Size = new System.Drawing.Size(47, 17);
            this.radioButton_USB.TabIndex = 2;
            this.radioButton_USB.Text = "USB";
            this.radioButton_USB.UseVisualStyleBackColor = true;
            this.radioButton_USB.Click += new System.EventHandler(this.radioButton_USB_Click);
            // 
            // radioButton_LPT
            // 
            this.radioButton_LPT.AutoSize = true;
            this.radioButton_LPT.Location = new System.Drawing.Point(98, 30);
            this.radioButton_LPT.Name = "radioButton_LPT";
            this.radioButton_LPT.Size = new System.Drawing.Size(45, 17);
            this.radioButton_LPT.TabIndex = 1;
            this.radioButton_LPT.Text = "LPT";
            this.radioButton_LPT.UseVisualStyleBackColor = true;
            this.radioButton_LPT.Click += new System.EventHandler(this.radioButton_LPT_Click);
            // 
            // radioButton_COM
            // 
            this.radioButton_COM.AutoSize = true;
            this.radioButton_COM.Checked = true;
            this.radioButton_COM.Location = new System.Drawing.Point(6, 30);
            this.radioButton_COM.Name = "radioButton_COM";
            this.radioButton_COM.Size = new System.Drawing.Size(49, 17);
            this.radioButton_COM.TabIndex = 0;
            this.radioButton_COM.TabStop = true;
            this.radioButton_COM.Text = "COM";
            this.radioButton_COM.UseVisualStyleBackColor = true;
            this.radioButton_COM.Click += new System.EventHandler(this.radioButton_COM_Click);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.label12);
            this.groupBox2.Controls.Add(this.label11);
            this.groupBox2.Controls.Add(this.textBox_WriteTimeOut);
            this.groupBox2.Controls.Add(this.textBox_ReadTimeOut);
            this.groupBox2.Controls.Add(this.label10);
            this.groupBox2.Controls.Add(this.label9);
            this.groupBox2.Controls.Add(this.label8);
            this.groupBox2.Controls.Add(this.label7);
            this.groupBox2.Controls.Add(this.comboBox_DriverName);
            this.groupBox2.Controls.Add(this.label6);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Controls.Add(this.label4);
            this.groupBox2.Controls.Add(this.label3);
            this.groupBox2.Controls.Add(this.label2);
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Controls.Add(this.comboBox_LPTAddress);
            this.groupBox2.Controls.Add(this.comboBox_FlowControl);
            this.groupBox2.Controls.Add(this.comboBox_DataBits);
            this.groupBox2.Controls.Add(this.comboBox_StopBits);
            this.groupBox2.Controls.Add(this.comboBox_Baudrate);
            this.groupBox2.Controls.Add(this.comboBox_Parity);
            this.groupBox2.Controls.Add(this.comboBox_ComName);
            this.groupBox2.Location = new System.Drawing.Point(12, 87);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(348, 289);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Port Setting";
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(178, 220);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(71, 13);
            this.label12.TabIndex = 21;
            this.label12.Text = "( Millisecond )";
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(178, 181);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(71, 13);
            this.label11.TabIndex = 20;
            this.label11.Text = "( Millisecond )";
            // 
            // textBox_WriteTimeOut
            // 
            this.textBox_WriteTimeOut.Location = new System.Drawing.Point(94, 217);
            this.textBox_WriteTimeOut.Name = "textBox_WriteTimeOut";
            this.textBox_WriteTimeOut.Size = new System.Drawing.Size(78, 20);
            this.textBox_WriteTimeOut.TabIndex = 8;
            this.textBox_WriteTimeOut.Text = "90000";
            this.textBox_WriteTimeOut.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.textBox_WriteTimeOut_KeyPress);
            // 
            // textBox_ReadTimeOut
            // 
            this.textBox_ReadTimeOut.Location = new System.Drawing.Point(94, 178);
            this.textBox_ReadTimeOut.Name = "textBox_ReadTimeOut";
            this.textBox_ReadTimeOut.Size = new System.Drawing.Size(78, 20);
            this.textBox_ReadTimeOut.TabIndex = 7;
            this.textBox_ReadTimeOut.Text = "3000";
            this.textBox_ReadTimeOut.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.textBox_ReadTimeOut_KeyPress);
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(198, 64);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(52, 13);
            this.label10.TabIndex = 17;
            this.label10.Text = "Stop Bits:";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(11, 259);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(69, 13);
            this.label9.TabIndex = 16;
            this.label9.Text = "Driver Name:";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(5, 220);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(75, 13);
            this.label8.TabIndex = 15;
            this.label8.Text = "WriteTimeOut:";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(11, 181);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(76, 13);
            this.label7.TabIndex = 14;
            this.label7.Text = "ReadTimeOut:";
            // 
            // comboBox_DriverName
            // 
            this.comboBox_DriverName.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_DriverName.Enabled = false;
            this.comboBox_DriverName.FormattingEnabled = true;
            this.comboBox_DriverName.Location = new System.Drawing.Point(94, 256);
            this.comboBox_DriverName.Name = "comboBox_DriverName";
            this.comboBox_DriverName.Size = new System.Drawing.Size(247, 21);
            this.comboBox_DriverName.TabIndex = 9;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(11, 142);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(71, 13);
            this.label6.TabIndex = 12;
            this.label6.Text = "LPT Address:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(23, 103);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(53, 13);
            this.label5.TabIndex = 11;
            this.label5.Text = "Data Bits:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(29, 64);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(53, 13);
            this.label4.TabIndex = 10;
            this.label4.Text = "Baudrate:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(179, 103);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(68, 13);
            this.label3.TabIndex = 9;
            this.label3.Text = "Flow Control:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(215, 25);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(36, 13);
            this.label2.TabIndex = 8;
            this.label2.Text = "Parity:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(29, 25);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(65, 13);
            this.label1.TabIndex = 7;
            this.label1.Text = "COM Name:";
            // 
            // comboBox_LPTAddress
            // 
            this.comboBox_LPTAddress.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_LPTAddress.Enabled = false;
            this.comboBox_LPTAddress.FormattingEnabled = true;
            this.comboBox_LPTAddress.Items.AddRange(new object[] {
            "0x378",
            "0x278"});
            this.comboBox_LPTAddress.Location = new System.Drawing.Point(94, 139);
            this.comboBox_LPTAddress.Name = "comboBox_LPTAddress";
            this.comboBox_LPTAddress.Size = new System.Drawing.Size(78, 21);
            this.comboBox_LPTAddress.TabIndex = 6;
            // 
            // comboBox_FlowControl
            // 
            this.comboBox_FlowControl.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_FlowControl.FormattingEnabled = true;
            this.comboBox_FlowControl.Items.AddRange(new object[] {
            "DTR/DSR"});
            this.comboBox_FlowControl.Location = new System.Drawing.Point(263, 100);
            this.comboBox_FlowControl.Name = "comboBox_FlowControl";
            this.comboBox_FlowControl.Size = new System.Drawing.Size(78, 21);
            this.comboBox_FlowControl.TabIndex = 5;
            // 
            // comboBox_DataBits
            // 
            this.comboBox_DataBits.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_DataBits.FormattingEnabled = true;
            this.comboBox_DataBits.Items.AddRange(new object[] {
            "7",
            "8"});
            this.comboBox_DataBits.Location = new System.Drawing.Point(94, 100);
            this.comboBox_DataBits.Name = "comboBox_DataBits";
            this.comboBox_DataBits.Size = new System.Drawing.Size(78, 21);
            this.comboBox_DataBits.TabIndex = 2;
            // 
            // comboBox_StopBits
            // 
            this.comboBox_StopBits.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_StopBits.FormattingEnabled = true;
            this.comboBox_StopBits.Items.AddRange(new object[] {
            "1",
            "2"});
            this.comboBox_StopBits.Location = new System.Drawing.Point(263, 61);
            this.comboBox_StopBits.Name = "comboBox_StopBits";
            this.comboBox_StopBits.Size = new System.Drawing.Size(78, 21);
            this.comboBox_StopBits.TabIndex = 4;
            // 
            // comboBox_Baudrate
            // 
            this.comboBox_Baudrate.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_Baudrate.FormattingEnabled = true;
            this.comboBox_Baudrate.Items.AddRange(new object[] {
            "2400",
            "4800",
            "9600",
            "19200",
            "38400",
            "57600",
            "115200"});
            this.comboBox_Baudrate.Location = new System.Drawing.Point(94, 61);
            this.comboBox_Baudrate.Name = "comboBox_Baudrate";
            this.comboBox_Baudrate.Size = new System.Drawing.Size(78, 21);
            this.comboBox_Baudrate.TabIndex = 1;
            // 
            // comboBox_Parity
            // 
            this.comboBox_Parity.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_Parity.FormattingEnabled = true;
            this.comboBox_Parity.Items.AddRange(new object[] {
            "NONE",
            "ODD",
            "EVEN",
            "MARK",
            "SPACE"});
            this.comboBox_Parity.Location = new System.Drawing.Point(263, 22);
            this.comboBox_Parity.Name = "comboBox_Parity";
            this.comboBox_Parity.Size = new System.Drawing.Size(78, 21);
            this.comboBox_Parity.TabIndex = 3;
            // 
            // comboBox_ComName
            // 
            this.comboBox_ComName.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_ComName.FormattingEnabled = true;
            this.comboBox_ComName.Items.AddRange(new object[] {
            "COM1",
            "COM2",
            "COM3",
            "COM4",
            "COM5",
            "COM6",
            "COM7",
            "COM8",
            "COM9",
            "COM10"});
            this.comboBox_ComName.Location = new System.Drawing.Point(94, 22);
            this.comboBox_ComName.Name = "comboBox_ComName";
            this.comboBox_ComName.Size = new System.Drawing.Size(78, 21);
            this.comboBox_ComName.TabIndex = 0;
            this.comboBox_ComName.SelectedIndexChanged += new System.EventHandler(this.comboBox_ComName_SelectedIndexChanged);
            // 
            // checkBox1
            // 
            this.checkBox1.AutoSize = true;
            this.checkBox1.Location = new System.Drawing.Point(19, 382);
            this.checkBox1.Name = "checkBox1";
            this.checkBox1.Size = new System.Drawing.Size(189, 17);
            this.checkBox1.TabIndex = 4;
            this.checkBox1.Text = "&Sending data to file but not to port.";
            this.checkBox1.UseVisualStyleBackColor = true;
            this.checkBox1.CheckedChanged += new System.EventHandler(this.checkBox1_CheckedChanged);
            // 
            // button_Open
            // 
            this.button_Open.Location = new System.Drawing.Point(12, 414);
            this.button_Open.Name = "button_Open";
            this.button_Open.Size = new System.Drawing.Size(86, 25);
            this.button_Open.TabIndex = 5;
            this.button_Open.Text = "&Open Port";
            this.button_Open.UseVisualStyleBackColor = true;
            this.button_Open.Click += new System.EventHandler(this.button_Open_Click);
            // 
            // button_Query
            // 
            this.button_Query.Enabled = false;
            this.button_Query.Location = new System.Drawing.Point(104, 414);
            this.button_Query.Name = "button_Query";
            this.button_Query.Size = new System.Drawing.Size(86, 25);
            this.button_Query.TabIndex = 6;
            this.button_Query.Text = "&Query Status";
            this.button_Query.UseVisualStyleBackColor = true;
            this.button_Query.Click += new System.EventHandler(this.button_Query_Click);
            // 
            // textBox_Msg
            // 
            this.textBox_Msg.Location = new System.Drawing.Point(196, 415);
            this.textBox_Msg.Name = "textBox_Msg";
            this.textBox_Msg.ReadOnly = true;
            this.textBox_Msg.Size = new System.Drawing.Size(271, 20);
            this.textBox_Msg.TabIndex = 7;
            this.textBox_Msg.Text = "All is ok,version is V1.0";
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.comboBox_DPI);
            this.groupBox3.Controls.Add(this.comboBox_PageWidth);
            this.groupBox3.Controls.Add(this.label14);
            this.groupBox3.Controls.Add(this.label13);
            this.groupBox3.Controls.Add(this.groupBox7);
            this.groupBox3.Controls.Add(this.groupBox6);
            this.groupBox3.Controls.Add(this.groupBox5);
            this.groupBox3.Controls.Add(this.groupBox4);
            this.groupBox3.Location = new System.Drawing.Point(367, 13);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(178, 362);
            this.groupBox3.TabIndex = 2;
            this.groupBox3.TabStop = false;
            // 
            // comboBox_DPI
            // 
            this.comboBox_DPI.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_DPI.FormattingEnabled = true;
            this.comboBox_DPI.Items.AddRange(new object[] {
            "203dpi",
            "300dpi"});
            this.comboBox_DPI.Location = new System.Drawing.Point(79, 329);
            this.comboBox_DPI.Name = "comboBox_DPI";
            this.comboBox_DPI.Size = new System.Drawing.Size(93, 21);
            this.comboBox_DPI.TabIndex = 7;
            // 
            // comboBox_PageWidth
            // 
            this.comboBox_PageWidth.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_PageWidth.FormattingEnabled = true;
            this.comboBox_PageWidth.Items.AddRange(new object[] {
            "56mm",
            "80mm",
            "210mm"});
            this.comboBox_PageWidth.Location = new System.Drawing.Point(79, 297);
            this.comboBox_PageWidth.Name = "comboBox_PageWidth";
            this.comboBox_PageWidth.Size = new System.Drawing.Size(93, 21);
            this.comboBox_PageWidth.TabIndex = 6;
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Location = new System.Drawing.Point(6, 333);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(60, 13);
            this.label14.TabIndex = 5;
            this.label14.Text = "Resolution:";
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Location = new System.Drawing.Point(6, 300);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(63, 13);
            this.label13.TabIndex = 4;
            this.label13.Text = "Page width:";
            // 
            // groupBox7
            // 
            this.groupBox7.Controls.Add(this.radioButton_Present);
            this.groupBox7.Controls.Add(this.radioButton_Rectract);
            this.groupBox7.Location = new System.Drawing.Point(6, 231);
            this.groupBox7.Name = "groupBox7";
            this.groupBox7.Size = new System.Drawing.Size(166, 61);
            this.groupBox7.TabIndex = 3;
            this.groupBox7.TabStop = false;
            this.groupBox7.Text = "Bundler Setting";
            // 
            // radioButton_Present
            // 
            this.radioButton_Present.AutoSize = true;
            this.radioButton_Present.Enabled = false;
            this.radioButton_Present.Location = new System.Drawing.Point(92, 27);
            this.radioButton_Present.Name = "radioButton_Present";
            this.radioButton_Present.Size = new System.Drawing.Size(61, 17);
            this.radioButton_Present.TabIndex = 1;
            this.radioButton_Present.Text = "Present";
            this.radioButton_Present.UseVisualStyleBackColor = true;
            this.radioButton_Present.Click += new System.EventHandler(this.radioButton_Present_Click);
            // 
            // radioButton_Rectract
            // 
            this.radioButton_Rectract.AutoSize = true;
            this.radioButton_Rectract.Checked = true;
            this.radioButton_Rectract.Enabled = false;
            this.radioButton_Rectract.Location = new System.Drawing.Point(9, 27);
            this.radioButton_Rectract.Name = "radioButton_Rectract";
            this.radioButton_Rectract.Size = new System.Drawing.Size(60, 17);
            this.radioButton_Rectract.TabIndex = 0;
            this.radioButton_Rectract.TabStop = true;
            this.radioButton_Rectract.Text = "Retract";
            this.radioButton_Rectract.UseVisualStyleBackColor = true;
            this.radioButton_Rectract.Click += new System.EventHandler(this.radioButton_Rectract_Click);
            // 
            // groupBox6
            // 
            this.groupBox6.Controls.Add(this.radioButton_Hold);
            this.groupBox6.Controls.Add(this.radioButton_Forward);
            this.groupBox6.Controls.Add(this.radioButton_Retract);
            this.groupBox6.Location = new System.Drawing.Point(6, 138);
            this.groupBox6.Name = "groupBox6";
            this.groupBox6.Size = new System.Drawing.Size(166, 91);
            this.groupBox6.TabIndex = 2;
            this.groupBox6.TabStop = false;
            this.groupBox6.Text = "Presenter Setting";
            // 
            // radioButton_Hold
            // 
            this.radioButton_Hold.AutoSize = true;
            this.radioButton_Hold.Location = new System.Drawing.Point(9, 67);
            this.radioButton_Hold.Name = "radioButton_Hold";
            this.radioButton_Hold.Size = new System.Drawing.Size(78, 17);
            this.radioButton_Hold.TabIndex = 2;
            this.radioButton_Hold.Text = "Paper Hold";
            this.radioButton_Hold.UseVisualStyleBackColor = true;
            this.radioButton_Hold.Click += new System.EventHandler(this.radioButton_Hold_Click);
            // 
            // radioButton_Forward
            // 
            this.radioButton_Forward.AutoSize = true;
            this.radioButton_Forward.Location = new System.Drawing.Point(9, 46);
            this.radioButton_Forward.Name = "radioButton_Forward";
            this.radioButton_Forward.Size = new System.Drawing.Size(94, 17);
            this.radioButton_Forward.TabIndex = 1;
            this.radioButton_Forward.Text = "Paper Forward";
            this.radioButton_Forward.UseVisualStyleBackColor = true;
            this.radioButton_Forward.Click += new System.EventHandler(this.radioButton_Forward_Click);
            // 
            // radioButton_Retract
            // 
            this.radioButton_Retract.AutoSize = true;
            this.radioButton_Retract.Checked = true;
            this.radioButton_Retract.Location = new System.Drawing.Point(9, 22);
            this.radioButton_Retract.Name = "radioButton_Retract";
            this.radioButton_Retract.Size = new System.Drawing.Size(89, 17);
            this.radioButton_Retract.TabIndex = 0;
            this.radioButton_Retract.TabStop = true;
            this.radioButton_Retract.Text = "Retraction on";
            this.radioButton_Retract.UseVisualStyleBackColor = true;
            this.radioButton_Retract.Click += new System.EventHandler(this.radioButton_Retract_Click);
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.radioButton_Bundler);
            this.groupBox5.Controls.Add(this.radioButton_Presenter);
            this.groupBox5.Location = new System.Drawing.Point(6, 75);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size(166, 61);
            this.groupBox5.TabIndex = 1;
            this.groupBox5.TabStop = false;
            this.groupBox5.Text = "Paper Out Mode Selecting";
            // 
            // radioButton_Bundler
            // 
            this.radioButton_Bundler.AutoSize = true;
            this.radioButton_Bundler.Location = new System.Drawing.Point(92, 25);
            this.radioButton_Bundler.Name = "radioButton_Bundler";
            this.radioButton_Bundler.Size = new System.Drawing.Size(61, 17);
            this.radioButton_Bundler.TabIndex = 1;
            this.radioButton_Bundler.Text = "Bundler";
            this.radioButton_Bundler.UseVisualStyleBackColor = true;
            this.radioButton_Bundler.Click += new System.EventHandler(this.radioButton_Bundler_Click);
            // 
            // radioButton_Presenter
            // 
            this.radioButton_Presenter.AutoSize = true;
            this.radioButton_Presenter.Checked = true;
            this.radioButton_Presenter.Location = new System.Drawing.Point(9, 25);
            this.radioButton_Presenter.Name = "radioButton_Presenter";
            this.radioButton_Presenter.Size = new System.Drawing.Size(70, 17);
            this.radioButton_Presenter.TabIndex = 0;
            this.radioButton_Presenter.TabStop = true;
            this.radioButton_Presenter.Text = "Presenter";
            this.radioButton_Presenter.UseVisualStyleBackColor = true;
            this.radioButton_Presenter.Click += new System.EventHandler(this.radioButton_Presenter_Click);
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.radioButton_Page);
            this.groupBox4.Controls.Add(this.radioButton_Standard);
            this.groupBox4.Location = new System.Drawing.Point(6, 10);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(166, 57);
            this.groupBox4.TabIndex = 0;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Print Mode Selecting";
            // 
            // radioButton_Page
            // 
            this.radioButton_Page.AutoSize = true;
            this.radioButton_Page.Location = new System.Drawing.Point(92, 26);
            this.radioButton_Page.Name = "radioButton_Page";
            this.radioButton_Page.Size = new System.Drawing.Size(50, 17);
            this.radioButton_Page.TabIndex = 1;
            this.radioButton_Page.Text = "Page";
            this.radioButton_Page.UseVisualStyleBackColor = true;
            this.radioButton_Page.Click += new System.EventHandler(this.radioButton_Page_Click);
            // 
            // radioButton_Standard
            // 
            this.radioButton_Standard.AutoSize = true;
            this.radioButton_Standard.Checked = true;
            this.radioButton_Standard.Location = new System.Drawing.Point(9, 26);
            this.radioButton_Standard.Name = "radioButton_Standard";
            this.radioButton_Standard.Size = new System.Drawing.Size(68, 17);
            this.radioButton_Standard.TabIndex = 0;
            this.radioButton_Standard.TabStop = true;
            this.radioButton_Standard.Text = "Standard";
            this.radioButton_Standard.UseVisualStyleBackColor = true;
            this.radioButton_Standard.Click += new System.EventHandler(this.radioButton_Standard_Click);
            // 
            // groupBox8
            // 
            this.groupBox8.Controls.Add(this.button_Stop);
            this.groupBox8.Controls.Add(this.button_Start);
            this.groupBox8.Controls.Add(this.textBox_Status);
            this.groupBox8.Location = new System.Drawing.Point(554, 13);
            this.groupBox8.Name = "groupBox8";
            this.groupBox8.Size = new System.Drawing.Size(191, 362);
            this.groupBox8.TabIndex = 3;
            this.groupBox8.TabStop = false;
            this.groupBox8.Text = "Status Monitor";
            // 
            // button_Stop
            // 
            this.button_Stop.Enabled = false;
            this.button_Stop.Location = new System.Drawing.Point(54, 329);
            this.button_Stop.Name = "button_Stop";
            this.button_Stop.Size = new System.Drawing.Size(75, 25);
            this.button_Stop.TabIndex = 2;
            this.button_Stop.Text = "Stop";
            this.button_Stop.UseVisualStyleBackColor = true;
            this.button_Stop.Click += new System.EventHandler(this.button_Stop_Click);
            // 
            // button_Start
            // 
            this.button_Start.Enabled = false;
            this.button_Start.Location = new System.Drawing.Point(54, 300);
            this.button_Start.Name = "button_Start";
            this.button_Start.Size = new System.Drawing.Size(75, 25);
            this.button_Start.TabIndex = 1;
            this.button_Start.Text = "Start";
            this.button_Start.UseVisualStyleBackColor = true;
            this.button_Start.Click += new System.EventHandler(this.button_Start_Click);
            // 
            // textBox_Status
            // 
            this.textBox_Status.AllowDrop = true;
            this.textBox_Status.Location = new System.Drawing.Point(8, 18);
            this.textBox_Status.Multiline = true;
            this.textBox_Status.Name = "textBox_Status";
            this.textBox_Status.ReadOnly = true;
            this.textBox_Status.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.textBox_Status.Size = new System.Drawing.Size(175, 275);
            this.textBox_Status.TabIndex = 0;
            // 
            // button_Print
            // 
            this.button_Print.Enabled = false;
            this.button_Print.Location = new System.Drawing.Point(473, 414);
            this.button_Print.Name = "button_Print";
            this.button_Print.Size = new System.Drawing.Size(86, 25);
            this.button_Print.TabIndex = 8;
            this.button_Print.Text = "&Print";
            this.button_Print.UseVisualStyleBackColor = true;
            this.button_Print.Click += new System.EventHandler(this.button_Print_Click);
            // 
            // button_Close
            // 
            this.button_Close.Enabled = false;
            this.button_Close.Location = new System.Drawing.Point(566, 414);
            this.button_Close.Name = "button_Close";
            this.button_Close.Size = new System.Drawing.Size(86, 25);
            this.button_Close.TabIndex = 9;
            this.button_Close.Text = "C&lose Port";
            this.button_Close.UseVisualStyleBackColor = true;
            this.button_Close.Click += new System.EventHandler(this.button_Close_Click);
            // 
            // button_Exit
            // 
            this.button_Exit.Location = new System.Drawing.Point(659, 414);
            this.button_Exit.Name = "button_Exit";
            this.button_Exit.Size = new System.Drawing.Size(86, 25);
            this.button_Exit.TabIndex = 10;
            this.button_Exit.Text = "&Exit";
            this.button_Exit.UseVisualStyleBackColor = true;
            this.button_Exit.Click += new System.EventHandler(this.button_Exit_Click);
            // 
            // button_PDF417
            // 
            this.button_PDF417.Enabled = false;
            this.button_PDF417.Location = new System.Drawing.Point(372, 381);
            this.button_PDF417.Name = "button_PDF417";
            this.button_PDF417.Size = new System.Drawing.Size(111, 24);
            this.button_PDF417.TabIndex = 11;
            this.button_PDF417.Text = "PrintPDF417";
            this.button_PDF417.UseVisualStyleBackColor = true;
            this.button_PDF417.Click += new System.EventHandler(this.btnPrintPdf417Code_Click);
            // 
            // button_PrintSample
            // 
            this.button_PrintSample.Enabled = false;
            this.button_PrintSample.Location = new System.Drawing.Point(502, 381);
            this.button_PrintSample.Name = "button_PrintSample";
            this.button_PrintSample.Size = new System.Drawing.Size(111, 24);
            this.button_PrintSample.TabIndex = 12;
            this.button_PrintSample.Text = "PrintSample";
            this.button_PrintSample.UseVisualStyleBackColor = true;
            this.button_PrintSample.Click += new System.EventHandler(this.button_PrintSample_Click);
            // 
            // Form_Main
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(751, 452);
            this.Controls.Add(this.button_PrintSample);
            this.Controls.Add(this.button_PDF417);
            this.Controls.Add(this.button_Exit);
            this.Controls.Add(this.button_Close);
            this.Controls.Add(this.button_Print);
            this.Controls.Add(this.groupBox8);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.textBox_Msg);
            this.Controls.Add(this.button_Query);
            this.Controls.Add(this.button_Open);
            this.Controls.Add(this.checkBox1);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.KeyPreview = true;
            this.MaximizeBox = false;
            this.Name = "Form_Main";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "KIOSKDLLDEMO_CSharp";
            this.Deactivate += new System.EventHandler(this.Form_Main_Deactivate);
            this.Load += new System.EventHandler(this.Form_Main_Load);
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Form_Main_KeyDown);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox7.ResumeLayout(false);
            this.groupBox7.PerformLayout();
            this.groupBox6.ResumeLayout(false);
            this.groupBox6.PerformLayout();
            this.groupBox5.ResumeLayout(false);
            this.groupBox5.PerformLayout();
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.groupBox8.ResumeLayout(false);
            this.groupBox8.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.RadioButton radioButton_USB;
        private System.Windows.Forms.RadioButton radioButton_LPT;
        private System.Windows.Forms.RadioButton radioButton_DRV;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.ComboBox comboBox_FlowControl;
        private System.Windows.Forms.ComboBox comboBox_DataBits;
        private System.Windows.Forms.ComboBox comboBox_StopBits;
        private System.Windows.Forms.ComboBox comboBox_Baudrate;
        private System.Windows.Forms.ComboBox comboBox_Parity;
        private System.Windows.Forms.ComboBox comboBox_ComName;
        private System.Windows.Forms.ComboBox comboBox_LPTAddress;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.ComboBox comboBox_DriverName;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox textBox_ReadTimeOut;
        private System.Windows.Forms.TextBox textBox_WriteTimeOut;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.CheckBox checkBox1;
        private System.Windows.Forms.Button button_Open;
        private System.Windows.Forms.Button button_Query;
        private System.Windows.Forms.TextBox textBox_Msg;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.Label label13;
        private System.Windows.Forms.GroupBox groupBox7;
        private System.Windows.Forms.GroupBox groupBox6;
        private System.Windows.Forms.GroupBox groupBox5;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.ComboBox comboBox_DPI;
        private System.Windows.Forms.ComboBox comboBox_PageWidth;
        private System.Windows.Forms.GroupBox groupBox8;
        private System.Windows.Forms.Button button_Stop;
        private System.Windows.Forms.Button button_Start;
        private System.Windows.Forms.TextBox textBox_Status;
        private System.Windows.Forms.Button button_Print;
        private System.Windows.Forms.Button button_Close;
        private System.Windows.Forms.Button button_Exit;
        private System.Windows.Forms.RadioButton radioButton_COM;
        private System.Windows.Forms.RadioButton radioButton_Standard;
        private System.Windows.Forms.RadioButton radioButton_Page;
        private System.Windows.Forms.RadioButton radioButton_Bundler;
        private System.Windows.Forms.RadioButton radioButton_Presenter;
        private System.Windows.Forms.RadioButton radioButton_Present;
        private System.Windows.Forms.RadioButton radioButton_Rectract;
        private System.Windows.Forms.RadioButton radioButton_Hold;
        private System.Windows.Forms.RadioButton radioButton_Forward;
        private System.Windows.Forms.RadioButton radioButton_Retract;
        private System.Windows.Forms.Button button_PDF417;
        private System.Windows.Forms.Button button_PrintSample;
    }
}

