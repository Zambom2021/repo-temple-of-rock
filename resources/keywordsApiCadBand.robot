*** Settings ***
Resource    ${EXECDIR}/resources/libs.resource
Resource    ${EXECDIR}/resources/pageObjects.robot

*** Keywords ***
Gera Cadastro de banda
    [Arguments]    ${band_name}    ${genre}    ${members}    ${formation_year}    ${country}    ${qtd}

    ${payload}    cadastro_banda    ${qtd}
    Log    ${payload}

    ${session}     Create Session    ${SESSION_ALIAS}    ${api_url} 
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${request_body}=    Update json Gera Cadastro de banda    ${payload}    ${band_name}    ${genre}    ${members}    ${formation_year}    ${country}    ${qtd}

    ${response}=    POST On Session    ${SESSION_ALIAS}    url=/bands    json=${request_body}    expected_status=anything 
    ${status_code}   convert to string    ${response.status_code} 
    
    ${response_body} =    Set Variable     ${response.content}
    &{response_json}=     Convert For JSON    ${response_body}

    RETURN   ${response_json}    ${request_body}    ${status_code}

Update json Gera Cadastro de banda
    [Arguments]    ${payload}    ${band_name}    ${genre}    ${members}    ${formation_year}    ${country}    ${qtd}

    ${year_int}=    Convert To Integer    ${formation_year}
    ${current_Year}    Generate Current Year
    # Atualiza o payload usando o dicionário original
    ${new_Json_body}=   Set To Dictionary    ${payload}          name            ${band_name}
    ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    genre           ${genre}
    ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    members         ${members}
    ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    formationYear   ${formation_year}
    ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    country         ${country}

    # Inicializa a lista de discografia
    ${disc_list}=   Create List

    # Adiciona discos na lista de discografia
    FOR    ${index}    IN RANGE    ${qtd}
        ${disc_title}=     Get Disc Name 
        ${release_year}=   Evaluate    ${year_int}+${index}
        IF    ${release_year} > ${current_Year}
            ${release_year}=   Set Variable    ${year_int}
        END
        ${disc}=    Create Dictionary    title=${disc_title}    releaseYear=${release_year}
        Append To List    ${disc_list}    ${disc}

        # Atualiza o payload com a discografia dentro do FOR
        ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    discography    ${disc_list}
        Evaluate     ${index}+1
    END
    RETURN    ${new_Json_body}


Gera Atualizacao de Discografia da banda
    [Arguments]    ${band_data}     ${qtd}

    ${payload}    cadastro_banda    ${qtd}
    Log    ${payload}

    ${session}     Create Session    ${SESSION_ALIAS}    ${api_url} 
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${request_body}=    Update json Atualiza Discos de banda    ${payload}    ${band_data}    ${qtd} 

    ${response}=    PUT On Session    ${SESSION_ALIAS}    url=/bands/${band_data["_id"]}   json=${request_body}
    ${status_code}   convert to string    ${response.status_code} 
    
    
    ${response_body} =    Set Variable     ${response.content}
    &{response_json}=     Convert For JSON    ${response_body}

    RETURN   ${response_json}    ${request_body}    ${status_code}

Update json Atualiza Discos de banda
    [Arguments]    ${payload}    ${band_data}     ${qtd}

    ${year_int}        Convert to Integer    ${band_data["formationYear"]}
    # IF    ${band_data} == None
    #     Fail    "band_data não pode ser None"
    # ELSE
    #     ${year_int}=    Convert To Integer    ${band_data["formationYear"]}
    # END
    ${current_Year}    Generate Current Year
    
    # Atualiza o payload usando o dicionário original
    ${new_Json_body}=   Set To Dictionary    ${payload}          name            ${band_data["name"]}
    ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    genre           ${band_data["genre"]}
    ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    members         ${band_data["members"]}
    ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    formationYear   ${band_data["formationYear"]}
    ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    country         ${band_data["country"]}

    # Inicializa a lista de discografia
    ${disc_list}=   Create List

    # Adiciona discos na lista de discografia
    FOR    ${index}    IN RANGE    ${qtd}
        ${disc_title}=     Get Disc Name 
        ${release_year}=   Evaluate    ${year_int}+${index}
        IF    ${release_year} > ${current_Year}
            ${release_year}=   Set Variable    ${year_int}
        END
        ${disc}=    Create Dictionary    title=${disc_title}    releaseYear=${release_year}
        Append To List    ${disc_list}    ${disc}

        # Atualiza o payload com a discografia dentro do FOR
        ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    discography    ${disc_list}
        Evaluate     ${index}+1

    END
    RETURN    ${new_Json_body}

Gera Atualizacao da banda
    [Arguments]    ${band_data}     
    ${qtd}    Get Length    ${band_data["discography"]}

    ${payload}    cadastro_banda    ${qtd}
    Log    ${payload}

    ${session}     Create Session    ${SESSION_ALIAS}    ${api_url} 
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${request_body}=    Update json Atualiza banda    ${payload}    ${band_data}    ${qtd} 

    ${response}=    PUT On Session    ${SESSION_ALIAS}    url=/bands/${band_data["_id"]}   json=${request_body}
    ${status_code}   convert to string    ${response.status_code} 
    
    ${response_body} =    Set Variable     ${response.content}
    &{response_json}=     Convert For JSON    ${response_body}

    RETURN   ${response_json}    ${request_body}    ${status_code}

Update json Atualiza banda
    [Arguments]    ${payload}    ${band_data}     ${qtd}
    
    ${new_genre}=         Generate Genres    
    ${new_country}=       Generate Country
    ${new_disc_count}=    GenresModel.Generate Random Number
    Log    Número de novos discos: ${new_disc_count}
    ${new_members}=       Generate Members    5

    ${year_int}        Convert to Integer    ${band_data["formationYear"]}

    # Atualiza o payload usando o dicionário original
    ${new_Json_body}=   Set To Dictionary    ${payload}          name            ${band_data["name"]}
    ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    genre           ${new_genre}
    ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    members         ${new_members}
    ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    formationYear   ${band_data["formationYear"]}
    ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    country         ${new_country}

    # Inicializa a lista de discografia
    ${disc_list}=   Create List

    # Adiciona discos na lista de discografia
    FOR    ${index}    IN RANGE    ${new_disc_count}
        ${disc_title}=     Get Disc Name 
        ${release_year}=   Evaluate    ${year_int}+${index}
        ${current_year}=    Generate Current Year
        IF    ${release_year} > ${current_year}
            ${release_year}=   Set Variable    ${year_int}
        END
        ${disc}=    Create Dictionary    title=${disc_title}    releaseYear=${release_year}
        Append To List    ${disc_list}    ${disc}
    END

    # Atualiza o payload com a discografia após o FOR
    ${new_Json_body}=   Set To Dictionary    ${new_Json_body}    discography    ${disc_list}
    
    RETURN    ${new_Json_body}
