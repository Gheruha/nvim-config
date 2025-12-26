-- Basic key mappings
vim.keymap.set("n", "<S-z>", "u", { desc = "Undo (⌘+Z)", noremap = true, silent = true })
vim.keymap.set("n", "<S-x>", "<C-r>", { desc = "Redo (⇧⌘+Z)", noremap = true, silent = true })

-- Normal mode: start visual and move
vim.keymap.set("n", "<S-Up>", "v<Up>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Down>", "v<Down>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Left>", "v<Left>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Right>", "v<Right>", { noremap = true, silent = true })

-- Visual mode: extend the existing selection
vim.keymap.set("v", "<S-Up>", "<Up>", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Down>", "<Down>", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Left>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Right>", "<Right>", { noremap = true, silent = true })

-- Insert mode: leave insert, start visual, then move
vim.keymap.set("i", "<S-Up>", "<Esc>v<Up>", { noremap = true, silent = true })
vim.keymap.set("i", "<S-Down>", "<Esc>v<Down>", { noremap = true, silent = true })
vim.keymap.set("i", "<S-Left>", "<Esc>v<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<S-Right>", "<Esc>v<Right>", { noremap = true, silent = true })

-- Select All with ⌘+A
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all (⌘+A)", noremap = true, silent = true })
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { desc = "Select all (⌘+A)", noremap = true, silent = true })
vim.keymap.set("v", "<C-a>", "<Esc>ggVG", { desc = "Select all (⌘+A)", noremap = true, silent = true })

-- Open Lazy shortcut
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy.nvim UI (leader l)" })
