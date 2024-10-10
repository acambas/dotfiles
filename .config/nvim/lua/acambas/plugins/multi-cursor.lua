local vscode_disable = function()
	if vim.g.vscode then
		return false
	else
		return true
	end
end

return {
	{
		"brenton-leighton/multiple-cursors.nvim",
		version = "*", -- Use the latest tagged version
		enabled = false,
		opts = {
			pre_hook = function()
				vim.g.minipairs_disable = true
				-- vim.fn.CocActionAsync("deactivateExtension", "coc-pairs")
			end,
			post_hook = function()
				vim.g.minipairs_disable = false
				-- vim.fn.CocActionAsync('activeExtension', 'coc-pairs')
			end,
		}, -- This causes the plugin setup function to be called
		keys = {
			{ "<m-j>", "<Cmd>MultipleCursorsAddDown<CR>" },
			{ "<m-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i" } },
			{ "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" } },
			-- { "<Leader>a",     "<Cmd>MultipleCursorsAddMatches<CR>",       mode = { "n", "x" } },
			-- { "<Leader>A",     "<Cmd>MultipleCursorsAddMatchesV<CR>",      mode = { "n", "x" } },
			{ "<C-n>", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "x" } },
			-- { "<Leader>D",     "<Cmd>MultipleCursorsJumpNextMatch<CR>" },
		},
	},
	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		config = function()
			local mc = require("multicursor-nvim")

			mc.setup()

			local set = vim.keymap.set

			-- Add or skip cursor above/below the main cursor.
			set({ "n", "v" }, "<m-up>", function()
				mc.lineAddCursor(-1)
			end)
			set({ "n", "v" }, "<m-down>", function()
				mc.lineAddCursor(1)
			end)
			-- set({ "n", "v" }, "<leader><up>", function()
			-- 	mc.lineSkipCursor(-1)
			-- end)
			-- set({ "n", "v" }, "<leader><down>", function()
			-- 	mc.lineSkipCursor(1)
			-- end)

			-- -- Add or skip adding a new cursor by matching word/selection
			set({ "n", "v" }, "<m-n>", function()
				mc.matchAddCursor(1)
			end)
			-- set({ "n", "v" }, "<leader>s", function()
			-- 	mc.matchSkipCursor(1)
			-- end)
			-- set({ "n", "v" }, "<leader>N", function()
			-- 	mc.matchAddCursor(-1)
			-- end)
			-- set({ "n", "v" }, "<leader>S", function()
			-- 	mc.matchSkipCursor(-1)
			-- end)

			-- Add all matches in the document
			set({ "n", "v" }, "<leader>A", mc.matchAllAddCursors)

			-- You can also add cursors with any motion you prefer:
			-- set("n", "<right>", function()
			--     mc.addCursor("w")
			-- end)
			-- set("n", "<leader><right>", function()
			--     mc.skipCursor("w")
			-- end)

			-- Rotate the main cursor.
			set({ "n", "v" }, "<m-left>", mc.nextCursor)
			set({ "n", "v" }, "<m-right>", mc.prevCursor)

			-- Delete the main cursor.
			set({ "n", "v" }, "<m-x>", mc.deleteCursor)

			-- Add and remove cursors with control + left click.
			set("n", "<c-leftmouse>", mc.handleMouse)

			-- Easy way to add and remove cursors using the main cursor.
			-- set({ "n", "v" }, "<c-q>", mc.toggleCursor)

			-- Clone every cursor and disable the originals.
			-- set({ "n", "v" }, "<leader><c-q>", mc.duplicateCursors)

			set({ "n", "v" }, "<m-esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				elseif mc.hasCursors() then
					mc.clearCursors()
				else
					-- Default <esc> handler.
				end
			end)

			-- bring back cursors if you accidentally clear them
			-- set("n", "<leader>gv", mc.restoreCursors)
			--
			-- -- Align cursor columns.
			-- set("v", "<leader>a", mc.alignCursors)
			--
			-- -- Split visual selections by regex.
			-- set("v", "S", mc.splitCursors)
			--
			-- -- Append/insert for each line of visual selections.
			-- set("v", "I", mc.insertVisual)
			-- set("v", "A", mc.appendVisual)
			--
			-- -- match new cursors within visual selections by regex.
			-- set("v", "M", mc.matchCursors)
			-- --
			-- -- Rotate visual selection contents.
			-- set("v", "<leader>t", function()
			-- 	mc.transposeCursors(1)
			-- end)
			-- set("v", "<leader>T", function()
			-- 	mc.transposeCursors(-1)
			-- end)

			-- Customize how cursors look.
			local hl = vim.api.nvim_set_hl
			hl(0, "MultiCursorCursor", { link = "Cursor" })
			hl(0, "MultiCursorVisual", { link = "Visual" })
			hl(0, "MultiCursorSign", { link = "SignColumn" })
			hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
			hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
			hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
		end,
	},
}
