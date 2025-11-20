SMODS.Atlas {
  key = "zero_tarot",
  px = 71,
  py = 95,
  path = "zero_tarot.png"
}

SMODS.Consumable {
  set = "Tarot",
  key = "light",
  name = "The Light",
  config = {
    max_highlighted = 2,
	suit_conv = "zero_Brights",
  },
  pos = {x = 0, y = 0},
  atlas = "zero_tarot",
  cost = 3,
  unlocked = true,
  discovered = true,
  loc_vars = function(self, info_queue, card)
    return {vars = {
	  card.ability.max_highlighted,
	  localize(card.ability.suit_conv, 'suits_plural'),
	  colours = {
	    G.C.SUITS[card.ability.suit_conv]
	  },
	}}
  end,
}

SMODS.Consumable {
  set = "Tarot",
  key = "flame",
  name = "The Flame",
  config = {
    max_highlighted = 2,
	mod_conv = "m_zero_sunsteel",
  },
  pos = {x = 1, y = 0},
  atlas = "zero_tarot",
  cost = 3,
  unlocked = true,
  discovered = true,
  loc_vars = function(self, info_queue, card)
	info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
	return { vars = {
		card.ability.max_highlighted,
		localize{
			type = 'name_text',
			set = 'Enhanced',
			key = card.ability.mod_conv
		},
		card.ability.max_highlighted == 1 and "" or "s",
	}}
  end,
}

SMODS.Consumable {
  set = "Tarot",
  key = "choice",
  name = "The Choice",
  config = {
    max_highlighted = 1,
	mod_conv = "m_zero_suit_yourself",
  },
  pos = {x = 2, y = 0},
  atlas = "zero_tarot",
  cost = 3,
  unlocked = true,
  discovered = true,
  loc_vars = function(self, info_queue, card)
	info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
	return { vars = {
		card.ability.max_highlighted,
		localize{
			type = 'name_text',
			set = 'Enhanced',
			key = card.ability.mod_conv
		},
		card.ability.max_highlighted == 1 and "" or "s",
	}}
  end,
}