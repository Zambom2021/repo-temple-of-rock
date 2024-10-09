*** Settings ***
Library           SeleniumLibrary
Library           FakerLibrary
Library           Collections
Resource          ../../resources/resource.resource

*** Variables ***
${URL}    http://localhost:9090/web    

${BROWSER_chrome}        chrome
${BROWSER_edge}          edge
${BROWSER}               firefox 
${BROWSER_HL}            headlessfirefox 


*** Test Cases ***
00 - Cadastro de Novo Usuário com Sucesso
    [Documentation]    Testa o Cadastro de novo usuário com sucesso
    [Tags]    0
    Open Browser    ${URL}  ${BROWSER}     
    Click Link    Login
    ${useremail}=   Generate Valid email
    ${username}=    Generate Username
    ${password}=    Generate Password
    Input Text    id=registerUsername       ${username} 
    Input Text    id=registerPassword       ${password}  
    Input Text    id=registerEmail          ${useremail}
    Click Button  id=registerBtn
    Wait Until Page Contains    Usuário registrado com sucesso! 
    Page Should Contain    Usuário registrado com sucesso!
    Capture Page Screenshot   
    Close Browser
01 - Login com sucesso
    [Documentation]    Testa o Login de um usuário com Sucesso
    [Tags]    1
    Open Browser    ${URL}  ${BROWSER}     
    Click Link    Login
    Input Text    id=username    admin
    Input Text    id=password    123
    Click Button  id=loginBtn
    Wait Until Page Contains    Login realizado com sucesso! 
    Page Should Contain    Login realizado com sucesso!
    Capture Page Screenshot   
    Close Browser

02 - Login com senha Invalida
    [Documentation]    Testa o Login com senha Invalida
    [Tags]    2
    Open Browser    ${URL}  ${BROWSER} 
    Click Link    Login
    Input Text    id=username    admin
    Input Text    id=password    xxxxxxxxx
    Click Button  id=loginBtn
    Wait Until Page Contains    Usuário ou senha incorretos.
    Page Should Contain    Usuário ou senha incorretos.
    Capture Page Screenshot   
    Close Browser

03 - Login com senha Branco
    [Documentation]    Testa o LLogin com senha Branco
    [Tags]    3
    Open Browser    ${URL}  ${BROWSER} 
    Click Link    Login
    Input Text    id=username    admin
    Input Text    id=password    ${EMPTY}
    Click Button  id=loginBtn
    Wait Until Page Contains    Por favor, preencha os campos de usuário e senha.
    Page Should Contain    Por favor, preencha os campos de usuário e senha.
    Capture Page Screenshot   
    Close Browser

04 - Login com usuário em Branco
    [Documentation]    Testa o Login com usuário em Branco
    [Tags]    4
    Open Browser    ${URL}  ${BROWSER} 
    Click Link    Login
    Input Text    id=username    ${EMPTY}
    Input Text    id=password    123
    Click Button  id=loginBtn
    Wait Until Page Contains    Por favor, preencha os campos de usuário e senha.
    Page Should Contain    Por favor, preencha os campos de usuário e senha.
    Capture Page Screenshot   
    Close Browser

05 - Login com Usuário Invalido
    [Documentation]    Testa o Login com Usuário Invalido
    [Tags]    5
    Open Browser    ${URL}  ${BROWSER} 
    Click Link    Login
    Input Text    id=username    Adimin
    Input Text    id=password    123
    Click Button  id=loginBtn
    Wait Until Page Contains    Usuário ou senha incorretos.
    Page Should Contain    Usuário ou senha incorretos.
    Capture Page Screenshot   
    Close Browser


06 - Consulta de Banda por Nome
    [Documentation]    Testa a Consulta de Banda por Nome
    [Tags]    6
    Open Browser         ${URL}    ${BROWSER}                   
    Input Text           id=searchBand    Nirvana
    Click Button         id=searchByNameBtn

    Wait Until Element Is Visible    xpath=//h2[contains(.,'Detalhes da Banda')]    10s
    Wait Until Element Is Visible    xpath=//span[contains(.,'Nirvana')]
    Page Should Contain     Nirvana
    Capture Page Screenshot
    Click Button    xpath=//button[@class='back-button']
    Wait Until Element Is Visible   xpath=//input[contains(@placeholder,'Digite o nome da banda')]
    sleep  5s
    Close Browser

