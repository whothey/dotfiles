local dap = require('dap');
local masondap = require('mason-nvim-dap');

local js_map_configs = {
  ["pwa-node"] = {
    configurations = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Node: Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Node: Attach",
        processId = require'dap.utils'.pick_process,
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Node: Debug Mocha Test",
        -- trace = true, -- include debugger info
        program = "${file}",
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/.bin/mocha",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
      }
    },
    filetypes = { 'javascript', 'typescript' },
  },
  ["node-terminal"] = {
    configurations = {
      {
        type = "node-terminal",
        request = "launch",
        name = "Start debugging terminal",
        cwd = "${workspaceFolder}",
      }
    },
    filetypes = { 'javascript', 'typescript' },
  }
}

dap.defaults.fallback.switchbuf = 'usetab';
dap.defaults.fallback.terminal_win_cmd = 'belowright new'

masondap.setup({
  ensure_installed = { 'js' };
  handlers = {
    function(config)
      masondap.default_setup(config);
    end;

    js = function(config)
      local base_config = vim.deepcopy(config);

      local js_adapter = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = vim.fn.exepath('js-debug-adapter'),
          args = { "${port}" }
        }
      }

      for name, adapter_setup in pairs(js_map_configs) do
        local adapter_config = vim.deepcopy(base_config);

        adapter_config.name = name
        adapter_config.adapters = js_adapter;
        adapter_config.filetypes = adapter_setup.filetypes;
        adapter_config.configurations = adapter_setup.configurations;

        masondap.default_setup(adapter_config);
      end
    end
  }
})

vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dB', function() dap.set_breakpoint() end)
vim.keymap.set('n', '<Leader>dlp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
vim.keymap.set('n', '<Leader>dcr', function()
  require('dap.ext.vscode').load_launchjs(nil, { });
  vim.notify "Reloaded vscode configs"
end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')

  widgets.centered_float(widgets.scopes)
end)

vim.keymap.set('n', '<Leader>dut', function() 
  require('dapui').toggle()
end)

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='🖹', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='➡️', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='🔁', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='❗', texthl='', linehl='', numhl=''})
