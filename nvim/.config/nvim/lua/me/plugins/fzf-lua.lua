return {'ibhagwan/fzf-lua', config = function()
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
end}