07 - Consulta Lista de Bandas pela letra Inicial do nome
    [Documentation]    Testa a Consulta Lista de Bandas pela letra Inicial do nome na Web
    [Tags]    7
   Open Browser         ${URL}     ${BROWSER}   
    Input Text           id=letterSearch   b
    Click Button         id=searchByLetterBtn
 
    Wait Until Element Is Visible   xpath=//h1[contains(.,'Lista de bandas Cadastradas')]    10s
    Page Should Contain  Lista de bandas Cadastradas        
    
    Sleep    5s
    # Obtemos a lista de bandas
    ${bandas}=          Get WebElements    xpath=//ul/li  
    ${num_bandas}=     Get Length    ${bandas}
    Log                 ${num_bandas} Lista de bandas Cadastradas.

    # Loop para validar cada banda
    FOR    ${i}    IN RANGE    ${num_bandas}
        ${banda}=    Get Text    ${bandas}[${i}]
        Log    Banda encontrada: ${banda}
        Page Should Contain    ${banda}
    END
    sleep  5s
    Capture Page Screenshot 
    Click Button    xpath=//button[contains(.,'Voltar')]
    Wait Until Element Is Visible   xpath=//label[contains(.,'Consulte as Bandas pela Inicial do Nome')]
    sleep  5s
    Close Browser 

08 - Consulta Banda não cadastrada por Nome 
    [Documentation]    Testa a Consulta Banda não cadastrada por Nome
    [Tags]    8
    Open Browser         ${URL}    ${BROWSER}                   
    Input Text           id=searchBand    Megadeth
    Click Button         id=searchByNameBtn
    Wait Until Page Contains    Erro ao buscar banda: Erro ao buscar a banda. Código: 404
    Page Should Contain    Erro ao buscar banda: Erro ao buscar a banda. Código: 404
    Capture Page Screenshot   
    Close Browser

09 - Cadastro de uma nova Banda
    [Documentation]    Testa o Cadastro de uma nova Banda
    [Tags]    9
    Open Browser    ${URL}/registerBand.html     ${BROWSER} 
    Sleep    5s  
    Wait Until Page Contains    Cadastro de Bandas 
    ${band_name}=        Get Band Name
    ${genre}=            Generate Genres
    ${members}=          Generate Members    5
    ${formation_year}=   Generate Formation Year 
    ${country}=          Generate Country
    ${discography}=      FakerLibrary.Words    3
    Input Text    id=bandName         ${band_name}
    Input Text    id=genre            ${genre}
    Input Text    id=members          ${members}
    Input Text    id=formationYear    ${formation_year}
    Input Text    id=origin           ${country}
    Click Button    xpath=//button[@type='submit'][contains(.,'Cadastrar')]
    Sleep    5s
    Capture Page Screenshot
    Page Should Contain    Banda cadastrada com sucesso!
    Click Button    xpath=//button[contains(.,'Voltar')]
    Wait Until Element Is Visible   xpath=//label[contains(.,'Consulte as Bandas pela Inicial do Nome')]
    Close Browser

10 - Cadastro de Novo Usuário com E-mail Invalido
    [Documentation]    Testa o Cadastro de Novo Usuário com E-mail Invalido
    [Tags]    10
    Open Browser    ${URL}  ${BROWSER}     
    Click Link    Login
    ${useremail}=   set variable    meuemail&meuemail.com
    ${username}=    Generate Username
    ${password}=    Generate Password
    Input Text    id=registerUsername       ${username} 
    Input Text    id=registerPassword       ${password}  
    Input Text    id=registerEmail          ${useremail}
    Click Button  id=registerBtn
    Wait Until Page Contains    Erro no registro. Tente novamente. 
    Page Should Contain    Erro no registro. Tente novamente.
    Capture Page Screenshot   
    Close Browser

11 - Cadastro de Novo Usuário com username em Branco
    [Documentation]    Testa o Cadastro de Novo Usuário com username em Branco
    [Tags]    11
    Open Browser    ${URL}  ${BROWSER}     
    Click Link    Login
    ${useremail}=   Generate Valid email
    ${password}=    Generate Password
    Input Text    id=registerUsername       ${EMPTY} 
    Input Text    id=registerPassword       ${password}  
    Input Text    id=registerEmail          ${useremail}
    Click Button  id=registerBtn
    Wait Until Page Contains    Por favor, preencha todos os campos. 
    Page Should Contain    Por favor, preencha todos os campos.
    Capture Page Screenshot   
    Close Browser

