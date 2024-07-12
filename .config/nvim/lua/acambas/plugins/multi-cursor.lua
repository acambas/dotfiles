local vscode_disable = function()
  if vim.g.vscode then
    return false
  else
    return true
  end
end

return {
  "brenton-leighton/multiple-cursors.nvim",
  version = "*", -- Use the latest tagged version
  enabled = true,
  opts = {
    pre_hook = function()
      vim.g.minipairs_disable = true
      vim.fn.CocActionAsync('deactivateExtension', 'coc-pairs')
    end,
    post_hook = function()
      vim.g.minipairs_disable = false
      vim.fn.CocActionAsync('activeExtension', 'coc-pairs')
    end,
  }, -- This causes the plugin setup function to be called
  keys = {
    { "<m-j>",         "<Cmd>MultipleCursorsAddDown<CR>" },
    { "<m-k>",         "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "i" } },
    { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>",   mode = { "n", "i" } },
    -- { "<Leader>a",     "<Cmd>MultipleCursorsAddMatches<CR>",       mode = { "n", "x" } },
    -- { "<Leader>A",     "<Cmd>MultipleCursorsAddMatchesV<CR>",      mode = { "n", "x" } },
    { "<C-n>",         "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "x" } },
    -- { "<Leader>D",     "<Cmd>MultipleCursorsJumpNextMatch<CR>" },
  },
}
