syntax enable
set tabstop=4
set shiftwidth=4
set expandtab
set number
filetype indent on
set autoindent
"split navigations
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'davidhalter/jedi'
call plug#end()
au BufNewFile,BufRead *.py \
  set foldmethod=indent
nnoremap <space> za
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}
let g:ale_fixers = {
      \    'python': ['yapf'],
      \}
nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 1
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}

