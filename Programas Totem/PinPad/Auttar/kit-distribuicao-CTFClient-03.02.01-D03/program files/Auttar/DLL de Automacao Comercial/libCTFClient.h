/*
 * Biblioteca de Automação Comercial
 *
 * API para facilitar integração com CTF Client
 */

/*prevent multiple includes*/
#ifndef _H_AUTTAR_BIBLIOTECA_AC_CTF
#define _H_AUTTAR_BIBLIOTECA_AC_CTF

/*useful definitions*/
#ifndef BOOL
  #define BOOL int
#endif

#ifndef TRUE
  #define TRUE 1
#endif

#ifndef FALSE
  #define FALSE 0
#endif

#ifndef NULL
  #ifdef __cplusplus
    #define NULL 0
  #else
    #define NULL ((void *)0)
  #endif
#endif

/*OS specific*/
#ifdef _WIN32
  #define CTF_API  __stdcall
#else
  #define CTF_API  
#endif

/*make this code usable by C++*/
#ifdef __cplusplus 
  extern "C" {
#endif

/*API function calls*/
void CTF_API iniciaClientCTF(char* resultado, 
                             char* terminal, 
                             char* versao_ac, 
                             char* nome_ac, 
                             char* num_sites, 
                             char* lista_ips, 
                             char* criptografia,
                             char* log,
                             char* interativo,
                             char* parametros);

void CTF_API iniciaTransacaoCTF(char* resultado, 
                                char* operacao, 
                                char* valor, 
                                char* num_doc, 
                                char* data_cli, 
                                char* num_trans );

void CTF_API iniciaTransacaoCTFext(char* resultado,
                                   char* operacao,
                                   char* valor,
                                   char* num_doc,
                                   char* data_cli,
                                   char* num_trans,
                                   char* dados);

void CTF_API continuaTransacaoCTF(char* resultado, 
                                  char* comando, 
                                  char* num_sc, 
                                  char* p_sc, 
                                  char* tam_sc, 
                                  char* aux);

void CTF_API finalizaTransacaoCTF(char* resultado, 
                                  char* confirmar, 
                                  char* num_trans, 
                                  char* data_cli );

void CTF_API finalizaTransacaoCTFext(char *resultado,
                                     char *confirmar,
                                     char *num_trans,
                                     char *data_cli,
                                     char *dados);

void CTF_API erroEspecifico(char* descricao);

/*make this code usable by C++*/
#ifdef __cplusplus 
    }
#endif

/*end of multiple-include prevention*/
#endif
