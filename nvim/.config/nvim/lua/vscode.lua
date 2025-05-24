local opts = {
    noremap = true,
    silent = true
}

-- remap leader key
vim.keymap.set("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({"n", "v"}, "<leader>db", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
vim.keymap.set({"n", "v"}, "K", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
vim.keymap.set({"n", "v"}, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
vim.keymap.set({"n", "v"}, "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
vim.keymap.set({"n", "v"}, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
vim.keymap.set({"n", "v"}, "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
vim.keymap.set({"n", "v"}, "<leader>lsf", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")
vim.keymap.set({"n", "v"}, "]d", "<cmd>lua require('vscode').action('editor.action.marker.next')<CR>")
vim.keymap.set({"n", "v"}, "[d", "<cmd>lua require('vscode').action('editor.action.marker.prev')<CR>")
vim.keymap.set({"n", "v"}, "<leader>dt", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
vim.keymap.set({"n", "v"}, "<leader>do", "<cmd>lua require('vscode').action('editor.action.marker.this')<CR>")


