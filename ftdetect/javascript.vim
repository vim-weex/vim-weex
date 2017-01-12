"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim ftplugin file
"
" Language: WEEX (JavaScript)
" Maintainer: kuilin.qkl <keynesqu@gmail.com>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Whether the .we extension is required.
if !exists('g:weex_ext_required')
  let g:weex_ext_required = 1
endif

" Whether the @weex pragma is required.
if !exists('g:weex_pragma_required')
  let g:weex_pragma_required = 1
endif

if g:weex_pragma_required
  " Look for the @weex pragma.  It must be included in a docblock comment before
  " anything else in the file (except whitespace).
  let s:weex_pragma_pattern = '\%^\_s*\/\*\*\%(\_.\%(\*\/\)\@!\)*@we\_.\{-}\*\/'
  let b:weex_pragma_found = search(s:weex_pragma_pattern, 'npw')
endif

" Whether to set the weex filetype on *.js files.
fu! <SID>EnableWeex()
  if g:weex_pragma_required && !b:weex_pragma_found | return 0 | endif
  if g:weex_ext_required && !exists('b:weex_ext_found') | return 0 | endif
  return 1
endfu

" Syntax with many language
fu! s:regSyntax()
    " runtime! syntax/html.vim
    " runtime! syntax/xml.vim
    setf weex
    " runtime! indent/weex.vim
endfu

au Syntax we call s:regSyntax()
autocmd BufNewFile,BufRead *.we let b:weex_ext_found = 1
autocmd BufNewFile,BufRead *.we let ts=2
autocmd BufNewFile,BufRead *.we call s:regSyntax()
autocmd BufNewFile,BufRead *.js
  \ if <SID>EnableWeex() | set filetype=javascript.we | endif
