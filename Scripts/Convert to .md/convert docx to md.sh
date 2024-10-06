#!/bin/bash

# Verifica se o pandoc está instalado
if ! command -v pandoc &> /dev/null; then
  echo "Pandoc não está instalado. Instale-o com: sudo apt-get install pandoc"
  exit 1
fi

# Verifica se existem arquivos .docx em subpastas
if ! find . -type f -name "*.docx" | grep -q .; then
  echo "Nenhum arquivo .docx encontrado nas subpastas."
  exit 1
fi

# Itera sobre cada arquivo .docx nas subpastas
find . -type f -name "*.docx" | while read -r input_file; do
  output_file="${input_file%.docx}.md"
  
  # Converte o arquivo .docx para .md usando pandoc
  pandoc "$input_file" -o "$output_file"
  
  echo "Conversão concluída: $output_file"
done

