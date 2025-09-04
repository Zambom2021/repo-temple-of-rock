*** Settings ***
Resource    ../resources/resource.resource
Library     ../resources/NameGenerator.py
Library     ../resources/modelPayload.py
Library     ../resources/GenresModel.py
Library     JsonConverter.py


*** Variables ***
${api_url}            http://localhost:9090/api
${SESSION_ALIAS}      my_session

@{PRE_NAME}          The    Last     Deep    Iron    Metal     Ultimate    Best Of     
${BAND_ID}           67101fad793421e6f0cad861

*** Keywords ***
Generate Current Date
    ${date}=    DateGenerator.current_date     
    RETURN   ${date}

Generate Current Year
    ${year}=    DateGenerator.current_year     
    RETURN   ${year}

Get Numero Aleatorio
    ${new_disc}=    Generate Random Number
    RETURN    ${new_disc}

Generate Date Plus N Days
    [Arguments]    ${days}
    ${date}=    DateGenerator.future_date    ${days}
    RETURN   ${date}

Generate Date Minus N Days
    [Arguments]    ${days}
    ${date}=    DateGenerator.past_date    ${days}
    RETURN   ${date}

Post Login
    [Arguments]    ${username}    ${password}

    ${session}          Create Session       ${SESSION_ALIAS}    ${api_url} 
    ${headers}=         Create Dictionary    Content-Type=application/json
    ${request_body}=    Create Dictionary    username=${username}    password=${password}
    ${response}=        POST On Session      ${SESSION_ALIAS}    url=/user/login    json=${request_body}    expected_status=anything         
    ${status_code}       set variable         ${response.status_code}

    ${response_body}     Convert String To Json    ${response.content} 

    RETURN   ${response_body}    ${request_body}    ${status_code} 

Post User
    [Arguments]    ${useremail}    ${username}    ${password}

    ${session}          Create Session       ${SESSION_ALIAS}    ${api_url} 
    ${headers}=         Create Dictionary    Content-Type=application/json
    ${request_body}=    Create Dictionary    email=${useremail}    username=${username}    password=${password}
    ${response}=        POST On Session      ${SESSION_ALIAS}    url=/user/register    json=${request_body}    
    ${status_code}       set variable         ${response.status_code}

    ${response_body}     Convert String To Json    ${response.content} 

    RETURN   ${response_body}    ${request_body}    ${status_code} 

Post Invalid User
    [Arguments]    ${useremail}    ${username}    ${password}

    ${session}          Create Session       ${SESSION_ALIAS}    ${api_url} 
    ${headers}=         Create Dictionary    Content-Type=application/json
    ${request_body}=    Create Dictionary    email=${useremail}    username=${username}    password=${password}
    ${response}=        POST On Session      ${SESSION_ALIAS}    url=/user/register    json=${request_body}     expected_status=anything
    ${status_code}       set variable         ${response.status_code}

    ${response_body}     Convert String To Json    ${response.content} 

    RETURN   ${response_body}    ${request_body}    ${status_code} 

Get Response Body
    [Arguments]    ${response}
    [Documentation]    Obtém o corpo da resposta como texto.
    ${body} =    Convert To String    ${response.text}
    RETURN    ${body}

Post Band
    [Arguments]    ${band_name}    ${genre}    ${members}    ${formation_year}    ${country}    ${discography}
    ${session}     Create Session    ${SESSION_ALIAS}    ${api_url} 
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${request_body}=       Create Dictionary     name=${band_name}     genre=${genre}     members=${members}    formationYear=${formation_year}    country=${country}    discography=${discography}
    ${response}=    POST On Session    ${SESSION_ALIAS}    url=/bands    json=${request_body}
    ${status_code}   convert to string    ${response.status_code} 
    Should Be Equal    ${status_code}    201
    
    ${response_body} =    Set Variable     ${response.content}

    RETURN   ${response_body}    ${request_body}

Generate Valid email
    [Documentation]    Gera um email valido usuário dinâmico.
    ${useremail}=    FakerLibrary.Email
    RETURN    ${useremail}

Generate Username
    [Documentation]    Gera um nome de usuário dinâmico.
    ${username}=    FakerLibrary.Username
    RETURN    ${username}

Generate Password
    [Documentation]    Gera uma senha dinâmica.
    ${password}=    FakerLibrary.Password
    RETURN    ${password}


