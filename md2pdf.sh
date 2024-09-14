#!/bin/sh

TMP=./doc
mkdir -p $TMP
rm -rf $TMP/* || true

# Save stdin to a temp file
cat > $TMP/file.md

touch $TMP/file.yaml

cat > $TMP/file.lua <<EOF
local List = require 'pandoc.List'

local found_title = nil
Header = function (header)
  if found_title == nil and header.level == 1 then
    found_title = header.content
    return ""
  end
  return header
end

Pandoc = function (doc)
  if doc.meta.title == nil then
    doc.meta.title = found_title
  end
  return doc
end

EOF

FORMAT=commonmark_x-raw_html+task_lists+definition_lists
#+blank_before_header+space_in_atx_header

pandoc $TMP/file.md -f $FORMAT --lua-filter=$TMP/file.lua --template=css/article.tmpl --no-highlight -t html5 -o $TMP/file.html
#--shift-heading-level-by=-1 

#pandoc $TMP/file.md $TMP/file.yaml --shift-heading-level-by=-1 -f commonmark_x-raw_html -t pdf --pdf-engine weasyprint -o $TMP/file.html
#weasyprint $TMP/file.html $TMP/file.pdf

pagedjs-cli -s A4 -w 210mm -h 297mm --style css/print.css -i $TMP/file.html -o $TMP/file.pdf

cat $TMP/file.pdf
