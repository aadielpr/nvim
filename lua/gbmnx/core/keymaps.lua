local map = require("gbmnx.utils.map").map
-- Split window
map("n", "ss", "<Cmd>split<CR><C-w>w")
map("n", "sv", "<Cmd>vsplit<CR><C-w>w")
-- These mappings control the size of splits (height/width)
map("n", "<M-,>", "<c-w>5<")
map("n", "<M-.>", "<c-w>5>")
map("n", "<M-t>", "<C-W>+")
map("n", "<M-s>", "<C-W>-")
-- Move between window
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-h>", "<C-w>h")

map("n", "Q", "")
map("n", "<F1>", "")
map("i", "<F1>", "")
map("n", "<leader>vh", ":noh<CR>")

-- Copy, Cut, Paste
map({ "n", "v" }, "y", '"+y')
map("n", "Y", '"+Y')
map({ "n", "v" }, "x", '"+x')
map({ "n", "v" }, "D", '"+D')

map({ "n", "v" }, "p", '"+p')
map({ "n", "v" }, "P", '"+P')

map("n", "sj", ":m+<CR>")
map("n", "sk", ":m-2<CR>")
map("v", "sj", ":m '>+1<CR>gv=gv")
map("v", "sk", ":m '<-2<CR>gv=gv")

-- go to normal mode when pressing CTRL+C
map("i", "<C-c>", "<Esc>")

map("n", "<n-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- search word
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("v", "<leader>s", [["hy:%s/<C-r>h/<C-r>h/gI<Left><Left><left>]])
map("n", "<leader>i", "<cmd>Inspect<CR>")

-- fold
map("n", ",f", "za")
