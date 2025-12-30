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
    key = "music_prestige", 
    path = "prestigepack.ogg",
    select_music_track = function() 
        local booster = G.pack_cards and G.pack_cards.cards and SMODS.OPENED_BOOSTER
		if booster and booster.config.center_key:find('p_zero_prestige_') then
			return 1e10
		end
	end
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "music_cups", 
    path = "cupspack.ogg",
    select_music_track = function() 
        local booster = G.pack_cards and G.pack_cards.cards and SMODS.OPENED_BOOSTER
		if booster and booster.config.center_key:find('p_zero_cups_') then
			return 1e10
		end
	end
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

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "galasfx", 
    path = "galasfx.ogg",
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "sunsteelpow", 
    path = "sunsteelpow.ogg",
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "hoshisaga_chirin", 
    path = "hoshisaga_chirin.ogg",
}

SMODS.Shader{
	key = "gala",
	path = "gala.fs"
}

--Custom Colors
G.C.CUPS = HEX("53468A")
G.C.PRESTIGE = HEX("344245")

local ref_loc_colour = loc_colour
function loc_colour(_c, _default)
    ref_loc_colour(_c, _default)
    G.ARGS.LOC_COLOURS.cups = G.C.CUPS
	G.ARGS.LOC_COLOURS.prestige = G.C.PRESTIGE
    return G.ARGS.LOC_COLOURS[_c] or _default or G.C.UI.TEXT_DARK
end