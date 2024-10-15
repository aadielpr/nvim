return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>w", vim.cmd.UndotreeToggle)
	end,
}
