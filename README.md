# Flurry
WoW - Addon - Change equip by zone (and subzone)

Download and unzip to your WoW Addon folder. (..\World of Warcraft\_retail_\Interface\AddOns)
Rename folder "Flurry-master" to "Flurry".

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
Each file is for one of your Talent specialisation in the order from top to down in your specialisation book.
For example the warrior's book:
1. Weapon - Spec1.lua
2. Fury   - Spec2.lua
3. Tank   . Spec3.lua

### Standart outfit:
For fallback outfits I have implemented a not existing "zones" named "Standard" in each Spec-file which is used in every case where is no configurated zone. E.g. I use it for my PvP gear.

### Example 1:
Lets make a Outfit for Nazjatar and The Eternal Palace and call it "Nazjatar Items" for the fury spec of your incredible warrior.
So you have to add these two lines to file "Spec2.lua":
["Nazjatar"] = "Nazjatar";
["The Eternal Palace"] = "Nazjatar";

### Example 2:
You want to wear the special cape for murlocs in newhome, make an outfit called "Annoying Murlocs" which ignore all slots excluding the back and set the cape in the back slot.
So you have to add these line to all trhee files "Spec1.lua, Spec2.lua, Spec3.lua":
["Newhome"] = "Annoying Murlocs";

### Example 3:
It's not needed to setup the exact name of a zone.
So if you want to wear an outfit in The Eternal Palace the String "Eternal Palace" is enough.
If you want to wear a special outfit in all zones where have the letters "new", make a config like this:
["new"] = "iamwithstupid";

### Pvp:
Because of a potential long list of battlegrounds and arenas I use the standart outfit for pvp gear and just specialize for special zones like nazjatar.

## Hints:
You can also use subzones(Showed name of place on minimap) in raid and mythic instances for specific gear for ever boss.
There is no fully list of all subzones for every zone in BfA like https://wowwiki.fandom.com/wiki/Icecrown#Subregions
So you have to refer by yourself to the following sites or ingame maps:

- https://wow.gamepedia.com/Arena
- https://wow.gamepedia.com/Battleground
- https://wow.gamepedia.com/Zone 

This addon is very simple and very effective.
I will not do any special development for ingame menu setup because this needs a fully internationalisation
and I realy dont want to waste my time on that.
