return {'albenisolmos/autochdir.nvim', config = function()
	require('autochdir').setup {
		flags = {
			['rs'] = {'Cargo.toml'}
		},
		keep_dir = true
	}
end}
