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
	end,
	
	create_default_deck_skin = function(self)
		local display_rank_arg = {'King', 'Queen', 'Jack'}
		if next(SMODS.find_mod("finity")) then
			table.insert(display_rank_arg, 1,'finity_V')
		end
		if next(SMODS.find_mod("entr")) then
			table.insert(display_rank_arg, 5 ,'entr_nilrank')
		end
		if next(SMODS.find_mod("paperback")) then
			table.insert(display_rank_arg, 6 ,'paperback_Apostle')
		end
		SMODS.DeckSkin{
			key = 'default_'..self.key,
			prefix_config = { key = false },
			suit = self.key,
			palettes = {
				{
					key = 'lc',
					ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', "King", "Ace", "finity_V", "entr_nilrank", "paperback_Apostle"},
					display_ranks = display_rank_arg,
					atlas = self.lc_atlas,
					pos_style = 'ranks',
					akyrs_pure_suit = {
						pos = {x = 15, y = 0,},
						atlas_key = "zero_brights_lc",
					},
				},
				{
					key = 'hc',
					ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', "King", "Ace", "finity_V", "entr_nilrank", "paperback_Apostle"},
					display_ranks = display_rank_arg,
					atlas = self.hc_atlas,
					pos_style = 'ranks',
					hc_default = true,
					akyrs_pure_suit = {
						pos = {x = 15, y = 0,},
						atlas_key = "zero_brights_hc",
					},
				},
			}
		}
	end,
}