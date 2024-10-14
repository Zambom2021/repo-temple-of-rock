Language: pt-br
*** Settings ***
Resource   ../../resources/resource.resource  
     
Test Setup       Abrir Navegador 
Test Teardown    Fechar Navegador

*** Test Cases ***
01 - Cadastro de Novo Usuário com Sucesso
    [Documentation]    Testa o Cadastro de novo usuário com sucesso
    [Tags]    1

    Dado que acesse a opcao de login
    Quando digito os dados para cadastrar um Novo usuario e clico no botão registrar
    Então devo ver a mensagem "Usuário registrado com sucesso!"

02 - Cadastro de Novo Usuário com Email Invalido
    [Documentation]    Testa o Cadastro de novo usuário com Email Invalido
    [Tags]    2

    Dado que acesse a opcao de login
    Quando digito os dados para cadastrar um Novo usuario com email Invalido e clico no botão registrar
    Então devo ver a mensagem "Erro no registro. Tente novamente."

03 - Login com sucesso
    [Documentation]    Testa o Login de usuário com sucesso
    [Tags]    3
   
    Dado que acesse a opcao de login
    Quando digito os dados de usuario "admin" e senha "123" e clico no botão login
    Então devo ver a mensagem "Login realizado com sucesso!"

04 - Login com senha Invalida
    [Documentation]    Testa o Login com senha invalida
    [Tags]    4
        
    Dado que acesse a opcao de login
    Quando digito os dados de usuario "admin" e senha "ABCDF123456" e clico no botão login
    Então devo ver a mensagem "Usuário ou senha incorretos."

05 - Login com Usuario Invalido
    [Documentation]    Testa o Login com usuário Invalido
    [Tags]    5
       
    Dado que acesse a opcao de login
    Quando digito os dados de usuario "ADMINISTRADOR" e senha "123" e clico no botão login
    Então devo ver a mensagem "Usuário ou senha incorretos."


06 - Login com Usuario em Branco
    [Documentation]    Testa o Login com usuário em Branco
    [Tags]    6
       
    Dado que acesse a opcao de login
    Quando digito os dados de usuario "${EMPTY}" e senha "123" e clico no botão login
    Então devo ver a mensagem "Por favor, preencha os campos de usuário e senha."

07 - Login com senha em Branco
    [Documentation]    Testa o Login com senha em Branco
    [Tags]    7
        
    Dado que acesse a opcao de login
    Quando digito os dados de usuario "admin" e senha "${EMPTY}" e clico no botão login
    Então devo ver a mensagem "Por favor, preencha os campos de usuário e senha."

