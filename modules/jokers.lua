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

SMODS.Joker {
  key = "dismantled_cube",
  pos = {x = 1, y = 0},
  atlas = "zero_jokers",
  rarity = 2,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
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
	
	mutation_effects = {
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
	--moved list_mutation_effects and create_mutation to funcs.lua for broader use
    loc_vars = function(self, info_queue, card)
        local main_end = {
		}
		for _, mutation in ipairs(card.ability.extra.mutations) do
			local mutation_effect = self.mutation_effects[mutation.effect]
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
				local mutation_effect = self.mutation_effects[mutation.effect]
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
										zero_create_mutation(self,card)
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
										card.ability.extra.mutations[pseudorandom("zero_alpine_lily_change_effect", 1, #card.ability.extra.mutations)].effect = pseudorandom_element(zero_list_mutation_effects(self), "zero_alpine_lily_change_mutation")
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
        return { vars = { card.ability.extra.mult, localize(card.ability.extra.suit, 'suits_singular'), colours = {G.C.SUITS[card.ability.extra.suit] } } }
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
	end
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
        return { vars = { localize(card.ability.extra.suit, 'suits_singular'), card.ability.extra.money, card.ability.extra.xmult, card.ability.extra.chips, card.ability.extra.mult, colours = {G.C.SUITS[card.ability.extra.suit] }, } }
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

SMODS.Joker {
    key = "konpeito",
	atlas = "zero_jokers",
    pos = { x = 2, y = 7 },
    rarity = 2,
    blueprint_compat = false,
    cost = 5,
    config = { extra = { suit = 'zero_Brights'}, },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.suit, 'suits_plural'), colours = {G.C.SUITS[card.ability.extra.suit] }, } }
    end,
    calculate = function(self, card, context)
        if context.before and #context.scoring_hand == 5 and not context.blueprint then
			for i = 1, #context.scoring_hand do
				SMODS.change_base(context.scoring_hand[i], card.ability.extra.suit, nil, true)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() context.scoring_hand[i]:flip(); play_sound('card1', 1); context.scoring_hand[i]:juice_up(0.3, 0.3) return true end }))
			end
			delay(0.2)
			for i = 1, #context.scoring_hand do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() context.scoring_hand[i]:set_sprites(context.scoring_hand[i].config.center, context.scoring_hand[i].config.card)  return true end }))
			end
			for i = 1, #context.scoring_hand do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() context.scoring_hand[i]:flip(); play_sound('card1', 1); context.scoring_hand[i]:juice_up(0.3, 0.3) return true end }))
			end
			SMODS.destroy_cards(card, nil, nil, true)
            return {
				message = localize('k_eaten_ex'),
            }
		end
    end,
}

SMODS.Joker {
    key = "mirror_shard",
	atlas = "zero_jokers",
    pos = { x = 5, y = 5 },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    config = { extra = { suit = 'zero_Brights'}, },
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = { localize(card.ability.extra.suit, 'suits_plural'), colours = {G.C.SUITS[card.ability.extra.suit] }, } }
    end,
    calculate = function(self, card, context)
		if context.repetition and (context.cardarea == G.play or context.cardarea == G.hand) then
			local returns = {}
			for i = 1, #context.cardarea.cards do
				if context.other_card == context.cardarea.cards[i] then
					if context.cardarea.cards[i-1] and SMODS.has_enhancement(context.cardarea.cards[i-1], 'm_glass') and not context.cardarea.cards[i-1].debuff then
						returns[#returns+1] = {
							repetitions = 1,
							message = localize('k_again_ex'),
							card = context.cardarea.cards[i-1]
						}
					end
					if context.cardarea.cards[i+1] and SMODS.has_enhancement(context.cardarea.cards[i+1], 'm_glass') and not context.cardarea.cards[i+1].debuff  then
						returns[#returns+1] = {
							repetitions = 1,
							message = localize('k_again_ex'),
							card = context.cardarea.cards[i+1]
						}
					end
				end
			end
            if #returns > 0 then
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() card:juice_up() return true end }))
                return SMODS.merge_effects(returns)
            end
        end
    end,
}

