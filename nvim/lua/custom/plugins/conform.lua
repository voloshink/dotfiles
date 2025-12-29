local prettier_file_types = {
	"css",
	"graphql",
	"handlebars",
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"jsonc",
	"less",
	"markdown",
	"markdown.mdx",
	"scss",
	"typescript",
	"typescriptreact",
	"vue",
	"yaml",
}

return {
	-- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },

	opts = function(_, opts)
		opts.formatters_by_ft = opts.formatters_by_ft or {}
		opts.formatters_by_ft["lua"] = { "stylua" }

		for _, ft in ipairs(prettier_file_types) do
			opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
			table.insert(opts.formatters_by_ft[ft], "prettier")
		end

		opts.notify_on_error = false

		opts.format_on_save = function(bufnr)
			-- Check if autoformat is disabled globally
			if vim.g.disable_autofmt then
				return nil
			end

			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			if disable_filetypes[vim.bo[bufnr].filetype] then
				return nil
			else
				return {
					timeout_ms = 500,
					lsp_format = "fallback",
				}
			end
		end
	end,
}
