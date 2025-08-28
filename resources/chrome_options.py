from selenium.webdriver.chrome.options import Options
import os

def get_chrome_options():
    opts = Options()
    
    # Detecta se está rodando no GitHub Actions
    ci_env = os.getenv("GITHUB_ACTIONS", "false").lower() == "true"

    if ci_env:
        # Headless para CI/CD
        opts.add_argument("--headless")
        opts.add_argument("--no-sandbox")
        opts.add_argument("--disable-dev-shm-usage")
        opts.add_argument("--disable-gpu")
    # Se não estiver em CI, abre o navegador visível
    
    return opts

# from selenium.webdriver.chrome.options import Options

# def get_chrome_options():
#     options = Options()
#     options.add_argument("--headless")
#     options.add_argument("--no-sandbox")
#     options.add_argument("--disable-dev-shm-usage")
#     options.add_argument("--disable-gpu")
#     options.add_argument("--remote-debugging-port=9222")
#     return options
