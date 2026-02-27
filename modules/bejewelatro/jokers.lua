SMODS.Atlas {
    key = "zero_jokersBejeweled",
    px = 71,
    py = 95,
    path = "zero_jokersBejeweled.png"
}

local function has_a_jewel(card)
    if not card.ability then return false end
    for k, v in pairs(card.ability) do
        if v == true and string.match(k, "^zero_.*jewel$") then
            return true
        end
    end

    return false
end

-- Joker (Bejeweled Mode ver)
SMODS.Joker {
    key = "gemjimbo",
    atlas = "zero_jokersBejeweled",
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 2,
    discovered = true,
    config = { extra = { mult = 4 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Angry Joker
SMODS.Joker {
    key = "gemred",
    atlas = "zero_jokersBejeweled",
    pos = { x = 0, y = 1 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { mult = 4 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_redjewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Hungry Joker
SMODS.Joker {
    key = "gemorange",
    atlas = "zero_jokersBejeweled",
    pos = { x = 1, y = 1 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { mult = 4 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_orangejewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Frugal Joker
SMODS.Joker {
    key = "gemyellow",
    atlas = "zero_jokersBejeweled",
    pos = { x = 2, y = 1 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { mult = 4 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_yellowjewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Jealous Joker
SMODS.Joker {
    key = "gemgreen",
    atlas = "zero_jokersBejeweled",
    pos = { x = 3, y = 1 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { mult = 4 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_greenjewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Vain Joker
SMODS.Joker {
    key = "gemblue",
    atlas = "zero_jokersBejeweled",
    pos = { x = 4, y = 1 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { mult = 4 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_bluejewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Affectionate Joker
SMODS.Joker {
    key = "gemviolet",
    atlas = "zero_jokersBejeweled",
    pos = { x = 5, y = 1 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { mult = 4 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_violetjewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Sleepy Joker
SMODS.Joker {
    key = "gemwhite",
    atlas = "zero_jokersBejeweled",
    pos = { x = 6, y = 1 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { mult = 4 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_whitejewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Ambivalent Joker
SMODS.Joker {
    key = "gempair",
    atlas = "zero_jokersBejeweled",
    pos = { x = 1, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 3,
    discovered = true,
    config = { extra = { mult = 10, type = 'zero_jewel_pair' }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Downtrodden Joker
SMODS.Joker {
    key = "gemspectrum",
    atlas = "zero_jokersBejeweled",
    pos = { x = 2, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { mult = 10, type = 'zero_jewel_spectrum' }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Helpless Joker
SMODS.Joker {
    key = "gemtwopair",
    atlas = "zero_jokersBejeweled",
    pos = { x = 3, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { mult = 12, type = 'zero_jewel_twopair' }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Blithe Joker
SMODS.Joker {
    key = "gemthree",
    atlas = "zero_jokersBejeweled",
    pos = { x = 4, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { mult = 16, type = 'zero_jewel_three' }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Wishy-Washy Joker
SMODS.Joker {
    key = "gemhouse",
    atlas = "zero_jokersBejeweled",
    pos = { x = 5, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    discovered = true,
    config = { extra = { mult = 20, chips = 75, type = 'zero_jewel_house' }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips,
            }
        end
    end
}

-- Apathetic Joker
SMODS.Joker {
    key = "gemfour",
    atlas = "zero_jokersBejeweled",
    pos = { x = 6, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    discovered = true,
    config = { extra = { mult = 24, chips = 120, type = 'zero_jewel_four' }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips,
            }
        end
    end
}

-- Unfeeling Joker
SMODS.Joker {
    key = "gemflush",
    atlas = "zero_jokersBejeweled",
    pos = { x = 7, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    discovered = true,
    config = { extra = { mult = 28, chips = 150, type = 'zero_jewel_flush' }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips,
            }
        end
    end
}

-- Scarlet Fire
SMODS.Joker {
    key = "scarletfire",
    atlas = "zero_jokersBejeweled",
    pos = { x = 0, y = 2 },
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    discovered = true,
    config = { extra = { mult = 9 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_redjewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Amber Star
SMODS.Joker {
    key = "amberstar",
    atlas = "zero_jokersBejeweled",
    pos = { x = 1, y = 2 },
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    discovered = true,
    config = { extra = { mult = 9 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_orangejewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Golden Twilight
SMODS.Joker {
    key = "goldentwilight",
    atlas = "zero_jokersBejeweled",
    pos = { x = 2, y = 2 },
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    discovered = true,
    config = { extra = { mult = 9 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_yellowjewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Chartreuse Spring
SMODS.Joker {
    key = "chartreusespring",
    atlas = "zero_jokersBejeweled",
    pos = { x = 3, y = 2 },
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    discovered = true,
    config = { extra = { mult = 9 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_greenjewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Azure Wave
SMODS.Joker {
    key = "azurewave",
    atlas = "zero_jokersBejeweled",
    pos = { x = 4, y = 2 },
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    discovered = true,
    config = { extra = { mult = 9 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_bluejewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Fuschia Rose
SMODS.Joker {
    key = "fuschiarose",
    atlas = "zero_jokersBejeweled",
    pos = { x = 5, y = 2 },
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    discovered = true,
    config = { extra = { mult = 9 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_violetjewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Ivory Bloom
SMODS.Joker {
    key = "ivorybloom",
    atlas = "zero_jokersBejeweled",
    pos = { x = 6, y = 2 },
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    discovered = true,
    config = { extra = { mult = 9 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        is_jewel_colour(context.other_card, 'zero_whitejewel', 'card') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Hypotenuse
SMODS.Joker {
    key = "hypotenusejoker",
    atlas = "zero_jokersBejeweled",
    pos = { x = 9, y = 1 },
    rarity = 1,
    blueprint_compat = false,
    cost = 5,
    discovered = true,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
}

-- Deuteranopia
SMODS.Joker {
    key = "deuteranopia",
    atlas = "zero_jokersBejeweled",
    pos = { x = 9, y = 0 },
    rarity = 2,
    blueprint_compat = false,
    cost = 6,
    discovered = true,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
}

-- Bad Trip
SMODS.Joker {
    key = "badtrip",
    atlas = "zero_jokersBejeweled",
    pos = { x = 8, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { discards_mod = 2 }, },
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discards_mod } }
    end,
    calculate = function(self, card, context)
        if context.after and next(context.poker_hands["zero_jewel_spectrum"]) then 
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_discard(card.ability.extra.discards_mod, nil, true)
                    card_eval_status_text(card, 'extra', nil, nil, nil, 
                        {
                            message = localize { 
                                type = 'variable', 
                                key = 'zero_a_discards', 
                                vars = { card.ability.extra.discards_mod }
                            },
                            colour = G.C.RED
                        }
                    )
                    return true
                end
            }))
        end
    end
}

-- Prism
SMODS.Joker {
    key = "prism",
    atlas = "zero_jokersBejeweled",
    pos = { x = 8, y = 1 },
    rarity = 1,
    blueprint_compat = false,
    cost = 5,
    discovered = true,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    --[[add_to_deck = function(self, card, from_debuff)
        if #SMODS.find_card('j_deuteranopia') <= 1 then
            Bejewelatro.weighted_jewel_list['whitejewel'].weight = 0
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if #SMODS.find_card('j_deuteranopia') <= 1 then
            Bejewelatro.weighted_jewel_list['whitejewel'].weight = 1
        end
    end,]]
}

local banned_jokers = {
    'j_jimbo',
    'j_greedy_joker',
    'j_lusty_joker',
    'j_wrathful_joker',
    'j_gluttenous_joker',
    --'j_jolly',
    --'j_zany',
    --'j_mad',
    --'j_crazy',
    --'j_droll',
    --'j_sly',
    --'j_wily',
    --'j_crazy',
    --'j_devious',
    --'j_crafty',
    'j_four_fingers',
    'j_todo_list',
    'j_blackboard',
    'j_shortcut',
    'j_smeared', 
    --'j_seeing_double',
    'j_zero_despondent_joker',
    --'j_zero_star_sapphire',
    --'j_zero_konpeito',
}

local brights_locked_jokers = {
    'j_rough_gem',
    'j_bloodstone',
    'j_arrowhead',
    'j_onyx_agate',
}

for k,v in pairs(banned_jokers) do
    SMODS.Joker:take_ownership(v, {
        in_pool = function(self, args)
            return not do_bejewelatro()
        end,
    }, true)
end

for k,v in pairs(brights_locked_jokers) do
    SMODS.Joker:take_ownership(v, {
        in_pool = function(self, args)
            return not do_bejewelatro() or zero_brights_in_deck()
        end,
    }, true)
end