return {
	desc = "Snacks File Explorer",
	"folke/snacks.nvim",
	opts = { explorer = {
		git_status_open = true,
		diagnostics_open = true,
	} },
	keys = {
		-- {
		-- 	"<leader>fe",
		-- 	function()
		-- 		Snacks.explorer({ cwd = LazyVim.root() })
		-- 	end,
		-- 	desc = "Explorer Snacks (root dir)",
		-- },
		{
			"<leader>fE",
			function()
				Snacks.explorer()
			end,
			desc = "Explorer Snacks (cwd)",
		},
		{ "<leader>e", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
		{ "<leader>E", "<leader>fE", desc = "Explorer Snacks (cwd)", remap = true },
	},
}
