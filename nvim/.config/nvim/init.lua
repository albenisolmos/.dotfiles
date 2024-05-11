local config = require("config")

config({
	statusline = "medium",
	border = "none",
	emmet_filetypes = {
		"html",
		"css",
		"javascriptreact",
		"typescriptreact",
		"javascript",
		"svelte",
		"astro",
	},
	lsp_clients = {
		"marksman",
		"svelte",
		"cssls",
		"rust_analyzer",
		"clangd",
		"pyright",
		"tsserver",
		"tailwindcss",
		"astro",
		lua_ls = {
			settings = {
				Lua = {
					completion = {
						enable = true,
						callSnippet = "Both",
					},
				},
			},
		},
	},
})
