return {
	{
		"shaunsingh/nord.nvim",
		priority = (vim.g.dotfiles_machine or {}).nord_priority,
	},
	{
		"ramojus/mellifluous.nvim",
		lazy = true,
		opts = {
			transparent_background = {
				enabled = true,
			},
		},
	},
	-- Install without configuration
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = true, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				options = {
					transparent = true,
				},
			})
		end,
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = true,
		priority = 999, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				transparent_background_level = 1,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
			})
		end,
	},
}
