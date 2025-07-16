return {
  -- Theme plugin (loads at startup)
  {
    "oxfist/night-owl.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("night-owl").setup()
      vim.cmd.colorscheme("night-owl")
    end,
  },

  -- Telescope (always loaded at startup)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      require("telescope").setup({})
    end,
  },

  -- Tree-sitter (always loaded at startup)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "javascript", "typescript", "cpp", "c", "sql", "python", "java", "css", "html" },
        highlight = { enable = true },
        indent    = { enable = true },
      }
    end,
  },

  -- Neo-tree (always loaded at startup, opens on the right)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    opts = {
      window = {
        position = "right",
        width = 30,
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
    end,
  },
}

