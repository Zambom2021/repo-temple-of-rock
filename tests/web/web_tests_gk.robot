Language: pt-br
*** Settings ***
Resource   ../../resources/resource.resource  
     
Test Setup       Abrir Navegador 
Test Teardown    Fechar Navegador

*** Test Cases ***
01 - Cadastro de Novo Usuário com Sucesso
    [Documentation]    Testa o Cadastro de novo usuário com sucesso
    [Tags]    1

    Dado que acesse a pagina temple Of Rock
    E que acesse a opcao de login
    Quando digito os dados para cadastrar um Novo usuario e clico no botão registrar
    Então devo ver a mensagem "Usuário registrado com sucesso!"

02 - Cadastro de Novo Usuário com Email Invalido
    [Documentation]    Testa o Cadastro de novo usuário com Email Invalido
    [Tags]    2

    Dado que acesse a pagina temple Of Rock
    E que acesse a opcao de login
    Quando digito os dados para cadastrar um Novo usuario com email Invalido e clico no botão registrar
    Então devo ver a mensagem "Erro no registro. Tente novamente."

03 - Login com sucesso
    [Documentation]    Testa o Login de usuário com sucesso
    [Tags]    3

    Dado que acesse a pagina temple Of Rock   
    E que acesse a opcao de login
    Quando digito os dados de usuario "admin" e senha "123" e clico no botão login
    Então devo ver a mensagem "Login realizado com sucesso!"

04 - Login com senha Invalida
    [Documentation]    Testa o Login com senha invalida
    [Tags]    4

    Dado que acesse a pagina temple Of Rock        
    E que acesse a opcao de login
    Quando digito os dados de usuario "admin" e senha "ABCDF123456" e clico no botão login
    Então devo ver a mensagem "Usuário ou senha incorretos."

05 - Login com Usuario Invalido
    [Documentation]    Testa o Login com usuário Invalido
    [Tags]    5

    Dado que acesse a pagina temple Of Rock     
    E que acesse a opcao de login
    Quando digito os dados de usuario "ADMINISTRADOR" e senha "123" e clico no botão login
    Então devo ver a mensagem "Usuário ou senha incorretos."


06 - Login com Usuario em Branco
    [Documentation]    Testa o Login com usuário em Branco
    [Tags]    6
       
    Dado que acesse a pagina temple Of Rock     
    E que acesse a opcao de login
    Quando digito os dados de usuario "${EMPTY}" e senha "123" e clico no botão login
    Então devo ver a mensagem "Por favor, preencha os campos de usuário e senha."

07 - Login com senha em Branco
    [Documentation]    Testa o Login com senha em Branco
    [Tags]    7
        
    Dado que acesse a pagina temple Of Rock     
    E que acesse a opcao de login
    Quando digito os dados de usuario "admin" e senha "${EMPTY}" e clico no botão login
    Então devo ver a mensagem "Por favor, preencha os campos de usuário e senha."

08 - Consulta Lista de Bandas pela letra Inicial do Nome
    [Documentation]    Testa a Consulta de Lista de Bandas pela letra Inicial do Nome
    [Tags]    8

    Dado que acesse a pagina temple Of Rock
    Quando digito a letra "n" e clico no botão de busca
    Então devo visualizar a listagem de Bandas

09 - Consulta Detalhes de uma Banda na consulta pela letra Inicial do Nome
    [Documentation]    Testa a Consulta Detalhes de uma Banda na consulta pela letra Inicial do Nome
    [Tags]    9

    Dado que acesse a pagina temple Of Rock
    E digito a letra "s" e clico no botão de busca
    ${banda_nome}    
    ...    Quando seleciono uma Banda na lista
    Então devo ver os detalhes da Banda    
    ...    ${banda_nome} 
    
10 - Consulta de Banda por Nome
    [Documentation]    Testa a Consulta de Banda por Nome
    [Tags]    10

    Dado que acesse a pagina temple Of Rock   
    Quando digito o nome "Nirvana" clico no botão de busca 
    Então devo ver os detalhes da Banda
    ...    Nirvana           

11 - Cadastro de uma nova Banda 
    [Documentation]    Testa o Cadastro de uma nova Banda 
    [Tags]    11

    Dado que esteja logado na pagina Temple of rock
    E seleciono o ítem "Cadastrar Banda" 
    Quando preencho o formulario de cadastro de Nova Banda
    Então vejo a a mensagem "Banda cadastrada com sucesso!"

12 - Edita o Cadastro Banda 
    [Documentation]    Testa Edição de Cadastro de Banda com Sucesso 
    [Tags]    12

    Dado que esteja logado na pagina Temple of rock
    E seleciono o ítem "Editar Banda"
    Quando digito o nome da banda "our dusk" e clico em Editar 
    E preencho o formulario de Editar Banda e clico em Salvar
    Então valido a mensagem de sucesso

13 - Desiste da Edição do Cadastro Banda 
    [Documentation]    Testa Desistencia da Edição de Cadastro de Banda. 
    [Tags]    13

    Dado que esteja logado na pagina Temple of rock
    E seleciono o ítem "Editar Banda"
    Quando digito o nome da banda "Heaven's Wait" e clico em Editar 
    E preencho o formulario de Editar Banda e clico em Salvar
    Então valido a mensagem de falha
    
14 - Incluir Discografia a uma Banda Cadastrada
    [Documentation]    Testa a Inclusão de Discografia de uma Banda Cadastrada
    [Tags]    14
    ## Gero Discos Aleatórios
    ${disc_title}    Get Disc Name
    ${randomNumber}  generate random number
    ${disc_Year}=    Evaluate    1998+${randomNumber}
    
    Dado que esteja logado na pagina Temple of rock
    E digito o nome da banda "Deep sign" e clico em incluir discos
    Quando digito o "${disc_title}" e o "${disc_Year}" e clico e Salvar
    Então vejo a a mensagem "Disco adicionado com sucesso!" 



 
     

