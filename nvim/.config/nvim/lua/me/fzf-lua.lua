local M = {}
local find_by_git = true

function M.toggle_finder()
	find_by_git = not find_by_git
end

function M.find(opts)
	opts = opts or {}
	local fzf_lua = require('fzf-lua')
	-- git_root() will warn us if we're not inside a git repo
	-- so we don't have to add another warning here, if
	-- you want to avoid the error message change it to:
	-- local git_root = fzf_lua.path.git_root(opts, true)
	local git_root = fzf_lua.path.git_root(opts, true)
	if git_root and find_by_git then
		local relative = fzf_lua.path.relative(vim.loop.cwd(), git_root)
		opts.fzf_opts = { ['--query'] = git_root ~= relative and relative or nil }
		fzf_lua.git_files(opts)
	else
		fzf_lua.files({cwd = vim.loop.cwd()})
	end
end

function M.setup()
	require('fzf-lua').setup {
		winopts = {
			hl = {
				normal = 'NormalFloat',
				border = 'FloatBorder',
				scrollborder_e = 'NormalFloat',
				scrollborder_f = 'NormalFloat',
				scrollfloat_e = 'NormalFloat',
				scrollfloat_f = 'NormalFloat',
				cursorline = 'NormalFloat',
				help_normal = 'NormalFloat',
				help_border = 'NormalFloat',
				search = 'NormalFloat'
			}
		},
		files = {
			fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude node_modules}",
			show_cwd_prompt = false,
			show_cwd_false = false,
		},
		preview_opts = 'hidden',
	}
	vim.api.nvim_set_hl(0, 'FzfLuaCursorLine', {fg='#696969', bg='NONE', bold=true})
	vim.api.nvim_set_hl(0, 'FzfLuaCursorLineNr', {bg='NONE', bold=true})
end

return M
