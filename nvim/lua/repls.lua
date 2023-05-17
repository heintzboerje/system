					    local iron = require("iron.core")

local views = require("iron.view")

iron.setup {
  config = {
	  highlight_last = "IronLastSent",
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    close_window_on_exit = true,
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = {"zsh"}
      },
      python = require("iron.fts.python").ipython,
      racket = {command = {"racket", "-i"}},
      scheme = {command = {"guile"}},
    },
    -- How the repl window will be displayed
    -- See below for more information
    repl_open_cmd = views.split.vertical.botright(0.4, {number=false})
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = "<space>rsc",
    visual_send = "<space>rsc",
    send_file = "<space>rsf",
    send_line = "<space>rsl",
    send_mark = "<space>rsm",
    mark_motion = "<space>rmc",
    mark_visual = "<space>rmc",
    remove_mark = "<space>rmd",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines

}

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rss', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
vim.keymap.set('t', '<space>x', '<cmd>IronHide<cr>')
