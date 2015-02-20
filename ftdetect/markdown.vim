" automaticaly detects markdown (copy of tpope script)
" https://github.com/tpope/vim-markdown/blob/master/ftdetect/markdown.vim
"
" " TITLE "
"
" File Name         : markdown.vim
" Created By        : Thomas Aurel
" Creation Date     : February 13th, 2015
" Version           : 0.1
" Last Change       : February 13th, 2015 at 15:00:10
" Last Changed By   : Thomas Aurel
"
autocmd BufNewFile,BufRead *.markdown,*.md,*.mkd
            \ if &filetype =~? '^\%(conf\|modula2\)$' |
            \  set filetype=markdown
            \ else |
            \  setf markdown |
            \ endif
