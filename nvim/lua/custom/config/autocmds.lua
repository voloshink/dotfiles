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

-- nvim-lspconfig no longer ships the :LspRestart/:LspStart/:LspStop commands,
-- and servers are launched through vim.lsp.enable(). This recreates a restart
-- command: stop the relevant clients and re-enable their configs so they
-- re-attach to the open buffers. With no args it restarts every active client,
-- otherwise it restarts the named ones (e.g. :LspRestart eslint vtsls).
vim.api.nvim_create_user_command("LspRestart", function(opts)
	local names = {}
	if opts.args ~= "" then
		for name in opts.args:gmatch("%S+") do
			names[#names + 1] = name
		end
	else
		for _, client in ipairs(vim.lsp.get_clients()) do
			names[#names + 1] = client.name
		end
	end

	local seen, unique = {}, {}
	for _, name in ipairs(names) do
		if not seen[name] then
			seen[name] = true
			unique[#unique + 1] = name
		end
	end

	if #unique == 0 then
		vim.notify("No active LSP clients to restart", vim.log.levels.WARN)
		return
	end

	for _, name in ipairs(unique) do
		for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
			client:stop(true)
		end
	end

	vim.defer_fn(function()
		for _, name in ipairs(unique) do
			vim.lsp.enable(name)
		end
		vim.notify("Restarted LSP: " .. table.concat(unique, ", "), vim.log.levels.INFO)
	end, 200)
end, {
	nargs = "*",
	desc = "Restart LSP clients",
	complete = function()
		local names = {}
		for _, client in ipairs(vim.lsp.get_clients()) do
			names[#names + 1] = client.name
		end
		return names
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
