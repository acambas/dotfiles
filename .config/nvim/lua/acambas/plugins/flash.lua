return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		labels = "23456789asdfghjklqwertyuiopzxcvbnm",
		search = {
			multi_window = false,
			-- Each mode will take ignorecase and smartcase into account.
			-- * exact: exact match
			-- * search: regular search
			-- * fuzzy: fuzzy search
			mode = "fuzzy",
		},
		modes = {
			char = {
				enabled = true,
				autohide = true,
			},
			search = {
				enabled = true,
				highlight = { backdrop = false },
				jump = { history = true, register = true, nohlsearch = true },
				pattern = [[\%c\%v\%c]],
			},
		},
	},
	keys = {
		-- {
		-- 	"s",
		-- 	mode = { "n", "x", "o" },
		-- 	function()
		-- 		require("flash").jump()
		-- 	end,
		-- 	desc = "Flash",
		-- },
		{
			"vv",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		-- {
		-- 	"r",
		-- 	mode = "o",
		-- 	function()
		-- 		require("flash").remote()
		-- 	end,
		-- 	desc = "Remote Flash",
		-- },
		-- {
		-- 	"R",
		-- 	mode = { "o", "x" },
		-- 	function()
		-- 		require("flash").treesitter_search()
		-- 	end,
		-- 	desc = "Treesitter Search",
		-- },
	},
}
