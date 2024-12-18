return {
	"nvim-tree/nvim-tree.lua",
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({
			actions = {
				open_file = {
					resize_window = false,
				},
			},
		})
	end,
	keys = {
		{ "<leader>e", function() vim.cmd([[NvimTreeToggle]]) end, mode = { "n" }, desc = "Toggle nvim-tree" },
		{ "<leader>E", function() vim.cmd([[NvimTreeFindFile]]) end, desc = "Show current file in nvim-tree" },
	},
}
