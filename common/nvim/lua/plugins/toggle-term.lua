return {
  {
		"akinsho/toggleterm.nvim",
		version = "*",
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
			{
				"<c-b>", "<c-\\><c-n>",
				desc = "Shortcut for scrolling in a terminal"
			}
		}
	}
}
