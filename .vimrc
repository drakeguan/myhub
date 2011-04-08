" syntax highlight and auto-complete
syntax on
source $VIMRUNTIME/autoload/syntaxcomplete.vim 

" make vim support 256 colors
set t_Co=256
colorscheme wombat256

set nocompatible
set clipboard=unnamed
set autoindent
set autoread
set hlsearch
set incsearch
set ignorecase
set modeline
"set nowrap
set ruler
set showmode
set showcmd
set showmatch
set smartcase
set wildmenu

" mouse
set mouse=a

" bail out if this isn't wanted (mrsvim.vim uses this).
if exists("g:skip_loading_mswin") && g:skip_loading_mswin
  finish
endif

" set the 'cpoptions' to its Vim default
if 1	" only do this when compiled with expression evaluation
  let s:save_cpo = &cpoptions
endif
set cpo&vim

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
"behave mswin

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X and SHIFT-Del are Cut
"vnoremap <C-X> "+x
"vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
"vnoremap <C-C> "+y
"vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
"map <C-V>		"+gP
"map <S-Insert>		"+gP

"cmap <C-V>		<C-R>+
"cmap <S-Insert>		<C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

"exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
"exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

"imap <S-Insert>		<C-V>
"vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
"noremap <C-Q>		<C-V>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" CTRL-Z is Undo; not in cmdline though
"noremap <C-Z> u
"inoremap <C-Z> <C-O>u

" CTRL-Y is Redo (although not repeat); not in cmdline though
"noremap <C-Y> <C-R>
"inoremap <C-Y> <C-O><C-R>

" Alt-Space is System menu
if has("gui")
"  noremap <M-Space> :simalt ~<CR>
"  inoremap <M-Space> <C-O>:simalt ~<CR>
"  cnoremap <M-Space> <C-C>:simalt ~<CR>
  set guioptions-=T "disable toolbar
endif

" CTRL-A is Select all
"noremap <C-A> gggH<C-O>G
"inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
"cnoremap <C-A> <C-C>gggH<C-O>G

" CTRL-Tab is Next window
noremap <C-Tab> :tabn<CR>
inoremap <C-Tab> <C-O>:tabn<CR>
cnoremap <C-Tab> <C-C>:tabn<CR>

" CTRL-F4 is Close window
noremap <C-F4> :tabc<CR>
inoremap <C-F4> <C-O>:tabc<CR>
cnoremap <C-F4> <C-C>:tabc<CR>
" CTRL+d is close tab
noremap <C-D> :tabc<CR>

" CTRL+N is new tab
noremap <C-N> :tabe<CR>
inoremap <C-N> <C-O>:tabe<CR>
cnoremap <C-N> <C-C>:tabe<CR>

" CTRL+[ is previous tab
map <C-[> :tabp<CR>

" CTRL+} is next tab
"map <C-\> :tabn<CR>
map <C-]> :tabn<CR>

" restore 'cpoptions'
set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif

" 光棒
"se cursorline
"hi cursorLine term=none cterm=none ctermbg=7
"autocmd InsertLeave * hi cursorLine term=none cterm=none ctermbg=7
"autocmd InsertEnter * hi cursorLine term=none cterm=none ctermbg=6

let $LANG="zh_TW.UTF-8" " locales
"set encoding=utf-8      " ability
set fileencoding=utf-8  " prefer
" charset detect list. ucs-bom must be earlier than ucs*.
set fileencodings=utf-8,big5,latin1,ascii

" tab size
set shiftwidth=4
set softtabstop=4

let python_highlight_all=1

" smartindent for python
"autocmd BufRead *.py set nu et smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufRead *.py set nu et cinwords=if,elif,else,for,while,try,except,finally,def,class

" highligh tabs for python
" ref: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
autocmd BufRead *.py set list listchars=tab:»-
autocmd BufRead *.mel set list listchars=tab:»-
autocmd BufRead *.tcl set list listchars=tab:»-
autocmd BufRead *.slim set list listchars=tab:»-

" actionscript 3 file type
autocmd BufRead *.as set filetype=actionscript

"" taglist
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1

" python_fn
"map  ]k    :call PythonNextLine(-1)<CR>
"map  ]j    :call PythonNextLine(1)<CR>

"" ctags for python 2.5 built-in libraries
"" generated as ctags -R -f ~/.vim/tags/python.ctags /usr/lib/python2.5/
"set tags+=$HOME/.vim/tags/python.ctags
"map <silent><C-Left> <C-T>
"map <silent><C-Right> <C-]>

"map <F5> :!make all<cr>




"""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-latex suite
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
"set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" ropevim
if has('python')
    let $PYTHONPATH .= ":".$HOME."/.vim/ropevim/pylibs"
    source $HOME/.vim/ropevim/src/ropevim/ropevim.vim
endif
