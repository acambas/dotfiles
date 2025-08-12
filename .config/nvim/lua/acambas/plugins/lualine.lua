return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", { "yavorski/lualine-macro-recording.nvim" } },
	cond = function()
		if vim.g.vscode then
			return false
		else
			return true
		end
	end,
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 35,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {},
				lualine_c = { { "filename", path = 1, file_status = true } },
				lualine_x = { "searchcount", { "macro_recording", "%S" }, "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			-- winbar = {
			-- 	lualine_a = {
			-- 		{
			-- 			"filename",
			-- 			path = 4, -- Relative  path
			-- 			symbols = {
			-- 				modified = "Δ", -- Text to show when the file is modified.
			-- 				readonly = "", -- Text to show when the file is non-modifiable or readonly.
			-- 			},
			-- 		},
			-- 	},
			-- },
			-- inactive_winbar = {
			-- 	lualine_a = {
			-- 		{
			-- 			"filename",
			-- 			path = 4, -- Relative path
			-- 			symbols = {
			-- 				modified = "Δ", -- Text to show when the file is modified.
			-- 				readonly = "", -- Text to show when the file is non-modifiable or readonly.
			-- 			},
			-- 		},
			-- 	},
			-- },
			extensions = { "oil", "lazy" },
		})
	end,
}
