"Plugins and compatibility:
set nocompatible
filetype plugin on
filetype indent on
let mapleader="\<Space>"
let g:EasyMotion_leader_key = "\<Leader>"

"Formatting options:
set tabstop=2
set shiftwidth=2
set expandtab
set number

"Search options
set incsearch
set nohlsearch

"Colors and matching:
set matchpairs=(:),{:},[:],<:>
set t_Co=256
colorscheme xoria256
runtime macros/matchit.vim
"I don't want to highlight matching parenthesis.
let g:loaded_matchparen = 1

"HTML and JavaScript indent options:
let g:html_indent_inctags = "html,body,head,tbody,li,p"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:SimpleJsIndenter_BriefMode = 1
