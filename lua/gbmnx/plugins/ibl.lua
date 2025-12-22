return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			indent = {
				char = require("ibl.utils").get_listchars(0).space_char,
			},
			scope = {
				char = "┊",
				show_start = false,
			},
		})
	end,
}
