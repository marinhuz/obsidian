#!/bin/bash

# Diretório onde o script está localizado
DIR="$(dirname "$(realpath "$0")")"

# Encontrar todos os arquivos .md no diretório e subdiretórios
find "$DIR" -type f -name "*.md" | while read -r file; do
    echo "Processando: $file"

    # Remove todas as linhas em branco
    sed -i '/^$/d' "$file"

    # Adiciona duas linhas em branco antes de h1 (#)
    sed -i '/^# /i\\' "$file"
    sed -i '/^# /i\\' "$file"
    
    # Adiciona uma linha em branco antes de h2 (##) e h3 (###)
    sed -i '/^## /i\\' "$file"
    sed -i '/^### /i\\' "$file"
    
    # Adiciona uma linha em branco antes de "---"
    sed -i '/^---/i\\' "$file"

    # Formatar começo de linha, adicionando marcador no início, exceto para "---"
    sed -i '/^---/!s|^\s*-\s*|###### - |' "$file"

    # Diminuir uma tabulação
    sed -i 's|^	\([0-9]\+\).|\1.|g' "$file"

done

echo "Formatação concluída nos arquivos .md em $DIR."

