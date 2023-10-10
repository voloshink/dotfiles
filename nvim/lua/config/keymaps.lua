-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map("n", "<C-d>", "<C-d>zz", { remap = true })
map("n", "<C-d>", "<C-d>zz", { remap = true })
map("n", "n", "nzzzv", { remap = true })
map("n", "N", "Nzzzv", { remap = true })
