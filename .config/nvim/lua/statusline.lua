----------------------------
-- Lualine config
----------------------------
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
      lualine_a = {{'mode', color = {gui='bold'}}},
    lualine_b = {
        'branch',
        },
    lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,
            },
            {
                'diagnostics',
                symbols = {error = ' ', warn = ' '}
            }
    },
    lualine_x = {
        '%{ObsessionStatus("tracking", "paused")}',
        'encoding',
        'fileformat',
        {'filetype', colored = false}
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
            {
                'filename',
                path = 1,
            }
        },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
      },
  extensions = {}
}
