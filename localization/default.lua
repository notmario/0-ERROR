local loc_stuff = {
  descriptions = {
    Enhanced = {
	  m_zero_sunsteel = {
	    name = "Sunsteel Card",
		text = {
		  "{X:mult,C:white}X#1#{} Mult while this card",
		  "stays in hand, increased",
		  "by {X:mult,C:white}X#2#{} for each other",
		  "{C:attention}Sunsteel Card{} held in hand",
		},
	  },
	  m_zero_suit_yourself = {
	    name = "Suit Yourself Card",
		text = {
		  "No rank, counts as",
		  "any regular suit",
		  "If scored with cards of",
		  "each regular suit, earns",
		  "{C:money}$#1#{} then {E:1,C:red}self destructs",
		},
	  },
	},
    Tarot = {
	  c_zero_light = {
	    name = "The Light",
		text = {
          "Converts up to {C:attention}#1#{}",
		  "selected cards to {V:1}#2#{}",
		  "{C:inactive,s:0.7}({V:1,s:0.7}#2#{C:inactive,s:0.7} count as any regular suit)",
		},
	  },
	  c_zero_flame = {
	    name = "The Flame",
		text = {
		  "Enhances {C:attention}#1#",
		  "selected card#3# to",
		  "{C:attention}#2##3#",
		},
	  },
	  c_zero_choice = {
	    name = "The Choice",
		text = {
		  "Enhances {C:attention}#1#",
		  "selected card#3# to",
		  "{C:attention}#2##3#",
		},
	  },
	},
    Joker = {
      j_zero_mad = {
        name = "Mutual Assured Destruction",
        text = {
          {
            "Creates a {C:attention}Prestige{} card when {C:attention}Blind{}",
            "is beaten on {C:attention}final {C:attention}hand{} of round"
          }
        },
      },
      j_zero_paraquiet = {
        name = "Paraquiet",
        text = {
          {
            "{C:green}#1# in #2#{} chance to reduce the rank",
            "of each {C:attention}played card{}, this joker",
            "gains {C:mult}+#3# Mult{} for each rank lost",
            "{C:inactive}(Currently {C:mult}+#4#{C:inactive} Mult)",
            "{C:inactive}(Cannot reduce ranks past 2)",
          }
        },
      },
      j_zero_e_supercharge = {
        name = "Energy Supercharge",
        text = {
          {
            "Once per round, {C:dark_edition,E:1}use{} this joker",
            "to add a random {C:red}temporary{} {C:attention}Enhanced",
            "card of each suit to your hand"
          }
        },
      },
      j_zero_awesome_face = {
        name = "Awesome Face",
        text = {
          {
            "{C:dark_edition,E:1}Use{} this joker to gain",
            "{C:attention}four fifths{} of the blind score",
            "{C:red}self destructs{}"
          }
        },
      },
      j_zero_perma_monster = {
        name = "Perma-Monster",
        text = {
          {
            "Once per ante, {C:dark_edition,E:1}use{} this joker",
            "to destroy the {C:attention}leftmost{}",
            "{C:attention}Joker and permanently copy it",
            "{C:inactive}(Currently copying #1#)"
          }
        },
      },
      j_zero_elite_inferno = {
        name = "Elite Inferno",
        text = {
          {
            "Once per ante, {C:dark_edition,E:1}use{} this",
            "joker to {C:dark_edition,E:1}activate{} it.",
            "{X:mult,C:white}X#2#{} Mult if {C:dark_edition,E:1}active{}",
            "{C:inactive}(Currently {C:attention}#1#{C:inactive})"
          }
        },
      },
      j_zero_defense_removal = {
        name = "Defense Removal",
        text = {
          {
            "Once per ante, {C:dark_edition,E:1}use{} this joker",
            "to reduce the {C:attention}blind",
            "requirement by three quarters"
          }
        },
      },
      j_zero_dream_book = {
        name = "Dream Book",
        text = {
          {
            "Once per ante, {C:dark_edition,E:1}use{} this joker to draw ",
            "a card for each card currently in hand,",
            "and get +1 {C:blue}selection {C:red}limit{} until end of round"
          }
        },
      },
      j_zero_brilliance = {
        name = "Brilliance",
        text = {
          {
            "Played {C:attention}Gold Cards{} give",
			"{X:mult,C:white}X#1#{} Mult when scored",
			"Played {C:attention}Steel Cards{}",
			"earn {C:money}$#2#{} when scored",
          }
        },
      },
      j_zero_dragonsthorn = {
        name = "Dragonsthorn",
        text = {
          {
            "Played {C:attention}Sunsteel Cards{}",
			"give {X:mult,C:white}X#1#{} Mult when",
			"scored for each {C:attention}Sunsteel",
			"{C:attention}Card{} in your {C:attention}full deck",
			"{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive} Mult)",
          }
        },
      },
      j_zero_venture_card = {
        name = "Venture Card",
        text = {
          {
			"Adds a {C:attention}Suit Yourself{}",
			"card to deck when",
			"{C:attention}Blind{} is selected",
          }
        },
      },
      j_zero_alpine_lily = {
        name = "Alpine Lily",
        text = {
          {
			"{C:attention}Mutates{} at end of round, may",
			"gain or lose effects or values",
          }
        },
      },
    },
    Prestige = {
      c_zero_plasmid = {
        name = "Plasmid",
        text = {
          {
            "All future {C:red}+Mult{} triggers",
            "give {C:red}+#1#{} more {C:red}Mult{}",
            "",
            "{C:dark_edition}Scaler{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_antiplasmid = {
        name = "Anti-Plasmid",
        text = {
          {
            "All future {C:chips}+Chips{} triggers",
            "give {C:chips}+#1#{} more {C:chips}Chips{}",
            "",
            "{C:dark_edition}Scaler{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_supercoiledplasmid = {
        name = "Supercoiled Plasmid",
        text = {
          {
            "All future {X:mult,C:white}XMult{} triggers",
            "give {X:mult,C:white}X#1#{} more {X:mult,C:white}XMult{}",
            "",
            "{C:dark_edition}Scaler{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_darkenergy = {
        name = "Dark Energy",
        text = {
          {
            "{C:dark_edition}+#1#{} Joker Slot",
            "",
            "{C:dark_edition}Cooldown{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_darkenergy_cd = {
        name = "Dark Energy",
        text = {
          {
            "{C:red}On cooldown!{}",
            "",
            "Will become functional",
            "after {C:attention}#1#{} more use#2#"
          }
        },
      },
      c_zero_aicore = {
        name = "AI Core",
        text = {
          {
            "{C:attention}+#1#{C:blue} Hand{} and",
            "{C:red}Discard{} selection limit",
            "",
            "{C:dark_edition}Cooldown{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_aicore_cd = {
        name = "AI Core",
        text = {
          {
            "{C:red}On cooldown!{}",
            "",
            "Will become functional",
            "after {C:attention}#1#{} more use#2#"
          }
        },
      },
      c_zero_phage = {
        name = "Phage",
        text = {
          {
            "{C:attention}+#1#{} hand size",
            "",
            "{C:dark_edition}Cooldown{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_phage_cd = {
        name = "Phage",
        text = {
          {
            "{C:red}On cooldown!{}",
            "",
            "Will become functional",
            "after {C:attention}#1#{} more use#2#"
          }
        },
      },
      c_zero_harmonycrystal = {
        name = "Harmony Crystal",
        text = {
          {
            "{C:green}+#1#{} free shop rerolls",
            "",
            "{C:dark_edition}Cooldown{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_harmonycrystal_cd = {
        name = "Harmony Crystal",
        text = {
          {
            "{C:red}On cooldown!{}",
            "",
            "Will become functional",
            "after {C:attention}#1#{} more use#2#"
          }
        },
      },
      c_zero_artifact = {
        name = "Artifact",
        text = {
          {
            "{C:attention}+#1#{} shop slots",
            "",
            "{C:dark_edition}Cooldown{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_artifact_cd = {
        name = "Artifact",
        text = {
          {
            "{C:red}On cooldown!{}",
            "",
            "Will become functional",
            "after {C:attention}#1#{} more use#2#"
          }
        },
      },
      c_zero_bloodstone = {
        name = "Blood Stone",
        text = {
          {
            "{C:attention}+#1#{} consumeable slots",
            "",
            "{C:dark_edition}Cooldown{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_bloodstone_cd = {
        name = "Blood Stone",
        text = {
          {
            "{C:red}On cooldown!{}",
            "",
            "Will become functional",
            "after {C:attention}#1#{} more use#2#"
          }
        },
      },
    },
    Other = {
      p_zero_prestige_normal_1 = {
        name = "Prestige Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:attention} Prestige{} cards",
        }
      },
      p_zero_prestige_normal_2 = {
        name = "Prestige Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:attention} Prestige{} cards",
        }
      },
      p_zero_prestige_jumbo_1 = {
        name = "Jumbo Prestige Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:attention} Prestige{} cards",
        }
      },
      p_zero_prestige_mega_1 = {
        name = "Mega Prestige Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:attention} Prestige{} cards",
        }
      },

      scaler_explainer = {
        name = "Scaler",
        text = {
          "When used, increases",
          "all future {C:attention}#1#{}'s",
          "strength by {C:attention}#2#"
        }
      },
      cooldown_explainer = {
        name = "Cooldown",
        text = {
          "When used, next {C:attention}#2#{} uses of",
          "{C:attention}#1#{} do nothing, and",
          "increases next duration by {C:attention}1"
        }
      },
      
      phage_effect = {
        name = "Phage",
        text = {
          "{C:attention}+1{} hand size",
        }
      },
      darkenergy_effect = {
        name = "Dark Energy",
        text = {
          "{C:dark_edition}+1{} Joker Slot",
        }
      },
      aicore_effect = {
        name = "AI Core",
        text = {
          "{C:attention}+1{C:blue} Hand{} and",
          "{C:red}Discard{} selection limit",
        }
      },
      harmonycrystal_effect = {
        name = "Harmony Crystal",
        text = {
          "{C:green}+1{} free shop rerolls",
        },
      },
      artifact_effect = {
        name = "Artifact",
        text = {
          "{C:attention}+1{} shop slots",
        },
      },
      bloodstone_effect = {
        name = "Blood Stone",
        text = {
          "{C:attention}+1{} consumeable slot",
        },
      },
	  zero_brights_blurb = {
        text = {
          "Counts as each",
		  "regular suit",
        },
	  },
    },
  },
  misc = {
    dictionary = {
      b_prestige = "Prestige",
      k_prestige_pack = "Prestige Pack",
      k_plus_prestige = "+1 Prestige",
	  k_plus_suit_yourself = "+1 Suit Yourself",
      k_poisoned_ex = "Poisoned!",
      k_charged_ex = "Charged!",
	  k_mutated_ex = "Mutated!",
	  k_new_effect_ex = "New Effect!",
	  k_lose_effect_ex = "Lost Effect!",
	  k_change_effect_ex = "Changed Effect!",
	  k_gain_value_ex = "Gained Value!",
	  k_lose_value_ex = "Lost Value!",

      mult_extra = "Bonus +Mult",
      chips_extra = "Bonus +Chips",
      xmult_extra = "Bonus XMult",

      k_no_cooldowns = "No cards are on cooldown",
      k_prestige_cooldowns = "Cards on Cooldown:",
      k_c_zero_phage = "Phage",
      k_c_zero_darkenergy = "Dark Energy",
      k_c_zero_aicore = "AI Core",
      k_c_zero_harmonycrystal = "Harmony Crystal",
      k_c_zero_artifact = "Artifact",
      k_c_zero_bloodstone = "Blood Stone",
    },
	v_dictionary = {
	  zero_alpine_lily_mult = "+#1# Mult",
	  zero_alpine_lily_chips = "+#1# Chips",
	  zero_alpine_lily_xmult = "X#1# Mult",
	  zero_alpine_lily_xchips = "X#1# Chips",
	  zero_alpine_lily_dollars = "+$#1#",
	},
	suits_singular = {
	  zero_Brights = "Bright",
	},
	suits_plural = {
	  zero_Brights = "Brights",
	},
  }
}

return loc_stuff