require('gitsigns').setup({
  current_line_blame = true;

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>gs', gs.stage_hunk, { desc = "Git stage hunk" })
    map('n', '<leader>gr', gs.reset_hunk, { desc = "Git reset hunk" })
    map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Git stage hunk (Visual Mode)" })
    map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Git reset hunk (Visual Mode)" })
    map('n', '<leader>gS', gs.stage_buffer, { desc = "Git stage buffer" })
    map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "Git undo stage" })
    map('n', '<leader>gR', gs.reset_buffer, { desc = "Git reset buffer" })
    map('n', '<leader>gp', gs.preview_hunk, { desc = "Git preview hunk" })
    map('n', '<leader>gb', function() gs.blame_line{full=true} end, { desc = "Git blame line" })
    map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = "Git toggle blame line" })
    map('n', '<leader>gd', gs.diffthis, { desc = "Git diff this" })
    map('n', '<leader>gD', function() gs.diffthis('~') end, { desc = "Git diff this ~" })
    map('n', '<leader>gtd', gs.toggle_deleted, { desc = "Git toggle deleted" })

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
});
