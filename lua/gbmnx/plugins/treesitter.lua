return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({
			ensure_installed = { "lua", "tsx", "html", "typescript", "json", "javascript", "go" },
			auto_install = false,

			sync_install = false,
			highlight = {
				enable = true,
				disable = {},
			},
			indent = {
				enable = true,
				disable = {},
			},
			autotag = {
				enable = true,
				filetypes = { "html", "xml" },
			},
		})
	end,
}
