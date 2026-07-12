local ELLIPSIS_CHAR = "…"
local MAX_LABEL_WIDTH = 60
local MAX_KIND_WIDTH = 14

local get_ws = function(max, len)
  return (" "):rep(max - len)
end

local format = function(_, item)
  local content = item.abbr
  -- local kind_symbol = symbols[item.kind]
  -- item.kind = kind_symbol .. get_ws(MAX_KIND_WIDTH, #kind_symbol)

  if #content > MAX_LABEL_WIDTH then
    item.abbr = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
  else
    item.abbr = content
  end
  return item
end

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = function(_, _)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      cmp.setup({
        formatting = {
          format = function(_entry, item)
            if item.menu ~= nil and string.len(item.menu) > 0 then
              item.menu = string.sub(item.menu, 1, 0) .. ""
            end
            return item
          end,
        },
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<TAB>"] = cmp.mapping(function(fallback)
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
          { name = "nvim_lsp", priority = 1000 },
          { name = "path", priority = 90 }, -- file system paths
          { name = "luasnip", priority = 70 }, -- For luasnip users.
          { name = "buffer", priority = 30 }, -- text within current buffer
        }),
      })
      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won"t work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
