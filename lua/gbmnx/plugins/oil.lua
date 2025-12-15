return {
	{
		"stevearc/oil.nvim",
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		lazy = false,
		config = function()
			require("oil").setup({
				keymaps = {
					["g?"] = { "actions.show_help", mode = "n" },
					["<CR>"] = "actions.select",
					["<leader>r"] = "actions.preview",
					["<ESC>"] = { "actions.close", mode = "n" },
					["<C-l>"] = "actions.refresh",
					["<BS>"] = { "actions.parent", mode = "n" },
					["_"] = { "actions.open_cwd", mode = "n" },
					["g."] = { "actions.toggle_hidden", mode = "n" },
					["g\\"] = { "actions.toggle_trash", mode = "n" },
				},
				use_default_keymaps = false,
				delete_to_trash = true,
				view_options = {
					show_hidden = true,
				},
				float = {
					-- Padding around the floating window
					padding = 2,
					-- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
					max_width = 0.4,
					max_height = 0.8,
				},
			})

			vim.keymap.set("n", "<C-p>", function()
				require("oil").toggle_float()
			end)
		end,
	},
}
