"enable mouse mode
set mouse=a

" Numbered lines
set number relativenumber

" nocampatible!!!
set nocompatible

function! OcamlSetup()
    let s:opam_share_dir = substitute(system("opam config var share"), '[\r\n]*$', '', '')
    execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
    execute "set rtp+=" . s:opam_share_dir . "/merlin/vim"
    " source "/home/aqcrazyboy/.opam/4.08.1/share/ocp-indent/vim/indent/ocaml.vim"
    " let s:opam_configuration = {}
    " function! OpamConfOcpIndent()
    "   execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
    " endfunction
    " let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')
    " function! OpamConfMerlin()
    "   let l:dir = s:opam_share_dir . "/merlin/vim"
    "   execute "set rtp+=" . l:dir
    " endfunction
    " let s:opam_configuration['merlin'] = function('OpamConfMerlin')
    " let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
    " let s:opam_packages = ["ocp-indent", "merlin"]
    " let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
    " let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
    " for tool in s:opam_packages
    "   " Respect package order (merlin should be after ocp-index)
    "   if count(s:opam_available_tools, tool) > 0
    "     call s:opam_configuration[tool]()
    "   endif
    " endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## 10d39c3c9a127157304e873999d4cfce ## you can edit, but keep this line
    " if count(s:opam_available_tools,"ocp-indent") == 0
    "   source "/home/aqcrazyboy/.opam/4.08.1/share/ocp-indent/vim/indent/ocaml.vim"
    " endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
endfunction

" for indenting: https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on
    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
    autocmd FileType ocaml set tabstop=2 shiftwidth=2 softtabstop=2 textwidth=80
    " autocmd FileType ocaml call OcamlSetup()
    autocmd FileType text set textwidth=80
    autocmd FileType tex set textwidth=80
    autocmd FileType markdown set textwidth=80
    " ocaml commentstring for commenting
    " set commentstring=(*\ %s\ *)
    " autocmd FileType,BufEnter * call plug#load('ale')
endif
" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.
" set textwidth=80
" set fo-=t

" let b:softwrap = 0
"
"Sy
" augroup softwrap
"     autocmd VimResized * if (exists('b:softwrap') && &columns > 80) | set columns=80 | endif
"     autocmd BufEnter * set columns=999
" augroup END

let g:python3_host_prog = '/home/attilus/.pyenv/versions/nvim3/bin/python'

" TODO: Toggle line formating
let g:w_set_in_wrap = 0

function! s:togglewwrap()
    if g:w_set_in_wrap
        st
        et fo-=w
        let g:w_set_in_wrap = 0
    else
        set fo+=w
        let g:w_set_in_wrap = 1
    endif
endfunction

nnoremap <f7> :call togglewwrap()<cr>
vnoremap <f7> :call togglewwrap()<cr>


"remove preview/scratch widow
set completeopt-=preview

" something neovim needs for vimtex to work?
let g:vimtex_compiler_progname = 'nvr'

" ale
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'python': ['flake8'],
\   'ocaml':['merlin'],
\   'text': ['vale'],
\   'rust': ['rls', 'rustc']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'markdown': ['remove_trailing_lines'],
\   'python': ['yapf', 'remove_trailing_lines', 'trim_whitespace'],
\   'ocaml': ['ocamlformat', 'ocp-indent', 'remove_trailing_lines', 'trim_whitespace'],
\   'rust': ['rustfmt']
\}
let g:ale_fix_on_save = 1
let g:ale_fix_on_save_ignore = {
\   'python': ['yapf'],
\   'ocaml': ['ocamlformat', 'ocp-indent']
\}
" let g:ale_ocaml_ocamlformat_options = '--enable-outside-detected-project --profile=janestreet'
let g:ale_ocaml_ocamlformat_options = '--enable-outside-detected-project'
let g:ale_python_auto_pipenv = 1

let g:markdown_fenced_languages = ['python', 'cpp', 'c', 'rust', 'ocaml']

call OcamlSetup()

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
" Defer loading until buffer enter
Plug 'w0rp/ale' ", { 'on' : [] }
" vimtex"
Plug 'lervag/vimtex'
" vim-gitgutter
Plug 'airblade/vim-gitgutter'
" falcon colorscheme
Plug 'fenetikm/falcon'
" Plug 'tomasr/molokai'
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
" cpp/clang deoplete
" Plug 'zchee/deoplete-clang'
" ocaml indent!
Plug 'let-def/ocp-indent-vim'
" lightline
Plug 'itchyny/lightline.vim'
" Floating terminal!
Plug 'voldikss/vim-floaterm'
" Rust
Plug 'rust-lang/rust.vim'
" markdown?
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
call plug#end()

" deoplete
let g:deoplete#enable_at_startup = 0
" call deoplete#custom#option('auto_complete', v:false)

" Shortcut for tab merge
" noremap <C-t> :Tabmerge <cr>
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

" get rid of the line under lightline
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ 'active': {
    \   'left': [ ['mode', 'paste'],
    \             ['readonly', 'filename', 'modified', 'gitbranch'] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }

" floaterm keymaps
" let g:floater_keymap_toggle = '<C-t>'
nnoremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>

" set colorscheme and enable 24bit colors
colorscheme falcon
" colorscheme molokai
set termguicolors
