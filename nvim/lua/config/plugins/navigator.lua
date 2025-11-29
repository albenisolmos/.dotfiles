return {
	"numToStr/Navigator.nvim",
	config = true,
	cmd = {
		"NavigatorLeft",
		"NavigatorRight",
		"NavigatorUp",
		"NavigatorDown",
	},
	keys = {
		{ "<A-n>", "<CMD>NavigatorLeft<CR>" },
		{ "<A-e>", "<CMD>NavigatorRight<CR>" },
		{ "<A-i>", "<CMD>NavigatorUp<CR>" },
		{ "<A-o>", "<CMD>NavigatorDown<CR>" },
	},
}
