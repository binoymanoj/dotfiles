local mainMod = "SUPER"
local terminal = "kitty"
local browser = "helium-browser"
local fileManager = "nautilus"
local musicPlayer = "spotify" -- adjust if needed

-- Core applications
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("~/.config/hypr/scripts/main-menu.sh"))
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd("~/.config/hypr/scripts/keymap-menu.sh"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Z", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + CTRL + P", hl.dsp.window.pin())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = 1 }))

-- Rofi / menus
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("rofi -show emoji"))
hl.bind("ALT + space", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/rofi-smart-run.sh"))
hl.bind("ALT + R", hl.dsp.exec_cmd("rofi -show run"))
hl.bind("ALT + TAB", hl.dsp.exec_cmd("rofi -show window"))

-- Power and system
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("~/.config/hypr/scripts/power-menu.sh"))
hl.bind(mainMod .. " + SHIFT + p", hl.dsp.exec_cmd("keepassxc"))

-- Clipboard manager
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -p 'Clipboard' | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + SHIFT + V",
  hl.dsp.exec_cmd("cliphist list | rofi -dmenu -p 'Delete from clipboard' | cliphist delete"))
hl.bind(mainMod .. " + SHIFT + ALT + V", hl.dsp.exec_cmd("cliphist wipe"))

-- Media player controls
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(musicPlayer))
hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.exec_cmd("mpc toggle"))
hl.bind(mainMod .. " + ALT + left", hl.dsp.exec_cmd("mpc prev"))
hl.bind(mainMod .. " + ALT + right", hl.dsp.exec_cmd("mpc next"))
hl.bind(mainMod .. " + ALT + h", hl.dsp.exec_cmd("mpc prev"))
hl.bind(mainMod .. " + ALT + l", hl.dsp.exec_cmd("mpc next"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("mpc next"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("mpc toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("mpc toggle"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("mpc prev"))

-- Volume controls
hl.bind(mainMod .. " + ALT + up", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind(mainMod .. " + ALT + down", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind(mainMod .. " + ALT + j", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind(mainMod .. " + ALT + k", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind(mainMod .. " + ALT + D", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

-- Brightness controls
hl.bind(mainMod .. " + ALT + equal", hl.dsp.exec_cmd("brightnessctl s 5%+"))
hl.bind(mainMod .. " + ALT + minus", hl.dsp.exec_cmd("brightnessctl s 5%-"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"))

-- Night light and system controls
hl.bind(mainMod .. " + ALT + N", hl.dsp.exec_cmd("~/.config/hypr/scripts/hyprsunset.sh toggle"))
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd("~/.config/hypr/scripts/caffeine.sh toggle"))
hl.bind(mainMod .. " + ALT + O", hl.dsp.exec_cmd("systemctl suspend"))

-- Focus movement (hjkl)
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Focus movement (arrow keys)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move windows (hjkl)
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Move windows (arrow keys)
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Resize windows (hjkl)
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.resize({ x = -20, y = 0 }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.resize({ x = 20, y = 0 }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.resize({ x = 0, y = -20 }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.resize({ x = 0, y = 20 }))

-- Resize windows (arrow keys)
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -20, y = 0 }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 20, y = 0 }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -20 }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 20 }))

-- Other useful bindings
hl.bind("ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("hyprpanel -q; hyprpanel"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("hyprpanel -q"))
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper-selector.sh"))
hl.bind("CTRL + SHIFT + ESCAPE", hl.dsp.exec_cmd("gnome-system-monitor"))

-- Workspace switching (1-10)
for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
  hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i, silent = true }))
end

-- Special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special({ name = "magic" }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move workspace between monitors
-- hl.bind(mainMod .. " + ALT + bracketleft", hl.dsp.workspace.move_to_monitor({ direction = "left" }))
-- hl.bind(mainMod .. " + ALT + bracketright", hl.dsp.workspace.move_to_monitor({ direction = "right" }))

-- Scroll through workspaces
-- hl.bind(mainMod .. " + mouse_down", hl.dsp.workspace.cycle({ offset = 1 }))
-- hl.bind(mainMod .. " + mouse_up", hl.dsp.workspace.cycle({ offset = -1 }))

-- Move workspace using SHIFT+ALT + H/L
-- hl.bind("SHIFT + ALT + H", hl.dsp.workspace.cycle({ offset = -1 }))
-- hl.bind("SHIFT + ALT + L", hl.dsp.workspace.cycle({ offset = 1 }))
-- hl.bind("SHIFT + ALT + left", hl.dsp.workspace.cycle({ offset = -1 }))
-- hl.bind("SHIFT + ALT + right", hl.dsp.workspace.cycle({ offset = 1 }))

-- Mouse bindings for window management
-- hl.bind(mainMod .. " + mouse:272", hl.dsp.window.move_with_mouse())
-- hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize_with_mouse())

-- Screenshot bindings
hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
hl.bind(mainMod .. " + Print",
  hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +'%Y%m%d_%H%M%S').png"))
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))

-- OBS passthrough
-- hl.bind(mainMod .. " + F10", hl.dsp.window.pass({ class = "^(com\\.obsproject\\.Studio)$" }))
