return {
	'ThePrimeagen/harpoon',
	dependencies = {'nvim-lua/plenary.nvim'},
	keys = {
		{'<leader>hh', function() require('harpoon.ui').toggle_quick_menu() end},
		{'<leader>ha', function() require('harpoon.mark').add_file() end},
		{'<leader>1', function() require('harpoon.ui').nav_file(1) end},
		{'<leader>2', function() require('harpoon.ui').nav_file(2) end},
		{'<leader>3', function() require('harpoon.ui').nav_file(3) end},
		{'<leader>4', function() require('harpoon.ui').nav_file(4) end}
	}
}
