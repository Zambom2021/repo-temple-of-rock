Language: pt-br
*** Settings ***
Resource    ../../resources/resource.resource


*** Test Cases ***
01 - Cadastro de Usuario
    [Documentation]    Testa o cadastro de um usuário com dados válidos e verifica se o usuário é criado com sucesso, retornando status 201.
    [Tags]    1    Positive
    ${useremail}=   Generate Valid email
    ${username}=    Generate Username
    ${password}=    Generate Password
    ${response_body}    ${request_body}    ${status_code}     Post User    ${useremail}    ${username}    ${password}

    Assert Valid User    ${response_body}    ${status_code}


02 - Cadastro de Usuario user Name Invalido
    [Documentation]    Testa o cadastro de um usuário com email e senha válidos, mas sem nome de usuário. Espera erro de validação e status 400.
    [Tags]    2    Negative    
    ${useremail}=   Generate Valid email
    ${username}=    set Variable    ${EMPTY}
    ${password}=    Generate Password
    ${response_body}    ${request_body}    ${status_code}         Post Invalid User     ${useremail}   ${username}    ${password}

    Assert Invalid User    ${response_body}    ${status_code} 

03 - Cadastro de Usuario user password Invalido
    [Documentation]    Testa o cadastro de um usuário com email e nome válidos, mas sem senha. Espera erro de validação e status 400.
    [Tags]    3    Negative    
    ${useremail}=   Generate Valid email
    ${username}=    Generate Username
    ${password}=    set Variable     ${EMPTY}
    ${response_body}    ${request_body}    ${status_code}         Post Invalid User     ${useremail}   ${username}    ${password}

    Assert Invalid User    ${response_body}    ${status_code} 

04 - Login de Usuario com Sucesso
    [Documentation]    Testa o login de usuário com credenciais válidas. Espera autenticação bem-sucedida e status 200.
    [Tags]    4    Positive

    ${response_body}    ${request_body}    ${status_code}     Post Login    admin    123

    Assert Valid Login    ${response_body}    ${status_code}

05 - Login de Usuario Invalido
    [Documentation]    Testa o login com usuário e senha inválidos. Espera falha na autenticação e status 401.
    [Tags]    5     Negative   

    ${response_body}    ${request_body}    ${status_code}     Post Login    Joao    9999

    Assert Invalid Login    ${response_body}    ${status_code}

06 - Login sem preencher os dados do Usuário 
    [Documentation]    Testa o login sem informar usuário e senha. Espera erro de validação e status 400.
    [Tags]    6    Negative    

    ${response_body}    ${request_body}    ${status_code}     Post Login    ${EMPTY}    ${EMPTY}

    Assert Invalid User    ${response_body}    ${status_code}

07 - Login de Usuario com senha Invalida
    [Documentation]    Testa o login com usuário válido e senha inválida. Espera falha na autenticação e status 401.
    [Tags]    7    Negative    

    ${response_body}    ${request_body}    ${status_code}     Post Login    admin    9999

    Assert Invalid Password    ${response_body}    ${status_code}