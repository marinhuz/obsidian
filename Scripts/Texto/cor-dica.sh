#!/bin/bash

# Diretório onde o script está localizado
DIR="$(dirname "$(realpath "$0")")"

# Encontrar todos os arquivos .md no diretório e subdiretórios
find "$DIR" -type f -name "*.md" | while read -r file; do
    echo "Processando: $file"

    # Substituir '<mark class="hltr-aa">Dica</mark>' por '<mark class="hltr-o">Dica</mark>'
    sed -i 's|<mark class="hltr-aa">Dica</mark>|<mark class="hltr-o">Dica</mark>|g' "$file"
    
done

echo "Substituição de 'Dica' concluída nos arquivos .md em $DIR."

