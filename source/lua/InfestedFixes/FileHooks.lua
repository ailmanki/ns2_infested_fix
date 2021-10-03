
do
	-- Only load if Infested Mod is loaded
	if nil ~= ModLoader.GetModInfo("infestedMarines") then
		ModLoader.SetupFileHook("lua/IMGUIGameEnd.lua", "lua/InfestedFixes/IMGUIGameEnd.lua", "replace" )
		ModLoader.SetupFileHook("lua/IMScoringMixin.lua", "lua/InfestedFixes/IMScoringMixin.lua", "post")
		
		ModLoader.SetupFileHook("lua/ServerStats.lua", "lua/InfestedFixes/ServerStats.lua", "replace")
		
		Log("[MOD] Infested Fixes applied !")
	else
		Log("[MOD] Infested Fixes not loaded !")
	end
end