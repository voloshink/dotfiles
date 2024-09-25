-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map("n", "<C-d>", "<C-d>zz", { remap = true })
map("n", "<C-u>", "<C-u>zz", { remap = true })
map("n", "n", "nzzzv", { remap = true })
map("n", "N", "Nzzzv", { remap = true })

-- creates a note from the template
map("n", "<leader>on", ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>")
-- removes timestamps from line and converts underscores to spaces, just a utility for obsidian note titles
map("n", "<leader>of", ':s/\\(# \\)[^_]*_/\\1/e | s/-/ /ge | let @/ = ""<cr>')
-- review workflow
map("n", "<leader>ok", function()
  local file = vim.fn.expand("%:p")
  if file == "" then
    print("No file to move.")
    return
  end

  local target_dir = "~/obsidian/personal-vault/zk/"
  -- Expand tilde to the home directory
  target_dir = vim.fn.expand(target_dir)

  -- Extract the file name to append to the target directory
  local filename = vim.fn.fnamemodify(file, ":t")
  local target_path = target_dir .. filename

  -- Try to move the file
  local ok, err = pcall(vim.loop.fs_rename, file, target_path)
  if ok then
    vim.cmd("bd!")
    print("File moved to " .. target_path)
  else
    print("Error moving file: " .. err)
  end
end, { desc = "Accept note" })
map("n", "<leader>odd", function()
  local file = vim.fn.expand("%:p")
  if file == "" then
    print("No file to delete.")
    return
  end

  local ok, err = pcall(vim.fn.delete, file)
  if ok then
    vim.cmd("bd!")
    print("File deleted successfully.")
  else
    print("Error deleting file: " .. err)
  end
end, { desc = "Delete note" })
