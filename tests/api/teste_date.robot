*** Settings ***
Library    ../../resources/DateGenerator.py
Library    DateTime

*** Test Cases ***
Exemplo De Geração De Data Atual
    ${current_date}=    Generate Current Date
    Log    Data Atual: ${current_date}

Exemplo De Geração De Data Futura
    ${future_date}=    Generate Date Plus N Days    60
    Log    Data Futura: ${future_date}

Exemplo De Geração De Data Passada
    ${past_date}=    Generate Date Minus N Days    30
    Log    Data Passada: ${past_date}


*** Keywords ***
Generate Current Date
    ${date}=    DateGenerator.current_date     
    RETURN   ${date}

Generate Date Plus N Days
    [Arguments]    ${days}
    ${date}=    DateGenerator.future_date    ${days}
    RETURN   ${date}

Generate Date Minus N Days
    [Arguments]    ${days}
    ${date}=    DateGenerator.past_date    ${days}
    RETURN   ${date}

