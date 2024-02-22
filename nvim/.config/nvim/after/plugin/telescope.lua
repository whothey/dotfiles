local builtin = require('telescope.builtin')

require('telescope').load_extension('dap')

vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find open buffers" })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files of current dir" })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Find nvim keymaps" })
vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = "Find nvim registers" })
vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = "Find treesitter symbols" })
vim.keymap.set('n', '<leader>fgf', builtin.git_files, { desc = "Find git files" })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Find git files" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fg', function()
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

