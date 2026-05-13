local terminal = "kitty"

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprpanel")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("kdeconnectd")
end)
