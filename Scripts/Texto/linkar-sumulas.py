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
        
        # Expressão regular para encontrar o padrão de Súmula e Súmula Vinculante
        padrao = re.compile(r'\[\[LINK#\^.*?\|📑 Súmula(?: Vinculante)?\s*(\d+),\s*(STF|STJ|TCU|TSE)\.')

        # Função para substituir o padrão encontrado
        def substituir(match):
            numero_sumula = match.group(1)
            corte = match.group(2).lower()
            
            if "Vinculante" in match.group(0):
                prefixo = "sv"
                link = "Vinculante, STF"
            else:
                prefixo = "s"
                link = match.group(2)  # Usa a corte correspondente
            
            return f'[[{link}#^{prefixo}{numero_sumula}{corte}|📑 Súmula {match.group(1)}, {match.group(2)}.]]'

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

