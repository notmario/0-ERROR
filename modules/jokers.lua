SMODS.Atlas {
  key = "zero_jokers",
  px = 71,
  py = 95,
  path = "zero_jokers.png"
}

SMODS.Joker {
  key = "mad",
  name = "Mutual Assured Destruction",
  config = {
  },
  pos = {x = 0, y = 0},
  atlas = "zero_jokers",
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = true,
  loc_vars = function(self, info_queue, center)
  end,
  calculate = function(self, card, context)
    if context.end_of_round and context.cardarea == G.jokers then
      if G.GAME.current_round.hands_left == 0 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
          trigger = 'before',
          delay = 0.0,
          func = (function()
              local card = create_card('Prestige',G.consumeables, nil, nil, nil, nil, nil, 'mad')
              card:add_to_deck()
              G.consumeables:emplace(card)
              G.GAME.consumeable_buffer = 0
            return true
          end)}))
        return {
          message = localize('k_plus_prestige'),
          colour = G.C.SECONDARY_SET.Spectral,
          card = card
        }
      end
    end
    if context.forcetrigger then
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
          trigger = 'before',
          delay = 0.0,
          func = (function()
              local card = create_card('Prestige',G.consumeables, nil, nil, nil, nil, nil, 'mad')
              card:add_to_deck()
              G.consumeables:emplace(card)
              G.GAME.consumeable_buffer = 0
            return true
          end)}))
        return {
          message = localize('k_plus_prestige'),
          colour = G.C.SECONDARY_SET.Spectral,
          card = card
        }
      end
    end
  end
}

SMODS.Joker {
  key = "paraquiet",
  name = "Paraquiet",
  config = {
    extra = {
      odds = 2,
      my_mult = 0,
      mult_per = 1,
    }
  },
  pos = {x = 2, y = 0},
  atlas = "zero_jokers",
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = true,
  loc_vars = function(self, info_queue, center)
    local new_numerator, new_denominator = SMODS.get_probability_vars(center, 1, center.ability.extra.odds, 'paraquiet')
    return {vars = {
      new_numerator, new_denominator,
      center.ability.extra.mult_per,
      center.ability.extra.my_mult,
    }}
  end,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers then
      local returns = {}
      for _, other_card in ipairs(context.full_hand) do
        if other_card.base.id ~= 2 and SMODS.pseudorandom_probability(card, 'paraquiet_poison', 1, card.ability.extra.odds, 'paraquiet') then
          card.ability.extra.my_mult = card.ability.extra.my_mult + card.ability.extra.mult_per
          returns[#returns + 1] = {
            message = localize("k_poisoned_ex"),
            colour = G.C.PURPLE,
            func = function()
              other_card:juice_up(0.5, 0.5)
              assert(SMODS.modify_rank(other_card, -1))
            end
          }
        end
      end
      return SMODS.merge_effects(returns)
    end
    if context.forcetrigger or context.joker_main then
      if card.ability.extra.my_mult ~= 0 then
        return {
          mult = card.ability.extra.my_mult
        }
      end
    end
  end
}

SMODS.Joker {
  key = "e_supercharge",
  name = "Energy Supercharge",
  config = {
    extra = {
      active = true,
    }
  },
  pos = {x = 4, y = 0},
  atlas = "zero_jokers",
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = false,
  zero_usable = true,
  -- keep_on_use = true,
  can_use = function(self, card)
    return G.STATE == G.STATES.SELECTING_HAND and card.ability.extra.active
  end,
  loc_vars = function(self, info_queue, center)
  end,
  calculate = function(self, card, context)
    if context.end_of_round and not card.ability.extra.active then
      card.ability.extra.active = true
      return {
        message = localize("k_charged_ex")
      }
    end
  end,
  use = function(self, card, area, copier)
    card.ability.extra.active = false

    local target_area = G.hand
    local suits = {"S", "H", "C", "D"}

    for _, _suit in ipairs(suits) do
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.4,
        func = function() 
          play_sound('tarot1')
          card:juice_up(0.3, 0.5)
          local cards = {}
          cards[1] = true
          local _rank = nil
          _rank = pseudorandom_element({'A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K'}, pseudoseed('energysupercharge'))
          local cen_pool = {}
          for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
            if v.key ~= 'm_stone' and not v.overrides_base_rank then 
              cen_pool[#cen_pool+1] = v
            end
          end
          local card = create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = pseudorandom_element(cen_pool, pseudoseed('energysupercharge'))}, target_area, nil, i ~= 1, {G.C.PURPLE})
          card.zero_temporary = true
          playing_card_joker_effects(cards)
          return true end }))
    end
    delay(0.5)
    draw_card(G.play, G.jokers, nil, 'up', nil, card)
  end,
}

