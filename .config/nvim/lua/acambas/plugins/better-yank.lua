return {
  "https://github.com/gbprod/yanky.nvim",
  event = "VeryLazy",
  config = function()
    require("yanky").setup({
      preserve_cursor_position = {
        enabled = true,
      },
    })
    vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
  end,
}
