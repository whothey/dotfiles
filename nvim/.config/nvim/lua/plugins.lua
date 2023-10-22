local plugins = {
  "folke/lazy.nvim";

  {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate", event = "BufRead", lazy = false};
  {"nvim-treesitter/nvim-treesitter-context", lazy = false};
  "nvim-treesitter/nvim-treesitter-textobjects";

  {"numToStr/Comment.nvim", lazy = false, config = function()
    require("Comment").setup()
  end};

  {"roy2220/easyjump.tmux", lazy = false};

  {"kylechui/nvim-surround", event = "VeryLazy", config = function()
    require('nvim-surround').setup({});
  end};
  {"windwp/nvim-autopairs", event = "InsertEnter", config = function()
    require('nvim-autopairs').setup({});
  end};

  {'nvim-telescope/telescope.nvim', tag = '0.1.2', dependencies = { 'nvim-lua/plenary.nvim' } };

  "williamboman/mason.nvim";
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "mfussenegger/nvim-dap";
  {
    'hrsh7th/nvim-cmp';
    dependencies = {
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},
    }
  };
}

return plugins
