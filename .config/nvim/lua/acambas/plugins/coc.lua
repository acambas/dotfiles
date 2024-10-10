return {
	"neoclide/coc.nvim",
	branch = "master",
	build = "npm install",
	enabled = false,
	event = "VeryLazy",

	-- cond = function()
	--   if vim.g.vscode then
	--     return false
	--   else
	--     if string.find(vim.fn.getcwd(), 'klarna-app/clients', 1, true) then
	--       return true
	--     else
	--       return false
	--     end
	--   end
	-- end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"fannheyward/telescope-coc.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("telescope").load_extension("coc")
		-- Some servers have issues with backup files, see #649
		vim.opt.backup = false
		vim.opt.writebackup = false

		-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
		-- delays and poor user experience
		vim.opt.updatetime = 300

		-- Always show the signcolumn, otherwise it would shift the text each time
		-- diagnostics appeared/became resolved
		vim.opt.signcolumn = "yes"

		local keyset = vim.keymap.set
		-- Autocomplete
		function _G.check_back_space()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
		end

		------------------------------------------------------------AUTOCOMPLETE-------------------------------------------------------------
		-- Use Tab for trigger completion with characters ahead and navigate
		-- NOTE: There's always a completion item selected by default, you may want to enable
		-- no select by setting `"suggest.noselect": true` in your configuration file
		-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
		-- other plugins before putting this into your config
		local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
		keyset(
			"i",
			"<TAB>",
			'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
			opts
		)
		keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
		-- Make <CR> to accept selected completion item or notify coc.nvim to format
		-- <C-g>u breaks current undo, please make your own choice
		-- keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts) -- Use <c-space> to trigger completio
		keyset(
			"i",
			"<cr>",
			[[coc#pum#visible() && coc#pum#info()['index'] == -1 ? "\<C-r>=coc#pum#cancel()\<CR>\<CR>"  : coc#pum#visible()  ? coc#_select_confirm() : "\<CR>" ]],
			opts
		)

		keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true }) -- Use <c-space> to trigger completio

		------------------------------------------------------------SNIPPETS-------------------------------------------------------------
		vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(coc-snippets-expand-jump)", { noremap = false, silent = true })
		vim.api.nvim_set_keymap(
			"i",
			"<C-k>",
			"<Plug>(coc-snippets-expand-jump-back)",
			{ noremap = false, silent = true }
		)

		------------------------------------------------------------NAVIGATION-------------------------------------------------------------
		-- keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
		keyset("n", "gd", "<CMD>Telescope coc definitions<cr>", { silent = true })
		-- keyset("n", "gt", "<Plug>(coc-type-definition)", { silent = true })
		keyset("n", "gt", "<CMD>Telescope coc type_definitions<cr>", { silent = true })
		keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
		keyset("n", "gr", "<CMD>Telescope coc references<cr>", { silent = true })
		-- keyset("n", "gr", "<Plug>(coc-references)", { silent = true })
		function _G.show_docs()
			local cw = vim.fn.expand("<cword>")
			if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
				vim.api.nvim_command("h " .. cw)
			elseif vim.api.nvim_eval("coc#rpc#ready()") then
				vim.fn.CocActionAsync("doHover")
			else
				vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
			end
		end

		keyset("n", "gh", "<CMD>lua _G.show_docs()<CR>", { silent = true })

		------------------------------------------------------------DIAGNOSTICS--------------------------------------------------------------
		-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
		vim.api.nvim_create_augroup("CocGroup", {})
		vim.api.nvim_create_autocmd("CursorHold", {
			group = "CocGroup",
			command = "silent call CocActionAsync('highlight')",
			desc = "Highlight symbol under cursor on CursorHold",
		})
		keyset("n", "<leader>cd", "<CMD>Telescope coc diagnostics<cr>", { silent = true })

		-- Use `[g` and `]g` to navigate diagnostics
		-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
		keyset("n", "[d", "<Plug>(coc-diagnostic-prev)", { silent = true })
		keyset("n", "]d", "<Plug>(coc-diagnostic-next)", { silent = true })
		------------------------------------------------------------CODE ACTIONS--------------------------------------------------------------
		keyset("n", "<leader>cr", "<Plug>(coc-rename)", { silent = true })
		keyset("n", "<leader>ca", "<CMD>Telescope coc file_code_actions<cr>", { silent = true })
		keyset("n", "<leader>cl", "<CMD>Telescope coc code_actions<cr>", { silent = true })
		--
		------------------------------------------------------------FORMAT--------------------------------------------------------------
		-- Add `:Format` command to format current buffer
		vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
		------------------------------------------------------------COC misc--------------------------------------------------------------

		keyset("n", "<leader>cc", "<CMD>Telescope coc commands<cr>", { silent = true })
		vim.g.coc_global_extensions = {
			"coc-json",
			"coc-tsserver",
			"coc-marketplace",
			"coc-html",
			"coc-lit-html",
			"coc-css",
			"coc-eslint",
			"coc-ultisnips",
			"coc-pairs",
			"coc-pretty-ts-errors",
			"coc-lua",
			"coc-markdownlint",
			"coc-biome",
			"coc-prettier",
			"coc-yaml",
			"coc-twoslash-queries",
			"coc-snippets",
			"@yaegassy/coc-marksman",
		}

		vim.g.coc_user_config = {
			suggest = {
				completionItemKindLabels = {
					["text"] = "󰉿 text",
					["method"] = "󰆧 method",
					["function"] = "󰊕 function",
					["constructor"] = " constructor",
					["field"] = "󰜢 field",
					["variable"] = "󰀫 variable",
					["class"] = "󰠱 class",
					["interface"] = " interface",
					["module"] = " module",
					["property"] = "󰜢 property",
					["unit"] = "󰑭 unit",
					["value"] = "󰎠 value",
					["enum"] = " enum",
					["keyword"] = "󰌋 keyword",
					["snippet"] = " snippet",
					["color"] = "󰏘 color",
					["file"] = "󰈙 file",
					["reference"] = "󰈇 reference",
					["folder"] = "󰉋 folder",
					["enumMember"] = " enumMember",
					["constant"] = "󰏿 constant",
					["struct"] = "󰙅 struct",
					["event"] = " event",
					["operator"] = "󰆕 operator",
					["default"] = "default",
				},
			},
		}

		----------------------garbage collextion -----------------------------------------------------
		local function notify(kind)
			if kind == "lsp_has_started" then
				vim.notify("Focus recovered. Starting LSP clients.", vim.log.levels.INFO, { title = "coc-gc" })
			elseif kind == "lsp_has_stopped" then
				vim.notify(
					"Inactive LSP clients have been stopped to save resources.",
					vim.log.levels.INFO,
					{ title = "coc-gc" }
				)
			end
		end

		local timer = vim.uv.new_timer() -- Can store ~29377 years

		local lsp_has_been_stopped = false

		-- Focus lost?
		vim.api.nvim_create_autocmd("FocusLost", {
			callback = function()
				timer:start(
					1000,
					0,
					vim.schedule_wrap(function()
						if lsp_has_been_stopped == false then
							lsp_has_been_stopped = true
							vim.notify("TURN OFF LSP", vim.log.levels.INFO, { title = "coc-gc" })
						end
					end)
				)
			end,
		})

		-- Focus gained?
		vim.api.nvim_create_autocmd("FocusGained", {
			callback = function()
				vim.defer_fn(function()
					if lsp_has_been_stopped then
						lsp_has_been_stopped = false
						vim.notify("turn ON coc lsp", vim.log.levels.INFO, { title = "coc-gc" })
					end
					timer:stop()
				end, 100)
			end,
		})
	end,
}
