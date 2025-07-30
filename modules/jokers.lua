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