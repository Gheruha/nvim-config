return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- install these servers
      ensure_installed = {
        "pyright",   -- Python
        "clangd",    -- C / C++
        "ts_ls",  -- JavaScript & TypeScript
        "sqlls",     -- SQL
        "jdtls",     -- Java
        "lua_ls",    -- Lua
        "html",      -- HTML
        "cssls",     -- CSS
      },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig   = require("lspconfig")
      local on_attach   = function(client, bufnr)
        -- your on_attach here (keymaps, etc)
      end
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Configure each server:
      lspconfig.pyright.setup   { on_attach = on_attach, capabilities = capabilities }
      lspconfig.clangd.setup    { on_attach = on_attach, capabilities = capabilities }
      lspconfig.ts_ls.setup     { on_attach = on_attach, capabilities = capabilities }
      lspconfig.sqlls.setup     { on_attach = on_attach, capabilities = capabilities }
      lspconfig.jdtls.setup     { on_attach = on_attach, capabilities = capabilities }
      lspconfig.lua_ls.setup    { on_attach = on_attach, capabilities = capabilities }
      lspconfig.html.setup      { on_attach = on_attach, capabilities = capabilities }
      lspconfig.cssls.setup     { on_attach = on_attach, capabilities = capabilities }

      -- Keymaps
        vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, {})
        vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, {})
        vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, {})
    end,
    
  },
}
