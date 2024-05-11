vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

local map = vim.keymap.set

map("n", "<leader>w", "<C-w>", {
	silent = true,
	desc = "window management modal"
})
map("n", "<leader>h", ":noh", {
	silent = true,
	desc = "Clear highlight"
})
map("n", "<leader>lg", ":LazyGit<CR>", {
	silent = true,
	desc = "Activate LazyGit window"
})
map("t", "<c-b>", "<c-\\><c-n>", {
	silent = true,
	desc = "Shortcut for scrolling in terminal"
})

map("n", "<leader>i",
	function()
		vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
	end
)

-- nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
-- " For global replace
-- nnoremap gR gD:%s/<C-R>///gc<left><left><left>

-- " fzf buffer list
-- nnoremap <silent><leader>r :Buffers<CR>
-- " fzf dir list
-- nnoremap <silent><leader>f :Files<CR>
-- " Explore
-- nnoremap <silent><leader>e :Lexplore<CR>
-- " Remap ctl-w to leader for window management
-- nnoremap <Leader>w <C-w>
-- " Close buffer without losing split
-- nnoremap <silent><leader>c :bp\|bd #<CR>
-- " Quickly switch to previous buffer
-- nnoremap <silent><leader>s <C-^>
-- " Clear highlight
-- nnoremap <silent><leader>h :noh<CR>
-- " Shortcut for scrolling in a terminal
-- tnoremap <c-b> <c-\><c-n>
