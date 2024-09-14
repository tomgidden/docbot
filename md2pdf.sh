#!/bin/sh

ASSETS=`pwd`/assets
TMP=`pwd`/doc

mkdir -p $TMP
rm -rf $TMP/* || true

# Save stdin to a temp file
cat > $TMP/file.md

FORMAT=commonmark_x-raw_html+task_lists+definition_lists

#+blank_before_header+space_in_atx_header

pandoc \
    $TMP/file.md \
    -f $FORMAT \
    --lua-filter=$ASSETS/metadata.lua \
    --template=$ASSETS/article.tmpl \
    --no-highlight \
    -t html5 \
    -o $TMP/file.html
#    --shift-heading-level-by=-1 \

pagedjs-cli \
  -s A4 \
  -w 210mm \
  -h 297mm \
  --style $ASSETS/print.css \
  -i $TMP/file.html \
  -o $TMP/file.pdf

cat $TMP/file.pdf
