return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = 'v:lua.require("conform").formatexpr()'
	end,
	opts = {
		format_after_save = { timeout_ms = 500 },
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			javascriptreact = { { "prettierd", "prettier" } },
			typescriptreact = { { "prettierd", "prettier" } },
			astro = { { "prettierd", "prettier" } },
			svelte = { { "prettierd", "prettier" } },
		},
	},
}
