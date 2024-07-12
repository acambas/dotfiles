local vscode_disable = function()
  if vim.g.vscode then
    return false
  else
    return true
  end
end

return {
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    -- enabled = false,
    config = function()
      require("rose-pine").setup({
        variant = "auto",      -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_nc_background = false,
        disable_background = true,
        disable_float_background = true,
        disable_italics = true,
      })
    end,
    cond = vscode_disable,
  },
}
