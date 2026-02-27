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

-- Heart Stone
SMODS.Consumable {
    set = "zero_raregem",
    key = 'heartstone',
    atlas = 'zero_raregemsBejeweled',
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
}

-- Citrine
SMODS.Consumable {
    set = "zero_raregem",
    key = 'citrine',
    atlas = 'zero_raregemsBejeweled',
    pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = true,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
}

-- Rising Star
SMODS.Consumable {
    set = "zero_raregem",
    key = 'risingstar',
    atlas = 'zero_raregemsBejeweled',
    pos = { x = 2, y = 0 },
    unlocked = true,
    discovered = true,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
}

-- Stemerald
SMODS.Consumable {
    set = "zero_raregem",
    key = 'stemerald',
    atlas = 'zero_raregemsBejeweled',
    pos = { x = 3, y = 0 },
    unlocked = true,
    discovered = true,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
}

-- Blue Thunder
SMODS.Consumable {
    set = "zero_raregem",
    key = 'bluethunder',
    atlas = 'zero_raregemsBejeweled',
    pos = { x = 0, y = 1 },
    unlocked = true,
    discovered = true,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
}

-- High Roller
SMODS.Consumable {
    set = "zero_raregem",
    key = 'highroller',
    atlas = 'zero_raregemsBejeweled',
    pos = { x = 1, y = 1 },
    unlocked = true,
    discovered = true,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
}

-- Royal Flash
SMODS.Consumable {
    set = "zero_raregem",
    key = 'royalflash',
    atlas = 'zero_raregemsBejeweled',
    pos = { x = 2, y = 1 },
    unlocked = true,
    discovered = true,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end,
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
}

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
}

-- Rare Gem Pack (appearance 1)
SMODS.Booster({
    key = "raregems_normal_1",
    kind = "zero_raregem",
    atlas = "zero_packsBejeweled",
    pos = { x = 0, y = 0 },
    config = { extra = 2, choose = 1 },
    cost = 4,
    draw_hand = false,
    --weight = 0.48,
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
    draw_hand = false,
    --weight = 0.48,
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
    draw_hand = false,
    --weight = 0.48,
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
    draw_hand = false,
    --weight = 0.48,
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