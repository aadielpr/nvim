return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local neotree = require("neo-tree")
		local map = require("gbmnx.utils.map").map

		neotree.setup({
			close_if_last_window = true,
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_by_name = { "node_modules", "dist", "build", ".github" },
					always_show = { ".gitignore", ".env" },
					never_show = { ".DS_Store", ".git" },
				},
			},
			window = {
				position = "right",
				width = 60,
				mappings = {
					["<BS>"] = "close_node",
				},
			},
			default_component_configs = {
				icon = {
					provider = function(icon, node) -- setup a custom icon provider
						local text, hl
						local mini_icons = require("mini.icons")
						if node.type == "file" then -- if it's a file, set the text/hl
							text, hl = mini_icons.get("file", node.name)
						elseif node.type == "directory" then -- get directory icons
							text, hl = mini_icons.get("directory", node.name)
							-- only set the icon text if it is not expanded
							if node:is_expanded() then
								text = nil
							end
						end

						-- set the icon text/highlight only if it exists
						if text then
							icon.text = text
						end
						if hl then
							icon.highlight = hl
						end
					end,
				},
				kind_icon = {
					provider = function(icon, node)
						local mini_icons = require("mini.icons")
						icon.text, icon.highlight = mini_icons.get("lsp", node.extra.kind.name)
					end,
				},
			},
		})

		map("n", "<C-p>", ":Neotree toggle=true<CR>", { silent = true, noremap = true })
	end,
}
