SMODS.Atlas {
    key = "zero_gemsUI",
    path = "zero_gemsUI.png",
    px = 18,
    py = 18
}

function Bejewelatro.f.tally_sprite(pos, value)
  local text_colour = G.C.BLACK
  if type(value) == "table" and value[1].string==value[2].string then 
    text_colour = value[1].colour or G.C.WHITE
    value = value[1].string
  end
  local t_s = Sprite(0,0,0.5,0.5,G.ASSET_ATLAS["zero_gemsUI"], {x=pos.x or 0, y=pos.y or 0})
  t_s.states.drag.can = false
  t_s.states.hover.can = false
  t_s.states.collide.can = false
  return 
  {n=G.UIT.C, config={align = "cm", padding = 0.07,force_focus = true,  focus_args = {type = 'tally_sprite'}}, nodes={
    {n=G.UIT.R, config={align = "cm", r = 0.1, padding = 0.04, emboss = 0.05, colour = G.C.JOKER_GREY}, nodes={
      {n=G.UIT.O, config={w=0.5,h=0.5 ,can_collide = false, object = t_s}}
    }},
    {n=G.UIT.R, config={align = "cm"}, nodes={
      type(value) == "table" and {n=G.UIT.O, config={object = DynaText({string = value, colours = {G.C.RED}, scale = 0.4, silent = true, shadow = true, pop_in_rate = 10, pop_delay = 4})}} or
      {n=G.UIT.T, config={text = value or 'NIL',colour = text_colour, scale = 0.4, shadow = true}},
    }},
  }}
end

function Bejewelatro.f.update_jewel_peek_table_values()
    local jewel_tallies = {
        ['zero_redjewel']  = 0, 
        ['zero_orangejewel'] = 0, 
        ['zero_yellowjewel'] = 0, 
        ['zero_greenjewel'] = 0,
        ['zero_bluejewel']  = 0, 
        ['zero_violetjewel'] = 0, 
        ['zero_whitejewel'] = 0, 
        ['nonejewel'] = 0,
    }

    local mod_jewel_tallies = {
        ['zero_redjewel']  = 0, 
        ['zero_orangejewel'] = 0, 
        ['zero_yellowjewel'] = 0, 
        ['zero_greenjewel'] = 0,
        ['zero_bluejewel']  = 0, 
        ['zero_violetjewel'] = 0, 
        ['zero_whitejewel'] = 0, 
        ['nonejewel'] = 0,
    }

    for k, v in ipairs(G.deck.cards) do
        
        local none_jewel = true
        
        --base gems
        for i = 1, #Bejewelatro.jewel_list do
            local jwl = 'zero_'..Bejewelatro.jewel_list[i]
            if v.ability[jwl] then
                jewel_tallies[jwl] = (jewel_tallies[jwl] or 0) + 1
                none_jewel = false
            end
        end

        --'quantum' gems
        for i = 1, #Bejewelatro.jewel_list do
            local jwl = 'zero_'..Bejewelatro.jewel_list[i]
            if is_jewel_colour(v, jwl, 'card') then
                mod_jewel_tallies[jwl] = (mod_jewel_tallies[jwl] or 0) + (is_jewel_colour(v, jwl, 'card') and 1 or 0)
                none_jewel = false
            end
        end

        if none_jewel == true then
            jewel_tallies['nonejewel'] = (jewel_tallies['nonejewel'] or 0) + 1
            mod_jewel_tallies['nonejewel'] = (mod_jewel_tallies['nonejewel'] or 0) + 1
        end

    end
    
    local modded = (face_tally ~= mod_face_tally) or
    (mod_jewel_tallies['zero_redjewel'] ~= jewel_tallies['zero_redjewel']) or
    (mod_jewel_tallies['zero_orangejewel'] ~= jewel_tallies['zero_orangejewel']) or
    (mod_jewel_tallies['zero_yellowjewel'] ~= jewel_tallies['zero_yellowjewel']) or
    (mod_jewel_tallies['zero_greenjewel'] ~= jewel_tallies['zero_greenjewel']) or
    (mod_jewel_tallies['zero_bluejewel'] ~= jewel_tallies['zero_bluejewel']) or
    (mod_jewel_tallies['zero_violetjewel'] ~= jewel_tallies['zero_violetjewel']) or
    (mod_jewel_tallies['zero_whitejewel'] ~= jewel_tallies['zero_whitejewel']) or
    (mod_jewel_tallies['nonejewel'] ~= jewel_tallies['nonejewel'])

    Bejewelatro.jewel_tallies = jewel_tallies
    Bejewelatro.mod_jewel_tallies = mod_jewel_tallies
    Bejewelatro.jewel_tallies_modded_present = modded
