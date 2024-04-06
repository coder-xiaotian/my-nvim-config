return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      -- disable the keymap to grep files
      { "<leader>di", false },
      { "<leader>do", false },
      { "<leader>dO", false },
      { "<leader>dc", false },
      -- custom keys
      {
        "<F7>",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<F8>",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<F20>",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<F9>",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
    },
  },
}
