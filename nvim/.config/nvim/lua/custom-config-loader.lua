M = {}

local custom_loaded_config_names = {};

local function clearLoadedConfigs()
  local dap = require('dap');

  for _, configs in pairs(dap.configurations) do
    for _, addedName in pairs(custom_loaded_config_names) do
      for iconfig, config in pairs(configs) do
        if (config.name == addedName) then
          table.remove(configs, iconfig);
        end
      end
    end
  end
end

local function reload_config()
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

-- Loads custom configs similar to .vscode folder
vim.api.nvim_create_autocmd({'DirChanged', 'VimEnter'}, {
  desc = 'Custom config loader for directories',
  callback = reload_config,
});

vim.keymap.set("n", "<Leader>cr", reload_config, { desc = "Reload custom configs" })
vim.keymap.set("n", "<Leader>cR", function()
  clearLoadedConfigs();
  reload_config();
end, { desc = "Clear and reload custom configs" })

M.dap_add_config = function(type, config)
  local dap = require('dap');

  for _, v in ipairs(dap.configurations[type]) do
    if (v.name == config.name) then
      return;
    end
  end

  table.insert(custom_loaded_config_names, config.name)
  table.insert(dap.configurations[type], config)
end

return M;
