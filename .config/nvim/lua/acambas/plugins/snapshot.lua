return {
	"mistricky/codesnap.nvim",
	build = "make",
	enabled = "false",
	event = "VeryLazy",
	config = function()
		require("codesnap").setup({
			bg_color = "#535c68",
			has_breadcrumbs = false,
			mac_window_bar = false,
		})
	end,
}
