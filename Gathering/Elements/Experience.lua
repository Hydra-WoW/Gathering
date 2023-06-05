local Name, AddOn = ...
local Gathering = AddOn.Gathering

function Gathering:PLAYER_XP_UPDATE()
	local XP = UnitXP("player")
	local MaxXP = UnitXPMax("player")

	if (MaxXP ~= self.LastMax) then
		self.XPGained = self.LastMax - self.LastXP + XP + self.XPGained
		self:AddStat("xp", (self.LastMax - self.LastXP + XP))
		self:AddStat("levels", 1)
	else
		self.XPGained = (XP - self.LastXP) + self.XPGained
		self:AddStat("xp", (XP - self.LastXP))
	end

	if (not self.XPStartTime) then
		self.XPStartTime = GetTime()
	end

	self:UpdateXPStat()

	self.LastXP = XP
	self.LastMax = MaxXP
end

Gathering:RegisterEvent("PLAYER_XP_UPDATE")