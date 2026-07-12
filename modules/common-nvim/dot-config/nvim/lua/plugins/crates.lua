return {
  "saecki/crates.nvim",
  event = { "BufRead Cargo.toml" },
  tag = "stable",
  config = function()
    require("crates").setup()
  end,
}
