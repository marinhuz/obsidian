import os
import re

def add_article_code(filename):
    """
    Adiciona o código do artigo ao final da linha onde ele aparece no mesmo parágrafo em um arquivo .md.
    Remove pontos dos números maiores que 999.

    Args:
        filename (str): Nome do arquivo .md.
    """

    with open(filename, 'r') as f:
        lines = f.readlines()

    new_lines = []
    for line in lines:
        match = re.search(r"(Art\. (\d{1,3}(?:\.\d{3})*))", line)
        if match:
            article_number = match.group(2).replace('.', '')  # Remove os pontos do número do artigo
            line = f"{line.strip()} ^art-{article_number}\n"  # Adiciona o código ao final da linha
        new_lines.append(line)

    with open(filename, 'w') as f:
        f.writelines(new_lines)

# Obtém todos os arquivos .md na pasta atual e processa cada um
for filename in os.listdir():
    if filename.endswith(".md"):
        add_article_code(filename)
        print(f"Código de artigo adicionado a: {filename}")

print("Processamento concluído!")

