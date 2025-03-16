return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		local map = require("gbmnx.utils.map").map

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		map("n", "<leader>a", function()
			harpoon:list():add()
		end)

		map("n", "H", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
			map("n", string.format("<leader>%d", idx), function()
				harpoon:list():select(idx)
			end)
		end
	end,
}
