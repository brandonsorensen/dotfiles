vim.g.python3_host_prog = vim.fn.expand("~/venvs/pynvim/bin/python3")

local machine = {}
local machine_config = vim.fn.expand("~/.config/dotfiles/nvim.lua")
if (vim.uv or vim.loop).fs_stat(machine_config) then
  local ok, config = pcall(dofile, machine_config)
  if ok and type(config) == "table" then
    machine = config
  end
end
vim.g.dotfiles_machine = machine

require("config")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

if machine.enable_lsps ~= false then
  vim.lsp.enable({
    "rust_analyzer",
    "lua_ls",
    "bashls",
    "just",
    "basedpyright",
    "ruff",
    "terraformls",
  })
end
require("lazy").setup("plugins")

vim.cmd(vim.o.background == "dark" and "colorscheme nord" or "colorscheme rose-pine")
