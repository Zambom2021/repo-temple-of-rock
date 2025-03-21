*** Settings ***
Library    JSONLibrary
*** Keywords ***

Assert Valid User
    [Arguments]    ${response}     ${status_code} 
    
    ${resp_str}     Convert to String    ${response}

    Should Be Equal As Numbers    ${status_code}               201
    Should Be Equal               ${resp_str}               {'message': 'Usuário registrado com sucesso!'}

Assert Invalid User
    [Arguments]    ${response}    ${status_code} 

    ${resp_str}     Convert to String    ${response}

    IF    '${status_code}' == '500'
        Should Be Equal As Numbers    ${status_code}     500 
        Should Be Equal               ${resp_str}        {'message': 'Erro ao registrar usuário. Tente novamente.'}
    ELSE IF    '${status_code}' == '400'
        Should Be Equal As Numbers    ${status_code}     400 
        Should Be Equal               ${resp_str}        {'message': 'Por favor, preencha todos os campos.'}
    END

Assert Cadastro Banda
    [Arguments]    ${response}    ${request_body}    ${status_code} 

    Should Be Equal               ${status_code}                   201
    Should Not Be Empty           ${response["_id"]} 
    Should Be Equal               ${response["name"]}              ${request_body["name"]}  
    Should Be Equal               ${response["genre"]}             ${request_body["genre"]} 
    Should Be Equal               ${response["country"]}           ${request_body["country"]} 
    Should Be Equal As Numbers    ${response["formationYear"]}     ${request_body["formationYear"]} 
    Should Be Equal               ${response["members"]}           ${request_body["members"]}

    ${disc_request}=    Get Length    ${request_body["discography"]}

    FOR     ${index}    IN RANGE    ${disc_request}
        Should Be Equal        ${response["discography"][${index}]["title"]}         ${request_body["discography"][${index}]["title"]}
        Should Be Equal        ${response["discography"][${index}]["releaseYear"]}   ${request_body["discography"][${index}]["releaseYear"]}
        Should Not Be Empty    ${response["discography"][${index}]["_id"]}
        Evaluate    ${index}+1
    END
     
Assert Consulta Banda    
    [Arguments]    ${response_Band}        ${request_body} 

    Should Be Equal               ${response_Band["name"]}              ${request_body["name"]}  
    Should Be Equal               ${response_Band["genre"]}             ${request_body["genre"]} 
    Should Be Equal               ${response_Band["country"]}           ${request_body["country"]} 
    Should Be Equal As Numbers    ${response_Band["formationYear"]}     ${request_body["formationYear"]} 
    Should Be Equal               ${response_Band["members"]}           ${request_body["members"]}

    ${disc_request}=    Get Length    ${request_body["discography"]}

    FOR     ${index}    IN RANGE    ${disc_request}
        Should Be Equal        ${response_Band["discography"][${index}]["title"]}         ${request_body["discography"][${index}]["title"]}
        Should Be Equal        ${response_Band["discography"][${index}]["releaseYear"]}   ${request_body["discography"][${index}]["releaseYear"]}
        Evaluate    ${index}+1
    END

eu devo validar a resposta 
    [Arguments]    ${response}      ${status_code}
    [Documentation]    Valida o código de status e a mensagem da resposta.
    
    IF    '${status_code}' == '201' 
        Assert Valid User
        ...    ${response}    ${status_code} 
    ELSE
        Assert Invalid User
        ...    ${response}    ${status_code} 
    END
