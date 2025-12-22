local set = vim.opt_local
local map = require("gbmnx.utils.map").map

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", {}),
	callback = function()
		set.number = false
		set.relativenumber = false
		set.scrolloff = 0

		vim.bo.filetype = "terminal"
	end,
})

-- Easily hit escape in terminal mode.
map("t", "<esc><esc>", "<c-\\><c-n>")

-- Store the terminal window ID
local terminal_buf = nil
local terminal_win = nil

local function toggle_terminal()
	-- If window exists → hide it
	if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
		vim.api.nvim_win_hide(terminal_win)
		terminal_win = nil
		return
	end

	-- Create buffer if it doesn't exist
	if not terminal_buf or not vim.api.nvim_buf_is_valid(terminal_buf) then
		vim.cmd("new")
		vim.cmd("wincmd J")
		vim.api.nvim_win_set_height(0, 12)
		vim.wo.winfixheight = true

		vim.cmd("term")
		terminal_buf = vim.api.nvim_get_current_buf()
	else
		-- Reopen existing terminal buffer
		vim.cmd("new")
		vim.cmd("wincmd J")
		vim.api.nvim_win_set_height(0, 12)
		vim.wo.winfixheight = true

		vim.api.nvim_win_set_buf(0, terminal_buf)
	end

	terminal_win = vim.api.nvim_get_current_win()

	-- Always enter terminal mode
	vim.cmd("startinsert!")
end

-- Open a terminal at the bottom of the screen with a fixed height.
map("n", "<C-t>", toggle_terminal)
map("t", "<C-t>", toggle_terminal)
map("t", "<M-t>", "<C-\\><C-n><C-w>+")
map("t", "<M-s>", "<C-\\><C-n><C-w>-")
map("t", "<M-,>", "<C-\\><C-n><C-w><")
map("t", "<M-.>", "<C-\\><C-n><C-w>>")
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { silent = true })
