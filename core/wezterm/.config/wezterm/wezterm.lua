local wezterm = require("wezterm")
local config = wezterm.config_builder()

 config = {
  color_scheme = "Tokyo Night",
  enable_tab_bar = false,
  window_decorations = "RESIZE",
  default_cursor_style = "BlinkingBar",
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 14.5,

  -- inital size of the window
  initial_rows = 50,
  initial_cols = 200,

  -- audio bell 
  audible_bell = "Disabled",

  keys = {
    {
      key = 'A',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.QuickSelect,
    },
  },


}

return config




  -- automatic_reload_config = true,
  -- color_scheme = "Catppuccin Mocha",
  -- color_scheme = "Dracula",
  -- font = wezterm.font("font-go-mono-nerd-font"),

  -- using aerospace so no need for FullScreen mode
  -- keys = {
  --   key = 'n',
  --   mods = 'SHIFT|CTRL',
  --   action = wezterm.action.ToggleFullScreen,
  -- }


  -- font = wezterm.font_with_fallback({
  --   "JetBrains Mono Nerd Font",
  --   "JetBrains Mono",
  --   "MesloLGS NF",
  -- }),
  -- font = wezterm.font("JetBrains Mono"),

