local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "tex", "typ", "text" },
	callback = function(_)
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
	end
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("indent_two"),
	pattern = { "rust", "lua", "terraform" },
	callback = function(_)
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typst" },
	callback = function(_)
		vim.g.typst_conceal = 1
		vim.g.typst_conceal_math = 1
		vim.g.typst_conceal_emoji = 1
		vim.g.typst_embedded_languages = {}
	end
})
