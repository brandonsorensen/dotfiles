vim.cmd('set runtimepath^=~/.vim runtimepath+=~/.vim/after')
<<<<<<<< HEAD:common/nvim/init.lua
vim.g.python3_host_prog = vim.fn.expand('~/venvs/pynvim/bin')
vim.cmd('source ~/.vimrc')
vim.opt.guicursor = 'n-v-c-i:block'

vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>")

require("leaf").setup({
    theme = "auto", -- default, based on vim.o.background, alternatives: "light", "dark"
    contrast = "low",
	transparent = true
})

require("nvim-autopairs").setup{}

local auto_dark_mode = require('auto-dark-mode')
auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		vim.api.nvim_set_option('background', 'dark')
		vim.cmd('colorscheme nord')
	end,
	set_light_mode = function()
		vim.api.nvim_set_option('background', 'light')
		vim.cmd('colorscheme leaf')
	end,
})

require('nvim-web-devicons').setup()
require('lualine').setup({})
========
vim.g.python3_host_prog = vim.fn.expand('~/virtual-envs/pynvim/bin')
vim.cmd('source ~/.vimrc')
vim.opt.guicursor = 'n-v-c-i:block'

vim.keymap.set('n', '<leader>lg', 'gg :LazyGit<CR>')

require('nvim-web-devicons')
require('lualine').setup({
	options = {
		theme = 'leaf'
	}
})

require('leaf').setup({
	transparent = true,
	contrast = 'medium'
})

require("nvim-autopairs").setup {}
require("flash").setup {}

-- Lua
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xz", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
vim.keymap.set("n", "<leader>f", ':FzfLua files<CR>')
vim.keymap.set("n", "<leader>r", ':FzfLua buffers<CR>')
vim.keymap.set("n", "<leader>a", ':FzfLua lsp_code_actions<CR>')
require('trouble').setup({
	icons = false
})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<S-esc>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

require('toggleterm').setup({
	open_mapping = [[<leader>tt]],
	terminal_mappings = false,
	start_in_insert = true,
	insert_mappings = false,
	direction = 'float',
	float_ops = {
		border = 'curved'
	}
})

>>>>>>>> 698082b (Lua for entry):common/nvim/.config/nvim/init.lua

-- Set up nvim-cmp.
local cmp = require'cmp'
local luasnip = require'luasnip'

require('flash').setup{}
require('trouble').setup{}
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xz", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<S-esc>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

require('toggleterm').setup({
	open_mapping = [[<leader>tt]],
	terminal_mappings = false,
	start_in_insert = true,
	insert_mappings = false,
	direction = 'float',
	float_ops = {
		border = 'curved'
	}
})

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
	end,
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(args.buf, true)
				vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#6b6b6b" })
		end
	end
})

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<TAB>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
      -- that way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }, -- For luasnip users.
		{ name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
	},
	{
		{ name = 'buffer' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['rust_analyzer'].setup {
	capabilities = capabilities
}
<<<<<<<< HEAD:common/nvim/init.lua
require('lspconfig').rust_analyzer.setup {
	settings = {
		['rust-analyzer'] = {
			checkOnSave = {
				allFeatures = true,
				overrideCommand = {
					'cargo', 'clippy', '--workspace', '--message-format=json',
					'--all-targets', '--all-features'
				}
			}
		}
	}
}
========
require('lspconfig').rust_analyzer.setup({})
>>>>>>>> 698082b (Lua for entry):common/nvim/.config/nvim/init.lua
require'lspconfig'.pylsp.setup {
	settings = {
      pylsp = {
        plugins = {
          -- formatter options
          black = { enabled = false },
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          -- linter options
          pylint = { enabled = false },
<<<<<<<< HEAD:common/nvim/init.lua
          ruff = {
			  enabled = true
		  },
========
          ruff = { enabled = true },
>>>>>>>> 698082b (Lua for entry):common/nvim/.config/nvim/init.lua
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          -- type checker
          pylsp_mypy = {
            enabled = true,
            report_progress = true,
            live_mode = false
          },
          -- auto-completion options
          jedi_completion = { enabled = true, fuzzy = true },
          -- import sorting
          isort = { enabled = false },
        },
      },
    }
}
require('lspconfig').lua_ls.setup{
	settings = {
		Lua = {
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					'vim',
					'require'
				},
			},
		}
	}
}

require('lspconfig').jsonls.setup {
	settings = {
		json = {
			schemas = require('schemastore').json.schemas {
				extra = {
				  {
					description = 'SageMaker Pipeline schema',
					fileMatch = 'sagemaker-pipline.json',
					name = 'sagemaker-pipeline.json',
					url = 'https://raw.githubusercontent.com/aws-sagemaker-mlops/sagemaker-model-building-pipeline-definition-JSON-schema/main/schema/pipeline-definition.schema.json',
				  }
			  }
			}
		}
	}
}

require'lspconfig'.terraformls.setup{}
require'lspconfig'.tflint.setup{}
require('lspconfig').mojo.setup{}
require('lspconfig').hls.setup{}

vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
		"rust", "python", "vim", "vimdoc", "lua", "json",
		"markdown", "markdown_inline", "hcl", "terraform"
	},
  indent = { enabled = true },
  -- theme = 'nord',
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
  highlight = {
    enable = true,
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
