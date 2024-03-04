vim.api.nvim_command('source $HOME/.config/nvim/fudebako.vim/manager.vim')


vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('c', 'jj', '<Esc>')

vim.keymap.set('i', '[', '[]<LEFT>')
vim.keymap.set('i', '{', '{}<LEFT>')
vim.keymap.set('i', '(', '()<LEFT>')
vim.keymap.set('i', '\'', '\'\'<LEFT>')
vim.keymap.set('i', '\"', '\"\"<LEFT>')

vim.keymap.set('n', '<C-n>', ':Fern . -reveal=% -drawer -toggle -width=40<CR>')

vim.opt.relativenumber = true
vim.opt.syntax = 'enable'
vim.cmd('colorscheme hybrid')
vim.opt.clipboard = "unnamedplus"


--tnoremap <C-w>N <C-\><C-n>
--tnoremap jj <C-\><C-n>
--tnoremap <C-w> <C-\><C-n><C-w>
--
--nnoremap sh <C-w>s<CR><C-w>w<CR>:term<CR>:set norelativenumber<CR>i
--
--set nowritebackup
--set nobackup
--set shell=bash
--set noswapfile
--set autoindent 
--set tabstop=4
--set shiftwidth=4



--function! OpenFern()
--	execute "Fern . -reveal=% -drawer -toggle -width=40\<CR>\<Esc>"
--endfunction
--
--function! OpenTerminal()
--	execute "normal! \<C-w>s\<C-w>w:term\<CR>:resize 10\<CR>:set norelativenumber\<CR>"
--endfunction
--
--augroup vimrc
--	autocmd!
--	autocmd VimEnter * call OpenTerminal() 
--	autocmd VimEnter * nested call OpenFern()
--	"autocmd bufread,bufnewfile * nested call OpenFern()
--augroup END

require'nvim-treesitter.configs'.setup {
	ensure_installed = {"c", "python", "typescript", "vim", "yaml", "rust"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = true,
	highlight = {
		enable = true,              -- false will disable the whole extension
		disable = {},  -- list of language that will be disabled
	},
}

