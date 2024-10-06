import os
import re

# Obtém o diretório onde o script está localizado
diretorio = os.path.dirname(os.path.abspath(__file__))
print(f"Processando arquivos no diretório: {diretorio}")

# Função para processar o arquivo e fazer as substituições
def processar_arquivo(caminho_arquivo):
    print(f"Processando o arquivo: {caminho_arquivo}")
    try:
        with open(caminho_arquivo, 'r', encoding='utf-8') as arquivo:
            conteudo = arquivo.read()

        # Expressão regular para encontrar o padrão de Súmula Vinculante
        padrao = re.compile(r'\[\[LINK#\^\|📑 Súmula\s+Vinculante\s*(\d+),\s*STF\.')

        # Função para substituir o padrão encontrado
        def substituir(match):
            numero_sumula = match.group(1)
            prefixo = "sv"
            return f'[[Vinculante, STF#^{prefixo}{numero_sumula}|📑 Súmula Vinculante {numero_sumula}, STF.]]'

        novo_conteudo = padrao.sub(substituir, conteudo)

        # Escreve o novo conteúdo de volta ao arquivo
        with open(caminho_arquivo, 'w', encoding='utf-8') as arquivo:
            arquivo.write(novo_conteudo)
        print(f"Arquivo atualizado: {caminho_arquivo}")

    except Exception as e:
        print(f"Erro ao processar o arquivo {caminho_arquivo}: {e}")

# Função para processar todos os arquivos .md no diretório e subpastas
def processar_diretorio(diretorio):
    for raiz, dirs, arquivos in os.walk(diretorio):
        for arquivo in arquivos:
            if arquivo.endswith('.md'):
                caminho_arquivo = os.path.join(raiz, arquivo)
                processar_arquivo(caminho_arquivo)

# Executa a função de processamento no diretório onde o script está localizado
processar_diretorio(diretorio)
print("Processamento concluído.")

