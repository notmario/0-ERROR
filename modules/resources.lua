SMODS.Font {
	key = "pokemon",
	path = "pokemon-font.ttf",
	render_scale = 200,
	TEXT_HEIGHT_SCALE = 0.9,
	TEXT_OFFSET = { x = 12, y = -24 },
	FONTSCALE = 0.06,
	squish = 1,
	DESCSCALE = 1
}

SMODS.Font {
	key = "pixeldingbats",
	path = "pixel_dingbats-7.ttf",
	render_scale = 200,
	TEXT_HEIGHT_SCALE = 0.9,
	TEXT_OFFSET = { x = 12, y = -24 },
	FONTSCALE = 0.06,
	squish = 1,
	DESCSCALE = 1
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "music_silence", 
    path = "silence.ogg",
    select_music_track = function() 
        return next(SMODS.find_card('j_zero_female_symbol')) and 100 or nil
	end
}