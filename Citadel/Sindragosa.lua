--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Sindragosa", "Icecrown Citadel")
if not mod then return end
mod:RegisterEnableMob(36853)
mod.toggleOptions = {69766, 70106, 71047, {70126, "FLASHSHAKE"}, "airphase", "phase2", 70127, "proximity", "berserk", "bosskill"}

--------------------------------------------------------------------------------
-- Locals
--

local beaconTargets = mod:NewTargetList()

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.engage_trigger = "You are fools to have come to this place."

	L.phase2 = "Phase 2"
	L.phase2_desc = "Warn when Sindragosa goes into phase 2, at 35%."
	L.phase2_trigger = "Now, feel my master's limitless power and despair!"
	L.phase2_message = "Phase 2!"

	L.airphase = "Air phase"
	L.airphase_desc = "Warn when Sindragosa will lift off."
	L.airphase_trigger = "Your incursion ends here! None shall survive!"
	L.airphase_message = "Air phase!"
	L.airphase_bar = "Next air phase"

	L.boom_message = "Explosion!"
	L.boom_bar = "Explosion"

	L.unchained_message = "Unchained magic on YOU!"
	L.instability_message = "Unstable x%d!"
	L.chilled_message = "Chilled x%d!"
	L.buffet_message = "Magic x%d!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED_DOSE", "Instability", 69766)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Chilled", 70106)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Buffet", 70127)

	self:Log("SPELL_AURA_APPLIED", "FrostBeacon", 70126)
	self:Log("SPELL_AURA_APPLIED", "Tombed", 70157)

	-- 70123, 71047, 71048, 71049 is the actual blistering cold
	self:Log("SPELL_CAST_SUCCESS", "Grip", 70117)

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:Yell("Engage", L["engage_trigger"])
	self:Yell("AirPhase", L["airphase_trigger"])
	self:Yell("Phase2", L["phase2_trigger"])
	self:Death("Win", 36853)
end

function mod:OnEngage()
	self:Berserk(600)
	self:Bar("airphase", L["airphase_bar"], 50, 23684)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Tombed(player)
	if UnitIsUnit(player, "player") then
		self:CloseProximity()
	end
end

do
	local scheduled = nil
	local function baconWarn(spellName)
		mod:TargetMessage(70126, spellName, beaconTargets, "Urgent", 70126)
		mod:Bar(70126, spellName, 7, 70126)
		scheduled = nil
	end
	function mod:FrostBeacon(player, spellId, _, _, spellName)
		beaconTargets[#beaconTargets + 1] = player
		if UnitIsUnit(player, "player") then
			self:OpenProximity(10)
			self:FlashShake(70126)
		end
		if not scheduled then
			scheduled = true
			self:ScheduleTimer(baconWarn, 0.2, spellName)
		end
	end
end

function mod:Grip()
	self:Message(71047, L["boom_message"], "Important", 71047, "Alarm")
	self:Bar(71047, L["boom_bar"], 5, 71047)
end

function mod:AirPhase()
	self:Message("airphase", L["airphase_message"], "Positive")
	self:Bar("airphase", L["airphase_bar"], 110, 23684)
end

function mod:Phase2()
	self:SendMessage("BigWigs_StopBar", self, L["airphase_bar"])
	self:Message("phase2", L["phase2_message"], "Positive", nil, "Long")
end

function mod:Buffet(player, spellId, _, _, _, stack)
	if (stack % 2 == 0) and UnitIsUnit(player, "player") then
		self:LocalMessage(70127, L["buffet_message"]:format(stack), "Attention", spellId, "Info")
	end
end

function mod:Instability(player, spellId, _, _, _, stack)
	if stack > 4 and UnitIsUnit(player, "player") then
		self:LocalMessage(69766, L["instability_message"]:format(stack), "Personal", spellId)
	end
end

function mod:Chilled(player, spellId, _, _, _, stack)
	if stack > 4 and UnitIsUnit(player, "player") then
		self:LocalMessage(70106, L["chilled_message"]:format(stack), "Personal", spellId)
	end
end

