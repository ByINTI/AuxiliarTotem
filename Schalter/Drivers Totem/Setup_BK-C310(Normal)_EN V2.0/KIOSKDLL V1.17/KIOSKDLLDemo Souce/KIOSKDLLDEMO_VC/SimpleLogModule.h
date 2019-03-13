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
 * 基本数据类型定义
**********************************************************************************************************************/
#ifndef Custom_Data_Type_Def
#define Custom_Data_Type_Def
	typedef char				sint8;		//有符号	1字节
	typedef unsigned char		uint8;		//无符号	1字节
	typedef short				sint16;		//有符号	2字节
	typedef unsigned short		uint16;		//无符号	2字节
	typedef int					sint32;		//有符号	4字节
	typedef unsigned int		uint32;		//无符号	4字节
	typedef	float				Real32;		//有符号	4字节
	typedef	double				Real64;		//无符号	8字节
	typedef	long double			Real80;		//有符号	10字节
	typedef void*				Pointer;	//void指针	4字节
	typedef	sint32				BOOL;
#endif

/**********************************************************************************************************************
 * 接口函数导出形式定义
**********************************************************************************************************************/
#ifndef Function_Export_Mode
	#ifdef WIN32
		#define Function_Export_Mode	__stdcall
	#else
		#define Function_Export_Mode
	#endif
#endif

/**********************************************************************************************************************
 * 错误码定义
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
 * 日志记录模式
**********************************************************************************************************************/
typedef enum LogMode
{
	Log_Mode_Simple	= 1,	//简单模式
	Log_Mode_Rollback,		//回滚模式
	Log_Mode_Date			//日期模式
}LogMode;

/**********************************************************************************************************************
* 日志记录级别	从低到高trace, debug. info, warn, error, crit, fatal, disable,其中disable级别不记录任何信息
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
 * 提取文件名及行号
**********************************************************************************************************************/
#define SOURCE_INFO(log_config)	SourceInfo(log_config, __FILE__, __LINE__)

/**********************************************************************************************************************
 * 日志实例
**********************************************************************************************************************/
typedef	uint32	LOGHANDLE;
static LOGHANDLE null_log_handle = 0;

/**********************************************************************************************************************
 * 日志输出控制结构
**********************************************************************************************************************/
typedef struct LogConfigRec
{
	sint8		log_file_name[260];		//日志文件名

	LogMode		log_mode;				//日志模式，取值范围见枚举类型LogMode
	LogLevel	log_level;				//日志级别，取值范围见枚举类型LogLevel
	
	uint32		max_file_size;			//文件最大字节数 0=不限制 其它=文件的最大字节数
	uint32		max_backup_index;		//日志模式为Log_Mode_Rollback时日志文件的最大数量，每个文件的最大大小为max_file_size(非零)
	
	uint32		file_flush_size;		//0=日志信息直接写磁盘 其它整数=缓存红的日志数据量大于该值时直接写入到磁盘
	uint32      log_time_span ;         //日志的时间范围

	sint8		log_format[64];			//日志记录格式
}LogConfigRec;

/**********************************************************************************************************************
 * 日志记录默认
**********************************************************************************************************************/
/**********************************************************************************************************************
 * 功能:	日志实例初始化
 * 参数:
 * 1 config_file	[in]	日志配置文件名
 * 2 section		[in]	日志配置段名
 * 3 a_log_handle	[out]	返回日志实例,若该参数为0，返回失败，日志实例无效
 * 返回值:
 * Log_Err_Ok=成功使用配置文件初始化实例  Log_Err_Invalid_Config_File=使用某些默认参数初始化实例 其它=失败
 * 若配置文件中某个参数不存在或非法则使用默认参数初始化日志实例，默认实例各配置参数如下：
 *		数据项				值					使用时机
 *		log_file_name		default.log			配置文件中获取log_file_name失败时
 *		log_level			Log_Level_Error		配置文件中获取log_level失败时
 *		log_mode			Log_Mode_Simple		配置文件中获取log_mode失败时
 *		max_file_size		20971520			配置文件中获取max_file_size失败时
 *		max_backup_index	20					配置文件中获取max_backup_index失败时，回滚模式时
 *		log_format			%D%T%E%N			配置文件中获取log_format失败时
**********************************************************************************************************************/
typedef	sint32	(Function_Export_Mode* LOG_MODULE_INIT)(const sint8 *config_file, const sint8 *section, LOGHANDLE *a_log_handle);
	
/**********************************************************************************************************************
 * 功能:	日志实例初始化
 * 参数:
 * 1 a_log_config	[in]	日志配置结构
 		log_file_name		日志文件名,必须为有效路径，至少包含文件名
 		log_mode			日志模式，取值范围见枚举类型LogMode
 		log_level			日志级别，取值范围见枚举类型LogLevel
 		max_file_size		文件最大字节数，必须为整数
  		max_backup_index	日志模式为Log_Mode_Rollback时有效， 日志文件的最大数量，每个文件的最大大小为max_file_size
 		log_format[64]		日志记录格式, %D=Date %T=time %E=level info %F=src file %L=line %N=new line, 顺序无关,选择性设置
 * 2 a_log_handle	[out]	返回日志实例
 * 返回值:	0=成功  其它=失败
**********************************************************************************************************************/
typedef	sint32	(Function_Export_Mode * LOG_MODULE_INIT_Ex)(const LogConfigRec *a_log_config, LOGHANDLE *a_log_handle);

/**********************************************************************************************************************
 * 功能:	日志记录实例销毁
 * 参数:
 * 1 a_log_handle	[in/out]	清空日志记录实例
 * 返回值: 无
**********************************************************************************************************************/
typedef	void	(Function_Export_Mode * LOG_MODULE_DESTORY)(LOGHANDLE *a_log_handle);

/**********************************************************************************************************************
 * 功能:	获取日志的级别
 * 参数:
 * LOGHANDLE log_handle[in]    日志实例
 * 返回值:
**********************************************************************************************************************/
typedef	LogLevel (Function_Export_Mode * LOG_LEVEL)(LOGHANDLE log_handle);

/**********************************************************************************************************************
 * 功能: Trace至Fatal各级别日志信息记录
 * 参数:
 * 1 log_handle	[in]	日志记录实例
 * 2 format		[in]	数据格式控制
 * 3 ...		[in]	变参数
 * 返回值:	0=成功	其它=失败
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
 * 功能: log_handle缓存中的日志信息强制写入磁盘
 * 参数:
 * 1 log_handle	[in]	日志记录实例
 * 返回值:	0=成功	其它=失败
**********************************************************************************************************************/
typedef sint32	(Function_Export_Mode * LOG_MSG_FLUSH)	(LOGHANDLE log_handle);

/**********************************************************************************************************************
 * 功能: 提取源文件名和行号信息保存到log_module中
 * 参数:
 * 1 log_handle			[in/out]	日志记录实例
 * 2 source_file_name	[in]		源文件名，包含路径
 * 3 source_file_line	[in]		行号
 * 返回值:	0=失败 成功时返回实例句柄
 * 若要记录源文件名或行号，log_src_file或log_src_line需配置为非0，日志实例句柄使用SOURCE_INFO进行设置，
 * 如LOG_TRACE(SOURCE_INFO(log_handle), "hello")
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
