SMODS.Back{
    name = "Draft Deck",
    key = "draft", 
	pos = { x = 2, y = 1 },
    atlas = 'zero_decks'
}

local old_start_run = Game.start_run
function Game:start_run(args)
    old_start_run(self, args)
    
    if not args.savestate and G.GAME.selected_back.effect.center.key == 'b_zero_draft' then
        G.E_MANAGER:add_event(Event({
            func = function()
                G.SETTINGS.paused = true
                G.FUNCS.overlay_menu{
                    definition = create_UIBox_joker_draft(),
                    config = {no_esc = true}
                }
                return true
            end
        }))
    end
end

function create_UIBox_joker_draft()
    local grid_tables = {}
    G.joker_draft_selection = {}
    for i = 1, 2 do
        local row = {n=G.UIT.R, config={colour = G.C.CLEAR, padding=0.05}, nodes={}}
        for j = 1, 3 do
            local idx = j + (i-1)*3
            G.joker_draft_selection[idx] = CardArea(G.ROOM.T.x, G.ROOM.T.h, G.CARD_W, G.CARD_H, {card_limit = 1, type = "title", highlight_limit = 0})
            table.insert(row.nodes, {n=G.UIT.O, config={object = G.joker_draft_selection[idx]}})
        end
        table.insert(grid_tables, row)
    end
    
    if not G.GAME.draft_options then
        local pool = G.P_CENTER_POOLS.Joker
        local temp_pool = {}
        for _, v in ipairs(pool) do 
            if v.unlocked
			and (not v.in_pool or v.in_pool())
			and type(v.rarity) == "number" and v.rarity < 4 
			and (v.eternal_compat == nil or v.eternal_compat == true)  then
                table.insert(temp_pool, v.key) 
            end
        end
        
        if #temp_pool == 0 then
            for _, v in ipairs(pool) do table.insert(temp_pool, v.key) end
        end

        G.GAME.draft_options = {}
        for i = 1, 6 do
            if #temp_pool > 0 then
                local r = pseudorandom('joker_draft_' .. i)
                local chosen_idx = math.min(#temp_pool, math.floor(r * #temp_pool) + 1)
                table.insert(G.GAME.draft_options, table.remove(temp_pool, chosen_idx))
            end
        end
        G.GAME.viewed_draft_joker = G.P_CENTERS[G.GAME.draft_options[1]]
    end
    
    for i = 1, 6 do
        local center = G.P_CENTERS[G.GAME.draft_options[i]]
        if not center then break end
        local card = Card(G.joker_draft_selection[i].T.x, G.joker_draft_selection[i].T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
        card.no_ui = true
        card.config.card.no_ui = true
        card.ability.fake_draft_joker = true
        G.joker_draft_selection[i]:emplace(card)
    end
    
    G.draft_preview_area = CardArea(G.ROOM.T.x, G.ROOM.T.h, G.CARD_W, G.CARD_H, {card_limit = 1, type = "title", highlight_limit = 0})
    
    local center = G.GAME.viewed_draft_joker or G.P_CENTERS["j_joker"]
    
    local preview_card = Card(G.draft_preview_area.T.x+G.draft_preview_area.T.w/2-G.CARD_W/2, G.draft_preview_area.T.y+G.draft_preview_area.T.h/2-G.CARD_H/2, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
    preview_card.states.hover.can = false
    G.draft_preview_area:emplace(preview_card)
    
    local minw = 3.5
    local unlocked = center.unlocked
    local UI_table = unlocked and generate_card_ui(center, nil, nil, "Joker") or generate_card_ui(center, nil, nil, "Locked")
    local desc_main = {n=G.UIT.ROOT, config={align = "cm", minw = minw, minh = 2, id = center.name, colour = G.C.CLEAR}, nodes={desc_from_rows(UI_table.main, true, minw-0.2)}}
    
    local t = create_UIBox_generic_options({no_back = true, contents = {
        {n=G.UIT.R, config={align = "cm", minw = 7.5, padding = 0.15, r = 0.1, colour = G.C.L_BLACK}, nodes={
            {n=G.UIT.C, config={align = "cm", padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=grid_tables},
            
            {n=G.UIT.C, config={align = "tm", minw = 4, minh = 4.5, r = 0.1, colour = G.C.BLACK, padding = 0.15, emboss = 0.05}, nodes={
                {n=G.UIT.R, config={align = "cm", emboss = 0.1, r = 0.1, minw = 3, minh = 0.5}, nodes={
                    {n=G.UIT.O, config={id = nil, func = "RUN_SETUP_check_draft_name", object = Moveable()}},
                }},
                {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.O, config={id = center.name, func = "RUN_SETUP_check_draft_card", object = G.draft_preview_area}},
                }},
                {n=G.UIT.R, config={align = "cm", colour = G.C.WHITE, emboss = 0.1, r = 0.1}, nodes={
                    {n=G.UIT.O, config={id = center.name, func = "RUN_SETUP_check_draft_desc", object = UIBox{definition = desc_main, config = {offset = {x=0,y=0}}}}}
                }}
            }},
        }},
        {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
            {n=G.UIT.C, config={minw = 2.5, minh = 0.8, r = 0.1, hover = true, button = "random_draft_joker", colour = G.C.BLUE, align = "cm", emboss = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.T, config={text = "Random", scale = 0.5, colour = G.C.WHITE}}
                }},
            }},
            {n=G.UIT.C, config={align = "cm", minw = 0.4}, nodes={}},
            {n=G.UIT.C, config={minw = 3.0, minh = 0.8, r = 0.1, hover = true, button = "select_draft_joker", func = "select_draft_joker_button", align = "cm", emboss = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.T, config={text = "Confirm", scale = 0.5, colour = G.C.WHITE}}
                }},
            }},
        }},
    }})
    return t
