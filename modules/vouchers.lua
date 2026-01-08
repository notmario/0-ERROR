SMODS.Atlas {
	key = "zero_vouchers",
	px = 71,
	py = 95,
	path = "zero_vouchers.png"
}

SMODS.Voucher {
	key = 'homeworld',
	atlas = 'zero_vouchers',
	pos = { x = 0, y = 0 },
	discovered = true
}

SMODS.Booster:take_ownership_by_kind('Celestial', {
        create_card = function(self, card, i)
            local _card
            if G.GAME.used_vouchers.v_zero_homeworld and i ~= 1 and pseudorandom('homeworld') > 0.85 then
                _card = {
                    set = "Prestige",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    "pl2"
                }
            else
                if G.GAME.used_vouchers.v_telescope and i == 1 then
					local _planet, _hand, _tally = nil, nil, 0
					for _, handname in ipairs(G.handlist) do
						if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
							_hand = handname
							_tally = G.GAME.hands[handname].played
						end
					end
					if _hand then
						for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
							if planet_center.config.hand_type == _hand then
								_planet = planet_center.key
							end
						end
					end
					_card = {
						set = "Planet",
						area = G.pack_cards,
						skip_materialize = true,
						soulable = true,
						key = _planet,
						key_append =
						"pl1"
					}
				else
					_card = {
						set = "Planet",
						area = G.pack_cards,
						skip_materialize = true,
						soulable = true,
						key_append =
						"pl1"
					}
				end
            end
            return _card
        end,
    },
    true
)

SMODS.Voucher {
	key = 'cataclysm',
	atlas = 'zero_vouchers',
	pos = { x = 1, y = 0 },
	discovered = true,
	requires = {
		'v_zero_homeworld'
	},
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == 'Prestige' then
            for k, v in pairs(G.GAME.Prestiges) do
				if k ~= context.consumeable.config.center.key and not k:find('plasmid') then
					cooldown_keyword(card, k)
				end
			end
        end
	end
}

SMODS.Voucher {
	key = 'overturned',
	atlas = 'zero_vouchers',
	pos = { x = 3, y = 0 },
	discovered = true,
	redeem = function(self, card)
		G.GAME.cups_rate = 3
	end,
}

SMODS.Voucher {
	key = 'fine_wine',
	atlas = 'zero_vouchers',
	pos = { x = 4, y = 0 },
	config = {
		pack = false
	},
	discovered = true,
	requires = {
		'v_zero_overturned'
	},
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and G.GAME.chips >= G.GAME.blind.chips * 2 then
			card.ability.pack = true
		end
		if context.starting_shop and card.ability.pack then
			card.ability.pack = false
			G.E_MANAGER:add_event(Event {
				func = function()
				local booster = SMODS.add_booster_to_shop('p_zero_cups_normal_' .. math.random(1, 2))
				booster:set_cost()
				return true
				end
			})
		end
	end
}