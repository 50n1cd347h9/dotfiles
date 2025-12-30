vim.cmd("source " .. vim.fn.stdpath("config") .. "/fudebako.vim/manager.vim")

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
-- ほげ
-- zig lsp settings
vim.lsp.config('zls', {
	cmd = {"zls"},
	filetypes = {"zig"},
	root_dir = vim.fs.root(0, {"build.zig", ".git"}),
	settings = {
		zig = {
		  cliExecutable = "zig"
		}
  }
})
vim.api.nvim_create_autocmd('BufWritePre',{
  pattern = {"*.zig", "*.zon"},
  callback = function(ev)
    vim.lsp.buf.format()
  end
})
vim.api.nvim_create_autocmd({ 'BufReadPre'}, {
	pattern = {'*.zig', '*.zon'},
	callback = function(ev)
		vim.lsp.enable('zls')
	end
})

-- TreeSitter setting
--require'nvim-treesitter.configs'.setup {
--	ensure_installed = {"c", "python", "zig"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--	sync_install = true,
--	highlight = {
--		enable = true,              -- false will disable the whole extension
--		disable = {},  -- list of language that will be disabled
--	},
--}

-- -- when load .frag
-- vim.cmd [[autocmd BufRead,BufNewFile *.frag setfiletype glsl]]
-- vim.cmd [[autocmd BufRead,BufNewFile *.h setfiletype c]]
-- vim.cmd [[autocmd BufRead,BufNewFile *.astro setfiletype tsx]]
