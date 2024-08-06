local wezterm = require("wezterm")
local config = wezterm.config_builder()

 config = {
  automatic_config_reload = true,
  color_scheme = "Catppuccin Mocha",
  enable_tab_bar = false,
  window_decorations = "RESIZE",
}

return config

