
do
	-- Only load if Infested Mod is loaded
	if nil ~= ModLoader.GetModInfo("infestedMarines") then
		ModLoader.SetupFileHook("lua/IMGUIGameEnd.lua", "lua/InfestedFixes/IMGUIGameEnd.lua", "replace" )
		ModLoader.SetupFileHook("lua/IMScoringMixin.lua", "lua/InfestedFixes/IMScoringMixin.lua", "post")
				ModLoader.SetupFileHook("lua/IMGUIMarineHUD.lua", "lua/InfestedFixes/IMGUIMarineHUD.lua", "replace")
		ModLoader.SetupFileHook("lua/IMNS2Gamerules.lua", "lua/InfestedFixes/IMNS2Gamerules.lua", "replace")
	end
end