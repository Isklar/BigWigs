
-- Notes --
-- Fel beam fixate

--------------------------------------------------------------------------------
-- Module Declaration
--

if not IsTestBuild() then return end

local mod, CL = BigWigs:NewBoss("Shadow-Lord Iskar", 1026, 1433)
if not mod then return end
mod:RegisterEnableMob(90316, 91591) -- 90316 in beta
mod.engageId = 1788

--------------------------------------------------------------------------------
-- Locals
--

local poundCount = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then

end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		181956, -- Phantasmal Winds
		182323, -- Phantasmal Wounds
		{181824, "SAY", "PROXIMITY"}, -- Phantasmal Corruption
		{181753, "SAY"}, -- Fel Bomb
		{181912, "FLASH"}, -- Focused Blast
		{182582, "SAY"}, -- Fel Incineration
		181827, -- Fel Conduit
		{182200, "SAY"}, -- Fel Chakram
		"berserk",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "PhantasmalWinds", 185757, 181957)
	self:Log("SPELL_AURA_APPLIED", "PhantasmalWounds", 182325)
	self:Log("SPELL_AURA_APPLIED", "PhantasmalCorruption", 181824, 187990)
	self:Log("SPELL_AURA_REMOVED", "PhantasmalCorruptionRemoved", 181824, 187990)
	self:Log("SPELL_AURA_APPLIED", "FelBomb", 181753)
	self:Log("SPELL_CAST_START", "FocusedBlast", 181912)
	self:Log("SPELL_CAST_START", "FelConduit", 181827, 187998)
	self:Log("SPELL_AURA_APPLIED", "FelChakram", 182200, 182178)

	self:RegisterEvent("RAID_BOSS_WHISPER")
end

function mod:OnEngage()
	self:Message("berserk", "Neutral", nil, "Shadow-Lord Iskar (beta) engaged", false)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local list = mod:NewTargetList()
	function mod:PhantasmalWinds(args)
		list[#list+1] = args.destName
		if #list == 1 then
			self:ScheduleTimer("TargetMessage", 0.2, 181956, list, "Attention")
		end
	end
end

do
	local list = mod:NewTargetList()
	function mod:PhantasmalWounds(args)
		list[#list+1] = args.destName
		if #list == 1 then
			self:ScheduleTimer("TargetMessage", 0.2, 182323, list, "Attention")
		end
	end
end

function mod:PhantasmalCorruption(args)
	self:TargetBar(args.spellId, 10, args.destName)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alert")
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:OpenProximity(args.spellId, 15) -- XXX verify obliteration range
	end
end

function mod:PhantasmalCorruptionRemoved(args)
	if self:Me(args.destGUID) then
		self:CloseProximity(args.spellId)
	end
	self:StopBar(args.spellName, args.destName)
end

function mod:FelBomb(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alert")
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

function mod:FocusedBlast(args)
	self:Message(args.spellId, "Important", "Long", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 12)
	self:Flash(args.spellId)
end

function mod:FelConduit(args)
	self:Message(args.spellId, "Important", "Long", CL.casting:format(args.spellName))
end

function mod:RAID_BOSS_WHISPER(event, msg)
	if msg:find(self:SpellName(182582)) then
		self:Message(182582, "Personal", "Alarm", CL.you:format(self:SpellName(182582)))
		self:Say(182582)
	end
end

do
	local list = mod:NewTargetList()
	function mod:FelChakram(args)
		list[#list+1] = args.destName
		if #list == 1 then
			self:ScheduleTimer("TargetMessage", 0.2, 182200, list, "Attention", "Alert")
		end
		if self:Me(args.destGUID) then
			self:Say(182200)
		end
	end
end
