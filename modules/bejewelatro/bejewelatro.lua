Bejewelatro = {
    show = false,
    board_visible = false,
    board_pos = {
        x = 0,
        y = 20,
    },
    f = {}, -- functions
    jewel_rows = {}, -- board rows
    jewel_list = {
        'redjewel', 'orangejewel', 'yellowjewel', 'greenjewel', 'bluejewel', 'violetjewel', 'whitejewel',
    }
}

function do_bejewelatro()
    if G.GAME and G.GAME.selected_back.name == 'b_zero_bejeweled' then
        return true
    else
        return false
    end
end

assert(SMODS.load_file("./modules/bejewelatro/deck.lua"))()
assert(SMODS.load_file("./modules/bejewelatro/jewels.lua"))()
assert(SMODS.load_file("./modules/bejewelatro/board.lua"))()
assert(SMODS.load_file("./modules/bejewelatro/stickers.lua"))()
assert(SMODS.load_file("./modules/bejewelatro/pokerhands.lua"))()
assert(SMODS.load_file("./modules/bejewelatro/jokers.lua"))()
assert(SMODS.load_file("./modules/bejewelatro/blinds.lua"))()
assert(SMODS.load_file("./modules/bejewelatro/planet.lua"))()
assert(SMODS.load_file("./modules/bejewelatro/raregems.lua"))()