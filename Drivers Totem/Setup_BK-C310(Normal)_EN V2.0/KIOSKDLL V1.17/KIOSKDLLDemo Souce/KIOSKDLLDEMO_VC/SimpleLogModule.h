/**********************************************************************************************************************
 * Copyright	(C), 2010-2010, SNBC 
 * FileName		SimpleLogModule.h
 * Author		duyuzhen
 * Version		v1.01
 * Date			2011/03/23
**********************************************************************************************************************/
#ifndef Log_Recode_H_Def
#define Log_Recode_H_Def

/**********************************************************************************************************************
 * �����������Ͷ���
**********************************************************************************************************************/
#ifndef Custom_Data_Type_Def
#define Custom_Data_Type_Def
	typedef char				sint8;		//�з���	1�ֽ�
	typedef unsigned char		uint8;		//�޷���	1�ֽ�
	typedef short				sint16;		//�з���	2�ֽ�
	typedef unsigned short		uint16;		//�޷���	2�ֽ�
	typedef int					sint32;		//�з���	4�ֽ�
	typedef unsigned int		uint32;		//�޷���	4�ֽ�
	typedef	float				Real32;		//�з���	4�ֽ�
	typedef	double				Real64;		//�޷���	8�ֽ�
	typedef	long double			Real80;		//�з���	10�ֽ�
	typedef void*				Pointer;	//voidָ��	4�ֽ�
	typedef	sint32				BOOL;
#endif

/**********************************************************************************************************************
 * �ӿں���������ʽ����
**********************************************************************************************************************/
#ifndef Function_Export_Mode
	#ifdef WIN32
		#define Function_Export_Mode	__stdcall
	#else
		#define Function_Export_Mode
	#endif
#endif

/**********************************************************************************************************************
 * �����붨��
**********************************************************************************************************************/
#define Log_Err_Ok						0x00
#define Log_Err_Invalid_Argument		0x01
#define Log_Err_Alloc_Memory			0x02
#define Log_Err_Memory_Exceed			0x03
#define Log_Err_Create_File				0x04
#define Log_Err_Open_File				0x05
#define Log_Err_Read_File				0x06
#define Log_Err_Write_File				0x07
#define Log_Err_File_Read_End			0x08
#define Log_Err_Invalid_Config_File		0x09
#define Log_Err_Unknown_Error			0x0a
#define Log_Err_Return_Error            0x0b
#define Log_Err_Time_Error              0x0c
#define Log_Err_GetSystemInfo_Failed    0x0d
/**********************************************************************************************************************
 * ��־��¼ģʽ
**********************************************************************************************************************/
typedef enum LogMode
{
	Log_Mode_Simple	= 1,	//��ģʽ
	Log_Mode_Rollback,		//�ع�ģʽ
	Log_Mode_Date			//����ģʽ
}LogMode;

/**********************************************************************************************************************
* ��־��¼����	�ӵ͵���trace, debug. info, warn, error, crit, fatal, disable,����disable���𲻼�¼�κ���Ϣ
**********************************************************************************************************************/
typedef enum LogLevel
{
	Log_Level_Trace = 1, 
	Log_Level_Debug, 
	Log_Level_Info, 
	Log_Level_Notice, 
	Log_Level_Warn, 
	Log_Level_Error, 
	Log_Level_Crit, 
	Log_Level_Fatal, 
	Log_Level_Disable
}LogLevel;

/**********************************************************************************************************************
 * ��ȡ�ļ������к�
**********************************************************************************************************************/
#define SOURCE_INFO(log_config)	SourceInfo(log_config, __FILE__, __LINE__)

/**********************************************************************************************************************
 * ��־ʵ��
**********************************************************************************************************************/
typedef	uint32	LOGHANDLE;
static LOGHANDLE null_log_handle = 0;

