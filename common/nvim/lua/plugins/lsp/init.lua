return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
			{ "folke/neodev.nvim", opts = {} },
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			inlay_hints = {
				enabled = true
			}
		},
		config = function(_, _)
		end,
		servers = {
			rust_analyzer = {
				opts = {
					["rust-analyzer"] = {
						cargo = {
							features = "all",
							allTargets = true,
						},
						check = {
							command = "clippy"
						}
					}
				}
			},
		}
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				-- "flake8",
			},
		},
	}
}
