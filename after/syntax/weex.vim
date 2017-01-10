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

if !exists("s:syntaxes")
  " Search available syntax files.
  function s:search_syntaxes(...)
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

  let s:syntaxes = s:search_syntaxes('pug', 'slm', 'coffee', 'stylus', 'sass', 'scss', 'less')
endif

" Prologue; load in XML syntax.
if exists('b:current_syntax')
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif
syn include @XMLSyntax syntax/xml.vim


syntax include @HTML syntax/html.vim
if exists("b:current_syntax")
  unlet b:current_syntax
endif
syntax region html keepend start=/^<template>/ end=/^<\/template>/ contains=@HTML fold

if s:syntaxes.pug
  syntax include @PUG syntax/pug.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region pug keepend start=/<template lang=\("\|'\)[^\1]*pug[^\1]*\1>/ end="</template>" contains=@PUG fold
  syntax region pug keepend start=/<template lang=\("\|'\)[^\1]*jade[^\1]*\1>/ end="</template>" contains=@PUG fold
endif

if s:syntaxes.slm
  syntax include @SLM syntax/slm.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region slm keepend start=/<template lang=\("\|'\)[^\1]*slm[^\1]*\1>/ end="</template>" contains=@SLM fold
endif

syntax include @JS syntax/javascript.vim
if exists("b:current_syntax")
  unlet b:current_syntax
endif
syntax region javascript keepend matchgroup=Delimiter start=/<script\( lang="babel"\)\?\( type="text\/babel"\)\?>/ end="</script>" contains=@JS fold

if s:syntaxes.coffee
  syntax include @COFFEE syntax/coffee.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  " Matchgroup seems to be necessary for coffee
  syntax region coffee keepend matchgroup=Delimiter start="<script lang=\"coffee\">" end="</script>" contains=@COFFEE fold
endif

syntax include @CSS syntax/css.vim
if exists("b:current_syntax")
  unlet b:current_syntax
endif
syntax region css keepend start=/<style\( \+scoped\)\?>/ end="</style>" contains=@CSS fold

if s:syntaxes.stylus
  syntax include @stylus syntax/stylus.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region stylus keepend start=/<style lang=\("\|'\)[^\1]*stylus[^\1]*\1\( \+scoped\)\?>/ end="</style>" contains=@stylus fold
endif

if s:syntaxes.sass
  syntax include @sass syntax/sass.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region sass keepend start=/<style\( \+scoped\)\? lang=\("\|'\)[^\1]*sass[^\1]*\1\( \+scoped\)\?>/ end="</style>" contains=@sass fold
endif

if s:syntaxes.scss
  syntax include @scss syntax/scss.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region scss keepend start=/<style\( \+scoped\)\? lang=\("\|'\)[^\1]*scss[^\1]*\1\( \+scoped\)\?>/ end="</style>" contains=@scss fold
endif

if s:syntaxes.less
  syntax include @less syntax/less.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region less keepend matchgroup=PreProc start=/<style\%( \+scoped\)\? lang=\("\|'\)[^\1]*less[^\1]*\1\%( \+scoped\)\?>/ end="</style>" contains=@less fold
endif

if exists('s:current_syntax')
  let b:current_syntax=s:current_syntax
endif

" Officially, vim-jsx depends on the pangloss/vim-javascript syntax package
" (and is tested against it exclusively).  However, in practice, we make some
" effort towards compatibility with other packages.
"
" These are the plugin-to-syntax-element correspondences:
"
"   - pangloss/vim-javascript:      jsBlock, jsExpression
"   - jelera/vim-javascript-syntax: javascriptBlock
"   - othree/yajs.vim:              javascriptNoReserved


" Weex attributes should color as JS.  Note the trivial end pattern; we let
" jsBlock take care of ending the region.
syn region xmlString contained start=+{+ end=++ contains=jsBlock,javascriptBlock

" Weex child blocks behave just like weex attributes, except that (a) they are
" syntactically distinct, and (b) they need the syn-extend argument, or else
" nested XML end-tag patterns may end the outer weRegion.
syn region weChild contained start=+{+ end=++ contains=jsBlock,javascriptBlock
  \ extend

" Highlight weex regions as XML; recursively match.
"
" Note that we prohibit Weex tags from having a < or word character immediately
" preceding it, to avoid conflicts with, respectively, the left shift operator
" and generic Flow type annotations (http://flowtype.org/).
syn region weRegion
  \ contains=@Spell,@XMLSyntax,weRegion,weChild,jsBlock,javascriptBlock
  \ start=+\%(<\|\w\)\@<!<\z([a-zA-Z][a-zA-Z0-9:\-.]*\)+
  \ skip=+<!--\_.\{-}-->+
  \ end=+</\z1\_\s\{-}>+
  \ end=+/>+
  \ keepend
  \ extend

" Add weRegion to the lowest-level JS syntax cluster.
syn cluster jsExpression add=weRegion

" Allow weRegion to contain reserved words.
syn cluster javascriptNoReserved add=weRegion
