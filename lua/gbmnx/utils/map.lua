local M = {}

function M.map(mode, lhs, rhs, opts)
	opts = vim.tbl_extend("force", { noremap = true, silent = false }, opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

return M
