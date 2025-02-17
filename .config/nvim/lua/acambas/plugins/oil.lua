return {
	"stevearc/oil.nvim",
	cond = function()
		if vim.g.vscode then
			return false
		else
			return true
		end
	end,

	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
			use_default_keymaps = false,
			experimental_watch_for_changes = true,
			keymaps = {
				["_"] = "actions.open_cwd",
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-r>"] = "actions.refresh",
				["<C-w>V"] = "actions.select_vsplit",
				["<C-w>S"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-x>"] = "actions.close",
				["gr"] = "actions.refresh",
				["<Backspace>"] = "actions.parent",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
			},
			columns = {
				"icon",
				-- "permissions",
				-- "size",
				-- "mtime",
			},
		})
		vim.keymap.set("n", "<bs>", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		-- vim.keymap.set("n", "<leader>E", function()
		--   -- copy path of current buffers directory to a local variable
		--   local path = vim.fn.expand("%:p:h")
		--   -- split the window vertically
		--   vim.cmd("vsplit")
		--
		--   -- open oil with the path in a split window
		--   vim.cmd("Oil " .. path)
		-- end, { desc = "Open parent directory" })
	end,
	-- Optional dependencies
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
