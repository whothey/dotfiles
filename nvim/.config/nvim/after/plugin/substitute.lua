-- Substitute
vim.keymap.set("n", "s", require('substitute').operator, { noremap = true, desc = "Substitute motion" })
vim.keymap.set("n", "ss", require('substitute').line, { noremap = true, desc = "Substitute line" })
vim.keymap.set("n", "S", require('substitute').eol, { noremap = true, desc = "Substitute to the end of line" });
vim.keymap.set("x", "s", require('substitute').visual, { noremap = true, desc = "Substitute visual" })
vim.keymap.set("n", "<leader>s", require('substitute.range').operator, { noremap = true, desc = "Substitute range normal mode" })
vim.keymap.set("x", "<leader>s", require('substitute.range').visual, { noremap = true, desc = "Substitute range visual mode" })
vim.keymap.set("n", "<leader>ss", require('substitute.range').word, { noremap = true, desc = "Substitute range word normal mode" })