/**********************************************************************************************************************
 * ��־������ƽṹ
**********************************************************************************************************************/
typedef struct LogConfigRec
{
	sint8		log_file_name[260];		//��־�ļ���

	LogMode		log_mode;				//��־ģʽ��ȡֵ��Χ��ö������LogMode
	LogLevel	log_level;				//��־����ȡֵ��Χ��ö������LogLevel
	
	uint32		max_file_size;			//�ļ�����ֽ��� 0=������ ����=�ļ�������ֽ���
	uint32		max_backup_index;		//��־ģʽΪLog_Mode_Rollbackʱ��־�ļ������������ÿ���ļ�������СΪmax_file_size(����)
	
	uint32		file_flush_size;		//0=��־��Ϣֱ��д���� ��������=��������־���������ڸ�ֵʱֱ��д�뵽����
	uint32      log_time_span ;         //��־��ʱ�䷶Χ

	sint8		log_format[64];			//��־��¼��ʽ
}LogConfigRec;

/**********************************************************************************************************************
 * ��־��¼Ĭ��
**********************************************************************************************************************/
/**********************************************************************************************************************
 * ����:	��־ʵ����ʼ��
 * ����:
 * 1 config_file	[in]	��־�����ļ���
 * 2 section		[in]	��־���ö���
 * 3 a_log_handle	[out]	������־ʵ��,���ò���Ϊ0������ʧ�ܣ���־ʵ����Ч
 * ����ֵ:
 * Log_Err_Ok=�ɹ�ʹ�������ļ���ʼ��ʵ��  Log_Err_Invalid_Config_File=ʹ��ĳЩĬ�ϲ�����ʼ��ʵ�� ����=ʧ��
 * �������ļ���ĳ�����������ڻ�Ƿ���ʹ��Ĭ�ϲ�����ʼ����־ʵ����Ĭ��ʵ�������ò������£�
 *		������				ֵ					ʹ��ʱ��
 *		log_file_name		default.log			�����ļ��л�ȡlog_file_nameʧ��ʱ
 *		log_level			Log_Level_Error		�����ļ��л�ȡlog_levelʧ��ʱ
 *		log_mode			Log_Mode_Simple		�����ļ��л�ȡlog_modeʧ��ʱ
 *		max_file_size		20971520			�����ļ��л�ȡmax_file_sizeʧ��ʱ
 *		max_backup_index	20					�����ļ��л�ȡmax_backup_indexʧ��ʱ���ع�ģʽʱ
 *		log_format			%D%T%E%N			�����ļ��л�ȡlog_formatʧ��ʱ
**********************************************************************************************************************/
typedef	sint32	(Function_Export_Mode* LOG_MODULE_INIT)(const sint8 *config_file, const sint8 *section, LOGHANDLE *a_log_handle);
	
/**********************************************************************************************************************
 * ����:	��־ʵ����ʼ��
 * ����:
 * 1 a_log_config	[in]	��־���ýṹ
 		log_file_name		��־�ļ���,����Ϊ��Ч·�������ٰ����ļ���
 		log_mode			��־ģʽ��ȡֵ��Χ��ö������LogMode
 		log_level			��־����ȡֵ��Χ��ö������LogLevel
 		max_file_size		�ļ�����ֽ���������Ϊ����
  		max_backup_index	��־ģʽΪLog_Mode_Rollbackʱ��Ч�� ��־�ļ������������ÿ���ļ�������СΪmax_file_size
 		log_format[64]		��־��¼��ʽ, %D=Date %T=time %E=level info %F=src file %L=line %N=new line, ˳���޹�,ѡ��������
 * 2 a_log_handle	[out]	������־ʵ��
 * ����ֵ:	0=�ɹ�  ����=ʧ��
**********************************************************************************************************************/
typedef	sint32	(Function_Export_Mode * LOG_MODULE_INIT_Ex)(const LogConfigRec *a_log_config, LOGHANDLE *a_log_handle);

/**********************************************************************************************************************
 * ����:	��־��¼ʵ������
 * ����:
 * 1 a_log_handle	[in/out]	�����־��¼ʵ��
 * ����ֵ: ��
**********************************************************************************************************************/
typedef	void	(Function_Export_Mode * LOG_MODULE_DESTORY)(LOGHANDLE *a_log_handle);

/**********************************************************************************************************************
 * ����:	��ȡ��־�ļ���
 * ����:
 * LOGHANDLE log_handle[in]    ��־ʵ��
 * ����ֵ:
**********************************************************************************************************************/
typedef	LogLevel (Function_Export_Mode * LOG_LEVEL)(LOGHANDLE log_handle);

