local builtin = require('telescope.builtin')

require('telescope').load_extension('dap')

vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string()
end)
vim.keymap.set('n', '<leader>pg', function()
  builtin.grep_string({
    search = vim.fn.input({
      prompt = "Grep > ";
      default = vim.fn.expand('<cword>');
    });
  });
end)

-- LSP
vim.keymap.set('n', '<leader>lss', builtin.lsp_document_symbols, { desc = "Lookup LSP file symbols" })
vim.keymap.set('n', '<leader>lsS', builtin.lsp_workspace_symbols, { desc = "Lookup LSP workspace symbols" })
vim.keymap.set('n', '<leader>lsr', builtin.lsp_references, { desc = "Lookup LSP references to current symbol under cursor" })
vim.keymap.set('n', '<leader>lsi', builtin.lsp_implementations, { desc = "Lookup LSP implementations of current symbol under cursor" })
vim.keymap.set('n', '<leader>lsd', builtin.lsp_definitions, { desc = "Lookup LSP definitions of current symbol under cursor" })

