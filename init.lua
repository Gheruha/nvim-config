-- Keys
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
                        
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
																								

-- Setup lazy.nvim with eager-loading for frequently used plugins
require("lazy").setup({
  spec = {
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
    },
  },

  install = { colorscheme = { "night-owl" } },
  checker = { enabled = true },
})

-- Telescope key mappings (available immediately)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<D-f>", builtin.find_files, { desc = "Telescope Find Files" })
vim.keymap.set("n", "<D-g>", builtin.live_grep,  { desc = "Telescope Live Grep"  })

-- Tree-sitter
local config = require("nvim-treesitter.configs")
config.setup({
	ensure_installed = {"lua", "javascript", "typescript", "cpp", "c", "sql", "python", "java", "css", "html"},
	highlight = { enable = true },
        indent = { enable = true },
})
