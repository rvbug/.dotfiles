local wezterm = require("wezterm")
local config = wezterm.config_builder()

 config = {
  -- automatic_reload_config = true,
  color_scheme = "Catppuccin Mocha",
  enable_tab_bar = false,
  window_decorations = "RESIZE",
  default_cursor_style = "BlinkingBar",
  -- font = wezterm.font("font-go-mono-nerd-font"),
  font_size = 12.5,

}

return config