Get Band Name
    ${length}=    Get Length    ${PRE_NAME} 
    ${index}=     Random Int    0    ${length - 1}
    ${pre_name}=     Get From List    ${PRE_NAME}    ${index}
    ${band_name}=    FakerLibrary.Word  
    RETURN        ${pre_name} ${band_name}

Get Disc Name
    ${length}=    Get Length    ${PRE_NAME} 
    ${index}=     Random Int    0    ${length - 1}
    ${pre_name}=     Get From List    ${PRE_NAME}    ${index}
    ${band_name}=    FakerLibrary.Word  
    RETURN        ${pre_name} ${band_name}

Generate Formation Year
    [Documentation]    Gera um ano de formação dinâmico.
    ${year}=    FakerLibrary.Year
    RETURN    ${year}


Generate Country
    [Documentation]    Gera um país dinâmico.
    ${country}=    FakerLibrary.Country
    RETURN    ${country}

Generate Discography
    [Documentation]    Gera uma discografia dinâmica.
    ${discography}=    FakerLibrary.Words    3
    RETURN    ${discography}

Generate Members
    [Arguments]    ${qtd}
    [Documentation]    Gera nomes de Membros da Banbda dinâmicos.
    ${members}=    generate_members_name    ${qtd} 
    RETURN    ${members}   

Get Band by name
    [Arguments]    ${band_Name}

    ${session}      Create Session    ${SESSION_ALIAS}    ${api_url} 
    ${response}=    Get On Session    ${SESSION_ALIAS}    url=bands/search?name=${band_Name}    expected_status=anything
    ${status_code}   convert to string    ${response.status_code} 

    &{band_data}     Set Variable   ${response.json()}
 
    RETURN    ${band_data}    ${status_code}

Get Band by letter
    [Arguments]    ${letter}

    ${session}      Create Session    ${SESSION_ALIAS}    ${api_url} 
    ${response}=    Get On Session    ${SESSION_ALIAS}    url=bands/startingWith?letter=${letter}
    ${status_code}   convert to string    ${response.status_code} 

    ${band_data}     Set Variable   ${response.json()}
 
    RETURN    ${band_data}    ${status_code}

Get All Bands
    [Arguments]    
    ${session}      Create Session    ${SESSION_ALIAS}    ${api_url} 
    ${response}=    Get On Session    ${SESSION_ALIAS}    url=bands
    ${status_code}   convert to string    ${response.status_code} 

    ${band_data}     Set Variable   ${response.json()} 
    ${empty_band}    find_empty_discography    ${band_data}    

    RETURN    ${empty_band}    


Delete Band
    [Arguments]    ${band_id}

    ${session}      Create Session    ${SESSION_ALIAS}    ${api_url} 
    ${response}=    DELETE On Session    ${SESSION_ALIAS}    url=bands/${band_id}       expected_status=anything
    ${status_code}   convert to string    ${response.status_code} 

    # ${response_body}     Set Variable   ${response.json()} 
 
    RETURN       ${status_code}      


que eu gere dados validos para cadastro de usuario
    [Documentation]    Gera um email, nome de usuário e senha válidos.
    ${useremail}=   Generate Valid email
    ${username}=    Generate Username
    ${password}=    Generate Password

    RETURN     ${useremail}    ${username}    ${password}

que eu gere dados invalidos para cadastro de usuario
    [Documentation]    Gera dados invalidos para cadastro de usuário.
    ${useremail}=   set variable    meuemail&meudominio.com
    ${username}=    Generate Username
    ${password}=    Generate Password

    RETURN     ${useremail}    ${username}    ${password}


eu realizar a requisição para cadastro do usuário
    [Arguments]    ${useremail}    ${username}    ${password}
    [Documentation]    Envia uma requisição para a API de cadastro de usuário.

    ${response_body}        ${request_body}        ${status_code}     
    ...    Post User    ${useremail}    ${username}    ${password}
    
    RETURN        ${response_body}        ${request_body}        ${status_code}   

eu realizar a requisição com dados invalidos para cadastro do usuário
    [Arguments]    ${useremail}    ${username}    ${password}
    [Documentation]    Envia uma requisição para a API de cadastro de usuário.

    ${response_body}        ${request_body}        ${status_code}     
    ...    Post Invalid User    ${useremail}    ${username}    ${password}
    
    RETURN        ${response_body}        ${request_body}        ${status_code} 


