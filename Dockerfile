# Usar uma versão leve do Python
FROM python:3.11-slim

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Instalar dependências do sistema necessárias para bibliotecas de ML (opcional)
# O scikit-learn e pandas geralmente precisam dessas bibliotecas compartilhadas
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copiar apenas o arquivo de requisitos primeiro (melhora o cache do Docker)
COPY requirements.txt .

# Instalar as bibliotecas Python sem salvar o cache do pip (economiza espaço)
RUN pip install --no-cache-dir -r requirements.txt

# Copiar o resto dos arquivos para dentro da imagem
COPY . .

# 1. Informa ao Docker que a porta 8888 será usada 
EXPOSE 8888
# 2. Comando para iniciar o Jupyter e manter o container "vivo" 
# O --ip=0.0.0.0 permite conexões externas (do seu Windows para o container) 
# O token='' remove a necessidade de senha para facilitar o seu tutorial
 CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
