return
-- Session management. This saves your session in the background,
-- keeping track of open buffers, window arrangement, and more.
-- You can restore sessions when returning through the dashboard.
{
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	init = function()
		local function close_snacks_wins()
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				local buf = vim.api.nvim_win_get_buf(win)
				local ft = vim.bo[buf].filetype
				if ft:match("^snacks_") then
					pcall(vim.api.nvim_win_close, win, true)
				end
			end
		end
		-- Close snacks windows before the session is written so they are never
		-- serialised into the session file.
		vim.api.nvim_create_autocmd("User", {
			pattern = "PersistenceSavePre",
			callback = close_snacks_wins,
		})
		-- Also clean up any snacks windows that leaked in from a session that
		-- was saved before this fix was in place.
		vim.api.nvim_create_autocmd("User", {
			pattern = "PersistenceLoadPost",
			callback = close_snacks_wins,
		})
	end,
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
}
