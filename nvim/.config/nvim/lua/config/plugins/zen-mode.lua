return {'folke/zen-mode.nvim', config = function()
	require('zen-mode').setup {
		window = {
			options = {
				statusline = 'zennn'
			}
		}
	}
end}
