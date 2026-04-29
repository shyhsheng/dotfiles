-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
-- vim.opt.tabstop = 8
-- vim.opt.shiftwidth = 8
-- vim.opt.softtabstop = 8
-- vim.opt.expandtab = false
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.ignorecase = true

vim.api.nvim_set_hl(0, "@lsp.mod.inactive", { link = "Normal" })
