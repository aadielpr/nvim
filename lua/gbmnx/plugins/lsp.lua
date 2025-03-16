return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lsp = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local map = require("gbmnx.utils.map").map

		local function on_attach(_, bufnr)
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
		local mason_registry = require("mason-registry")
		local vue_language_server = mason_registry.get_package("vue-language-server"):get_install_path()
			.. "/node_modules/@vue/language-server"

		mason_lsp.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,
			["ts_ls"] = function()
				lspconfig.ts_ls.setup({
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server,
							languages = { "vue" },
						},
					},
					on_attach = on_attach,
					capabilities = capabilities,
					handlers = {
						["textDocument/definition"] = function(_, result, ctx, _)
							if not result or vim.tbl_isempty(result) then
								return
							end

							-- If multiple results exist, jump to the first one
							local client = vim.lsp.get_client_by_id(ctx.client_id)
							if vim.tbl_islist(result) then
								vim.lsp.util.jump_to_location(result[1], client.offset_encoding)
							else
								vim.lsp.util.jump_to_location(result, client.offset_encoding)
							end
						end,
					},
				})
			end,
			["volar"] = function()
				lspconfig.volar.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					init_options = {
						vue = {
							hybridMode = false,
						},
					},
				})
			end,
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,
			["html"] = function()
				lspconfig.html.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					filetypes = { "html", "templ" },
				})
			end,
			["tailwindcss"] = function()
				lspconfig.tailwindcss.setup({
					filetypes = { "vue" },
				})
			end,
		})

		-- Handle missing filetype
		vim.filetype.add({ extension = { templ = "templ" } })

		-- Diagnostic
		vim.diagnostic.config({
			float = {
				focusable = true,
				border = "single",
				source = "always",
				max_width = 70, -- Limit width
				max_height = 15, -- Limit height
				header = "",
				prefix = "",
			},
		})

		local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

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
