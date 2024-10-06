#!/bin/bash

# Função para formatar o texto
format_text() {
    local file="$1"
 
    # Remover _)_
    sed -i 's|_)_||g' "$file"

    # Remover _
    sed -i 's|_||g' "$file"
    
    # Remover _
    sed -i '/^  $/d' "$file"

    # Remover URLs dentro de parênteses e os próprios parênteses
#    sed -i -E 's/\([^\)]*https?:\/\/[^\)]*\)//g' "$file"
    
    # Substituir padrões [texto] por `[texto]
    sed -i 's/\[\(.*?\)\]/\`[\1]\`/g' "$file"

    # Substituir "Artigo XX", "ARTIGO XX" e "Art XX" por "Art. XX"
    sed -i -E 's/\b(Artigo|ARTIGO|Art) ([0-9]{1,3}(\.[0-9]{3})*)\b/Art. \2/g' "$file"

    # Substituir "Artigo XXº", "ARTIGO XXº" e "Art XXº" por "Art. XXº"
    sed -i -E 's/\b(Artigo|ARTIGO|Art) ([0-9]{1,3}(\.[0-9]{3})*)º\b/Art. \2º/g' "$file"

    # Substituir "REGRA XX" por "Regra XX"
    sed -i -E 's/\bREGRA ([0-9]{1,3}(\.[0-9]{3})*)\b/Regra \1/g' "$file"

#    # Adicionar uma linha em branco antes de cada artigo ou regra
#    sed -i -E 's/(Art\. [0-9]+|Regra [0-9]+)\b/\n\1/g' "$file"

    # Substituir "Art. XXo" por "Art. XXº"
    sed -i -E 's/Art\. ([0-9]+)o\b/Art. \1º/g' "$file"

    # Substituir "Art. XX o" por "Art. XXº"
    sed -i -E 's/Art\. ([0-9]+) o\b/Art. \1º/g' "$file"

    # Substituir "o" por "º" em parágrafos específicos
    sed -i -E 's/§ ([0-9]+) o\b/§ \1º/g' "$file"

    # Adicionar "- " no início de cada parágrafo
    sed -i -E '/^---|^Nome:|^Nº:|^Ano:|^Art|^[[:space:]]*$/!s/^/- /' "$file"

    # Grifar "Art. XX" e "Regra XX"
    sed -i -E 's/\b(Art\. [0-9]{1,3}(\.[0-9]{3})*º?)\b/**\1**/g' "$file"
    sed -i -E 's/\b(Regra [0-9]{1,3}(\.[0-9]{3})*º?)\b/**\1**/g' "$file"
 
}

# Caminho do diretório onde o script está localizado
directory=$(dirname "$(realpath "$0")")

# Itera sobre todos os arquivos .md no diretório
for file in "$directory"/*.md; do
    [ -e "$file" ] || continue  # Evitar erros se não houver arquivos .md

    # Chama a função para formatar o texto no arquivo .md
    format_text "$file"

    echo "Texto formatado em $file"
done

