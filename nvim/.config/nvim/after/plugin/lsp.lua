local cmp = require('cmp');
local mason = require('mason');
local masonlsp = require('mason-lspconfig');
local lspconfig = require('lspconfig');

local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body);
    end
  };

  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<S-Tab>'] = nil,
    ['<C-Space>'] = cmp.mapping.complete(),
  });

  sorting = {
    comparators = {
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.offset,
      -- cmp.config.compare.exact,
      -- cmp.config.compare.recently_used,
      -- cmp.config.compare.sort_text,
    }
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'treesitter' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keywork_length = 3 },
  });

formatting = {
    format = function(entry, vim_item)
      if entry.source.name == 'nvim_lsp' then
        vim_item.dup = 0
      end

      return vim_item
    end
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gDh", function()
      vim.cmd('vsplit');
      vim.lsp.buf.definition();
    end, opts)
    vim.keymap.set("n", "gDl", function()
      vim.cmd('vsplit');
      vim.cmd('wincmd l');
      vim.lsp.buf.definition();
    end, opts)
    vim.keymap.set("n", "gDk", function()
      vim.cmd('split');
      vim.lsp.buf.definition();
    end, opts)
    vim.keymap.set("n", "gDj", function()
      vim.cmd('split');
      vim.cmd('wincmd j');
      vim.lsp.buf.definition();
    end, opts)
    vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  end
})

mason.setup();

masonlsp.setup({
  ensure_installed = {
    'lua_ls',
    'rust_analyzer',
    'tsserver',
    'eslint',
    'gopls',
  }
});

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

masonlsp.setup_handlers({
  function(server_name)
    local settings = {
      capabilities = lsp_capabilities,
    };

    lspconfig[server_name].setup(settings)
  end,
})

vim.diagnostic.config({
    virtual_text = true
})
