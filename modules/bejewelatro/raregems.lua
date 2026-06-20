SMODS.Atlas {
    key = "zero_raregemsBejeweled",
    px = 71,
    py = 95,
    path = "zero_raregemsBejeweled.png"
}

SMODS.Atlas {
    key = "zero_spectralsBejeweled",
    px = 71,
    py = 95,
    path = "zero_spectralsBejeweled.png"
}

SMODS.Atlas {
    key = "zero_packsBejeweled",
    px = 71,
    py = 95,
    path = "zero_packsBejeweled.png"
}

SMODS.ConsumableType {
    key = 'zero_raregem',
    default = 'c_zero_royalflash',
    primary_colour = HEX('4c447a'),
    secondary_colour = HEX('6b6bac'),
    collection_rows = { 4, 3 },
    --shop_rate = 4
    loc_txt = {
    name = 'Rare Gem',
 		collection = 'Rare Gems',
 		undiscovered = { 
 			name = 'Undiscovered',
 			text = { '???' },
 		},
    },
}

SMODS.UndiscoveredSprite {
    key = "zero_raregem",
    atlas = "zero_raregemsBejeweled",
    pos = {x = 3, y = 1} 
}

local jewel_list = {
    'redjewel', 'orangejewel', 'yellowjewel', 'greenjewel', 'bluejewel', 'violetjewel', 'whitejewel',
}

local localized_jewel_list = {
    'Red Gem', 'Orange Gem', 'Yellow Gem', 'Green Gem', 'Blue Gem', 'Violet Gem', 'White Gem',
}

local colour_list = {
    'ec000a', 'ec5100', 'f4ad00', '04cb00', '005be9', 'de00ec', 'acacac'
}

local raregems_list = {
    'heartstone', 'citrine', 'risingstar', 'stemerald', 'bluethunder', 'highroller', 'royalflash'
}

local localized_raregems_list = {
    'Heart Stone', 'Citrine', 'Rising Star', 'Stemerald', 'Blue Thunder', 'High Roller', 'Royal Flash'
}

function scaler_keyword_raregems(table_scaling, table_base, key)
  local base = G.GAME.Prestiges and G.GAME.Prestiges[key] or table_base
  base = base + table_scaling

  if not G.GAME.Prestiges then G.GAME.Prestiges = {} end
  G.GAME.Prestiges[key] = base
  
  return base - table_scaling
end

for i = 1, #jewel_list do 
    local atlas_x = i >= 5 and (i - 5) or (i - 1)
    local atlas_y = i >= 5 and 1 or 0
    
    SMODS.Consumable {
        set = "zero_raregem",
        key = raregems_list[i],
        name = localized_raregems_list[i],
        atlas = 'zero_raregemsBejeweled',
        pos = { x = atlas_x, y = atlas_y },
        unlocked = true,
        discovered = true,
        config = { 
            gem_type = 'zero_'..jewel_list[i], 
            localized_gem_type = localized_jewel_list[i],
            gem_colour = HEX(colour_list[i]),
            extra = {
                card_selection_scaler = 1,
                xchips_scaler = 0.1,
                card_selection_base = 1,
                xchips_base = 0.1,
            }
        },
        loc_vars = function(self, info_queue, card)
            if not G.GAME.Prestiges then G.GAME.Prestiges = {} end
            info_queue[#info_queue+1] = { key = "scaler_explainer_raregems", set="Other", specific_vars = { card.ability.name, card.ability.extra.card_selection_scaler, card.ability.extra.xchips_scaler } }
            return {
                key = 'raregem',
                vars = {
                    card.ability.localized_gem_type,
                    G.GAME.Prestiges and G.GAME.Prestiges[card.config.center_key..'_selection'] or card.ability.extra.card_selection_base, 
                    card.ability.extra.card_selection_scaler,
                    G.GAME.Prestiges and G.GAME.Prestiges[card.config.center_key..'_xchips'] or card.ability.extra.xchips_base, 
                    card.ability.extra.xchips_scaler,
                    card.ability.name,
                    colours = { card.ability.gem_colour or HEX('FFFFFF') }
                }
            }
        end,
        draw = function(self, card, layer)
            if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
                card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
            end
        end,
        in_pool = function(self, args)
            return do_bejewelatro()
        end,
        can_use = function(self, card)
            return not (
                G.hand and G.hand.highlighted 
                and #G.hand.highlighted > (G.GAME.Prestiges and G.GAME.Prestiges[card.config.center_key..'_selection'] or card.ability.extra.card_selection_base)
            )
        end,
        use = function(self, card, area, copier)
            local value_xchips = scaler_keyword_raregems(card.ability.extra.xchips_scaler, card.ability.extra.xchips_base, card.config.center_key..'_xchips')
            local value_selection = scaler_keyword_raregems(card.ability.extra.card_selection_scaler, card.ability.extra.card_selection_base, card.config.center_key..'_selection')
            if not G.GAME.PrestigeValues[card.config.center_key..'_xchips'] then G.GAME.PrestigeValues[card.config.center_key..'_xchips'] = 1 end
            if not G.GAME.PrestigeValues[card.config.center_key..'_selection'] then G.GAME.PrestigeValues[card.config.center_key..'_selection'] = 1 end
            G.GAME.PrestigeValues[card.config.center_key..'_xchips'] = G.GAME.PrestigeValues[card.config.center_key..'_xchips'] + value_xchips
            G.GAME.PrestigeValues[card.config.center_key..'_selection'] = G.GAME.PrestigeValues[card.config.center_key..'_selection'] + value_selection
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        local pcard_ability = G.hand.highlighted[i].ability
                        if pcard_ability.zero_redjewel then pcard_ability.zero_redjewel = nil end
                        if pcard_ability.zero_orangejewel then pcard_ability.zero_orangejewel = nil end
                        if pcard_ability.zero_whitejewel then pcard_ability.zero_whitejewel = nil end
                        if pcard_ability.zero_yellowjewel then pcard_ability.zero_yellowjewel = nil end
                        if pcard_ability.zero_greenjewel then pcard_ability.zero_greenjewel = nil end
                        if pcard_ability.zero_bluejewel then pcard_ability.zero_bluejewel = nil end
                        if pcard_ability.zero_violetjewel then pcard_ability.zero_violetjewel = nil end
                        pcard_ability[card.ability.gem_type] = true
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end,
    }
end

-- Moonstone (Spectral)
SMODS.Consumable {
    set = "Spectral",
    key = 'moonstone',
    atlas = 'zero_spectralsBejeweled',
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    hidden = true,
    soul_set = 'zero_raregem',
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    can_use = function(self, card)
        return true
    end, 
    use = function(self, card, area, copier)
        for i = 1, #raregems_list do
            local card_table = G.P_CENTERS['c_zero_'..raregems_list[i]]
            local value_xchips = scaler_keyword_raregems(card_table.config.extra.xchips_scaler, card_table.config.extra.xchips_base, card_table.key..'_xchips')
            local value_selection = scaler_keyword_raregems(card_table.config.extra.card_selection_scaler, card_table.config.extra.card_selection_base, card_table.key..'_selection')
            if not G.GAME.PrestigeValues[card_table.key..'_xchips'] then G.GAME.PrestigeValues[card_table.key..'_xchips'] = 1 end
            if not G.GAME.PrestigeValues[card_table.key..'_selection'] then G.GAME.PrestigeValues[card_table.key..'_selection'] = 1 end
            G.GAME.PrestigeValues[card_table.key..'_xchips'] = G.GAME.PrestigeValues[card_table.key..'_xchips'] + value_xchips
            G.GAME.PrestigeValues[card_table.key..'_selection'] = G.GAME.PrestigeValues[card_table.key..'_selection'] + value_selection
            for k,v in ipairs(G.playing_cards) do
                if is_jewel_colour(v, card_table.config.gem_type, 'card') then
                    v.ability.perma_x_chips = v.ability.perma_x_chips + value_xchips
                end
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.5)
    end,
}

