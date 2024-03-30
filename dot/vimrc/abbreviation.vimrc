"""""""""" abbreviation
" ;r で置換コマンドを展開
cabbrev <expr> r getcmdtype() .. getcmdline() ==# ':r' ? [getchar(), ''][1] .. "%s//gc<Left><Left><Left>" : 'r'

