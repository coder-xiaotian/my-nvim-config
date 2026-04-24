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
          require("persistence").load()
        end,
      })
    end,
  },
}