12 - Consulta Detalhes de Bandas Listadas na consulta pela letra Inicial e retorna à pagina inicial
    [Documentation]    Testa a Consulta Detalhes de Bandas Listadas na consulta pela letra Inicial e retorna à pagina inicial
    [Tags]    12
    Open Browser         ${URL}     ${BROWSER_chrome}
    Input Text           id=letterSearch   b
    Click Button         id=searchByLetterBtn

    Wait Until Element Is Visible   xpath=//h1[contains(.,'Lista de bandas Cadastradas')]    10s
    Page Should Contain  Lista de bandas Cadastradas

    Sleep    5s
    # Obtemos a lista de bandas
    ${bandas}=          Get WebElements    xpath=//ul/li/a
    ${num_bandas}=      Get Length    ${bandas}
    Log                 ${num_bandas} Lista de bandas Cadastradas.

    # Selecionar uma banda aleatória
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${num_bandas} - 1)
    ${banda_aleatoria}=     Get WebElement    xpath=//ul/li[${indice_aleatorio+1}]/a
    ${banda_nome}=          Get Text          ${banda_aleatoria}
    Log                     Clicando na banda aleatória: ${banda_nome}
    # Clicar na banda aleatória para ver os detalhes
    Click Element           ${banda_aleatoria}
    Capture Page Screenshot
    sleep     5s
    Wait Until Element Is Visible   xpath=//h2[contains(.,'Detalhes da Banda')]    10s
    Page Should Contain    ${banda_nome}
    # Voltar para a lista de bandas
    Click Button    xpath=//button[contains(.,'Voltar')]
    Wait Until Element Is Visible   xpath=//h1[contains(.,'Lista de bandas Cadastradas')]    10s
    Page Should Contain  Lista de bandas Cadastradas
    Click Button    xpath=//button[contains(.,'Voltar')]
    Wait Until Element Is Visible   xpath=//label[contains(.,'Consulte as Bandas pela Inicial do Nome')]
    Sleep  5s
    Close Browser


13 - Editar os dados de uma Banda Existente
    [Documentation]    Testa a Edição do país de Origem, Membros e ano de Formação de uma Banda Existente
    [Tags]    13
    
    Open Browser    ${URL}/optionsPage.html     ${BROWSER} 
    Sleep    5s  
    Input Text    id=username    admin
    Input Text    id=password    123
    Click Button  id=loginBtn
    Sleep    10s 
    Click Button    //button[@id='editBandBtn']
    Wait Until Page Contains    Opções de Banda
    Input Text    id=searchBand    Lost Horizon
    Click Button    xpath=//button[contains(.,'Editar Banda')]
    Wait Until Page Contains Element    xpath=//h2[contains(.,'Editar Banda')]
    # Captura o valor original dos campos 
    ${original_country}=    Get Value    id=editCountry  
    ${original_members}=    Get Value    id=editMembers  
    ${original_Year}=       Get Value    id=editFormationYear 
    # Gera um novo valor de país com FakerLibrary
    ${new_country}=          Generate Country
    ${new_members}=          Generate Members    4
    ${new_formation_year}=   Generate Formation Year

    # Insere o novo valor no campo 'país de origem'
    Input Text    id=editCountry             ${new_country} 
    Input Text    id=editMembers             ${new_members} 
    Input Text    id=editFormationYear       ${new_formation_year}  
 
    # Salva a alteração
    Click Button      id=saveBtn   
    Wait Until page Contains Element     id=confirmEditModal 
    Click Button    id=confirmYes
    Wait Until Element Is Visible    xpath=//span[contains(.,'Lost Horizon')]
    # Verifica se o novo valor está correto na página
    Page Should Contain    ${new_country}
    Page Should Contain    ${new_members}
    Page Should Contain    ${new_formation_year}
    #Compara o valor original com o novo valor
    Run Keyword If    '${original_country}' != '${new_country}'    
    ...    Log    País de origem alterado de ${original_country} para ${new_country}
    Log    Membros alteradoa de ${original_members} para ${new_members}
    Log    Ano de Formação alterado de ${original_Year} para ${new_formation_year}
    Capture Page Screenshot
    Close Browser

