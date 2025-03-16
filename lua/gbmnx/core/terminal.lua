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
local terminal_win = nil

-- Toggle terminal function
local function toggle_terminal()
	if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
		-- Hide terminal by closing the window, but keeping the buffer
		vim.api.nvim_win_hide(terminal_win)
		terminal_win = nil
	else
		-- Open a new terminal or reuse an existing one
		vim.cmd("new")
		vim.cmd("wincmd J")
		vim.api.nvim_win_set_height(0, 12)
		vim.wo.winfixheight = true
		vim.cmd("term")

		-- Store the terminal window ID
		terminal_win = vim.api.nvim_get_current_win()
	end
end

-- Open a terminal at the bottom of the screen with a fixed height.
map("n", "<leader>t", toggle_terminal)
