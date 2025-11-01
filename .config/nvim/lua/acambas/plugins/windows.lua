return {
	{
		"b0o/incline.nvim",
		enabled = false,
		config = function()
			local helpers = require("incline.helpers")
			local devicons = require("nvim-web-devicons")
			require("incline").setup({
				window = {
					padding = 0,
					margin = { horizontal = 0 },
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[props.buf].modified
					local bgcol = props.focused and "#41798f" or "#44406e"

					return {
						ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
							or "",
						" ",
						{ filename, gui = modified and "bold,italic" or "bold" },
						" ",
						guibg = bgcol,
					}
				end,
			})
		end,
		-- Optional: Lazy load Incline
		event = "VeryLazy",
	},
	-- {
	-- 	"Bekaboo/dropbar.nvim",
	-- 	-- optional, but required for fuzzy finder support
	-- 	enabled = false,
	-- 	dependencies = {
	-- 		"nvim-telescope/telescope-fzf-native.nvim",
	-- 		build = "make",
	-- 	},
	-- 	config = function()
	-- 		local dropbar_api = require("dropbar.api")
	-- 		vim.keymap.set("n", "<leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
	-- 		vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
	-- 		vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
	-- 	end,
	-- },
}
