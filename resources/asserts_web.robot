*** Settings ***
Resource    ./resource.resource

*** Keywords ***
devo ver a mensagem "${mensagem}" 
    Wait Until Page Contains    ${mensagem} 
    Page Should Contain         ${mensagem}
    Capture Page Screenshot  

devo visualizar a listagem de Bandas
    Wait Until Element Is Visible   xpath=//h1[contains(.,'Lista de bandas Cadastradas')]    10s
    Sleep    5s
    Page Should Contain  Lista de bandas Cadastradas
    Capture Page Screenshot

devo ver os detalhes da Banda
    [Arguments]     ${banda_nome}
    Wait Until Element Is Visible   xpath=//h2[contains(.,'Detalhes da Banda')]    10s
    Wait Until Element Is Visible   xpath=//span[contains(.,'${banda_nome}')]
    Page Should Contain    ${banda_nome}
    Capture Page Screenshot

vejo a a mensagem "${mensagem}"
    Capture Page Screenshot
    Page Should Contain    ${mensagem}

valido a mensagem de sucesso
    Wait Until Page Contains Element    id=confirmEditModal    
    # Rola a página para o modal de confirmação
    # Execute JavaScript    window.scrollTo(0, document.getElementById('confirmEditModal').offsetTop)
    Execute JavaScript    document.getElementById('confirmEditModal').scrollIntoView()
    Wait Until Element Is Visible       id=confirmEditModal
    Click Button    id=confirmYes 
    Page Should Contain    Banda atualizada com sucesso!
    Capture Page Screenshot

valido a mensagem de falha
    Wait Until Page Contains Element    id=confirmEditModal    
    # Rola a página para o modal de confirmação
    # Execute JavaScript    window.scrollTo(0, document.getElementById('confirmEditModal').offsetTop)
    Execute JavaScript    document.getElementById('confirmEditModal').scrollIntoView()
    Wait Until Element Is Visible       id=confirmEditModal
    Click Button    id=confirmNo 
    Page Should Contain    Dados não salvos. Retornando à página de edição.
    Capture Page Screenshot
