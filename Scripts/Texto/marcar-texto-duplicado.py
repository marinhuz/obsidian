import os
import re
from collections import defaultdict

# Função para ler o conteúdo de um arquivo .md
def read_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as file:
        return file.read()

# Função para escrever o conteúdo em um arquivo .md
def write_file(filepath, content):
    with open(filepath, 'w', encoding='utf-8') as file:
        file.write(content)

# Função para encontrar e marcar duplicidades
def mark_duplicates(root_dir):
    # Dicionário para armazenar frases e seus caminhos
    phrases_to_files = defaultdict(list)
    file_contents = {}

    # Percorre recursivamente todas as subpastas e arquivos .md
    for subdir, _, files in os.walk(root_dir):
        for file in files:
            if file.endswith('.md'):
                filepath = os.path.join(subdir, file)
                content = read_file(filepath)
                file_contents[filepath] = content

                # Divida o conteúdo em frases com pelo menos 50 caracteres
                phrases = re.findall(r'.{50,}', content)
                for phrase in phrases:
                    phrases_to_files[phrase].append(filepath)

    # Verificar duplicidades e marcar
    for phrase, files in phrases_to_files.items():
        if len(files) > 1:  # Só processa se houver duplicidade
            for filepath in files:
                content = file_contents[filepath]
                # Marca todas as instâncias da frase duplicada
                marked_content = re.sub(f'({re.escape(phrase)})', r'\1 🔁', content)
                write_file(filepath, marked_content)

# Diretório contendo as subpastas e arquivos .md
root_dir = './'

# Executar o script
mark_duplicates(root_dir)

