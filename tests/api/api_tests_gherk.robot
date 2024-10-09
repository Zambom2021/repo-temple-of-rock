Language: pt-br
*** Settings ***
# Library     ../../resources/convert_payload.py
Resource    ../../resources/resource.resource

*** Test Cases ***
01 - Cadastro de Usuario
    [Documentation]    Testa o cadastro de um usuário com dados Validos.
    [Tags]    1    Positive

    Dado que eu gere dados validos para cadastro de usuario
    ${useremail}=   Generate Valid email
    ${username}=    Generate Username
    ${password}=    Generate Password

    ${response_body}    ${request_body}        ${status_code} 
    ...    Quando eu realizar a requisição para cadastro do usuário
    ...    ${useremail}    ${username}    ${password}

    Então eu devo validar a resposta        
    ...    ${response_body}    ${status_code} 


01.1 - Cadastro de Usuario com email invalido 
    [Documentation]    Testa o cadastro de um usuário com "CAMPO EMAIL" invalido.
    [Tags]    1    
   
    Dado que eu gere dados invalidos para cadastro de usuario
    ${Invalidemail}=   set variable    meuemail&meuemailo.com
    ${username}=       Generate Username
    ${password}=       Generate Password
    
    ${response_body}    ${request_body}        ${status_code} 
    ...    Quando eu realizar a requisição com dados invalidos para cadastro do usuário
    ...    ${Invalidemail}    ${username}    ${password}

    Então eu devo validar a resposta        
    ...    ${response_body}    ${status_code} 

01.2 - Cadastro de Usuario com email Vazio
    [Documentation]    Testa o cadastro de um usuário com "CAMPO EMAIL" Vazio.
    [Tags]    1    Positive

    Dado que eu gere dados invalidos para cadastro de usuario
    ${useremail}=      set variable    ${EMPTY}
    ${username}=       Generate Username
    ${password}=       Generate Password

    ${response_body}    ${request_body}        ${status_code} 
    ...    Quando eu realizar a requisição com dados invalidos para cadastro do usuário
    ...    ${useremail}    ${username}    ${password}

    Então eu devo validar a resposta        
    ...    ${response_body}    ${status_code} 