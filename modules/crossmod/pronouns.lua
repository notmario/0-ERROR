if next(SMODS.find_mod('cardpronouns')) then

	CardPronouns.Pronoun {
		colour = HEX("99E0E8"),
		text_colour = G.C.WHITE,
		pronoun_table = { "mirror :P" },
		in_pool = function()
			return false
		end,
		key = "mirror"
	}
	
end