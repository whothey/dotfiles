local plugins = {
  "folke/lazy.nvim";
  {
    "projekt0n/github-nvim-theme",
    config = function()
      vim.cmd('colorscheme github_light')
    end
  };
  {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate", event = "BufRead", lazy = false};
  "nvim-treesitter/nvim-treesitter-context";
  "kylechui/nvim-surround";
  {'nvim-telescope/telescope.nvim', tag = '0.1.2', dependencies = { 'nvim-lua/plenary.nvim' } };
}

return plugins
