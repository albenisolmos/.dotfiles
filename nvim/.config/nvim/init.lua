local config = require("config")

config({
	disable_background = true,
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
		astro = {
			init_options = {
				typescript = {
					tsdk = vim.fs.normalize("~/AppData/Local/pnpm/global/5/node_modules/typescript/lib"),
				},
			},
		},
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
