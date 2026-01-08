SMODS.Voucher {
	key = 'better_dead_than_red',
	atlas = 'zero_vouchers',
	pos = { x = 2, y = 0 },
	discovered = true,
	requires = {
		'v_zero_cataclysm'
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
	end,
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == 'Prestige' and (not context.consumeable.edition or not context.consumeable.edition.negative) then
            local copy = copy_card(context.consumeable)
			copy:set_edition({negative = true})
			G.consumeables:emplace(copy)
        end
	end
}

local alias_card_setcost = Card.set_cost
function Card:set_cost()
    if (self.ability.set == 'Cups' or (self.ability.set == 'Booster' and self.ability.name:find('cups'))) and G.GAME.used_vouchers.v_zero_wine_cellar then self.cost = 0
    else
        return alias_card_setcost(self)
    end
end

SMODS.Voucher {
	key = 'wine_cellar',
	atlas = 'zero_vouchers',
	pos = { x = 5, y = 0 },
	discovered = true,
	requires = {
		'v_zero_fine_wine'
	},
	add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
}