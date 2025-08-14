# temple-of-rock

Projeto criado como exercício profissional em QA, com objetivo de garantir qualidade em funcionalidades simuladas de cadastro de bandas.

# Para executar os testes web:

## Browser Chrome:
robot -d ./logs tests/web/web_tests_gk.robot

## Browser Firefox:
robot -d ./logs -v BROWSER:firefox tests/web/web_tests_gk.robot

## MODO HEADLESS
robot -d ./logs -v BROWSER:headlesschrome tests/web/web_tests_gk.robot
robot -d ./logs -v BROWSER:headlessfirefox tests/web/web_tests_gk.robot

## Para executar testes API:
robot -d ./logs tests/api
