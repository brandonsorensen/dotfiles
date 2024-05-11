return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		lazy = false,
		opts = {
			open_mapping = [[<leader>tt]],
			terminal_mappings = false,
			start_in_insert = true,
			insert_mappings = false,
			direction = "float",
			float_ops = {
				border = "curved"
			}
		},
		keys = {
			{"t", "<C-esc>", [[<C-\><C-n>]]},
			{"t", "<C-h>", [[<Cmd>wincmd h<CR>]]},
			{"t", "<C-j>", [[<Cmd>wincmd j<CR>]]},
			{"t", "<C-k>", [[<Cmd>wincmd k<CR>]]},
			{"t", "<C-w>", [[<C-\><C-n><C-w>]]},
			{
				"t", "<c-b>", "<c-\\><c-n>",
				desc = "Shortcut for scrolling in a terminal"
			}
		}
	}
}
