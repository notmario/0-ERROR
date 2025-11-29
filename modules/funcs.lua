function zero_brights_in_deck()
	if G.deck then
		for k,v in ipairs(G.playing_cards) do
			if v.base.suit == "zero_Brights" and not SMODS.has_no_suit(v) then
				return true
			end
		end
	end
	return false
end

function zero_has_any_regular_suit(card)
	if SMODS.has_no_suit(card) then return false end
	if SMODS.has_any_suit(card) then return true end
	if card.base and card.base.suit == "zero_Brights" then return true end
	-- WARNING may break with quantum enhancements enabled
	-- (hopefully doesnt :fingers_crossed:)
	if SMODS.has_enhancement(card, "m_zero_suit_yourself") then
		return true
	end
	
	return false
end

function zero_cube_shuffle(_table)
	for i = #_table, 2, -1 do
		local j = pseudorandom("dismantled_cube", 1, i)
		_table[i], _table[j] = _table[j], _table[i]
    end
end

--mutation-related functions
-- Returns a list of every valid mutation effect
zero_list_mutation_effects = function(self)
	local ret = {}
	for key,effect in pairs(self.mutation_effects) do
		if type(effect.in_pool) ~= "function" or effect:in_pool() then
			ret[#ret+1] = key
		end
	end
	return ret
end
	
-- Creates a new mutation and places it into the mutations of card
zero_create_mutation = function(self, card, gala)
	local mutations = zero_list_mutation_effects(self)
	
	if gala then
		local mutation = { effect = pseudorandom_element(mutations, "zero_alpine_lily_new_mutation"), value = pseudorandom("zero_alpine_lily_new_value", card.edition.extra.min_new_value, card.edition.extra.max_new_value) }
	
		card.edition.extra.mutations[#card.edition.extra.mutations+1] = mutation
	else
		local mutation = { effect = pseudorandom_element(mutations, "zero_alpine_lily_new_mutation"), value = pseudorandom("zero_alpine_lily_new_value", card.ability.extra.min_new_value, card.ability.extra.max_new_value) }
	
		card.ability.extra.mutations[#card.ability.extra.mutations+1] = mutation
	end
	return mutation
end