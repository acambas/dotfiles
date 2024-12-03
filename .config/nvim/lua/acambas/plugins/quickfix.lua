return {
	"kevinhwang91/nvim-bqf",
	event = "VeryLazy",
	config = function()
		require("bqf").setup({})
	end,
	enabled = true,
	dependencies = {
		{
			"junegunn/fzf",
			run = function()
				vim.fn["fzf#install"]()
			end,
		},
	},
}
