local unpack = table.unpack or unpack
local opt = vim.o
local calls = {}
local M = {
	statusline = "medium",
	border = "rounded",
	lsp_clients = {},
	emmet_filetypes = {},
}

local function set_status(statusln, cmdln)
	opt.laststatus = statusln
	opt.cmdheight = cmdln

	if cmdln > 0 then
		opt.showmode = true
	else
		vim.api.nvim_set_hl(0, "MsgArea", { link = "Statusline" })
	end

	if statusln == 0 then
		vim.cmd("set statusline=%{repeat('─',winwidth('.'))}")
	end
end

local statuslines = {
	minimal = { 0, 1 },
	medium = { 3, 0 },
	full = { 3, 1 },
}

local properties = {
	border = true,
	lsp_clients = true,
	emmet_filetypes = true,
	statusline = function(value)
		table.insert(calls, function()
			local statusln = statuslines[value][1]
			local cmdln = statuslines[value][2]

			opt.laststatus = statusln
			opt.cmdheight = cmdln

			if cmdln > 0 then
				opt.showmode = true
			else
				vim.api.nvim_set_hl(0, "MsgArea", { link = "Statusline" })
			end

			if statusln == 0 then
				vim.cmd("set statusline=%{repeat('─',winwidth('.'))}")
			end
		end)
	end,
	disable_background = function()
		table.insert(calls, function()
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		end)
	end,
}

function M.init(args)
	for key, value in pairs(args) do
		assert(properties[key], "Invalid config key: " .. key)
		if properties[key] then
			M[key] = value
			if type(properties[key]) == "function" then
				properties[key](value)
			end
		end
	end

	--require("config.start")
	require("config.keymaps")
	require("config.configs")
	require("config.autocmds")
	require("config.lazy")

	for _, call in pairs(calls) do
		call()
	end
end

return setmetatable(M, {
	__call = function(_, ...)
		M.init(...)
	end,
})
