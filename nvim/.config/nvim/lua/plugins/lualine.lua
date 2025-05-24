return {
  options = {
    icons_enabled = true,
    theme = 'auto',
    always_show_bufferline = false,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = true,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
    },
    lualine_c = {
      function()
        return vim.fn.fnamemodify('.', ':~')
      end
    },
    lualine_x = {'branch', 'diff'},
    lualine_y = {'diagnostics'},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
      {
        'tabs',
        mode = 1,
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {'encoding', 'fileformat', 'filetype', 'lsp_status'},
    lualine_z = {'location'}
  },
  winbar = {},
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'location'}
  },
  extensions = {}
}
