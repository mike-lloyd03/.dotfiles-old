local function session_status()
    if require('auto-session-library').current_session_name() then
        return "tracking"
    end
    return "no session"
end

----------------------------
-- Lualine config
----------------------------
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {'NvimTree'},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {{'mode', color = {gui='bold'}}},
    lualine_b = {
        {
            'filename',
            file_status = true,
            path = 1,
        },
    },
    lualine_c = {
        'branch',
        {
            'diagnostics',
            symbols = {error = ' ', warn = ' '}
        }
    },
    lualine_x = {
        session_status,
        'encoding',
        'fileformat',
        {'filetype', colored = true}
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
}
