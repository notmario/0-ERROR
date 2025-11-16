assert(SMODS.load_file("./modules/logo.lua"))()
assert(SMODS.load_file("./modules/resources.lua"))()
assert(SMODS.load_file("./modules/hooks.lua"))()
assert(SMODS.load_file("./modules/funcs.lua"))()

assert(SMODS.load_file("./modules/prestige.lua"))()
assert(SMODS.load_file("./modules/jokers.lua"))()
assert(SMODS.load_file("./modules/enhancements.lua"))()
assert(SMODS.load_file("./modules/suits.lua"))()
assert(SMODS.load_file("./modules/tarot.lua"))()

assert(SMODS.load_file("./modules/challenges.lua"))()

print("0 ERROR")