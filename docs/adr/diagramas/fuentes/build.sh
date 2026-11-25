#!/usr/bin/env bash
# Compila los diagramas de los ADR y guarda las imágenes PNG en la carpeta diagramas/.
# Uso: ./build.sh            (todos los diagramas)
#      ./build.sh replica    (solo replica.tex)
set -euo pipefail
cd "$(dirname "$0")"

diagramas=("$@")
if [ ${#diagramas[@]} -eq 0 ]; then
  for f in *.tex; do
    [ "$f" = "estilo.tex" ] || diagramas+=("${f%.tex}")
  done
fi

mkdir -p build
for d in "${diagramas[@]}"; do
  latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build "$d.tex" >/dev/null
  pdftoppm -png -r 200 -singlefile "build/$d.pdf" "../$d"
  echo "Generado: diagramas/$d.png"
done
