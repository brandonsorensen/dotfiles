return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
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
      desc = "list all open buffers",
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
