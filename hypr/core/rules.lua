hl.config({
  xwayland = {
    force_zero_scaling = true,
  },
})

hl.window_rule({
  name = "suppress-maximize",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name = "fix-xwayland",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
  },
  no_focus = true,
})
