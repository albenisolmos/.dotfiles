return {
	"albenisolmos/autochdir.nvim",
	config = function()
		require("autochdir").setup({
			flags = {
				["rs"] = { "Cargo.toml" },
				["cs"] = { "app.manifest" },
			},
			keep_dir = true,
		})
	end,
}
