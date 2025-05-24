local plugins = {
  "folke/lazy.nvim";

  {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate", event = "BufEnter", lazy = false};
  {"nvim-treesitter/nvim-treesitter-context", lazy = false};
  {"nvim-treesitter/nvim-treesitter-textobjects", lazy = false};

  {"numToStr/Comment.nvim", lazy = false, config = function()
    require("Comment").setup()
  end};

  {"kylechui/nvim-surround", event = "VeryLazy", config = function()
    require('nvim-surround').setup({});
  end};

  {'nvim-telescope/telescope.nvim', tag = '0.1.4', dependencies = { 'nvim-lua/plenary.nvim' } };
  {'nvim-telescope/telescope-dap.nvim', dependencies = { 'mfussenegger/nvim-dap' } };

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  };

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

  { "stevearc/dressing.nvim", opts = {} },

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

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = require('plugins.lualine')
  };

  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  };

  {
    'hrsh7th/nvim-cmp';
    dependencies = {
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},
      {'ray-x/cmp-treesitter'},
      {'L3MON4D3/LuaSnip'},
    }
  };

  {
    'mireq/luasnip-snippets',
    dependencies = {'L3MON4D3/LuaSnip'},
    init = function()
      -- Mandatory setup function
      require('luasnip_snippets.common.snip_utils').setup()
    end
  },

  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    build = "make install_jsregexp",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    init = function()
      local ls = require('luasnip')
      ls.setup({
        -- Required to automatically include base snippets, like "c" snippets for "cpp"
        load_ft_func = require('luasnip_snippets.common.snip_utils').load_ft_func,
        ft_func = require('luasnip_snippets.common.snip_utils').ft_func,
        -- To enable auto expansin
        enable_autosnippets = true,
        -- Uncomment to enable visual snippets triggered using <c-x>
        -- store_selection_keys = '<c-x>',
      })
      -- LuaSnip key bindings
      vim.keymap.set({"i", "s"}, "<Tab>", function() if ls.expand_or_jumpable() then ls.expand_or_jump() else vim.api.nvim_input('<C-V><Tab>') end end, {silent = true})
      vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})
      vim.keymap.set({"i", "s"}, "<C-E>", function() if ls.choice_active() then ls.change_choice(1) end end, {silent = true})
    end
  },

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
