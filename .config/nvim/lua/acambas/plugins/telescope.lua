return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    --    or                              , branch = '0.1.x',
    event = "VeryLazy",
    cond = function()
      if vim.g.vscode then
        return false
      else
        return true
      end
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      pcall(require("telescope").load_extension, "fzf")
      require("telescope").load_extension("ui-select")

      require("telescope").setup({
        defaults = {
          layout_strategy = 'vertical',
          path_display = { "smart" },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          buffers = {
            sort_lastused = true,
            mappings = {
              n = {
                ['<c-x>'] = require('telescope.actions').delete_buffer
              },
              i = {
                ['<c-x>'] = require('telescope.actions').delete_buffer
              },
            },
          }
        },
      })
      vim.keymap.set(
        "n",
        "<leader><leader>",
        require("telescope.builtin").buffers,
        { desc = "[ ] Find existing buffers" }
      )
      vim.keymap.set("n", "<leader>p", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
      vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })

      vim.keymap.set("n", "<leader>sg", function()
        require("telescope.builtin").live_grep({
          vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-F' }
        })
      end, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sk", require("telescope.builtin").keymaps, { desc = "[S]earch [K]eymaps" })
    end,
  },
}
