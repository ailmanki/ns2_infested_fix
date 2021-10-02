-- Add commander playing teams separate per team
-- Vanilla only tracks overall commanding time
function ScoringMixin:UpdatePlayerStats(deltaTime)
	
	local steamId = self:GetSteamId()
	if steamId > 0 then -- ignore players without a valid steamid (bots etc.)
		
		local clientStat = StatsUI_GetStatForClient(steamId)
		if self:GetIsPlaying() and clientStat then
			
			local teamNumber = self:GetTeamNumber()
			local statusPlayer = clientStat
			local statusRoot = clientStat["status"]
			local stat = clientStat[teamNumber]
			
			-- Make sure we update times only once per frame
			if not statusPlayer.lastUpdate or statusPlayer.lastUpdate < Shared.GetTime() then
				
				statusPlayer.lastUpdate = Shared.GetTime()
				
				if self:isa("Commander") then
					stat.commanderTime = stat.commanderTime + deltaTime end
				-- [Server] Script Error #560: lua/ScoringMixin.lua:98: attempt to perform arithmetic on field 'timePlayed' (a nil value)
				if stat.timePlayed == nil then
					stat.timePlayed = 0
				end
				stat.timePlayed = stat.timePlayed + deltaTime
				local status = StatsUI_GetStatusGrouping(self:GetPlayerStatusDesc()) or self:GetPlayerStatusDesc()
				
				statusRoot[status] = (statusRoot[status] or 0) + deltaTime
			end
		end
	end
end