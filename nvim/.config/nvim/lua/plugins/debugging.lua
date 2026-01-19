return {
  {
    'mfussenegger/nvim-dap',
    lazy = false,
    config = function()
      local dap = require('dap');

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.exepath("codelldb"),
          args = { "--port", "${port}" },
        },
      }

      dap.adapters['pwa-node'] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = vim.fn.exepath('js-debug-adapter'),
          args = { "${port}" }
        }
      };


      dap.configurations.zig = {
        {
          name = 'Launch',
          type = 'codelldb',
          request = 'launch',
          program = function(cb)
            local exe_files = vim.fn.glob(vim.fn.getcwd() .. '**/zig-out/**/*', false, true);
            local options = { prompt = "Select executable", kind="file" };
            vim.ui.select(exe_files, options, cb);
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      };

      local js_configs = {
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
        },
      };

      dap.configurations.javascript = js_configs;
      dap.configurations.typescript = js_configs;

      dap.defaults.fallback.switchbuf = 'useopen,usetab,newtab';
      dap.defaults.fallback.terminal_win_cmd = 'belowright vertical new'

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
        require('dap-view').toggle()
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

      vim.api.nvim_create_autocmd("QuickFixCmdPost", {
        pattern = "make",
        callback = function()
          -- Check if make command was successful (no errors in quickfix list)
          local qf_list = vim.fn.getqflist()
          if #qf_list == 0 then
            -- Restart debug session if one exists
            if dap.session() then
              vim.notify("Trying restart debug session after successful make", vim.log.levels.INFO)
              dap.restart()
            end
          end
        end,
        desc = "Restart debug session after successful make command"
      })
    end,
  };

  { 'nvim-telescope/telescope-dap.nvim', dependencies = { 'nvim-telescope/telescope.nvim' } };

  { 'theHamsta/nvim-dap-virtual-text', dependencies = { 'nvim-treesitter/nvim-treesitter' } };

  {
    "igorlfs/nvim-dap-view",
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
  };
};
