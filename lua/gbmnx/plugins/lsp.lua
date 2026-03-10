return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lsp = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local map = require("gbmnx.utils.map").map

		local function on_attach(client, bufnr)
			client.server_capabilities.semanticTokensProvider = nil
			local opts = { noremap = true, silent = true, buffer = bufnr }

			map("n", "gD", vim.lsp.buf.declaration, opts)
			map("n", "gd", vim.lsp.buf.definition, opts)
			map("n", "gi", vim.lsp.buf.implementation, opts)
			map("n", "K", vim.lsp.buf.hover, opts)
			map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			map("n", "<leader>rn", vim.lsp.buf.rename, opts)
			map("i", "<C-h>", vim.lsp.buf.signature_help, opts)
			map("n", "gr", vim.lsp.buf.references, opts)

			-- diagnostic
			map("n", "E", vim.diagnostic.open_float, opts)
			map("n", ".d", vim.diagnostic.goto_next, opts)
			map("n", ",d", vim.diagnostic.goto_prev, opts)
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local server_configs = {
			ts_ls = {
				handlers = {
					["textDocument/definition"] = function(_, result, ctx, _)
						if not result or vim.tbl_isempty(result) then
							return
						end
						local client = vim.lsp.get_client_by_id(ctx.client_id)
						if vim.tbl_islist(result) then
							vim.lsp.util.jump_to_location(result[1], client.offset_encoding)
						else
							vim.lsp.util.jump_to_location(result, client.offset_encoding)
						end
					end,
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},
			html = {
				filetypes = { "html", "templ" },
			},
			tailwindcss = {
				filetypes = { "vue" },
			},
		}

		mason_lsp.setup({
			handlers = {
				-- default handler for installed servers
				function(server_name)
					local config = server_configs[server_name] or {}
					config.capabilities = capabilities
					config.on_attach = on_attach
					lspconfig[server_name].setup(config)
				end,
			},
		})

		-- Handle missing filetype
		vim.filetype.add({ extension = { templ = "templ" } })

		-- Diagnostic
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰌵 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			float = {
				focusable = true,
				border = "single",
				source = "always",
				max_width = 70,
				max_height = 15,
				header = "",
				prefix = "",
			},
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "single", -- Other options: "double", "shadow", "none"
			max_width = 70,
			max_height = 15,
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "single",
			max_width = 70,
			max_height = 15,
		})
	end,
}
