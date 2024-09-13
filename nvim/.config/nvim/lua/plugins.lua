local plugins = {
  "folke/lazy.nvim";

  {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate", event = "BufEnter", lazy = false};
  {"nvim-treesitter/nvim-treesitter-context", lazy = false};
  {"nvim-treesitter/nvim-treesitter-textobjects", lazy = false};

  {"numToStr/Comment.nvim", lazy = false, config = function()
    require("Comment").setup()
  end};

  {"roy2220/easyjump.tmux", lazy = false};

  {"kylechui/nvim-surround", event = "VeryLazy", config = function()
    require('nvim-surround').setup({});
  end};
  -- {"windwp/nvim-autopairs", event = "InsertEnter", config = function()
  --   require('nvim-autopairs').setup({});
  -- end};

  {'nvim-telescope/telescope.nvim', tag = '0.1.4', dependencies = { 'nvim-lua/plenary.nvim' } };
  {'nvim-telescope/telescope-dap.nvim', dependencies = { 'mfussenegger/nvim-dap' } };

  {
    'cameron-wags/rainbow_csv.nvim',
    config = true,
    ft = {
        'csv',
        'tsv',
        'csv_semicolon',
        'csv_whitespace',
        'csv_pipe',
        'rfc_csv',
        'rfc_semicolon'
    },
    cmd = {
        'RainbowDelim',
        'RainbowDelimSimple',
        'RainbowDelimQuoted',
        'RainbowMultiDelim'
    }
  };

  {"williamboman/mason.nvim", lazy = false, config = function()
    require('mason').setup()
  end};
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  {"mfussenegger/nvim-dap", lazy = false};
  "jay-babu/mason-nvim-dap.nvim",
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require('dapui').setup({})
    end,
    dependencies = { "nvim-neotest/nvim-nio" }
  };

  -- Themes
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 };

  { "lewis6991/gitsigns.nvim" };

  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } };
  { 'kkoomen/vim-doge', run = ':call doge#install()' };

  {
    'hrsh7th/nvim-cmp';
    dependencies = {
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},
      {'ray-x/cmp-treesitter'},
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp"
      }
    }
  };

  {
    "gbprod/substitute.nvim";
    opts = {
      highlight_substituted_text = {
        enabled = true,
        timer = 500,
      };
    };
  };
}

return plugins