SMODS.Joker {
    key = "queen_sigma",
	atlas = "zero_jokers",
    pos = { x = 2, y = 6 },
    rarity = 3,
    blueprint_compat = true,
    cost = 9,
    config = { extra = { total = 150, discovered = 1}, },
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
		local vanilla_count = 0
		local discover_vanilla_count = 0
		for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
			if not v.original_mod then
				vanilla_count = vanilla_count + 1
				if v.discovered == true then
					discover_vanilla_count = discover_vanilla_count + 1
				end
			end
		end
		card.ability.extra.total = vanilla_count
		card.ability.extra.discovered = discover_vanilla_count
        return { vars = { card.ability.extra.total, card.ability.extra.discovered * G.GAME.probabilities.normal } }
    end,
	set_ability = function(self, card, initial, delay_sprites)
		local vanilla_count = 0
		local discover_vanilla_count = 0
		for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
			if not v.original_mod then
				vanilla_count = vanilla_count + 1
				if v.discovered == true then
					discover_vanilla_count = discover_vanilla_count + 1
				end
			end
		end
		card.ability.extra.total = vanilla_count
		card.ability.extra.discovered = discover_vanilla_count
    end,
    calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers then
			local vanilla_count = 0
			local discover_vanilla_count = 0
			for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
				if not v.original_mod then
					vanilla_count = vanilla_count + 1
					if v.discovered == true then
						discover_vanilla_count = discover_vanilla_count + 1
					end
				end
			end
			card.ability.extra.total = vanilla_count
			card.ability.extra.discovered = discover_vanilla_count
		end
        if ((context.individual and context.cardarea == G.play and context.other_card:get_id() == 12 or context.forcetrigger) and (context.other_card:is_suit("Clubs") or #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit)) and pseudorandom('queen_sigma') < card.ability.extra.discovered * G.GAME.probabilities.normal / card.ability.extra.total then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				local _negative = false
				if context.other_card:is_suit("Clubs") then
					_negative = true
				end
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
					local _Tarot = create_card('Tarot', G.consumeables, nil, nil, nil, true)
					if _negative == true then
						_Tarot:set_edition("e_negative", true)
					end
					_Tarot:add_to_deck()
					G.consumeables:emplace(_Tarot)
					G.GAME.consumeable_buffer = 0
				return true end }))
			return {
                message = localize('k_plus_tarot'),
            }
        end
    end
}

SMODS.Joker {
    key = "he_has_a_gun",
	atlas = "zero_jokers",
    pos = { x = 8, y = 1 },
	soul_pos = { x = 9, y = 1 },
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
    config = { extra = { limit = 0, odds = 2, money = 3}, },
    loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
		if context.hand_drawn then
		local count = 0
			for _, v in pairs(G.hand.cards) do
				if v.base.value == "7" then
					count = count + 1
					if not context.blueprint then
						v.ability.forced_selection = true
						G.hand:add_to_highlighted(v)
					end
				end
			end
			if count ~= card.ability.extra.limit then
				SMODS.change_play_limit(-card.ability.extra.limit + count)
				SMODS.change_discard_limit(-card.ability.extra.limit + count)
				card.ability.extra.limit = count
			end
		end
		if context.individual and context.cardarea == G.play and context.other_card.base.value == "7" and pseudorandom('he_has_a_gun') < G.GAME.probabilities.normal / card.ability.extra.odds then
			return {
				dollars = card.ability.extra.money
			}
		end
    end,
}

