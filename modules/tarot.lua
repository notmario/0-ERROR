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
    max_highlighted = 3,
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