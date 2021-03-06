local L = BigWigs:NewBossLocale("Harjatan the Bludger", "ruRU")
if not L then return end
if L then
	L.custom_on_fixate_plates = "Иконка фиксации на вражеских неймплейтах"
	L.custom_on_fixate_plates_desc = "Показывать иконку цели, которая на вас навелась.\nТребуется чтобы вражеские неймплейты были включены. Эта функция пока поддерживается только аддоном KuiNameplates."
end

L = BigWigs:NewBossLocale("Demonic Inquisition", "ruRU")
if L then
	--L.custom_on_stop_timers = "Always show ability bars"
	--L.custom_on_stop_timers_desc = "Demonic Inquisition has some spells which are delayed by interupts/other casts. When this option is enabled, the bars for those abilities will stay on your screen."
end

L = BigWigs:NewBossLocale("The Desolate Host", "ruRU")
if L then
	L.infobox_players = "Игроки"
	L.armor_remaining = "%s осталось (%d)" -- Bonecage Armor Remaining (#)
	--L.tormentingCriesSay = "Cries" -- Tormenting Cries (short say)
end

L = BigWigs:NewBossLocale("Maiden of Vigilance", "ruRU")
if L then
	L.infusionChanged = "Насыщение ИЗМЕНИЛОСЬ: %s"
	L.sameInfusion = "Насыщение: %s"
	L.fel = "Скверна"
	L.light = "Свет"
	--L.felHammer = "Fel Hammer" -- Better name for "Hammer of Obliteration"
	--L.lightHammer = "Light Hammer" -- Better name for "Hammer of Creation"
end

L = BigWigs:NewBossLocale("Fallen Avatar", "ruRU")
if L then
	L.touch_impact = "Взрыв касания" -- Touch of Sargeras Impact (short)

	--L.custom_on_stop_timers = "Always show ability bars"
	--L.custom_on_stop_timers_desc = "Fallen Avatar randomizes which off-cooldown ability he uses next. When this option is enabled, the bars for those abilities will stay on your screen."
end

L = BigWigs:NewBossLocale("Kil'jaeden", "ruRU")
if L then
	L.singularityImpact = "Взрыв сингулярности"
	L.obeliskExplosion = "Взрыв обелисков"

	L.darkness = "Тьма" -- Shorter name for Darkness of a Thousand Souls (238999)
	L.reflectionErupting = "Отражение: взрывное" -- Shorter name for Shadow Reflection: Erupting (236710)
	L.reflectionWailing = "Отражение: жалобное" -- Shorter name for Shadow Reflection: Wailing (236378)
	L.reflectionHopeless = "Отражение: обречённое" -- Shorter name for Shadow Reflection: Hopeless (237590)
end

L = BigWigs:NewBossLocale("Tomb of Sargeras Trash", "ruRU")
if L then
	L.chaosbringer = "Инфернал - вестник хаоса"
	L.rez = "Смотритель гробницы Рез"
	L.custodian = "Подводный надзиратель"
	L.sentry = "Страж Хранительницы"
end
