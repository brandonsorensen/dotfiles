-- style 
vim.cmd('syntax on')
vim.opt.rnu = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.softtabstop = 0
vim.opt.curslorline = true
vim.opt.clipboard='unnamed'
vim.opt.backspace = 'indent,eol,start'
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- key mappings
local opts = { noremap = true, silent = true }
vim.g.leader = ' '
vim.api.nvim_set_keymap('gr')
