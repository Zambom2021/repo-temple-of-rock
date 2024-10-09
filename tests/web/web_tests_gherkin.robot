Language: pt-br
*** Settings ***
Suite Setup       Setup Suite
Suite Teardown    Teardown Suite
Test Setup        Setup Test
Test Teardown     Teardown Test
Library           SeleniumLibrary
Library           FakerLibrary



*** Variables ***
${URL}            http://localhost:9090/web
${BROWSER_HL}     headlessfirefox

${username}    admin
${password}    123

*** Keywords ***

Setup Suite
    Log    Iniciando Suite de Testes


Teardown Suite
    Log    Finalizando Suite de Testes


Setup Test
    Log    Iniciando o teste


Teardown Test
    Log    Finalizando o teste
    Capture Page Screenshot
    Close Browser
Dado que o browser está aberto
    [Arguments]    ${url}
    Open Browser    ${url}  firefox

eu clico no link de login
    Click Link    Login

eu preencho o usuário com ${username} e a senha com ${password}
    Input Text    id=username    ${username}
    Input Text    id=password    ${password}

E eu clico no botão de login
    Click Button  id=loginBtn

eu devo ver a mensagem de sucesso
    Wait Until Page Contains    Login realizado com sucesso!
    Page Should Contain         Login realizado com sucesso!

E eu fecho o browser
    Capture Page Screenshot
    Close Browser

*** Test Cases ***
01 - Login com sucesso
    [Tags]    1
    Dado que o browser está aberto    ${URL}
    E eu clico no link de login
    Quando eu preencho o usuário com ${username} e a senha com ${password}
    E eu clico no botão de login
    Então eu devo ver a mensagem de sucesso
    E eu fecho o browser

02 - Login com senha inválida
    Dado que o browser está aberto    ${URL}
    Quando eu clico no link de login
    E eu preencho o usuário com    admin    e a senha com    xxxxxxxxx
    E eu clico no botão de login
    Então eu devo ver a mensagem "Usuário ou senha incorretos."
    E eu fecho o browser

03 - Login com senha em branco
    Dado que o browser está aberto    ${URL}
    Quando eu clico no link de login
    E eu preencho o usuário com    admin    e a senha com    ${EMPTY}
    E eu clico no botão de login
    Então eu devo ver a mensagem "Por favor, preencha os campos de usuário e senha."
    E eu fecho o browser


