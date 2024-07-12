return {
  'rguruprakash/simple-note.nvim',
  enabled = false,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('simple-note').setup({
      notes_dir = '~/notes/' -- default: '~/notes/'
    })
    vim.api.nvim_set_keymap('n', '<leader>nc', '<cmd>SimpleNoteCreate<cr>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>nn', '<cmd>SimpleNoteList<cr>',
      { noremap = true, silent = true })
  end
}
