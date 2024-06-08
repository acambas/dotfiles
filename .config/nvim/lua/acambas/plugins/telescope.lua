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
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			pcall(require("telescope").load_extension, "fzf")
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					mappings = {
						i = {
							["<C-h>"] = "which_key",
						},
					},
				},
				pickers = {
					buffers = {
						sort_lastused = true,
						initial_mode = "normal",
						mappings = {
							i = {
								["<c-x>"] = "delete_buffer",
							},
							n = {
								["<c-x>"] = "delete_buffer",
							},
						},
					},
				},
			})
			vim.keymap.set(
				"n",
				"<leader><space>",
				require("telescope.builtin").buffers,
				{ desc = "[ ] Find existing buffers" }
			)
			vim.keymap.set("n", "<leader>/", function()
				--      You can pass additional configuration to telescope to change theme, layout, etc.
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			vim.keymap.set("n", "<leader>p", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
			vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sg", function()
				require("telescope.builtin").live_grep({
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"-F",
					},
				})
			end, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sk", require("telescope.builtin").keymaps, { desc = "[S]earch [K]eymaps" })
		end,
	},
}
