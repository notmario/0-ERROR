SMODS.Atlas { 
    key = "zero_decks",
    path = "zero_decks.png",
    px = 71,
    py = 95
}

local hidden_hands = {
    ["spectrum_Spectrum"] = true,
    ["paperback_Spectrum"] = true,
    ["Straight Flush"] = true,
    ["Four of a Kind"] = true,
    ["Full House"] = true,
    ["Flush"] = true,
    ["Straight"] = true,
}

SMODS.Back {
    key = "bejeweled",
    pos = { x = 4, y = 0 },
    atlas = 'zero_decks',
    config = { hand_size = -3, discards = 3, win_ante_mod = -2 },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.hand_size, self.config.discards, self.config.win_ante_mod + 8} }
    end,
    apply = function(self, back)
        G.GAME.win_ante = (G.GAME.win_ante or 8) + self.config.win_ante_mod 
        for k,v in pairs(G.GAME.hands) do
            if string.find(k, 'jewel') then -- shows jewel hands
                v.visible = true
            end
            if hidden_hands[k] then
                v.visible = false
            end
        end
        
    end,
        
}

SMODS.Back {
    key = "blue_bejeweled",
    pos = { x = 0, y = 1 },
    atlas = 'zero_decks',
    config = { hand_size = -3, win_ante_mod = -2, stone_chips = 10 },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.hand_size, self.config.win_ante_mod + 8, self.config.stone_chips } }
    end,
    apply = function(self, back)
        G.GAME.win_ante = (G.GAME.win_ante or 8) + self.config.win_ante_mod 
        for k,v in pairs(G.GAME.hands) do
            if string.find(k, 'jewel') or string.find(k, "High Card") then -- shows jewel hands
                v.visible = true
            else
                v.visible = false
            end
        end
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    v:set_ability('m_stone', true, nil)
                end
                return true
            end
        }))
    end,
        
}

SMODS.Enhancement:take_ownership('stone', { -- Stone Cards
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,    
    config = { extra = { ret_bonus = 50, blue_bejeweled_bonus = 10} },
    loc_vars = function(self, info_queue, card)
        return { vars = { do_bejewelatro(true) and card.ability.extra.blue_bejeweled_bonus or card.ability.extra.ret_bonus } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = do_bejewelatro(true) and card.ability.extra.blue_bejeweled_bonus or card.ability.extra.ret_bonus
            }
        end
    end,
}, true)