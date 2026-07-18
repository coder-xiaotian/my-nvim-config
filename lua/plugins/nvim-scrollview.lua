-- 文件滚动条插件，右侧显示 gitsigns 增改删标记
return {
  {
    "dstein64/nvim-scrollview",
    dependencies = { "lewis6991/gitsigns.nvim" },
    opts = {},
    config = function(_, opts)
      require("scrollview").setup(opts)
      require("scrollview.contrib.gitsigns").setup()
    end,
  },
}
