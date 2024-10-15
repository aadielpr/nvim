return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
         -- import mason
         local mason = require("mason")

         -- import mason-lspconfig
         local mason_lsp = require("mason-lspconfig")

         local mason_tool_installer = require("mason-tool-installer")

        mason.setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        })

        mason_lsp.setup({
          ensure_installed = {
            "ts_ls",
            "lua_ls",
            "gopls",
          },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettierd",
                "prettier",
                "gofumpt",
                "goimports",
                "golines",
                "stylua",
            },
        })
  end,
}
