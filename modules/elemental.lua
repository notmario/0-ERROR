SMODS.Atlas {
  key = "zero_elemental",
  px = 71,
  py = 95,
  path = "zero_elemental.png"
}

SMODS.ConsumableType {
  key = "Elemental",
  primary_colour = HEX("E4BE7D"),
  secondary_colour = HEX("D16F3E"),
  loc_txt = {
    name = 'Element', -- used on card type badges
 		collection = 'Elemental Cards', -- label for the button to access the collection
 		undiscovered = { -- description for undiscovered cards in the collection
 			name = 'Undiscovered',
 			text = { '???' },
 		},
  },
  collection_rows = { 5, 5, 6 },
  shop_rate = 0.0
}

zero_base_elements = {"c_zero_fire", "c_zero_earth", "c_zero_water", "c_zero_air", "c_zero_cosmos"}

SMODS.UndiscoveredSprite {
    key = "Elemental",
    atlas = "zero_elemental",
    pos = {x = 5, y = 2} 
}
  
SMODS.Booster({
  key = "elemental_normal_1",
  kind = "Elemental",
  atlas = "zero_booster",
  pos = { x = 0, y = 1 },
  config = { extra = 5, choose = 2 },
  cost = 6,
  draw_hand = false,
  weight = 0.48,
  unlocked = true,
  discovered = true,
  create_card = function(self, card, i)
    local n_card = create_card("Elemental", G.pack_cards, nil, nil, true, true, zero_base_elements[i], "zero_elemental")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Elemental)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Elemental, special_colour = G.C.ELEMENTAL, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 2} }
  end,
  group_key = "k_elemental_pack",
})
SMODS.Booster({
  key = "elemental_normal_2",
  kind = "Elemental",
  atlas = "zero_booster",
  pos = { x = 1, y = 1 },
  config = { extra = 5, choose = 2 },
  cost = 6,
  draw_hand = false,
  weight = 0.48,
  unlocked = true,
  discovered = true,
  create_card = function(self, card, i)
    local n_card = create_card("Elemental", G.pack_cards, nil, nil, true, true, zero_base_elements[i], "zero_elemental")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Elemental)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Elemental, special_colour = G.C.ELEMENTAL, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 2} }
  end,
  group_key = "k_elemental_pack",
})
SMODS.Booster({
  key = "elemental_jumbo_1",
  kind = "Elemental",
  atlas = "zero_booster",
  pos = { x = 2, y = 1 },
  config = { extra = 6, choose = 2 },
  cost = 8,
  draw_hand = false,
  weight = 0.48,
  unlocked = true,
  discovered = true,
  create_card = function(self, card, i)
    local n_card = create_card("Elemental", G.pack_cards, nil, nil, true, true, zero_base_elements[i], "zero_elemental")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Elemental)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Elemental, special_colour = G.C.ELEMENTAL, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 1, 5, card.ability and card.ability.extra - 5 or 1, card.ability.extra - 5 == 1 and "" or "s"} }
  end,
  group_key = "k_elemental_pack",
})
SMODS.Booster({
  key = "elemental_mega_1",
  kind = "Elemental",
  atlas = "zero_booster",
  pos = { x = 3, y = 1 },
  config = { extra = 6, choose = 3 },
  cost = 9,
  draw_hand = false,
  weight = 0.24,
  unlocked = true,
  discovered = true,
  create_card = function(self, card, i)
    local n_card = create_card("Elemental", G.pack_cards, nil, nil, true, true, zero_base_elements[i], "zero_elemental")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Elemental)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Elemental, special_colour = G.C.ELEMENTAL, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 1, 5, card.ability and card.ability.extra - 5 or 1, card.ability.extra - 5 == 1 and "" or "s"} }
  end,
  group_key = "k_elemental_pack",
})

--taking cards from packs instead of using them, as seen in Cryptid, Betmma, MoreFluff, Unstable...
G.FUNCS.can_take_card = function(e)
	local card = e.config.ref_table
	local neg_buffer = (card.edition or {}).key == 'e_negative' and 1 or 0
	if #G.consumeables.cards < G.consumeables.config.card_limit + neg_buffer then
		  e.config.colour = G.C.GREEN
		  e.config.button = "take_card"
	else
		  e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		  e.config.button = nil
	end
end

