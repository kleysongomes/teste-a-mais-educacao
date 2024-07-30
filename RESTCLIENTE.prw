#include 'protheus.ch'
#Include 'RestFul.CH'
#INCLUDE "TOPCONN.CH"

WSRESTFUL RESTCLIENTES DESCRIPTION "Serviço REST para atualização de cliente " FORMAT "application/json,text/html"

	WSDATA cpf As String
	WSDATA alter As String
	WSDATA token As String

	WSMETHOD PUT PutAttCli ;
		DESCRIPTION "Altera dados do cliente" ;
		WSSYNTAX "/api/users/update" ;
		PATH "/api/users/update" ;
		PRODUCES APPLICATION_JSON

END WSRESTFUL
