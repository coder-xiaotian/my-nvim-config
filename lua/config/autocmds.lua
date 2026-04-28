-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- 自动保存 + 自动格式化
-- 触发时机：退出插入模式、切换 buffer、失去焦点
-- 策略：直接调用 conform 同步格式化，再写盘；不依赖 BufWritePre 链路
local auto_save_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "BufLeave", "FocusLost" }, {
  group = auto_save_group,
  pattern = "*",
  callback = function(ev)
    local buf = ev.buf
    -- 只处理已命名的、可修改的、常规文件类型的 buffer
    if not vim.bo[buf].modified then
      return
    end
    if vim.bo[buf].buftype ~= "" then
      return
    end
    if vim.api.nvim_buf_get_name(buf) == "" then
      return
    end

    -- 同步格式化（有 formatter 才会改，没有则静默跳过）
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({ bufnr = buf, async = false, lsp_format = "fallback" })
    end

    -- 写盘
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! write")
    end)
  end,
  desc = "Auto format + save on insert leave / buf leave / focus lost",
})
