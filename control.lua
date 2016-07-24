local guiOpen = false

script.on_event(defines.events.on_player_cursor_stack_changed, function(event) CheckStack(event) end)

local oldStack = nil
local totalCount = 0

function CheckStack(event)
	local player=game.players[event.player_index]
	if player and player.cursor_stack.valid_for_read then
		OpenGUI(player)
		CalculateTotal(player, player.cursor_stack)
		SetGUIText(player, totalCount)
	else
		CloseGUI(player)
	end
	--]]
end


function CalculateTotal(player, stack)
	totalCount = stack.count
	local inventory = player.get_inventory(defines.inventory.player_quickbar)
	totalCount = totalCount + inventory.get_item_count(stack.name)
	inventory = player.get_inventory(defines.inventory.player_main)
	totalCount = totalCount + inventory.get_item_count(stack.name)
end

function SetGUIText(player, text)
	if player.gui.center.itemcount then
		player.gui.center.itemcount.style.font = "default-bold"
		player.gui.center.itemcount.caption = text
	end
end

function OpenGUI(player)
	if not player.gui.center.itemcount then
		player.gui.center.add{type="label", name="itemcount", caption="100000", direction = "vertical"}
	end
end

function CloseGUI(player)
	if player.gui.center.itemcount then
		player.gui.center.itemcount.destroy()
	end
end
