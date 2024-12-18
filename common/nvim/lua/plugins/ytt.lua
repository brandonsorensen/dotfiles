return {
  {
    "cappyzawa/starlark.vim",
    lazy = true,
  },
  {
    "carvel-dev/ytt.vim",
    lazy = true,
    dependencies = {
      "starlark.vim",
    },
    keys = {
      {
        "<leader>ey",
        ":EnableYtt<CR>",
      },
      {
        "<leader>dy",
        ":DisableYtt<CR>",
      },
    },
  },
}
