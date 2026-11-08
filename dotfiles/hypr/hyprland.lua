local mainMod = "SUPER"
local terminal = "ghostty"
local fileManager = "yazi"
local menu = "noctalia-shell msg launcher toggle"

hl.env("QT_QPA_PLATFORMTHEME", "hyprqt6engine")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")

hl.config({
    general = {
        border_size = 0,
        gaps_out = 1,
        resize_on_border = true,
    },
    input = {
        kb_layout = "us,ru",
        kb_options = "grp:alt_shift_toggle",
        sensitivity = 0.3,
        accel_profile = "flat",
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@60",
    position = "0x0",
    scale = 1,
})

hl.device({
    name = "razer-razer-basilisk-v3",
    sensitivity = 0.6,
    accel_profile = "flat",
})

hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia-shell")
end)

-- Apps
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("AyuGram"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("kate"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("zeditor"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("Discord"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("code"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("yandex-music"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("/home/pavelzaikin/Downloads/osu.AppImage"))
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"), { description = "Lock screen" })

-- Workspaces
for i = 1, 2 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Trackpad gestures
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "up", action = "close" })
hl.gesture({ fingers = 3, direction = "down", action = function() hl.exec_cmd(terminal) end })

-- Mouse: Super+left drag resizes; Super+right drag moves.
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.drag(), { mouse = true })

-- Audio controls work while the screen is locked too.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
