return {
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		opts = {},
	},

	-- LSP Keymaps
	{
		"neovim/nvim-lspconfig",
		keys = {
			{
				"<leader>cr",
				function()
					local inc_rename = require("inc_rename")
					return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
				end,
				expr = true,
				desc = "Rename (inc-rename.nvim)",
			},
		},
	},

	--- Noice integration
	{
		"folke/noice.nvim",
		optional = true,
		opts = {
			presets = { inc_rename = true },
		},
	},
}
