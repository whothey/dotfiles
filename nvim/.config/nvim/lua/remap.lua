vim.g.mapleader = " "
vim.keymap.set("n", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-l>", "<C-W>l")
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Jump to next warning/error" } )
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Jump to previous warning/error" })
vim.keymap.set("n", "]t", function() vim.cmd('tabnext') end, { desc = "Next tab" })
vim.keymap.set("n", "[t", function() vim.cmd('tabprevious') end, { desc = "Previous tab" })
vim.keymap.set("n", "]T", function() vim.cmd('tabm +1') end, { desc = "Move tab right" })
vim.keymap.set("n", "[T", function() vim.cmd('tabm -1') end, { desc = "Move tab left" })
vim.keymap.set("n", "<leader>tc", function() vim.cmd('tabnew') end, { desc = "Create a tab" })
vim.keymap.set("n", "<leader>td", function() vim.cmd('tabclose') end, { desc = "Close a tab" })
vim.keymap.set("n", "<leader>do", function() vim.diagnostic.open_float() end, { desc = "Open diagnostics float" });
vim.keymap.set("n", "<leader>dt", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = "Toggle diagnostics" });
