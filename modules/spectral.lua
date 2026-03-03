SMODS.Atlas {
  key = "zero_spectral",
  px = 71,
  py = 95,
  path = "zero_spectral.png"
}

local bit = require("bit")

local zero_card_masks_ref = {}
local next_bit = 1

--dynamically assign bitmasks to all suits
for _, suit_name in ipairs(SMODS.Suit.obj_buffer) do
    zero_card_masks_ref[suit_name] = next_bit
    next_bit = next_bit * 2
end

local zero_MAX_RECIPE_LEN = 5

local function zero_card_to_mask(card)
    local mask = 0
    for _, _suit in ipairs(SMODS.Suit.obj_buffer) do
        if card:is_suit(_suit) then
            mask = mask + zero_card_masks_ref[_suit]
        end
    end
    return mask
end

-- ==========================================================
-- FIXED RECIPES
-- Define custom Philosopher's Stone recipes here. 
-- "suit" defaults to "ANY". "enh" defaults to "ANY". "count" defaults to 1.
-- ==========================================================
local zero_FIXED_RECIPES = {
    {
        item = "j_zero_eigengrau",
        recipe = { { suit = "zero_Brights", count = 5 } }
    },
    {
        item = "j_zero_lovejoy",
        recipe = { { suit = "Hearts", count = 5 } }
    },
    {
        item = "j_zero_skye",
        recipe = { { suit = "Spades", count = 5 } }
    },
    {
        item = "j_zero_vonllery",
        recipe = { { suit = "Diamonds", count = 5 } }
    },
    {
        item = "j_zero_hartwell",
        recipe = { { suit = "Clubs", count = 5 } }
    },
    --[[ Example recipe:
    {
        item = "j_my_awesome_joker",
        recipe = {
            { suit = "Spades", enh = "m_mult", count = 2 },     -- Exactly 2 Mult Spades
            { suit = "ANY", enh = "m_bonus", count = 1 },       -- Exactly 1 Bonus card of any suit
            { suit = "Hearts", count = 1 }                      -- Exactly 1 Heart with any enhancement
        }
    }
    ]]
}

local function zero_rarity_weight(r)
    return type(r) == "number" and r or 999
end

--evaluates if a single card fits a recipe's requirement component
local function card_satisfies_comp(card, comp_str)
    local parts = {}
    for p in comp_str:gmatch("[^_]+") do table.insert(parts, p) end
    local req_suit = parts[1]
    local req_enh = parts[2]
    if req_suit ~= "ANY" then
        local req_mask = tonumber(req_suit)
        local card_mask = zero_card_to_mask(card)
        if bit.band(card_mask, req_mask) == 0 then return false end
    end
    if req_enh ~= "ANY" then
        local card_enh = card.config.center.key or "c_base"
        if card_enh ~= req_enh then return false end
    end

    return true
end

--check if a group of cards exactly fulfills a recipe's requirements
local function match_recipe(hand_cards, recipe_comps)
    if #hand_cards ~= #recipe_comps then return false end
    
    local function search(card_idx, used_mask)
        if card_idx > #hand_cards then return true end
        for i = 1, #recipe_comps do
            if bit.band(used_mask, bit.lshift(1, i - 1)) == 0 then
                if card_satisfies_comp(hand_cards[card_idx], recipe_comps[i]) then
                    if search(card_idx + 1, bit.bor(used_mask, bit.lshift(1, i - 1))) then
                        return true
                    end
                end
            end
        end
        return false
    end
    return search(1, 0)
end

local function build_fixed_recipes()
    local fixed = {}
    local used_keys = {}
    local item_has_fixed_recipe = {}
    for _, entry in ipairs(zero_FIXED_RECIPES) do
        local comps = {}
        for _, req in ipairs(entry.recipe) do
            local suit_str = "ANY"
            if req.suit and req.suit ~= "ANY" then
                suit_str = tostring(zero_card_masks_ref[req.suit] or "ANY")
            end

            local enh_str = req.enh or "ANY"
            local count = req.count or 1

            for i = 1, count do
                table.insert(comps, suit_str .. "_" .. enh_str)
            end
        end
        table.sort(comps)
        table.insert(fixed, { comps = comps, item = entry.item })
        used_keys[table.concat(comps, "-")] = true
        item_has_fixed_recipe[entry.item] = true
    end
    return fixed, used_keys, item_has_fixed_recipe
end

local function zero_build_recipe_table()
    local fixed, used_keys, item_has_fixed_recipe = build_fixed_recipes()
    return { fixed = fixed }