SMODS.Joker {
    key = "lockout",
	atlas = "zero_jokers",
    pos = { x = 4, y = 4 },
    rarity = 1,
    blueprint_compat = false,
    cost = 4,
	config = { extra = { uses = 3, current_uses = 3, used = false}, },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.current_uses, card.ability.extra.uses } }
    end,
    calculate = function(self, card, context)
		if context.blueprint then return end
		if context.hand_drawn or context.forcetrigger then
			if (card.ability.extra.current_uses > 0 and G.FUNCS.get_poker_hand_info(G.hand.cards) == "High Card") or context.forcetrigger then
				if card.ability.extra.used == false then
					SMODS.calculate_effect({
						message = localize('k_impossible_ex')
					}, card)	
				end
				for _, v in pairs(G.hand.cards) do
					draw_card(G.hand, G.deck, nil, nil, nil, v)
					G.deck:shuffle()
				end
				card.ability.extra.current_uses = card.ability.extra.current_uses - 1
				card.ability.extra.used = true
			elseif card.ability.extra.used == true then
				card.ability.extra.used = false
				return {
					message = card.ability.extra.current_uses .. "/" .. card.ability.extra.uses
				}
			end
		end
		if context.end_of_round and context.main_eval then
			card.ability.extra.current_uses = card.ability.extra.uses
		end
    end
}

