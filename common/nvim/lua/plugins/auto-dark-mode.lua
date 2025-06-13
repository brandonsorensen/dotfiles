return {
  "f-person/auto-dark-mode.nvim",
  config = {
    update_interval = 1000,
    set_dark_mode = function()
      vim.api.nvim_set_option_value("background", "dark", {})
      vim.cmd("colorscheme nord")
      vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#54637d" })
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value("background", "light", {})
      vim.cmd("colorscheme rose-pine")
      vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#6b6b6b" })
    end,
  },
}
