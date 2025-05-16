local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local make_entry = require("telescope.make_entry")
local config = require("telescope.config").values

local smart_grep = function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd or vim.fn.getcwd()
	local finder = finders.new_async_job({
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end
			local pieces = vim.split(prompt, "  ")
			local args = { "rg" }
			if pieces[1] then
				table.insert(args, "-e")
				table.insert(args, pieces[1])
			end

			if pieces[2] then
				table.insert(args, "-g")
				table.insert(args, pieces[2])
			end

			local res = vim.list_extend(args, {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"-F",
			})

			return res
		end,
		cwd = opts.cwd,
		entry_maker = make_entry.gen_from_vimgrep(opts),
	})

	pickers
		.new(opts, {
			sorter = sorters.empty(),
			previewer = config.grep_previewer(opts),
			debounce = opts.debounce or 100,
			finder = finder,
			prompt_title = "Smart Grep",
		})
		:find()
end

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		--    or                              , branch = '0.1.x',
		event = "VeryLazy",
		enabled = true,
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
			require("telescope").load_extension("ui-select")
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					sorting_strategy = "ascending",
					layout_config = {
						prompt_position = "top",
						vertical = {
							prompt_position = "top",
						},
					},
					path_display = { "smart" },
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
				},
				extensions = {
					fzf = {},
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
			require("telescope").load_extension("fzf")
			vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[S]earch [B]uffers" })
			vim.keymap.set("n", "<leader>sg", smart_grep, { desc = "[S]mart [G]rep" })

			-- vim.keymap.set("n", "<leader>sg", function()
			-- 	require("telescope.builtin").live_grep({
			-- 		vimgrep_arguments = {
			-- 			"rg",
			-- 			"--color=never",
			-- 			"--no-heading",
			-- 			"--with-filename",
			-- 			"--line-number",
			-- 			"--column",
			-- 			"--smart-case",
			-- 			"-F",
			-- 		},
			-- 	})
			-- end, { desc = "[S]earch by [G]rep" })
			-- vim.keymap.set("n", "<leader>sk", require("telescope.builtin").keymaps, { desc = "[S]earch [K]eymaps" })
		end,
	},
}