/**********************************************************************************************************************
 * ����: Trace��Fatal��������־��Ϣ��¼
 * ����:
 * 1 log_handle	[in]	��־��¼ʵ��
 * 2 format		[in]	���ݸ�ʽ����
 * 3 ...		[in]	�����
 * ����ֵ:	0=�ɹ�	����=ʧ��
**********************************************************************************************************************/
typedef	sint32	(Function_Export_Mode * LOG_TRACE)	(LOGHANDLE log_handle, sint8 *format, ...);
typedef	sint32	(Function_Export_Mode * LOG_DEBUG)	(LOGHANDLE log_handle, sint8 *format, ...);
typedef	sint32	(Function_Export_Mode * LOG_INFO)	(LOGHANDLE log_handle, sint8 *format, ...);
typedef	sint32	(Function_Export_Mode * LOG_NOTICE)	(LOGHANDLE log_handle, sint8 *format, ...);
typedef	sint32	(Function_Export_Mode * LOG_WARN)	(LOGHANDLE log_handle, sint8 *format, ...);
typedef	sint32	(Function_Export_Mode * LOG_ERROR)	(LOGHANDLE log_handle, sint8 *format, ...);
typedef	sint32	(Function_Export_Mode * LOG_CRIT)	(LOGHANDLE log_handle, sint8 *format, ...);
typedef	sint32	(Function_Export_Mode * LOG_FATAL)	(LOGHANDLE log_handle, sint8 *format, ...);
/**********************************************************************************************************************
 * ����: log_handle�����е���־��Ϣǿ��д�����
 * ����:
 * 1 log_handle	[in]	��־��¼ʵ��
 * ����ֵ:	0=�ɹ�	����=ʧ��
**********************************************************************************************************************/
typedef sint32	(Function_Export_Mode * LOG_MSG_FLUSH)	(LOGHANDLE log_handle);

/**********************************************************************************************************************
 * ����: ��ȡԴ�ļ������к���Ϣ���浽log_module��
 * ����:
 * 1 log_handle			[in/out]	��־��¼ʵ��
 * 2 source_file_name	[in]		Դ�ļ���������·��
 * 3 source_file_line	[in]		�к�
 * ����ֵ:	0=ʧ�� �ɹ�ʱ����ʵ�����
 * ��Ҫ��¼Դ�ļ������кţ�log_src_file��log_src_line������Ϊ��0����־ʵ�����ʹ��SOURCE_INFO�������ã�
 * ��LOG_TRACE(SOURCE_INFO(log_handle), "hello")
**********************************************************************************************************************/
typedef LOGHANDLE (Function_Export_Mode * SourceInfo)(LOGHANDLE log_handle, const sint8 *source_file_name, sint32 source_file_line);

// #ifdef	__cplusplus
// }
// #endif
extern LOGHANDLE sdk_log_handle;

extern LOG_MODULE_INIT       LOG_MODULE_INIT_KIOSK;
extern LOG_MODULE_INIT_Ex    LOG_MODULE_INIT_Ex_KIOSK;
extern LOG_MODULE_DESTORY    LOG_MODULE_DESTORY_KIOSK;
extern LOG_LEVEL             LOG_LEVEL_KIOSK;
extern LOG_TRACE             LOG_TRACE_KIOSK;
extern LOG_DEBUG             LOG_DEBUG_KIOSK;
extern LOG_INFO              LOG_INFO_KIOSK;
extern LOG_NOTICE            LOG_NOTICE_KIOSK;
extern LOG_WARN              LOG_WARN_KIOSK;
extern LOG_ERROR             LOG_ERROR_KIOSK;
extern LOG_CRIT              LOG_CRIT_KIOSK;
extern LOG_FATAL             LOG_FATAL_KIOSK;
extern LOG_MSG_FLUSH         LOG_MSG_FLUSH_KIOSK;
extern SourceInfo            SourceInfo_KIOSK;

/**********************************************************************************************************************
* The End
**********************************************************************************************************************/
#endif
