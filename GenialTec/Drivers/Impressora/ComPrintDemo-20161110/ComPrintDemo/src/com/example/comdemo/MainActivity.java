package com.example.comdemo;

import java.io.IOException;
import java.security.InvalidParameterException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Queue;
 
import com.bean.ComBean;         
import com.printsdk.cmd.PrintCmd;

import android.os.Bundle;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;
import android.view.Menu; 
import android.view.View; 
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText; 
import android.widget.Spinner;
import android.widget.Toast;
import android.widget.ToggleButton;
import android_serialport_api.SerialPortFinder;

@SuppressLint("SimpleDateFormat") 
public class MainActivity extends Activity {
	SerialPortFinder mSerialPortFinder;//串口设备搜索
	Spinner SpinnerCOMA;
	Spinner SpinnerBaudRateCOMA;
	ToggleButton toggleButtonCOMA; 
	CheckBox checkBoxAutoCOMA;
	Button ButtonClear,ButtonSendCOMA,ButtonDemoCOMA; 
	EditText editTextRecDisp,editTextCOMA;
	EditText editTextTimeCOMA;
	SerialControl ComA;//串口
	DispQueueThread DispQueue;//刷新显示线程	
  	SimpleDateFormat m_sdfDate = new SimpleDateFormat("HH:mm:ss ");
  	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss"); // 国际化标志时间格式类
	int m_iRecValue = -1;//接收值
	int m_iStatusCount=0;	//返回状态计时
	boolean m_blnStatus= false;//查询状态标志  	 
    // 根据系统语言获取测试文本
    static int Number = 1000; // 默认1000开始
	String title = "", strData = "", num = "",QrCodeStr = ""; // 小票标题、内容、票号、二维码内容
	// 通过系统语言判断Message显示
	String receive = "", state = ""; // 接收提示、状态类型
	String normal = "",paperExh = "",paperWillExh = "",abnormal = "";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
        setControls();
        getSPData();
        DispQueue = new DispQueueThread();
        DispQueue.start();
	}
	
    private void setControls()
	{
    	try{
	        ComA = new SerialControl(); 
	        ComA.setbLoopData(PrintCmd.GetStatus4()); 
	        
	    	SpinnerCOMA=(Spinner)findViewById(R.id.SpinnerCOMA);
	       	SpinnerBaudRateCOMA=(Spinner)findViewById(R.id.SpinnerBaudRateCOMA);
	    	toggleButtonCOMA=(ToggleButton)findViewById(R.id.toggleButtonCOMA);
			checkBoxAutoCOMA=(CheckBox)findViewById(R.id.checkBoxAutoCOMA);
	    	ButtonClear=(Button)findViewById(R.id.ButtonClear);
	    	ButtonSendCOMA=(Button)findViewById(R.id.ButtonSendCOMA);
	    	ButtonDemoCOMA=(Button)findViewById(R.id.ButtonDemoCOMA);
	    	editTextRecDisp=(EditText)findViewById(R.id.editTextRecDisp);
	    	editTextCOMA=(EditText)findViewById(R.id.editTextCOMA);
	    	editTextTimeCOMA = (EditText)findViewById(R.id.editTextTimeCOMA);
		
	    	mSerialPortFinder= new SerialPortFinder();
	    	String[] entryValues = mSerialPortFinder.getAllDevicesPath();
	    	List<String> allDevices = new ArrayList<String>();
			for (int i = 0; i < entryValues.length; i++) {
				allDevices.add(entryValues[i]);
			}
			ArrayAdapter<String> aspnDevices = new ArrayAdapter<String>(this,
					android.R.layout.simple_spinner_item, allDevices);
			aspnDevices.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
			SpinnerCOMA.setAdapter(aspnDevices);
			if (allDevices.size()>1)
			{
				SpinnerCOMA.setSelection(0);
			}	
	    	ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this, 
	    			R.array.baudrates_value,android.R.layout.simple_spinner_item);
	    	adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
	    	SpinnerBaudRateCOMA.setAdapter(adapter);
	    	SpinnerBaudRateCOMA.setSelection(4);    	
	
	    	toggleButtonCOMA.setOnCheckedChangeListener(new ToggleButtonCheckedChangeEvent());
	    	ButtonClear.setOnClickListener(new ButtonClickEvent());
	    	ButtonSendCOMA.setOnClickListener(new ButtonClickEvent());
	    	ButtonDemoCOMA.setOnClickListener(new ButtonClickEvent());
	    	checkBoxAutoCOMA.setOnCheckedChangeListener(new CheckBoxChangeEvent());
    	}
    	catch(Exception e)
    	{
    		Log.d("MainActivity","setControls:"+e.getMessage());
    	}
	}    
    
	//----------------------------------------------------打开关闭串口
	class ToggleButtonCheckedChangeEvent implements
			ToggleButton.OnCheckedChangeListener {
		public void onCheckedChanged(CompoundButton buttonView,
				boolean isChecked) {
			try {
				if (buttonView == toggleButtonCOMA) {
					SpinnerCOMA.setEnabled(!isChecked);
					SpinnerBaudRateCOMA.setEnabled(!isChecked);
					checkBoxAutoCOMA.setEnabled(isChecked);
					if (isChecked) {
						ComA.setPort(SpinnerCOMA.getSelectedItem().toString());
						ComA.setBaudRate(SpinnerBaudRateCOMA.getSelectedItem()
								.toString());
						OpenComPort(ComA);
					} else {
						CloseComPort(ComA);
						checkBoxAutoCOMA.setChecked(false);
					}
				}
			} catch (Exception se) {
				ShowMessage(se.getMessage());
			}
		}
	}
    
    //----------------------------------------------------关闭串口
	private void CloseComPort(SerialHelper ComPort) {
		if (ComPort != null) {
			ComPort.stopSend();
			ComPort.close();
		}
	}
    
    //----------------------------------------------------打开串口
	private void OpenComPort(SerialHelper ComPort) {
		try {
			ComPort.open();
		} catch (SecurityException e) {
			ShowMessage(getString(R.string.No_read_or_write_permissions));
		} catch (IOException e) {
			ShowMessage(getString(R.string.Unknown_error));
		} catch (InvalidParameterException e) {
			ShowMessage(getString(R.string.Parameter_error));
		}
	}
    
    //------------------------------------------显示消息
	private void ShowMessage(String sMsg) {
		StringBuilder sbMsg = new StringBuilder();
		sbMsg.append(editTextRecDisp.getText());
		sbMsg.append(m_sdfDate.format(new Date()));
		sbMsg.append(sMsg);
		sbMsg.append("\r\n");
		editTextRecDisp.setText(sbMsg);
		editTextRecDisp.setSelection(sbMsg.length(), sbMsg.length());
	}
  	
    //----------------------------------------------------串口控制类
	private class SerialControl extends SerialHelper {
		public SerialControl() {
		}
		@Override
		protected void onDataReceived(final ComBean ComRecData) {
			DispQueue.AddQueue(ComRecData);// 线程定时刷新显示(推荐)
		}
	}
    
    //----------------------------------------------------刷新显示线程
	private class DispQueueThread extends Thread {
		private Queue<ComBean> QueueList = new LinkedList<ComBean>();
		@Override
		public void run() {
			super.run();
			while (!isInterrupted()) {
				final ComBean ComData;
				while ((ComData = QueueList.poll()) != null) {
					runOnUiThread(new Runnable() {
						public void run() {
							DispRecData(ComData);
						}
					});
					try {
						Thread.sleep(200);// 显示性能高的话，可以把此数值调小。
					} catch (Exception e) {
						e.printStackTrace();
					}
					break;
				}
			}
		}
		public synchronized void AddQueue(ComBean ComData) {
			QueueList.add(ComData);
		}
	}
    
    //----------------------------------------------------串口发送
