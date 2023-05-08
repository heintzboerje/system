vim.o.timeout = true
vim.o.timeoutlen = 300
local wk = require("which-key")

wk.register({
	b = {
		name = "buffer",
		b = {"<cmd>JABSOpen<cr>", "switch buffer"}
	}
}, {prefix = "<leader>"})
