#!/bin/bash

# Diretório onde o script está localizado
DIR="$(dirname "$(realpath "$0")")"

# Encontrar todos os arquivos .md no diretório e subdiretórios
find "$DIR" -type f -name "*.md" | while read -r file; do
    echo "Processando: $file"

    # Substituir 'png]]' por 'png|center]]'
    sed -i 's/png]]/png|center]]/g' "$file"
done

echo "Substituição concluída nos arquivos .md em $DIR."

