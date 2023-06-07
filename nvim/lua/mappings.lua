vim.o.timeout = true
vim.o.timeoutlen = 300
local wk = require("which-key")

wk.register({
	b = {
		name = "buffer",
		b = {"<cmd>ReachOpen buffers<cr>", "Switch buffer"},
	},
	t = {
		name = "terminal",
		t = {"<cmd>NeotermOpen<cr>", "Open terminal"},
		x = {"<cmd>NeotermClose<cr>", "Close terminal", mode="t"},
		r = {":Neoterm<space>", "Send a command to terminal"},
	},
	f = {
		name = "telescope",
		f = {"<cmd>Telescope find_files<cr>", "Find file"},
		o = {"<cmd>Telescope vim_options<cr>", "Vim options"},
		c = {"<cmd>Telescope colorscheme<cr>", "Change colorscheme"},
		},

}, {prefix = "<leader>"})

-- I didn't know how to do this in pure lua so...
vim.cmd("nnoremap <C-W>m <Cmd>WinShift<CR>")
