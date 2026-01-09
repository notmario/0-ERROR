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
	  e_zero_gala_playing_card = {
        name = "Gala",
        text = {
			"{C:attention}Mutates #1#{} time#2#",
			"at end of scoring",
			"{s:0.15} ",
        }
      },
	},
    Enhanced = {
	  m_wild = {
                name = "Wild Card",
                text = {
                    "Can be used as",
                    "any suit, cannot",
					"be {C:attention}debuffed"
                },
            },
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
		  "{C:money}$#1#{} then {E:2,C:red}self destructs",
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
	  tag_zero_alchemical = {
	    name = "Alchemical Tag",
		text = {
          "Gives a free",
          "{C:elemental}Mega Element Pack",
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
            "{C:red,E:2}self destructs{}"
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
			"hand above {C:attention}1{}, played cards {C:attention}mutate",
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
			"when entering {C:attention}shop"
			}
        },
      },
	  j_zero_sacred_pyre = {
        name = "Sacred Pyre",
        text = {
			{
			"Add a random {C:attention}Sunsteel Card{} to",
			"deck and increase {C:attention}Sunsteel Power",
			"by {X:diamonds,C:white}X#1#{} at end of round,",
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
			"by {X:diamonds,C:white}X#1#{} at end of round,"
			}
        },
      },
	  j_zero_violet_apostrophe_s_vessel = {
        name = "Violet's Vessel",
        text = {
			{
			"Create {C:attention}#2# {C:cups}Cups{} card#3#",
            "when {C:attention}Blind{} is selected,",
			"{X:attention,C:white}X#1#{C:attention} Blind{} size"
			}
        },
      },
	  j_zero_viscount = {
        name = "Viscount",
        text = {
			{
			"{C:cups}Cups{} cards in your",
            "{C:attention}consumable{} area give",
            "{X:red,C:white} X#1# {} Mult",
			}
        },
      },
	  j_zero_qrcode = {
        name = "QR Code",
        text = {
            "{C:chips}+#1#{} Chips for each",
            "{C:attention}0 ERROR{C:attention} Joker{} card",
            "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
        },
      },
	  j_zero_cups_prince = {
        name = "Prince of Cups",
        text = {
            "Create a {C:cups}Cups{} card if",
            "played hand contains",
            "only {C:attention}face{} cards with",
			"the same rank"
        },
      },
	  j_zero_dotdotdotdotdotdot = {
        name = "{f:zero_pokemon}......",
        text = {
			{
			"{f:zero_pixeldingbats}NJG{f:zero_pokemon,X:red,C:white}X#1#{f:zero_pokemon}Mult{f:zero_pixeldingbats}VCM",
			"{f:zero_pixeldingbats}£l<XMNCVBN,Aò",
			"{f:zero_pixeldingbats},AòGBY{f:zero_pokemon,C:diamonds}NO {f:zero_pokemon,C:hearts}REDS{f:zero_pixeldingbats}L"
          }
        },
      },
	  j_zero_damocles = {
        name = "Damocles",
        text = {
            "{C:attention}Use{} to receive",
			"a {E:1,C:blue}King's Blessing",
			"and a {E:2,C:red}Curse"
        },
      },
	  j_zero_damocles_active = {
        name = "Damocles",
        text = {
            "{C:attention}+#1#{C:blue} free{} card slots",
            "available in shop,",
			"{C:red}forces{} hands per",
			"round to {C:attention}1"
        },
      },
	  j_zero_crux = {
        name = "Crux",
        text = {
            "{C:attention}Transform{} a random {C:attention}consumable",
            "into a {C:planet}Planet{} card for your",
			"most played {C:attention}poker hand{} at",
			"the end of the {C:attention}shop"
        },
      },
	  j_zero_h_poke = {
        name = "{f:zero_pokemon,s:1.5}h POKé",
        text = {
			"{f:zero_pixeldingbats,s:1.5}FESGFDBGJHNFJ",
			"{f:zero_pixeldingbats,s:1.5}NCHLIAIPVINSK",
			"{f:zero_pixeldingbats,s:1.5}SCHWJSRGKVBMO",
			"{f:zero_pixeldingbats,s:1.5}NBXZZWBAFFDJC",
			"{f:zero_pixeldingbats,s:1.5}QMDORROGCVLXA",
			"{f:zero_pixeldingbats,s:1.5}RPMZDPVONWKQE",
			"{f:zero_pixeldingbats,s:1.5}WYBYVJSLYQLYB",
			"{f:zero_pixeldingbats,s:1.5}CCFNUGHGKFOTE",
			"{f:zero_pixeldingbats,s:1.5}ALFDWDYQWHQPZ",
			"{f:zero_pixeldingbats,s:1.5}GRMAZABRKRZZR",
			"{f:zero_pixeldingbats,s:1.5}JQAVAACEGFYJS",
			"{f:zero_pixeldingbats,s:1.5}IZORSHZUNTAKJ",
			"{f:zero_pixeldingbats,s:1.5}DJWMFMNYUETLS",
			"{f:zero_pixeldingbats,s:1.5}IJURGPRGIUNVI",
			"{f:zero_pixeldingbats,s:1.5}KIGBHYOGMIXOK",
			"{f:zero_pixeldingbats,s:1.5}PGAWOFIMZFVSN",
			"{f:zero_pixeldingbats,s:1.5}ZYRSHTQNZUMNB",
			"{f:zero_pixeldingbats,s:1.5}IHKTWFNMEWFBN",
			"{f:zero_pixeldingbats,s:1.5}XLHFHVIKHVSGJ",
			"{f:zero_pixeldingbats,s:1.5}XUJWXORTSZIIY",
			"{f:zero_pixeldingbats,s:1.5}QAVMWUIAGGWBO",
        },
      },
	  j_zero_strange_seeds = {
        name = "Strange Seeds",
        text = {
            "Blooms into a random",
            "{C:green}Magic Plant{} Joker",
			"after {C:attention}#1#{} rounds",
			"{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)"
        },
      },
	  j_zero_fabled_rose_of_isola = {
        name = {"Fabled Rose of Isola",
				"{s:0.5}Fabled Lemonbush"},
        text = {
			"Extremely valuable, gains {C:money}$#1#{} of",
            "{C:attention}sell value{} at end of round",
        },
      },
	  j_zero_magic_tree_of_fragrance = {
        name = {"Magic Tree of Fragrance",
				"{s:0.5}Fourpetal Maple"},
        text = {
			"{C:green}#2# in #1#{} chance to add a {C:red}Rare",
            "Joker to shop when {C:attention}rerolling"
        },
      },
	  j_zero_golden_berries_of_wealth = {
        name = {"Golden Berries of Wealth",
				"{s:0.5}Aureus Scandens"},
        text = {
			"{X:money,C:white}X#1#{} sell value to",
            "a random Joker"
        },
      },
	  j_zero_rose_of_joy = {
        name = {"Rose of Joy",
				"{s:0.5}Rosaceae Fern"},
        text = {
			"While shopping, {C:attention}selling",
            "a Joker adds {C:attention}2{} cards",
			"to shop"
        },
      },
	  j_zero_fruit_of_life = {
        name = {"Fruit of Life",
				"{s:0.5}Mela Rare Oak"},
        text = {
			"Sell this to create",
            "a {C:dark_edition}Negative{} {C:green}Strange Seeds{},",
			"it blooms in {C:attention}4{} less rounds"
        },
      },
	  j_zero_fruit_of_life_negative = {
        name = {"Fruit of Life",
				"{s:0.5}Mela Rare Oak"},
        text = {
			"Sell this to gain",
			"{C:dark_edition}+1{} Joker slot and create",
            "a {C:dark_edition}Negative{} {C:green}Strange Seeds{},",
			"it blooms in {C:attention}4{} less rounds"
        },
      },
	  j_zero_flower_of_knowledge = {
        name = {"Flower of Knowledge",
				"{s:0.5}Nox Orchid"},
        text = {
			"{C:attention}Removes{} the cap on interest",
			"earned in each round"
        },
      },
	  j_zero_croque_madame = {
        name = "Croque Madame",
        text = {
			"If a Joker is on the right of",
			"this at end of round, consume",
			"this and gain {C:money}${} equal to {C:attention}double",
			"the {C:attention}sell value{} of both"
        },
      },
	  j_zero_lip_balm = {
        name = "Lip Balm",
        text = {
			"Cards cannot be {C:attention}debuffed{},",
			"lasts {C:attention}#1#{} rounds",
        },
      },
	  j_zero_red_sketch = {
        name = "Red Sketch",
        text = {
			"Consumables copy the ability",
			"of rightmost {C:attention}Joker{}, destroy all",
			"consumables at end of round"
        },
      },
	  j_zero_q_triangle = {
        name = "{f:zero_pokemon}Q ▶",
        text = {
			"{f:zero_pixeldingbats}O{f:zero_pokemon,C:attention}H{f:zero_pixeldingbats}RE{f:zero_pokemon}8{f:zero_pixeldingbats}H{f:zero_pokemon}7{f:zero_pixeldingbats}S",
			"{f:zero_pixeldingbats}DHZ{f:zero_pokemon,C:attention}I{f:zero_pixeldingbats}NWAN",
			"{f:zero_pixeldingbats}Y{f:zero_pokemon}1{f:zero_pixeldingbats}GDA{f:zero_pokemon,C:attention}D{f:zero_pixeldingbats}ST",
			"{f:zero_pixeldingbats}IYUGZOO{f:zero_pokemon,C:attention}E{f:zero_pixeldingbats}",
        },
      },
	  j_zero_sharps_bin = {
        name = "Sharps Bin",
        text = {
            "This Joker gains {X:mult,C:white} X#1# {} Mult",
            "when a {C:attention}Glass{} card",
            "is destroyed",
            "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        },
      },
	  j_zero_3trainerpoke = {
        name = "{f:zero_pokemon}3TrainerPoké $",
        text = {
			"{f:zero_pixeldingbats}O{f:zero_pokemon,C:attention}Change{f:zero_pixeldingbats}WMYT{f:zero_pokemon}JokeRight{f:zero_pixeldingbats}YUI",
			"{f:zero_pixeldingbats}MCY{f:zero_pokemon}values{f:zero_pixeldingbats}PQU{f:zero_pokemon,C:red}Randomly{f:zero_pixeldingbats}QOI"
        },
      },
	  j_zero_missingno = {
        name = "{f:zero_pokemon}MissingNo.",
        text = {
			"{f:zero_pixeldingbats}OVCH{f:zero_pokemon}ヂャグ{f:zero_pixeldingbats}QEHEDS",
			"{f:zero_pixeldingbats}DS{f:zero_pokemon}�№{f:zero_pixeldingbats}ZINHCWANJ",
			"{f:zero_pixeldingbats}YGZFDBASDS{f:zero_pokemon}?シも",
			"{f:zero_pokemon}PKMN{f:zero_pixeldingbats}IYRMZ{f:zero_pokemon}のほ{f:zero_pixeldingbats}IE",
        },
      },
	  j_zero_portrait_dragee = {
        name = "Dragee's Portrait",
        text = {
			"Draw a {C:attention}Sunsteel Card{} and",
			"immediately {C:attention}score{} it when",
			"a {C:attention}Sunsteel Card{} or a card",
			"with {C:hearts}Heart{} suit scores"
        },
      },
	  j_zero_portrait_lunchalot = {
        name = "Lunchalot's Portrait",
        text = {
			"Retrigger all {C:attention}Gold{} and {C:attention}Steel Cards",
			"{C:inactive}({C:attention}Once{C:inactive} in hand and {C:attention}twice{C:inactive} in play)"
        },
      },
	  j_zero_found_a_star = {
        name = "Found a Star!",
        text = {
			"{C:attention}One{} random card in your",
			"deck is secretly {V:1}#1#",
			"suit, score it to {C:attention}reveal{} it",
			"{C:inactive,s:0.7}({V:1,s:0.7}#2#{C:inactive,s:0.7} count as any regular suit)",
        },
      },
	  j_zero_obsessive_elementation = {
        name = "Obsessive Elementation",
        text = {
			"{C:green}#1# in #2#{} chance for played",
			"cards with a suit to create a",
			"{C:elemental}Basic Element{} card of their",
			"{C:attention}original suit{} when scored"
        },
      },
	  j_zero_e = {
        name = "E",
        text = {
			"This Joker {C:attention}secretly{} chooses",
			"a suit every round and",
			"gains {X:mult,C:white} X#1# {} Mult when a",
			"card of that suit is scored",
			"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
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
	  c_zero_cups_eight = {
        name = "Eight of Cups",
        text = {
          "Destroys {C:attention}#1#{} random card#2#",
          "in hand and creates {C:attention}#3#{} cop#4# ",
          "of a random remaining one",
        },
      },
	  c_zero_cups_nine = {
        name = "Nine of Cups",
        text = {
          "Improves {C:attention}#1#{} card#2#",
          "{C:inactive}(determined by already",
		  "{C:inactive}applied {C:attention}modifiers{C:inactive})"
        },
      },
	  c_zero_cups_ten = {
        name = "Ten of Cups",
        text = {
          "{C:green}#2# in #1#{} chance to",
          "create a random",
          "{C:dark_edition}Negative {C:attention}Joker{} card"
        },
      },
	  c_zero_cups_page = {
        name = "Page of Cups",
        text = {
           "Creates a random {f:zero_pokemon}Glitch{C:attention} Joker{},",
           "if you already have one without an",
		   "{C:dark_edition}edition{}, adds {C:dark_edition}Gala{} to it instead",
        },
      },
	  c_zero_cups_knight = {
	    name = "Knight of Cups",
		text = {
		  "Enhances {C:attention}#1#{} selected",
		  "card#3# to {C:attention}#2##3#",
		  "and increases {C:attention}Sunsteel",
		  "{C:attention}Power{} by {X:diamonds,C:white}X#4#"
		},
	  },
	  c_zero_cups_queen = {
	    name = "Queen of Cups",
		text = {
		  "Converts all cards {C:attention}sharing",
		  "a suit with selected card to",
		  "suits that card {C:attention}doesn't have"
		},
	  },
	  c_zero_cups_king = {
	    name = "King of Cups",
		text = {
		  "Gives {C:money}$#1#{} per {C:cups}Cups",
		  "card used this run",
		  "{C:inactive}(currently {C:money}$#2#{C:inactive})"
		},
	  },
    },
	Elemental = {
	  c_zero_fire = {
        name = "Fire",
        text = {
			"Destroys up to",
			"{C:attention}#1#{} selected cards",
			"with {C:hearts}Heart{} suit"
		},
      },
	  c_zero_earth = {
        name = "Earth",
        text = {
			"Converts {C:attention}random{} cards equal",
			"to the number of cards with",
			"{C:spades}Spade{} suit in hand to {C:attention}Stone Cards"
		},
      },
	  c_zero_water = {
        name = "Water",
        text = {
			"Creates up to {C:attention}#1#{}",
            "random {C:attention}consumables",
			"{C:inactive}(Must select {C:attention}#2#{C:inactive} cards with",
            "{C:clubs}Club{C:inactive} suit and have room)",
		},
      },
	  c_zero_air = {
        name = "Air",
        text = {
			"Draws {C:attention}#1#{} cards",
			"with {C:diamonds}Diamond{} suit",
		},
      },
	  c_zero_cosmos = {
        name = "Cosmos",
        text = {
			"{C:attention}Splits{} selected card",
			"with {V:1}Bright{} suit into",
			"all suits it counts as"
		},
      },
	  c_zero_lava = {
        name = {"Lava",
				"{s:0.5}Earth + Fire"},
        text = {
			"Destroys any number of cards",
			"with {C:hearts}Heart{} or {C:spades}Spade{} suit, enhances",
			"an equal number of cards in deck",
			"to {C:attention}Steel{}, {C:attention}Gold{} or {C:attention}Sunsteel Cards"
        },
      },
	  c_zero_forest = {
        name = {"Forest",
				"{s:0.5}Earth + Water"},
        text = {
			"Removes {C:attention}Enhancements{} from up",
			"to {C:attention}#1#{} cards with {C:spades}Spade{} or {C:clubs}Club",
			"suit and creates an equal number",
			"of {C:dark_edition}Negative {C:spectral}Spectral{} cards"
        },
      },
	  c_zero_geyser = {
        name = {"Geyser",
				"{s:0.5}Fire + Water"},
        text = {
			"Destroys any number of cards",
			"with {C:hearts}Heart{} or {C:clubs}Club{} suit and",
			"creates a {C:attention}consumable{} based on",
			"those card's total {C:chips}chip value",
			"{C:inactive}({C:chips}#1#{C:inactive} Chips#2#{C:attention}#3#{C:inactive})"
        },
      },
	  c_zero_lightning = {
        name = {"Lightning",
				"{s:0.5}Air + Fire"},
        text = {
			"Destroys {C:attention}#1#{} random cards",
			"in deck with {C:hearts}Heart{} or {C:diamonds}Diamond",
			"suit, gain {C:money}${} equal to those",
			"card's total {C:chips}chip value"
        },
      },
	  c_zero_rain = {
        name = {"Rain",
				"{s:0.5}Air + Water"},
        text = {
            "Creates a copy of up to",
            "{C:attention}#1#{} selected cards with",
			"{C:diamonds}Diamond{} or {C:clubs}Club{} suit",
            "in your hand",
        },
      },
	  c_zero_tornado = {
        name = {"Tornado",
				"{s:0.5}Air + Earth"},
        text = {
            "Draws {C:attention}#1#{} cards with {C:spades}Spade{}",
			"or {C:diamonds}Diamond{} suit, give a random",
			"{C:attention}Enhancement{} to any without one"
        },
      },
	  c_zero_star = {
        name = {"Star",
				"{s:0.5}Fire + Cosmos"},
        text = {
            "{C:dark_edition}Merges {C:attention}4{} cards with",
			"different base suits into",
			"a {V:1}Bright{} suit card"
        },
      },
	  c_zero_planets = {
        name = {"Planets",
				"{s:0.5}Earth + Cosmos"},
        text = {
            "Removes {C:attention}Enhancements{} from all",
			"cards in hand and converts",
			"their suit to {V:1}Brights"
        },
      },
	  c_zero_nebulae = {
        name = {"Nebulae",
				"{s:0.5}Water + Cosmos"},
        text = {
            "Creates {C:attention}#1#{} random {V:1}Bright",
			"suit cards with {C:blue}Blue{} and",
			"{C:purple}Purple{} Seals respectively"
        },
      },
	  c_zero_comet = {
        name = {"Comet",
				"{s:0.5}Air + Cosmos"},
        text = {
            "Adds {C:dark_edition}Gala{} effect to {C:attention}#1#",
			"selected card in hand with",
			"{V:1}Bright{} suit, shuffle it in",
			"deck and draw {C:attention}#2#{} cards"
        },
      },
	  c_zero_wild = {
        name = {"Wild",
				"{s:0.5}???"},
        text = {
            "Enhances {C:attention}#1#{} selected cards",
            "to {C:attention}Wild Cards{}, creates {C:attention}2",
            "random {C:elemental}Basic Elements{}",
			"{C:inactive}(Must have room)"
        },
      },
    },
	Voucher = {
	  v_zero_homeworld = {
		name = "Homeworld",
		text = {
			"{X:prestige,C:white}Prestige{} cards may",
			"appear in any of",
			"the {C:attention}Celestial Packs",
        }
	  },
	  v_zero_cataclysm = {
		name = "Cataclysm",
		text = {
			"{X:prestige,C:white}Prestige{} cards reduce",
			"all active {C:dark_edition}Cooldowns",
			"by {C:attention}1{} when used",
        }
	  },
	  v_zero_better_dead_than_red = {
		name = {"Better Dead",
				"than Red"},
		text = {
			"Non-{C:dark_edition}Negative{} {X:prestige,C:white}Prestige{}",
			"cards create a {C:dark_edition}Negative{}",
			"copy when used",
        }
	  },
	  v_zero_overturned = {
		name = "Overturned",
		text = {
			"{C:cups}Cups{} cards can",
			"be purchased",
			"from the shop"
        }
	  },
	  v_zero_fine_wine = {
		name = "Fine Wine",
		text = {
			"Shops after clearing a {C:attention}Blind",
			"with {C:attention}double{} the required",
			"score or more contain an",
			"extra {C:cups}Cups Pack"
        }
	  },
	  v_zero_wine_cellar = {
		name = "Wine Cellar",
		text = {
			"All {C:cups}Cups{} cards and",
			"{C:cups}Cups Packs{} in the",
			"shop are {C:attention}free",
        }
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
	  p_zero_elemental_normal_1 = {
        name = "Element Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:elemental}Basic Element{} cards to",
		  "add to your consumables"
        }
      },
      p_zero_elemental_normal_2 = {
        name = "Element Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:elemental}Basic Element{} cards to",
		  "add to your consumables"
        }
      },
      p_zero_elemental_jumbo_1 = {
        name = "Jumbo Element Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:elemental}Basic Element{} cards and",
		  "{C:attention}#3#{C:elemental} Greater Element{} card#4# to",
		  "add to your consumables"
        }
      },
      p_zero_elemental_mega_1 = {
        name = "Mega Element Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:elemental}Basic Element{} cards and",
		  "{C:attention}#3#{C:elemental} Greater Element{} card#4# to",
		  "add to your consumables"
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
	  zero_q_triangle_storage = {
		name = "{f:zero_pokemon}←",
		text = {
			"{f:zero_pokemon,C:attention}#1#"
		},
	  },
	  zero_base_elements_reminder = {
		name = "Elemental Reactions",
		text = {
			"{C:attention}2 {C:elemental}Basic Elements{} combine",
			"into a {C:elemental}Greater Element"
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
	  b_elemental = "Elemental",
	  k_elemental_base = "Basic Element",
	  k_elemental_mix = "Greater Element",
	  k_elemental_chaotic = "Chaotic Element",
      k_elemental_pack = "Element Pack",
      k_plus_prestige = "+1 Prestige",
	  k_plus_cups = "+1 Cups",
	  k_plus_elemental = "+1 Element",
	  k_plus_suit_yourself = "+1 Suit Yourself",
	  k_plus_sunsteel_pow = "+Sunsteel Power",
      k_poisoned_ex = "Poisoned!",
      k_charged_ex = "Charged!",
	  k_mutated_ex = "Mutated!",
	  k_new_effect_ex = "New Effect!",
	  k_lose_effect_ex = "Lost Effect!",
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
	  k_plus_blessing_ex = "+Blessing!",
	  k_plus_curse_ex = "+Curse!",
	  k_transformed_ex = "Transformed!",
	  k_bloom_ex = "Bloom!",
	  k_plus_shop_ex = "+Shop!",
	  k_sell_value = "Value",
	  k_draw_ex = "Draw!",
	  k_stage_clear_upper = "STAGE CLEAR",
	  
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