SMODS.Atlas { 
    key = "zero_decks",
    path = "zero_decks.png",
    px = 71,
    py = 95
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
        for k,v in pairs(G.GAME.hands) do -- shows jewel hands
            if string.find(k, 'jewel') then
                v.visible = true
            end
        end
        
    end,
        
}