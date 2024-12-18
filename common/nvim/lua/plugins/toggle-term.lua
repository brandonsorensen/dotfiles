return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,
    opts = {
      open_mapping = [[<leader>tt]],
      terminal_mappings = false,
      start_in_insert = true,
      insert_mappings = false,
      direction = "float",
      float_ops = {
        border = "curved",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*toggleterm#*",
        callback = function()
          local opts = { buffer = 0 }
          vim.keymap.set("t", "<S-esc>", [[<C-\><C-n>]], opts)
          vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
          vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
          vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
          vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
        end,
      })
    end,
    keys = {
      {
        "t",
        "<c-b>",
        "<c-\\><c-n>",
        desc = "Shortcut for scrolling in a terminal",
      },
    },
  },
}
