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
          "-t",
          "0",
          "--exit"
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

dap.defaults.fallback.switchbuf = 'useopen,usetab,newtab';
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

vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "Debug - Continue" })
vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = "Debug - Step over" })
vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = "Debug - Step into" })
vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = "Debug - Step out" })
vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end, { desc = "Debug - Toggle Breakpoint" })
vim.keymap.set('n', '<Leader>dB', function() dap.set_breakpoint(vim.fn.input('Expression: ')) end, { desc = "Debug - Toggle breakpoint with expression" })
vim.keymap.set("n", "<leader>dE", function() dap.set_exception_breakpoints({ "Warning", "Error", "Exception" }) end, { desc = "Debug - Stop on exceptions" })
vim.keymap.set("n", "<leader>dA", function() dap.set_exception_breakpoints({ "Notice", "Warning", "Error", "Exception" }) end, { desc = "Debug - Stop on all" })
vim.keymap.set('n', '<Leader>dlp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = "Debug - Log point message"})
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end, { desc = "Debug - Open REPL" })
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { desc = "Debug - Run last config" })
vim.keymap.set('n', '<Leader>dcr', function()
  require('dap.ext.vscode').load_launchjs(nil, { });
  vim.notify "Reloaded vscode configs"
end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end, { desc = "Debug - Hover debug value for symbol" })
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end, { desc = "Debug - Preview symbol value in a separate buffer" })
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, { desc = "Debug - Stack frames" })
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')

  widgets.centered_float(widgets.scopes)
end, { desc = "Debug - Stack Scopes" })
vim.keymap.set('n', '<Leader>dS', function()
  local widgets = require('dap.ui.widgets')

  widgets.centered_float(widgets.sessions)
end, { desc = "Debug - Stack sessions" })

vim.keymap.set('n', '<Leader>dut', function()
  require('dapui').toggle()
end, { desc = "Debug - Toggle UI" })

vim.fn.execute('highlight Breakpoint guifg=#ff0000')
vim.fn.execute('highlight RejectedBreakpoint guifg=#808080')

vim.fn.sign_define('DapBreakpoint', {text='', texthl='Breakpoint', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='󱂅', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='➡️', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='Breakpoint', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='RejectedBreakpoint', linehl='', numhl=''})

---@param dir "next"|"prev"
local function gotoBreakpoint(dir)
	local breakpoints = require("dap.breakpoints").get()
	if #breakpoints == 0 then
		vim.notify("No breakpoints set", vim.log.levels.WARN)
		return
	end
	local points = {}
	for bufnr, buffer in pairs(breakpoints) do
		for _, point in ipairs(buffer) do
			table.insert(points, { bufnr = bufnr, line = point.line })
		end
	end

	local current = {
		bufnr = vim.api.nvim_get_current_buf(),
		line = vim.api.nvim_win_get_cursor(0)[1],
	}

	local nextPoint
	for i = 1, #points do
		local isAtBreakpointI = points[i].bufnr == current.bufnr and points[i].line == current.line
		if isAtBreakpointI then
			local nextIdx = dir == "next" and i + 1 or i - 1
			if nextIdx > #points then nextIdx = 1 end
			if nextIdx == 0 then nextIdx = #points end
			nextPoint = points[nextIdx]
			break
		end
	end
	if not nextPoint then nextPoint = points[1] end

	vim.cmd(("buffer +%s %s"):format(nextPoint.line, nextPoint.bufnr))
end

vim.keymap.set("n", "]b", function() gotoBreakpoint("next") end, { desc = "Go to next breakpoint" })
vim.keymap.set("n", "[b", function() gotoBreakpoint("prev") end, { desc = "Go to previous breakpoint" })