end

local function stateless_random_element(pool, string_seed)
    local hash = 5381
    for i = 1, #string_seed do
        hash = (hash * 31 + string.byte(string_seed, i)) % 2147483647
    end
    return pool[(hash % #pool) + 1]
end

local function zero_get_procedural_fallback(cards)
    local cost = 0
    local key_parts = {}
    for _, card in ipairs(cards) do
        local mask = zero_card_to_mask(card)
        local enh = (card.config and card.config.center and card.config.center.key) or "c_base"
        cost = cost + (enh == "c_base" and 1 or 2)
        table.insert(key_parts, mask .. "_" .. enh)
    end
    table.sort(key_parts)
    local run_seed = (G.GAME and G.GAME.pseudorandom and G.GAME.pseudorandom.seed) or "seed"
    local seed_str = run_seed .. "-" .. table.concat(key_parts, "-")
    local rarity = 1
    if cost >= 8 then rarity = 4
    elseif cost >= 5 then rarity = 3
    elseif cost >= 3 then rarity = 2 end
    local pool = {}
    for _, j in ipairs(G.P_CENTER_POOLS.Joker) do
        if zero_rarity_weight(j.rarity) == rarity then
            table.insert(pool, j.key)
        end
    end
    if #pool == 0 then
        for _, j in ipairs(G.P_CENTER_POOLS.Joker) do table.insert(pool, j.key) end
    end
    return stateless_random_element(pool, seed_str)
end

local function zero_craft(cards, recipes)
    if not cards or #cards == 0 then return nil end
    local check_cards = {}
    for i = 1, math.min(#cards, zero_MAX_RECIPE_LEN) do table.insert(check_cards, cards[i]) end
    for _, recipe in ipairs(recipes.fixed) do
        if match_recipe(check_cards, recipe.comps) then return recipe.item end
    end
    return zero_get_procedural_fallback(check_cards)
end

local old_start_run = Game.start_run
function Game:start_run(args)
    old_start_run(self,args)
    if not G.GAME.zero_recipes or not args or not args.savetext then
        G.GAME.zero_recipes = zero_build_recipe_table()
    end
end

SMODS.Consumable {
    key = 'philosopher_stone',
    name = "Philosopher's Stone",
    set = 'Spectral',
    hidden = true,
    soul_set = 'Elemental',
    soul_rate = 0.024,
    atlas = 'zero_spectral',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },
    cost = 4,
	loc_vars = function(self, info_queue, card)
        return { vars = { G.hand and G.hand.highlighted and zero_craft(G.hand.highlighted, G.GAME.zero_recipes) and localize({type = "name_text", set = "Joker", key = zero_craft(G.hand.highlighted, G.GAME.zero_recipes)}) or "nothing" } }
    end,
    use = function(self, card, context, copier)
        local crafted_joker = zero_craft(G.hand.highlighted, G.GAME.zero_recipes)
        if crafted_joker then
            SMODS.add_card {
                set = 'Joker',
                key = crafted_joker
            }
            SMODS.destroy_cards(G.hand.highlighted)
        end
    end,
    can_use = function(self, card)
        return G.hand and G.hand.highlighted and zero_craft(G.hand.highlighted, G.GAME.zero_recipes) and true or false
    end,
    update = function(self, card, dt) --ortalab was an absolute savior for this
        local crafted_joker = G.hand and #G.hand.highlighted > 0 and zero_craft(G.hand.highlighted, G.GAME.zero_recipes)
        if crafted_joker then
            update_philosopherstone_atlas(card, G.ASSET_ATLAS[G.P_CENTERS[crafted_joker].atlas], G.P_CENTERS[crafted_joker].pos)
        else
            update_philosopherstone_atlas(card, G.ASSET_ATLAS[card.config.center.atlas], card.config.center.pos)
        end
    end
}

function update_philosopherstone_atlas(self, new_atlas, new_pos)
	if not self.children.front then
        self.children.front = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[new_atlas and new_atlas.name or "Joker"], new_pos)
        self.children.front.states.hover = self.states.hover
        self.children.front.states.click = self.states.click
        self.children.front.states.drag = self.states.drag
        self.children.front.states.collide.can = false
        self.children.front:set_role({major = self, role_type = 'Glued', draw_major = self})
    end
    self.children.front.sprite_pos = new_pos
    self.children.front.atlas.name = new_atlas and (new_atlas.key or new_atlas.name) or 'Joker'
    self.children.front:reset()
end