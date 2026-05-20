hl.config({
  general = {
    gaps_in = 2,
    -- gaps_out = 5,
    gaps_out = {
      top = 3,
      bottom = 5,
      left = 5,
      right = 5,
    },
    border_size = 2,
    col = {
      active_border = { colors = { "rgba(b4befecc)", "rgba(cdd6f4cc)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },
    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
  },

  decoration = {
    rounding = 8,
    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = false,
    },

    blur = {
      enabled = false,
      size = 5,
      passes = 2,
      vibrancy = 0.1696,
    },
  },
})
