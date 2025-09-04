Language: pt-br
*** Settings ***

Resource   ${EXECDIR}/resources/resource.resource  


Suite Setup      Limpar Screenshots Antigas     
Test Setup       Abrir Navegador    
Test Teardown    Fechar Navegador

*** Test Cases ***
08 - Consulta Lista de Bandas pela letra Inicial do Nome
    [Documentation]    Testa a Consulta de Lista de Bandas pela letra Inicial do Nome
    [Tags]    8

    Dado que acesse a pagina temple Of Rock
    Quando digitar a letra "d" e clico no botão de busca
    Então deve visualizar a listagem de Bandas

09 - Consulta Detalhes de uma Banda na consulta pela letra Inicial do Nome
    [Documentation]    Testa a Consulta Detalhes de uma Banda na consulta pela letra Inicial do Nome
    [Tags]    9

    Dado que acesse a pagina temple Of Rock
    E digitar a letra "t" e clico no botão de busca
    ${banda_nome}    Quando selecionar uma Banda na lista
    Então deve ver os detalhes da Banda    ${banda_nome} 
    
10 - Consulta de Banda por Nome
    [Documentation]    Testa a Consulta de Banda por Nome
    [Tags]    10

    Dado que acesse a pagina temple Of Rock   
    Quando digitar o nome "Ultimate School" clico no botão de busca 
    Então deve ver os detalhes da Banda    Ultimate School           

11 - Cadastro de uma nova Banda 
    [Documentation]    Testa o Cadastro de uma nova Banda 
    [Tags]    11

    Dado que esteja logado na pagina Temple of rock
    E selecionar o ítem "Cadastrar Banda" 
    Quando preencher o formulario de cadastro de Nova Banda
    Então visualizar a mensagem "Banda cadastrada com sucesso!"

12 - Edita o Cadastro Banda 
    [Documentation]    Testa Edição de Cadastro de Banda com Sucesso 
    [Tags]    12

    Dado que esteja logado na pagina Temple of rock
    E selecionar o ítem "Editar Banda"
    Quando digitar o nome da banda "Ultimate School" e clico em Editar 
    E preencher o formulario de Editar Banda e clico em Salvar
    Então validar a mensagem de sucesso

13 - Desiste da Edição do Cadastro Banda 
    [Documentation]    Testa Desistencia da Edição de Cadastro de Banda. 
    [Tags]    13

    Dado que esteja logado na pagina Temple of rock
    E selecionar o ítem "Editar Banda"
    Quando digitar o nome da banda "Iron Daughter" e clico em Editar 
    E preencher o formulario de Editar Banda e clico em Salvar
    Então validar a mensagem de falha
    
14 - Incluir Discografia a uma Banda Cadastrada
    [Documentation]    Testa a Inclusão de Discografia de uma Banda Cadastrada
    [Tags]    14
    ## Gero Discos Aleatórios
    ${disc_title}    Get Disc Name
    ${randomNumber}  generate random number
    ${disc_Year}=    Evaluate    1987+${randomNumber}
    
    Dado que esteja logado na pagina Temple of rock
    E digitar o nome da banda "Dr. Doom" e clico em incluir discos
    Quando digitar o "${disc_title}" e o "${disc_Year}" e clico e Salvar
    Então visualizar a mensagem "Disco adicionado com sucesso!" 

15 - Consulta Lista de Bandas pela letra Inicial do Nome Inexistente
    [Documentation]    Testa a Consulta de Lista de Bandas pela letra Inicial do Nome Inexistente   
    [Tags]    15

    Dado que acesse a pagina temple Of Rock
    Quando digitar a letra "Y" e clico no botão de busca
    Então visualizar a mensagem "Nenhuma banda encontrada."

16 - Consulta de Banda Não Cadastrada
    [Documentation]    Testa a Consulta não cadastrada
    [Tags]    16

    Dado que acesse a pagina temple Of Rock
    Quando digitar o nome "UFO" clico no botão de busca 
    Então visualizar a mensagem "Erro ao buscar banda: Erro ao buscar a banda. Código: 404"

17 - Consulta Lista de Bandas pela letra Inicial do Nome Vazio
    [Documentation]    Testa a Consulta de Lista de Bandas pela letra Inicial do Nome vazio   
    [Tags]    17

    Dado que acesse a pagina temple Of Rock
    Quando digitar a letra " " e clico no botão de busca
    Então visualizar a mensagem "Letra inválida."

18 - Cadastro de uma nova Banda com data de formação Invalida 
    [Documentation]    Testa o Cadastro de uma nova Banda com data de formação Invalida e valida mensagem de erro 
    [Tags]    18
    ${invalidFomartionYear}    Generate Date Plus N Days    366 

    Dado que esteja logado na pagina Temple of rock
    E selecionar o ítem "Cadastrar Banda" 
    Quando preencher o formulario de cadastro de Nova Banda com data "${invalidFomartionYear}"
    Então visualizar a mensagem "Erro ao cadastrar banda"

19 - Cadastro de uma nova Banda com data de formação futura 
    [Documentation]    Testa o Cadastro de uma nova Banda com data de formação futura e valida mensagem de erro 
    [Tags]    19

    ${futureDate}    Set Variable    2026

    Dado que esteja logado na pagina Temple of rock
    E selecionar o ítem "Cadastrar Banda" 
    Quando preencher o formulario de cadastro de Nova Banda com data "${futureDate}"
    Então visualizar a mensagem "Erro ao cadastrar banda"
