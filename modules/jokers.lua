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
    return G.STATE == G.STATES.SELECTING_HAND and card.ability.extra.active
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