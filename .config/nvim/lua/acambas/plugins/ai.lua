return {
	{
		"NickvanDyke/opencode.nvim",
		event = "VeryLazy",
		lazy = true,
		dependencies = {
			"folke/snacks.nvim",
		},
		enabled = true,
		opts = {},
  -- stylua: ignore
      keys = {
        -- opencode.nvim exposes a general, flexible API — customize it to your workflow!
        -- But here are some examples to get you started :)
        { '<leader>ot', function() require('opencode').toggle() end, desc = 'Toggle opencode', },
        { '<leader>oa', function() require('opencode').ask() end, desc = 'Ask opencode', mode = { 'n', 'v' }, },
        { '<leader>oA', function() require('opencode').ask('@file ') end, desc = 'Ask opencode about current file', mode = { 'n', 'v' }, },
        { '<leader>on', function() require('opencode').command('/new') end, desc = 'New session', },
        { '<leader>oe', function() require('opencode').prompt('Explain @cursor and its context') end, desc = 'Explain code near cursor' },
        { '<leader>or', function() require('opencode').prompt('Review @file for correctness and readability') end, desc = 'Review file', },
        { '<leader>of', function() require('opencode').prompt('Fix these @diagnostics') end, desc = 'Fix errors', },
        { '<leader>oo', function() require('opencode').prompt('Optimize @selection for performance and readability') end, desc = 'Optimize selection', mode = 'v', },
        { '<leader>od', function() require('opencode').prompt('Add documentation comments for @selection') end, desc = 'Document selection', mode = 'v', },
        -- { '<leader>ot', function() require('opencode').prompt('Add tests for @selection') end, desc = 'Test selection', mode = 'v', },
      },
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = true,
		enabled = false,
		version = false, -- set this if you want to always pull the latest change
		config = function()
			require("avante").setup({
				-- default options
				provider = "copilot", -- or "openai", "ollama", "gemini", "mistral", "deepseek", "llama3", "llama2"
				-- copilot = {
				-- 	model = "claude-3.7-sonnet",
				-- },
			})
		end,
		-- opts = {
		-- 	provider = "copilot", -- Recommend using Claude
		-- 	-- auto_suggestions_provider = "copilot", --
		-- },
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			-- {
			-- 	-- Make sure to set this up properly if you have lazy=true
			-- 	"MeanderingProgrammer/render-markdown.nvim",
			-- 	opts = {
			-- 		file_types = { "markdown", "Avante" },
			-- 	},
			-- 	ft = { "markdown", "Avante" },
			-- },
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		enabled = true,
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						-- accept = "<M-l>",
						accept = false,
						accept_word = false,
						accept_line = "<c-y>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<S-tab>",
					},
				},
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		enabled = false,
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
