local wezterm = require("wezterm")
local config = wezterm.config_builder()

 config = {
  -- color_scheme = "Kanagawa (Gogh)",
  color_scheme = 'Kanagawa (Gogh)',
  enable_tab_bar = false,
  window_decorations = "RESIZE",
  default_cursor_style = "BlinkingBar",
  font = wezterm.font("Geist Mono"),
  font_size = 14.5,

  -- inital size of the window
  initial_rows = 70,
  initial_cols = 210,

  -- audio bell
  audible_bell = "Disabled",

  -- keys = {
  --   {
  --     key = 'A',
  --     mods = 'CTRL|SHIFT',
  --     action = wezterm.action.QuickSelect,
  --   },
  -- },


}

return config
