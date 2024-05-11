return {
	"neovim/nvim-lspconfig",
	event = {"BufReadPre", "BufNewfile"},
	dependencies = {
		{
			"folke/neoconf.nvim",
			cmd = "Neoconf",
			config = false,
			dependencies = { "nvim-lspconfig" }
		},
		{ "folke/neodev.nvim", opts = {} },
		-- "mason.nvim",
		-- "williamboman/mason-lspconfig.nvim",
	},
	config = function(_, opts)
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
			end,
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(args.buf, true)
					vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#6b6b6b" })
				end
			end
		})
		local servers = opts.servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		local function setup(server)
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = vim.deepcopy(capabilities),
			}, servers[server] or {})
			require("lspconfig")[server].setup(server_opts)
		end
		for server, _server_opts in pairs(servers) do
			setup(server)
		end
	end,
	opts = {
		inlay_hints = {
			enabled = true
		},
		codelens = {
			enabled = true,
		},
		servers = {
			rust_analyzer = {
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							allTargets = true,
						},
						checkOnSave= {
							command = "clippy",
						}
					}
				}
			},
			lua_ls = {
				settings = {
					Lua = {
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = {
								"vim",
								"require"
							},
						},
					}
				}
			},
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							-- formatter options
							black = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							-- linter options
							pylint = { enabled = false },
							ruff = { enabled = true },
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							-- type checker
							pylsp_mypy = {
								enabled = true,
								report_progress = true,
								live_mode = false
							},
							-- auto-completion options
							jedi_completion = { enabled = true, fuzzy = true },
							-- import sorting
							isort = { enabled = false },
						},
					},
				}
			},

		}
	},
}
