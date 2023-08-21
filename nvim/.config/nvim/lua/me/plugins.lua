local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	--  Depencies
	'kyazdani42/nvim-web-devicons',
	-- Varius
	--{dir = '~/Dev/vim-plugins/center.nvim', config = function()
	--	require('center').setup()
	--end},
    'christoomey/vim-tmux-navigator',
    {'stevearc/oil.nvim', config = true},
	'tpope/vim-repeat',
	'michaeljsmith/vim-indent-object',
	'machakann/vim-swap',
	'lukas-reineke/indent-blankline.nvim',
	'ptzz/lf.vim',
	'voldikss/vim-floaterm',
	'lambdalisue/suda.vim',
	{'windwp/nvim-autopairs', config = true},
	{'lewis6991/gitsigns.nvim', config = true},
	'mfussenegger/nvim-dap',
	{'kylechui/nvim-surround', config = true},
	{'mattn/emmet-vim', ft = {
		'html', 'css', 'javascriptreact', 'javascript', 'svelte'}
	},
	'nvim-treesitter/playground',
	{'jedrzejboczar/possession.nvim', config = true},
	-- Mason
	{'williamboman/mason.nvim', config = true},
	{'williamboman/mason-lspconfig.nvim', config = true},
	-- Snip
	'dcampos/nvim-snippy',
	'honza/vim-snippets',
	'dcampos/cmp-snippy',
	{import = 'plugins'}
})
