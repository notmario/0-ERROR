SMODS.Atlas {
    key = "zero_jewelsuits",
    px = 71,
    py = 95,
    path = "jewelsuits.png"
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

for i = 1, #jewel_list do
    SMODS.Sticker {
        key = jewel_list[i],
        col_index = i,
        badge_colour = HEX(colour_list[i]),
        pos = { x = i-1, y = 0 },
        atlas = "zero_jewelsuits",
        loc_vars = function(self, info_queue, card)
            local _key = self.key
            local prestige_key = _key and Bejewelatro.raregems_list[string.sub(_key, 6)]
                and 'c_zero_'..Bejewelatro.raregems_list[string.sub(_key, 6)]..'_xchips' or nil
            if prestige_key and G.GAME.Prestiges and G.GAME.PrestigeValues[prestige_key]
            and G.GAME.PrestigeValues[prestige_key] ~= 1 then
                _key = _key..'_xchips'
            end
            return {
                key = _key,
                vars = {
                    G.GAME.Prestiges and G.GAME.PrestigeValues[prestige_key] or 1
                }
            }
        end,
        draw = function(self, card, layer)
            local has_updated = false
            if G.GAME and card.ability then
                for j=1, #jewel_list do
                    if self.col_index>j and card.ability['zero_'..jewel_list[j]] then
                        G.shared_stickers[self.key]:set_sprite_pos({ x = self.col_index-1, y = 1 })
                        has_updated = true
                    elseif self.col_index<j and card.ability['zero_'..jewel_list[j]] then
                        G.shared_stickers[self.key]:set_sprite_pos({ x = self.col_index-1, y = 2 })
                        has_updated = true
                    end
                end
            end
            if not has_updated then
                G.shared_stickers[self.key]:set_sprite_pos({ x = self.col_index-1, y = 0 })
            end
            G.shared_stickers[self.key].role.draw_major = card
            G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
        end,
        calculate = function(self, card, context)
            if context.main_scoring and context.cardarea == G.play then
                return {
                    xchips = G.GAME.PrestigeValues['c_zero_'..Bejewelatro.raregems_list[string.sub(self.key, 6)]..'_xchips'],
                }
            end
        end,
    }
end

