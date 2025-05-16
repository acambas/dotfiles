local vscode_disable = function()
	if vim.g.vscode then
		return false
	else
		return true
	end
end

return {

	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		enabled = true,
		event = "VeryLazy",
		config = function()
			local mc = require("multicursor-nvim")
			mc.setup()

			vim.keymap.set({ "n", "v" }, "<m-up>", function()
				mc.addCursor("k")
			end)

			vim.keymap.set({ "n", "v" }, "<m-down>", function()
				mc.addCursor("j")
			end)
			vim.keymap.set({ "n", "v" }, "<m-n>", function()
				mc.addCursor("*")
			end)
			vim.keymap.set({ "n", "v" }, "<m-s>", function()
				mc.skipCursor("*")
			end)

			vim.keymap.set({ "n" }, "<m-leftmouse>", mc.handleMouse)
			mc.addKeymapLayer(function(layerSet)
				layerSet({ "n", "x" }, "<left>", mc.prevCursor)
				layerSet({ "n", "x" }, "<right>", mc.nextCursor)
				layerSet({ "n", "x" }, "<m-x>", mc.deleteCursor)
				layerSet("n", "<esc>", function()
					if not mc.cursorsEnabled() then
						mc.enableCursors()
					else
						mc.clearCursors()
					end
				end)
			end)
		end,
	},
}
