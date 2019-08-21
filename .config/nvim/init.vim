"enable mouse mode
set mouse=a

" for indenting: https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on
    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif
" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.

" something neovim needs for vimtex to work?
let g:vimtex_compiler_progname = 'nvr'

let g:ale_sign_column_always = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}
let g:ale_fix_on_save = 1
let g:ale_linters = {
\   'python': ['pyflakes', 'pylint', 'pydocstyle'],
\   'text': ['vale']
\}
" hi SignColumn ctermbg=233

" Numbered lines
set number

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

" tmux navigator
Plug 'christoomey/vim-tmux-navigator'
" tab merge
Plug 'vim-scripts/Tabmerge'
" ale linter
Plug 'w0rp/ale'
" vimtex"
Plug 'lervag/vimtex'
" vim-gitgutter
Plug 'airblade/vim-gitgutter'
" falcon colorscheme
Plug 'fenetikm/falcon'
" nerdtree
Plug 'scrooloose/nerdtree'
" vim-fugitive (for git)
Plug 'tpope/vim-fugitive'
" vim-commentary (for commenting)
Plug 'tpope/vim-commentary'
" vim-hybrid-material colorscheme
" Plug 'kristijanhuask/vim-hybrid-material'
" pydocstring
" Plug 'heavenshell/vim-pydocstring'
" vim-multiline-cursors
Plug 'terryma/vim-multiple-cursors'
" vim surround
Plug 'tpope/vim-surround'
" emmet - html snippets
Plug 'mattn/emmet-vim'

call plug#end()

" Shortcut for tab merge
noremap <C-t> :Tabmerge <cr>
noremap <C-s> <C-w>T
noremap <Space> :NERDTreeToggle<cr>
"inoremap <C-Tab> <C-x><C-p>

" Control +(hjkl) for arrow keys
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" function ToggleWriteGood

" Black hole register
nnoremap X "_x
vnoremap X "_x
nnoremap D "_dd
vnoremap D "_d

" spellcheck
nnoremap <F5> :setlocal spell! spelllang=en_us<CR>

" set colorscheme and enable 24bit colors
colorscheme falcon
set termguicolors
