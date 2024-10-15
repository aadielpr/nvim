return {
	"SirZenith/oil-vcs-status",
	dependencies = {
		"stevearc/oil.nvim",
	},
	config = function()
		require("oil-vcs-status").setup()
	end,
}
