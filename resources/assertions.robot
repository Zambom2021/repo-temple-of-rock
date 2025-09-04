*** Settings ***
Library    JSONLibrary

*** Keywords ***
Assert Valid Login
    [Arguments]    ${response}     ${status_code} 
    
    ${resp_str}     Convert to String    ${response}

    Should Be Equal As Numbers    ${status_code}            200
    Should Be Equal               ${resp_str}               {'message': 'Login realizado com sucesso!'}

Assert Invalid Login
    [Arguments]    ${response}     ${status_code} 
    
    ${resp_str}     Convert to String    ${response}

    Should Be Equal As Numbers    ${status_code}            401
    Should Be Equal               ${resp_str}               {'message': 'Usuário não encontrado.'}

Assert Invalid Password
    [Arguments]    ${response}     ${status_code} 
    
    ${resp_str}     Convert to String    ${response}

    Should Be Equal As Numbers    ${status_code}            401
    Should Be Equal               ${resp_str}               {'message': 'Senha incorreta.'}

Assert Valid User
    [Arguments]    ${response}     ${status_code} 
    
    ${resp_str}     Convert to String    ${response}

    Should Be Equal As Numbers    ${status_code}            201
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

    Should Be Equal                   ${status_code}                   201
    Should Not Be Empty               ${response["_id"]} 
    Should Be Equal As Strings        ${response["name"]}              ${request_body["name"]}    ignore_case=True  
    Should Be Equal As Strings        ${response["genre"]}             ${request_body["genre"]} 
    Should Be Equal As Strings        ${response["country"]}           ${request_body["country"]} 
    Should Be Equal As Numbers        ${response["formationYear"]}     ${request_body["formationYear"]} 
    Should Be Equal                   ${response["members"]}           ${request_body["members"]}

    ${disc_request}=    Get Length    ${request_body["discography"]}

    FOR     ${index}    IN RANGE    ${disc_request}
        Should Be Equal        ${response["discography"][${index}]["title"]}         ${request_body["discography"][${index}]["title"]}
        Should Be Equal        ${response["discography"][${index}]["releaseYear"]}   ${request_body["discography"][${index}]["releaseYear"]}
        Should Not Be Empty    ${response["discography"][${index}]["_id"]}
        Evaluate    ${index}+1
    END
     
Assert Consulta Banda    
    [Arguments]    ${response_Band}        ${status_Code}     

    Should Be Equal         ${status_code}    200
    Should Not Be Empty     ${response_Band["_id"]}   
    Should Be Equal         ${response_Band["name"]}     Metal Factor  

    ${disc_request}=    Get Length    ${response_Band["discography"]}

Assert List Band    
    [Arguments]    ${response_Band}        ${status_Code}    ${letter}  

    Should Be Equal         ${status_code}    200
    
    FOR    ${band}    IN    @{response_Band}
        Should Not Be Empty    ${band["_id"]}
        Should Contain         ${band["name"]}    ${letter}
    END
    
Assert Delete Message    
    [Arguments]     ${status_code}     ${message}
       
    Should Be Equal     ${status_code}        200
    Should Be Equal     ${message}            "Banda removida com sucesso"

Assert Duplicate Registration    
    [Arguments]     ${status_code}     ${message}
       
    Should Be Equal     ${status_code}        409
    Should Be Equal     ${message}            "Banda já cadastrada."

Assert Update Band   
    [Arguments]    ${response_Up}    ${request_Up}    ${status_code}

    Should Be Equal               ${status_code}                      200
    Should Not Be Empty           ${response_Up["_id"]}
    Should Be Equal As Strings    ${response_Up["name"]}              ${request_Up["name"]}        ignore_case=True  
    Should Be Equal As Strings    ${response_Up["genre"]}             ${request_Up["genre"]} 
    Should Be Equal As Strings    ${response_Up["country"]}           ${request_Up["country"]} 
    Should Be Equal As Numbers    ${response_Up["formationYear"]}     ${request_Up["formationYear"]} 
    Should Be Equal               ${response_Up["members"]}           ${request_Up["members"]}    
    Should Not Be Empty           ${response_Up["discography"]}     

Assert Invalid Band Registration         
    [Arguments]     ${status_code}     ${message}
       
    Should Be Equal     ${status_code}        400
    Should Be Equal     ${message}            "Band validation failed: name: Path `name` is required."

Assert Invalid Year Formation Band       
    [Arguments]     ${status_code}     ${message}
       
    Should Be Equal     ${status_code}        400
    Should Be Equal     ${message}            "Ano de formação inválido."

Assert Band Not Found    
    [Arguments]     ${status_code}    ${message}

    Should Be Equal As Numbers    ${status_code}     404
    Should Be Equal               ${message}         "message":"Banda não encontrada."