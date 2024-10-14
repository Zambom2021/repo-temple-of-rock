*** Settings ***
Resource          resource.resource

*** Variables ***
${URL}            http://localhost:9090/web
${BROWSER_HL}     headlessfirefox
${BROWSER}        firefox

*** Keywords ***

Abrir Navegador 
    Open Browser    browser=${BROWSER}
    Go To           url=${URL}

Fechar Navegador
    Close Browser

que acesse a opcao de login
    Click Link    Login

digito os dados para cadastrar um Novo usuario e clico no botão registrar
    ${useremail}      Generate Valid email
    ${username}       Generate Username
    ${password}       Generate Password
    Input Text        id=registerUsername       ${username} 
    Input Text        id=registerPassword       ${password}  
    Input Text        id=registerEmail          ${useremail}
    Click Button      id=registerBtn

digito os dados para cadastrar um Novo usuario com email Invalido e clico no botão registrar 
    ${useremail}      Generate Valid email
    ${username}       Generate Username
    ${password}       Generate Password
    Input Text        id=registerUsername       ${username} 
    Input Text        id=registerPassword       ${password}  
    Input Text        id=registerEmail          email&email.com
    Click Button      id=registerBtn

digito os dados de usuario "${USER}" e senha "${PSW}" e clico no botão login
    Input Text        id=username        ${USER}
    Input Text        id=password        ${PSW}
    Click Button      id=loginBtn


