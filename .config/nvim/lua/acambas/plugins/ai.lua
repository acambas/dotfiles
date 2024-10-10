return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		event = "VeryLazy",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		config = function()
			require("CopilotChat").setup({
				debug = true, -- Enable debugging
				-- See Configuration section for rest
				mappings = {
					complete = {
						detail = "Use @<Tab> or /<Tab> for options.",
						insert = "<Tab>",
					},
					close = {
						normal = "q",
						insert = "<C-c>",
					},
					reset = {
						normal = "<C-r>",
						insert = "<C-r>",
					},
					submit_prompt = {
						normal = "<CR>",
						insert = "<C-m>",
					},
					accept_diff = {
						normal = "<C-y>",
						insert = "<C-y>",
					},
					yank_diff = {
						normal = "gy",
					},
					show_diff = {
						normal = "gd",
					},
					show_system_prompt = {
						normal = "gp",
					},
					show_user_selection = {
						normal = "gs",
					},
				},
			})
			vim.keymap.set({ "n" }, "<leader>ccq", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end)
			vim.keymap.set({ "v" }, "<leader>ccq", function()
				require("CopilotChat").ask("explain how it works", { selection = require("CopilotChat.select").visual })
			end) -- save file
		end,
	},
}
