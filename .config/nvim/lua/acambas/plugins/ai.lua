return {
	{
		"greggh/claude-code.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for git operations
		},
		enabled = false,
		config = function()
			require("claude-code").setup({
				git = {
					use_git_root = false, -- Set CWD to git root when opening Claude Code (if in git project)
				},
			})
		end,
	},
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `toggle()`.
			-- { "folke/snacks.nvim", opts = { input = {}, picker = {} } },
		},
		config = function()
			vim.g.opencode_opts = {
				-- Your configuration, if any — see `lua/opencode/config.lua`
			}

			-- Required for `vim.g.opencode_opts.auto_reload`
			vim.opt.autoread = true

			-- Recommended/example keymaps
			vim.keymap.set({ "n", "x" }, "<leader>oa", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask about this" })
			vim.keymap.set({ "n", "x" }, "<leader>o+", function()
				require("opencode").prompt("@this")
			end, { desc = "Add this" })
			vim.keymap.set({ "n", "x" }, "<leader>os", function()
				require("opencode").select()
			end, { desc = "Select prompt" })
			vim.keymap.set("n", "<leader>ot", function()
				require("opencode").toggle()
			end, { desc = "Toggle embedded" })
			vim.keymap.set("n", "<leader>on", function()
				require("opencode").command("session_new")
			end, { desc = "New session" })
			vim.keymap.set("n", "<leader>oi", function()
				require("opencode").command("session_interrupt")
			end, { desc = "Interrupt session" })
			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("messages_half_page_up")
			end, { desc = "Messages half page up" })
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("messages_half_page_down")
			end, { desc = "Messages half page down" })
		end,
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
				provider = "claude", -- or "openai", "ollama", "gemini", "mistral", "deepseek", "llama3", "llama2"
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
		enabled = false,
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
}
