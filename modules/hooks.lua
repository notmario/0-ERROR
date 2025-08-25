-- modified version of PTA's card use button
-- which is a modified version of aikoshen's wild scrabble card
local cardhighlighthook = Card.highlight
function Card:highlight(is_higlighted)
	local exists = self.children.use_button ~= nil
	local ret = cardhighlighthook(self, is_higlighted)

	if self.config.center.zero_usable and self.area and self.area ~= G.pack_cards then
		if self.highlighted and self.area and self.area.config.type ~= 'shop' and (self.area == G.jokers or self.area == G.consumeables) then
			if self.children.use_button then
				self.children.use_button:remove()
				self.children.use_button = nil
			end
			self.children.use_button = UIBox {
				definition = G.UIDEF.zeroerror_joker_use_buttons(self),
				config = { align =
					((self.area == G.jokers) or (self.area == G.consumeables)) and "cr" or
					"bmi"
				, offset =
					((self.area == G.jokers) or (self.area == G.consumeables)) and { x = -0.5, y = 0 } or
					{ x = 0, y = 0.65 },
					parent = self }
			}
		elseif exists and self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end
	end

	return ret
end


function G.UIDEF.zeroerror_joker_use_buttons(card, use_button)
	local sell = {
		n = G.UIT.C,
		config = { align = "cr" },
		nodes = {
			{
				n = G.UIT.C,
				config = { ref_table = card, align = "cr", padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card' },
				nodes = {
					{ n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
					{
						n = G.UIT.C,
						config = { align = "tm" },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", maxw = 1.25 },
								nodes = {
									{ n = G.UIT.T, config = { text = localize('b_sell'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
								}
							},
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{ n = G.UIT.T, config = { text = localize('$'), colour = G.C.WHITE, scale = 0.4, shadow = true } },
									{ n = G.UIT.T, config = { ref_table = card, ref_value = 'sell_cost_label', colour = G.C.WHITE, scale = 0.55, shadow = true } }
								}
							}
						}
					}
				}
			},
		}
	}
	local use = use_button and use_button(card) or {
		n = G.UIT.C,
		config = { align = "cr" },
		nodes = {

			{
				n = G.UIT.C,
				config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'use_card', func = 'can_use_consumeable' },
				nodes = {
					{ n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
					{ n = G.UIT.T, config = { text = localize('b_use'), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true } }
				}
			}
		}
	}
	local t = {
		n = G.UIT.ROOT,
		config = { padding = 0, colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.C,
				config = { padding = 0.15, align = 'cl' },
				nodes = {
					{
						n = G.UIT.R,
						config = { align = 'cl' },
						nodes = {
							sell
						}
					},
					{
						n = G.UIT.R,
						config = { align = 'cl' },
						nodes = {
							use
						}
					},
				}
			},
		}
	}
	return t
end

-- pulled from Entropy. thanks ruby!
local e_round = end_round
function end_round()
  e_round()
  local remove_temp = {}
  for i, v in pairs({G.jokers, G.hand, G.consumeables, G.discard, G.deck}) do
    for ind, card in pairs(v.cards) do
      if card.ability then
        if card.ability.zero_temporary then
          if card.area ~= G.hand and card.area ~= G.play and card.area ~= G.jokers and card.area ~= G.consumeables then card.states.visible = false end
          card:remove_from_deck()
          card:start_dissolve()
          if card.ability.zero_temporary then remove_temp[#remove_temp+1]=card end
        end
      end
    end
  end
  if #remove_temp > 0 then
    SMODS.calculate_context({remove_playing_cards = true, removed=remove_temp})
  end
end

function zero_error_use_joker (card, area, copier)
	stop_use()
	if card.debuff then return nil end
	local used_tarot = copier or card
	if card.ability.rental and G.GAME.cry_consumeable_rental_rate then
		G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			blocking = false,
			blockable = false,
			func = (function()
				ease_dollars(-G.GAME.cry_consumeable_rental_rate)
				return true
			end)
		}))
	end

	local obj = card.config.center
	if obj.use and type(obj.use) == 'function' then
		return obj:use(card, area, copier)
	end
end

-- patch for Brights' [Spades/Hearts/Clubs/Diamonds]ness
-- look here for Suit Yourself cards later
local alias__Card_is_suit = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
	if zero_has_any_regular_suit(self) then
		if suit == "Spades" or suit == "Hearts" or suit == "Clubs" or suit == "Diamonds" then
			return true
		end
		
		-- this specifically makes it do the thing for spectrums
		if suit == "not a suit" then return true end
	end
	return alias__Card_is_suit(self, suit, bypass_debuff, flush_calc)
end

local alias__SMODS_localize_perma_bonuses = SMODS.localize_perma_bonuses
function SMODS.localize_perma_bonuses(specific_vars, desc_nodes)
	local ret = alias__SMODS_localize_perma_bonuses(specific_vars, desc_nodes)
	
    if specific_vars and specific_vars.zero_brights then
        localize{type = 'other', key = 'zero_brights_blurb', nodes = desc_nodes, vars = {}}
    end
	
	return ret
end