SMODS.Joker {
    key = "female_symbol", --this code is 25% functional stuff and 75% bells and whistles
	atlas = "zero_jokers",
    pos = { x = 4, y = 6 },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
	config = { extra = { money = 1, xmult = 0.2, mult = 2, chips = 10, xchips = 0.2, retriggers = 1}, },
	loc_vars = function(self, info_queue, card)
		local randomjoker = G.P_CENTER_POOLS["Joker"][math.random(1, #G.P_CENTER_POOLS["Joker"])]
		info_queue[#info_queue+1] = randomjoker.key and randomjoker or nil
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:get_id() == 12 then
			local random_sound_effs = {
				"button",
				"cancel",
				"card1",
				"card3",
				"cardFan2",
				"cardSlide1",
				"cardSlide2",
				"chips1",
				"chips2",
				"coin1",
				"coin2",
				"coin3",
				"coin4",
				"coin5",
				"coin6",
				"coin7",
				"crumple1",
				"crumple2",
				"crumple3",
				"crumple4",
				"crumple5",
				"crumpleLong1",
				"crumpleLong2",
				"crumpleLong2",
				"foil1",
				"foil2",
				"generic1",
				"glass1",
				"glass2",
				"glass3",
				"glass4",
				"glass5",
				"glass6",
				"gold_seal",
				"gong",
				"highlight1",
				"highlight2",
				"holo1",
				"magic_crumple",
				"magic_crumple2",
				"magic_crumple3",
				"multhit1",
				"multhit2",
				"negative",
				"other1",
				"paper1",
				"polychrome1",
				"slice1",
				"tarot1",
				"tarot2",
				"timpani",
				"whoosh",
				"whoosh1",
				"whoosh2",
				"zero_galasfx"
			}
			local bonuses = {
				["perma_p_dollars"] = card.ability.extra.money,
				["perma_x_mult"] = card.ability.extra.xmult,
				["perma_bonus"] = card.ability.extra.chips,
				["perma_mult"] = card.ability.extra.mult,
				["perma_x_chips"] = card.ability.extra.xchips,
				["perma_h_x_mult"] = card.ability.extra.xmult,
				["perma_h_chips"] = card.ability.extra.chips,
				["perma_h_mult"] = card.ability.extra.mult,
				["perma_h_x_chips"] = card.ability.extra.xchips,
				["perma_h_dollars"] = card.ability.extra.money,
				["perma_repetitions"] = card.ability.extra.retriggers
			}
			local keys = {}
			for k in pairs(bonuses) do
				table.insert(keys, k)
			end
			local randombonus = pseudorandom_element(keys)
			context.other_card.ability[randombonus] = context.other_card.ability[randombonus] or 1
			context.other_card.ability[randombonus] = context.other_card.ability[randombonus] + bonuses[randombonus]
			local punctuations = {".", ",", ";", ":", "!", "?", "-", "_", "(", ")", "[", "]", "{", "}", "@", "#", "$", "%", "&", "*", "\"", "\'"}
			return {
				message = localize('k_upgrade_ex'):sub(1, -2) .. punctuations[math.random(1, #punctuations)],
				sound = pseudorandom_element(random_sound_effs)
			}
		end
    end
}

SMODS.Joker {
    key = "key_he4rt",
	atlas = "zero_jokers",
    pos = { x = 9, y = 0 },
    rarity = 2,
    blueprint_compat = false,
    cost = 4,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS['m_zero_l0ck']
		info_queue[#info_queue+1] = G.P_CENTERS['m_zero_k3y']
    end,
    add_to_deck = function(self, card, from_debuff)
		for _, v in pairs(G.playing_cards) do
			if v.config.center and (v.config.center == G.P_CENTERS.m_zero_k3y or v.config.center == G.P_CENTERS.m_zero_l0ck) then
				return
			end
		end
			local l0ck_card = SMODS.add_card { set = "Base", enhancement = "m_zero_l0ck", area = G.play }
			local k3y_card = SMODS.add_card { set = "Base", enhancement = "m_zero_k3y", area = G.play }
		for _, v in pairs(G.play.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
				draw_card(G.play, G.deck, nil, nil, nil, v)
			return true end }))
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		for _, v in pairs(G.jokers.cards) do
			if v.config.center and v.config.center.key == "j_zero_key_he4rt" then
				return
			end
		end
		for _, v in pairs(G.playing_cards) do
			if v.config.center and (v.config.center == G.P_CENTERS.m_zero_l0ck or v.config.center == G.P_CENTERS.m_zero_k3y) then
				v:start_dissolve("override")
			end
		end
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			local found_l0ck = false
			local found_k3y = false
			for _, v in pairs(G.playing_cards) do
				if v.config.center and v.config.center == G.P_CENTERS.m_zero_l0ck then
					found_l0ck = true
				elseif v.config.center and v.config.center == G.P_CENTERS.m_zero_k3y then
					found_k3y = true
				end
			end
			if found_l0ck == false then
				local l0ck_card = SMODS.add_card { set = "Base", enhancement = "m_zero_l0ck", area = G.deck }
			end
			if found_k3y == false then
				local k3y_card = SMODS.add_card { set = "Base", enhancement = "m_zero_k3y", area = G.deck }
			end
		end
    end
}

SMODS.Joker {
    key = "hater",
	atlas = "zero_jokers",
    pos = { x = 0, y = 4 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
	config = { extra = { chips = 0, max = 50 } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.max } }
    end,
    calculate = function(self, card, context)
		if context.before or context.forcetrigger and not context.blueprint then
			local _upgrade = 0
			for _, v in pairs(G.jokers.cards) do
				_upgrade = _upgrade + v.sell_cost
			end
			if _upgrade ~= 0 then
				card.ability.extra.chips = card.ability.extra.chips + math.min(_upgrade, card.ability.extra.max)
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS,
				}
			end
		end
		if context.joker_main and card.ability.extra.chips ~= 0 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

SMODS.Joker {
    key = "valdi",
	atlas = "zero_jokers",
    pos = { x = 0, y = 6 },
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
	loc_vars = function(self, info_queue, card)
		local cd_dur = G.GAME.PrestigeCooldowns and G.GAME.PrestigeCooldowns["j_zero_valdi"] or 1
		local cur_cd = G.GAME.Prestiges["j_zero_valdi"]
		local main_end
		if card.area and card.area == G.jokers then
			local other_joker
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card and G.jokers.cards[i - 1] then other_joker = G.jokers.cards[i - 1] end
			end
			local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
			main_end = {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
							nodes = {
								{ n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
							}
						}
					}
				}
			}
		end
		local ret
		if cur_cd ~= nil then
			info_queue[#info_queue+1] = { key = "valdi_effect", set="Other" }
			ret = {
				key = self.key.."_cd",
				vars = {
				G.GAME.Valdi_power or 0,
				(G.GAME.Valdi_power == 1) and "" or "s",
				cur_cd,
				(cur_cd == 1) and "" or "s"
				},
			}
		else
			info_queue[#info_queue+1] = { key = "cooldown_explainer", set="Other", specific_vars = {"any Prestige", cd_dur } }
			ret = {vars = { 
			G.GAME.Valdi_power or 0,
			(G.GAME.Valdi_power == 1) and "" or "s",
			cd_dur, 
			},}
		end
		if main_end then
			ret["main_end"] = main_end
		end
		return ret
    end,
    calculate = function(self, card, context)
		if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Prestige" then
            G.GAME.Valdi_power = G.GAME.Valdi_power or 0
			local works = cooldown_keyword(card, "j_zero_valdi")
			if works then
				G.GAME.Valdi_power = G.GAME.Valdi_power + 1
				return {
					message = localize('k_upgrade_ex')
				}
			end
        end
		if card.area and card.area == G.jokers and G.GAME.Valdi_power and G.GAME.Valdi_power > 0 then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card and G.jokers.cards[i - 1] then other_joker = G.jokers.cards[i - 1] end
            end
			local effects = {}
			for i = 1, G.GAME.Valdi_power do
				effects[#effects+1] = SMODS.blueprint_effect(card, other_joker, context)
			end
			if #effects > 0 then
				return SMODS.merge_effects(effects)
			end
		end
    end
}

SMODS.Joker {
    key = "4_h",
	atlas = "zero_jokers",
    pos = { x = 5, y = 6 },
    rarity = 1,
    blueprint_compat = true,
    cost = 6,
	config = { choice = 1, rank = 9, extra = {
	{mult = 10},
	{chips = 50},
	{xmult = 1.5},
	{dollars = 1},
	{swap = true, message = "localizeswap"},
	{balance = true}
	}},
	loc_vars = function(self, info_queue, card)
		for k, v in pairs(card.ability.extra[card.ability.choice]) do
			return { vars = { card.ability.rank, v } }
		end
    end,
	set_ability = function(self, card, initial, delay_sprites)
        card.ability.choice = pseudorandom("4_h", 1, #card.ability.extra)
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play and context.other_card:get_id() == card.ability.rank) or context.forcetrigger then
            local ret = {}
			local val
			for k, v in pairs(card.ability.extra[card.ability.choice]) do
				if v == "localizeswap" then
					val = localize('k_swap_ex')
				else
					val = v
				end
				ret[k] = val
			end
			return ret
        end
    end
}

SMODS.Joker {
    key = "prestige_tree",
	atlas = "zero_jokers",
    pos = { x = 1, y = 6 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
	config = { extra = { odds = 3, chips = 5, mult = 1 }},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.odds, G.GAME.probabilities.normal, card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
		if context.joker_main then
			local rets = {}
			rets[1] = {
                chips = card.ability.extra.chips
            }
			rets[2] = {
                mult = card.ability.extra.mult
            }
            return SMODS.merge_effects(rets)
        end
		if ((context.using_consumeable and context.consumeable.ability.set == "Prestige") or context.forcetrigger) and pseudorandom('prestige_tree') < G.GAME.probabilities.normal / card.ability.extra.odds and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
			trigger = 'before',
			delay = 0.0,
			func = (function()
				local card = create_card('Prestige',G.consumeables, nil, nil, nil, nil, nil, 'prestige_tree')
				card:add_to_deck()
				G.consumeables:emplace(card)
				G.GAME.consumeable_buffer = 0
				return true
			end)}))
			if G.GAME.probabilities.normal >= card.ability.extra.odds then
				card.ability.extra.odds = card.ability.extra.odds * 2
			end
			return {
			message = localize('k_plus_prestige'),
			colour = G.C.SECONDARY_SET.Spectral,
			card = card
			}
		end
    end
}

SMODS.Joker {
	key = "ankimo", --Alpine Lily but with different mutation conditions
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
	pos = {x = 7, y = 4},
	atlas = "zero_jokers",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	
	blueprint_compat = true,
	
	mutation_effects = {
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
    loc_vars = function(self, info_queue, card)
        local main_end = {
		}
		for _, mutation in ipairs(card.ability.extra.mutations) do
			local mutation_effect = self.mutation_effects[mutation.effect]
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
			desc_node.config.minh = 0
			desc_node.config.padding = 0
			desc_node.config.r = 0
			main_end[#main_end+1] = desc_node
		end
		local validhands = {}
		local maxlevel = -math.huge
		local besthands
		for k, v in pairs(G.GAME.hands) do
			if v.level > maxlevel then
				maxlevel = v.level
				validhands = {k}
			elseif v.level == maxlevel then
				validhands[#validhands+1] = k
			end
		end
		if maxlevel <= 1 then
			besthands = localize("k_ankimo_nil")
		elseif #validhands == 1 then
			besthands = validhands[1] .. localize("k_ankimo_one")
		elseif #validhands == 2 then
			besthands = validhands[1] .. localize("k_ankimo_two_1") .. validhands[2] .. localize("k_ankimo_two_2")
		else
			besthands = localize("k_ankimo_multiple")
		end
		return {vars = {
			card.ability.extra.mutations_per_round,
			card.ability.extra.mutations_per_round == 1 and "" or "s",
			besthands
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
				local mutation_effect = self.mutation_effects[mutation.effect]
				if type(mutation_effect.calculate) == "function" then
					append_extra(ret, mutation_effect:calculate(card, mutation.value))
				end
			end
			if ret.extra then return ret.extra end
		end
		
		if not context.blueprint and ((context.individual and context.cardarea == G.play) or context.forcetrigger) then
			if not context.forcetrigger then
				if G.GAME.hands[context.scoring_name].level <= 1 then return end
				for k, v in pairs(G.GAME.hands) do
					if v.level > G.GAME.hands[context.scoring_name].level then return end
				end
			end
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
						if v == "new_effect" or (#card.ability.extra.mutations == 1 and v == "lose_effect") then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										zero_create_mutation(self,card)
									end,
									message = localize("k_new_effect_ex")
								},
							})
						elseif v == "lose_effect" then
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
										card.ability.extra.mutations[pseudorandom("zero_alpine_lily_change_effect", 1, #card.ability.extra.mutations)].effect = pseudorandom_element(zero_list_mutation_effects(self), "zero_alpine_lily_change_mutation")
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
    key = "receipt",
	atlas = "zero_jokers",
    pos = { x = 0, y = 3 },
    rarity = 2,
    blueprint_compat = true,
    cost = 4,
	config = { extra = { sell_value = 2 } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.sell_value} }
    end,
    calculate = function(self, card, context)
		if context.buying_card and not context.buying_self then
			if context.card.set_cost then
                context.card.ability.extra_value = (context.card.ability.extra_value or 0) +
                    card.ability.extra.sell_value
                context.card:set_cost()
            end
			return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end
}

SMODS.Joker {
    key = "playjoke",
	atlas = "zero_jokers",
    pos = { x = 2, y = 4 },
	pixel_size = { w = 63, h = 59},
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
	zero_usable = true,
	config = { extra = { modes ={ "chips", "mult", "xmult", "dollars", "swap", "enhance", "consumable" },
	values = { 20, 4, 1.25, 1, true, nil, 4 }, mode = 1
	} },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.values[card.ability.extra.mode], G.GAME.probabilities.normal },
			key = 'j_zero_playjoke_' .. card.ability.extra.modes[card.ability.extra.mode] , set = 'Joker',}
    end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		if card.ability.extra.mode == #card.ability.extra.modes then
			card.ability.extra.mode = 1
		else
			card.ability.extra.mode = card.ability.extra.mode + 1
		end
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = (function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end)}))
		delay(0.5)
		draw_card(G.play, G.jokers, nil, 'up', nil, card)
		return {
            message = localize('k_changed_ex')
        }
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			if card.ability.extra.mode <= 5 then
				local ret = {
					[card.ability.extra.modes[card.ability.extra.mode]] = card.ability.extra.values[card.ability.extra.mode]
				}
				if card.ability.extra.mode == 5 then
					ret["message"] = localize('k_swap_ex')
				end
				return ret
			elseif card.ability.extra.mode == 6 then
				local randomcard = pseudorandom_element( G.play.cards, "playjoke" )
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() randomcard:flip(); play_sound('card1', 1); randomcard:juice_up(0.3, 0.3) return true end }))
				delay(0.2)
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() randomcard:set_ability(G.P_CENTERS[SMODS.poll_enhancement({guaranteed = true})]);return true end }))
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() randomcard:flip(); play_sound('card1', 1); randomcard:juice_up(0.3, 0.3) return true end }))
				return {
					message = localize('k_enhanced_ex'),
				}
			elseif card.ability.extra.mode == 7 then
				if pseudorandom('playjoke') < G.GAME.probabilities.normal / card.ability.extra.values[card.ability.extra.mode] and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					func = (function()
						local card = create_card('Consumeables', G.consumeables, nil, nil, nil, nil, nil, 'playjoke')
						card:add_to_deck()
						G.consumeables:emplace(card)
						G.GAME.consumeable_buffer = 0
						return true
					end)}))
					return {
					message = "+1",
					}
				end
			end
        end
    end
}

