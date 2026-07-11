local function toggle_cwd(_, opts)
	require("fzf-lua.actions").toggle_opt(opts, "cwd_only")
end

return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		buffers = {
			cwd_only = true,
			sort_lastused = true,
			actions = {
				["ctrl-g"] = toggle_cwd,
			},
		},
		oldfiles = {
			cwd_only = true,
			include_current_session = true,
			actions = {
				["ctrl-g"] = toggle_cwd,
			},
		},
	},
	keys = {
		{
			"<leader>f",
			":FzfLua files<CR>",
			desc = "list all project files",
		},
		{
			"<leader>ff",
			":FzfLua files<CR>",
			desc = "list all project files",
		},
		{
			"<leader>fr",
			":FzfLua buffers<CR>",
			desc = "list project buffers by recent use",
		},
		{
			"<leader>fo",
			":FzfLua oldfiles<CR>",
			desc = "list recent project files",
		},
		{
			"<leader>fg",
			":FzfLua live_grep<CR>",
			desc = "live grep current project",
		},
		{
			"<leader>ft",
			":FzfLua treesitter<CR>",
			desc = "list treesitter symbols",
		},
		{
			"<leader>a",
			":FzfLua lsp_code_actions<CR>",
			desc = "Current code actions",
		},
	},
}
