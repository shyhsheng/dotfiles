-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-j>", "<C-e>", { desc = "Scroll down 1 cols" })
vim.keymap.set("n", "<C-k>", "<C-y>", { desc = "Scroll up 1 cols" })
vim.keymap.set("n", "<C-A-j>", "<C-d>", { desc = "Scroll down a page" })
vim.keymap.set("n", "<C-A-k>", "<C-u>", { desc = "Scroll up a page" })

vim.keymap.set("n", "<C-l>", "3zl", { desc = "Scroll right 3 cols" })
vim.keymap.set("n", "<C-h>", "3zh", { desc = "Scroll left 3 cols" })
vim.keymap.set("n", "<C-A-l>", "zL", { desc = "Scroll left a page" })
vim.keymap.set("n", "<C-A-h>", "zH", { desc = "Scroll right a page" })

-- Insert: move cursor (推薦)
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

vim.keymap.set("v", "<C-c>", "y", { desc = "Yank selection" })
