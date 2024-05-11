return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = {
				enabled = true
			}
		},
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
	}
}
