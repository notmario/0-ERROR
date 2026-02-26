SMODS.Sound({
	key = "music_valdi_ascension",
	path = "valdi_ascension.ogg",
	volume = 0.7,
	pitch = 1,
	sync = false,
	select_music_track = function()
		return G.STAGE == G.STAGES.MAIN_MENU
			and SMODS.Mods["Cryptid"].config.Cryptid.alt_bg_music
			and zero_config.remix_cryptid_alt_bg_music
	end,
})