return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"echasnovski/mini.icons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			extensions = {
				fzf = {
					fuzzy = false, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
			},
			defaults = {
				layout_strategy = "flex",
				layout_config = {
					horizontal = { preview_cutoff = 80, preview_width = 0.55 },
					prompt_position = "top",
					-- width = 0.87,
					-- height = 0.80,
				},
				sorting_strategy = "ascending",
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
					n = {
						["<C-c>"] = actions.close,
					},
				},
				initial_mode = "insert",
				file_ignore_patterns = { "node_modules" },
			},
		})

		telescope.load_extension("fzf")

		local opt = { noremap = true, silent = true }

		vim.keymap.set("n", "ff", builtin.find_files, opt)
		vim.keymap.set("n", "ft", builtin.git_files, {})
		vim.keymap.set("n", "fb", builtin.buffers, opt)
		vim.keymap.set("n", "fg", builtin.live_grep, opt)
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end,
}
