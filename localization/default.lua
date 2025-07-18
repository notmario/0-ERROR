local loc_stuff = {
  descriptions = {
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
    },
  },
  misc = {
    dictionary = {
      b_prestige = "Prestige",
      k_prestige_pack = "Prestige Pack",
      k_plus_prestige = "+1 Prestige",
      k_poisoned_ex = "Poisoned!",
      k_charged_ex = "Charged!",

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
    }
  }
}

return loc_stuff