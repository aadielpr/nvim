return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
	keys = {
		{ "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Open DiffView" },
		{ "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close DiffView" },
		{ "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
	},
	opts = {},
}
