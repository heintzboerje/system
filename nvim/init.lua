local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	{"nvim-lua/plenary.nvim"},

	{"nvim-treesitter/nvim-treesitter",
	config=function()
		require("nvim-treesitter.configs").setup({ensure_installed = {"racket", "scheme", "lua", "python", "ruby"},
		endwise = {enable = true}, highlight = {enable = true}})
	end},

	{"numToStr/Comment.nvim",
	config = function()
		require('Comment').setup()
	end},

	{"nvim-treesitter/nvim-treesitter-textobjects"},

	{"RRethy/nvim-treesitter-endwise"},

	{"itmecho/neoterm.nvim"},

	{"jghauser/mkdir.nvim"},

	{"nvim-tree/nvim-web-devicons"},

	--{"yamatsum/nvim-nonicons"},

	{"loctvl842/monokai-pro.nvim"},

	{"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	config = function ()
		require("nvim-surround").setup({})
	end},

	{"folke/noice.nvim",
	config=function()
		require("noice").setup()
	end,
	dependencies={"MunifTanjim/nui.nvim",
	"rcarriga/nvim-notify"}},

	{"brenoprata10/nvim-highlight-colors"},

	{"Eandrju/cellular-automaton.nvim"},

	{'tamton-aquib/zone.nvim',
	config = function()
		require("zone").setup()
	end},

	{'folke/drop.nvim',
	event = "VimEnter",
	config = function()
		require("drop").setup()
	end},

	{"alanfortlink/blackjack.nvim"},

	--[[ {"matbme/JABS.nvim",
	lazy = false,
	config = function()
		require("jabs").setup ({
			position = {"center", "bottom"},
			border = 'single',
			use_devicons = false
		})
	end}, ]]

	{"toppair/reach.nvim",
	config = function()
		require('reach').setup({})
		require('reach').buffers({})
	end},

	-- {"gpanders/nvim-parinfer"},
	{"vim-scripts/paredit.vim"},

	{"m-demare/hlargs.nvim"},

	{"windwp/nvim-autopairs",
	config = function()
		require("nvim-autopairs").setup {}
	end},

	{"folke/which-key.nvim"},

	{"windwp/windline.nvim"},

	{"Vigemus/iron.nvim"},

	{"lifepillar/vim-mucomplete"},
})

require("repls")
require("pretty_colors")
require("mappings")
require("hlargs").setup()
require("wlsample.vscode")

vim.cmd.colorscheme("monokai-pro-machine")
vim.opt.number = true
vim.opt.termguicolors = true
vim.g.mapleader = " "

-- these settings are for mucomplete
vim.cmd("set completeopt+=menuone")
vim.cmd("set shortmess+=c")
