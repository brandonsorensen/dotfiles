return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewfile" },
  config = function(_, opts)
    vim.lsp.config("*", {
      inlay_hints = {
        enabled = true,
      },
      codelens = {
        enabled = true,
      },
    })
    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            allTargets = true,
          },
          check = {
            command = "clippy",
          },
          checkOnSave = true,
        },
      },
    })

    vim.lsp.config("bashls", {
      opts = {
        filetypes = {
          "sh",
          "zsh",
        },
      },
    })
    vim.lsp.config("lua_ls", {
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
    })
    vim.lsp.config("basedpyright", {
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
    })
    vim.lsp.enable({
      "rust_analyzer",
      "lua_ls",
      "bashls",
      "just",
      "basedpyright",
      "ruff",
      "terraformls",
    })
  end,
}
