SMODS.Atlas {
    key = 'zero_blindsBejeweled',
    px = 34,
    py = 34,
    path = 'zero_blindsBejeweled.png',
    frames = 21,
    atlas_table = 'ANIMATION_ATLAS'
}

SMODS.Blind { -- The Clover
    key = "redjewelblind",
    dollars = 5,
    mult = 2,
    atlas = 'zero_blindsBejeweled',
    pos = { x = 0, y = 0 },
    boss = { min = 1 },
    boss_colour = HEX("44f456"),
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    debuff = { jewel = 'zero_redjewel' },
}

SMODS.Blind { -- The Wave
    key = "orangejewelblind",
    dollars = 5,
    mult = 2,
    atlas = 'zero_blindsBejeweled',
    pos = { x = 0, y = 1 },
    boss = { min = 1 },
    boss_colour = HEX("3e93f2"),
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    debuff = { jewel = 'zero_orangejewel' },
}

SMODS.Blind { -- The Royalty
    key = "yellowjewelblind",
    dollars = 5,
    mult = 2,
    atlas = 'zero_blindsBejeweled',
    pos = { x = 0, y = 2 },
    boss = { min = 1 },
    boss_colour = HEX("e24cf4"),
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    debuff = { jewel = 'zero_yellowjewel' },
}

SMODS.Blind { -- The Cleave
    key = "greenjewelblind",
    dollars = 5,
    mult = 2,
    atlas = 'zero_blindsBejeweled',
    pos = { x = 0, y = 3 },
    boss = { min = 1 },
    boss_colour = HEX("ec3243"),
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    debuff = { jewel = 'zero_greenjewel' },
}

SMODS.Blind { -- The Radiance
    key = "bluejewelblind",
    dollars = 5,
    mult = 2,
    atlas = 'zero_blindsBejeweled',
    pos = { x = 0, y = 4 },
    boss = { min = 1 },
    boss_colour = HEX("ff852a"),
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    debuff = { jewel = 'zero_bluejewel' },
}

SMODS.Blind { -- The Squeeze
    key = "violetjewelblind",
    dollars = 5,
    mult = 2,
    atlas = 'zero_blindsBejeweled',
    pos = { x = 0, y = 5 },
    boss = { min = 1 },
    boss_colour = HEX("fdda4f"),
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    debuff = { jewel = 'zero_violetjewel' },
}

SMODS.Blind { -- The Ink
    key = "whitejewelblind",
    dollars = 5,
    mult = 2,
    atlas = 'zero_blindsBejeweled',
    pos = { x = 0, y = 6 },
    boss = { min = 1 },
    boss_colour = HEX("494f72"),
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
    debuff = { jewel = 'zero_whitejewel' },
}

SMODS.Blind { -- The Panel
    key = "thepanel",
    dollars = 5,
    mult = 1,
    atlas = 'zero_blindsBejeweled',
    pos = { x = 0, y = 7 },
    boss = { min = 1 },
    boss_colour = HEX("ff5b9b"),
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
}

SMODS.Blind { -- The Descent
    key = "thedescent",
    dollars = 5,
    mult = 1,
    atlas = 'zero_blindsBejeweled',
    pos = { x = 0, y = 8 },
    boss = { min = 1 },
    boss_colour = HEX("b0d5de"),
    in_pool = function(self, args)
        return do_bejewelatro()
    end,
}

SMODS.Blind:take_ownership('water', {
    mult = 1,
}, true)