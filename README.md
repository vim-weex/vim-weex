vim-weex
=======

Syntax highlighting and indenting for WEEX.  Weex is a JavaScript syntax
transformer which translates inline HTML document fragments into JavaScript
objects.  It was developed by Alibaba alongside [Weex][1].

vim-weex is _not_ a JavaScript syntax package, so in order to use it, you will
also need to choose a base JS highlighter.  [pangloss/vim-javascript][2] is the
recommended package---it is vim-weex's "official" dependency, and the only
package against which it is regularly tested.  However, vim-weex makes a best
effort to support other JavaScript syntax packages, including:
- pangloss/vim-javascript
- jelera/vim-javascript-syntax
- othree/yajs

Notably, the system vim JavaScript syntax is _not_ supported, due to its
over-simplicity.  However, the system HTML syntax package is an implicit
dependency.

Troubleshooting
---------------

If you're experiencing incorrect highlighting or indenting in your weex code,
please file a GitHub issue which includes the following:

- A brief affirmation that you've read the README and have installed one of the
  supported dependencies (and the name of the one you're using).

- A minimal ~/.vimrc which repros the issue you're having, as well as both a
  paste and a screenshot of the issue (a paste alone is insufficient, since it
  doesn't illustrate the specific highlighting or indenting problem).  To
  obtain a minimal ~/.vimrc, simply bisect your ~/.vimrc by adding `finish` at
  various points in the file.  (You can likewise bisect your included plugins
  by selectively including only half of them, then a quarter, etc.).

Most of the issues filed result from failures to install vim-javascript or
conflicts with existing JS syntax or indent files---so failing to indicate that
you've ruled those issues out may result in your issue being closed with
minimal comment.

(Please feel free to disregard all this for feature requests.)

Usage
-----

By default, WEEX syntax highlighting and indenting will be enabled only for
files with the `.we` extension.  If you would like WEEX in `.js` files, add

```viml
let g:weex_ext_required = 0
```

to your .vimrc or somewhere in your include path.

Frequently Asked Questions
--------------------------

- _How come syntax highlighting doesn't work at all?_

This is the only question I'll answer with another question---Which do you
think is more likely: (a) this package fails completely and utterly in serving
its most fundamental purpose, or (b) user error?

- _Why are my end tags colored differently than my start tags?_

vim-weex is basically the glue that holds JavaScript and HTML syntax packages
together in blissful harmony.  This means that any HTML syntax defaults carry
over to the HTML portions of vim, and it's common for many colorschemes to
highlight start and end tags differently due to the system HTML syntax defaults.

- _Syntax highlighting seems to work, but breaks highlighting and indenting
  further down in the file.  What's wrong?_

Installation
------------

### Pathogen

The recommended installation method is via [Pathogen][3].  Then simply execute

    cd ~/.vim/bundle
    git clone https://github.com/vim-weex/vim-weex.git

(You can install [vim-javascript][2] in an analogous manner.)

### Vundle

You can also add vim-weex using [Vundle][4]---just add the following lines to
your `~/.vimrc`:

    Plugin 'vim-weex/vim-weex'

To install from within vim, use the commands below.

    :so ~/.vimrc
    :PluginInstall

Alternatively, use the command below to install the plugins from the command
line.

    vim +PluginInstall +qall

### Manual Installation

If you have no `~/.vim/after` directory, you can download the tarball or zip
and copy the contents to `~/.vim`.

If you have existing `~/.vim/after` files, copy the syntax and indent files
directly into their respective destinations.  If you have existing after syntax
or indent files for Javascript, you'll probably want to do something like

    mkdir -p ~/.vim/after/syntax/javascript
    cp path/to/vim-weex/after/syntax/weex.vim ~/.vim/after/syntax/javascript/weex.vim
    mkdir -p ~/.vim/after/indent/javascript
    cp path/to/vim-weex/after/indent/weex.vim ~/.vim/after/indent/javascript/weex.vim


[1]: https://github.com/alibaba/weex            "Weex"
[2]: https://github.com/pangloss/vim-javascript "pangloss: vim-javascript"
[3]: https://github.com/tpope/vim-pathogen      "tpope: vim-pathogen"
[4]: https://github.com/VundleVim/Vundle.vim    "VundleVim: Vundle.vim"
