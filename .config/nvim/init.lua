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
vim.opt.clipboard = "unnamedplus"
vim.opt.shell = 'bash'
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.cmd('colorscheme kanagawa')
-- vim.cmd('colorscheme default')
vim.api.nvim_create_augroup('vimrc', { clear = true })


require'nvim-treesitter.configs'.setup {
	ensure_installed = {"tsx", "awk", "go", "verilog", "c_sharp", "html", "glsl", "c", "vue", "python", "javascript", "typescript", "vim", "yaml", "rust", "lua", "commonlisp", "zig"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = true,
	highlight = {
		enable = true,              -- false will disable the whole extension
		disable = {},  -- list of language that will be disabled
	},
}

-- when load .frag
vim.cmd [[autocmd BufRead,BufNewFile *.frag setfiletype glsl]]
vim.cmd [[autocmd BufRead,BufNewFile *.h setfiletype c]]
vim.cmd [[autocmd BufRead,BufNewFile *.astro setfiletype tsx]]

-- setting terminal true color
local function set_terminal_colors()
	vim.g.terminal_color_0  = "#2E3436"
	vim.g.terminal_color_1  = "#CC0000"
	vim.g.terminal_color_2  = "#4E9A06"
	vim.g.terminal_color_3  = "#C4A000"
	vim.g.terminal_color_4  = "#3465A4"
	vim.g.terminal_color_5  = "#75507B"
	vim.g.terminal_color_6  = "#93A1A1"
	vim.g.terminal_color_7  = "#D3D7CF"
	vim.g.terminal_color_8  = "#555753"
	vim.g.terminal_color_9  = "#EF2929"
	vim.g.terminal_color_10 = "#8AE234"
	vim.g.terminal_color_11 = "#FCE94F"
	vim.g.terminal_color_12 = "#729FCF"
	vim.g.terminal_color_13 = "#AD7FA8"
	vim.g.terminal_color_14 = "#34E2E2"
	vim.g.terminal_color_15 = "#EEEEEC"
end

term_height = 25
local function open_termnal()
	vim.cmd("botright split | resize " .. term_height .. "| terminal")
    vim.cmd("setlocal nonu nornu")  -- disable row number
	vim.cmd("startinsert")
end

function fix_term_size()
  local current_win = vim.api.nvim_get_current_win()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
		vim.api.nvim_win_set_height(win, term_height)
    end
  end
end

function resize_term(opt)
	new_height = opt.args
	term_height = tonumber(new_height)
	fix_term_size()
end

-- Vim Enter
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		-- disable background color
		--vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE"})
		set_terminal_colors()
		open_termnal()
	end
})


vim.cmd('set noequalalways')
-- when windows resized
vim.api.nvim_create_autocmd("WinResized", {
  callback = function()
    fix_term_size()
  end,
})

vim.api.nvim_create_user_command("TermH", function()
    print("height:", term_height)
end, {})

vim.api.nvim_create_user_command("RT", resize_term, {nargs = 1})
