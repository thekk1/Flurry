-- Flurry, equip changing addon
-- by thekk
local standart = "Normal"
local Flurry, FlurryVars = ...
local SPEC1 = FlurryVars.SPEC1
local SPEC2 = FlurryVars.SPEC2
local SPEC3 = FlurryVars.SPEC3
function Flurry_OnLoad()
	------------------ Register game event handlers ---------------------------
	FlurryFrame:RegisterEvent("ZONE_CHANGED");
	FlurryFrame:RegisterEvent("ZONE_CHANGED_INDOORS");
	FlurryFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	FlurryFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED");
	FlurryFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
	-------------------- Register game event handlers ---------------------------

	-------------------- something stuff --------------------------------
	-------------------- something stuff --------------------------------
end

local function doEquip(setID, k, v)
	local ok = C_EquipmentSet.UseEquipmentSet(setID)
	if (ok) then
	print("Zone: "..k.." - Equip: "..v)	
	end
end

local function EquipSet(k, v)
	--print(k.." "..v)
	local setID = C_EquipmentSet.GetEquipmentSetID(v)
	local _,_,setID,isEquipped,_,_,_,_,_ = C_EquipmentSet.GetEquipmentSetInfo(setID)
	--print(setID);
	if(not isEquipped) then
		doEquip(setID, k, v)
	end
end

local function Flurry_setSpec(list)
	local zoneName = GetZoneText()
	local subZone = GetSubZoneText()
	--print("zoneName: "..zoneName)
	--print(string.find(zoneName, subZone))
	--print("subzone: "..subZone)
	--print(string.find(subZone, subZone))
	for k,v in pairs(list) do
		--print("key: "..k)
		--print("value: "..v)
		if (string.find(zoneName, k) or string.find(subZone, k)) then
			EquipSet(k, v)
			return;
		end
	end
	EquipSet("Standard", list["Standard"])
end

function Flurry_OnEvent(event)
	--print(SPEC2["Standart"])
	if (UnitAffectingCombat("player") or UnitIsDeadOrGhost("player")) then return; end
	local spec = GetSpecialization()
	--print("Spec: "..spec)
	
	if(spec == 1) then
		Flurry_setSpec(SPEC1)
	end
	
	if(spec == 2) then
		Flurry_setSpec(SPEC2)
	end
	
	if(spec == 3) then
		Flurry_setSpec(SPEC3)
	end
end