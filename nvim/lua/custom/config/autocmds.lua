local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = augroup("highlight_yank"),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- conceallevel is a window-local option, so when markview.nvim sets it to 3
-- for markdown rendering, it persists when switching to a different buffer in
-- the same window. nvim-treesitter ships JSON highlight queries that conceal
-- quote characters when conceallevel > 0, causing string quotes to disappear
-- in normal mode. Explicitly resetting it for JSON files prevents this.
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("json_no_conceal"),
	pattern = { "json", "jsonc" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
