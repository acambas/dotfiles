return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  cond = function()
    if vim.g.vscode then
      return false
    else
      return true
    end
  end,
  config = true,
}
