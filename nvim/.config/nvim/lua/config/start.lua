local api = vim.api
local autocmd = vim.api.nvim_create_autocmd
local acsii_art = require("config.ascii-arts")

local function table_get_key_from_index(t, index)
	local i = 0

	for _, v in pairs(t) do
		if i == index then
			return v
		end
		i = i + 1
	end

	return nil
end

local function center_text(width, text)
	local pad = string.rep(" ", (width - #text) / 2)
	return pad .. text
end

local function start()
	vim.api.nvim_command("enew")

	local buf = vim.api.nvim_get_current_buf()
	local eob = vim.opt.fillchars:get().eob or "~"

	autocmd("InsertEnter", {
		buffer = buf,
		callback = function()
			vim.api.nvim_command("enew")
			vim.opt.fillchars:append({ eob = eob })
		end,
	})

	vim.cmd.setlocal("nonumber")
	vim.cmd.setlocal("norelativenumber")
	vim.cmd.setlocal("nocursorline")
	vim.cmd.setlocal("nocursorcolumn")
	api.nvim_buf_set_name(buf, "Start")
	api.nvim_buf_set_option(buf, "swapfile", false)
	api.nvim_buf_set_option(buf, "buftype", "nofile")
	api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	api.nvim_buf_set_option(buf, "buflisted", false)
	vim.cmd.setlocal("nolist")
	vim.opt.fillchars:append({ eob = " " })

	local content = table_get_key_from_index(acsii_art, math.random(1, 3)) or { "<null>" }
	local message_height = #content
	local height = vim.api.nvim_win_get_height(0)
	local width = vim.api.nvim_win_get_width(0)
	local pad_top = math.floor(height - message_height) / 2

	-- add padding on top to place message at center
	for i = 0, pad_top do
		vim.api.nvim_buf_set_lines(buf, i, -1, false, { "" })
	end

	-- add content
	for i, line in pairs(content) do
		local y = math.floor((height - message_height) / 2) + i
		local center_line = center_text(width, line)

		vim.api.nvim_buf_set_lines(buf, y, -1, false, { center_line })
	end
end

autocmd({ "VimEnter" }, {
	callback = function(ev)
		if api.nvim_call_function("argc", {}) ~= 0 then
			return
		end

		start()
	end,
})
