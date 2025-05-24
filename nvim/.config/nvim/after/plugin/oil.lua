vim.keymap.set('n', '<leader>ef', function() vim.cmd.edit(vim.fn.expand('%:h')) end, { desc = "Edit filetree of current file" })
vim.keymap.set('n', '<leader>et', function() vim.cmd.edit('.') end, { desc = "Edit filetree from root dir" })
