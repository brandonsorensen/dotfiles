return {
  "lewis6991/gitsigns.nvim",
  event = { "VeryLazy" },
  lazy = true,
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      -- Actions
      map("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage hunk" })
      map("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset hunk" })
      map("v", "<leader>ghs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Stage selected hunk" })
      map("v", "<leader>ghr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Reset selected hunk" })
      map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage buffer" })
      map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
      map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset buffer" })
      map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview hunk" })
      map("n", "<leader>ghb", function()
        gs.blame_line({ full = true })
      end, { desc = "Blame line" })
      map("n", "<leader>ght", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
      map("n", "<leader>ghd", gs.diffthis, { desc = "Diff this" })
      map("n", "<leader>ghD", function()
        gs.diffthis("~")
      end, { desc = "Diff this ~" })
      map("n", "<leader>ghx", gs.toggle_deleted, { desc = "Toggle deleted" })
    end,
  },
}
