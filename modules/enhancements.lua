SMODS.Atlas {
  key = "zero_enhancers",
  px = 71,
  py = 95,
  path = "zero_enhancers.png"
}

SMODS.Enhancement {
  key = "sunsteel",
  name = "Sunsteel Card",
  config = {
    extra = {
	  xmult = 1.05,
	  xmult_mod = 0.05,
	},
  },
  pos = {x = 0, y = 0},
  atlas = "zero_enhancers",
  unlocked = true,
  discovered = true,
  loc_vars = function(self, info_queue, card)
    return { vars = {
	  card.ability.extra.xmult,
	  card.ability.extra.xmult_mod
	}}
  end,
  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.hand then
	  local val = card.ability.extra.xmult
	  for k,v in ipairs(G.hand.cards) do
	    if v ~= card and SMODS.has_enhancement(v, "m_zero_sunsteel") then
		  val = val + card.ability.extra.xmult_mod
		end
      end
      return { xmult = val }
	end
  end,
}

SMODS.Enhancement {
  key = "suit_yourself",
  name = "Suit Yourself Card",
  config = {
    extra = {
	  dollars = 10,
	  active = false,
	},
  },
  pos = {x = 1, y = 0},
  atlas = "zero_enhancers",
  unlocked = true,
  discovered = true,
  replace_base_card = true,
  no_rank = true,
  -- they're not actually *any* suit,
  -- so any_suit isn't set to true here
  -- instead, their suitedness is handled
  -- in zero_has_any_regular_suit
  loc_vars = function(self, info_queue, card)
    return { vars = {
	  card.ability.extra.dollars,
	}}
  end,
  calculate = function(self, card, context)
	if context.main_scoring and context.cardarea == G.play then
		local suits = {
			['Hearts'] = 0,
			['Diamonds'] = 0,
			['Spades'] = 0,
			['Clubs'] = 0,
		}
		local wild_or_whatever = 0


		for i = 1, #context.scoring_hand do
			if not zero_has_any_regular_suit(context.scoring_hand[i]) then
				if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then
					suits["Hearts"] = suits["Hearts"] + 1
				elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then
					suits["Diamonds"] = suits["Diamonds"] + 1
				elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then
					suits["Spades"] = suits["Spades"] + 1
				elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0 then
					suits["Clubs"] = suits["Clubs"] + 1
				end
			else
				wild_or_whatever = wild_or_whatever + 1
			end
		end

		for k,v in pairs(suits) do
			if v == 0 and wild_or_whatever > 0 then
				wild_or_whatever = wild_or_whatever - 1
				suits[k] = v + 1
			end
		end

		if suits["Hearts"] > 0 and suits["Diamonds"] > 0 and
		  suits["Spades"] > 0 and suits["Clubs"] > 0 then
			card.ability.extra.active = true
			return { dollars = card.ability.extra.dollars }
		end

		
	end
	if context.destroy_card == card and card.ability.extra.active then
		return { remove = true }
	end
  end
}