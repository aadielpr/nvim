return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"windwp/nvim-autopairs",
		"echasnovski/mini.icons",
	},
	config = function()
		local luasnip = require("luasnip")
		local cmp = require("cmp")
		local MiniIcons = require("mini.icons")
		local npairs = require("nvim-autopairs")
		local border = require("gbmnx.utils.border")

		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		npairs.setup({ enable_check_bracket_line = false })

		cmp.setup({
			formatting = {
				format = function(_, vim_item)
					local icon, hl = MiniIcons.get("lsp", vim_item.kind)
					vim_item.kind = icon .. " " .. vim_item.kind
					vim_item.kind_hl_group = hl
					return vim_item
				end,
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
					border = border.border_chars_none,
				}),
				documentation = cmp.config.window.bordered({
					winhighlight = "FloatBorder:FloatBorder",
					border = border.border_chars_none,
				}),
			},
			mapping = {
				["<Esc>"] = cmp.mapping.close(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-y>"] = cmp.config.disable,
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<C-n>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-p>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer" },
			},
		})
	end,
}
