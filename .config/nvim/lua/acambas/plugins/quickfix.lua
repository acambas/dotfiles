return {
  'kevinhwang91/nvim-bqf',
  config = function()
    require('bqf').setup({
    })
  end,
  enabled = false,
  dependencies = {
    {
      'junegunn/fzf',
      run = function()
        vim.fn['fzf#install']()
      end
    }
  }
}
