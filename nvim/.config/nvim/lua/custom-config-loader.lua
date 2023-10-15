-- Loads custom configs similar to .vscode folder
vim.api.nvim_create_autocmd({'BufRead', 'BufCreate'}, {
  desc = 'Custom config for files',
  callback = function()
    local sep = "/";
    local current_dir = vim.fn.getcwd();
    local paths = vim.fn.split(current_dir, sep);

    while #paths ~= 0 do
      local current_base = sep .. vim.fn.join(paths, sep)
      local current_test = current_base .. "/.whothey";

      if vim.fn.isdirectory(current_test) == 1 then
        local current_init = current_test .. "/init.lua";

        if not pcall(dofile, current_init) then
          vim.notify("Failed to load custom script " .. current_init)
        end
      end

      table.remove(paths, #paths)
    end
  end
})

