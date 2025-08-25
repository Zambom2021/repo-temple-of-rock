FROM python:3.11-slim

WORKDIR /tests

# Instalar Robot Framework e Requests
RUN pip install --no-cache-dir robotframework robotframework-requests

# Copiar testes e recursos
COPY tests/ ./tests
COPY resources/ ./resources

# Criar diretório de logs
RUN mkdir logs

# Comando padrão para rodar os testes
CMD ["robot", "--outputdir", "logs", "tests/"]
