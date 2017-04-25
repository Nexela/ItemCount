local function SetGUIText(player, count, vehicle_count)
    local text = tostring(count)
    if vehicle_count > 0 then
        text = text .. " (".. tostring(vehicle_count) ..")"
    end
    if player.gui.center.itemcount then
        player.gui.center.itemcount.style.font = "default-bold"
        player.gui.center.itemcount.caption = text
    end
end

local function OpenGUI(player)
    if not player.gui.center.itemcount then
        player.gui.center.add{type="label", name="itemcount", caption="0", direction = "vertical"}
        player.gui.center.itemcount.style.minimal_width=32
    end
end

local function CloseGUI(player)
    if player.gui.center.itemcount then
        player.gui.center.itemcount.destroy()
    end
end

local function CalculateTotal(player, item_name, vehicle)
    local inventory_count = player.get_item_count(item_name)
    local vehicle_count = 0
    if vehicle and vehicle.get_inventory(defines.inventory.car_trunk) then
        vehicle_count = vehicle.get_inventory(defines.inventory.car_trunk).get_item_count(item_name)
    end
    return inventory_count, vehicle_count
end

local function CheckStack(event)
    local player=game.players[event.player_index]
    if player and player.cursor_stack.valid_for_read then
        OpenGUI(player)
        SetGUIText(player, CalculateTotal(player, player.cursor_stack.name, player.vehicle))
    else
        CloseGUI(player)
    end
    --]]
end
local events = {
    defines.events.on_player_cursor_stack_changed,
    defines.events.on_player_driving_changed_state,
    defines.events.on_player_main_inventory_changed,
    defines.events.on_player_ammo_inventory_changed,
    defines.events.on_player_quickbar_inventory_changed,
    --defines.events.on_player_crafted_item,
}
script.on_event(events, function(event) CheckStack(event) end)
