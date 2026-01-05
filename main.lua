assert(SMODS.load_file("./modules/logo.lua"))()
assert(SMODS.load_file("./modules/resources.lua"))()
assert(SMODS.load_file("./modules/hooks.lua"))()
assert(SMODS.load_file("./modules/funcs.lua"))()

assert(SMODS.load_file("./modules/prestige.lua"))()
assert(SMODS.load_file("./modules/cups.lua"))()
assert(SMODS.load_file("./modules/elemental.lua"))()
assert(SMODS.load_file("./modules/jokers.lua"))()
assert(SMODS.load_file("./modules/tags.lua"))()
assert(SMODS.load_file("./modules/enhancements.lua"))()
assert(SMODS.load_file("./modules/editions.lua"))()
assert(SMODS.load_file("./modules/suits.lua"))()
assert(SMODS.load_file("./modules/tarot.lua"))()

assert(SMODS.load_file("./modules/crossmod/pronouns.lua"))()

assert(SMODS.load_file("./modules/challenges.lua"))()

assert(SMODS.load_file("./modules/ui.lua"))()
print("0 ERROR")