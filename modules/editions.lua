--Alpine Lily's code but adapted as an edition basically
--had to make a few sacrifices like giving each mutation
--its own info_queue due to limitations with main_end
SMODS.Edition {
    key = 'gala',
    shader = 'zero_gala',
    config = {
		extra = {
			odds = {
				new_effect = 3,
				lose_effect = 3,
				change_effect = 5,
				gain_value = 12,
				lose_value = 8,
				nothing = 1,
				plus_mutation = 2,
				minus_mutation = 1,
			},
			min_new_value = 1,
			max_new_value = 10,
			min_gain_value = 1,
			max_gain_value = 15,
			min_lose_value = 1,
			max_lose_value = 10,
			mutations_per_round = 2,
			mutations = {
				{ effect = "chips", value = 10 },
			}
		}
	},
    in_shop = true,
    weight = 3,
    extra_cost = 5,
    sound = { sound = "zero_galasfx", per = 1.2, vol = 0.7 },
    get_weight = function(self)
        return (G.GAME.edition_rate - 1) * G.P_CENTERS["e_negative"].weight + G.GAME.edition_rate * self.weight
    end,
    gala_mutation_effects = {
		mult = {
			calculate = function(self, card, value)
				return {
					mult = value * 1
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { value * 1 } }
			end,
		},
		chips = {
			calculate = function(self, card, value)
				return {
					chips = value * 5
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { value * 5 } }
			end,
		},
		xmult = {
			calculate = function(self, card, value)
				return {
					xmult = 1 + (value * 0.025)
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { 1 + (value * 0.025) } }
			end,
		},
		xchips = {
			calculate = function(self, card, value)
				return {
					xchips = 1 + (value * 0.025)
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { 1 + (value * 0.025) } }
			end,
		},
		dollars = {
			calculate = function(self, card, value)
				return {
					dollars = math.floor(value * 0.4)
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { math.floor(value * 0.4) } }
			end,
		},
	},
	
	-- Returns a list of every valid mutation effect
	gala_list_mutation_effects = function(self)
		local ret = {}
		for key,effect in pairs(self.gala_mutation_effects) do
			if type(effect.in_pool) ~= "function" or effect:in_pool() then
				ret[#ret+1] = key
			end
		end
		return ret
	end,
	
	-- Creates a new mutation and places it into the mutations of card
	gala_create_mutation = function(self, card)
		local mutations = self:gala_list_mutation_effects()
		
		local mutation = { effect = pseudorandom_element(mutations, "zero_gala_new_mutation"), value = pseudorandom("zero_gala_new_value", card.edition.extra.min_new_value, card.edition.extra.max_new_value) }
		
		card.edition.extra.mutations[#card.edition.extra.mutations+1] = mutation
		return mutation
	end,	
	
    loc_vars = function(self, info_queue, card)
		for _, mutation in ipairs(card.edition.extra.mutations) do
			local mutation_effect = self.gala_mutation_effects[mutation.effect]
			local vars = {}
			if type(mutation_effect.loc_vars) == "function" then
				vars = mutation_effect:loc_vars(card, mutation.value).vars
			end
			info_queue[#info_queue+1] = { set = 'Other', key = "zero_gala_" .. mutation.effect, specific_vars = vars }
		end
		return {vars = {
			card.edition.extra.mutations_per_round,
			card.edition.extra.mutations_per_round == 1 and "" or "s",
		}, main_end = main_end}
    end,
	
    calculate = function(self, card, context)
		local function append_extra(_ret, append)
			if _ret.extra then return append_extra(_ret.extra, append) end
			_ret.extra = append
			return _ret
		end
		
		if context.pre_joker then
			local ret = {}
			for _,mutation in ipairs(card.edition.extra.mutations) do
				local mutation_effect = self.gala_mutation_effects[mutation.effect]
				if type(mutation_effect.calculate) == "function" then
					append_extra(ret, mutation_effect:calculate(card, mutation.value))
				end
			end
			if ret.extra then return ret.extra end
		end
		
		if not context.blueprint and ((context.end_of_round and not context.game_over and context.cardarea == G.jokers) or context.forcetrigger) then
			local ret = {}
			local repeats = card.edition.extra.mutations_per_round
			for iii=1,repeats do
				local odds_list = {
					"new_effect",
					"lose_effect",
					"change_effect",
					"gain_value",
					"lose_value",
					"nothing",
					"plus_mutation",
					"minus_mutation",
				}
				local max_odds = 0
				for k,v in ipairs(odds_list) do max_odds = max_odds + card.edition.extra.odds[v] end
				local roll = pseudorandom("zero_gala_eor", 1, max_odds)
				for k,v in ipairs(odds_list) do
					if roll <= card.edition.extra.odds[v] then
						-- do that effect
						if v == "new_effect" or (#card.edition.extra.mutations == 1 and v == "lose_effect") then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										self:gala_create_mutation(card)
									end,
									message = localize("k_new_effect_ex")
								},
							})
						elseif v == "lose_effect" then
							-- If this effect is rolled while the lily has
							-- 1 effect remaining, instead we literally just
							-- lie and pretend they rolled the above effect
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										table.remove(card.edition.extra.mutations, pseudorandom("zero_gala_lose_effect", 1, #card.edition.extra.mutations))
									end,
									message = localize("k_lose_effect_ex")
								},
							})
						elseif v == "change_effect" then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										card.edition.extra.mutations[pseudorandom("zero_gala_change_effect", 1, #card.edition.extra.mutations)].effect = pseudorandom_element(self:gala_list_mutation_effects(), "zero_gala_change_mutation")
									end,
									message = localize("k_change_effect_ex")
								},
							})
						elseif v == "gain_value" then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										local mutation = card.edition.extra.mutations[pseudorandom("zero_gala_gain_value_effect", 1, #card.edition.extra.mutations)]
										mutation.value = mutation.value + pseudorandom("zero_gala_gain_value", card.edition.extra.min_gain_value, card.edition.extra.max_gain_value)
									end,
									message = localize("k_gain_value_ex")
								},
							})
						elseif v == "lose_value" then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										local mutation = card.edition.extra.mutations[pseudorandom("zero_gala_lose_value_effect", 1, #card.edition.extra.mutations)]
										mutation.value = math.max(0, mutation.value - pseudorandom("zero_gala_lose_value", card.edition.extra.min_lose_value, card.edition.extra.max_lose_value))
									end,
									message = localize("k_lose_value_ex")
								},
							})
						elseif v == "nothing" then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									message = localize("k_nothing_ex")
								},
							})
						elseif v == "plus_mutation" or (card.edition.extra.mutations_per_round <= 1 and v == "minus_mutation") then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										card.edition.extra.mutations_per_round = card.edition.extra.mutations_per_round + 1
									end,
									message = localize("k_plus_mutation_ex")
								},
							})
						elseif v == "minus_mutation" then
							append_extra(ret, {
								message = localize("k_mutated_ex"),
								extra = {
									func = function()
										card.edition.extra.mutations_per_round = card.edition.extra.mutations_per_round - 1
									end,
									message = localize("k_minus_mutation_ex")
								},
							})
						end
						
						break
					else
						roll = roll - card.edition.extra.odds[v]
					end
				end
			end
			if ret.extra then return ret.extra end
		end
    end
}