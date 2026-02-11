return {
  -- 自动恢复会话时需要禁用 dashboard，否则 dashboard 会覆盖恢复的 buffer
  {
    "snacks.nvim",
    opts = function(_, opts)
      -- 仅当无参数启动时禁用 dashboard
      if vim.fn.argc(-1) == 0 then
        opts.dashboard = opts.dashboard or {}
        opts.dashboard.enabled = false
      end
    end,
  },
  {
    "folke/persistence.nvim",
    opts = {},
    init = function()
      -- 启动时自动恢复会话（仅当没有传入文件参数时）
      vim.api.nvim_create_autocmd("VimEnter", {
        nested = true,
        callback = function()
          require("persistence").load({ last = true })
          -- 删除 session 恢复后残留的空 [No Name] buffer
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_get_name(buf) == "" and vim.bo[buf].buftype == "" and not vim.bo[buf].modified then
              pcall(vim.api.nvim_buf_delete, buf, {})
            end
          end
        end,
      })
    end,
  },
}
