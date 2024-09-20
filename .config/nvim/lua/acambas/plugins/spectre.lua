return {
	"nvim-pack/nvim-spectre",
	event = "VeryLazy",
	enabled = false,
	cond = function()
		if vim.g.vscode then
			return false
		else
			return true
		end
	end,
	config = function()
		require("spectre").setup({

			default = {
				find = {
					options = { "fixed-string", "smart-case" },
				},
			},
			find_engine = {
				-- rg is map with finder_cmd
				["rg"] = {
					cmd = "rg",
					-- default args
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
					options = {
						["ignore-case"] = {
							value = "--ignore-case",
							icon = "[I]",
							desc = "ignore case",
						},
						["hidden"] = {
							value = "--hidden",
							desc = "hidden file",
							icon = "[H]",
						},
						["smart-case"] = {
							value = "--smart-case",
							desc = "smart case",
							icon = "[S]",
						},
						["fixed-string"] = {
							value = "-F",
							desc = "fixed string search",
							icon = "[F]",
						},
						-- you can put any rg search option you want here it can toggle with
						-- show_option function
					},
				},
			},
		})
		local function get_relative_path_to_current_buffer_dir()
			-- Get the full path of the current buffer
			local buffer_full_path = vim.fn.expand("%:p")
			-- Get the directory of the current buffer
			local buffer_dir = vim.fn.fnamemodify(buffer_full_path, ":h")
			-- Get the relative path to the buffer's directory from the current working directory
			local relative_path = vim.fn.fnamemodify(buffer_dir, ":.")
			return relative_path
		end

		vim.api.nvim_create_user_command("SearchInDir", function()
			local search_directory = ""
			-- check if filyetype is oil
			if vim.bo.filetype == "oil" then
				local oil = require("oil")
				search_directory = oil.get_current_dir()
			else
				search_directory = get_relative_path_to_current_buffer_dir()
			end
			-- vim.notify(search_directory, vim.log.levels.INFO, { title = "directory for searching" })
			local spectre = require("spectre")
			spectre.open({ search_paths = { search_directory } })
		end, {}) -- directory path
	end,
}
