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

map({ "i", "x", "n", "s" }, "<C-d>", '<esc>"zyy"zp', { desc = "Duplicate line without touching clipboard" })
map({ "i", "x", "n", "s" }, "<C-x>", '<esc>yy"_dd', { desc = "Cut line" })

-- dd 删除行不进寄存器/剪贴板（要剪切请用 <C-x>）
map({ "n", "v" }, "d", '"_d', { desc = "Delete without yank" })
map({ "n", "v" }, "D", '"_D', { desc = "Delete to EOL without yank" })
map("n", "x", '"_x', { desc = "Delete char without yank" })
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

-- visual 模式下复制 cc 文件引用（@相对git-root路径:行区间），粘贴进 cc 直接定位
map("v", "<leader>cy", function()
  local s = vim.fn.getpos("'<")
  local e = vim.fn.getpos("'>")
  local file = vim.fn.expand("%:p")
  local root = vim.fs.root(0, ".git") or vim.fs.dirname(file)
  local rel = file:sub(#root + 2) -- root 无尾斜杠，跳过前导 /
  local range = s[2] == e[2] and tostring(s[2]) or (s[2] .. "-" .. e[2])
  local text = ("@%s:%s"):format(rel, range)
  vim.fn.setreg("+", text)
  vim.notify(("Copied %s"):format(text))
end, { desc = "Copy file location for Claude Code" })
