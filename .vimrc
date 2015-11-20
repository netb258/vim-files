"----------------------------------- General Settings ------------------------------------

"Plugins and compatibility:
set nocompatible
filetype plugin on
filetype indent on

"Turn on line numbers and syntax highlighting:
syntax on
set number

"Formatting options:
set tabstop=2
set shiftwidth=2
set expandtab

"Search options:
set incsearch
set hlsearch
set ignorecase "use case insensitive searching
set smartcase  "^ unless a capital letter is used

"Set small delays when switching between normal, insert and visual mode.
set timeoutlen=1000
set ttimeoutlen=0

"Always show status line
set laststatus=2
"The ruler is useful, it shows me which column I'm on.
set ruler

"I want pwd to be the same as the file I'm editing.
set autochdir

"Remember more commands and searches
set history=100

"Enable the backspace key in insert mode.
set backspace=2

"When I close a tab, remove the buffer.
set nohidden

"Enable command and file-name completion with <tab>.
set wildmenu
set wildmode=list:longest,full

"----------------------------------- Custom Mappings -------------------------------------

"My leader key is space
let mapleader="\<Space>"

"Opening tabs
map <Leader>t :tabnew<cr>

"Disable default easy-motion mappings
let g:EasyMotion_do_mapping = 0

"Bi-directional find motion
map <Leader><Leader> <Plug>(easymotion-s)

"JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"Search mapping
map <Leader>n <Plug>(easymotion-bd-n)

"Make yanking distant lines easier:
nmap yj y<Plug>(easymotion-j)
nmap yk y<Plug>(easymotion-k)

"Make deleting distant lines easier:
nmap dj d<Plug>(easymotion-j)
nmap dk d<Plug>(easymotion-k)

"I want the current search highlight to be cleared when I hit escape.
nnoremap <silent> <esc> :noh<cr><esc>
"This one is needed, for the above mapping to behave well in the terminal.
nnoremap <esc>^[ <esc>^[
"I also want this mapping in insert mode.
inoremap <silent> <esc> <esc>:noh<cr>

"----------------------------------- Lesser Settings -------------------------------------

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
