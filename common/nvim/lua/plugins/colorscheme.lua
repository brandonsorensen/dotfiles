return {
  {
    "shaunsingh/nord.nvim",
  },
  {
    "ramojus/mellifluous.nvim",
    lazy = true,
    opts = {
      transparent_background = {
        enabled = true,
      },
    },
  },
  -- Install without configuration
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
        },
      })
    end,
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = true,
    priority = 999, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup({
        -- Your config here
        transparent_background_level = 1,

        vim.cmd("colorscheme everforest"),
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    },
    config = function()
      require("rose-pine").setup({
        -- Your config here
        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },

        vim.cmd("colorscheme rose-pine"),
      })
    end,
  },
}
