-- Color scheme config
require("onedark").setup({
    style = "deep",
    toggle_style_key = "<leader>ts",
    -- toggle_style_list = { "dark", "light" },
    highlights = {
        MatchParen = { fg = "$red", bg = "$none", fmt = "underline" },

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
