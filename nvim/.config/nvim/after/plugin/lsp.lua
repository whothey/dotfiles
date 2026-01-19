local cmp = require('cmp');
local mason = require('mason');
local masonlsp = require('mason-lspconfig');

local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
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
    vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>lsf", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  end
})

mason.setup();

masonlsp.setup({
  ensure_installed = {
    'lua_ls',
    'rust_analyzer',
    'ts_ls',
    'eslint',
    'gopls',
  }
});

vim.diagnostic.config({
    virtual_text = true
})