SMODS.Joker {
  key = "awesome_face",
  name = "Awesome Face",
  config = {
    extra = {
      active = true,
    }
  },
  pos = {x = 6, y = 0},
  atlas = "zero_jokers",
  rarity = 1,
  cost = 1,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = false,
  zero_usable = true,
  -- keep_on_use = true,
  can_use = function(self, card)
    return card.ability.extra.active
  end,
  loc_vars = function(self, info_queue, center)
  end,
  calculate = function(self, card, context)
  end,
  use = function(self, card, area, copier)
    card.ability.extra.active = false
    for i = 1,8 do
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.8 / (i + 3),
        func = function() 
          play_sound('chips1', 0.8 + i * 0.1)
          card:juice_up(0.3, 0.5)

          G.GAME.chips = G.GAME.chips + G.GAME.blind.chips / 10
          return true end }))
    end

    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.7,
      func = function() 
        card:start_dissolve()
        return true end }))

    -- snippet taken from Magic the Jokering
    if not next(SMODS.find_mod("NotJustYet")) then
      G.E_MANAGER:add_event(Event({
      func = (function(t)
        if G.GAME.chips >= G.GAME.blind.chips then 
        G.E_MANAGER:add_event(
          Event({
            trigger = "immediate",
            func = function()
              if G.STATE ~= G.STATES.SELECTING_HAND then
                return false
              end
              G.STATE = G.STATES.HAND_PLAYED
              G.STATE_COMPLETE = true
              end_round()
              return true
            end,
          }),
          "other"
        )
      end
      return true end)
      }))
    end
  end,
}

