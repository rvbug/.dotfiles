local wezterm = require("wezterm")
local config = wezterm.config_builder()

 config = {
  -- automatic_reload_config = true,
  -- color_scheme = "Catppuccin Mocha",
  color_scheme = "Nord (base16)",
  enable_tab_bar = false,
  window_decorations = "RESIZE",
  default_cursor_style = "BlinkingBar",
  -- font = wezterm.font("font-go-mono-nerd-font"),
  font_size = 12.5,
  -- inital size of the window
  initial_rows = 50,
  initial_cols = 200,

  -- audio bell 
  audible_bell = "Disabled",

}

return config

