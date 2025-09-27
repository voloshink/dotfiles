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
