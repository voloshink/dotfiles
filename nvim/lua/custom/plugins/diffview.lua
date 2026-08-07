return {
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		keys = {
			{
				"<leader>gm",
				"<cmd>DiffviewOpen main...HEAD<CR>",
				desc = "Review Branch vs Main",
			},
			{
				"<leader>gM",
				"<cmd>DiffviewOpen main<CR>",
				desc = "Review Worktree vs Main",
			},
			{
				"<leader>gq",
				"<cmd>DiffviewClose<CR>",
				desc = "Close Diffview",
			},
		},
		opts = {
			enhanced_diff_hl = true,
		},
		config = function(_, opts)
			local diff_groups = {
				DiffAdd = "Added",
				DiffChange = "Changed",
				DiffDelete = "Removed",
			}

			local function preserve_syntax_highlighting()
				for diff_group, source_group in pairs(diff_groups) do
					local source = vim.api.nvim_get_hl(0, { name = source_group, link = false })
					vim.api.nvim_set_hl(0, diff_group, { bg = source.bg })
				end
			end

			preserve_syntax_highlighting()
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("diffview_syntax_highlighting", { clear = true }),
				callback = preserve_syntax_highlighting,
			})

			require("diffview").setup(opts)
		end,
	},
}
