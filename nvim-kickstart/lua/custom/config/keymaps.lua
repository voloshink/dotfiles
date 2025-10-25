local map = vim.keymap.set

-- Escape is annoying to hit
map("i", "<C-c>", "<Esc>", { noremap = true, silent = true })

-- Save File
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Better window navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- windows
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- Buffers
map("n", "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

-- Keep centered while going up and down
map("n", "<C-d>", "<C-d>zz", { remap = true })
map("n", "<C-u>", "<C-u>zz", { remap = true })
map("n", "n", "nzzzv", { remap = true })
map("n", "N", "Nzzzv", { remap = true })

-- diagnostic
local diagnostic_goto = function(next, severity)
	return function()
		vim.diagnostic.jump({
			count = (next and 1 or -1) * vim.v.count1,
			severity = severity and vim.diagnostic.severity[severity] or nil,
			float = true,
		})
	end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- terminal
map({ "n", "t" }, "<c-/>", function()
	Snacks.terminal()
end, { desc = "Terminal (Root Dir)" })

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- codebridge
vim.keymap.set("n", "<leader>ct", ":CodeBridgeTmux<CR>", { desc = "Send file to claude" })
vim.keymap.set("v", "<leader>ct", ":CodeBridgeTmux<CR>", { desc = "Send selection to claude" })
vim.keymap.set("n", "<leader>cc", ":CodeBridgeChat<CR>", { desc = "Chat with claude" })
vim.keymap.set("n", "<leader>cx", ":CodeBridgeWipe<CR>", { desc = "Wipe chat and clear history" })
vim.keymap.set("n", "<leader>cq", ":CodeBridgeQuery<CR>", { desc = "Query claude with context" })
vim.keymap.set("v", "<leader>cq", ":CodeBridgeQuery<CR>", { desc = "Query claude with selection" })

-- toggle autoformat
map("n", "<leader>uf", function()
	vim.g.disable_autofmt = not vim.g.disable_autofmt
	local status = vim.g.disable_autofmt and "disabled" or "enabled"
	vim.notify("Autoformat " .. status, vim.log.levels.INFO)
end, { desc = "Toggle Autoformat" })

-- code
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Source Action (auto-apply first code action)
map("n", "<leader>cA", function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source" },
			diagnostics = {},
		},
	})
end, { desc = "Source Action" })
