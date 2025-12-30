vim.keymap.set('i', '[', '[]<LEFT>')
vim.keymap.set('i', '{', '{}<LEFT>')
vim.keymap.set('i', '(', '()<LEFT>')
vim.keymap.set('i', '\'', '\'\'<LEFT>')
vim.keymap.set('i', '\"', '\"\"<LEFT>')

vim.keymap.set('t', '<C-w>N', '<C-\\><C-n>')
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>')

-- vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
vim.opt.syntax = 'enable'
vim.opt.shell = 'bash'
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.termguicolors = true
require("tokyonight").setup({
	terminal_colors = true,
    transparent = true,
	comments = { italic = true },
    keywords = { italic = true },

    styles = {
        sidebars = "dark",
        floats = "transparent",
    },
})
vim.cmd('colorscheme tokyonight')

-- TreeSitter setting
--require'nvim-treesitter.configs'.setup {
--	ensure_installed = {"c", "python", "zig"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--	sync_install = true,
--	highlight = {
--		enable = true,              -- false will disable the whole extension
--		disable = {},  -- list of language that will be disabled
--	},
--}