G.FUNCS.take_card = function(e)
local c1 = e.config.ref_table
G.E_MANAGER:add_event(Event({
  trigger = "after",
  delay = 0.1,
  func = function()
	c1.area:remove_card(c1)
	c1:add_to_deck()
	if c1.children.price then
	  c1.children.price:remove()
	end
	c1.children.price = nil
	if c1.children.buy_button then
	  c1.children.buy_button:remove()
	end
	c1.children.buy_button = nil
	remove_nils(c1.children)
	play_sound('generic1')
	G.consumeables:emplace(c1)
	G.GAME.pack_choices = G.GAME.pack_choices - 1
	if G.GAME.pack_choices <= 0 then
	  G.FUNCS.end_consumeable(nil, delay_fac)
	end
	return true
  end,
}))
end

local G_UIDEF_card_focus_ui_ref = G.UIDEF.card_focus_ui

function G.UIDEF.card_focus_ui(card)
	base_background = G_UIDEF_card_focus_ui_ref(card)
	local card_width = card.T.w + (card.ability.consumeable and -0.1 or card.ability.set == 'Voucher' and -0.16 or 0)
	local base_attach = base_background:get_UIE_by_ID('ATTACH_TO_ME')
	if ((card.area == G.pack_cards and G.pack_cards)) and card.ability.consumeable and card.ability.set == "Elemental" then
		base_attach.children.use = G.UIDEF.card_focus_button{
		card = card, parent = base_attach, type = 'select',
		func = 'can_take_card', button = 'use_card', card_width = card_width
		}
	end
	return base_background
end

local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then
	  if card.ability.set == "Elemental" then
		return {
		  n = G.UIT.ROOT,
		  config = { padding = -0.1, colour = G.C.CLEAR },
		  nodes = {
			{
			  n = G.UIT.R,
			  config = {
				ref_table = card,
				r = 0.08,
				padding = 0.1,
				align = "bm",
				minw = 0.5 * card.T.w - 0.15,
				minh = 0.7 * card.T.h,
				maxw = 0.7 * card.T.w - 0.15,
				hover = true,
				shadow = true,
				colour = G.C.UI.BACKGROUND_INACTIVE,
				one_press = true,
				button = "use_card",
				func = "can_take_card",
			  },
			  nodes = {
				{
				  n = G.UIT.T,
				  config = {
					text = "SELECT",
					colour = G.C.UI.TEXT_LIGHT,
					scale = 0.55,
					shadow = true,
				  },
				},
			  },
			},
		  },
		}
	  end
	end
	return G_UIDEF_use_and_sell_buttons_ref(card)
end

--stuff to make base element cards combine
function zero_mix_elements(a, b)
    if a == b then return nil end
    local x, y = a < b and a or b, a < b and b or a
    local key = x .. "+" .. y
    return zero_elements_mix[key]
