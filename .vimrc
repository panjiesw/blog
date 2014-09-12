augroup LOCAL_SETUP
    autocmd BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
    autocmd FileType javascript,coffee,html,jinja setlocal tabstop=2 | setlocal softtabstop=2 | setlocal sw=2
augroup end

