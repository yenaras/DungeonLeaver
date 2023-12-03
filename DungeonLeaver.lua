DungeonLeaver = {}
DungeonLeaver.name = "DungeonLeaver"

-- if player is in an instance, leave the instance
local function InstanceLeaver()
    if CanExitInstanceImmediately() then
        ExitInstanceImmediately()
        d("leaving instance")
    end
end

local function LeaveDungeon()
    -- if player is in a group, leave the group
    if IsUnitGrouped("player") then
        GroupLeave()
        d("leaving group")
        zo_callLater(function() InstanceLeaver() end, 1000)
    else
        InstanceLeaver()
    end
end

function DungeonLeaver.OnAddOnLoaded(event, addonName)
    if addonName ~= DungeonLeaver.name then return end
    EVENT_MANAGER:UnregisterForEvent(DungeonLeaver.name, EVENT_ADD_ON_LOADED)

    SLASH_COMMANDS["/dl"] = LeaveDungeon
    SLASH_COMMANDS["/dungeonleave"] = LeaveDungeon
    SLASH_COMMANDS["/ld"] = LeaveDungeon
    SLASH_COMMANDS["/leavedungeon"] = LeaveDungeon
    SLASH_COMMANDS["/gl"] = LeaveDungeon
    SLASH_COMMANDS["/groupleave"] = LeaveDungeon
    SLASH_COMMANDS["/lg"] = LeaveDungeon
    SLASH_COMMANDS["/leavegroup"] = LeaveDungeon
end

EVENT_MANAGER:RegisterForEvent(DungeonLeaver.name, EVENT_ADD_ON_LOADED, DungeonLeaver.OnAddOnLoaded)
