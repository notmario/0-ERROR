SMODS.current_mod.config_tab = function()
    local stake_colour_options = {}

    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
			{n=G.UIT.R, config = {align = 'cm'}, nodes={
                create_toggle({label = "(Spectrum Framework) Force-activate Specflush hand config on startup", ref_table = zero_config, ref_value = 'force_specflush', active_colour = G.C.RED, right = true}),
            }},
    }}
end