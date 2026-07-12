return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    local root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }) or vim.fn.getcwd()
    local project_name = root_dir:gsub("[^%w_.-]", "_")
    local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name

    require("jdtls").start_or_attach({
      cmd = { "jdtls", "-data", workspace_dir },
      root_dir = root_dir,
    })
  end,
}