end

G.FUNCS.RUN_SETUP_check_draft_name = function(e)
    local viewed = G.GAME.viewed_draft_joker or G.P_CENTERS["j_joker"]
    if e.config.object and viewed.name ~= e.config.id then
        local name_text = viewed.unlocked and localize{type = "name_text", set = "Joker", key = viewed.key} or localize("k_locked")
        e.config.object:remove()
        e.config.object = UIBox{
            definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
                {n=G.UIT.O, config={id = viewed.name, func = "RUN_SETUP_check_draft_name", object = DynaText({string = name_text, maxw = 4, colours = {G.C.WHITE}, shadow = true, bump = true, scale = 0.5, pop_in = 0, silent = true})}},
            }},
            config = {offset = {x=0,y=0}, align = "cm", parent = e}
        }
        e.config.id = viewed.name
    end
end

G.FUNCS.RUN_SETUP_check_draft_card = function(e)
    if e.config.object and G.GAME.viewed_draft_joker.name ~= e.config.id then
        local c = G.draft_preview_area:remove_card(G.draft_preview_area.cards[1])
        c:remove()
        c = nil
        local center = G.GAME.viewed_draft_joker
        local card = Card(G.draft_preview_area.T.x+G.draft_preview_area.T.w/2-G.CARD_W/2, G.draft_preview_area.T.y+G.draft_preview_area.T.h/2-G.CARD_H/2, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
        card.states.hover.can = false
        G.draft_preview_area:emplace(card)
        e.config.id = G.GAME.viewed_draft_joker.name
    end
end

G.FUNCS.RUN_SETUP_check_draft_desc = function(e)
    local viewed = G.GAME.viewed_draft_joker or G.P_CENTERS["j_joker"]
    if viewed.name ~= e.config.id then
        local minw = 3.5
        local unlocked = viewed.unlocked
        local UI_table = unlocked and generate_card_ui(viewed, nil, nil, "Joker") or generate_card_ui(viewed, nil, nil, "Locked")
        local desc_main = {n=G.UIT.ROOT, config={align = "cm", minw = minw, minh = 2, id = viewed.name, colour = G.C.CLEAR}, nodes={desc_from_rows(UI_table.main, true, minw-0.2)}}
        e.config.object:remove() 
        e.config.object = UIBox{
            definition = desc_main,
            config = {offset = {x=0,y=0}, align = "cm", parent = e}
        }
        e.config.id = viewed.name
    end
end

local Card_click_ref = Card.click
function Card:click()
    Card_click_ref(self)
    if self.ability.fake_draft_joker then
        G.GAME.viewed_draft_joker = self.config.center
    end
end

G.FUNCS.select_draft_joker_button = function(e)
    local viewed = G.GAME.viewed_draft_joker or G.P_CENTERS["j_joker"]
    if viewed and viewed.unlocked then
        e.config.colour = G.C.GREEN
        e.config.button = "select_draft_joker"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.random_draft_joker = function()
    local random_key = pseudorandom_element(G.GAME.draft_options, pseudoseed(os.time()))
    G.GAME.viewed_draft_joker = G.P_CENTERS[random_key]
end

G.FUNCS.select_draft_joker = function()
    G.FUNCS.exit_overlay_menu()
    
    local center = G.GAME.viewed_draft_joker or G.P_CENTERS["j_joker"]
    
    G.E_MANAGER:add_event(Event({
        func = function()
            local card = Card(G.deck.T.x+G.deck.T.w-G.CARD_W*0.6, G.deck.T.y-G.CARD_H*1.6, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
            card.ability.eternal = true
			card:add_to_deck()
            G.jokers:emplace(card)
            card:juice_up(0.3, 0.5)
            
            save_run()
            
            G.GAME.draft_options = nil
            G.GAME.viewed_draft_joker = nil
            return true 
        end
    }))
end