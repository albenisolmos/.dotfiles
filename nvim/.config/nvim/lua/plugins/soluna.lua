return {dir = '~/Dev/vim-plugins/soluna', lazy = false, config = function()
	require('soluna').setup {
		dynamic_color = true,
        statusline_style = 'none'
	}
end}
