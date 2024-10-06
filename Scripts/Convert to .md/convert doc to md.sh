#!/bin/bash

# Verifica se o pandoc está instalado
if ! command -v pandoc &> /dev/null; then
  echo "Pandoc não está instalado. Instale-o com: sudo apt-get install pandoc"
  exit 1
fi

# Verifica se existem arquivos .doc na pasta atual
if ! ls *.doc 1> /dev/null 2>&1; then
  echo "Nenhum arquivo .doc encontrado na pasta atual."
  exit 1
fi

# Itera sobre cada arquivo .doc na pasta atual
for input_file in *.doc; do
  output_file="${input_file%.doc}.md"
  
  # Converte o arquivo .doc para .md usando pandoc
  pandoc "$input_file" -o "$output_file"
  
  echo "Conversão concluída: $output_file"
done
sudo 
