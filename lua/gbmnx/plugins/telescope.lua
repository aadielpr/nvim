return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"echasnovski/mini.icons",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local map = require("gbmnx.utils.map").map

		telescope.setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({ initial_mode = "normal" }),
				},
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
			defaults = {
				layout_strategy = "flex",
				layout_config = {
					horizontal = { preview_cutoff = 80, preview_width = 0.5 },
					prompt_position = "top",
					width = 0.6,
					height = 0.6,
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
			pickers = {
				find_files = { theme = "dropdown", previewer = true },
				live_grep = { theme = "dropdown", previewer = true },
				buffers = { theme = "dropdown", previewer = true },
				help_tags = { theme = "dropdown", previewer = true },
				git_files = { theme = "dropdown", previewer = true },
				grep_string = { theme = "dropdown", previewer = true },
				lsp_references = { theme = "dropdown", previewer = true },
				lsp_definitions = { theme = "dropdown", previewer = true },
				lsp_implementations = { theme = "dropdown", previewer = true },
				diagnostics = { theme = "dropdown", previewer = true },
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")

		map("n", "<leader>ff", builtin.find_files)
		map("n", "<leader>ft", builtin.git_files, {})
		map("n", "<leader>fb", builtin.buffers)
		map("n", "<leader>fg", builtin.live_grep)
		map("n", "<leader>fd", builtin.diagnostics)
		map("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		map("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		map("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end,
}
