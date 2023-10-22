local plugins = require('plugins')

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    'git',
    'clone',
    "--filter=blob:none",
    'https://github.com/folke/lazy.nvim.git',
    lazy_path
  })
end

vim.opt.rtp:prepend(lazy_path)

require('lazy').setup(plugins, {
  defaults = {
    lazy = false
  }
})
