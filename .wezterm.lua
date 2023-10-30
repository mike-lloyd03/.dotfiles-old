local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.hide_tab_bar_if_only_one_tab = true

config.color_scheme = "One Dark (Gogh)"

config.colors = {
    foreground = "#a0a8b7",
    background = "#1a1c23",
}

return config
