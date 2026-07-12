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
      else
        vim.cmd("colorscheme rose-pine")
      end
    end)
  end,
})

-- Applies colorscheme-specific highlight overrides. Using ColorScheme rather
-- than OptionSet background ensures overrides are set on every colorscheme
-- load, including the initial synchronous load at startup.
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function(ev)
    if ev.match == "nord" then
      vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#54637d" })
    elseif ev.match:match("^rose%-pine") then
      vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#6b6b6b" })
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
