return {
  {'nvim-telescope/telescope.nvim', tag = '0.1.4', dependencies = { 'nvim-lua/plenary.nvim' } };

  { 'stevearc/dressing.nvim', opts = {} },

  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    keys = {
      { '<leader>ef', function() vim.cmd.edit(vim.fn.expand('%:h')) end, desc = "Edit filetree of current file" },
      { '<leader>et', function() vim.cmd.edit('.') end, desc = "Edit filetree from root dir" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  };
}