-- Rare Gem Pack (appearance 1)
SMODS.Booster({
    key = "raregems_normal_1",
    kind = "zero_raregem",
    atlas = "zero_packsBejeweled",
    pos = { x = 0, y = 0 },
    config = { extra = 2, choose = 1 },
    cost = 4,
    draw_hand = true,
    weight = 0.48,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        local n_card = create_card("zero_raregem", G.pack_cards, nil, nil, true, true, nil, "zero_raregem")
        return n_card
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07, scale = 0.1,
            initialize = true, lifespan = 15,
            speed = 0.1, padding = -4,
            attach = G.ROOM_ATTACH, colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2, scale = 0.05,
            lifespan = 1.5, speed = 4,
            attach = G.ROOM_ATTACH, colours = { G.C.WHITE },
            fill = true
        })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 2} }
    end,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    group_key = "k_zero_raregem_pack",
})

-- Rare Gem Pack (appearance 2)
SMODS.Booster({
    key = "raregems_normal_2",
    kind = "zero_raregem",
    atlas = "zero_packsBejeweled",
    pos = { x = 1, y = 0 },
    config = { extra = 2, choose = 1 },
    cost = 4,
    draw_hand = true,
    weight = 0.48,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        local n_card = create_card("zero_raregem", G.pack_cards, nil, nil, true, true, nil, "zero_raregem")
        return n_card
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07, scale = 0.1,
            initialize = true, lifespan = 15,
            speed = 0.1, padding = -4,
            attach = G.ROOM_ATTACH, colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2, scale = 0.05,
            lifespan = 1.5, speed = 4,
            attach = G.ROOM_ATTACH, colours = { G.C.WHITE },
            fill = true
        })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 2} }
    end,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    group_key = "k_zero_raregem_pack",
})

-- Jumbo Rare Gem Pack
SMODS.Booster({
    key = "raregems_jumbo_1",
    kind = "zero_raregem",
    atlas = "zero_packsBejeweled",
    pos = { x = 2, y = 0 },
    config = { extra = 4, choose = 1 },
    cost = 6,
    draw_hand = true,
    weight = 0.48,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        local n_card = create_card("zero_raregem", G.pack_cards, nil, nil, true, true, nil, "zero_raregem")
        return n_card
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07, scale = 0.1,
            initialize = true, lifespan = 15,
            speed = 0.1, padding = -4,
            attach = G.ROOM_ATTACH, colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2, scale = 0.05,
            lifespan = 1.5, speed = 4,
            attach = G.ROOM_ATTACH, colours = { G.C.WHITE },
            fill = true
        })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 2} }
    end,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    group_key = "k_zero_raregem_pack",
})

-- Mega Rare Gem Pack
SMODS.Booster({
    key = "raregems_mega_1",
    kind = "zero_raregem",
    atlas = "zero_packsBejeweled",
    pos = { x = 3, y = 0 },
    config = { extra = 4, choose = 2 },
    cost = 8,
    draw_hand = true,
    weight = 0.48,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
        local n_card = create_card("zero_raregem", G.pack_cards, nil, nil, true, true, nil, "zero_raregem")
        return n_card
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07, scale = 0.1,
            initialize = true, lifespan = 15,
            speed = 0.1, padding = -4,
            attach = G.ROOM_ATTACH, colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2, scale = 0.05,
            lifespan = 1.5, speed = 4,
            attach = G.ROOM_ATTACH, colours = { G.C.WHITE },
            fill = true
        })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 2} }
    end,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    group_key = "k_zero_raregem_pack",
})