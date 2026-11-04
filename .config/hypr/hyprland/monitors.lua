-- Dynamic workspace layout
--
-- Single monitor: 1-10
-- Double monitor:
--    Main:   6-10
--    Second: 1-5

local vars = require("variables")

-- Per machine monitor setup in hosts/<hostname>.lua
-- Machines without a file keep the default rule from hyprland.lua (preferred, auto, scale 1)
local function read_hostname()
    local f = io.open("/proc/sys/kernel/hostname")
    if not f then return "unknown" end
    local hostname = f:read("l")
    f:close()
    return hostname
end

local function load_host(hostname)
    local file = io.open(os.getenv("HOME") .. "/.config/hypr/hosts/" .. hostname .. ".lua")
    if not file then return {} end
    file:close()
    return require("hosts." .. hostname)
end

local hostname = read_hostname()
local host = load_host(hostname)

-- One monitor or a priority list, the first connected one is the main monitor
local primary_monitors = host.primaryMonitor or {}
if type(primary_monitors) == "string" then
    primary_monitors = { primary_monitors }
end

if #primary_monitors == 0 then
    pcall(hl.notification.create, {
        text    = "No primaryMonitor set in ~/.config/hypr/hosts/" .. hostname .. ".lua, using the first monitor",
        timeout = 10000,
        icon    = 3, -- error
    })
end

for _, monitor in ipairs(host.monitors or {}) do
    hl.monitor(monitor)
end

-- Monitor selector: either a name (eDP-1) or "desc:" followed by the start of its description
local function matches(mon, selector)
    if selector:sub(1, 5) == "desc:" then
        local desc = selector:sub(6)
        return mon.description:sub(1, #desc) == desc
    end
    return mon.name == selector
end

local function pick_primary_secondary(monitors)
    local primary
    for _, selector in ipairs(primary_monitors) do
        for _, mon in ipairs(monitors) do
            if matches(mon, selector) then
                primary = mon
                break
            end
        end
        if primary then break end
    end
    primary = primary or monitors[1]

    local secondary
    for _, mon in ipairs(monitors) do
        if mon.id ~= primary.id then
            secondary = mon
            break
        end
    end

    return primary, secondary
end

local function get_layout_monitors()
    local monitors = hl.get_monitors()
    if #monitors == 0 then return nil end
    if #monitors == 1 then return monitors[1], nil end
    return pick_primary_secondary(monitors)
end

local function target_monitor(id, primary, secondary)
    local position = ((id - 1) % 10) + 1 -- 1-10 within its decade
    return (not secondary or position > 5) and primary or secondary
end

local function apply_workspace_layout()
    local primary, secondary = get_layout_monitors()
    if not primary then return end

    -- Register the rules on which monitor each workspace should live
    for id = 1, vars.maxWorkspace do
        hl.workspace_rule({ workspace = tostring(id), monitor = target_monitor(id, primary, secondary).name })
    end

    -- Whatever already exists (e.g. after a monitor plug/unplug) needs an explicit move
    for _, ws in ipairs(hl.get_workspaces()) do
        if not ws.special and ws.id >= 1 and ws.id <= vars.maxWorkspace then
            hl.dispatch(hl.dsp.workspace.move({
                workspace = ws.id,
                monitor = target_monitor(ws.id, primary, secondary)
                    .name
            }))
        end
    end
end

-- Apply workspace layout once manually
-- Update it on monitor add/remove
apply_workspace_layout()
hl.on("monitor.added", apply_workspace_layout)
hl.on("monitor.removed", apply_workspace_layout)

return {
    apply_workspace_layout = apply_workspace_layout,
}
