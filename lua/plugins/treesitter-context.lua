return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  opts = {
    max_lines = 3, -- 最多显示几行上下文（函数头）
    multiline_threshold = 1, -- 单行函数不显示
  },
}
