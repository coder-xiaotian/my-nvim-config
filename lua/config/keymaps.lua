-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local util = require("lazyvim.util")
local map = util.safe_keymap_set

vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

vim.keymap.del("i", "<C-s>")
vim.keymap.del("x", "<C-s>")
vim.keymap.del("n", "<C-s>")
map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- undo redo 重新映射
map({ "i", "x", "n", "s" }, "<D-z>", function()
  vim.cmd([[undo]])
end, { desc = "Undo" })
map({ "i", "x", "n", "s" }, "<D-S-z>", function()
  vim.cmd([[redo]])
end, { desc = "Rndo" })
-- map({ "i" }, "<D-z>", "<esc>uA", { desc = "Insert mode undo" })

map({ "i", "x", "n", "s" }, "<D-d>", "<esc>yyp", { desc = "Copy line to blow" })
map({ "i", "x", "n", "s" }, "<D-x>", "<esc>cc<esc>", { desc = "Cut line" })
map({ "i", "x", "n", "s" }, "<D-c>", "<esc>yy", { desc = "Copy line" })
map({ "i", "x", "n", "s" }, "<D-S-f>", "<esc><cmd>Telescope live_grep<cr>", { desc = "Find text globally" })
map({ "i", "x", "n", "s" }, "<D-S-o>", "<esc><cmd>Telescope find_files<cr>", { desc = "Find file globally" })
map({ "i", "x", "n", "s" }, "<D-a>", "<esc>gg<S-v>G", { desc = "Select all" })

-- Move Lines
map("n", "<D-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<D-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<D-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<D-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<D-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<D-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
