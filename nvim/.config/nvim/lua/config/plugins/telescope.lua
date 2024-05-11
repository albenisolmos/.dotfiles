local builtin = {}
local find_by_git = true

local function toggle_find_method()
	find_by_git = not find_by_git
	print("Find method:", find_by_git and "Git" or "Files")
end

local function find_files()
	local results = require("telescope.utils").get_os_command_output({ "git", "rev-parse", "--git-dir" })
	builtin = require("telescope.builtin")

	if results[1] and find_by_git then
		builtin.git_files()
	else
		builtin.find_files()
	end
end

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "tG", toggle_find_method },
			{ "tl", "<cmd>Telescope oil<cr>" },
			{ "tt", "<cmd>Telescope find_files<cr>" },
			{ "to", "<cmd>Telescope oldfiles<cr>" },
			{ "tT", find_files },
			{ "tb", "<cmd>Telescope buffers<cr>" },
			{ "tg", "<cmd>Telescope live_grep<cr>" },
			{ "tI", "<cmd>Telescope lsp_document_symbols<cr>" },
			{
				"ti",
				function()
					builtin.lsp_document_symbols({ ignore_symbols = { "variable" } })
				end,
			},
		},
		config = function()
			builtin = require("telescope.builtin")

			require("telescope").setup({
				defaults = {
					preview = false,
					file_ignore_patterns = {
						"node_modules",
						".git",
					},
				},
				pickers = {
					git_files = { theme = "dropdown", hidden = true },
					oldfiles = { theme = "dropdown" },
					find_files = { theme = "dropdown", hidden = true },
					buffers = { theme = "dropdown" },
					live_grep = { theme = "dropdown" },
					lsp_document_symbols = { theme = "dropdown" },
				},
				extensions = {
					oil = { theme = "dropdown" },
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
		end,
	},
	{
		"albenisolmos/telescope-oil.nvim",
		config = function()
			require("telescope").load_extension("oil")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
}
