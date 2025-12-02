local loc_stuff = {
  descriptions = {
    Edition = {
      e_zero_gala = {
        name = "Gala",
        text = {
			"{C:attention}Mutates #1#{} time#2#",
			"at end of round",
			"{s:0.15} ",
        }
      },
	},
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
	  m_zero_l0ck = {
	    name = "L0ck Card",
	  },
	  m_zero_k3y = {
	    name = "K3y Card",
	  },
	  m_zero_l0ck_k3y = {
	    name = "#1#",
		text = {
		  "{C:attention}Immutable{}, must be played",
		  "with {C:attention}#2#{}, all scoring ",
		  "cards between the two are",
		  "{C:attention}stored{} until played again"
		},
	  },
	},
	Tag = {
	  tag_zero_crispr = {
	    name = "CRISPR Tag",
		text = {
          "Gives a free",
          "{X:prestige,C:white}Mega{} {X:prestige,C:white}Prestige{} {X:prestige,C:white}Pack",
		},
	  },
	  tag_zero_chalice = {
	    name = "Chalice Tag",
		text = {
          "Gives a free",
          "{C:cups}Mega Cups Pack",
		},
	  },
	  tag_zero_gala = {
	    name = "Gala Tag",
		text = {
          "Next base edition shop",
          "Joker is free and",
          "becomes {C:dark_edition}Gala",
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
            "Creates a {X:prestige,C:white}Prestige{} card when {C:attention}Blind{}",
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
	  j_zero_dismantled_cube = {
        name = "Dismantled Cube",
        text = {
          {
			"Sorts Deck",
			"by {C:attention}Suit order",
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
			"{C:attention}Mutates #1#{} time#2#",
			"at end of round",
			"{s:0.15} ",
          }
        },
      },
	  j_zero_alpine_lily_mult = {
		text = {
			"{C:mult}+#1#{} Mult",
		},
	  },
	  j_zero_alpine_lily_chips = {
		text = {
			"{C:chips}+#1#{} Chips",
		},
	  },
	  j_zero_alpine_lily_xmult = {
		text = {
			"{X:mult,C:white}X#1#{} Mult",
		},
	  },
	  j_zero_alpine_lily_xchips = {
		text = {
			"{C:white,X:chips}X#1#{} Chips",
		},
	  },
	  j_zero_alpine_lily_dollars = {
		text = {
			"{C:money}+$#1#",
		},
	  },
	  j_zero_despondent_joker = {
        name = "Despondent Joker",
        text = {
          {
			"Played cards with",
            "{V:1}#2#{} suit give",
            "{C:mult}+#1#{} Mult when scored",
          }
        },
      },
	  j_zero_star_sapphire = {
        name = "Star Sapphire",
        text = {
			{
			"Played cards with",
            "{V:1}#1#{} suit randomly",
            "give {C:money}$#2#{}, {X:mult,C:white} X#3# {} Mult,",
            "{C:chips}+#4#{} Chips or {C:mult}+#5#{} Mult",
			"when scored"
          }
        },
      },
	  j_zero_konpeito = {
        name = "Konpeito",
        text = {
			{
			"Consume this and convert",
			"all cards to {V:1}#1#{} when a",
            "{C:attention}5-card{} poker hand is played",
			"{C:inactive,s:0.7}({V:1,s:0.7}#1#{C:inactive,s:0.7} count as any regular suit)",
          }
        },
      },
	  j_zero_mirror_shard = {
        name = "Mirror Shard",
        text = {
			{
			"{C:attention}Glass Cards{} retrigger",
			"adjacent cards"
          }
        },
      },
	  j_zero_queen_sigma = {
        name = "Queen Sigma!",
        text = {
			{
			"{C:green}#2# in #1#{} chance to create",
			"a {C:tarot}Tarot{} card when a {C:attention}Queen{}",
			"is scored, make it {C:dark_edition}Negative{} if",
			"that card's suit is {C:clubs}Clubs{}",
			"{C:inactive,s:0.7}(Chance based on discovered {C:attention,s:0.7}base-game {C:inactive,s:0.7}Jokers)"
          }
        },
      },
	  j_zero_he_has_a_gun = {
        name = "HE HAS A GUN",
        text = {
			{
			"FORCES ALL {C:attention}7S{} TO BE SELECTED",
			"WHEN CARDS ARE DRAWN, {C:attention}7S{} HAVE A",
			"{C:green}#1# IN #2#{} CHANCE TO EARN {C:money}$#3#{}, {C:attention}+1{} CARD",
			"SELECTION LIMIT PER {C:attention}7{} IN HAND"
          }
        },
      },
	  j_zero_lockout = {
        name = "Lockout",
        text = {
			{
			"{C:attention}3{} times per round,",
			"shuffle all cards back",
			"in deck if only possible",
			"hand is a {C:attention}High Card",
			"{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
          }
        },
      },
	  j_zero_female_symbol = {
        name = "{f:zero_pixeldingbats}l{f:zero_pokemon} ♀ .",
        text = {
			{ --oh lawd
			"{f:zero_pixeldingbats}O{f:zero_pokemon}Pl{f:zero_pixeldingbats}A{f:zero_pokemon}yed{f:zero_pixeldingbats}/{C:attention,f:zero_pokemon}Queens{f:zero_pixeldingbats}\"{f:zero_pokemon}gain",
			"{f:zero_pixeldingbats})?{C:attention,f:zero_pokemon}rand{C:attention,f:zero_pixeldingbats}B{C:attention,f:zero_pokemon}m{C:attention,f:zero_pixeldingbats}=CV{C:attention,f:zero_pokemon}nuses{f:zero_pixeldingbats}£l<",
			"{f:zero_pixeldingbats}GJD{f:zero_pokemon}wh{f:zero_pixeldingbats}U{f:zero_pokemon}en{f:zero_pixeldingbats}[{f:zero_pokemon}sc{f:zero_pixeldingbats}UQ{f:zero_pokemon}ed{f:zero_pixeldingbats}QWQW"
          }
        },
      },
	  j_zero_key_he4rt = {
        name = "The Key To My He4rt",
        text = {
			{
			"While owned, add a {C:attention}L0ck Card{}",
			"and a {C:attention}K3y Card{} to deck"
          }
        },
      },
	  j_zero_hater = {
        name = "Hater",
        text = {
			{
			"This Joker gains {C:chips}Chips{} equal to",
			"total sell value of all current",
			"{C:attention}Jokers{} when hand is played",
			"{C:inactive,s:0.7}(Max of {C:chips,s:0.7}+#2#{C:inactive,s:0.7} at once, currently {C:chips,s:0.7}+#1#{C:inactive,s:0.7} Chips)"
          }
        },
      },
	  j_zero_valdi = {
        name = "Valdi",
        text = {
			{
			"Copies ability of {C:attention}Joker{}",
			"to the left {C:attention}#1#{} time#2#,",
			"{C:attention,s:0.7}Upgrades{s:0.7} if a {X:prestige,C:white,s:0.7}Prestige{s:0.7} card is used",
			"",
			"{C:dark_edition,s:0.7}Cooldown{s:0.3,C:attention} {f:6,s:0.55}—{s:0.3,C:attention} {C:attention,s:0.7}#3#"
          }
        },
      },
	  j_zero_valdi_cd = {
        name = "Valdi",
        text = {
			{
			"Copies ability of {C:attention}Joker{}",
			"to the left {C:attention}#1#{} time#2#,",
			"{C:red,s:0.7}Upgrade on cooldown!{}",
			"",
            "{s:0.7}Will become functional",
            "{s:0.7}after {C:attention,s:0.7}#3#{s:0.7} more {X:prestige,C:white,s:0.7}Prestige{s:0.7} use#4#"
          }
        },
      },
	  j_zero_4_h = {
        name = "{f:zero_pokemon}4 h",
        text = {
			{
			"{f:zero_pokemon}Pl{f:zero_pixeldingbats}A{f:zero_pokemon}yed{f:zero_pixeldingbats}W{f:zero_pokemon,C:attention}#1#s{f:zero_pixeldingbats}PkO",
			"{f:zero_pixeldingbats}CP{f:zero_pokemon}Kaf{f:zero_pixeldingbats}S{f:zero_pokemon}Js{f:zero_pixeldingbats}MV{f:zero_pokemon}srt",
			"{f:zero_pokemon,C:attention}#2#",
          }
        },
      },
	  j_zero_prestige_tree = {
        name = "Prestige Tree",
        text = {
			{
			"{C:chips}+#3#{} Chips, {C:mult}+#4#{} Mult,",
			"{C:green}#2# in #1#{} chance to create",
			"another {X:prestige,C:white}Prestige{} card",
			"when one is used"
			}
        },
      },
	  j_zero_ankimo = {
        name = "Ankimo",
        text = {
			{
			"While playing your {C:attention}highest-level",
			"hand above {C:attention}1{}, played cards mutate",
			"this Joker {C:attention}#1#{} time#2# when scored",
			"{C:inactive}(#3#)"
			}
        },
      },
	  j_zero_receipt = {
        name = "Receipt",
        text = {
			{
			"Bought cards gain",
			"{C:money}$#1#{} of {C:attention}sell value"
			}
        },
      },
	  j_zero_playjoke_chips = {
        name = "Playjoke",
        text = {
			{
			"{C:chips}+#1#{} Chips,",
			"{C:attention}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_playjoke_mult = {
        name = "Playjoke",
        text = {
			{
			"{C:mult}+#1#{} Mult,",
			"{C:attention}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_playjoke_xmult = {
        name = "Playjoke",
        text = {
			{
			"{X:mult,C:white}X#1#{} Mult,",
			"{C:attention}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_playjoke_dollars = {
        name = "Playjoke",
        text = {
			{
			"{C:money}+$#1#{},",
			"{C:attention}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_playjoke_swap = {
        name = "Playjoke",
        text = {
			{
			"Swap {X:chips,C:white}Chips{} and {X:mult,C:white}Mult{},",
			"{C:attention}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_playjoke_enhance = {
        name = "Playjoke",
        text = {
			{
			"Randomly {C:attention}enhance",
			"a card in play,",
			"{C:attention}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_playjoke_consumable = {
        name = "Playjoke",
        text = {
			{
			"{C:green}#2# in #1#{} chance to create",
			"a random consumable,",
			"{C:attention}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_lipu_suno = {
        name = "lipu suno",
        text = {
			{
			"kipisi tenpo la {C:attention}ante{} e {V:1}lipu suno",
			"{C:inactive}({C:green}#2#{C:inactive} kipisi {C:green}#1#{C:inactive} ken)"
			}
        },
      },
	  j_zero_downx2 = {
        name = "Down Down",
        text = {
			{
			"{C:green}#2# in #1#{} chance",
			"to {C:attention}halve{} all costs",
			"when entering {C:attention}shops"
			}
        },
      },
	  j_zero_sacred_pyre = {
        name = "Sacred Pyre",
        text = {
			{
			"Add a random {C:attention}Sunsteel Card{} to",
			"deck and increase {C:attention}Sunsteel Power",
			"by {X:mult,C:white}X#1#{} at end of round,",
			"{C:red,E:2,s:0.9}self destructs{s:0.9} to prevent death once"
			}
        },
      },
	  j_zero_sacred_pyre_resurrected = {
        name = "Sacred Pyre",
        text = {
			{
			"Add a random {C:attention}Sunsteel Card{} to",
			"deck and increase {C:attention}Sunsteel Power",
			"by {X:mult,C:white}X#1#{} at end of round,"
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
	Cups = {
	  c_zero_cups_ace = {
        name = "Ace of Cups",
        text = {
          {
          "Converts {C:attention}#1#{} selected card",
		  "to {V:1}#2#{} and creates",
		  "{C:attention}1{} random {C:cups}Cups{} card",
		  "{C:inactive,s:0.7}({V:1,s:0.7}#2#{C:inactive,s:0.7} count as any regular suit)",
          }
        },
      },
	  c_zero_cups_two = {
        name = "Two of Cups",
        text = {
          "Creates a random {X:prestige,C:white}Prestige{}",
          "and {C:planet}Planet{} card",
          "{C:inactive}(Must have room)",
        },
      },
	  c_zero_cups_three = {
        name = "Three of Cups",
        text = {
          {
          "Changes {C:attention}#1#{} enhanced",
		  "cards to {C:attention}Steel{}, {C:attention}Gold{} or",
		  "{C:attention}Sunsteel Cards{} randomly",
          }
        },
      },
	  c_zero_cups_four = {
        name = "Four of Cups",
        text = {
          "Selected card gives away",
          "{C:attention}Enhancement{}, {C:attention}Seal{} and",
          "{C:dark_edition}Edition{} to adjacent cards",
        },
      },
	  c_zero_cups_five = {
        name = "Five of Cups",
        text = {
          "Adds {C:dark_edition}Negative{} to",
          "a random {C:attention}Consumable"
        },
      },
	  c_zero_cups_six = {
        name = "Six of Cups",
        text = {
          "Adds {C:attention}Eternal{} to",
          "a selected Joker",
        },
      },
	  c_zero_cups_seven = {
        name = "Seven of Cups",
        text = {
          "Adds a random {C:attention}Seal{} to",
          "up to {C:attention}#1#{} selected cards",
        },
      },
	  c_zero_cups_knight = {
	    name = "Knight of Cups",
		text = {
		  "Enhances {C:attention}#1#{} selected",
		  "card#3# to {C:attention}#2##3#{},",
		  "increase {C:attention}Sunsteel",
		  "{C:attention}Power{} by {X:mult,C:white}X#4#"
		},
	  },
    },
    Other = {
      p_zero_prestige_normal_1 = {
        name = "Prestige Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2# {X:prestige,C:white}Prestige{} cards",
        }
      },
      p_zero_prestige_normal_2 = {
        name = "Prestige Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2# {X:prestige,C:white}Prestige{} cards",
        }
      },
      p_zero_prestige_jumbo_1 = {
        name = "Jumbo Prestige Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2# {X:prestige,C:white}Prestige{} cards",
        }
      },
      p_zero_prestige_mega_1 = {
        name = "Mega Prestige Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2# {X:prestige,C:white}Prestige{} cards",
        }
      },
	  p_zero_cups_normal_1 = {
        name = "Cups Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:cups} Cups{} cards to",
		  "be used immediately"
        }
      },
      p_zero_cups_normal_2 = {
        name = "Cups Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:cups} Cups{} cards to",
		  "be used immediately"
        }
      },
      p_zero_cups_jumbo_1 = {
        name = "Jumbo Cups Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:cups} Cups{} cards to",
		  "be used immediately"
        }
      },
      p_zero_cups_mega_1 = {
        name = "Mega Cups Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:cups} Cups{} cards to",
		  "be used immediately"
        }
      },

      scaler_explainer = {
        name = "Scaler",
        text = {
          "When used, increases",
          "all future {X:prestige,C:white}#1#{}'s",
          "strength by {C:attention}#2#"
        }
      },
      cooldown_explainer = {
        name = "Cooldown",
        text = {
          "When used, next {C:attention}#2#{} uses of",
          "{X:prestige,C:white}#1#{} do nothing, and",
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
	  valdi_effect = {
        name = "Valdi",
        text = {
			"{C:attention}Upgrades{} if a ",
			"{X:prestige,C:white}Prestige{} card is used"
        },
      },
	  
	  zero_brights_blurb = {
        text = {
          "Counts as each",
		  "regular suit",
        },
	  },
	  zero_gala_mult = {
		name = "Gala Mutation",
		text = {
			"{C:mult}+#1#{} Mult",
		},
	  },
	  zero_gala_chips = {
		name = "Gala Mutation",
		text = {
			"{C:chips}+#1#{} Chips",
		},
	  },
	  zero_gala_xmult = {
		name = "Gala Mutation",
		text = {
			"{X:mult,C:white}X#1#{} Mult",
		},
	  },
	  zero_gala_xchips = {
		name = "Gala Mutation",
		text = {
			"{C:white,X:chips}X#1#{} Chips",
		},
	  },
	  zero_gala_dollars = {
		name = "Gala Mutation",
		text = {
			"{C:money}+$#1#",
		},
	  },
	  zero_lipu_suno_info = {
		name = "mi toki ala e toki pona",
		text = {
			"Scoring {V:1}#3#{} have a",
			"{C:green}#2# in #1#{} chance to",
			"change {C:attention}enhancement"
		},
	  },
    },
  },
  misc = {
    dictionary = {
      b_prestige = "Prestige",
      k_prestige_pack = "Prestige Pack",
	  b_cups = "Cups",
      k_cups_pack = "Cups Pack",
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
	  k_nothing_ex = "Nothing!",
	  k_plus_mutation_ex = "+Mutation!",
	  k_minus_mutation_ex = "-Mutation!",
	  k_impossible_ex = "Impossible!",
	  k_swap_ex = "Swap!",
	  k_enhanced_ex = "Enhanced!",
	  k_discount_ex = "Discount!",
	  k_plus_sunsteel_pow = "+Sunsteel Power",
	  
	  k_ankimo_nil = "No valid hands",
	  k_ankimo_one = " is in the lead",
	  k_ankimo_two_1 = " and ",
	  k_ankimo_two_2 = " are tied",
	  k_ankimo_multiple = "Multiple hands are tied",

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
	  k_j_zero_valdi = "Valdi",
	  
	  ph_zero_sacred_pyre = "Saved by Sacred Pyre"
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
	challenge_names = {
		c_zero_alpine_garden = "Alpine Garden",
	},
	labels = {
		zero_gala = "Gala",
	},
  }
}

return loc_stuff