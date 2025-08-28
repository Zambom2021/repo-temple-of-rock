*** Settings ***
Resource          resource.resource

*** Variables ***
${URL}                http://localhost:9090/web
${BROWSER_HL}         headlessfirefox
${BROWSER}            chrome

*** Keywords ***
Abrir Navegador 
    ${opts}=        Get Chrome Options    
    Open Browser    browser=${BROWSER}    options=${opts}    
    
Fechar Navegador
    Close Browser

Limpar Screenshots Antigas
    Remove Files    logs/*.png

que acesse a pagina temple Of Rock
    Go To           url=${URL}

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


digito a letra "${letra}" e clico no botão de busca
    Input Text           id=letterSearch   ${letra}
    Click Button         id=searchByLetterBtn

digito o nome "${bandName}" clico no botão de busca             
    Input Text           id=searchBand    ${bandName}
    Click Button         id=searchByNameBtn

seleciono uma Banda na lista
    Wait Until Element Is Visible   xpath=//h1[contains(.,'Lista de bandas Cadastradas')]    10s
    Page Should Contain  Lista de bandas Cadastradas
    Sleep    5s
    ${bandas}=          Get WebElements    xpath=//ul/li/a
    ${num_bandas}=      Get Length    ${bandas}
    Log                 ${num_bandas} Lista de bandas Cadastradas.
    # Selecionar uma banda aleatória
    ${indice_aleatorio}=    Evaluate    random.randint(0, ${num_bandas} - 1)
    ${banda_aleatoria}=     Get WebElement    xpath=//ul/li[${indice_aleatorio+1}]/a
    ${banda_nome}=          Get Text          ${banda_aleatoria}
    # Clicar na banda aleatória para ver os detalhes
    Click Element           xpath=//a[contains(.,'${banda_nome}')]

    RETURN     ${banda_nome}   

que esteja logado na pagina Temple of rock
    que acesse a pagina temple Of Rock
    que acesse a opcao de login
    digito os dados de usuario "admin" e senha "123" e clico no botão login
    Sleep    10s
    
seleciono o ítem "${botao_select}"
    
    IF    '${botao_select}' == 'Cadastrar Banda' 
        Click Button       //button[contains(.,'Cadastrar Banda')]
    ELSE IF    '${botao_select}' == 'Editar Banda' 
        Click Button    //button[contains(.,'Editar Banda')]       
    END
        
preencho o formulario de cadastro de Nova Banda
    Wait Until Page Contains    Cadastro de Bandas 
    Click Button         xpath=//button[@onclick='openRegisterBandModal()']
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

digito o nome da banda "${band_Name}" e clico em Editar
    Wait Until Page Contains    Opções de Banda
    Input Text    id=searchBand    ${band_Name}
    Click Button    xpath=//button[contains(.,'Editar Banda')]

Preencho o formulario de Editar Banda e clico em Salvar
    Wait Until Page Contains Element    xpath=//h2[contains(.,'Editar Banda')]    timeout=10s

    # Captura os valores originais dos campos
    ${original_country}=    Get Value    id=editCountry
    ${original_members}=    Get Value    id=editMembers
    ${original_Year}=       Get Value    id=editFormationYear

    # Gera novos valores
    ${new_country}=          Generate Country
    ${new_members}=          Generate Members    4
    ${new_formation_year}=   Generate Formation Year

    # Espera até os campos estarem visíveis e interagíveis
    Wait Until Element Is Visible    id=editCountry    timeout=10s
    Wait Until Element Is Enabled    id=editCountry    timeout=10s
    Scroll Element Into View         id=editCountry
    Input Text                       id=editCountry    ${new_country}

    Wait Until Element Is Visible    id=editMembers    timeout=10s
    Wait Until Element Is Enabled    id=editMembers    timeout=10s
    Scroll Element Into View         id=editMembers
    Input Text                       id=editMembers    ${new_members}

    Wait Until Element Is Visible    id=editFormationYear    timeout=10s
    Wait Until Element Is Enabled    id=editFormationYear    timeout=10s
    Scroll Element Into View         id=editFormationYear
    Input Text                       id=editFormationYear    ${new_formation_year}

    # Salva a alteração
    Click Button    id=saveBtn

digito o nome da banda "${band_name}" e clico em incluir discos
    Input Text      xpath=//input[@placeholder='Nome da banda']    ${band_name}
    Click Button    //button[contains(.,'Incluir Discos')]
    
digito o "${disc_title}" e o "${disc_Year}" e clico e Salvar
    Input Text      id=discTitle    ${disc_title}  
    Input Text      id=discYear     ${disc_Year}   
    Click Button    xpath=//button[contains(.,'Salvar Disco')] 



