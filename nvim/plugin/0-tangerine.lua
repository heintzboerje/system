-- pick your plugin manager, default [standalone]
local pack = "tangerine" or "packer" or "paq"

local function bootstrap(url, ref)
	local name = url:gsub(".*/", "")
	local path = vim.fn.stdpath [[data]] .. "/site/pack/" .. pack .. "/start/" .. name

	if vim.fn.isdirectory(path) == 0 then
		print(name .. ": installing in data dir...")

		vim.fn.system {"git", "clone", url, path}
		if ref then
			vim.fn.system {"git", "-C", path, "checkout", ref}
		end

		vim.cmd [[redraw]]
		print(name .. ": finished installing")
	end
end

-- for stable version [recommended]
bootstrap("https://github.com/udayvir-singh/tangerine.nvim")
bootstrap("https://github.com/udayvir-singh/hibiscus.nvim", "1.4")

local status, tanger = pcall(require, [[tangerine]])

if not status then
	print("Can't start tangerine yet. Restart neovim")
else
	tanger.setup({compiler = {
		-- disable popup showing compiled files
		verbose = false,

		-- compile every time you change fennel files or on entering vim
		hooks = {"onsave", "oninit"}
	}
})
end
