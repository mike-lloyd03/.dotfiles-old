local light_colors = {
    bg0 = "#fafafa",
    bg1 = "#f0f0f0",
    bg2 = "#e6e6e6",
    bg3 = "#dcdcdc",
    bg_d = "#c9c9c9",
    purple = "#a626a4",
    green = "#50a14f",
    orange = "#c18401",
    blue = "#4078f2",
    yellow = "#986801",
    cyan = "#0184bc",
    red = "#e45649",
}

-- Color scheme config
require("onedark").setup({
    style = "deep",
    toggle_style_key = "<leader>ts",
    -- toggle_style_list = { "dark", "light" },
    highlights = {
        -- NormalFloat = { fg = "$fg", bg = "$bg2" },
        -- FloatBorder = { fg = "$grey", bg = "$bg0" },
        MatchParen = { fg = "$red", bg = "$none", fmt = "underline" },
        -- Pmenu = { fg = "$fg", bg = "$bg2" },
        -- PmenuSel = { fg = "$bg0", bg = "$bg_blue" },
        -- Search = { fg = "$bg0", bg = "$light_grey" },

        TSKeyword = { fg = "$red" },
        TSInclude = { fg = "$red" },
        TSFuncMacro = { fg = "$red" },
        TSOperator = { fg = "$purple" },
        TSParameter = { fg = "$cyan" },
        TSNamespace = { fg = "$blue" },

        TelescopeBorder = { fg = "$light_grey" },
        TelescopePromptBorder = { fg = "$light_grey" },
        TelescopeResultsBorder = { fg = "$light_grey" },
        TelescopePreviewBorder = { fg = "$light_grey" },
        TelescopeMatching = { fg = "$orange", fmt = "bold" },
        TelescopePromptPrefix = { fg = "$red" },

        DiagnosticError = { fg = "$red" },
        DiagnosticHint = { fg = "$purple" },
        DiagnosticInfo = { fg = "$blue" },
        DiagnosticWarn = { fg = "$yellow" },
    },
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        -- background = true, -- use background color for virtual text
    },
})
require("onedark").load()
