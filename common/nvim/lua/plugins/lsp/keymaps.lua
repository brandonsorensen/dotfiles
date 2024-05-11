local M = {}

M._keys = nil

function M.get()
	if M._keys then
		return M._keys
	end
	M._keys = {
		{
			"<leader>i",
			function()
				vim.lsp.inlay_hint.enable(
					0, not vim.lsp.inlay_hint.is_enabled()
				)
			end
		}
	}
end

return M
