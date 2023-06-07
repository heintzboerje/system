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
		require("nvim-treesitter.configs").setup({
			ensure_installed = {"racket", "scheme", "lua", "python", "ruby", "haskell"},
			endwise = {enable = true},
			highlight = {enable = true},
			rainbow = {enable = true,
			disable = {'lua', 'cpp', 'python', 'ruby'}}
		})
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

	{"tiagovla/tokyodark.nvim"},

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
		require("zone").setup({
			exclude_filetypes = {"TelescopePrompt",
			"NvimTree", "neo-tree", "dashboard", "lazy", "veil"},
			style = "epilepsy",
			epilepsy = {
				stage = "ictal",
			},
			after = 1000 * 60 * 2
		})
	end},

	{'folke/drop.nvim',
	event = "VimEnter",
	config = function()
		require("drop").setup({
			theme = "snow",
			max = 25,
			screensaver = false, 
			filetypes = {"veil"}
		})
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
	{"kovisoft/paredit"},

	{"m-demare/hlargs.nvim"},

	{"windwp/nvim-autopairs",
	config = function()
		require("nvim-autopairs").setup {}
	end},

	{"folke/which-key.nvim"},

	-- {"windwp/windline.nvim"},

	{"tamton-aquib/staline.nvim",
},

	{"Vigemus/iron.nvim"},

	{"lifepillar/vim-mucomplete"},

	{"HiPhish/nvim-ts-rainbow2"},

	{"willothy/veil.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-telescope/telescope-file-browser.nvim"
	},
	config = true},

	{'tamton-aquib/keys.nvim',
	config = function()
		require("keys").setup {}
	end},

	{'tamton-aquib/staline.nvim'},

	{'sindrets/winshift.nvim',
	config = function()
		require("winshift").setup()
	end}
})

require("repls")
require("pretty_colors")
require("mappings")
require("statusline")
require("hlargs").setup()
-- require("wlsample.vscode")

-- vim.g.tokyodark_color_gamma = "1.5"
vim.cmd.colorscheme("monokai-pro-octagon")
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.laststatus = 3 	-- this is for global statusline
vim.g.mapleader = " "

-- these settings are for mucomplete
vim.cmd("set completeopt+=menuone")
vim.cmd("set shortmess+=c")
-- vim.cmd("let g:mucomplete#chains = {}")
