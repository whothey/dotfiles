vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true

vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.textwidth = 100
vim.opt.colorcolumn = "+1"

vim.cmd("highlight ColorColumn ctermbg=8 guibg=lightgrey")

vim.api.nvim_create_autocmd({'VimEnter', 'VimLeave'}, {
  pattern = '*',
  callback = function()
    vim.cmd('silent !tmux set status');
  end,
})

