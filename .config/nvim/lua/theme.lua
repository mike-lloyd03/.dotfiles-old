-- Color scheme config
require("onedark").setup({
    style = "deep",
    toggle_style_key = "<leader>ts",
    -- toggle_style_list = { "dark", "light" },
    colors = {
        light_blue = "#0888f1",
    },
    lualine = {
        transparent = true,
    },
    highlights = {
        MatchParen = { fg = "$red", bg = "$none", fmt = "underline" },

        TelescopeBorder = { fg = "$light_grey" },
        TelescopePromptBorder = { fg = "$light_grey" },
        TelescopeResultsBorder = { fg = "$light_grey" },
        TelescopePreviewBorder = { fg = "$light_grey" },
        TelescopeMatching = { fg = "$orange", fmt = "bold" },
        TelescopePromptPrefix = { fg = "$red" },

        CurSearch = { bg = "$blue" },
        IncSearch = { bg = "$blue" },
        Search = { bg = "$light_blue" },
    },
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = false, -- use undercurl instead of underline for diagnostics
        -- background = true, -- use background color for virtual text
    },
})
require("onedark").load()
