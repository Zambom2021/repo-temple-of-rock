#  🤘🎸 TEMPLE OF ROCK 🤘🎸

Projeto criado como exercício profissional em QA, com objetivo de garantir qualidade em funcionalidades simuladas de cadastro de bandas🎸🎶.  
O projeto utiliza **Robot Framework** para automação de testes, incluindo testes **Web** e **API**, com suporte a execução local e CI/CD via GitHub Actions.

# 🖥️ Para executar os testes Web:

## 🌟 Chrome:
`robot -d ./logs tests/web/`

## 🌟 Firefox:
`robot -d ./logs -v BROWSER:firefox tests/web/`

## 👻 Headless:
`robot -d ./logs -v BROWSER:headlesschrome tests/web/`
`robot -d ./logs -v BROWSER:headlessfirefox tests/web/`

💡 Dica: Para validar a interface localmente, utilize os navegadores em modo normal (não headless).

🏹 Para executar testes API:
`robot -d ./logs tests/api/`

⚡ Para executar todos os testes de uma vez (Web + API):
`python -m robot -d logs tests/web tests/api`

📸 Logs e screenshots:
- Todas as screenshots das execuções são salvas na pasta `logs/`.
- Para manter apenas as screenshots da última execução e evitar acúmulo de arquivos antigos:


🤖 Integração com GitHub Actions

O workflow está configurado para:

🏁 Executar testes Web e API.

📦 Fazer upload dos resultados (logs e screenshots) como artifacts, permitindo download e análise.

⚠️ Observação: Mantenha o navegador atualizado para evitar problemas de compatibilidade nos testes Web.

🏆 Boas práticas

Sempre limpe os logs antigos antes de rodar novos testes para evitar confusão.

Use o modo headless no CI/CD e modo normal para testes locais quando quiser validar a interface visual.

Aproveite os artifacts do GitHub Actions para analisar falhas sem precisar rodar os testes localmente.

⚠️ Observação: Mantenha o navegador atualizado para evitar problemas de compatibilidade nos testes Web.

___
💀🤘🎸 Developed by: Ricardo Zambom 🤘🎸💀

 
