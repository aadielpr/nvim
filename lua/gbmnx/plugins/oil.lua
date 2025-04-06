return {
	{
		"stevearc/oil.nvim",
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
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
				win_options = {
					signcolumn = "yes:2",
				},
			})

			vim.keymap.set("n", "<C-p>", function()
				require("oil").toggle_float()
			end)
		end,
	},
	{
		"refractalize/oil-git-status.nvim",
		dependencies = {
			"stevearc/oil.nvim",
		},
		config = function()
			require("oil-git-status").setup({
				show_ignored = true,
				symbols = {
					index = {
						["!"] = "", -- Ignored
						["?"] = "", -- Untracked
						["A"] = "󱇬", -- Added
						["C"] = "", -- Copied
						["D"] = "", -- Deleted
						["M"] = "", -- Modified
						["R"] = "", -- Renamed
						["T"] = "", -- Type Changed
						["U"] = "", -- Unmerged
					},
					working_tree = {
						["!"] = "", -- Ignored
						["?"] = "", -- Untracked
						["A"] = "󱇬", -- Added
						["C"] = "", -- Copied
						["D"] = "", -- Deleted
						["M"] = "", -- Modified
						["R"] = "", -- Renamed
						["T"] = "", -- Type Changed
						["U"] = "", -- Unmerged
					},
				},
			})
		end,
	},
}
