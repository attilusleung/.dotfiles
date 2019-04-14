"enable mouse mode
set mouse=a

"something neovim needs for vimtex to work?
let g:vimtex_compiler_progname = 'nvr'

let g:ale_sign_column_always = 1
"hi SignColumn ctermbg=233

"Numbered lines
set number

if empty(glob('~/.config/nvim/autoload/plug.vim')) 
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

"tmux navigator
Plug 'christoomey/vim-tmux-navigator'
"ale linter
Plug 'w0rp/ale'
"vimtex"
Plug 'lervag/vimtex'
"vim-gitgutter
Plug 'airblade/vim-gitgutter'
"falcon colorscheme
Plug 'fenetikm/falcon'
"nerdtree
Plug 'scrooloose/nerdtree'

call plug#end()

"set colorscheme and enable 24bit colors, whatever that means 
colorscheme falcon
set termguicolors
