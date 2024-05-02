vim.api.nvim_command('source $HOME/.config/nvim/fudebako.vim/manager.vim')


vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('c', 'jj', '<Esc>')

vim.keymap.set('i', '[', '[]<LEFT>')
vim.keymap.set('i', '{', '{}<LEFT>')
vim.keymap.set('i', '(', '()<LEFT>')
vim.keymap.set('i', '\'', '\'\'<LEFT>')
vim.keymap.set('i', '\"', '\"\"<LEFT>')

vim.keymap.set('n', '<C-n>', ':Fern . -reveal=% -drawer -toggle -width=40<CR>')

vim.keymap.set('t', 'jj', '<C-\\><C-n>')
vim.keymap.set('t', '<C-w>N', '<C-\\><C-n>')
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>')

vim.opt.relativenumber = true
vim.opt.syntax = 'enable'
vim.cmd('colorscheme hybrid')
vim.opt.clipboard = "unnamedplus"
vim.opt.shell = 'bash'
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.api.nvim_create_augroup('vimrc', { clear = true })
-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
-- 	pattern = {"*"},
-- 	command = "Fern . -reveal=% -drawer -toggle -width=40\\<CR>\\<Esc>"
-- })

require'nvim-treesitter.configs'.setup {
	ensure_installed = {"c", "python", "typescript", "vim", "yaml", "rust", "lua", "commonlisp"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = true,
	highlight = {
		enable = true,              -- false will disable the whole extension
		disable = {},  -- list of language that will be disabled
	},
}

