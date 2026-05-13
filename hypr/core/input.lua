hl.config({
  input = {
    kb_layout = "us",
    follow_mouse = 1,
    sensitivity = 0,
    kb_options = "caps:escape",

    touchpad = {
      natural_scroll = true,
    },
  },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "vertical", action = "special" })
hl.gesture({ fingers = 4, direction = "vertical", action = "close" })
