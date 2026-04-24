-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local util = require("lazyvim.util")
local map = util.safe_keymap_set

vim.keymap.set({ "n", "v" }, "<C-v>", '"+P') -- Paste normal/visual mode
vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
vim.keymap.set("i", "<C-v>", '<ESC>l"+Pli') -- Paste insert mode

vim.keymap.del("i", "<C-s>")
vim.keymap.del("x", "<C-s>")
vim.keymap.del("n", "<C-s>")
-- map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- undo redo 重新映射
map({ "i", "n", "s" }, "<C-z>", function()
  vim.cmd([[undo]])
end, { desc = "Undo" })
map({ "i", "n", "s" }, "<C-S-z>", function()
  vim.cmd([[redo]])
end, { desc = "Rndo" })

map({ "i", "x", "n", "s" }, "<C-d>", "<esc>yyp", { desc = "Copy line to blow" })
map({ "i", "x", "n", "s" }, "<C-x>", "<esc>dd", { desc = "Cut line" })
map({ "i", "x", "n", "s" }, "<C-c>", "<esc>yy", { desc = "Copy line" })
map({ "i", "x", "n", "s" }, "<C-a>", "<esc>gg<S-v>G", { desc = "Select all" })

-- Move Lines
map("n", "<C-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<C-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

map({ "n" }, "<C-S-U>", "<C-d>zz", { desc = "Scroll down half page" })
