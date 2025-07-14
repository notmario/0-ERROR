SMODS.Atlas {
  key = "zero_prestige",
  px = 71,
  py = 95,
  path = "zero_prestige.png"
}

SMODS.Atlas {
  key = "zero_booster",
  px = 71,
  py = 95,
  path = "zero_booster.png"
}

SMODS.ConsumableType {
  key = "Prestige",
  primary_colour = HEX("4f6367"),
  secondary_colour = HEX("344245"),
  loc_txt = {
    name = 'Prestige', -- used on card type badges
 		collection = 'Prestige Cards', -- label for the button to access the collection
 		undiscovered = { -- description for undiscovered cards in the collection
 			name = 'Undiscovered',
 			text = { '???' },
 		},
  },
  collection_rows = { 4, 5 },
  shop_rate = 0.0
}
  
SMODS.Booster({
  key = "prestige_normal_1",
  kind = "Prestige",
  atlas = "zero_booster",
  pos = { x = 0, y = 0 },
  config = { extra = 2, choose = 1 },
  cost = 4,
  weight = 0.48,
  unlocked = true,
  discovered = true,
  create_card = function(self, card)
    local n_card = create_card("Prestige", G.pack_cards, nil, nil, true, true, nil, "zero_prestige")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Prestige)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Prestige, special_colour = G.C.BLACK, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 2} }
  end,
  group_key = "k_prestige_pack",
})
SMODS.Booster({
  key = "prestige_normal_2",
  kind = "Prestige",
  atlas = "zero_booster",
  pos = { x = 1, y = 0 },
  config = { extra = 2, choose = 1 },
  cost = 4,
  weight = 0.48,
  unlocked = true,
  discovered = true,
  create_card = function(self, card)
    local n_card = create_card("Prestige", G.pack_cards, nil, nil, true, true, nil, "zero_prestige")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Prestige)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Prestige, special_colour = G.C.BLACK, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 2} }
  end,
  group_key = "k_prestige_pack",
})
SMODS.Booster({
  key = "prestige_jumbo_1",
  kind = "Prestige",
  atlas = "zero_booster",
  pos = { x = 2, y = 0 },
  config = { extra = 4, choose = 1 },
  cost = 6,
  weight = 0.48,
  unlocked = true,
  discovered = true,
  create_card = function(self, card)
    local n_card = create_card("Prestige", G.pack_cards, nil, nil, true, true, nil, "zero_prestige")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Prestige)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Prestige, special_colour = G.C.BLACK, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 4} }
  end,
  group_key = "k_prestige_pack",
})
SMODS.Booster({
  key = "prestige_mega_1",
  kind = "Prestige",
  atlas = "zero_booster",
  pos = { x = 3, y = 0 },
  config = { extra = 4, choose = 2 },
  cost = 8,
  weight = 0.24,
  unlocked = true,
  discovered = true,
  create_card = function(self, card)
    local n_card = create_card("Prestige", G.pack_cards, nil, nil, true, true, nil, "zero_prestige")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Prestige)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Prestige, special_colour = G.C.BLACK, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 2, card.ability and card.ability.extra or 4} }
  end,
  group_key = "k_prestige_pack",
})

function scaler_keyword(card, key)
  local base = G.GAME.Prestiges and G.GAME.Prestiges[key] or card.ability.immutable.base_amount
  base = base + card.ability.extra.scale_amount

  if not G.GAME.Prestiges then G.GAME.Prestiges = {} end
  G.GAME.Prestiges[key] = base
  
  return base
end

function cooldown_keyword(card, key)
  if G.GAME.Prestiges[key] ~= nil then
    G.GAME.Prestiges[key] = G.GAME.Prestiges[key] - 1
    if G.GAME.Prestiges[key] == 0 then
      G.GAME.Prestiges[key] = nil
      G.GAME.PrestigeCooldowns[key] = G.GAME.PrestigeCooldowns[key] + 1
    end
    return false
  else
    G.GAME.PrestigeCooldowns[key] = G.GAME.PrestigeCooldowns[key] or 1
    G.GAME.Prestiges[key] = G.GAME.PrestigeCooldowns[key]
    return true
  end
