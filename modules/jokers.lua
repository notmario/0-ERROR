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
