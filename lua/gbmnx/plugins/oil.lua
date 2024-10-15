return {
	"stevearc/oil.nvim",
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	config = function()
		local oil = require("oil")
		oil.setup({
			delete_to_trash = true,
			default_file_explorer = true,
			skip_confirm_for_simple_edits = false,
			watch_for_changes = true,
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _)
					return name == ".." or name == ".git" or name == "node_modules" or name == "dist"
				end,
				natural_order = true,
			},
			keymaps = {
				["<BS>"] = "actions.parent",
				["-"] = "actions.open_cwd",
				["_"] = false,
				["<C-p>"] = false,
				["t"] = "actions.preview",
			},
			float = {
				-- Padding around the floating window
				padding = 2,
				max_width = 100,
				max_height = 80,
				border = "rounded",
				win_options = {
					winblend = 0,
					signcolumn = "number",
				},
				preview_split = "auto",
			},
		})

		vim.keymap.set("n", "<C-p>", oil.toggle_float)
	end,
}
