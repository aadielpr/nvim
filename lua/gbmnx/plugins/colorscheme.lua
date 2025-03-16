return {
	"AlexvZyl/nordic.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local nordic = require("nordic")
		nordic.setup({
			after_palette = function(palette)
				palette.bg = palette.black0
				palette.bg_sidebar = palette.black0
				palette.border_fg = palette.gray0
				palette.border_bg = palette.bg
			end,
			bold_keywords = true,
			italic_comments = true,
			transparent = {
				bg = false,
				float = false,
			},
			bright_border = false,
			reduced_blue = true,
			swap_backgrounds = false,
			cursorline = {
				bold = false,
				bold_number = true,
				theme = "dark",
				blend = 0,
			},
			telescope = {
				-- Available styles: `classic`, `flat`.
				style = "classic",
			},
			ts_context = {
				dark_background = true,
			},
		})

		vim.cmd("colorscheme nordic")
	end,
}
