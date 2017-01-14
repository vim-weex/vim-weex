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

" From yuezk/weex.vim
" Thanks yuezk
" Merge since 20170114
syntax region template matchgroup=weexTag keepend start=/^<template.\{-}>/ end=/^<\/template>/ contains=@HTML fold
" {{}} syntax
syntax region weexNormalInside matchgroup=weexSpecialKey start=/\({\)\@<!{{\([{!%]\)\@!\~\?/ end=/\~\?\([%}]\)\@<!}}\(}\)\@!/ containedin=template,htmlString
" 操作符
syn match weexOperators '[-+*/=.><%,]' contained containedin=weexNormalInside

syntax include @JS syntax/javascript.vim
if exists("b:current_syntax")
  unlet b:current_syntax
endif
" Statement Keywords
syntax keyword jsImport                       import export require module exports global process __dirname __filename

syntax keyword jsStorageClass   const var let const
syntax keyword jsReturn return with exports
syntax keyword jsPrototype      prototype toString toLocaleString toValue toFixed \$broadcast \$dispatch \$on \$off data init created compiled ready methods
syntax keyword jsStatement      return with exports
syntax keyword jsGlobalObjects  Array Boolean Date Function Math Number Object RegExp String
syntax keyword jsExceptions     try catch throw finally Error EvalError RangeError ReferenceError SyntaxError TypeError URIError

syntax cluster jsExpression  contains=jsBracket,jsParen,jsObject,jsBlock,jsTernaryIf,jsTaggedTemplate,jsTemplateString,jsString,jsRegexpString,jsNumber,jsFloat,jsOperator,jsBooleanTrue,jsBooleanFalse,jsNull,jsFunction,jsArrowFunction,jsGlobalObjects,jsExceptions,jsFutureKeys,jsDomErrNo,jsDomNodeConsts,jsHtmlEvents,jsFuncCall,jsUndefined,jsNan,jsPrototype,jsBuiltins,jsNoise,jsClassDefinition,jsArrowFunction,jsArrowFuncArgs,jsParensError,jsComment,jsArguments,jsThis,jsSuper,jsDo

syntax region javascript keepend matchgroup=weexTag start=/<script\( lang="babel"\)\?\( type="text\/babel"\)\?>/ end="</script>" contains=@JS,@jsAll,@jsExpression fold

syntax include @CSS syntax/css.vim
if exists("b:current_syntax")
  unlet b:current_syntax
endif
syntax region css keepend matchgroup=weexTag start=/<style\( \+scoped\)\?>/ end="</style>" contains=@CSS fold

if s:syntaxes.scss
  syntax include @scss syntax/scss.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region scss keepend matchgroup=weexTag start=/<style\( \+scoped\)\? lang=\("\|'\)[^\1]*scss[^\1]*\1\( \+scoped\)\?>/ end="</style>" contains=@scss fold
endif


" From yuezk/weex.vim
" Thanks yuezk
" Merge since 20170114
command! -nargs=+ WeexHiLink hi def link <args>

" template script style 标签高亮
WeexHiLink weexTag Keyword
" 大括号部分高亮
" {{ }}
WeexHiLink weexSpecialKey Special
" 操作符高亮
WeexHiLink weexOperators Operator
WeexHiLink jsWeexDef Operator

" if exists('s:current_syntax')
"   let b:current_syntax=s:current_syntax
" endif

delcommand WeexHiLink
let b:current_syntax = "weex"
