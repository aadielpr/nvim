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
		require("luasnip.loaders.from_vscode").lazy_load()

		local ls = require("luasnip")
		local cmp = require("cmp")
		local MiniIcons = require("mini.icons")
		local npairs = require("nvim-autopairs")

		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		npairs.setup({ enable_check_bracket_line = false })

		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node

		-- JSDoc Comment
		ls.add_snippets("all", {
			s("/*", {
				t({ "/**", " * " }),
				ls.insert_node(1, "Your comment here"),
				t({ "", " */" }),
			}),
		})

		ls.add_snippets("go", {
			s("iferr", {
				t({ "if err != nil {", "\t" }),
				i(1, "log.Println(err)"),
				t({ "", "}" }),
			}),
		})

		local function is_in_start_tag()
			local ts_utils = require("nvim-treesitter.ts_utils")
			local node = ts_utils.get_node_at_cursor()
			if not node then
				return false
			end
			local node_to_check = { "start_tag", "self_closing_tag", "directive_attribute" }
			return vim.tbl_contains(node_to_check, node:type())
		end

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
					ls.lsp_expand(args.body)
				end,
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
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
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			},
			sources = {
				{
					name = "nvim_lsp",
					entry_filter = function(entry, ctx)
						-- Check if the buffer type is 'vue'
						if ctx.filetype ~= "vue" then
							return true
						end

						-- Use a buffer-local variable to cache the result of the Treesitter check
						local bufnr = ctx.bufnr
						local cached_is_in_start_tag = vim.b[bufnr]._vue_ts_cached_is_in_start_tag
						if cached_is_in_start_tag == nil then
							vim.b[bufnr]._vue_ts_cached_is_in_start_tag = is_in_start_tag()
						end
						-- If not in start tag, return true
						if vim.b[bufnr]._vue_ts_cached_is_in_start_tag == false then
							return true
						end

						local cursor_before_line = ctx.cursor_before_line
						-- For events
						if cursor_before_line:sub(-1) == "@" then
							return entry.completion_item.label:match("^@")
						-- For props also exclude events with `:on-` prefix
						elseif cursor_before_line:sub(-1) == ":" then
							return entry.completion_item.label:match("^:")
								and not entry.completion_item.label:match("^:on%-")
						else
							return true
						end
					end,
				},
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer" },
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					-- Below is the default comparitor list and order for nvim-cmp
					cmp.config.compare.offset,
					-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
				},
			},
		})

		cmp.event:on("menu_closed", function()
			local bufnr = vim.api.nvim_get_current_buf()
			vim.b[bufnr]._vue_ts_cached_is_in_start_tag = nil
		end)
	end,
}
