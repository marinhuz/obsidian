#!/bin/bash

# Verifica se o pandoc está instalado
if ! command -v pandoc &> /dev/null; then
  echo "Pandoc não está instalado. Instale-o com: sudo apt-get install pandoc"
  exit 1
fi

# Verifica se existem arquivos .odt na pasta atual
if ! ls *.odt 1> /dev/null 2>&1; then
  echo "Nenhum arquivo .odt encontrado na pasta atual."
  exit 1
fi

# Itera sobre cada arquivo .odt na pasta atual
for input_file in *.odt; do
  output_file="${input_file%.odt}.md"
  
  # Converte o arquivo .odt para .md usando pandoc
  pandoc "$input_file" -o "$output_file"
  
  echo "Conversão concluída: $output_file"
done
sudo 
