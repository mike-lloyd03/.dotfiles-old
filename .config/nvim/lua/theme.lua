-- Color scheme config
require("onedark").setup({
    style = "dark",
    colors = {
        green = "#88D988",
        blue = "#00B6FF",
        cyan = "#56B6C2",
        orange = "#DC8A61",
        red = "#FF618A",
        purple = "#DB61DB",
        yellow = "#D7AF87",
        bg0 = "#1a1c23", -- main bg
        bg1 = "#303030", -- active row bg
        bg2 = "#393f4a", -- nothing
        bg3 = "#3b3f4c", -- dividers and light gray status line bg
        bg_d = "#21252b", -- dark background
        bg_blue = "#00afff",
    },
    highlights = {
        Function = { fg = "$blue" },
        Keyword = { fg = "$red" },
        Include = { fg = "$blue" },
        NormalFloat = { fg = "$fg", bg = "$bg2" },
        FloatBorder = { fg = "$grey", bg = "$bg0" },
        MatchParen = { fg = "$red", bg = "$none", fmt = "underline" },
        Pmenu = { fg = "$fg", bg = "$bg2" },
        PmenuSel = { fg = "$bg0", bg = "$bg_blue" },
        Search = { fg = "$bg0", bg = "$light_grey" },
        Operator = { fg = "$purple" },

        TSKeyword = { fg = "$red" },
        TSInclude = { fg = "$red" },
        TSFuncMacro = { fg = "$red" },
        TSOperator = { fg = "$purple" },
        TSParameter = { fg = "$light_grey" },
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
})
require("onedark").load()
vim.opt.termguicolors = true
