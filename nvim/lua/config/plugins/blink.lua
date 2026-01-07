return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },

	-- use a release tag to download pre-built binaries
	version = "1.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Esc>"] = { "hide", "fallback" },
			["<PageUp>"] = { "scroll_documentation_up", "fallback" },
			["<PageDown>"] = { "scroll_documentation_down", "fallback" },
		},
		completion = { list = { selection = { auto_insert = true } } },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
}
