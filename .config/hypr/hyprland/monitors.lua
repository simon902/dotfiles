-- Dynamic workspace layout
--
-- Single monitor: 1-10
-- Double monitor:
--    Main:   6-10
--    Second: 1-5

local vars = require("variables")

local function pick_primary_secondary(monitors)
    local primary
    for _, mon in ipairs(monitors) do
        if mon.name == vars.primaryMonitorName then
            primary = mon
            break
        end
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
