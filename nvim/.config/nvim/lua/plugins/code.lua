return {
  {"numToStr/Comment.nvim", lazy = false, opts = {}},

  {
    'hrsh7th/nvim-cmp';
    dependencies = {
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},
      {'ray-x/cmp-treesitter'},
    }
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim",
    },
    opts = {
      ensure_installed = {
        'lua_ls',
        'rust_analyzer',
        'ts_ls',
        'eslint',
        -- 'gopls',
        -- 'golangci_lint_ls',
      }
    }
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {},
  },
};
