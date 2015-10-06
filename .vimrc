"Plugins and compatibility:
set nocompatible
filetype plugin on
filetype indent on

"Turn on line numbers and syntax highlighting:
syntax on
set number

"----------------------------------- Custom Mappings ------------------------------------

let mapleader="\<Space>"

"Map leader p to paste from clipboard
noremap <leader>p "+p
"Map leader y to yank to the clipboard
noremap <leader>y "+y

"Map leader P to paste from clipboard
noremap <leader>P "+P
"Map leader Y to yank to the clipboard
noremap <leader>Y "+Y

"Opening tabs
nnoremap <leader>t :tabnew<cr>

"Disable default easy-motion mappings
let g:EasyMotion_do_mapping = 0 

"Bi-directional find motion (comma is already a VIM motion, but I never use it)
map , <Plug>(easymotion-s)

"JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"----------------------------------------------------------------------------------------

"Formatting options:
set tabstop=2
set shiftwidth=2
set expandtab

"Search options:
set incsearch
set nohlsearch
set ignorecase "use case insensitive searching
set smartcase  "^ unless a capital letter is used

"Set small delays when switching between normal, insert and visual mode.
set timeoutlen=1000
set ttimeoutlen=0

"The ruler is useful, it shows me which column I'm on.
set ruler

"I want pwd to be the same as the file I'm editing.
set autochdir

"Colors and matching:
set matchpairs=(:),{:},[:],<:>
set t_Co=256
colorscheme xoria256
runtime macros/matchit.vim
"I don't want to highlight matching parenthesis.
let g:loaded_matchparen=1

"Simple command to bring up nerd tree.
command! TREE NERDTreeToggle
cabbrev tree TREE

"Small styling option for nerd tree.
let g:NERDTreeDirArrows=0

"HTML and JavaScript indent options:
let g:html_indent_inctags="html,body,head,tbody,li,p"
let g:html_indent_script1="inc"
let g:html_indent_style1="inc"
let g:SimpleJsIndenter_BriefMode=1
