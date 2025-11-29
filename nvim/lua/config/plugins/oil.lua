return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	keys = { { "<leader>f", "<cmd>Oil<cr>" } },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
		})
	end,
}
