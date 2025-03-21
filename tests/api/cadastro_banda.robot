Language: pt-br
*** Settings ***
Resource    ../../resources/resource.resource
Resource    ../../resources/keywords_cad_band.robot
Library     ../../resources/GenresModel.py

*** Test Cases ***
01 - Cadastro de Nova Banda
    [Documentation]    Testa o cadastro de uma banda com dados dinâmicos.
    [Tags]    1    Positive

    ${current_date}       Generate Current Date
    ${future_date}        Generate Date Plus N Days    60
    ${pass_date}          Generate Date Minus N Days   5
    ${band_name}=         Get Band Name
    ${genre}=             Generate Genres    
    ${members}=           Generate Members    5
    ${formation_year}=    Generate Formation Year 
    ${country}=           Generate Country
    ${qtd_discs}          set variable    5

    ${response_body}    ${request_body}    ${status_code}
    ...    Gera Cadastro de banda
    ...    ${band_name}    ${genre}    ${members}    ${formation_year}    ${country}    ${qtd_discs}

    Assert Cadastro Banda    ${response_body}        ${request_body}    ${status_code}

    ${response_Band}    ${staus_code}    Get Band by name     ${band_name}

    Assert Consulta Banda    ${response_Band}        ${request_body}    


02 - Consultar Banda Por Nome
    [Documentation]    Testa a consulta de uma banda pelo nome
    [Tags]    2    Positive

    ${response_body}    ${staus_code}    Get Band by name     Last Available

    Should Be Equal         ${staus_code}    200
    Should Not Be Empty     ${response_body["_id"]}   
    Should Be Equal         ${response_body["name"]}     Last Available  


03 - Alterar Banda Com Discografia Vazia
    [Documentation]    Testa a alteração de uma banda já cadastrada
    [Tags]    3   Positive
    
    ${qtd_disc}     Set Variable    5

    ${band_data}    Get All Bands
    Log     ${band_data}   

    ${response_Up}    ${request_Up}    ${status_code}
    ...    Gera Atualizacao de Discografia da banda
    ...    ${band_data}    ${qtd_disc} 

04 - Cadastro e Atualização da Banda
    [Documentation]    Testa o cadastro de uma banda com dados dinâmicos.
    [Tags]    4    Positive

    ${band_name}=         Get Band Name
    ${genre}=             Generate Genres    
    ${members}=           Generate Members    5
    ${formation_year}=    Generate Formation Year 
    ${country}=           Generate Country
    ${qtd_discs}          set variable    5

    ${response_body}    ${request_body}    ${status_code}
    ...    Gera Cadastro de banda
    ...    ${band_name}    ${genre}    ${members}    ${formation_year}    ${country}    ${qtd_discs}

    ${response_Up}    ${request_Up}    ${status_code}
    ...    Gera Atualizacao da banda
    ...    ${response_body}    


05 - Incluir Discografia da Banda por Nome
    [Documentation]    Testa a alteração de uma banda já cadastrada
    [Tags]    5   Positive
    
    ${qtd_disc}     Set Variable    10

    ${band_data}    ${staus_code}    Get Band by name     Last Available

    ${response_Up}    ${request_Up}    ${status_code}
    ...    Gera Atualizacao de Discografia da banda
    ...    ${band_data}    ${qtd_disc} 