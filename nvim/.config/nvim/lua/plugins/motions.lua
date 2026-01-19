return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {}
  },

  {
    "gbprod/substitute.nvim";
    opts = {
      highlight_substituted_text = {
        enabled = true,
        timer = 500,
      };
    };
  },

  -- {
  --   'windwp/nvim-autopairs',
  --   event = "InsertEnter",
  --   opts = {
  --     enable_abbr = true,
  --   }
  -- };
};
