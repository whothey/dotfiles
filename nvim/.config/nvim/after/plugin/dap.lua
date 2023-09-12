  local dap = require('dap')

  dap.configurations.node = {
    {
      type = 'node';
      request = 'launch';
      name = "Launch file";
      program = "${file}";
      pythonPath = function()
        return '/usr/bin/python'
      end;
    },
  }
