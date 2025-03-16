-- Stop Neovim Daemons.
local stop_neovim_daemons = vim.api.nvim_create_augroup("StopNeovimDaemons", { clear = true })

vim.api.nvim_create_autocmd("ExitPre", {
	group = stop_neovim_daemons,
	callback = function()
		vim.fn.jobstart(vim.fn.expand("$SCRIPTS") .. "/stop-nvim-daemon.sh", { detach = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		-- Move down and jump to entry
		vim.keymap.set("n", "j", function()
			vim.cmd("cnext") -- Move to the next entry
			vim.cmd("wincmd p") -- Switch focus back to quickfix
		end, { buffer = true, silent = true })

		-- Move up and jump to entry
		vim.keymap.set("n", "k", function()
			vim.cmd("cprev") -- Move to the previous entry
			vim.cmd("wincmd p") -- Switch focus back to quickfix
		end, { buffer = true, silent = true })
	end,
})
