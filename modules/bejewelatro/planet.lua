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

-- Spectrum
SMODS.Consumable{
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'zero_planetBejeweled',
    pos = {x = 1, y = 0},
    key = 'spectrum',
    name = "Spectrum",
    effect = 'Hand Upgrade',
    config = {hand_type = 'zero_jewel_spectrum'},
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

-- Coal Mine
SMODS.Consumable{
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'zero_planetBejeweled',
    pos = {x = 2, y = 0},
    key = 'coalmine',
    name = "Coal Mine",
    effect = 'Hand Upgrade',
    config = {hand_type = 'zero_jewel_twopair'},
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

-- Chain Reaction
SMODS.Consumable{
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'zero_planetBejeweled',
    pos = {x = 3, y = 0},
    key = 'chainreaction',
    name = "Chain Reaction",
    effect = 'Hand Upgrade',
    config = {hand_type = 'zero_jewel_three'},
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

-- Arsenal
SMODS.Consumable{
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'zero_planetBejeweled',
    pos = {x = 4, y = 0},
    key = 'arsenal',
    name = "Arsenal",
    effect = 'Hand Upgrade',
    config = {hand_type = 'zero_jewel_house'},
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

-- Firestorm
SMODS.Consumable{
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'zero_planetBejeweled',
    pos = {x = 5, y = 0},
    key = 'firestorm',
    name = "Firestorm",
    effect = 'Hand Upgrade',
    config = {hand_type = 'zero_jewel_four'},
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

-- Preserver
SMODS.Consumable{
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'zero_planetBejeweled',
    pos = {x = 6, y = 0},
    key = 'preserver',
    name = "Preserver",
    effect = 'Hand Upgrade',
    config = {hand_type = 'zero_jewel_flush'},
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

local undefaulted_planets = {
    "neptune",
    "mars",
    "earth",
    "jupiter",
    "saturn",
    "venus",
    "uranus",
    "mercury",
}

for k,v in pairs(undefaulted_planets) do
    SMODS.Consumable:take_ownership(v, {
        in_pool = function(self, args)
            return not do_bejewelatro() or G.GAME.hands[self.config.hand_type].visible == true
        end,
    }, false)
end