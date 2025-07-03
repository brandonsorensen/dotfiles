return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = true,
    cmd = "ToggleTerm", -- lazy-load on command
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    },
    opts = {
      -- Don't set open_mapping as we're using keys for lazy loading
      start_in_insert = true,
      insert_mappings = false,
      direction = "float",
      float_ops = {
        border = "curved",
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      
      -- Terminal navigation mappings
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*toggleterm#*",
        callback = function()
          local term_opts = { buffer = 0 }
          vim.keymap.set("t", "<S-esc>", [[<C-\><C-n>]], term_opts)
          vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], term_opts)
          vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], term_opts)
          vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], term_opts)
          vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], term_opts)
          vim.keymap.set("t", "<c-b>", "<c-\\><c-n>", term_opts, { desc = "Exit terminal mode" })
        end,
      })
    end,
  },
}
