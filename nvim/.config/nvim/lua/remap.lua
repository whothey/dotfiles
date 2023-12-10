vim.g.mapleader = " "
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Jump to next warning/error" } )
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Jump to previous warning/error" })
vim.keymap.set("n", "]t", function() vim.cmd('tabnext') end, { desc = "Next tab" })
vim.keymap.set("n", "[t", function() vim.cmd('tabprevious') end, { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tc", function() vim.cmd('tabnew') end, { desc = "Create a tab" })
vim.keymap.set("n", "<leader>tx", function() vim.cmd('tabclose') end, { desc = "Close a tab" })
