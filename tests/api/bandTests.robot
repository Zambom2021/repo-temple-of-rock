Language: pt-br
*** Settings ***
Resource    ${EXECDIR}/resources/resource.resource
Resource    ${EXECDIR}/resources/keywords_cad_band.robot

*** Test Cases ***
01 - Cadastro de Nova Banda
    [Documentation]    Testa o cadastro de uma banda com dados dinâmicos e verifica se o cadastro retorna sucesso (status 201).
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
    [Documentation]    Testa a consulta de uma banda existente pelo nome e verifica se os dados retornados estão corretos (status 200).
    [Tags]    2    Positive

    ${response_body}    ${status_code}    Get Band by name     Metal Factor

    Assert Consulta Banda    ${response_body}    ${status_code}

03 - Cadastro de Nova Banda com discografia Vazia
    [Documentation]    Testa o cadastro de uma banda com dados dinâmicos e discografia vazia e verifica se o cadastro retorna sucesso (status 201).
    [Tags]    3    Positive

    ${current_date}       Generate Current Date
    ${future_date}        Generate Date Plus N Days    60
    ${pass_date}          Generate Date Minus N Days   5
    ${band_name}=         Get Band Name
    ${genre}=             Generate Genres    
    ${members}=           Generate Members    5
    ${formation_year}=    Generate Formation Year 
    ${country}=           Generate Country
    ${qtd_discs}          set variable    0

    ${response_body}    ${request_body}    ${status_code}
    ...    Gera Cadastro de banda
    ...    ${band_name}    ${genre}    ${members}    ${formation_year}    ${country}    ${qtd_discs}

    Assert Cadastro Banda    ${response_body}        ${request_body}    ${status_code}

04 - Cadastro e Atualização da Banda
    [Documentation]    Testa o cadastro de uma banda e, em seguida, a atualização dos dados dessa banda, verificando ambos os retornos de sucesso.
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

    Assert Update Band    ${response_Up}    ${request_Up}    ${status_code}

05 - Incluir Discografia da Banda por Nome
    [Documentation]    Testa a inclusão/atualização da discografia de uma banda existente pelo nome, verificando se a alteração é realizada com sucesso.
    [Tags]    5   Positive
    
    ${qtd_disc}     Set Variable    10

    ${band_data}    ${status_code}    Get Band by name     Ultimate school

    ${response_Up}    ${request_Up}    ${status_code}
    ...    Gera Atualizacao de Discografia da banda
    ...    ${band_data}    ${qtd_disc} 

    Assert Update Band    ${response_Up}    ${request_Up}    ${status_code}

06 - Remove o Cadastro de uma Banda
    [Documentation]     Testa o cadastro de uma banda e, em seguida, a remoção dessa banda, verificando se a exclusão retorna mensagem de sucesso.
    [Tags]    6    Positive

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
    [Documentation]    Testa o cadastro de uma banda já existente e verifica se o sistema impede duplicidade, retornando mensagem de erro apropriada.
    [Tags]    7    Negative    

    ${qtd_discs}          set variable    1

    ${band_data}    ${status_code}    Get Band by name     Metal Factor

    ${response_body}    ${request_body}    ${status_code}
    ...    Gera Cadastro de banda
    ...    ${band_data.name}     ${band_data.genre}    ${band_data.members}    ${band_data.formationYear}    ${band_data.country}    ${qtd_discs}

    Assert Duplicate Registration     ${status_code}     "Banda já cadastrada." 
    
08 - Consultar Lista de Bandas pela Primeira Letra do Nome
    [Documentation]    Testa a consulta de bandas pela primeira letra do nome e verifica se a lista retornada está correta.
    [Tags]    8   Positive

    ${response_body}    ${status_code}    Get Band by letter    b    

    Assert List Band    ${response_body}    ${status_code}    B 

09 - Consultar Lista de Todas as Bandas
    [Documentation]    Testa a consulta da lista completa de bandas e verifica se todos os registros são retornados corretamente.
    [Tags]    9   Positive

    ${response_body}    ${status_code}    Get Band by letter    ${EMPTY}    

    Assert List Band    ${response_body}    ${status_code}    ${EMPTY}  

10 - Cadastro de Banda com Nome Vazio
    [Documentation]    Testa o cadastro de uma banda sem informar o nome. Espera erro de validação e status 400.
    [Tags]    10    Negative    Validacao

    ${genre}=             Generate Genres    
    ${members}=           Generate Members    5
    ${formation_year}=    Generate Formation Year 
    ${country}=           Generate Country
    ${qtd_discs}          set variable    5

    ${response_body}    ${request_body}    ${status_code}
    ...    Gera Cadastro de banda
    ...    ${EMPTY}    ${genre}    ${members}    ${formation_year}    ${country}    ${qtd_discs}

    Assert Invalid Band Registration    ${status_code}    "Band validation failed: name: Path `name` is required."

11 - Cadastro de Banda com Ano de Formação Futuro
    [Documentation]    Testa o cadastro de uma banda com ano de formação maior que o ano atual. Espera erro de validação e status 400.
    [Tags]    11    Negative    Validacao

    ${band_name}=         Get Band Name
    ${genre}=             Generate Genres    
    ${members}=           Generate Members    5
    ${country}=           Generate Country
    ${qtd_discs}          set variable    5

    ${response_body}    ${request_body}    ${status_code}
    ...    Gera Cadastro de banda
    ...    ${band_name}    ${genre}    ${members}    2030    ${country}    ${qtd_discs}

    Assert Invalid Year Formation Band    ${status_code}    "Ano de formação inválido."

12 - Consulta de Banda Inexistente
    [Documentation]    Testa a consulta de uma banda que não existe no sistema. Espera resposta de não encontrado e status 404.
    [Tags]    12    Negative    

    ${response_body}    ${status_code}    Get Band by name     Test Band 

    Assert Band Not Found    ${status_code}    "message":"Banda não encontrada."

13 - Remover Banda Inexistente
    [Documentation]    Testa a tentativa de remoção de uma banda que não existe. Espera resposta de erro e status 404.
    [Tags]    13     Negative    

    ${status_code}    Delete Band     58b9ba094e2a27d96fe640d0

    Assert Band Not Found   ${status_code}    "message":"Banda não encontrada."

14 - Alterar Banda Com Discografia Vazia
    [Documentation]    Testa a alteração da discografia de uma banda já cadastrada, verificando se a atualização ocorre corretamente (status 200).
    [Tags]    14   Positive
    
    ${qtd_disc}     Set Variable    5

    ${band_data}    Get All Bands
    Log     ${band_data}   

    ${response_Up}    ${request_Up}    ${status_code}
    ...    Gera Atualizacao de Discografia da banda
    ...    ${band_data}    ${qtd_disc} 

    Assert Update Band    ${response_Up}    ${request_Up}    ${status_code}