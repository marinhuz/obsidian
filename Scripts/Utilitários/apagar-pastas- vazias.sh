#!/bin/bash

# Diretório onde o script deve procurar por pastas vazias
DIR="${1:-.}"  # Usa o diretório passado como argumento ou o diretório atual por padrão

# Verifica se o diretório existe
if [ ! -d "$DIR" ]; then
    echo "O diretório especificado não existe."
    exit 1
fi

# Encontrar e remover pastas vazias, incluindo subpastas
find "$DIR" -type d -empty -delete

echo "Pastas vazias removidas em $DIR e suas subpastas."

