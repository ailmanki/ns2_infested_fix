-- ======= Copyright (c) 2003-2011, Unknown Worlds Entertainment, Inc. All rights reserved. =======
--
-- lua\DeathMessage_Client.lua
--
--    Created by:   Charlie Cleveland (charlie@unknownworlds.com)
--
-- ========= For more information, visit us at http://www.unknownworlds.com =====================

local kSubImageWidth = 128
local kSubImageHeight = 64

local queuedDeathMessages = { }

local resLostMarine = 0
local resLostAlien = 0
local rtsLostMarine = 0
local rtsLostAlien = 0
local resRecovered = 0

-- Can't have multi-dimensional arrays so return potentially very long array [color, name, color, name, doerid, ....]
function DeathMsgUI_GetMessages()
	
	local returnArray = {}
	local arrayIndex = 1
	
	-- return list of recent death messages
	for index, deathMsg in ipairs(queuedDeathMessages) do
		
		for deathMessageIndex, element in ipairs(deathMsg) do
			table.insert(returnArray, element)
		end
	
	end
	
	-- Clear current death messages
	table.clear(queuedDeathMessages)
	
	return returnArray

end

function DeathMsgUI_MenuImage()
	return "death_messages"
end

function DeathMsgUI_GetTechOffsetX(doerId)
	return 0
end

function DeathMsgUI_GetTechOffsetY(iconIndex)
	
	if not iconIndex then
		iconIndex = 1
	end
	
	return (iconIndex - 1)*kSubImageHeight

end

function DeathMsgUI_GetTechWidth(doerId)
	return kSubImageWidth
end

function DeathMsgUI_GetTechHeight(doerId)
	return kSubImageHeight
end

-- Pass 1 for isPlayer if coming from a player (look it up from scoreboard data), otherwise it's a tech id
local function GetDeathMessageEntityName(isPlayer, clientIndex)

	local name = ""

	if isPlayer then
		name = Scoreboard_GetPlayerData(clientIndex, "Name")
	elseif clientIndex ~= -1 then
		name = GetDisplayNameForTechId(clientIndex)
	end

	return name or ""

end

-- Stored the name of the last killer.
local gKillerName = nil
local gKillerWeaponIconIndex = kDeathMessageIcon.None

-- The killer name will clear when this is called.
function GetKillerNameAndWeaponIcon()
	
	local killerName = gKillerName
	gKillerName = nil
	return killerName, gKillerWeaponIconIndex

end

function DeathMsgUI_GetResLost(teamNumber)
	
	if teamNumber == kTeam1Index then
		
		return resLostMarine
	
	elseif teamNumber == kTeam2Index then
		
		return resLostAlien
	
	end
	
	return nil

end

function DeathMsgUI_GetRtsLost(teamNumber)
	
	if teamNumber == kTeam1Index then
		
		return rtsLostMarine
	
	elseif teamNumber == kTeam2Index then
		
		return rtsLostAlien
	
	end
	
	return nil

end

function DeathMsgUI_GetCystsLost()
	
	return cystsLost

end

function DeathMsgUI_GetResRecovered()
	
	return resRecovered

end

function DeathMsgUI_ResetStats()
	
	resLostMarine = 0
	resLostAlien = 0
	rtsLostMarine = 0
	rtsLostAlien = 0
	resRecovered = 0

end

function DeathMsgUI_AddResLost(teamNumber, res)
	
	if teamNumber == kTeam1Index then
		resLostMarine = resLostMarine + res
	elseif teamNumber == kTeam2Index then
		resLostAlien = resLostAlien + res
	end

end

function DeathMsgUI_AddRtsLost(teamNumber, rts)
	
	if teamNumber == kTeam1Index then
		rtsLostMarine = rtsLostMarine + rts
	elseif teamNumber == kTeam2Index then
		rtsLostAlien = rtsLostAlien + rts
	end

end

function DeathMsgUI_AddResRecovered(amount)
	
	resRecovered = resRecovered + amount

end



local function OnDeathMessage(message)
    return
end
Client.HookNetworkMessage("DeathMessage", OnDeathMessage)