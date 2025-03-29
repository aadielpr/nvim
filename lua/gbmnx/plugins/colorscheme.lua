return {
	{
		"datsfilipe/vesper.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local colors = {
				orange = { base = "#D08770", bright = "#D79784", dim = "#CB775D" },
				red = { base = "#BF616A", bright = "#C5727A", dim = "#B74E58" },
				yellow = { base = "#EBCB8B", bright = "#EFD49F", dim = "#E7C173" },
				green = { base = "#A3BE8C", bright = "#B1C89D", dim = "#97B67C" },
				magenta = { base = "#B48EAD", bright = "#BE9DB8", dim = "#A97EA1" },
				cyan = { base = "#8FBCBB", bright = "#9FC6C5", dim = "#80B3B2" },
				blue = { base = "#5E81AC", bright = "#81A1C1", dim = "#88C0D0" },
			}

			require("vesper").setup({
				transparent = false, -- Boolean: Sets the background to transparent
				italics = {
					comments = true, -- Boolean: Italicizes comments
					keywords = false, -- Boolean: Italicizes keywords
					functions = false, -- Boolean: Italicizes functions
					strings = false, -- Boolean: Italicizes strings
					variables = false, -- Boolean: Italicizes variables
				},
				overrides = {
					["@variable.builtin"] = { fg = colors.orange.base },
					["@keyword.exception"] = { fg = colors.red.base },
					["@keyword.return"] = { fg = colors.red.base },
					["@keyword.coroutine"] = { fg = colors.blue.base },
					["@keyword.import"] = { fg = colors.red.base },
					["@keyword.type"] = { fg = colors.orange.base },
					["@keyword.modifier"] = { fg = colors.magenta.bright },
					["@keyword"] = { fg = colors.blue.base },
					["@constructor"] = { fg = colors.orange.base },
				}, -- A dictionary of group names, can be a function returning a dictionary or a table.
				palette_overrides = {},
			})

			vim.cmd("colorscheme vesper")
		end,
	},
}
