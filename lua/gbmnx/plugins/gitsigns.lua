return {
	"lewis6991/gitsigns.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			local map = require("gbmnx.utils.map").map
			local opts = { buffer = bufnr }

			-- Navigation
			map("n", ".c", function()
				if vim.wo.diff then
					return ".c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, {
				buffer = bufnr,
				expr = true,
			})

			map("n", ",c", function()
				if vim.wo.diff then
					return ",c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, {
				expr = true,
				buffer = bufnr,
			})

			map("n", "gp", gs.preview_hunk, opts)
			map("n", "gb", function()
				gs.blame_line({
					full = true,
				})
			end, opts)
			map("n", "gtb", gs.toggle_current_line_blame, opts)
			map("n", "ghd", gs.diffthis, opts)
			map("n", "ghD", function()
				gs.diffthis("~")
			end, opts)
		end,
	},
}
