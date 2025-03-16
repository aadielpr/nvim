return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		local map = require("gbmnx.utils.map").map

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", stop_after_first = true },
				typescript = { "prettierd", stop_after_first = true },
				typescriptreact = { "prettierd", stop_after_first = true },
				vue = { "prettierd", stop_after_first = true },
				markdown = { "prettierd", stop_after_first = true },
				json = { "prettierd", stop_after_first = true },
				go = { "goimports", "gofmt", "golines" },
			},
		})

		map("n", "fm", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end)
	end,
}