end

-- update deck peek values when deck is hovered
local card_hover_ref = Card.hover
function Card:hover()
    if do_bejewelatro() and self.area.config.type == 'deck' then
        if G.deck.children and G.deck.children.view_deck then
            G.deck.children.view_deck:remove()
            G.deck.children.view_deck = nil
        end
        Bejewelatro.f.update_jewel_peek_table_values()
    end
    card_hover_ref(self)
end

function Bejewelatro.f.suit_peek_table()
    local jewel_tallies = Bejewelatro.jewel_tallies
    local mod_jewel_tallies = Bejewelatro.mod_jewel_tallies
    local modded = Bejewelatro.jewel_tallies_modded_present
    return {
        n=G.UIT.C, config={align = "cm", r = 0.1, colour = G.C.BLACK, outline_colour = G.C.L_BLACK, line_emboss = 0.05, outline = 1.5, emboss = 0.2}, nodes={
            {n=G.UIT.R, config={align = "cm", minh = 0.05, padding = 0.07}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = {{string = localize('k_base_cards'), colour = G.C.RED}, modded and {string = localize('k_effective'), colour = G.C.BLUE} or nil}, colours = {G.C.RED}, silent = true,scale = 0.4,pop_in_rate = 10, pop_delay = 4})}}
            }},
            {n=G.UIT.R, config={align = "cm", minh = 0.05, padding = 0.1}, nodes={
                Bejewelatro.f.tally_sprite({x=0,y=0}, {{string = ''..jewel_tallies['zero_redjewel'], colour = flip_col},{string =''..mod_jewel_tallies['zero_redjewel'], colour = G.C.BLUE}}),
                Bejewelatro.f.tally_sprite({x=1,y=0}, {{string = ''..jewel_tallies['zero_orangejewel'], colour = flip_col},{string =''..mod_jewel_tallies['zero_orangejewel'], colour = G.C.BLUE}}),
                Bejewelatro.f.tally_sprite({x=2,y=0}, {{string = ''..jewel_tallies['zero_yellowjewel'], colour = flip_col},{string =''..mod_jewel_tallies['zero_yellowjewel'], colour = G.C.BLUE}}),
                Bejewelatro.f.tally_sprite({x=3,y=0}, {{string = ''..jewel_tallies['zero_whitejewel'], colour = flip_col},{string =''..mod_jewel_tallies['zero_whitejewel'], colour = G.C.BLUE}}),
            }},
            {n=G.UIT.R, config={align = "cm", minh = 0.05, padding = 0.1}, nodes={
                Bejewelatro.f.tally_sprite({x=0,y=1}, {{string = ''..jewel_tallies['zero_greenjewel'], colour = flip_col},{string =''..mod_jewel_tallies['zero_greenjewel'], colour = G.C.BLUE}}),
                Bejewelatro.f.tally_sprite({x=1,y=1}, {{string = ''..jewel_tallies['zero_bluejewel'], colour = flip_col},{string =''..mod_jewel_tallies['zero_bluejewel'], colour = G.C.BLUE}}),
                Bejewelatro.f.tally_sprite({x=2,y=1}, {{string = ''..jewel_tallies['zero_violetjewel'], colour = flip_col},{string =''..mod_jewel_tallies['zero_violetjewel'], colour = G.C.BLUE}}),
                Bejewelatro.f.tally_sprite({x=3,y=1}, {{string = ''..jewel_tallies['nonejewel'], colour = flip_col},{string =''..mod_jewel_tallies['nonejewel'], colour = G.C.BLUE}}),
            }},
        }
    }
end