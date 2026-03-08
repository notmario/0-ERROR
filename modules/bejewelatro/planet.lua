SMODS.Atlas {
    key = "zero_planetBejeweled",
    px = 71,
    py = 95,
    path = "zero_planetBejeweled.png" -- the images are secretly webps or something
}

-- Gemfall
SMODS.Consumable{
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'zero_planetBejeweled',
    pos = {x = 0, y = 0},
    key = 'gemfall',
    name = "Gemfall",
    effect = 'Hand Upgrade',
    config = {hand_type = 'zero_jewel_pair'},
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.hands[card.ability.hand_type].level,
                localize(card.ability.hand_type, 'poker_hands'),
                G.GAME.hands[card.ability.hand_type].l_mult,
                G.GAME.hands[card.ability.hand_type].l_chips,
                colours = { (G.GAME.hands[card.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]) }
            }
        }
    end,
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
    end
}