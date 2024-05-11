return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({})
  end,
	keys = {
		{
			"<leader>f", ":FzfLua files<CR>",
			desc = "list all project files"
		},
		{
			"<leader>r", ":FzfLua buffers<CR>",
			desc = "list all open buffers"
		},
		{
			"<leader>a", ":FzfLua lsp_code_actions<CR>",
			desc = "Current code actions"
		}
	}
}
