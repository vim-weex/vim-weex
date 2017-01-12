"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim indent file
"
" Language: WEEX (JavaScript)
" Maintainer: kuilin.qkl <keynesqu@gmail.com>
"
" CREDITS: Inspired by Alibaba,Inc.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Save the current JavaScript indentexpr.
let b:weex_js_indentexpr = &indentexpr

if exists("b:did_indent")
  finish
endif

" Load indent files for required languages
for language in ['css', 'javascript', 'html']
  unlet! b:did_indent
  exe "runtime! indent/".language.".vim"
  exe "let s:".language."indent = &indentexpr"
endfor

let b:did_indent = 1

setlocal indentexpr=GetWeexIndent()

if exists("*GetWeexIndent")
  finish
endif

function! GetWeexIndent()
  if searchpair('<style', '', '</style>', 'bWr')
    exe "let indent = ".s:cssindent
  elseif searchpair('<script', '', '</script>', 'bWr')
    exe "let indent = ".s:javascriptindent
  else
    exe "let indent = ".s:htmlindent
  endif

  return indent > -1 ? indent : s:htmlindent
endfunction
