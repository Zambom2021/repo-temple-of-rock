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


02 - Cadastro de Usuario user Name Invalido
    [Documentation]    Testa o cadastro de um usuário com dados dinâmicos.
    [Tags]    2    
    ${useremail}=   Generate Valid email
    ${username}=    set Variable    ${EMPTY}
    ${password}=    Generate Password
    ${response_body}    ${request_body}    ${status_code}         Post Invalid User     ${useremail}   ${username}    ${password}

    Assert Invalid User    ${response_body}    ${status_code} 

03 - Cadastro de Usuario user password Invalido
    [Documentation]    Testa o cadastro de um usuário com dados dinâmicos.
    [Tags]    3    
    ${useremail}=   Generate Valid email
    ${username}=    Generate Username
    ${password}=    set Variable     ${EMPTY}
    ${response_body}    ${request_body}    ${status_code}         Post Invalid User     ${useremail}   ${username}    ${password}

    Assert Invalid User    ${response_body}    ${status_code} 
