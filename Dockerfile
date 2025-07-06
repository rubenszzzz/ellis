# 1. Imagem Base
# Usamos uma imagem oficial do Python. A tag 'slim' é uma boa escolha
# pois é menor que a padrão, mas ainda inclui ferramentas comuns,
# evitando problemas de compilação que podem ocorrer com 'alpine'.
FROM python:3.11-slim-bullseye

# 2. Diretório de Trabalho
# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copiar e Instalar Dependências
# Copiamos primeiro o requirements.txt para aproveitar o cache de camadas do Docker.
# Se o arquivo não mudar, o Docker reutilizará a camada, acelerando builds futuros.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copiar o Código da Aplicação
COPY . .

# 5. Expor a Porta
# Informa ao Docker que o contêiner escuta na porta 8000.
EXPOSE 8000

# 6. Comando de Execução
# Comando para iniciar a aplicação com Uvicorn.
# Usamos --host 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
