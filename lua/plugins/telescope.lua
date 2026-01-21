return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  keys = {
    -- disable the keymap to grep files
    { "<leader>/", false },
    { "<leader><space>", false },
    { "<D-S-f>", "<cmd>Telescope live_grep<cr>", desc = "Find text globally", mode = { "i", "x", "n", "s" } },
    { "<D-S-o>", "<cmd>Telescope find_files<cr>", desc = "Find file globally", mode = { "i", "x", "n", "s" } },
  },
}
