/*/{Protheus.doc} AttCliente
    Fun��o para comunica��o com a API de atualiza��o de dados do cliente
    @type  user Function
    @author Kleyson Gomes
    @since 29/07/2024
    @version 12.1.27
    @param CodCli, cJson
    @return Boolean
    @example
    (examples)
    @see https://tdn.totvs.com.br/display/public/framework/FWRest
/*/
User Function AttCliente(CodCli, cJson)
    Local cBaseUrl      := "http://iws.grupoa.com.br/"
    Local aHeaders      := {'Content-Type: application/json',;
                                'Authorization: BASIC cHJvdGhldXMtaU50ZWdyYXRpb246WWQ0bHZAUk14Z25AcEgwcEMPXk9lITk0'}
    Local cPath         := "/api/users/update/" + CodCli
    Local lResponse     := .F.
    Local cRet          := ""
    
    oRest := FWRest():New(cBaseUrl)
    oRest:SetPath(cPath)

    lResponse := oRest:Put(aHeaders, cJson) 
    
    If !lResponse
        cRet := oRest:GetLastError()
        MsgInfo("Erro ao atualizar os dados do cliente no Time Sistemas! Erro: " + cRet, "Atualiza��o de Usu�rio")
    EndIf

Return lResponse
