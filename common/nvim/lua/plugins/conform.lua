return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { "rustfmt" },
      terraform = { "terraform_fmt" },
    },
  },
}
