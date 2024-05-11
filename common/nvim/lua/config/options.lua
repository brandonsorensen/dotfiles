-- style 
vim.cmd("syntax on")
vim.opt.rnu = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.softtabstop = 0
vim.opt.curslorline = true
vim.opt.clipboard ="unnamed"
vim.opt.backspace = "indent,eol,start"
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.python3_host_prog = vim.fn.expand("~/venvs/pynvim/bin")
vim.opt.guicursor = "n-v-c-i:block"
