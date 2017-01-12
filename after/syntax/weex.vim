"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax file
"
" Language: WEEX (JavaScript)
" Maintainer: kuilin.qkl <keynesqu@gmail.com>
" Depends: pangloss/vim-javascript
"
" CREDITS: Inspired by Alibaba,Inc.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists("b:current_syntax")
  finish
endif

if !exists("s:syntaxes")
  " Search available syntax files.
  function! s:search_syntaxes(...)
    let syntaxes = {}
    let names = a:000
    for name in names
      let syntaxes[name] = 0
    endfor

    for path in split(&runtimepath, ',')
      if isdirectory(path . '/syntax')
        for name in names
          let syntaxes[name] = syntaxes[name] || filereadable(path . '/syntax/' . name . '.vim')
        endfor
      endif
    endfor
    return syntaxes
  endfunction

  let s:syntaxes = s:search_syntaxes('html', 'css', 'javascript', 'scss')
endif

" Prologue; load in XML syntax.
" if exists('b:current_syntax')
"   " let s:current_syntax=b:current_syntax
"   unlet b:current_syntax
" endif
" syn include @XMLSyntax syntax/xml.vim


syntax include @HTML syntax/html.vim
if exists("b:current_syntax")
  unlet b:current_syntax
endif
syntax region html keepend start=/^<template>/ end=/^<\/template>/ contains=@HTML fold

syntax include @JS syntax/javascript.vim
if exists("b:current_syntax")
  unlet b:current_syntax
endif
syntax region javascript keepend matchgroup=Delimiter start=/<script\( lang="babel"\)\?\( type="text\/babel"\)\?>/ end="</script>" contains=@JS fold

syntax include @CSS syntax/css.vim
if exists("b:current_syntax")
  unlet b:current_syntax
endif
syntax region css keepend start=/<style\( \+scoped\)\?>/ end="</style>" contains=@CSS fold

if s:syntaxes.scss
  syntax include @scss syntax/scss.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region scss keepend start=/<style\( \+scoped\)\? lang=\("\|'\)[^\1]*scss[^\1]*\1\( \+scoped\)\?>/ end="</style>" contains=@scss fold
endif

" if exists('s:current_syntax')
"   let b:current_syntax=s:current_syntax
" endif

let b:current_syntax = "weex"
