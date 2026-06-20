vim.opt.rtp:prepend("/path/to/fudebako.nvim")
require("fudebako").setup({
  plugins = {                          -- loaded immediately
    -- "tpope/vim-surround",              -- shorthand: owner/repo
	"neovim/nvim-lspconfig",
	"chentoast/marks.nvim.git",
	"folke/tokyonight.nvim.git"
  },
  -- delayed = {                          -- lazy-loaded
  --   { src = "fatih/vim-go", ft = { "go" } },
  --   { src = "nvim-telescope/telescope.nvim", cmd = "Telescope" },
  --   { src = "neovim/nvim-lspconfig", ft = "rust", version = "v1.0" },
  -- },
})

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
	--transparent = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = { bold = true },
		sidebars = "transparent",
		floats = "transparent",
	},
	on_highlights = function(hl, c)
		-- ここでは link は壊れない。直接hlテーブルいじる
		hl['@lsp.type.parameter']   = { italic = true, fg = c.fg }
		hl['@lsp.type.macro']       = { bold = true, italic = true, fg = c.magenta }
		hl['@lsp.type.function']    = { bold = true, fg = c.blue }
		hl['@lsp.type.type']        = { italic = true, fg = c.cyan }
		hl['@lsp.typemod.variable.readonly']     = { italic = true }
		hl['@lsp.typemod.function.declaration']  = { bold = true, underline = true, fg = c.blue }
		hl['@lsp.typemod.variable.globalScope']  = { bold = true, italic = true }
		hl['@lsp.typemod.variable.functionScope']= { italic = true }
		hl['@lsp.mod.deprecated']                = { strikethrough = true }
		hl['@lsp.mod.unused']                    = { italic = true }

		-- C固有
		hl.cStatement    = { italic = true, fg = c.purple }
		hl.cType         = { italic = true, fg = c.cyan }
		hl.cDefine       = { bold = true, italic = true, fg = c.orange }
	end,

})
vim.cmd('colorscheme tokyonight-storm')
--vim.cmd('colorscheme tokyonight')

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

vim.lsp.config('clangd', {
	filetypes = { 'c', 'h', 'cpp', 'cc' },
	cmd = {
		"clangd",
		"--background-index",
		'--clang-tidy',
		'--log=verbose',
	},
	root_markers = { 'Makefile' },
})
vim.lsp.enable('clangd')

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

require'marks'.setup {
	-- whether to map keybinds or not. default true
	default_mappings = true,
	-- which builtin marks to show. default {}
	builtin_marks = { ".", "<", ">", "^" },
	-- whether movements cycle back to the beginning/end of buffer. default true
	cyclic = true,
	-- whether the shada file is updated after modifying uppercase marks. default false
	force_write_shada = false,
	-- how often (in ms) to redraw signs/recompute mark positions. 
	-- higher values will have better performance but may cause visual lag, 
	-- while lower values may cause performance penalties. default 150.
	refresh_interval = 250,
	-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
	-- marks, and bookmarks.
	-- can be either a table with all/none of the keys, or a single number, in which case
	-- the priority applies to all marks.
	-- default 10.
	sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
	-- disables mark tracking for specific filetypes. default {}
	excluded_filetypes = {},
	-- disables mark tracking for specific buftypes. default {}
	excluded_buftypes = {},
	-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
	-- sign/virttext. Bookmarks can be used to group together positions and quickly move
	-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
	-- default virt_text is "".
	bookmark_0 = {
		sign = "⚑",
		virt_text = "hello world",
		-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
		-- defaults to false.
		annotate = false,
	},
	mappings = {}
}
