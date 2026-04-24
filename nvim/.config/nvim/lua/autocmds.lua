local augroup = vim.api.nvim_create_augroup("__whothey_init_private", { clear = true });

vim.api.nvim_create_autocmd('BufRead', {
  group = augroup,
  callback = function()
    vim.api.nvim_feedkeys("'\"", "m", false);
  end
})
