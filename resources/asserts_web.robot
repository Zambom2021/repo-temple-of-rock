*** Settings ***
Resource    ./resource.resource

*** Keywords ***
devo ver a mensagem "${mensagem}" 
    Wait Until Page Contains    ${mensagem} 
    Page Should Contain         ${mensagem}
    Capture Page Screenshot  