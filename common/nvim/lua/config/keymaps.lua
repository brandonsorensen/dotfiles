vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

local map = vim.keymap.set

map("n", "<leader>w", "<C-w>", {
	silent = true,
	desc = "window management modal"
})
map("n", "<leader>e", ":Lexplore<CR>", {
	silent = true,
	desc = "window management modal"
})
map("n", "<leader>h", ":noh<CR>", {
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

map("n", "<leader>s", "<C-^>", {
	silent = true,
	desc = "Quickly switch to previous buffer"
})
map("n", "<leader>c", ":bp\\|bd #<CR>", {
	silent = true,
	desc = "Quickly switch to previous buffer"
})

map("n", "<leader>i",
function()
	vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
end
)

-- lsp mappings
-- move them to LSP module?
map("n", "gd",
	function()
		vim.lsp.buf.definition()
	end,
	{silent = true}
)
map("n", "gb",
	function()
		vim.lsp.buf.implementation()
	end,
	{silent = true}
)

map("n", "gu",
	function()
		vim.lsp.buf.references()
	end,
	{silent = true}
)

map("n", "<leader>R",
	function()
		vim.lsp.buf.rename()
	end,
	{silent = true}
)

