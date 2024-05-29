-- style 
vim.cmd("syntax on")
vim.o.background = "light"
vim.opt.rnu = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.softtabstop = 0
vim.opt.cursorline = true
vim.opt.clipboard ="unnamed"
vim.opt.backspace = "indent,eol,start"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.guicursor = "n-v-c-i:block"

-- disabled netrw in favor of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.python3_host_prog = vim.fn.expand("~/venvs/pynvim/bin/python3")
