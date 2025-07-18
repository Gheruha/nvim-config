return {
	"oxfist/night-owl.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("night-owl").setup()
		vim.cmd.colorscheme("night-owl")
		vim.keymap.set("n", "<leader>l", vim.lsp.buf.hover, {})
	end,
}
