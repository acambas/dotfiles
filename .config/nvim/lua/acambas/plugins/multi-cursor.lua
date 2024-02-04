local vscode_disable = function()
	if vim.g.vscode then
		return false
	else
		return true
	end
end

return {
	"mg979/vim-visual-multi",
	event = "VeryLazy",
	enabled = true,
	cond = vscode_disable,
	init = function()
		vim.g.VM_maps = {
			["Select Cursor Down"] = "<m-j>",
			["Select Cursor Up"] = "<m-k>",
		}
	end,
	config = function() end,
}
