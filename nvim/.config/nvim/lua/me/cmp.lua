return {'hrsh7th/nvim-cmp', config = function()
	local cmp = require('cmp')
	local snip = require('snippy')

	local function has_words_before()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	cmp.setup({
		window = {
			completion = cmp.config.window.bordered(SETTINGS.float.border),
			documentation = {
				border = SETTINGS.float.border,
				scrollbar = '┃',
			}
		},
		snippet = {
			expand = function(args)
				require('snippy').expand_snippet(args.body)
			end
		},
		mapping = {
			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif snip.can_expand_or_advance() then
					snip.expand_or_advance()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
				end, { "i", "s", 'c' }),
			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif snip.can_jump(-1) then
					snip.previous()
				else
					fallback()
				end
				end, { "i", "s", 'c' }),
			['<C-n>'] = cmp.mapping(function(fallback)
				if snip.can_expand_or_advance() then
					snip.expand_or_advance()
				else
					fallback()
				end
				end, {'s', 'i'}),
			['<C-p>'] = cmp.mapping(function(fallback)
				if snip.can_jump(-1) then
					snip.previous()
				else
					fallback()
				end
				end, {'s', 'i'}),
			['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
			['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
			['<C-c>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
			['<C-e>'] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'snippy' },
			{ name = 'buffer' },
			{ name = 'path' }
		}
	})

	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline('/', {
		sources = {{ name = 'buffer' }}
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		sources = cmp.config.sources(
			{{ name = 'path' }},
			{{ name = 'cmdline' }}
		)
	})
end}
