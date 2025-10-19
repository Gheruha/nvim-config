return {
  -- Mason (LSP/DAP/etc. installer)
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  -- Mason-LSPConfig (bridge Mason <-> nvim-lspconfig)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "pyright", -- Python
        "clangd", -- C/C++
        "ts_ls", -- JavaScript & TypeScript (new name; replaces tsserver)
        "sqlls", -- SQL
        "jdtls", -- Java
        "lua_ls", -- Lua
        "html", -- HTML
        "cssls", -- CSS
        "bzl", -- Bazel / Starlark
      },
      automatic_installation = true,
    },
  },

  -- Core LSP configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      -- nvim-cmp capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- on_attach: buffer-local keymaps, etc.
      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        -- If you use external formatters (prettier/biome), keep ts formatting off:
        if client.name == "ts_ls" then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end

        -- Keymaps
        vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<leader>fm", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)
      end

      -- Servers to configure
      local servers = {
        "pyright", -- Python
        "clangd", -- C/C++
        "ts_ls", -- JavaScript & TypeScript (replaces tsserver)
        "sqlls", -- SQL
        "jdtls", -- Java
        "lua_ls", -- Lua
        "html", -- HTML
        "cssls", -- CSS
        "bzl", -- Bazel / Starlark
      }

      -- Per-server settings/overrides
      local server_opts = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                  "${3rd}/luv/library",
                  "${3rd}/busted/library",
                },
              },
              telemetry = { enable = false },
            },
          },
        },

        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic", -- change to "strict" if you want
                autoImportCompletions = true,
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },

        clangd = {
          -- offsetEncoding tweak can help with jump locations
          capabilities = (function()
            local c = vim.deepcopy(capabilities)
            c.offsetEncoding = { "utf-16" }
            return c
          end)(),
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=iwyu",
          },
        },

        -- New TS/JS server key: ts_ls (typescript-language-server)
        ts_ls = {
          -- If you keep formatting external (prettier/biome), we disable it in on_attach above.
          -- Useful init_options/preferences; adjust to taste:
          init_options = {
            hostInfo = "neovim",
            preferences = {
              includeCompletionsWithSnippetText = true,
              includeAutomaticOptionalChainCompletions = true,
              includeCompletionsForModuleExports = true,
              includeCompletionsForImportStatements = true,
              includeCompletionsWithClassMemberSnippets = true,
              includeCompletionsWithInsertTextCompletions = true,
            },
          },
          settings = {
            javascript = {
              preferGoToSourceDefinition = true,
              suggest = { completeFunctionCalls = true },
            },
            typescript = {
              preferGoToSourceDefinition = true,
              suggest = { completeFunctionCalls = true },
              tsserver = { maxTsServerMemory = 4096 },
            },
          },
          root_dir = function(fname)
            return util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
          end,
        },

        html = {
          capabilities = (function()
            local c = vim.deepcopy(capabilities)
            c.textDocument.completion.completionItem.snippetSupport = true
            return c
          end)(),
        },

        cssls = {
          capabilities = (function()
            local c = vim.deepcopy(capabilities)
            c.textDocument.completion.completionItem.snippetSupport = true
            return c
          end)(),
          settings = {
            css = { validate = true },
            scss = { validate = true },
            less = { validate = true },
          },
        },

        sqlls = {
          cmd = { "sql-language-server", "up", "--method", "stdio" },
          root_dir = function(fname)
            return util.root_pattern(".sqllsrc.json", ".git")(fname) or util.path.dirname(fname)
          end,
        },

        jdtls = {
          -- jdtls likes a per-project workspace; launch Neovim from project root
          root_dir = util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
        },

        bzl = {
          root_dir = util.root_pattern("WORKSPACE", "WORKSPACE.bazel", ".git"),
        },
      }

      -- Apply setups
      for _, name in ipairs(servers) do
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }
        if server_opts[name] then
          opts = vim.tbl_deep_extend("force", opts, server_opts[name])
        end

        if lspconfig[name] then
          lspconfig[name].setup(opts)
        else
          vim.notify(("lspconfig: server '%s' not found"):format(name), vim.log.levels.WARN)
        end
      end
    end,
  },
}
