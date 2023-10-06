local M = {}
SETTINGS = {}
local opt = vim.o
local to_call = {}

local function set_status(statusln, cmdln)
	opt.laststatus = statusln
	opt.cmdheight = cmdln

	if cmdln > 0 then
		opt.showmode = true
	end
	if statusln == 0 then
		vim.api.nvim_set_hl(0, 'Statusline', {link = 'VertSeparator'})
		vim.api.nvim_set_hl(0, 'StatuslineNC', {link = 'VertSeparator'})
		vim.cmd("set statusline=%{repeat('─',winwidth('.'))}")
	end
end

local status ={
	minimal = {0,1},
	medium  = {3,0},
	full = {3,1}
}

function M.setup(args)
	SETTINGS = args

	if args['status'] then
		table.insert(to_call, function()
			set_status(unpack(status[args.status]))
		end)
	end

	if SETTINGS.float.border == 'margin' then
		SETTINGS.float.border = 'rounded'
		SETTINGS._hide_border = true
	end

end

function M.end_setup()
	for _, call in pairs(to_call) do
		call()
	end
end

return M
