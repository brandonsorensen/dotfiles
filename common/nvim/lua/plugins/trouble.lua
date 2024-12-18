return {
  "folke/trouble.nvim",
  opts = {
    icons = false,
  },
  keys = {
    {
      "<leader>xx",
      function()
        require("trouble").toggle()
      end,
      desc = "Toggle problem buffer",
    },
    {
      "<leader>xz",
      function()
        require("trouble").toggle("quickfix")
      end,
      desc = "Toggle problem quick fix buffer",
    },
    {
      "gR",
      function()
        require("trouble").toggle("lsp_references")
      end,
    },
  },
}
