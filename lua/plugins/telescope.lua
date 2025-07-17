return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
        require("telescope").setup({})
    end,
    keys = {
    -- Normal + Visual: select all
    { "<D-a>", "ggVG",                 mode = { "n", "v" }, desc = "Select all (⌘+A)" },
    -- Insert: exit, then select all
    { "<D-a>", "<Esc>ggVG",            mode = { "i"      }, desc = "Select all (⌘+A)" },
    -- Telescope-specific mappings
    { "<D-f>", "<cmd>Telescope find_files<cr>", mode = "n", desc = "Telescope: Find Files" },
    { "<D-g>", "<cmd>Telescope live_grep<cr>",  mode = "n", desc = "Telescope: Live Grep"  },
  },
}
