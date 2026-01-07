local config = require("config")

return {
	{ "kyazdani42/nvim-web-devicons", lazy = true },
	{ "j-hui/fidget.nvim", config = true },
	{ "tpope/vim-fugitive", cmd = { "Git" } },
	{ "mbbill/undotree", lazy = true },
	{ "albenisolmos/center.nvim", config = true },
	{ "m4xshen/smartcolumn.nvim", config = true },
	{ "lambdalisue/suda.vim", lazy = true },
	"tpope/vim-obsession",
	"tpope/vim-repeat",
	-- Pairs
	{ "yorickpeterse/nvim-tree-pairs", config = true },
	{ "windwp/nvim-autopairs", config = true },
	{ "kylechui/nvim-surround", config = true },
	{
		"mattn/emmet-vim",
		ft = config.emmet_filetypes,
	},
}
