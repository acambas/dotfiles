vim.g.mapleader = " "
vim.g.maplocalleader = " "

local noremap_silent = { noremap = true, silent = true }

vim.keymap.set({ "i", "n" }, "<C-s>", "<Esc>:silent update!<CR>", noremap_silent)                -- save file
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", noremap_silent)                                     -- move selection up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", noremap_silent)                                     -- move selection up
vim.keymap.set("n", "M", "gM", noremap_silent)                                                   -- Move to the middle of the line in normal mode
vim.keymap.set("n", "<C-D>", "<C-D>zz")                                                          -- Scroll down half a page and center the cursor line
vim.keymap.set("n", "<C-U>", "<C-U>zz")                                                          -- Scroll up half a page and center the cursor line
vim.keymap.set({ "n", "v" }, "H", "^")                                                           -- Move to the start of the line in normal and visual mode
vim.keymap.set({ "n", "v" }, "L", "$")                                                           -- Move to the end of the line in normal and visual mode
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })                              -- Disable the space key in normal and visual mode
vim.keymap.set("n", "q", "<nop>")                                                                -- Disable the q key in normal mode
vim.keymap.set("n", "S", "<nop>")                                                                -- Disable the S key in normal mode
vim.keymap.set({ "n", "v" }, "c", '"xc')                                                         -- Cut to clipboard in normal and visual mode
vim.keymap.set({ "v" }, "p", 'P')                                                                -- Paste before the cursor in visual mode
vim.keymap.set("n", "<leader>a", "ggVG")                                                         -- Select all text in the file
vim.keymap.set('t', '<Esc>', "<C-\\><C-n><C-w>h", { silent = true })                             -- Exit terminal mode with Esc
vim.keymap.set("i", "<m-backspace>", "<C-w>")                                                    -- Delete the previous word in insert mode with Alt+Backspace
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", noremap_silent)                                  -- Clear search highlight with Esc in normal mode
vim.keymap.set("n", "U", "<C-r>", { remap = false })                                             -- Use `u` to undo, use `U` to redo
vim.keymap.set("n", "n", "nzz", { remap = false })                                               -- Search next with n and center the cursor line
vim.keymap.set("n", "N", "Nzz", { remap = false })                                               -- Search previous with N and center the cursor line
vim.keymap.set("n", "*", "*zz", { remap = false })                                               -- Search the word under the cursor with * and center the cursor line
vim.keymap.set("n", "<C-q>", "<C-w>q", { silent = true })                                        -- Close the current window with Ctrl+q
vim.keymap.set("v", "'", [[:s/\%V\(.*\)\%V/'\1'/ <CR>]], { desc = "Surround selection with '" }) -- Surround the visual selection with ''
vim.keymap.set("v", '"', [[:s/\%V\(.*\)\%V/"\1"/ <CR>]], { desc = 'Surround selection with "' }) -- Surround the visual selection with ''
vim.keymap.set("v", '`', [[:s/\%V\(.*\)\%V/`\1`/ <CR>]], { desc = "Surround selection with `" }) -- Surround the visual selection with ``
vim.keymap.set("v", '{', [[:s/\%V\(.*\)\%V/{\1}/ <CR>]], { desc = "Surround selection with {" }) -- Surround the visual selection with {}
vim.keymap.set("v", '[', [[:s/\%V\(.*\)\%V/[\1]/ <CR>]], { desc = "Surround selection with [" }) -- Surround the visual selection with []
vim.keymap.set("v", "/", "y/<C-r>\"<CR>N")                                                       -- Search the visual selection
vim.keymap.set("n", "<tab>", "<C-S-^>")

-- keymap that deletes the current line and puts the cursor in the right place
vim.keymap.set("n", "dd", function()
  if vim.fn.getline(".") == "" then
    return '"_dd'
  end
  return "dd"
end, { expr = true })

-- get contents of visual selection
-- handle unpack deprecation
---@diagnostic disable-next-line: deprecated
table.unpack = table.unpack or unpack
local function get_visual()
  local _, ls, cs = table.unpack(vim.fn.getpos("v"))
  local _, le, ce = table.unpack(vim.fn.getpos("."))
  return vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
end

vim.keymap.set("v", "<C-r>", function()
  local pattern = table.concat(get_visual())
  -- escape regex and line endings
  pattern =
      vim.fn.substitute(vim.fn.escape(pattern, "^$.*\\/~[]"), "\n", "\\n", "g")
  -- send substitute command to vim command line
  vim.api.nvim_input("<Esc>:%s/" .. pattern .. "//gc<Left><Left><Left>")
end)



-- toggle quickfix window
vim.keymap.set("n", "<leader>gq", function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and "cclose" or "copen"
  vim.cmd("botright " .. action)
end, { desc = "toggle quicklist", noremap = true, silent = true })

-- toggle quickfix window
local toggle_qf = function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd "cclose"
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
  end
end
vim.keymap.set("n", "<leader>q", toggle_qf, { desc = "toggle quickfix" })
