return {
	"MagicDuck/grug-far.nvim",
	config = function()
		require("grug-far").setup({

			vim.keymap.set({ "n", "v" }, "<leader>fe", function()
				require("grug-far").open({ prefills = { flags = "--fixed-strings" } })
			end, { desc = "search everywhere" }),
		})
	end,
}
