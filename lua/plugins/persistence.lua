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
          -- 恢复会话时首个 buffer 常常早于 treesitter 加载，
          -- 导致 syntax highlight 失效。延迟一帧后重新触发 FileType
          -- 让 treesitter 和其它 FileType 监听者补上。
          -- 根因：persistence 恢复会话时，非激活 buffer 不会触发 BufReadPost / filetype 检测，
          -- 导致 loaded 但 filetype=""，之后切过去也不会重新检测，自然没高亮。
          -- 修复：对所有 loaded 但缺 filetype 的普通文件 buffer 手动触发 filetype 检测。
          vim.schedule(function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if
                vim.api.nvim_buf_is_loaded(buf)
                and vim.bo[buf].buftype == ""
                and vim.bo[buf].filetype == ""
                and vim.api.nvim_buf_get_name(buf) ~= ""
              then
                local ft = vim.filetype.match({ buf = buf })
                if ft then
                  -- 设置 filetype 会级联触发 FileType autocmd，进而挂载 treesitter / LSP / indent 等
                  vim.bo[buf].filetype = ft
                end
              end
            end
          end)
        end,
      })
    end,
  },
}
