local command = vim.api.nvim_create_user_command
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local opts = vim.o

command('ToggleFinder', function()
	require('me.telescope').toggle_finder()
end, {})

command('ToggleOverlength', function()
	vim.o.colorcolumn = opts.colorcolumn == '' or opts.colorcolumn == 0 and 80 or 0
end, {})

-- Highlight yanked text
autocmd('TextYankPost', {
	group = augroup('yank_highlight', {}),
	pattern = '*',
	callback = function()
		vim.highlight.on_yank {higroup = 'IncSearch', timeout = 300, on_visual = false}
	end
})
