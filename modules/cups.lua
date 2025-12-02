SMODS.Atlas {
  key = "zero_cups",
  px = 71,
  py = 95,
  path = "zero_cups.png"
}

SMODS.ConsumableType {
  key = "Cups",
  primary_colour = HEX("53468A"),
  secondary_colour = HEX("8A71E1"),
  loc_txt = {
    name = 'Cups', -- used on card type badges
 		collection = 'Cups Cards', -- label for the button to access the collection
 		undiscovered = { -- description for undiscovered cards in the collection
 			name = 'Undiscovered',
 			text = { '???' },
 		},
  },
  collection_rows = { 4, 5 },
  shop_rate = 0.0
}
  
SMODS.Booster({
  key = "cups_normal_1",
  kind = "Cups",
  atlas = "zero_booster",
  pos = { x = 4, y = 0 },
  config = { extra = 3, choose = 1 },
  cost = 4,
  draw_hand = true,
  weight = 0.48,
  unlocked = true,
  discovered = true,
  create_card = function(self, card)
    local n_card = create_card("Cups", G.pack_cards, nil, nil, true, true, nil, "zero_cups")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Cups)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Cups, special_colour = G.C.CUPS, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 2} }
  end,
  group_key = "k_cups_pack",
})
SMODS.Booster({
  key = "cups_normal_2",
  kind = "Cups",
  atlas = "zero_booster",
  pos = { x = 5, y = 0 },
  config = { extra = 3, choose = 1 },
  cost = 4,
  draw_hand = true,
  weight = 0.48,
  unlocked = true,
  discovered = true,
  create_card = function(self, card)
    local n_card = create_card("Cups", G.pack_cards, nil, nil, true, true, nil, "zero_cups")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Cups)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Cups, special_colour = G.C.CUPS, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 2} }
  end,
  group_key = "k_cups_pack",
})
SMODS.Booster({
  key = "cups_jumbo_1",
  kind = "Cups",
  atlas = "zero_booster",
  pos = { x = 6, y = 0 },
  config = { extra = 5, choose = 1 },
  cost = 6,
  draw_hand = true,
  weight = 0.48,
  unlocked = true,
  discovered = true,
  create_card = function(self, card)
    local n_card = create_card("Cups", G.pack_cards, nil, nil, true, true, nil, "zero_cups")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Cups)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Cups, special_colour = G.C.CUPS, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 4} }
  end,
  group_key = "k_cups_pack",
})
SMODS.Booster({
  key = "cups_mega_1",
  kind = "Cups",
  atlas = "zero_booster",
  pos = { x = 7, y = 0 },
  config = { extra = 5, choose = 2 },
  cost = 8,
  draw_hand = true,
  weight = 0.24,
  unlocked = true,
  discovered = true,
  create_card = function(self, card)
    local n_card = create_card("Cups", G.pack_cards, nil, nil, true, true, nil, "zero_cups")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Cups)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Cups, special_colour = G.C.CUPS, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 2, card.ability and card.ability.extra or 4} }
  end,
  group_key = "k_cups_pack",
})

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_ace',
	pos = { x = 0, y = 0 },
	config = {
		max_highlighted = 1,
		suit_conv = "zero_Brights",
	},
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, localize(card.ability.suit_conv, 'suits_plural'), colours = {G.C.SUITS[card.ability.suit_conv] }, } }
    end,
	use = function(self, card)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:change_suit(card.ability.consumeable.suit_conv);return true end }))
        end    
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.0,
				func = (function()
					local card = create_card('Cups',G.consumeables, nil, nil, nil, nil, nil, 'cups_ace')
					card:add_to_deck()
					G.consumeables:emplace(card)
					G.GAME.consumeable_buffer = 0
				return true
			end)}))
		end
		delay(0.5)
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_two',
	pos = { x = 1, y = 0 },
	config = {
		generate = { "Prestige", "Planet"}
	},
	can_use = function(self, card)
		return (G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit) or (card.area == G.consumeables)
	end,
	use = function(self, card)
		local count = 1
        for i = 1, math.min(#card.ability.generate, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ set = card.ability.generate[count] })
                        card:juice_up(0.3, 0.5)
						count = count + 1
                    end
                    return true
                end
            }))
        end
        delay(0.6)
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_three',
	pos = { x = 2, y = 0 },
	config = {
		max_highlighted = 5,
		random_mod_conv = {"m_steel","m_gold","m_zero_sunsteel"},
	},
	loc_vars = function(self, info_queue, card)
		for _, v in pairs(card.ability.random_mod_conv) do
			info_queue[#info_queue + 1] = G.P_CENTERS[v]
		end
        return { vars = { card.ability.max_highlighted} }
    end,
	can_use = function(self, card)
		if G.hand and (G.hand.highlighted and #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted > 0) then
			for _, v in pairs(G.hand.highlighted) do
				if not next(SMODS.get_enhancements(v)) then
					return false
				end
			end
			return true
		end
		return false
	end,
	use = function(self, card)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:set_ability(pseudorandom_element(card.ability.random_mod_conv, "cups_two"));return true end }))
        end    
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
		delay(0.5)
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_four',
	pos = { x = 3, y = 0 },
	can_use = function(self, card)
		return G.hand and G.hand.highlighted and #G.hand.highlighted == 1
	end,
	use = function(self, card)
		local _target = G.hand.highlighted[1]
        for i = 1, #G.hand.cards do
            if G.hand.cards[i] == _target and (G.hand.cards[i-1] or G.hand.cards[i+1]) then
				local to_buff = {}
				for _, v in pairs({i-1,i+1}) do
					if G.hand.cards[v] then
						to_buff[#to_buff+1] = G.hand.cards[v]
					end
				end
				if _target.config.center.key ~= "c_base" or _target.seal or _target.edition then
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
					_target:flip();play_sound('card1');_target:juice_up(0.3, 0.3)
					for _, v in pairs(to_buff) do
						v:flip();play_sound('card1');v:juice_up(0.3, 0.3)
					end
					return true end }))
					delay(0.2)
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
					for _, v in pairs(to_buff) do
						if _target.config.center.key ~= "c_base" then
							v:set_ability(_target.config.center.key)
						end
						if _target.seal then
							v:set_seal(_target.seal,true)
						end
						if _target.edition then
							v:set_edition(_target.edition,true)
						end
					end
					_target:set_ability('c_base')
					_target:set_seal()
					_target:set_edition()
					return true end }))
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
					for _, v in pairs(to_buff) do
					v:flip();play_sound('tarot2', nil, 0.6);v:juice_up(0.3, 0.3)
					end
					_target:flip();play_sound('tarot2', nil, 0.6);_target:juice_up(0.3, 0.3)
					return true end }))
				end
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				return true end }))
				break
			end
        end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.6)
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_five',
	pos = { x = 4, y = 0 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
    end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card)
		if #G.consumeables.cards > 0 then
			pseudorandom_element(G.consumeables.cards, "cups_two"):set_edition("e_negative")
		end
		card:juice_up(0.3, 0.5)
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_six',
	pos = { x = 0, y = 1 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key = 'eternal', set = 'Other'}
	end,
	can_use = function(self, card)
        return G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1
    end,
	use = function(self, card)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
				play_sound('tarot1')
                G.jokers.highlighted[1].ability.eternal = true
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.jokers:unhighlight_all(); return true end }))
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_seven',
	pos = { x = 1, y = 1 },
	config = {
		max_highlighted = 2,
	},
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted} }
    end,
	use = function(self, card)
		local _givenseal
		local given____
		for _, v in pairs(G.hand.highlighted) do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					play_sound('tarot1')
					_givenseal = SMODS.poll_seal({guaranteed = true, type_key = seal_type})
					while _givenseal == nil or _givenseal == "akyrs_debuff" do
						_givenseal = SMODS.poll_seal({guaranteed = true, type_key = seal_type})
					end
					v:set_seal(_givenseal)
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_knight',
	pos = { x = 1, y = 2 },
	config = {
		max_highlighted = 1,
		mod_conv = "m_zero_sunsteel",
		boost = 0.1
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_zero_sunsteel
        return { vars = { card.ability.max_highlighted, 
		localize{
			type = 'name_text',
			set = 'Enhanced',
			key = card.ability.mod_conv
		},
		card.ability.max_highlighted == 1 and "" or "s", 
		card.ability.boost } }
    end,
	use = function(self, card)
		G.GAME.zero_sunsteel_pow = G.GAME.zero_sunsteel_pow or 0
		G.GAME.zero_sunsteel_pow = G.GAME.zero_sunsteel_pow + card.ability.boost
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:set_ability(card.ability.consumeable.mod_conv);return true end }))
        end    
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
		delay(0.5)
    end
}