return {
	dir = "~/Dev/soluna.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("soluna").setup({
			dynamic_color = true,
			statusline_style = "none",
			style_msgarea = false,
		})

		vim.cmd("colorscheme sol-black")
	end,
}
