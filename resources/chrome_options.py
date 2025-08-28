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

