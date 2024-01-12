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
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>tp', builtin.pickers, {})

-- LSP
vim.keymap.set('n', '<leader>lss', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>pS', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>lsr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>lsi', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>lsd', builtin.lsp_definitions, {})
