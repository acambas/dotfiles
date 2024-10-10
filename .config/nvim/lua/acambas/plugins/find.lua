return {
	"MagicDuck/grug-far.nvim",
	event = "VeryLazy",
	config = function()
		require("grug-far").setup({})
		local function get_relative_path_to_current_buffer_dir()
			-- Get the full path of the current buffer
			local buffer_full_path = vim.fn.expand("%:p")
			-- Get the directory of the current buffer
			local buffer_dir = vim.fn.fnamemodify(buffer_full_path, ":h")
			-- Get the relative path to the buffer's directory from the current working directory
			local relative_path = vim.fn.fnamemodify(buffer_dir, ":.")
			return relative_path
		end

		vim.api.nvim_create_user_command("FindInDir", function()
			local search_directory = ""
			-- check if filyetype is oil
			if vim.bo.filetype == "oil" then
				local oil = require("oil")
				search_directory = oil.get_current_dir()
			else
				search_directory = get_relative_path_to_current_buffer_dir()
			end
			-- vim.notify(search_directory, vim.log.levels.INFO, { title = "directory for searching" })
			require("grug-far").open({ prefills = { flags = "--fixed-strings", paths = search_directory } })
		end, {})
		vim.keymap.set({ "n", "v" }, "<leader>fe", function()
			require("grug-far").open({ prefills = { flags = "--fixed-strings" } })
		end, { desc = "search everywhere" })
		vim.keymap.set({ "n", "v" }, "<leader>ff", function()
			require("grug-far").open({ prefills = { flags = "--fixed-strings", paths = vim.fn.expand("%") } })
		end, { desc = "search everywhere" })
	end,
}
