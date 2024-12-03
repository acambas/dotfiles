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
			{
				"danielfalk/smart-open.nvim",
				branch = "0.2.x",
				config = function()
					require("telescope").load_extension("smart_open")
					vim.keymap.set("n", "<leader><leader>", function()
						require("telescope").extensions.smart_open.smart_open({ cwd_only = true })
					end, { desc = "smart search" })
				end,
				dependencies = {
					"kkharji/sqlite.lua",
					-- Only required if using match_algorithm fzf
					{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
					-- Optional.  If installed, native fzy will be used when match_algorithm is fzy
					{ "nvim-telescope/telescope-fzy-native.nvim" },
				},
			},
		},
		config = function()
			pcall(require("telescope").load_extension, "fzf")
			require("telescope").load_extension("ui-select")
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					path_display = { "smart" },
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
					buffers = {
						sort_lastused = true,
						mappings = {
							n = {
								["<c-x>"] = require("telescope.actions").delete_buffer,
							},
							i = {
								["<c-x>"] = require("telescope.actions").delete_buffer,
							},
						},
					},
				},
			})
			-- vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[S]earch [B]uffers" })

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
