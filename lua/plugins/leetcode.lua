return {
	{
		"kawre/leetcode.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{ "nvim-treesitter/nvim-treesitter", lazy = false },
		},
		build = function()
			vim.cmd("TSUpdate html")
		end,
		opts = {
			-- your opts…
		},
	},
}
