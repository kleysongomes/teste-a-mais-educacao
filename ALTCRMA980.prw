#include "Protheus.ch"
#include "FWMVCDEF.CH"

/*/{Protheus.doc} ALTCRMA980
Ponto de entrada para atualização de dados do cliente 
@type user function
@author Kleyson Gomes
@since 29/07/2024
@version 12.1.27
@param NA
@return Boolean
@see https://centraldeatendimento.totvs.com/hc/pt-br/articles/360039466954-Cross-Segmentos-TOTVS-Backoffice-Linha-Protheus-SIGAFAT-Pontos-de-entrada-para-altera%C3%A7%C3%A3o-do-cadastro-do-cliente
@see https://centraldeatendimento.totvs.com/hc/pt-br/articles/360000146128-Cross-Segmento-TOTVS-Backoffice-Linha-Protheus-ADVPL-Ponto-de-entrada-MVC-CRMA980
@see https://centraldeatendimento.totvs.com/hc/pt-br/articles/7406000650391-Cross-Segmento-TOTVS-Backoffice-Linha-Protheus-SIGAFAT-Incidente-There-is-a-source-name-conflict-ao-utilizar-Ponto-de-Entrada
@see https://centraldeatendimento.totvs.com/hc/pt-br/articles/360019002512-Cross-Segmento-TOTVS-Backoffice-Linha-Protheus-ADVPL-Retornar-o-campo-que-esta-sendo-alterado-em-rotina-MVC
/*/
User Function CRMA980()

    local oDados        := JsonObject():New()
    Local aParam        := PARAMIXB
    Local cIdPonto      := ""
    Local nOperation    := 0
    Local lAltera       := .F.
    Local aAlterados    := {}
    Local i, j, cCampo, cJsonCampo, cValorCampo
    Local aMapeamento := { ;
        {"A1_NOME", "nome"}, ;
        {"A1_NREDUZ", "nomereduz"}, ;
        {"A1_CGC", "documento"}, ;
        {"A1_EMAIL", "email"}, ;
        {"A1_PESSOA", "tipoPessoa"}, ;
        {"A1_TEL", "telefone"}, ;
        {"A1_DDD", "ddd"} ;
    }

    If aParam == NIL
        MsgInfo("Processo de Atualização cancelado! Não foi possível identificar os parâmetros.", "Atualização de Usuário")
        Return .F.
    EndIf
    
    oObj        := aParam[1]
    cIdPonto    := aParam[2]
    aAlterados  := aParam[5]
    nOperation  := oObj:GetOperation()
    
    If cIDPonto == 'MODELCOMMITTTS' .And. nOperation == 4
        For i := 1 To Len(aAlterados)
            cCampo := aAlterados[i]
            
            For j := 1 To Len(aMapeamento)
                If cCampo == aMapeamento[j][1]
                    cJsonCampo := aMapeamento[j][2]
                    
                    cValorCampo := M->&(cCampo)
                    
                    oDados[cJsonCampo] := cValorCampo
                    lAltera := .T.
                EndIf
            Next j
        Next i
    EndIf

    If lAltera
        cJson := FWJsonSerialize(oDados) 
        If !u_AttCliente(M->A1_COD, cJson)
            MsgInfo("Processo de Atualização cancelado!","Atualização de Usuário")
            Return .F.
        EndIf
        
        MsgInfo("Dados atualizados no Time Sistemas!", "Atualização de Usuário")
    EndIf

Return .T.