local srh = save_run
save_run = function(self)
  local perma_monster_jokers = {}
  for i, card in ipairs(G.jokers.cards) do
    if card.config.center.key == "j_zero_perma_monster" then
      -- print("saving wow", i)
      perma_monster_jokers[i] = {}

      for _, copied_card in ipairs(card.ability.immutable.copied_jokers) do
        -- print(copied_card.config.center.key)
        perma_monster_jokers[i][#perma_monster_jokers[i] + 1] = copied_card:save()
      end
    end
  end

  G.GAME.zero_perma_monster_jokers = perma_monster_jokers

  srh(self)
end
local strh = Game.start_run
Game.start_run = function(self, args)
  strh(self, args)

  if G.GAME.zero_perma_monster_jokers then
    -- print("reinit")
    for i, cards in pairs(G.GAME.zero_perma_monster_jokers) do
      -- print(i)
      G.jokers.cards[i].ability.immutable.copied_jokers = {}
      for _, copied_card in pairs(cards) do
        local card = Card(0, 0, 1, 1, G.P_CENTERS.j_joker, G.P_CENTERS.c_base)
        card.T.x = math.huge
        card.T.y = math.huge
        card.T.H = 4 -- WTF ??
        card.T.h = 4
        card.T.w = 4
        card:load(copied_card)
        G.jokers.cards[i].ability.immutable.copied_jokers[#G.jokers.cards[i].ability.immutable.copied_jokers + 1] = card

        -- print(card.config.center.key)
      end
    end

    G.GAME.zero_perma_monster_jokers = nil
  end
end

SMODS.Joker {
  key = "perma_monster",
  name = "Perma Monster",
  config = {
    extra = {
      active = true,
    },
    immutable = {
      copied_jokers = {}
    }
  },
  pos = {x = 3, y = 0},
  atlas = "zero_jokers",
  rarity = 3,
  cost = 10,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = false,
  demicoloncompat = false,
  zero_usable = true,
  zero_stay_in_area = true,
  -- keep_on_use = true,
  can_use = function(self, card)
    return G.STATE == G.STATES.SELECTING_HAND and card.ability.extra.active
  end,
  loc_vars = function(self, info_queue, center)
    return { vars = { #center.ability.immutable.copied_jokers } }
  end,
  calculate = function(self, card, context)
    local returns = {}

    if not context.no_blueprint then

      for _, copied in ipairs(card.ability.immutable.copied_jokers) do

        -- based on code from Maximus (bootlegger)
        context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
        context.blueprint_card = context.blueprint_card or card
        local ret = copied:calculate_joker(context)
        context.blueprint = nil
        local eff_card = context.blueprint_card or card
        context.blueprint_card = nil
        if ret then
          ret.card = eff_card
          ret.colour = G.C.YELLOW
          returns[#returns + 1] = ret
        end
      end

    end
    
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss then
      card.ability.extra.active = true
    end

    return SMODS.merge_effects(returns)
  end,
  use = function(self, card, area, copier)
    local my_pos = 0
    -- print("asdf", my_pos)
    if G.jokers.cards[my_pos+1] and not card.getting_sliced and
      not SMODS.is_eternal(G.jokers.cards[my_pos+1], card) and not G.jokers.cards[my_pos+1].getting_sliced and
      not (G.jokers.cards[my_pos+1].config.center.key == "j_zero_perma_monster") then

      local sliced_card = G.jokers.cards[my_pos+1]
      -- print(sliced_card)
      sliced_card.getting_sliced = true
      G.GAME.joker_buffer = G.GAME.joker_buffer - 1
      G.E_MANAGER:add_event(Event({func = function()
        G.GAME.joker_buffer = 0

        local copied_card = copy_card(sliced_card)
        copied_card.T.x = math.huge
        copied_card.T.y = math.huge

        card.ability.immutable.copied_jokers[#card.ability.immutable.copied_jokers + 1] = copied_card
        
        card:juice_up(0.8, 0.8)
        sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
        play_sound('slice1', 0.96+math.random()*0.08)
      return true end }))
      
      card.ability.extra.active = false
    end
    -- delay(0.5)
    -- print("wow")
    draw_card(G.play, G.jokers, nil, 'up', nil, card)
  end,
}

SMODS.Joker {
  key = "elite_inferno",
  name = "Elite Inferno",
  config = {
    extra = {
      active = true,
      triggering = false,
      times_mult = 7,
    },
  },
  pos = {x = 5, y = 0},
  atlas = "zero_jokers",
  rarity = 3,
  cost = 9,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = true,
  zero_usable = true,
  -- keep_on_use = true,
  can_use = function(self, card)
    return G.STATE == G.STATES.SELECTING_HAND and card.ability.extra.active
  end,
  loc_vars = function(self, info_queue, center)
    return { vars = { 
      center.ability.extra.triggering and "active" or "inactive",
      center.ability.extra.times_mult
    } }
  end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.triggering then
      return {
        x_mult = card.ability.extra.times_mult
      }
    end
    
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss then
      card.ability.extra.active = true
    end
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      card.ability.extra.triggering = false
    end
  end,
  use = function(self, card, area, copier)
    card.ability.extra.active = false
    card.ability.extra.triggering = true
    delay(0.5)
    -- print("wow")
    draw_card(G.play, G.jokers, nil, 'up', nil, card)
  end,
}

SMODS.Joker {
  key = "defense_removal",
  name = "Defense Removal",
  config = {
    extra = {
      active = true,
    }
  },
  pos = {x = 8, y = 0},
  atlas = "zero_jokers",
  rarity = 2,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = false,
  zero_usable = true,
  -- keep_on_use = true,
  can_use = function(self, card)
    return card.ability.extra.active
  end,
  loc_vars = function(self, info_queue, center)
  end,
  calculate = function(self, card, context)
    if context.end_of_round and not card.ability.extra.active and G.GAME.blind.boss then
      card.ability.extra.active = true
      return {
        message = localize("k_charged_ex")
      }
    end
  end,
  use = function(self, card, area, copier)
    card.ability.extra.active = false
    G.E_MANAGER:add_event(Event({
      trigger = 'before',
      delay = 0.8,
      func = function() 
        card:juice_up(0.3, 0.5)

        G.GAME.blind.chips = math.floor(G.GAME.blind.chips / 4)
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        return true end }))

    -- snippet taken from Magic the Jokering
    if not next(SMODS.find_mod("NotJustYet")) then
      G.E_MANAGER:add_event(Event({
      func = (function(t)
        if G.GAME.chips >= G.GAME.blind.chips then 
        G.E_MANAGER:add_event(
          Event({
            trigger = "immediate",
            func = function()
              if G.STATE ~= G.STATES.SELECTING_HAND then
                return false
              end
              G.STATE = G.STATES.HAND_PLAYED
              G.STATE_COMPLETE = true
              end_round()
              return true
            end,
          }),
          "other"
        )
      end
      return true end)
      }))
    end
    delay(0.5)
    -- print("wow")
    draw_card(G.play, G.jokers, nil, 'up', nil, card)
  end,
}

SMODS.Joker {
  key = "dream_book",
  name = "Dream Book",
  config = {
    extra = {
      active = true,
      selected = false,
    }
  },
  pos = {x = 7, y = 0},
  atlas = "zero_jokers",
  rarity = 2,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = false,
  zero_usable = true,
  -- keep_on_use = true,
  can_use = function(self, card)
    return G.STATE == G.STATES.SELECTING_HAND and card.ability.extra.active
  end,
  loc_vars = function(self, info_queue, center)
  end,
  calculate = function(self, card, context)
    if context.end_of_round and not card.ability.extra.active and G.GAME.blind.boss then
      card.ability.extra.active = true
      return {
        message = localize("k_charged_ex")
      }
    end
    if context.end_of_round and card.ability.extra.selected then
      card.ability.extra.selected = false
      SMODS.change_play_limit(-1)
      SMODS.change_discard_limit(-1)
    end
  end,
  use = function(self, card, area, copier)
    card.ability.extra.active = false
    card.ability.extra.selected = true
    SMODS.change_play_limit(1)
    SMODS.change_discard_limit(1)

    local draw_count = #G.hand.cards
    
    SMODS.draw_cards(draw_count)

    delay(0.5)
    -- print("wow")
    draw_card(G.play, G.jokers, nil, 'up', nil, card)
  end,
}

SMODS.Joker {
	key = "brilliance",
	name = "Brilliance",
	config = {
		extra = {
			xmult = 1.5,
			dollars = 3,
		}
	},
	pos = {x = 9, y = 4},
	atlas = "zero_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_gold
		info_queue[#info_queue+1] = G.P_CENTERS.m_steel
		return { vars = {
			card.ability.extra.xmult,
			card.ability.extra.dollars
		}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.end_of_round then
			local ret = {}
			local function appendextra(tbl, _ret)
				if not tbl.extra then tbl.extra = _ret else
				appendextra(tbl.extra, _ret) end
			end
			if SMODS.has_enhancement(context.other_card,"m_gold") then
				appendextra(ret, {
					xmult = card.ability.extra.xmult,
				})
			end
			if SMODS.has_enhancement(context.other_card,"m_steel") then
				appendextra(ret, {
					dollars = card.ability.extra.dollars,
				})
			end
			if ret.extra then return ret.extra end
		end
	end,
	in_pool = function(self)
		for k,v in ipairs(G.playing_cards) do
			if SMODS.has_enhancement(v,"m_gold") or SMODS.has_enhancement(v,"m_steel") then
				return true
			end
		end
	end,
}

SMODS.Joker {
	key = "dragonsthorn",
	name = "Dragonsthorn",
	config = {
		extra = {
			xmult_mod = 0.05,
		}
	},
	pos = {x = 8, y = 4},
	atlas = "zero_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_zero_sunsteel
		local count = 0
		if G.deck then
			for k,v in ipairs(G.playing_cards) do
				if SMODS.has_enhancement(v, "m_zero_sunsteel") then
					count = count + 1
				end
			end
		end
		return { vars = {
			card.ability.extra.xmult_mod,
			1 + (card.ability.extra.xmult_mod * count)
		}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.end_of_round and SMODS.has_enhancement(context.other_card, "m_zero_sunsteel") then
			local count = 0
			for k,v in ipairs(G.playing_cards) do
				if SMODS.has_enhancement(v, "m_zero_sunsteel") then
					count = count + 1
				end
			end
			if count > 1 then -- idk
				return { xmult = 1 + (card.ability.extra.xmult_mod * count) }
			end
		end
	end,
	enhancement_gate = "m_zero_sunsteel",
}

-- WARNING: Joker not finished
SMODS.Joker {
  key = "dismantled_cube",
  name = "Dismantled Cube",
  loc_txt = {text = {
    "{C:attention}Cards{} are drawn in increasing order"
  }},
  pos = {x = 1, y = 0},
  atlas = "zero_jokers",
  rarity = 2,
  cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
  loc_vars = function(self,info_queue,card)
    return {}
  end,
  calculate = function(self,card,context)
    local order = {}
    local rank_order = {"zero_Brights","Spades","Hearts","Clubs","Diamonds"}
    local get_pos = function(t,k)
      for i,_ in pairs(t) do
            if t[i] == k then
          return i
        end
      end
    end
    if context.setting_blind then
      for i,playing_card in ipairs(G.deck.cards) do
        if G.deck.cards[i+1] then
          if get_pos(rank_order,playing_card.base.suit) > get_pos(rank_order,G.deck.cards[i+1].base.suit) then
            if playing_card:get_id() > G.deck.cards[i+1]:get_id() then
              table.insert(order,playing_card)
            end
          end
        end
        if SMODS.has_no_rank(playing_card) == true and SMODS.has_no_suit(playing_card) == true then
          table.insert(order,playing_card,#order)
        end
      end
      for i=1,#order do
        draw_card(G.deck, G.hand, nil, "up", nil, order[i])
        table.remove(order,i)
      end
    end
    if context.hand or context.discard then
      for i=1,#order do
        draw_card(G.deck, G.hand, nil, "up", nil, order[i])
        table.remove(order,i)
      end
    end
  end
}

SMODS.Joker {
	key = "venture_card",
	name = "Venture Card",
	config = {
		extra = {
		}
	},
	pos = {x = 5, y = 4},
	atlas = "zero_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_zero_suit_yourself
    end,
    calculate = function(self, card, context)
        if context.setting_blind or context.forcetrigger then
            local sy_card = SMODS.create_card { set = "Base", enhancement = "m_zero_suit_yourself", area = G.discard }
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            sy_card.playing_card = G.playing_card
            table.insert(G.playing_cards, sy_card)
			sy_card.states.visible = false

            G.E_MANAGER:add_event(Event({
                func = function()
                    G.play:emplace(sy_card)
					sy_card.states.visible = true
                    sy_card:start_materialize({ G.C.SUITS.Spades, G.C.SUITS.Hearts, G.C.SUITS.Clubs, G.C.SUITS.Diamonds })
                    return true
                end
            }))
            return {
                message = localize('k_plus_suit_yourself'),
                colour = G.C.SECONDARY_SET.Enhanced,
                func = function()
                    G.E_MANAGER:add_event(Event({
						trigger = "after",
                        func = function()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
							draw_card(G.play, G.deck, 100, 'up', nil, sy_card)
							SMODS.calculate_context({ playing_card_added = true, cards = { sy_card } })
                            return true
                        end
                    }))
                end
            }
        end
    end
}

SMODS.Joker {
	key = "alpine_lily",
	name = "Alpine Lily",
	config = {
		extra = {
			odds = {
				new_effect = 3,
				lose_effect = 3,
				change_effect = 5,
				gain_value = 12,
				lose_value = 8,
				nothing = 1,
				plus_mutation = 2,
				minus_mutation = 1,
			},
			min_new_value = 1,
			max_new_value = 10,
			min_gain_value = 1,
			max_gain_value = 15,
			min_lose_value = 1,
			max_lose_value = 10,
			mutations_per_round = 1,
			mutations = {
				{ effect = "mult", value = 4 },
			}
		}
	},
	pos = {x = 0, y = 1},
	atlas = "zero_jokers",
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	
	blueprint_compat = true,
	
	-- Alright buckle up because this is where it gets weird
	
	lily_mutation_effects = {
		mult = {
			calculate = function(self, card, value)
				return {
					mult = value * 1
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { value * 1 } }
			end,
		},
		chips = {
			calculate = function(self, card, value)
				return {
					chips = value * 5
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { value * 5 } }
			end,
		},
		xmult = {
			calculate = function(self, card, value)
				return {
					xmult = 1 + (value * 0.025)
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { 1 + (value * 0.025) } }
			end,
		},
		xchips = {
			calculate = function(self, card, value)
				return {
					xchips = 1 + (value * 0.025)
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { 1 + (value * 0.025) } }
			end,
		},
		dollars = {
			calculate = function(self, card, value)
				return {
					dollars = math.floor(value * 0.4)
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { math.floor(value * 0.4) } }
			end,
		},
	},
	
	-- Returns a list of every valid mutation effect
	lily_list_mutation_effects = function(self)
		local ret = {}
		for key,effect in pairs(self.lily_mutation_effects) do
			if type(effect.in_pool) ~= "function" or effect:in_pool() then
				ret[#ret+1] = key
			end
		end
		return ret
	end,
	
	-- Creates a new mutation and places it into the mutations of card
	lily_create_mutation = function(self, card)
		local mutations = self:lily_list_mutation_effects()
		
		local mutation = { effect = pseudorandom_element(mutations, "zero_alpine_lily_new_mutation"), value = pseudorandom("zero_alpine_lily_new_value", card.ability.extra.min_new_value, card.ability.extra.max_new_value) }
		
		card.ability.extra.mutations[#card.ability.extra.mutations+1] = mutation
		return mutation
	end,	
	
    loc_vars = function(self, info_queue, card)
        local main_end = {
		}
		for _, mutation in ipairs(card.ability.extra.mutations) do
			local mutation_effect = self.lily_mutation_effects[mutation.effect]
			local vars = {}
			if type(mutation_effect.loc_vars) == "function" then
				vars = mutation_effect:loc_vars(card, mutation.value).vars
			end
			
			local desc_node = {}
			localize {type = 'descriptions',
				key = "j_zero_alpine_lily_" .. mutation.effect,
				set = 'Joker',
				nodes = desc_node,
				scale = 1,
				text_colour = G.C.UI.TEXT_DARK,
				vars = vars
			} 
			desc_node = desc_from_rows(desc_node,true)
			--desc node should contains the text nodes now
			
			desc_node.config.minh = 0
			desc_node.config.padding = 0
			desc_node.config.r = 0
			
			--print(inspect(desc_node.config))
			
			main_end[#main_end+1] = desc_node
		end
		return {vars = {
			card.ability.extra.mutations_per_round,
			card.ability.extra.mutations_per_round == 1 and "" or "s",
		}, main_end = main_end}
    end,
	
    calculate = function(self, card, context)
		local function append_extra(_ret, append)
			if _ret.extra then return append_extra(_ret.extra, append) end
			_ret.extra = append
			return _ret
		end
		
		if context.joker_main then
			local ret = {}
			for _,mutation in ipairs(card.ability.extra.mutations) do
				local mutation_effect = self.lily_mutation_effects[mutation.effect]
				if type(mutation_effect.calculate) == "function" then
					append_extra(ret, mutation_effect:calculate(card, mutation.value))
				end
			end
			if ret.extra then return ret.extra end
		end
		
		if not context.blueprint and ((context.end_of_round and not context.game_over and context.cardarea == G.jokers) or context.forcetrigger) then
			local ret = {}
			local repeats = card.ability.extra.mutations_per_round
			for iii=1,repeats do
				local odds_list = {
					"new_effect",
					"lose_effect",
					"change_effect",
					"gain_value",
					"lose_value",
					"nothing",
					"plus_mutation",
					"minus_mutation",
				}
				local max_odds = 0
				for k,v in ipairs(odds_list) do max_odds = max_odds + card.ability.extra.odds[v] end
				local roll = pseudorandom("zero_alpine_lily_eor", 1, max_odds)
				for k,v in ipairs(odds_list) do
					if roll <= card.ability.extra.odds[v] then
						-- do that effect
						if v == "new_effect" or (#card.ability.extra.mutations == 1 and v == "lose_effect") then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										self:lily_create_mutation(card)
									end,
									message = localize("k_new_effect_ex")
								},
							})
						elseif v == "lose_effect" then
							-- If this effect is rolled while the lily has
							-- 1 effect remaining, instead we literally just
							-- lie and pretend they rolled the above effect
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										table.remove(card.ability.extra.mutations, pseudorandom("zero_alpine_lily_lose_effect", 1, #card.ability.extra.mutations))
									end,
									message = localize("k_lose_effect_ex")
								},
							})
						elseif v == "change_effect" then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										card.ability.extra.mutations[pseudorandom("zero_alpine_lily_change_effect", 1, #card.ability.extra.mutations)].effect = pseudorandom_element(self:lily_list_mutation_effects(), "zero_alpine_lily_change_mutation")
									end,
									message = localize("k_change_effect_ex")
								},
							})
						elseif v == "gain_value" then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										local mutation = card.ability.extra.mutations[pseudorandom("zero_alpine_lily_gain_value_effect", 1, #card.ability.extra.mutations)]
										mutation.value = mutation.value + pseudorandom("zero_alpine_lily_gain_value", card.ability.extra.min_gain_value, card.ability.extra.max_gain_value)
									end,
									message = localize("k_gain_value_ex")
								},
							})
						elseif v == "lose_value" then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										local mutation = card.ability.extra.mutations[pseudorandom("zero_alpine_lily_lose_value_effect", 1, #card.ability.extra.mutations)]
										mutation.value = math.max(0, mutation.value - pseudorandom("zero_alpine_lily_lose_value", card.ability.extra.min_lose_value, card.ability.extra.max_lose_value))
									end,
									message = localize("k_lose_value_ex")
								},
							})
						elseif v == "nothing" then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									message = localize("k_nothing_ex")
								},
							})
						elseif v == "plus_mutation" or (card.ability.extra.mutations_per_round <= 1 and v == "minus_mutation") then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										card.ability.extra.mutations_per_round = card.ability.extra.mutations_per_round + 1
									end,
									message = localize("k_plus_mutation_ex")
								},
							})
						elseif v == "minus_mutation" then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										card.ability.extra.mutations_per_round = card.ability.extra.mutations_per_round - 1
									end,
									message = localize("k_minus_mutation_ex")
								},
							})
						end
						
						break
					else
						roll = roll - card.ability.extra.odds[v]
					end
				end
			end
			if ret.extra then return ret.extra end
		end
    end,
}

