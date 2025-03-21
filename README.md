# repo-temple-of-rock

# Para executar os testes web:

# Browser Chrome:
robot -d ./logs tests/web/web_tests_gk.robot

# Browser Firefox:
robot -d ./logs -v BROWSER:firefox tests/web/web_tests_gk.robot

# MODO HEADLESS
robot -d ./logs -v BROWSER:headlesschrome tests/web/web_tests_gk.robot
robot -d ./logs -v BROWSER:headlessfirefox tests/web/web_tests_gk.robot


# Para executar testes API:
robot -d ./logs tests/api
