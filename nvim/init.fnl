(require-macros :hibiscus.core)
(require-macros :hibiscus.vim)

(let [lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim)]
  (when (not (vim.loop.fs_stat lazypath))
    (vim.fn.system [:git
                    :clone
                    "--filter=blob:none"
                    "https://github.com/folke/lazy.nvim.git"
                    :--branch=stable
                    lazypath]))
  (vim.opt.runtimepath:prepend lazypath))

((. (require :lazy) :setup) [

                             ;; Colorscheme
                             {1 :loctvl842/monokai-pro.nvim
                              :lazy false 
                              :config 
                              (fn [] ((. (require :monokai-pro) :setup) {:filter "octagon"}))}

                             ;Treesitter
                             {1 :nvim-treesitter/nvim-treesitter
                              :config
                              (fn [] ((. (require :nvim-treesitter.configs) :setup)
                                      {:ensure_installed [:scheme :racket :lua :python :fennel]
                                       :highlight {:enable true}}))}
           
                             {1 :nvim-treesitter/nvim-treesitter-textobjects}

                             ;Treminal
                             :itmecho/neoterm.nvim
           

                             {1 :jghauser/mkdir.nvim :lazy false}
           
                             ;Statusline
                             :nvim-lualine/lualine.nvim
           
                             ;Pretty icons
                             :nvim-tree/nvim-web-devicons
                             :yamatsum/nvim-nonicons

                             ;REPLs
                             :Vigemus/iron.nvim

                             ;Pretty ui
                             {1 :folke/noice.nvim
                              :config
                              (fn [] ((. (require :noice) :setup)))
                              :dependencies [:MunifTanjim/nui.nvim :rcarriga/nvim-notify]}


                             :brenoprata10/nvim-highlight-colors
          
                             ;Games
                             :Eandrju/cellular-automaton.nvim
                             :alanfortlink/blackjack.nvim

                             :udayvir-singh/tangerine.nvim

                             :udayvir-singh/hibiscus.nvim

                             {1 :kylechui/nvim-surround
                              :version :*
                              :event :VeryLazy
                              :config
                              (fn [] ((. (require :nvim-surround) :setup)))}

                             ;Picker and buffer switcher
                             {1 :nvim-telescope/telescope.nvim
                              :dependencies [:nvim-lua/plenary.nvim]}
                             :matbme/JABS.nvim

                             :gpanders/nvim-parinfer

                             :folke/which-key.nvim

                             :numToStr/Comment.nvim]
           
          
          {:performance {:rtp {:reset false}}})

;; editor options
(color! :monokai-pro)
(set! termguicolors)
;(set! t_Co 256)
(g! mapleader " ")

;; start plugins
(require :statusline)
(require :repls)
(require :mappings)

((. (require :jabs) :setup))
((. (require :nvim-highlight-colors) :setup))
((. (require :nvim-treesitter.configs) :setup))
((. (require :nvim-nonicons) :setup))
((. (require :Comment)) :setup)
((. (require :nvim-highlight-colors) :setup))

