Language: pt-br
*** Settings ***
Resource    ../../resources/resource.resource


*** Test Cases ***
01 - Cadastro de Usuario
    [Documentation]    Testa o cadastro de um usuário com dados dinâmicos.
    [Tags]    1    Positive
    ${useremail}=   Generate Valid email
    ${username}=    Generate Username
    ${password}=    Generate Password
    ${response_body}    ${request_body}    ${status_code}     Post User    ${useremail}    ${username}    ${password}

    Assert Valid User    ${response_body}    ${status_code}


01.1 - Cadastro de Usuario user Name Invalido
    [Documentation]    Testa o cadastro de um usuário com dados dinâmicos.
    [Tags]    1    
    ${useremail}=   Generate Valid email
    ${username}=    set Variable    ${EMPTY}
    ${password}=    Generate Password
    ${response_body}    ${request_body}    ${status_code}         Post Invalid User     ${useremail}   ${username}    ${password}

    Assert Invalid User    ${response_body}    ${status_code} 

01.1 - Cadastro de Usuario user password Invalido
    [Documentation]    Testa o cadastro de um usuário com dados dinâmicos.
    [Tags]    1     
    ${useremail}=   Generate Valid email
    ${username}=    Generate Username
    ${password}=    set Variable     ${EMPTY}
    ${response_body}    ${request_body}    ${status_code}         Post Invalid User     ${useremail}   ${username}    ${password}

    Assert Invalid User    ${response_body}    ${status_code} 

03 - Consultar Bandas
    [Documentation]    Testa a consulta de todas as bandas
    [Tags]    3    Positive
    ${session}      Create Session    ${SESSION_ALIAS}    ${api_url} 
    ${response}=    Get On Session    ${SESSION_ALIAS}    url=bands    
    ${staus_code}   convert to string    ${response.status_code} 
    Should Be Equal    ${staus_code}    200
    Log    ${response.json()}

04 - Consultar Discografia
    [Documentation]    Testa a consulta da discografia de uma banda específica
    [Tags]    4    Positive
    ${session}      Create Session    ${SESSION_ALIAS}    ${api_url} 
    ${response}=    Get On Session    ${SESSION_ALIAS}    url=bands/${BAND_ID}
    ${staus_code}   convert to string    ${response.status_code} 
    Should Be Equal     ${staus_code}    200

    Log    ${response.json()}

05 - Consultar Banda Por Nome
    [Documentation]    Testa a consulta de uma banda pelo nome
    [Tags]    5    Positive

    ${response_body}    ${staus_code}    Get Band by name     Kiss

    Should Be Equal         ${staus_code}    200
    Should Not Be Empty     ${response_body["_id"]}   
    Should Be Equal         ${response_body["name"]}     Kiss  

06 - Consultar Banda Por ID
    [Documentation]    Testa a consulta de uma banda pelo ID
    [Tags]    6    Positive
    ${session}      Create Session    ${SESSION_ALIAS}    ${api_url} 
    ${response}=    Get On Session    ${SESSION_ALIAS}    url=bands/search?id=${BAND_ID}
    ${staus_code}   convert to string    ${response.status_code} 
    Should Be Equal     ${staus_code}    200
    Log    ${response.json()}

07 - Alterar Banda
    [Documentation]    Testa a alteração de uma banda já cadastrada
    [Tags]    7   Positive
    ${session}      Create Session    ${SESSION_ALIAS}    ${api_url} 
    ${data}=        Create Dictionary    name=Nirvana    country=Estados Unidos    genre=Grunge    formationYear=1987    members=Kurt Cobain, Krist Novoselic, Dave Grohl, Pat Smear    
    
    ${album1}=      Create Dictionary    title=Bleach                       releaseYear=1989
    ${album2}=      Create Dictionary    title=Nevermind                    releaseYear=1991
    ${album3}=      Create Dictionary    title=In Utero                     releaseYear=1993
    ${album4}=      Create Dictionary    title=MTV Unplugged in New York    releaseYear=1994
    ${album5}=      Create Dictionary    title=The Best Of                  releaseYear=2010
    ${album6}=      Create Dictionary    title=The Collection               releaseYear=2024

    ${discography}=    Create List    ${album1}    ${album2}    ${album3}    ${album4}    ${album5}    ${album6}
    Set To Dictionary    ${data}    discography=${discography}
    # Realizando a requisição PUT
    ${response}=    Put On Session    ${SESSION_ALIAS}    url=bands/${BAND_ID}    json=${data} 
    # Validando o status da resposta
    ${status_code}=   Convert To String    ${response.status_code} 
    Should Be Equal     ${status_code}    200
    Log    ${response.json()}