14 - Cadastro de uma nova Banda com Sessão de Login
    [Documentation]    Testa o Cadastro de uma nova Banda com sessão de Login
    [Tags]    14
    Open Browser    ${URL}/optionsPage.html     ${BROWSER} 
    Sleep    5s  
    Input Text    id=username    admin
    Input Text    id=password    123
    Click Button  id=loginBtn
    Sleep    5s 
    Click Button       //button[contains(.,'Cadastrar Banda')]
    Wait Until Page Contains    Cadastro de Bandas 
    ${band_name}=        Get Band Name
    ${genre}=            Generate Genres
    ${members}=          Generate Members    4
    ${formation_year}=   Generate Formation Year 
    ${country}=          Generate Country
    # ${discography}=      FakerLibrary.Words    3
    Input Text    id=bandName         ${band_name}
    Input Text    id=genre            ${genre}
    Input Text    id=members          ${members}
    Input Text    id=formationYear    ${formation_year}
    Input Text    id=origin           ${country}
    Click Button    xpath=//button[@type='submit'][contains(.,'Cadastrar')]
    Sleep    5s
    Capture Page Screenshot
    Page Should Contain    Banda cadastrada com sucesso!
    Click Button    xpath=//button[contains(.,'Voltar')]
    Wait Until Element Is Visible   xpath=//label[contains(.,'Consulte as Bandas pela Inicial do Nome')]
    Close Browser

15 - Incluir Discografia de uma Banda Existente
    [Documentation]    Testa a Inclusão de Discografia de uma Banda Existente
    [Tags]    15
    
    Open Browser    ${URL}/optionsPage.html     ${BROWSER} 
    Sleep    5s  
    Input Text    id=username    admin
    Input Text    id=password    123
    Click Button  id=loginBtn
    Sleep    10s 

    Input Text      xpath=//input[@placeholder='Nome da banda']    Iron serve
    Click Button    //button[contains(.,'Incluir Discos')]

    ${disc_title}    Get Disc Name
    ${randomNumber}    generate random number
    ${disc_Year}=    Evaluate    2009+${randomNumber}

    Input Text      id=discTitle    ${disc_title}  
    Input Text      id=discYear     ${disc_Year}   
    Click Button    xpath=//button[contains(.,'Salvar Disco')] 
    Wait Until Page Contains Element    xpath=//h2[contains(.,'Editar Banda')]
    Wait Until Page Contains    Disco adicionado com sucesso! 
    Page Should Contain         Disco adicionado com sucesso!

    Capture Page Screenshot
    Close Browser

16 - Desistir da Edição de uma Banda Existente
    [Documentation]    Testa a Edição de uma Banda Existente clicanco em NÃO para não salvar Alteração
    [Tags]    16
    
    Open Browser    ${URL}/optionsPage.html     ${BROWSER} 
    Sleep    5s  
    Input Text    id=username    admin
    Input Text    id=password    123
    Click Button  id=loginBtn
    Sleep    10s 
    Click Button    //button[@id='editBandBtn']
    Wait Until Page Contains    Opções de Banda
    Input Text    id=searchBand    Lost Horizon
    Click Button    xpath=//button[contains(.,'Editar Banda')]
    Wait Until Page Contains Element    xpath=//h2[contains(.,'Editar Banda')]
    # Captura o valor original dos campos 
    ${original_country}=    Get Value    id=editCountry  
    ${original_members}=    Get Value    id=editMembers  
    ${original_Year}=       Get Value    id=editFormationYear 
    # Gera um novo valor de país com FakerLibrary
    ${new_country}=          Generate Country
    ${new_members}=          Generate Members    4
    ${new_formation_year}=   Generate Formation Year

    # Insere o novo valor no campo 'país de origem'
    Input Text    id=editCountry             ${new_country} 
    Input Text    id=editMembers             ${new_members} 
    Input Text    id=editFormationYear       ${new_formation_year}  
 
    # Salva a alteração
    Click Button      id=saveBtn   
    Wait Until page Contains Element     id=confirmEditModal 
    Click Button    id=confirmNo

    Wait Until Page Contains    Dados não salvos. Retornando à página de edição. 
    Page Should Contain    Dados não salvos. Retornando à página de edição.

    Capture Page Screenshot
    Close Browser