end

SMODS.Consumable({
  object_type = "Prestige",
  set = "Prestige",
  name = "Plasmid",
  key = "plasmid",
  pos = { x = 0, y = 0 },
  soul_pos = { x = 1, y = 0 },
  config = {
    immutable = {
      base_amount = 1
    },
    extra = {
      scale_amount = 1,
    }
  },
  cost = 4,
  atlas = "zero_prestige",
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    local value = scaler_keyword(card, "c_zero_plasmid")

    G.GAME.PrestigeValues.mult_extra = G.GAME.PrestigeValues.mult_extra + value
  end,
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = { key = "scaler_explainer", set="Other", specific_vars = { center.ability.name, center.ability.extra.scale_amount } }
    return {vars = { 
      G.GAME.Prestiges and G.GAME.Prestiges["c_zero_plasmid"] or center.ability.immutable.base_amount, 
      center.ability.extra.scale_amount 
    } }
  end,
})

SMODS.Consumable({
  object_type = "Prestige",
  set = "Prestige",
  name = "Phage",
  key = "phage",
  pos = { x = 2, y = 0 },
  soul_pos = { x = 3, y = 0 },
  config = {
    extra = {
      amount = 1,
    }
  },
  cost = 4,
  atlas = "zero_prestige",
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    local works = cooldown_keyword(card, "c_zero_phage")

    if works then
      G.hand:change_size(1)
    end
  end,
  loc_vars = function(self, info_queue, center)
    local cd_dur = G.GAME.PrestigeCooldowns and G.GAME.PrestigeCooldowns["c_zero_phage"] or 1
    local cur_cd = G.GAME.Prestiges["c_zero_phage"]
    if cur_cd ~= nil then
      info_queue[#info_queue+1] = { key = "phage_effect", set="Other" }
      return {
        key = self.key.."_cd",
        vars = {
          cur_cd,
          (cur_cd == 1) and "" or "s"
        }
      }
    end
    info_queue[#info_queue+1] = { key = "cooldown_explainer", set="Other", specific_vars = { center.ability.name, cd_dur } }
    return {vars = { 
      center.ability.extra.amount,
      cd_dur, 
    } }
  end,
})

SMODS.Consumable({
  object_type = "Prestige",
  set = "Prestige",
  name = "Dark Energy",
  key = "darkenergy",
  pos = { x = 4, y = 0 },
  soul_pos = { x = 5, y = 0 },
  config = {
    extra = {
      amount = 1,
    }
  },
  cost = 4,
  atlas = "zero_prestige",
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    local works = cooldown_keyword(card, "c_zero_darkenergy")

    if works then
      G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.amount
    end
  end,
  loc_vars = function(self, info_queue, center)
    local cd_dur = G.GAME.PrestigeCooldowns and G.GAME.PrestigeCooldowns["c_zero_darkenergy"] or 1
    local cur_cd = G.GAME.Prestiges["c_zero_darkenergy"]
    if cur_cd ~= nil then
      info_queue[#info_queue+1] = { key = "darkenergy_effect", set="Other" }
      return {
        key = self.key.."_cd",
        vars = {
          cur_cd,
          (cur_cd == 1) and "" or "s"
        }
      }
    end
    info_queue[#info_queue+1] = { key = "cooldown_explainer", set="Other", specific_vars = { center.ability.name, cd_dur } }
    return {vars = { 
      center.ability.extra.amount,
      cd_dur, 
    } }
  end,
})

SMODS.Consumable({
  object_type = "Prestige",
  set = "Prestige",
  name = "Harmony Crystal",
  key = "harmonycrystal",
  pos = { x = 0, y = 1 },
  soul_pos = { x = 1, y = 1 },
  config = {
    extra = {
      amount = 1,
    }
  },
  cost = 4,
  atlas = "zero_prestige",
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    local works = cooldown_keyword(card, "c_zero_harmonycrystal")

    if works then
      SMODS.change_free_rerolls(card.ability.extra.amount)
    end
  end,
  loc_vars = function(self, info_queue, center)
    local cd_dur = G.GAME.PrestigeCooldowns and G.GAME.PrestigeCooldowns["c_zero_harmonycrystal"] or 1
    local cur_cd = G.GAME.Prestiges["c_zero_harmonycrystal"]
    if cur_cd ~= nil then
      info_queue[#info_queue+1] = { key = "harmonycrystal_effect", set="Other" }
      return {
        key = self.key.."_cd",
        vars = {
          cur_cd,
          (cur_cd == 1) and "" or "s"
        }
      }
    end
    info_queue[#info_queue+1] = { key = "cooldown_explainer", set="Other", specific_vars = { center.ability.name, cd_dur } }
    return {vars = { 
      center.ability.extra.amount,
      cd_dur, 
    } }
  end,
})

SMODS.Consumable({
  object_type = "Prestige",
  set = "Prestige",
  name = "Blood Stone",
  key = "bloodstone",
  pos = { x = 2, y = 1 },
  soul_pos = { x = 3, y = 1 },
  config = {
    extra = {
      amount = 1,
    }
  },
  cost = 4,
  atlas = "zero_prestige",
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    local works = cooldown_keyword(card, "c_zero_bloodstone")

    if works then
      G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.amount
    end
  end,
  loc_vars = function(self, info_queue, center)
    local cd_dur = G.GAME.PrestigeCooldowns and G.GAME.PrestigeCooldowns["c_zero_bloodstone"] or 1
    local cur_cd = G.GAME.Prestiges["c_zero_bloodstone"]
    if cur_cd ~= nil then
      info_queue[#info_queue+1] = { key = "bloodstone_effect", set="Other" }
      return {
        key = self.key.."_cd",
        vars = {
          cur_cd,
          (cur_cd == 1) and "" or "s"
        }
      }
    end
    info_queue[#info_queue+1] = { key = "cooldown_explainer", set="Other", specific_vars = { center.ability.name, cd_dur } }
    return {vars = { 
      center.ability.extra.amount,
      cd_dur, 
    } }
  end,
})

SMODS.Consumable({
  object_type = "Prestige",
  set = "Prestige",
  name = "Artifact",
  key = "artifact",
  pos = { x = 4, y = 1 },
  soul_pos = { x = 5, y = 1 },
  config = {
    extra = {
      amount = 1,
    }
  },
  cost = 4,
  atlas = "zero_prestige",
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    local works = cooldown_keyword(card, "c_zero_artifact")

    if works then
      G.GAME.shop.joker_max = G.GAME.shop.joker_max + card.ability.extra.amount
    end
  end,
  loc_vars = function(self, info_queue, center)
    local cd_dur = G.GAME.PrestigeCooldowns and G.GAME.PrestigeCooldowns["c_zero_artifact"] or 1
    local cur_cd = G.GAME.Prestiges["c_zero_artifact"]
    if cur_cd ~= nil then
      info_queue[#info_queue+1] = { key = "artifact_effect", set="Other" }
      return {
        key = self.key.."_cd",
        vars = {
          cur_cd,
          (cur_cd == 1) and "" or "s"
        }
      }
    end
    info_queue[#info_queue+1] = { key = "cooldown_explainer", set="Other", specific_vars = { center.ability.name, cd_dur } }
    return {vars = { 
      center.ability.extra.amount,
      cd_dur, 
    } }
  end,
})

SMODS.Consumable({
  object_type = "Prestige",
  set = "Prestige",
  name = "AI Core",
  key = "aicore",
  pos = { x = 0, y = 2 },
  soul_pos = { x = 1, y = 2 },
  config = {
    extra = {
      amount = 1,
    }
  },
  cost = 4,
  atlas = "zero_prestige",
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    local works = cooldown_keyword(card, "c_zero_aicore")

    if works then
      SMODS.change_play_limit(card.ability.extra.amount)
      SMODS.change_discard_limit(card.ability.extra.amount)
    end
  end,
  loc_vars = function(self, info_queue, center)
    local cd_dur = G.GAME.PrestigeCooldowns and G.GAME.PrestigeCooldowns["c_zero_aicore"] or 1
    local cur_cd = G.GAME.Prestiges["c_zero_aicore"]
    if cur_cd ~= nil then
      info_queue[#info_queue+1] = { key = "aicore_effect", set="Other" }
      return {
        key = self.key.."_cd",
        vars = {
          cur_cd,
          (cur_cd == 1) and "" or "s"
        }
      }
    end
    info_queue[#info_queue+1] = { key = "cooldown_explainer", set="Other", specific_vars = { center.ability.name, cd_dur } }
    return {vars = { 
      center.ability.extra.amount,
      cd_dur, 
    } }
  end,
})

SMODS.Consumable({
  object_type = "Prestige",
  set = "Prestige",
  name = "Supercoiled Plasmid",
  key = "supercoiledplasmid",
  pos = { x = 2, y = 2 },
  soul_pos = { x = 3, y = 2 },
  config = {
    immutable = {
      base_amount = 0.1
    },
    extra = {
      scale_amount = 0.1,
    }
  },
  cost = 4,
  atlas = "zero_prestige",
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    local value = scaler_keyword(card, "c_zero_supercoiledplasmid")

    G.GAME.PrestigeValues.xmult_extra = G.GAME.PrestigeValues.xmult_extra + value
  end,
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = { key = "scaler_explainer", set="Other", specific_vars = { center.ability.name, center.ability.extra.scale_amount } }
    return {vars = { 
      G.GAME.Prestiges and G.GAME.Prestiges["c_zero_supercoiledplasmid"] or center.ability.immutable.base_amount, 
      center.ability.extra.scale_amount 
    } }
  end,
})


SMODS.Consumable({
  object_type = "Prestige",
  set = "Prestige",
  name = "Anti-Plasmid",
  key = "antiplasmid",
  pos = { x = 4, y = 2 },
  soul_pos = { x = 5, y = 2 },
  config = {
    immutable = {
      base_amount = 5
    },
    extra = {
      scale_amount = 5,
    }
  },
  cost = 4,
  atlas = "zero_prestige",
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area, copier)
    local value = scaler_keyword(card, "c_zero_antiplasmid")

    G.GAME.PrestigeValues.chips_extra = G.GAME.PrestigeValues.chips_extra + value
  end,
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = { key = "scaler_explainer", set="Other", specific_vars = { center.ability.name, center.ability.extra.scale_amount } }
    return {vars = { 
      G.GAME.Prestiges and G.GAME.Prestiges["c_zero_antiplasmid"] or center.ability.immutable.base_amount, 
      center.ability.extra.scale_amount 
    } }
  end,
})

-- UI

function create_UIBox_current_prestige_row(my_type, key, default, col)
  return ({n=G.UIT.R, config={align = "cm", padding = 0.05, r = 0.1, colour = col, emboss = 0.05, hover = true, force_focus = true}, nodes={
      {n=G.UIT.C, config={align = "cl", padding = 0, minw = 5}, nodes={
        {n=G.UIT.C, config={align = "cm", minw = 4.5, maxw = 4.5}, nodes={
          {n=G.UIT.T, config={text = ' '..localize(my_type), scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
        }}
      }},
      {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = darken(col, 0.8),r = 0.1}, nodes={
        {n=G.UIT.C, config={align = "cr", padding = 0.01, r = 0.1, minw = 1.4}, nodes={
          {n=G.UIT.T, config={text = G.GAME.PrestigeValues[my_type], scale = 0.45, colour = G.C.UI.TEXT_LIGHT}},
          {n=G.UIT.B, config={w = 0.08, h = 0.01}}
        }}
      }},
      {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = darken(col, 0.6),r = 0.1, minw = 1}, nodes={
        {n=G.UIT.T, config={text = "+"..(G.GAME.Prestiges and G.GAME.Prestiges[key] or default), scale = 0.45, colour = G.C.TEXT_LIGHT, shadow = true}},
      }},
    }})
  or nil
end

function create_UIBox_prestige_cooldown_row(key)
  local col = G.C.JOKER_GREY
  return ({n=G.UIT.R, config={align = "cm", padding = 0.05, r = 0.1, colour = darken(col, 0.1), emboss = 0.05, hover = true, force_focus = true}, nodes={
      {n=G.UIT.C, config={align = "cl", padding = 0, minw = 6.6}, nodes={
        {n=G.UIT.C, config={align = "cm", minw = 6, maxw = 6}, nodes={
          {n=G.UIT.T, config={text = localize('k_'..key), scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
        }}
      }},
      {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = darken(col, 0.6),r = 0.1, minw = 1}, nodes={
        {n=G.UIT.T, config={text = (G.GAME.Prestiges and G.GAME.Prestiges[key] or default), scale = 0.45, colour = G.C.TEXT_LIGHT, shadow = true}},
      }},
    }})
  or nil
end

function create_UIBox_current_prestige(simple)
  local hands = {
    create_UIBox_current_prestige_row("mult_extra", "c_zero_plasmid", 1, darken(G.C.MULT, 0.1)),
    create_UIBox_current_prestige_row("chips_extra", "c_zero_antiplasmid", 5, darken(G.C.CHIPS, 0.1)),
    create_UIBox_current_prestige_row("xmult_extra", "c_zero_supercoiledplasmid", 0.2, darken(G.C.MULT, 0.2)),

    -- PATCH TARGET: PRESTIGE SCREEN
  }

  local cooldown_nodes = {
    {n=G.UIT.T, config={text = ' '..localize("k_no_cooldowns"), minw = 2, scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
  }

  local cooldown_cards = {}
  for k, v in pairs(G.GAME.PrestigeCooldowns) do
    if G.GAME.Prestiges[k] ~= nil then
      cooldown_cards[#cooldown_cards + 1] = k
    end
  end

  if #cooldown_cards > 0 then
    cooldown_nodes = {
      {n=G.UIT.R, config={align = "cm", minw = 6, maxw = 6, padding = 0.04}, nodes={
        {n=G.UIT.T, config={text = ' '..localize("k_prestige_cooldowns"), scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
      }}
    }

    for _, v in ipairs(cooldown_cards) do
      cooldown_nodes[#cooldown_nodes + 1] = create_UIBox_prestige_cooldown_row(v)
    end
  end

  local t = {n=G.UIT.ROOT, config={align = "cm", minw = 4, padding = 0.1, r = 0.1, colour = G.C.CLEAR}, nodes={
    {n=G.UIT.R, config={align = "cm", padding = 0.04}, nodes=
      hands
    },
    {n=G.UIT.R, config={align = "cm", minh = 0.1}, nodes={}},
    {n=G.UIT.R, config={align = "cm", padding = 0.04}, nodes=
      cooldown_nodes
    },
  }}

  return t
end

-- apply score bonuses
local scalcieff = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
  if key == "chips" or key == "h_chips" or key == "chip_mod" then
    amount = amount + G.GAME.PrestigeValues.chips_extra
  end
  if key == "mult" or key == "h_mult" or key == "mult_mod" then
    amount = amount + G.GAME.PrestigeValues.mult_extra
  end
  if key == "x_mult" or key == "xmult" or key == "Xmult" or key == "x_mult_mod" or key == "Xmult_mod" then
    amount = amount + G.GAME.PrestigeValues.xmult_extra
  end
  scalcieff(effect, scored_card, key, amount, from_edition)
end