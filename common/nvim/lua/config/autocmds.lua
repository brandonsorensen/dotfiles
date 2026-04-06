-- Switches colorscheme when vim.o.background changes. Neovim 0.11+ detects
-- the terminal background via OSC 11 at startup and on terminal theme changes,
-- setting vim.o.background automatically. vim.schedule defers execution until
-- after lazy.nvim has loaded plugins, since OSC 11 can fire before they are
-- available.
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    vim.schedule(function()
      if vim.o.background == "dark" then
        vim.cmd("colorscheme nord")
        vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#54637d" })
      else
        vim.cmd("colorscheme rose-pine")
        vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#6b6b6b" })
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
