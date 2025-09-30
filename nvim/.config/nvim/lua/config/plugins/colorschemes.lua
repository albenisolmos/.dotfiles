local hl = vim.api.nvim_set_hl
local function link(group, link_group)
	vim.api.nvim_set_hl(0, group, { link = link_group })
end

local function get_hightlight(name)
	local ret = vim.api.nvim_get_hl_by_name(name, true)
	ret.foreground = ret.foreground and string.format("#%06x", ret.foreground)
	ret.background = ret.background and string.format("#%06x", ret.background)
	return ret
end

return {
	{
		dir = "~/Dev/soluna.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			--[[
		require("soluna").setup({
			dynamic_color = true,
			statusline_style = "none",
			style_msgarea = false,
		})

		vim.cmd("colorscheme sol-black")
		]]
		end,
	},
	{
		"kyza0d/xeno.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("xeno").new_theme("sol", {
				base = "#000000",
				accent = "#BB4430",
			})

			vim.cmd("colorscheme sol")

			hl(0, "StatusLine", { bg = nil })
			hl(0, "NormalNC", { bg = nil })
			hl(0, "NormalFloat", { bg = nil })
			hl(0, "FloatBorder", { bg = nil })
			hl(0, "FloatShadow", { bg = nil })
			hl(0, "TabLine", { bg = nil })
			hl(0, "TabLineFill", { bg = nil })
			hl(0, "TabLineSel", {
				bg = get_hightlight("CursorLine").background,
				sp = get_hightlight("CursorLineNr").foreground,
				undercurl = true,
			})
			link("TelescopeNormal", "NormalFloat")
			link("TelescopeBorder", "FloatBorder")
			link("TelescopePromptCounter", "Comment")
			link("FloatermBorder", "FloatBorder")
			link("Floaterm", "NormalFloat")
			link("TelescopeTitle", "Normal")
		end,
	},
	{
		"vague2k/vague.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			--vim.cmd("colorscheme vague")
			vim.api.nvim_set_hl(0, "StatusLine", { bg = nil })
		end,
	},
}
