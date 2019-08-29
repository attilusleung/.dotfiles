"enable mouse mode
set mouse=a

" Numbered lines
set number

" for indenting: https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on
    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
    autocmd FileType ocaml set tabstop=2 shiftwidth=2 softtabstop=2 textwidth=80
    " ocaml commentstring for commenting
    set commentstring=(*\ %s\ *)
endif
" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.

"remove preview/scratch widow
set completeopt-=preview

" something neovim needs for vimtex to work?
let g:vimtex_compiler_progname = 'nvr'

" ALE
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'python': ['flake8'],
\   'ocaml':['merlin'],
\   'text': ['vale']
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['yapf', 'remove_trailing_lines', 'trim_whitespace'],
\   'ocaml': ['ocamlformat', 'ocp-indent', 'remove_trailing_lines', 'trim_whitespace']
\}
let g:ale_fix_on_save = 1
let g:ale_fix_on_save_ignore = {
\   'python': ['yapf'],
\   'ocaml': ['ocamlformat']
\}
let g:ale_ocaml_ocamlformat_options = '--enable-outside-detected-project --profile=janestreet'

" nmap <F8> <Plug>(ale_fix)

"   'python': ['pyflakes', 'pydocstyle'],
"   'python': ['pyflakes', 'pylint', 'pydocstyle'],
" hi SignColumn ctermbg=233

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
" Plug 'tpope/vim-commentary'
" tcomment?
Plug 'tomtom/tcomment_vim'
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
" deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" jedi for python autocopmlete
Plug 'zchee/deoplete-jedi'
" ocaml deoplete
Plug 'copy/deoplete-ocaml'

Plug 'let-def/ocp-indent-vim'

call plug#end()

" deoplete
let g:deoplete#enable_at_startup = 0
" call deoplete#custom#option('auto_complete', v:false)

" Shortcut for tab merge
noremap <C-t> :Tabmerge <cr>
noremap <C-s> <C-w>T
noremap <silent> <Space> :NERDTreeToggle<cr>
"inoremap <C-Tab> <C-x><C-p>

" Control +(hjkl) for arrow keys
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Black hole register
nnoremap X "_x
vnoremap X "_x
nnoremap D "_dd
vnoremap D "_d

" spellcheck
nnoremap <silent> <F5> :setlocal spell! spelllang=en_us<CR>

" enable deoplete
nnoremap <F6> :call deoplete#toggle()<CR>

" inoremap <C-n> deoplete#manual_complete()
inoremap <silent><expr> <C-n>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ deoplete#manual_complete()
		function! s:check_back_space() abort "{{{
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
		endfunction"}}}

" alefix
nmap <F8> <Plug>(ale_fix)

" tcomment block comment
vnoremap <silent> gb :TCommentBlock<CR>

" set colorscheme and enable 24bit colors
colorscheme falcon
set termguicolors
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## 10d39c3c9a127157304e873999d4cfce ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/home/attilus/.opam/4.08.1/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
