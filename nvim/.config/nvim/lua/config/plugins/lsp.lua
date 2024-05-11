return {
	"neovim/nvim-lspconfig",
	config = function()
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

		local clients = require("config").lsp_clients
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local opts = {
			autostart = true,
			capabilities = capabilities,
			flags = {
				debounce_text_changes = 150,
			},
		}

		for client, client_opts in pairs(clients) do
			if type(client) == "number" then
				lspconfig[client_opts].setup(opts)
			else
				local tbl = vim.tbl_extend("force", opts, client_opts)
				lspconfig[client].setup(tbl)
			end
		end

		local sign_define = vim.fn.sign_define
		local hightlights = {
			"DiagnosticSignError",
			"DiagnosticSignWarn",
			"DiagnosticSignInfo",
			"DiagnosticSignHint",
		}

		for _, hi in pairs(hightlights) do
			sign_define(hi, { text = "", texthl = hi, linehl = "", numhl = hi })
		end
	end,
}
