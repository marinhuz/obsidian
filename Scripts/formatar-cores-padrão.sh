#!/bin/bash

# Diretório onde o script está localizado
DIR="$(dirname "$(realpath "$0")")"

# Encontrar todos os arquivos .md no diretório e subdiretórios
find "$DIR" -type f -name "*.md" | while read -r file; do
    echo "Processando: $file"

    # Formatar '≠ '
    sed -i 's|≠ |<span style="color:#D44C47;">≠</span> |g' "$file"

    # Formatar '≠ '
    sed -i 's|Exceção:|<span style="color:#D44C47;">Exceção</span>:|g' "$file"

    # Formatar '≠ 
    sed -i 's|Dica:|<span style="color:#9972B6;">Dica</span>:|g' "$file"

    # Formatar '≠ '
    sed -i 's|STJ:|<span style="color:#C4548F;">STJ</span>:|g' "$file"

    # Formatar '≠ '
    sed -i 's|STF:|<span style="color:#C4548F;">STF</span>:|g' "$file"
    
done

echo "Substituição de 'Dica' concluída nos arquivos .md em $DIR."

