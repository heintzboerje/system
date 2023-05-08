-- :fennel:1683513317
do
  local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
  else
  end
  do end (vim.opt.runtimepath):prepend(lazypath)
end
local function _2_()
  return (require("monokai-pro")).setup({filter = "octagon"})
end
local function _3_()
  return (require("nvim-treesitter.configs")).setup({ensure_installed = {"scheme", "racket", "lua", "python", "fennel"}, highlight = {enable = true}})
end
local function _4_()
  return (require("noice")).setup()
end
local function _5_()
  return (require("nvim-surround")).setup()
end
do end (require("lazy")).setup({{config = _2_, lazy = false, "loctvl842/monokai-pro.nvim"}, {config = _3_, "nvim-treesitter/nvim-treesitter"}, {"nvim-treesitter/nvim-treesitter-textobjects"}, "itmecho/neoterm.nvim", {lazy = false, "jghauser/mkdir.nvim"}, "nvim-lualine/lualine.nvim", "nvim-tree/nvim-web-devicons", "yamatsum/nvim-nonicons", "Vigemus/iron.nvim", {config = _4_, dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}, "folke/noice.nvim"}, "brenoprata10/nvim-highlight-colors", "Eandrju/cellular-automaton.nvim", "alanfortlink/blackjack.nvim", "udayvir-singh/tangerine.nvim", "udayvir-singh/hibiscus.nvim", {version = "*", event = "VeryLazy", config = _5_, "kylechui/nvim-surround"}, {dependencies = {"nvim-lua/plenary.nvim"}, "nvim-telescope/telescope.nvim"}, "matbme/JABS.nvim", "gpanders/nvim-parinfer", "folke/which-key.nvim", "numToStr/Comment.nvim"}, {performance = {rtp = {reset = false}}})
vim.cmd("colorscheme monokai-pro")
do end (vim.opt)["termguicolors"] = true
vim.g["mapleader"] = " "
require("statusline")
require("repls")
require("mappings")
do end (require("jabs")).setup()
do end (require("nvim-highlight-colors")).setup()
do end (require("nvim-treesitter.configs")).setup()
do end (require("nvim-nonicons")).setup()
require("Comment")("setup")
return (require("nvim-highlight-colors")).setup()