vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
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

-- Setup lazy.nvim with eager-loading for frequently used plugins ============================
require("lazy").setup("plugins", {
	checker = { enabled = true },
})
-- Setup lazy.nvim with eager-loading for frequently used plugins ============================

-- Basic key mappings (available immediately)
vim.keymap.set("n", "<D-z>", "u", { desc = "Undo (⌘+Z)", noremap = true, silent = true })
vim.keymap.set("n", "<D-S-z>", "<C-r>", { desc = "Redo (⇧⌘+Z)", noremap = true, silent = true })

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
vim.keymap.set("n", "<D-a>", "ggVG", { desc = "Select all (⌘+A)", noremap = true, silent = true })
vim.keymap.set("i", "<D-a>", "<Esc>ggVG", { desc = "Select all (⌘+A)", noremap = true, silent = true })
vim.keymap.set("v", "<D-a>", "<Esc>ggVG", { desc = "Select all (⌘+A)", noremap = true, silent = true })

-- Open Lazy shortcut
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy.nvim UI (leader l)" })
