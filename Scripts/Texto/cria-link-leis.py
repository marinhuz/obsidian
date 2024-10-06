import os
import re

def add_article_code(filename):
    """
    Adiciona o código do artigo ao final da última frase de cada parágrafo em um arquivo .md.

    Args:
        filename (str): Nome do arquivo .md.
    """

    with open(filename, 'r') as f:
        lines = f.readlines()

    new_lines = []
    paragraph = ""
    for line in lines:
        if line.strip() == "":  # Verifica se a linha está vazia (final do parágrafo)
            if paragraph:
                match = re.search(r"Art\. (\d+(?:\.\d+)?)", paragraph)  # Nova expressão regular
                if match:
                    article_number = match.group(1)
                    paragraph += f" ^art-{article_number}\n"
                new_lines.append(paragraph)
                paragraph = ""  # Reinicia o parágrafo
            new_lines.append(line)
        else:
            paragraph += line

    # Adiciona o último parágrafo, se houver
    if paragraph:
        match = re.search(r"Art\. (\d+(?:\.\d+)?)", paragraph)  # Nova expressão regular
        if match:
            article_number = match.group(1)
            paragraph += f" ^art-{article_number}\n"
        new_lines.append(paragraph)

    with open(filename, 'w') as f:
        f.writelines(new_lines)

# Obtém todos os arquivos .md na pasta atual e processa cada um
for filename in os.listdir():
    if filename.endswith(".md"):
        add_article_code(filename)
        print(f"Código de artigo adicionado a: {filename}")

print("Processamento concluído!")
