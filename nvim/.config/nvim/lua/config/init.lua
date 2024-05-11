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

function M.init(args)
	for key, value in pairs(args) do
		assert(M[key], "Invalid config key: " .. key)
		M[key] = value
	end

	if M["statusline"] then
		table.insert(calls, function()
			set_status(unpack(statuslines[args.statusline]))
		end)
	end

	if M.border == "none" then
		M.border = "rounded"
	end

	require("config.start")
	require("config.keymaps")
	require("config.lazy")
	require("config.configs")
	require("config.commands")

	for _, call in pairs(calls) do
		call()
	end
end

function M.end_init()
	for _, call in pairs(calls) do
		call()
	end
end

return setmetatable(M, {
	__call = function(_, ...)
		M.init(...)
	end,
})
