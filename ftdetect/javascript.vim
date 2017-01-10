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
  let g:weex_pragma_required = 0
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

autocmd BufNewFile,BufRead *.we let b:weex_ext_found = 1
autocmd BufNewFile,BufRead *.we set filetype=javascript.we
autocmd BufNewFile,BufRead *.js
  \ if <SID>EnableWeex() | set filetype=javascript.we | endif
