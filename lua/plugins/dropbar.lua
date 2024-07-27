-- 文件面包屑导航条插件

return {
  {
    "Bekaboo/dropbar.nvim",
    keys = {
      {
        "<leader>m",
        function()
          local api = require("dropbar.api")
          local bar = require("dropbar.utils.bar")
          api.pick(#bar.get_current().components)
        end,
        desc = "open dropbar",
      },
    },
  },
}
