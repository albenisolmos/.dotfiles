local config = require("config")

return {
	--  Depencies
	"kyazdani42/nvim-web-devicons",
	-- Varius
	"tpope/vim-fugitive",
	"mbbill/undotree",
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = false,
	},
	{
		dir = "~/Dev/center.nvim",
		config = function()
			require("center").setup({
				on_vimenter = false,
			})
		end,
	},
	{ "m4xshen/smartcolumn.nvim", config = true },
	"tpope/vim-obsession",
	"tpope/vim-repeat",
	{
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup()
		end,
		cmd = {
			"NavigatorLeft",
			"NavigatorRight",
			"NavigatorUp",
			"NavigatorDown",
		},
		keys = {
			{ "<A-n>", "<CMD>NavigatorLeft<CR>" },
			{ "<A-e>", "<CMD>NavigatorRight<CR>" },
			{ "<A-i>", "<CMD>NavigatorUp<CR>" },
			{ "<A-o>", "<CMD>NavigatorDown<CR>" },
		},
	},
	--"voldikss/vim-floaterm",
	"lambdalisue/suda.vim",
	-- Pairs
	{ "yorickpeterse/nvim-tree-pairs", config = true },
	{ "windwp/nvim-autopairs", config = true },
	--"mfussenegger/nvim-dap",
	{ "kylechui/nvim-surround", config = true },
	{
		"mattn/emmet-vim",
		ft = config.emmet_filetypes,
	},
	-- Mason
	{ "williamboman/mason.nvim", config = true },
	{ "williamboman/mason-lspconfig.nvim", config = true },
	{ "neovim/nvim-lspconfig" },
	-- Snip
	"dcampos/nvim-snippy",
	"honza/vim-snippets",
	"dcampos/cmp-snippy",
}
