SMODS.Atlas {
  key = "zero_brights_lc",
  px = 71,
  py = 95,
  path = "zero_brights_lc.png"
}
SMODS.Atlas {
  key = "zero_brights_hc",
  px = 71,
  py = 95,
  path = "zero_brights_hc.png"
}
SMODS.Atlas {
  key = "zero_brights_ui_lc",
  px = 18,
  py = 18,
  path = "zero_brights_ui_lc.png"
}
SMODS.Atlas {
  key = "zero_brights_ui_hc",
  px = 18,
  py = 18,
  path = "zero_brights_ui_hc.png"
}

SMODS.Suit {
	key = 'Brights',
	card_key = 'BRIGHTS',

	lc_atlas = 'zero_brights_lc',
	lc_ui_atlas = 'zero_brights_ui_lc',
	lc_colour = HEX("35d2ff"),

	hc_atlas = 'zero_brights_hc',
	hc_ui_atlas = 'zero_brights_ui_hc',
	hc_colour = HEX("882cf7"),

	pos = { y = 0 },
	ui_pos = { x = 0, y = 0 },

	in_pool = function(self, args)
		--this is where something for standard packs would go
		return false
	end
}