return {
  "olimorris/codecompanion.nvim",
	opts = {
	  strategies = {
		chat = {
		  adapter = {
			name = "copilot",
			model = "claude-3.7-sonnet",
		  },
		},
		inline = {
		  adapter = "copilot",
		},
	  }
	},
	
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
