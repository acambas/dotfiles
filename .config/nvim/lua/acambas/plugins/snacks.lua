return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	-- opts = {
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
	-- bigfile = { enabled = true },
	-- dashboard = { enabled = true },
	-- indent = { enabled = true },
	-- input = { enabled = true },
	-- picker = { enabled = true },
	-- notifier = { enabled = true },
	-- quickfile = { enabled = true },
	-- scroll = { enabled = true },
	-- statuscolumn = { enabled = true },
	-- words = { enabled = true },
	-- },
	config = function()
		local snacks = require("snacks")
		snacks.setup({})
		vim.keymap.set("n", "<leader>gf", function()
			snacks.lazygit.log_file()
		end)
		vim.keymap.set("n", "<leader>gg", function()
			snacks.lazygit.open()
		end)
		vim.keymap.set("n", "<leader>gl", function()
			snacks.lazygit.log()
		end)
	end,
}
