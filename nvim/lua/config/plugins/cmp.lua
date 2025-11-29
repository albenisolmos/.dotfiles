return {
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			local cmp = require("cmp")
			local snip = require("snippy")
			local unpack = table.unpack or unpack

			local function has_words_before()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				formatting = {
					fields = { "abbr", "kind" },
					format = function(_, item)
						local ELLIPSIS_CHAR = "…"
						local MAX_LABEL_WIDTH = 30
						local MIN_LABEL_WIDTH = 30
						local symbol_map = {
							Text = "text",
							Method = "method",
							Function = "func",
							Constructor = "constructor",
							Field = "field",
							Variable = "var",
							Class = "class",
							Interface = "inter",
							Module = "mod",
							Property = "prop",
							Unit = "unit",
							Value = "val",
							Enum = "enum",
							Keyword = "key",
							Snippet = "snip",
							Color = "color",
							File = "file",
							Reference = "ref",
							Folder = "dir",
							EnumMember = "enumMember",
							Constant = "const",
							Struct = "struct",
							Event = "event",
							Operator = "op",
							TypeParameter = "type",
							Codeium = "ia",
						}

						local label = item.abbr
						local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
						if truncated_label ~= label then
							item.abbr = truncated_label .. ELLIPSIS_CHAR
						elseif string.len(label) < MIN_LABEL_WIDTH then
							local padding = string.rep(" ", MIN_LABEL_WIDTH - string.len(label))
							item.abbr = label .. padding
						end
						item.kind = symbol_map[item.kind] or item.kind
						return item
					end,
				},
				sources = {
					{ name = "codeium" },
					{ name = "snippy", keyword_length = 2 },
					{ name = "nvim_lsp", keyword_length = 1 },
					{ name = "buffer", keyword_length = 3 },
					{ name = "path" },
				},
				snippet = {
					expand = function(args)
						require("snippy").expand_snippet(args.body)
					end,
				},
				mapping = {
					["<C-n>"] = cmp.mapping(
						cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
						{ "i", "c", "s" }
					),
					["<C-p>"] = cmp.mapping(
						cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
						{ "i", "c", "s" }
					),
					["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
					["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4)),
					["<C-e>"] = cmp.mapping.abort(),
					["<c-m>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}, { "i", "s", "c" }),
					["<cr>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}, { "i", "s", "c" }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				},
			})

			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline("/", {
				sources = { { name = "buffer" } },
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})

			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				if snip.can_expand_or_advance() then
					snip.expand_or_advance()
				end
			end)

			vim.keymap.set({ "i", "s" }, "<C-k>", function()
				if snip.can_jump(-1) then
					snip.previous()
				end
			end)
		end,
	},
	{
		"Exafunction/windsurf.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
}
