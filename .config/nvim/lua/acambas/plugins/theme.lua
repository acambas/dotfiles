local vscode_disable = function()
	if vim.g.vscode then
		return false
	else
		return true
	end
end

return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		-- enabled = false,
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = false },
				functionStyle = {},
				keywordStyle = { italic = false },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = false, -- do not set background color
				dimInactive = true, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					light = "lotus",
				},
			})
			-- vim.cmd("colorscheme kanagawa")
		end,
		cond = vscode_disable,
	},
	{
		"rose-pine/neovim",
		lazy = false,
		priority = 1000,
		-- enabled = false,
		config = function()
			require("rose-pine").setup({
				variant = "auto", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = true,
				styles = {
					italic = false,
				},
			})
		end,
		cond = vscode_disable,
	},
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		-- enabled = false,
		config = function()
			require("onedark").setup()
		end,
		cond = vscode_disable,
	},
	{
		"projekt0n/github-nvim-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		cond = vscode_disable,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup()

			-- vim.cmd("colorscheme github_dark_tritanopia")
		end,
	},
}
