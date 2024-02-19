inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap { {}<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
" escape with jj 
inoremap jj <Esc>
cnoremap jj <Esc>

" open fern
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>

" escape terminalmode
tnoremap <C-w>N <C-\><C-n>
tnoremap jj <C-\><C-n>
tnoremap <C-w> <C-\><C-n><C-w>

" open terminal (type 'sh' in normalmode)
nnoremap sh <C-w>s<CR><C-w>w<CR>:term<CR>:set norelativenumber<CR>i

"set number
set relativenumber
set clipboard+=unnamedplus
syntax enable

" set ignorecase
set nowritebackup
set nobackup
"set default shell
set shell=bash
set noswapfile
set autoindent 
set tabstop=4
set shiftwidth=4


source $HOME/.config/nvim/fudebako.vim/manager.vim

function! OpenFern()
	execute "Fern . -reveal=% -drawer -toggle -width=40\<CR>\<Esc>"
endfunction

function! OpenTerminal()
	execute "normal! \<C-w>s\<C-w>w:term\<CR>:resize 10\<CR>:set norelativenumber\<CR>"
endfunction

augroup vimrc
	autocmd!
	autocmd VimEnter * call OpenTerminal() 
	autocmd VimEnter * nested call OpenFern()
	"autocmd bufread,bufnewfile * nested call OpenFern()
augroup END

