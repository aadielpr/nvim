return {
	{
		"datsfilipe/vesper.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vesper").setup({
				transparent = false, -- Boolean: Sets the background to transparent
				italics = {
					comments = true, -- Boolean: Italicizes comments
					keywords = false, -- Boolean: Italicizes keywords
					functions = false, -- Boolean: Italicizes functions
					strings = false, -- Boolean: Italicizes strings
					variables = false, -- Boolean: Italicizes variables
				},
				overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
				palette_overrides = {},
			})

			vim.cmd("colorscheme vesper")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "moon", -- auto, main, moon, or dawn
				dark_variant = "moon", -- main, moon, or dawn
				dim_inactive_windows = false,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},

				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},

				palette = {
					-- Override the builtin palette per variant
					main = {
						base = "#101010",
						surface = "#101010",
						-- overlay = "#101010",
					},
					moon = {
						base = "#101010",
						surface = "#101010",
						-- overlay = "#363738",
					},
				},
			})

			-- vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"aktersnurra/no-clown-fiesta.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			-- local plugin = require("no-clown-fiesta")
			-- return plugin.load({
			-- 	theme = "dark",
			-- 	styles = {
			-- 		type = { bold = true },
			-- 		lsp = { underline = false },
			-- 		match_paren = { underline = true },
			-- 	},
			-- })
		end,
	},
}
