# Flurry
WoW - Addon - Change equip by zone (and subzone)

## Addon changes equip by this events:
- ZONE_CHANGED
- ZONE_CHANGED_INDOORS
- ZONE_CHANGED_NEW_AREA
- PLAYER_SPECIALIZATION_CHANGED
- PLAYER_REGEN_ENABLED (if you becomes alive in an other zone)

## It does NOT change while:
- Player is in fight
- Player is dead

## Usage:
- Make outfits ingame with Blizz Equipment Manager.
- Find out name of zone or subzone in the LANGUAGE OF YOUR GAME, where a outfit should be used.
- Fill in one of the three "spec" files your setup with zone and outfit-name.
- Optional test key: Keysetup -> Others -> FLURRY 

### Explanation of Spec-files:
Each file is for of of your Talent specialisation in the order from top to down in your specialisation book.
For example the warrior'S book:
1. Weapon - Spec1.lua
2. Fury   - Spec2.lua
3. Tank   . Spec3.lua

### Example1:
Lets make a Outfit for Nazjatar and The Eternal Palace and call it "Nazjatar Items" for the fury spec of your incredible warrior.
So you have to add these two lines to file "Spec2.lua":
["Nazjatar"] = "Nazjatar";
["The Eternal Palace"] = "Nazjatar";

### Example2:
You want to wear the special cape for murlocs in newhome, make an outfit called "Annoying Murlocs" which ignore all slots excluding the back and set the cape in the back slot.
So you have to add these line to all trhee files "Spec1.lua, Spec2.lua, Spec3.lua":
["Newhome"] = "Annoying Murlocs";

## Hints:
You can also use subzones in raid and mythic instances for specific gear for ever boss.
Pls. refer to https://wow.gamepedia.com/Zone or ingame maps.

This addon is very simple and very effective.
I will not do any special development for ingame menu setup because this needs a fully internationalisation
and I realy dont want to waste my time on that.
