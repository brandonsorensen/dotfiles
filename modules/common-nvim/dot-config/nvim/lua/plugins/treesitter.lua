return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- markdown_inline has no filetype of its own; it's pulled in via injection
    -- once the markdown parser is installed, so it's only needed in `install`.
    require("nvim-treesitter").install({
      "rust",
      "python",
      "vim",
      "vimdoc",
      "lua",
      "json",
      "markdown",
      "markdown_inline",
      "hcl",
      "terraform",
    })

    vim.api.nvim_create_autocmd("FileType", {
      -- vimdoc's parser attaches to the `help` filetype
      pattern = { "rust", "python", "vim", "help", "lua", "json", "markdown", "hcl", "terraform" },
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
