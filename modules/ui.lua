--Credits page
SMODS.current_mod.extra_tabs = function()
  local credits_tab = {
    n = G.UIT.ROOT,
    config = { align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = G.C.BLACK },
    nodes = {
      {
        n = G.UIT.R,
		config = {align = "tm"},
        nodes = {
          {
            n = G.UIT.C,
            config = { padding = 0.5 },
            nodes = {
              {
                n = G.UIT.R,
                config = { align = 'cm' },
                nodes = {
                  { n = G.UIT.T, config = { text = "Developers", colour = G.C.GREEN, scale = 0.9 } },
                }
              },
            }
          },
          {
            n = G.UIT.C,
            config = { padding = 0.5 },
            nodes = {
              {
                n = G.UIT.R,
                config = { align = 'cm' },
                nodes = {
                  { n = G.UIT.T, config = { text = "Notmario\nAutumMood\nYouhWithAnH\nFreh", colour = G.C.WHITE, scale = 0.4 } },
                }
              },
            }
          },
        }
      },
	  {n = G.UIT.R, config = {align = "tm"}, nodes = {{n = G.UIT.T, config = {text = "", colour = G.C.WHITE, scale = 0.7}}}},
	  {
        n = G.UIT.R,
		config = {align = "tm"},
        nodes = {
          {
            n = G.UIT.C,
            config = { padding = 0.5 },
            nodes = {
              {
                n = G.UIT.R,
                config = { align = 'cm' },
                nodes = {
                  { n = G.UIT.T, config = { text = "Artists", colour = G.C.GREEN, scale = 0.9 } },
                }
              }
            }
          },
		  {
            n = G.UIT.C,
            config = { padding = 0.5 },
            nodes = {
              {
                n = G.UIT.R,
                config = { align = 'cm' },
                nodes = {
                  { n = G.UIT.T, config = { text = "missingnumber (lead artist)\ncassknows (edition shaders)", colour = G.C.WHITE, scale = 0.4 } },
                }
              },
            }
          },
		}
	  },
	  {n = G.UIT.R, config = {align = "tm"}, nodes = {{n = G.UIT.T, config = {text = "", colour = G.C.WHITE, scale = 0.5}}}},
	  {
		n = G.UIT.R,
		config = {align = "tm"},
        nodes = {
          {
            n = G.UIT.C,
            config = { padding = 0.5 },
            nodes = {
              {
                n = G.UIT.R,
                config = { align = 'cm' },
                nodes = {
                  { n = G.UIT.T, config = { text = localize('b_music'), colour = G.C.GREEN, scale = 0.9 } }
                }
              },
            }
          },
		  {
            n = G.UIT.C,
            config = { padding = 0.5 },
            nodes = {
              {
                n = G.UIT.R,
                config = { align = 'cm' },
                nodes = {
                  { n = G.UIT.T, config = { text = "missingnumber\n(lead composer)", colour = G.C.WHITE, scale = 0.4 } },
                }
              },
            }
          },
        }
      },
    }
  }
  return {
    {
      label = localize('b_credits'),
      tab_definition_function = function()
        return credits_tab
      end
    },
	{
      label = '???',
      tab_definition_function = function()
		G.zero_soshi_page = 1
		G.zero_soshi_condition_met = false
        return G.UIDEF.zero_soshi_wrapper()
      end
    },
  }
end