SMODS.Joker {
    key = "lipu_suno",
	atlas = "zero_jokers",
    pos = { x = 5, y = 7 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
	config = { extra = { odds = 2, suit = 'zero_Brights' }},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = { set = 'Other', key = 'zero_lipu_suno_info', specific_vars = { card.ability.extra.odds, G.GAME.probabilities.normal, localize(card.ability.extra.suit, 'suits_plural'), colours = {G.C.SUITS[card.ability.extra.suit] }} }
		return { vars = { zero_compose_toki_pona(card.ability.extra.odds), zero_compose_toki_pona(G.GAME.probabilities.normal), colours = {G.C.SUITS[card.ability.extra.suit] } } }
    end,
    calculate = function(self, card, context)
		if context.before then
			local converted = false
			for i=1, #G.play.cards do
				if G.play.cards[i]:is_suit(card.ability.extra.suit) and SMODS.get_enhancements(G.play.cards[i]) ~= {} and pseudorandom('lipu_suno') < G.GAME.probabilities.normal / card.ability.extra.odds then
					converted = true
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.play.cards[i]:flip();play_sound('card1');G.play.cards[i]:juice_up(0.3, 0.3);return true end }))
					delay(0.2)
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.play.cards[i]:set_ability(G.P_CENTERS[SMODS.poll_enhancement({guaranteed = true})]);return true end }))
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.play.cards[i]:flip();play_sound('tarot2', nil, 0.6);G.play.cards[i]:juice_up(0.3, 0.3);return true end }))
					delay(0.5)
				end
			end
			if converted == true then
				return {
                    message = localize("k_swap_ex")
                }
			end
        end
    end,
	in_pool = function(self, args)
		 return zero_brights_in_deck()
	end
}

SMODS.Joker {
    key = "downx2",
	atlas = "zero_jokers",
    pos = { x = 1, y = 4 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
	config = { extra = { odds = 2 } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds, G.GAME.probabilities.normal } }
    end,
    calculate = function(self, card, context)
		if context.starting_shop and pseudorandom('downx2') < G.GAME.probabilities.normal / card.ability.extra.odds then
			for i, _card in ipairs(G.shop_jokers.cards) do
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function()
				_card.cost = math.ceil(_card.cost/2)
				_card:juice_up()
				return true end }))
			end
			for i, _card in ipairs(G.shop_vouchers.cards) do
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function()
				_card.cost = math.ceil(_card.cost/2)
				_card:juice_up()
				return true end }))
			end
			for i, _card in ipairs(G.shop_booster.cards) do
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function()
				_card.cost = math.ceil(_card.cost/2)
				_card:juice_up()
				return true end }))
			end
			return {
                message = localize("k_discount_ex")
            }
        end
    end
}