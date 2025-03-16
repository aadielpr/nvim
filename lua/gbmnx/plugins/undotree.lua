return {
	"mbbill/undotree",
	config = function()
        local map = require("gbmnx.utils.map").map

		map("n", "<leader>w", vim.cmd.UndotreeToggle)
	end,
}
