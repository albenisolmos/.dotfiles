return {
	{ "williamboman/mason.nvim", config = true },
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local clients = require("config").lsp_clients
			local lspconfig = vim.lsp.config
			local lsp_opts = {
				autostart = true,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				flags = {
					debounce_text_changes = 150,
				},
			}

			vim.lsp.config("*", {
				root_markers = { ".git" },
			})

			require("mason").setup()
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name) -- default handler
						lspconfig(server_name, lsp_opts)
					end,
				},
			})

			for client, client_opts in pairs(clients) do
				if type(client) == "number" then
					lspconfig[client_opts](lsp_opts)
				else
					local tbl = vim.tbl_extend("force", lsp_opts, client_opts)
					lspconfig(client, tbl)
				end
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { noremap = true, silent = true, buffer = ev.buf }
					local keymap = vim.keymap.set

					keymap("n", "gd", vim.lsp.buf.definition, opts)
					keymap("n", "gD", vim.lsp.buf.declaration, opts)
					keymap("n", "gi", vim.lsp.buf.implementation, opts)
					keymap("n", "gr", vim.lsp.buf.references, opts)
					keymap("n", "<leader>lh", vim.lsp.buf.hover, opts)
					keymap("n", "<leader>lH", vim.lsp.buf.signature_help, opts)
					keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
					keymap("n", "<leader>lc", vim.lsp.buf.code_action, opts)
					keymap("n", "<leader>dd", vim.diagnostic.open_float, opts)
					keymap("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
					keymap("n", "<leader>dn", vim.diagnostic.goto_next, opts)
					keymap("n", "<leader>dl", vim.diagnostic.setloclist, opts)
					keymap("n", "<space>Wa", vim.lsp.buf.add_workspace_folder, opts)
					keymap("n", "<space>Wr", vim.lsp.buf.remove_workspace_folder, opts)
					keymap("n", "<space>Wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
				end,
			})
		end,
	},
}
