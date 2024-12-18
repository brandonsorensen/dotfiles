return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewfile" },
  dependencies = {
    {
      "folke/neoconf.nvim",
      cmd = "Neoconf",
      config = false,
      dependencies = { "nvim-lspconfig" },
    },
    { "folke/neodev.nvim", opts = {} },
    -- "mason.nvim",
    -- "williamboman/mason-lspconfig.nvim",
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(args)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true)
        end
        client.server_capabilities.semanticTokensProvider = nil
      end,
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
      enabled = true,
    },
    codelens = {
      enabled = true,
    },
    servers = {
      bashls = {
        opts = {
          filetypes = {
            "sh",
            "zsh",
          },
        },
      },
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              allTargets = true,
            },
            checkOnSave = {
              command = "clippy",
            },
          },
        },
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
                "require",
              },
            },
          },
        },
      },
      terraformls = {},
      tflint = {},
      ruff = {},
      basedpyright = {
        settings = {
          basedpyright = {
            disableOrganizeImports = true, -- Using Ruff
            analysis = {
              -- ignore = { "*" }, -- Using Ruff
              -- typeCheckingMode = "off", -- Using mypy
              diagnosticSeverityOverrides = {
                -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md#type-check-diagnostics-settings
                reportUndefinedVariable = "none",
                reportUnusedVariable = "none",
                reportUnusedImport = "none",
              },
            },
          },
        },
      },
    },
  },
}
