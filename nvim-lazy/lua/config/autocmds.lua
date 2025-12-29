-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup("typescript quickfix", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typescript,typescriptreact",
  group = augroup,
  command = "compiler tsc | setlocal makeprg=npx\\ tsc",
})

-- Treat Fastlane Fastfiles as Ruby files
local fastlane_augroup = vim.api.nvim_create_augroup("fastlane", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Fastfile", "Appfile", "Deliverfile", "Matchfile", "Snapfile", "Scanfile", "Gymfile" },
  group = fastlane_augroup,
  command = "set filetype=ruby",
})