end
zero_elements_mix = {
	["c_zero_air+c_zero_cosmos"]   = "c_zero_comet",
    ["c_zero_air+c_zero_earth"]    = "c_zero_tornado",
    ["c_zero_air+c_zero_fire"]     = "c_zero_lightning",
    ["c_zero_air+c_zero_water"]    = "c_zero_rain",
    ["c_zero_cosmos+c_zero_earth"] = "c_zero_planets",
    ["c_zero_cosmos+c_zero_fire"]  = "c_zero_star",
    ["c_zero_cosmos+c_zero_water"] = "c_zero_nebulae",
    ["c_zero_earth+c_zero_fire"]   = "c_zero_lava",
    ["c_zero_earth+c_zero_water"]  = "c_zero_forest",
    ["c_zero_fire+c_zero_water"]   = "c_zero_geyser",
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'fire',
	pos = { x = 0, y = 0 },
	config = { max_highlighted = 2 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {set = "Other", key = 'zero_base_elements_reminder'}
        return { vars = { card.ability.max_highlighted } }
    end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                SMODS.destroy_cards(G.hand.highlighted)
                return true
            end
        }))
        delay(0.3)
    end,
	can_use = function(self, card)
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted then
			for k, v in pairs(G.hand.highlighted) do
				if v:is_suit("Hearts") == false then
					return false
				end
			end
			return true
		end
    end,
	add_to_deck = function(self, card, from_debuff)
		local possible_mix
		for k,v in ipairs(G.consumeables.cards) do
			if zero_mix_elements(v.config.center.key, card.config.center.key) then
				possible_mix = v
				break
			end
		end
		if possible_mix and not possible_mix.mixed then
			possible_mix.mixed = true
			SMODS.destroy_cards({possible_mix, card})
			SMODS.add_card {
				set = 'Elemental',
				key = zero_mix_elements(possible_mix.config.center.key, card.config.center.key)
			}
		end
	end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_base'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'earth',
	pos = { x = 1, y = 0 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {set = "Other", key = 'zero_base_elements_reminder'}
		info_queue[#info_queue+1] = G.P_CENTERS.m_stone
	end,
	use = function(self, card, area, copier)
		local count = 0
		local nonstones = {}
		local targets = {}
        for k, v in pairs(G.hand.cards) do
			if v:is_suit("Spades") then
				count = count + 1
			end
			if v.config.center ~= G.P_CENTERS.m_stone then
				nonstones[#nonstones + 1] = v
			end
		end
		if #nonstones > count then
			for i = 1, count do
				local _choice = pseudorandom_element(nonstones, "earth")
				for i, v in ipairs(nonstones) do if v == _choice then table.remove(nonstones, i) break end end
				targets[#targets + 1] = _choice
			end
		else
			targets = nonstones
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #targets do
            local percent = 1.15 - (i-0.999)/(#targets-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() targets[i]:flip();play_sound('card1', percent);targets[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #targets do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() targets[i]:set_ability("m_stone");return true end }))
        end    
        for i=1, #targets do
            local percent = 0.85 + (i-0.999)/(#targets-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() targets[i]:flip();play_sound('tarot2', percent, 0.6);targets[i]:juice_up(0.3, 0.3);return true end }))
        end
		delay(0.5)
    end,
	can_use = function(self, card)
        if G.hand and #G.hand.cards > 0 then
			for k, v in pairs(G.hand.cards) do
				if v:is_suit("Spades") then
					return true
				end
			end
			return false
		end
    end,
	add_to_deck = function(self, card, from_debuff)
		local possible_mix
		for k,v in ipairs(G.consumeables.cards) do
			if zero_mix_elements(v.config.center.key, card.config.center.key) then
				possible_mix = v
				break
			end
		end
		if possible_mix and not possible_mix.mixed then
			possible_mix.mixed = true
			SMODS.destroy_cards({possible_mix, card})
			SMODS.add_card {
				set = 'Elemental',
				key = zero_mix_elements(possible_mix.config.center.key, card.config.center.key)
			}
		end
	end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_base'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'water',
	pos = { x = 2, y = 0 },
	config = { highlighted = 5, extra = {created = 2} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {set = "Other", key = 'zero_base_elements_reminder'}
        return { vars = { card.ability.extra.created, card.ability.highlighted } }
    end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
		for i = 1,card.ability.extra.created do
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.0,
					func = function()
						local randomcons = create_card('Consumeables',G.consumeables, nil, nil, nil, nil, nil, 'water')
						randomcons:add_to_deck()
						G.consumeables:emplace(randomcons)
						G.GAME.consumeable_buffer = 0
						card:juice_up()
					return true
				end}))
			end
		end
		delay(0.3)
    end,
	can_use = function(self, card)
        if G.hand and #G.hand.highlighted == card.ability.highlighted then
			for k, v in pairs(G.hand.highlighted) do
				if v:is_suit("Clubs") == false then
					return false
				end
			end
			return true
		end
    end,
	add_to_deck = function(self, card, from_debuff)
		local possible_mix
		for k,v in ipairs(G.consumeables.cards) do
			if zero_mix_elements(v.config.center.key, card.config.center.key) then
				possible_mix = v
				break
			end
		end
		if possible_mix and not possible_mix.mixed then
			possible_mix.mixed = true
			SMODS.destroy_cards({possible_mix, card})
			SMODS.add_card {
				set = 'Elemental',
				key = zero_mix_elements(possible_mix.config.center.key, card.config.center.key)
			}
		end
	end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_base'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'air',
	pos = { x = 3, y = 0 },
	config = { extra = { draw = 3} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {set = "Other", key = 'zero_base_elements_reminder'}
        return { vars = { card.ability.extra.draw } }
    end,
	use = function(self, card, area, copier)
		local diamonds = {}
		local chosendiamonds = {}
		for k, v in ipairs(G.deck.cards) do
			if v:is_suit("Diamonds") then
				diamonds[#diamonds + 1] = v
			end
		end
		if #diamonds > card.ability.extra.draw then
			for i = 1,card.ability.extra.draw do
				local _choice = pseudorandom_element(diamonds, "air")
				for i, v in ipairs(diamonds) do if v == _choice then table.remove(diamonds, i) break end end
				chosendiamonds[#chosendiamonds + 1] = _choice
			end
		else
			chosendiamonds = diamonds
		end
		for i = 1, #chosendiamonds do
			draw_card(G.deck, G.hand, nil, nil, nil, chosendiamonds[i])
			G.E_MANAGER:add_event(Event({
				func = function()
					card:juice_up()
					return true
				end
			}))
		end
		delay(0.3)
    end,
	can_use = function(self, card)
        if G.hand and #G.hand.cards > 0 then
			for k, v in ipairs(G.deck.cards) do
				if v:is_suit("Diamonds") then
					return true
				end
			end
			return false
		end
    end,
	add_to_deck = function(self, card, from_debuff)
		local possible_mix
		for k,v in ipairs(G.consumeables.cards) do
			if zero_mix_elements(v.config.center.key, card.config.center.key) then
				possible_mix = v
				break
			end
		end
		if possible_mix and not possible_mix.mixed then
			possible_mix.mixed = true
			SMODS.destroy_cards({possible_mix, card})
			SMODS.add_card {
				set = 'Elemental',
				key = zero_mix_elements(possible_mix.config.center.key, card.config.center.key)
			}
		end
	end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_base'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'cosmos',
	pos = { x = 4, y = 0 },
	config = { max_highlighted = 2 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {set = "Other", key = 'zero_base_elements_reminder'}
        return { vars = { colours = {G.C.SUITS.zero_Brights} } }
    end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                local _first_dissolve = nil
                local new_cards = {}
				local _suits = {}
				for k, v in pairs(SMODS.Suit.obj_table) do
					if G.hand.highlighted[1]:is_suit(k) and k ~= "zero_Brights" then
						_suits[#_suits + 1] = k
					end
				end
                for i = 1, #_suits do
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
                    _card:change_suit(_suits[i])
					_card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.hand:emplace(_card)
                    _card:start_materialize(nil, _first_dissolve)
                    _first_dissolve = true
                    new_cards[#new_cards + 1] = _card
                end
                SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                return true
            end
        }))
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                SMODS.destroy_cards(G.hand.highlighted)
                return true
            end
        }))
        delay(0.3)
    end,
	can_use = function(self, card)
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted then
			for k, v in pairs(G.hand.highlighted) do
				if v:is_suit("zero_Brights") == false then
					return false
				end
			end
			return true
		end
    end,
	add_to_deck = function(self, card, from_debuff)
		local possible_mix
		for k,v in ipairs(G.consumeables.cards) do
			if zero_mix_elements(v.config.center.key, card.config.center.key) then
				possible_mix = v
				break
			end
		end
		if possible_mix and not possible_mix.mixed then
			possible_mix.mixed = true
			SMODS.destroy_cards({possible_mix, card})
			SMODS.add_card {
				set = 'Elemental',
				key = zero_mix_elements(possible_mix.config.center.key, card.config.center.key)
			}
		end
	end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_base'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'lava',
	pos = { x = 0, y = 1 },
	config = {
		random_mod_conv = {"m_steel","m_gold","m_zero_sunsteel"},
	},
	loc_vars = function(self, info_queue, card)
		for _, v in pairs(card.ability.random_mod_conv) do
			info_queue[#info_queue + 1] = G.P_CENTERS[v]
		end
    end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
        return true end }))
        local to_enhance = #G.hand.highlighted
		SMODS.destroy_cards(G.hand.highlighted)
		local unenhanced = {}
		for k,v in ipairs(G.deck.cards) do
			if v.ability.set ~= "Enhanced" then
				unenhanced[#unenhanced + 1] = v
			end
		end
		for i = 1,to_enhance do
			if #unenhanced == 0 then break
			else
				local _choice = pseudorandom_element(unenhanced, "lava")
				for j, v in ipairs(unenhanced) do if v == _choice then table.remove(unenhanced, j) break end end
				_choice:set_ability(pseudorandom_element(card.ability.random_mod_conv, "lava"))
			end
		end
		delay(0.3)
    end,
	can_use = function(self, card)
        if G.hand and #G.hand.highlighted > 0 then
			for k, v in pairs(G.hand.highlighted) do
				if v:is_suit("Hearts") == false and v:is_suit("Spades") == false then
					return false
				end
			end
			return true
		end
    end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_mix'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'forest',
	pos = { x = 1, y = 1 },
	config = { max_highlighted = 3 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        return { vars = { card.ability.max_highlighted } }
    end,
	use = function(self, card, area, copier)
		local _cards = #G.hand.highlighted
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:set_ability('c_base');return true end }))
        end    
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
		for i=1, _cards do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.0,
				func = (function()
					local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'forest')
					card:add_to_deck()
					card:set_edition("e_negative", true)
					G.consumeables:emplace(card)
				return true
			end)}))
		end
		delay(0.5)
    end,
	can_use = function(self, card)
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted then
			for k, v in pairs(G.hand.highlighted) do
				if v.ability.set ~= "Enhanced" or (v:is_suit("Clubs") == false and v:is_suit("Spades") == false) then
					return false
				end
			end
			return true
		end
    end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_mix'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'geyser',
	pos = { x = 2, y = 1 },
	loc_vars = function(self, info_queue, card)
		local value
		if G.hand and #G.hand.highlighted > 0 then
			value = 0
			for k, v in pairs(G.hand.highlighted) do
				value = value + v.base.nominal + v.ability.perma_bonus or 0
			end
			info_queue[#info_queue + 1] = G.P_CENTERS[G.P_CENTER_POOLS.Consumeables[value % #G.P_CENTER_POOLS.Consumeables].key]
		end
		return { vars = { value or 0, value and " = " or "", value and G.P_CENTER_POOLS.Consumeables[value % #G.P_CENTER_POOLS.Consumeables].name or "" } }
    end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
        return true end }))
		local value = 0
		for k, v in pairs(G.hand.highlighted) do
			value = value + v.base.nominal + v.ability.perma_bonus or 0
		end
		SMODS.destroy_cards(G.hand.highlighted)
		value = value % #G.P_CENTER_POOLS.Consumeables
		SMODS.add_card({ key = G.P_CENTER_POOLS.Consumeables[value].key })
		delay(0.3)
    end,
	can_use = function(self, card)
        if G.hand and #G.hand.highlighted > 0 then
			for k, v in pairs(G.hand.highlighted) do
				if v:is_suit("Hearts") == false and v:is_suit("Clubs") == false then
					return false
				end
			end
			return true
		end
    end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_mix'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'lightning',
	pos = { x = 3, y = 1 },
	config = { extra = { destroy = 3} },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.destroy } }
    end,
	use = function(self, card, area, copier)
		local eligible = {}
		for k, v in ipairs(G.deck.cards) do
			if v:is_suit("Diamonds") or v:is_suit("Hearts") then
				eligible[#eligible + 1] = v
			end
		end
		local _choice
		local to_destroy = {}
		for i = 1, math.min(card.ability.extra.destroy, #eligible) do
			_choice = pseudorandom_element(eligible, "lightning")
			for i, v in ipairs(eligible) do if v == _choice then table.remove(eligible, i) break end end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
            card:juice_up(0.3, 0.5)
			return true end }))
			draw_card(G.deck, G.play, nil, nil, nil, _choice)
            to_destroy[#to_destroy + 1] = _choice
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local money = 0
			for k, v in pairs(to_destroy) do
				money = money + v.base.nominal + v.ability.perma_bonus or 0
			end
			SMODS.destroy_cards(to_destroy)
			ease_dollars(money)
		return true end }))
    end,
	can_use = function(self, card)
		for k, v in ipairs(G.deck.cards) do
			if v:is_suit("Diamonds") or v:is_suit("Hearts") then
				return true
			end
		end
		return false
    end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_mix'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'rain',
	pos = { x = 4, y = 1 },
	config = { max_highlighted = 3 },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
	use = function(self, card, area, copier)
		local new_cards = {}
		for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event({
				func = function()
					local _first_dissolve = nil
					G.playing_card = (G.playing_card and G.playing_card + 1) or 1
					local _card = copy_card(G.hand.highlighted[i], nil, nil, G.playing_card)
					_card:add_to_deck()
					G.deck.config.card_limit = G.deck.config.card_limit + 1
					table.insert(G.playing_cards, _card)
					G.hand:emplace(_card)
					_card:start_materialize(nil, _first_dissolve)
					_first_dissolve = true
					new_cards[#new_cards + 1] = _card
					return true
				end
			}))
		end
		G.E_MANAGER:add_event(Event({
			func = function()
				SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
				return true
			end
		}))
    end,
	can_use = function(self, card)
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted then
			for k, v in pairs(G.hand.highlighted) do
				if v:is_suit("Clubs") == false and v:is_suit("Diamonds") == false then
					return false
				end
			end
			return true
		end
    end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_mix'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'tornado',
	pos = { x = 5, y = 1 },
	config = { extra = { draw = 4} },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.draw } }
    end,
	use = function(self, card, area, copier)
		local eligible = {}
		local _chosen = {}
		for k, v in ipairs(G.deck.cards) do
			if v:is_suit("diamonds") or v:is_suit("Spades") then
				eligible[#eligible + 1] = v
			end
		end
		if #eligible > card.ability.extra.draw then
			for i = 1,card.ability.extra.draw do
				local _choice = pseudorandom_element(eligible, "air")
				for i, v in ipairs(eligible) do if v == _choice then table.remove(eligible, i) break end end
				_chosen[#_chosen + 1] = _choice
			end
		else
			_chosen = eligible
		end
		for i = 1, #_chosen do
			if _chosen[i].ability.set ~= "Enhanced" then
				_chosen[i]:set_ability(G.P_CENTERS[SMODS.poll_enhancement({guaranteed = true})])
			end
			draw_card(G.deck, G.hand, nil, nil, nil, _chosen[i])
			G.E_MANAGER:add_event(Event({
				func = function()
					card:juice_up()
					return true
				end
			}))
		end
		delay(0.3)
    end,
	can_use = function(self, card)
        if G.hand and #G.hand.cards > 0 then
			for k, v in ipairs(G.deck.cards) do
				if v:is_suit("Diamonds") or v:is_suit("Spades") then
					return true
				end
			end
			return false
		end
    end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_mix'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

function zero_check_four_suits(cards)
    local suits = {"Hearts", "Spades", "Diamonds", "Clubs"}
    local used = {
        Hearts = false,
        Spades = false,
        Diamonds = false,
        Clubs = false,
    }
    local function dfs(i)
        if i > #cards then
            for _, s in ipairs(suits) do
                if not used[s] then
                    return false
                end
            end
            return true
        end
        local card = cards[i]
        local tried_any = false
        for _, s in ipairs(suits) do
            if not used[s] and card:is_suit(s) then
                used[s] = true
                if dfs(i + 1) then return true end
                used[s] = false
                tried_any = true
            end
        end
        return dfs(i + 1)
    end
    return dfs(1)
end
SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'star',
	pos = { x = 0, y = 2 },
	loc_vars = function(self, info_queue, card)
        return { vars = { colours = {G.C.SUITS.zero_Brights} } }
    end,
	use = function(self, card, area, copier)
        local ranks = {}
		local enhancements = {}
		local editions = {}
		local seals = {}
		for k, v in ipairs(G.hand.highlighted) do
			ranks[#ranks+1] = v.base.value
			if v.ability.set == "Enhanced" then
				enhancements[#enhancements+1] = v.config.center.key
			end
			if v.edition then
				editions[#editions+1] = v.edition
			end
			if v.seal then
				seals[#seals+1] = v.seal
			end
		end
		SMODS.destroy_cards(G.hand.highlighted)
		SMODS.add_card {
			set = "Base",
			suit = "zero_Brights",
			rank = pseudorandom_element(ranks, "star"),
			enhancement = pseudorandom_element(enhancements, "star"),
			edition = pseudorandom_element(editions, "star"),
			seal = pseudorandom_element(seals, "star")
		}
    end,
	can_use = function(self, card)
		if G.hand and #G.hand.highlighted == 4 then
			return zero_check_four_suits(G.hand.highlighted)
		end
		return false
	end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_mix'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'planets',
	pos = { x = 1, y = 2 },
	loc_vars = function(self, info_queue, card)
        return { vars = { colours = {G.C.SUITS.zero_Brights} } }
    end,
	use = function(self, card, area, copier)
		local to_strip = {}
        for k, v in ipairs(G.hand.cards) do
			for _ in pairs(SMODS.get_enhancements(v)) do to_strip[#to_strip + 1] = v break end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #to_strip do
            local percent = 1.15 - (i-0.999)/(#to_strip-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() to_strip[i]:flip();play_sound('card1', percent);to_strip[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #to_strip do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() to_strip[i]:set_ability('c_base'); to_strip[i]:change_suit("zero_Brights");return true end }))
        end    
        for i=1, #to_strip do
            local percent = 0.85 + (i-0.999)/(#to_strip-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() to_strip[i]:flip();play_sound('tarot2', percent, 0.6);to_strip[i]:juice_up(0.3, 0.3);return true end }))
        end
		delay(0.5)
    end,
	can_use = function(self, card)
		if G.hand and #G.hand.cards > 0 then
			for k, v in ipairs(G.hand.cards) do
				for _ in pairs(SMODS.get_enhancements(v)) do return true end
			end
			return false
		end
	end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_mix'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'nebulae',
	pos = { x = 2, y = 2 },
	config = { extra = {cards = 2} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_SEALS["Blue"]
		info_queue[#info_queue + 1] = G.P_SEALS["Purple"]
        return { vars = { card.ability.extra.cards, colours = {G.C.SUITS.zero_Brights} } }
    end,
	use = function(self, card, area, copier)
		local seals_ = {"Blue", "Purple"}
		for i=1, card.ability.extra.cards do
			SMODS.add_card {
				set = "Base",
				suit = "zero_Brights",
				seal = seals_[i]
			}
		end
    end,
	can_use = function(self, card)
		if G.hand and #G.hand.cards > 0 then
			return true
		end
	end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_mix'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'comet',
	pos = { x = 3, y = 2 },
	config = { max_highlighted = 1, extra = { draw = 3} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_zero_gala
        return { vars = { card.ability.max_highlighted, card.ability.extra.draw, colours = {G.C.SUITS.zero_Brights} } }
    end,
	use = function(self, card, area, copier)
		local chosen_card = G.hand.highlighted[1]
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                chosen_card:set_edition("e_zero_gala", true)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
		delay(0.2)
		G.E_MANAGER:add_event(Event({
            func = function()
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
		delay(0.5)
		draw_card(G.hand, G.deck, nil, nil, nil,chosen_card)
		delay(0.5)
		for i=1, card.ability.extra.draw do
			G.E_MANAGER:add_event(Event({
				func = function()
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
			draw_card(G.deck, G.hand)
		end
		delay(0.5)
    end,
	can_use = function(self, card)
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted then
			for k, v in pairs(G.hand.highlighted) do
				if v:is_suit("zero_Brights") == false then
					return false
				end
			end
			return true
		end
    end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_mix'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}

SMODS.Consumable{
    set = 'Elemental',
	atlas = 'zero_elemental',
    key = 'wild',
	pos = { x = 4, y = 2 },
	config = {
		max_highlighted = 2,
		mod_conv = "m_wild",
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_wild
		info_queue[#info_queue + 1] = {set = "Other", key = 'zero_base_elements_reminder'}
        return { vars = { card.ability.max_highlighted } }
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:set_ability(card.ability.mod_conv);return true end }))
        end    
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        local elements = {pseudorandom_element(zero_base_elements,"wild")}
		local zero_base_elements_minus = {}
		for k, v in pairs(zero_base_elements) do
			if v ~= elements[1] then
				zero_base_elements_minus[#zero_base_elements_minus + 1] = v
			end
		end
		elements[2] = pseudorandom_element(zero_base_elements_minus,"wild")
		for i=1, 2 do
			if #G.consumeables.cards + G.GAME.consumeable_buffer - 1 < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.0,
					func = (function()
						local card = create_card('Elemental',G.consumeables, nil, nil, nil, nil, elements[i])
						card:add_to_deck()
						G.consumeables:emplace(card)
						G.GAME.consumeable_buffer = 0
					return true
				end)}))
			end
		end
		delay(0.5)
    end,
	set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_elemental_chaotic'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Elemental.text_colour,
            1.2)
    end
}