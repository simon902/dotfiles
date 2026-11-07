local vars = require("variables")

hl.config({
    input = {
        kb_layout          = "de",
        numlock_by_default = false,
        repeat_delay       = 250,
        repeat_rate        = 35,
        focus_on_close     = 1,

        touchpad           = {
            natural_scroll       = false,
            disable_while_typing = vars.touchpadDisableTyping,
            scroll_factor        = vars.touchpadScrollFactor,
        },
    },

    binds = {
        scroll_event_delay = 0,
    },

    cursor = {
        hotspot_padding = 1,
    },
})

-- Per mouse pointer speed (-1 to 1, names from `hyprctl devices`)
hl.device({
    name        = "logitech-mx-vertical-1",
    sensitivity = -0.2,
})
