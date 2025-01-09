local wezterm = require("wezterm")
local config = wezterm.config_builder()

 config = {
  -- automatic_reload_config = true,
  -- color_scheme = "Catppuccin Mocha",
  -- color_scheme = "Nord (base16)",
  color_scheme = "Dracula",
  enable_tab_bar = false,
  window_decorations = "RESIZE",
  default_cursor_style = "BlinkingBar",
  -- font = wezterm.font("font-go-mono-nerd-font"),
  -- font = wezterm.font("MesloLGS NF"),
  font = wezterm.font_with_fallback({
    "JetBrains Mono",
    "MesloLGS NF",
  }),
  -- font = wezterm.font("JetBrains Mono"),
  font_size = 14.5,
  -- inital size of the window
  initial_rows = 50,
  initial_cols = 200,

  -- audio bell 
  audible_bell = "Disabled",

}

return config
