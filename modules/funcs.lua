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