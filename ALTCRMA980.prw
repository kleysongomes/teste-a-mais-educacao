#include "Protheus.ch"
#include "FWMVCDEF.CH"

/*/{Protheus.doc} ALTCRMA980
(long_description)
@type user function
@author Kleyson Gomes
@since 29/07/2024
@version 12.1.27
@param 
@return 
@see https://centraldeatendimento.totvs.com/hc/pt-br/articles/360039466954-Cross-Segmentos-TOTVS-Backoffice-Linha-Protheus-SIGAFAT-Pontos-de-entrada-para-altera%C3%A7%C3%A3o-do-cadastro-do-cliente
@see https://centraldeatendimento.totvs.com/hc/pt-br/articles/360000146128-Cross-Segmento-TOTVS-Backoffice-Linha-Protheus-ADVPL-Ponto-de-entrada-MVC-CRMA980
@see https://centraldeatendimento.totvs.com/hc/pt-br/articles/7406000650391-Cross-Segmento-TOTVS-Backoffice-Linha-Protheus-SIGAFAT-Incidente-There-is-a-source-name-conflict-ao-utilizar-Ponto-de-Entrada
@see https://centraldeatendimento.totvs.com/hc/pt-br/articles/360019002512-Cross-Segmento-TOTVS-Backoffice-Linha-Protheus-ADVPL-Retornar-o-campo-que-esta-sendo-alterado-em-rotina-MVC
/*/
User Function CRMA980()

    Local oObj          := Nil
    local oData         := JsonObject():New()
    Local cPath         := "/api/users/update/"
    Local aParam        := PARAMIXB
    Local xRet          := .T.
    Local cIdPonto      := ""
    Local nOperation    := 0
    Local lSucesso      := .T.
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

    If aParam != NIL
        Help(NIL, NIL, "Cancelado", NIL, "Objeto não informado.", 1, 0, NIL, NIL, NIL, NIL, NIL, NIL)
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
                    
                    oData[cJsonCampo] := cValorNovo
                    lSucesso := .T.
                EndIf
            Next j
        Next i
        
        If !lSucesso
            Help(NIL, NIL, "Cancelado", NIL, "Nenhum campo relevante foi alterado.", 1, 0, NIL, NIL, NIL, NIL, NIL, NIL)
            return lSucesso
        EndIf
        cPath += M->A1_COD

        jResponse := AttClient(cPath, oData)
    EndIf

Return lSucesso


/*/{Protheus.doc} nomeStaticFunction
    (long_description)
    @type  Static Function
    @author user
    @since 29/07/2024
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function AttClient(cPath, oData)
    Local oRestClient   := FWRest():New("http://iws.grupoa.com.br/")
    Local oResponse     := JsonObject():new()
    Local RequestMehtod := "PUT"
    Local aHeaders := {'Content-Type: application/json',;
                  'Authorization: BASIC ' + Encode64('cHJvdGhldXMtaU50ZWdyYXRpb246WWQ0bHZAUk14Z25AcEgwcEMPXk9lITk0')}
    
    cJson := FWJsonSerialize(oData) 
    oRestClient:SetPostParams(cJson)
    
    oResponse := oRestClient:PutAttCli(cPath, RequestMehtod, oData)
    
Return oResponse
