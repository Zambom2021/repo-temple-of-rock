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

04 - Login de Usuario com Sucesso
    [Documentation]    Testa o login de Usuário com sucesso.
    [Tags]    4    Positive

    ${response_body}    ${request_body}    ${status_code}     Post Login    admin    123

    Assert Valid Login    ${response_body}    ${status_code}

05 - Login de Usuario Invalido
    [Documentation]    Testa o login de Usuário Invalido.
    [Tags]    5    

    ${response_body}    ${request_body}    ${status_code}     Post Login    Joao    9999

    Assert Invalid Login    ${response_body}    ${status_code}

06 - Login sem preencher os dados do Usuário 
    [Documentation]    Testa o sem preencher os dados do Usuário
    [Tags]    6    

    ${response_body}    ${request_body}    ${status_code}     Post Login    ${EMPTY}    ${EMPTY}

    Assert Invalid User    ${response_body}    ${status_code}

07 - Login de Usuario com senha Invalida
    [Documentation]    Testa o login de Usuário com senha Invalida.
    [Tags]    7    

    ${response_body}    ${request_body}    ${status_code}     Post Login    admin    9999

    Assert Invalid Password    ${response_body}    ${status_code}