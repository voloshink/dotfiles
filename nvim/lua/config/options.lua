-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local auto_command_on = vim.api.nvim_create_autocmd

auto_command_on({ "BufRead", "BufNewFile" }, {
  pattern = { "*.podspec", "Podfile" },
  command = "set filetype=ruby",
})

-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldmethod = "expr"
