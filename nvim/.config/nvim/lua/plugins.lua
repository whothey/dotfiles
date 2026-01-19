return {
  "folke/lazy.nvim";
  {"williamboman/mason.nvim", lazy = false};
  "williamboman/mason-lspconfig.nvim",

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

  { "lewis6991/gitsigns.nvim" };
}
