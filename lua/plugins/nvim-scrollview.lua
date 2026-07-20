-- 文件滚动条插件，右侧显示 gitsigns 增改删标记
return {
  {
    "dstein64/nvim-scrollview",
    dependencies = { "lewis6991/gitsigns.nvim" },
    opts = {},
    config = function(_, opts)
      -- 同一行只保留一个 gitsigns 标记，避免 add/change/delete 叠在一起
      vim.g.scrollview_signs_max_per_row_by_group = { gitsigns = 1 }
      require("scrollview").setup(opts)
      require("scrollview.contrib.gitsigns").setup({
        add_priority = 90,
        change_priority = 91,
        delete_priority = 92,
      })
    end,
  },
}
