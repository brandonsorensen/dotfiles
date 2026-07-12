return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup()
  end,
  keys = {
    {
      "<leader>P",
      mode = { "n" },
      function()
        require("harpoon"):list():add()
      end,
      desc = "pin buffer in Harpoon list",
    },
    {
      "<leader>ll",
      mode = { "n" },
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Toggle Harpoon quick menu",
    },
    {
      "<leader>pp",
      mode = { "n" },
      function()
        require("harpoon"):list():prev()
      end,
      desc = "previous Harpoon buffer",
    },
    {
      "<leader>pn",
      mode = { "n" },
      function()
        require("harpoon"):list():next()
      end,
      desc = "next Harpoon buffer",
    },
    {
      "<leader>1",
      mode = { "n" },
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon file 1",
    },
    {
      "<leader>2",
      mode = { "n" },
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon file 2",
    },
    {
      "<leader>3",
      mode = { "n" },
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon file 3",
    },
    {
      "<leader>4",
      mode = { "n" },
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon file 4",
    },
    {
      "<leader>5",
      mode = { "n" },
      function()
        require("harpoon"):list():select(5)
      end,
      desc = "Harpoon file 5",
    },
  },
}
