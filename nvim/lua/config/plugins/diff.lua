return {
	"echasnovski/mini.diff",
	version = "*",
	opts = {
		-- Options for how hunks are visualized
		view = {
			-- Visualization style. Possible values are 'sign' and 'number'.
			-- Default: 'number' if line numbers are enabled, 'sign' otherwise.
			style = "sign",
			-- Signs used for hunks with 'sign' view
			signs = { add = "│", change = "│", delete = "│" },
			-- Priority of used visualization extmarks
			priority = 199,
		},
		-- Source(s) for how reference text is computed/updated/etc
		-- Uses content from Git index by default
		source = nil,
		-- Delays (in ms) defining asynchronous processes
		delay = {
			-- How much to wait before update following every text change
			text_change = 200,
		},
	},
}
