Language: pt-br
*** Settings ***
Resource    ${EXECDIR}/resources/resource.resource
Resource    ${EXECDIR}/resources/keywords_cad_band.robot

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

02 - Consultar Banda Por Nome
    [Documentation]    Testa a consulta de uma banda pelo nome
    [Tags]    2    Positive

    ${response_body}    ${status_code}    Get Band by name     Metal Factor

    Assert Consulta Banda    ${response_body}    ${status_code}

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

    ${band_data}    ${status_code}    Get Band by name     Ultimate school

    ${response_Up}    ${request_Up}    ${status_code}
    ...    Gera Atualizacao de Discografia da banda
    ...    ${band_data}    ${qtd_disc} 

06 - Remove o Cadastro de uma Banda
    [Documentation]    Faz o Cadastro de uma Banda e Depois Remove o Cadastro
    [Tags]    6    

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

    ${status_code}    Delete Band     ${response_body._id}

    Assert Delete Message     ${status_code}     "Banda removida com sucesso"       

07 - Cadastro de Banda já Existente 
    [Documentation]    Não deve Permitir o Cadastro de bandas Duplicado
    [Tags]    7    

    ${qtd_discs}          set variable    1

    ${band_data}    ${status_code}    Get Band by name     Metal Factor

    ${response_body}    ${request_body}    ${status_code}
    ...    Gera Cadastro de banda
    ...    ${band_data.name}     ${band_data.genre}    ${band_data.members}    ${band_data.formationYear}    ${band_data.country}    ${qtd_discs}

    Assert Duplicate Registration     ${status_code}     "Banda já cadastrada." 
    
08 - Consultar Lista de Bandas pela Primeira Letra do Nome
    [Documentation]    Testa a consulta de uma banda pela primeira letra do nome
    [Tags]    8   Positive

    ${response_body}    ${status_code}    Get Band by letter    b    

    Assert List Band    ${response_body}    ${status_code}    B 

09 - Consultar Lista de Todas as Bandas
    [Documentation]    Testa a consulta de todas as bandas
    [Tags]    9   Positive

    ${response_body}    ${status_code}    Get Band by letter    ${EMPTY}    

    Assert List Band    ${response_body}    ${status_code}    ${EMPTY}  