//	private void sendPortData(SerialHelper ComPort, byte[] bOut) {
//		try {
//			if (ComPort != null && ComPort.isOpen()) {
//				ComPort.send(bOut); 
//			} else {
//				ShowMessage(getString(R.string.Serial_port_not_open));
//			}
//		} catch (Exception ex) {
//			ShowMessage(ex.getMessage());
//		}
//	} 

    //----------------------------------------------------清除按钮、发送按钮
	class ButtonClickEvent implements View.OnClickListener {
		public void onClick(View v) {
			if (!ComA.isOpen()) {
				Toast.makeText(getApplicationContext(),
						getString(R.string.Serial_connect_failed),
						Toast.LENGTH_SHORT).show();
				return;
			}
			if (v == ButtonClear) {
				editTextRecDisp.setText("");
			} else if (v == ButtonSendCOMA) {
				ComA.send(PrintCmd.PrintString(editTextCOMA.getText().toString(), 0));
			} else if (v == ButtonDemoCOMA) {
				//sendPortData(ComA, PrintCmd.GetStatus()); // 查询状态
				ComA.send(PrintCmd.GetStatus4());
				m_blnStatus = true;
				m_iStatusCount = 0;
				m_iRecValue = -1; 
				ShowMessage(getString(R.string.State_query)); 
			}
		}
	}

 	private void getStrDataByLanguage(){
 		if(isZh()){
 			title = Constant.TITLE_CN;
 			strData = Constant.STRDATA_CN;
 		}else {
 			title = Constant.TITLE_US;
 			strData = Constant.STRDATA_US;
 		}
 		num = String.valueOf(Number) + "\n\n";
 		Number++;
 	}
    /**
	 *  2.打印银行排队办理业务排队单
	 */
	private void PrintBankQueue() {
		getStrDataByLanguage();
		try {
			// 小票标题
			ComA.send(PrintCmd.SetBold(0));
			ComA.send(PrintCmd.SetAlignment(1));
			ComA.send(PrintCmd.SetSizetext(1, 1));
			ComA.send(PrintCmd.PrintString(title, 0));
			// 小票号码
			ComA.send(PrintCmd.SetBold(1));
			ComA.send(PrintCmd.PrintString(num, 0));
			// 小票主要内容
			CleanPrinter(); // 清理缓存，缺省模式
			ComA.send(PrintCmd.PrintString(strData, 0));
			// 二维码
			ComA.send(PrintCmd.PrintFeedline(2));    
			PrintQRCode();  // 二维码打印                          
			ComA.send(PrintCmd.PrintFeedline(2));    
			// 日期时间
			ComA.send(PrintCmd.SetAlignment(2));
			ComA.send(PrintCmd.PrintString(sdf.format(new Date()).toString() + "\n\n", 1));
			// 一维条码
			CleanPrinter();                          
			ComA.send(PrintCmd.Set1DBarCodeAlign(1));// 条码对齐方式
			ComA.send(PrintCmd.SetAlignment(1));
			ComA.send(PrintCmd.Print1Dbar(2, 100, 0, 2, 10, "123456888"));  // 一维条码打印 CODE128
			// 走纸4行,再切纸,清理缓存
			PrintFeedCutpaper(4);                 
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 走纸换行，再切纸，清理缓存
	private void PrintFeedCutpaper(int iLine) throws IOException {
		ComA.send(PrintCmd.PrintFeedline(iLine));
		ComA.send(PrintCmd.PrintCutpaper(0));
		ComA.send(PrintCmd.SetClean());
	}
	// 清理缓存，缺省模式
	private void CleanPrinter() {
		ComA.send(PrintCmd.SetClean());
	}
    //----------------------------------------------------自动发送
	class CheckBoxChangeEvent implements CheckBox.OnCheckedChangeListener {
		public void onCheckedChanged(CompoundButton buttonView,
				boolean isChecked) {
			try {
				if (buttonView == checkBoxAutoCOMA) {
					editTextTimeCOMA.setEnabled(!isChecked);
					if (!toggleButtonCOMA.isChecked() && isChecked) {
						buttonView.setChecked(false);
						return;
					}
					if (isChecked) {
						ComA.setiDelay(Integer.parseInt(editTextTimeCOMA
								.getText().toString()));
						ComA.startSend();
					} else {
						ComA.stopSend();
					}
				}
			} catch (Exception se) {
				ShowMessage(se.getMessage());
			}
		}
	} 
	// 打印二维码
	private void PrintQRCode() throws IOException {
		ComA.send(PrintCmd.PrintQrcode(Constant.WebAddress, 25, 7, 1));
	}
    //----------------------------------------------------显示接收数据
	private void DispRecData(ComBean ComRecData) {
		m_blnStatus = false;
		m_iStatusCount = 0;
		getMsgByLanguage(); // 根据系统语言获取状态类型
		StringBuilder sMsg = new StringBuilder();
		try {
			sMsg.append(receive);
			sMsg.append(MyFunc.ByteArrToHex(ComRecData.bRec));
			m_iRecValue = -1;
			m_iRecValue = PrintCmd.CheckStatus4(ComRecData.bRec[0]);
			byte iValue = ComRecData.bRec[0];
			sMsg.append(state);
			switch(m_iRecValue)
			{
			case 0:
				sMsg.append(normal);
				break;
			case 7:
				sMsg.append(paperExh);
				break;
			case 10:
				sMsg.append(paperWillExh);
				break;
			default:
				sMsg.append(abnormal);
				break;
			}

			ShowMessage(sMsg.toString());
			if (m_iRecValue == 10 || m_iRecValue == 0) {
				// ShowMessage("打印Demo...");
//				QRCodeInfo codeInfo = new QRCodeInfo();
//				codeInfo.setmSide(2);
//				byte[] bQRcode = codeInfo.GetQRBCode("123456abcd", 1);
//				ComA.send(bQRcode);
//				PrintQRCode();   // 打印二维码
				PrintBankQueue();// 银行小票打印
			}
		} catch (Exception ex) {
			Log.d("DispRecData:",ex.getMessage());
		}
	}
    
	// ----------------------------------------------------保存、获取界面数据
	private void saveSPData() {
		SharedPreferences msharedPreferences = getSharedPreferences("ComDemo",
				Context.MODE_PRIVATE);
		try {
			SharedPreferences.Editor editor = msharedPreferences.edit();
			editor.putString("editTextTimeCOMA", editTextTimeCOMA.getText()
					.toString());
			editor.putString("editTextCOMA", editTextCOMA.getText().toString());
			editor.putString("SpinnerCOMA", SpinnerCOMA.getSelectedItem()
					.toString());
			editor.putString("SpinnerBaudRateCOMA", SpinnerBaudRateCOMA
					.getSelectedItem().toString());
			editor.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// ----------------------------------------------------刷新界面数据
	private void getSPData() {
		SharedPreferences msharedPreferences = getSharedPreferences("ComDemo",
				Context.MODE_PRIVATE);
		try {
			editTextCOMA.setText(msharedPreferences.getString("editTextCOMA",
					""));
			editTextTimeCOMA.setText(msharedPreferences.getString(
					"editTextTimeCOMA", "3000"));
			String strValue = msharedPreferences.getString("SpinnerCOMA", "");

			int iCount = SpinnerCOMA.getAdapter().getCount();
			int iIndex = 0;
			for (iIndex = 0; iIndex < iCount; iIndex++) {
				if (SpinnerCOMA.getItemAtPosition(iIndex).toString()
						.equals(strValue)) {
					SpinnerCOMA.setSelection(iIndex);
					break;
				}
			}
			strValue = msharedPreferences.getString("SpinnerBaudRateCOMA", "");
			iCount = SpinnerBaudRateCOMA.getAdapter().getCount();
			for (iIndex = 0; iIndex < iCount; iIndex++) {
				if (SpinnerBaudRateCOMA.getItemAtPosition(iIndex).toString()
						.equals(strValue)) {
					SpinnerBaudRateCOMA.setSelection(iIndex);
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 获取当前系统的语言环境
	private boolean isZh() {
		Locale locale = getResources().getConfiguration().locale;
		String language = locale.getLanguage();
		if (language.endsWith("zh"))
			return true;
		else
			return false;
	}

	private void getMsgByLanguage() {
		if (isZh()) {
			receive = Constant.Receive_CN;
			state = Constant.State_CN;
			normal = Constant.Normal_CN;
			paperExh = Constant.PaperExhausted_CN;
			paperWillExh = Constant.PaperWillExhausted_CN;
			abnormal = Constant.Abnormal_CN;
		} else {
			receive = Constant.Receive_US;
			state = Constant.State_US;
			normal = Constant.Normal_US;
			paperExh = Constant.PaperExhausted_US;
			paperWillExh = Constant.PaperWillExhausted_US;
			abnormal = Constant.Abnormal_US;
		}
	}
	@Override
    public void onDestroy(){
    	saveSPData();
    	CloseComPort(ComA);
    	super.onDestroy();
    }   
	
    @Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}
}
