SMODS.Atlas {
  key = "zero_planet",
  px = 71,
  py = 95,
  path = "zero_planet.png"
}

if next(SMODS.find_mod('SpectrumFramework')) then
	local old_init_game_object = Game.init_game_object
	function Game:init_game_object()
		if zero_config.force_specflush == true then
			SMODS.Mods["SpectrumFramework"].config.specflush = true
		end
		return old_init_game_object(self, args)
	end
	
	SMODS.Consumable{
		set = 'Planet',
		cost = 3,
		unlocked = true,
		discovered = true,
		atlas = 'zero_planet',
		pos = {x=0, y=0},
		key = 'ievea',
		name = "Iev'ea",
		effect = 'Hand Upgrade',
		config = {hand_type = 'spectrum_Specflush', softlock = true},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					G.GAME.hands[card.ability.hand_type].level,
					localize(card.ability.hand_type, 'poker_hands'),
					G.GAME.hands[card.ability.hand_type].l_mult,
					G.GAME.hands[card.ability.hand_type].l_chips,
					colours = { (G.GAME.hands[card.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]) }
				}
			}
		end,
		set_card_type_badge = function(self, card, badges)
			badges[1] = create_badge("Superspace", get_type_colour(self or card.config, card), nil, 1.2)
		end
	}
	SMODS.Consumable{
		set = 'Planet',
		cost = 3,
		unlocked = true,
		discovered = true,
		atlas = 'zero_planet',
		pos = {x=1, y=0},
		key = 'id',
		name = "Id",
		effect = 'Hand Upgrade',
		config = {hand_type = 'spectrum_Straight Specflush', softlock = true},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					G.GAME.hands[card.ability.hand_type].level,
					localize(card.ability.hand_type, 'poker_hands'),
					G.GAME.hands[card.ability.hand_type].l_mult,
					G.GAME.hands[card.ability.hand_type].l_chips,
					colours = { (G.GAME.hands[card.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]) }
				}
			}
		end,
		set_card_type_badge = function(self, card, badges)
			badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
		end
	}
	SMODS.Consumable{
		set = 'Planet',
		cost = 3,
		unlocked = true,
		discovered = true,
		atlas = 'zero_planet',
		pos = {x=2, y=0},
		key = 'false_vacuum',
		name = "False Vacuum",
		effect = 'Hand Upgrade',
		config = {hand_type = 'spectrum_Specflush House', softlock = true},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					G.GAME.hands[card.ability.hand_type].level,
					localize(card.ability.hand_type, 'poker_hands'),
					G.GAME.hands[card.ability.hand_type].l_mult,
					G.GAME.hands[card.ability.hand_type].l_chips,
					colours = { (G.GAME.hands[card.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]) }
				}
			}
		end,
		set_card_type_badge = function(self, card, badges)
			badges[1] = create_badge("Superspace", get_type_colour(self or card.config, card), nil, 1.2)
		end
	}
	SMODS.Consumable{
		set = 'Planet',
		cost = 3,
		unlocked = true,
		discovered = true,
		atlas = 'zero_planet',
		pos = {x=3, y=0},
		key = 'everblaze_isles',
		name = "Everblaze Isles",
		effect = 'Hand Upgrade',
		config = {hand_type = 'spectrum_Specflush Five', softlock = true},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					G.GAME.hands[card.ability.hand_type].level,
					localize(card.ability.hand_type, 'poker_hands'),
					G.GAME.hands[card.ability.hand_type].l_mult,
					G.GAME.hands[card.ability.hand_type].l_chips,
					colours = { (G.GAME.hands[card.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]) }
				}
			}
		end,
		set_card_type_badge = function(self, card, badges)
			badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
		end
	}
end