SMODS.Joker {
    key = "despondent_joker",
	atlas = "zero_jokers",
    pos = { x = 0, y = 7 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    config = { extra = { mult = 5, suit = 'zero_Brights'}, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize(card.ability.extra.suit, 'suits_singular'), colours = {G.C.SUITS[card.ability.extra.suit] }, } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card:is_suit(card.ability.extra.suit) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
	in_pool = function(self, args)
		 return zero_brights_in_deck()
	end,
}

SMODS.Joker {
    key = "star_sapphire",
	atlas = "zero_jokers",
    pos = { x = 1, y = 7 },
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    config = { extra = { money = 1, xmult = 1.5, mult = 7, chips = 50, suit = 'zero_Brights'}, },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.suit, 'suits_plural'), card.ability.extra.money, card.ability.extra.xmult, card.ability.extra.chips, card.ability.extra.mult, colours = {G.C.SUITS[card.ability.extra.suit] }, } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card:is_suit(card.ability.extra.suit) then
			local allrets = {
				dollars = card.ability.extra.money,
				xmult = card.ability.extra.xmult,
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult
			}
			local keys = {}
			for k in pairs(allrets) do
				table.insert(keys, k)
			end
			local randomret = pseudorandom_element(keys)
            return {
                [randomret] = allrets[randomret]
            }
        end
    end,
	in_pool = function(self, args)
		 return zero_brights_in_deck()
	end,
}