-- Configures LuaLS to support auto-completion and type checking
-- while editing your Neovim configuration.
return {
	"folke/lazydev.nvim",
	ft = "lua",
	cmd = "LazyDev",
	opts = {
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			{ path = "snacks.nvim", words = { "Snacks" } },
			{ path = "lazy.nvim", words = { "LazyVim" } },
		},
	},
}
