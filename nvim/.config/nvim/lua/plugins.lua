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
  "nvim-treesitter/nvim-treesitter-textobjects";
  "kylechui/nvim-surround";
  "windwp/nvim-autopairs";
  {'nvim-telescope/telescope.nvim', tag = '0.1.2', dependencies = { 'nvim-lua/plenary.nvim' } };
  "mfussenegger/nvim-dap";
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 };
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},

        -- Snippets
        {'L3MON4D3/LuaSnip'},
        {'rafamadriz/friendly-snippets'},
    }
  }
}

return plugins
