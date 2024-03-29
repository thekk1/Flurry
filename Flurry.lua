-- Flurry, equip changing addon
-- by thekk
local standart = "Normal"
local Flurry, FlurryVars = ...
local SPEC1 = FlurryVars.SPEC1
local SPEC2 = FlurryVars.SPEC2
local SPEC3 = FlurryVars.SPEC3
local MSG1 = FlurryVars.MSG1
local MSG2 = FlurryVars.MSG2
local MSG3 = FlurryVars.MSG3
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

local waitTable = {};
local waitFrame = nil;

function FLURRY_wait(delay, func, ...)
  if(type(delay)~="number" or type(func)~="function") then
    return false;
  end
  if(waitFrame == nil) then
    waitFrame = CreateFrame("Frame","WaitFrame", UIParent);
    waitFrame:SetScript("onUpdate",function (self,elapse)
      local count = #waitTable;
      local i = 1;
      while(i<=count) do
        local waitRecord = tremove(waitTable,i);
        local d = tremove(waitRecord,1);
        local f = tremove(waitRecord,1);
        local p = tremove(waitRecord,1);
        if(d>elapse) then
          tinsert(waitTable,i,{d-elapse,f,p});
          i = i + 1;
        else
          count = count - 1;
          f(unpack(p));
        end
      end
    end);
  end
  tinsert(waitTable,{delay,func,{...}});
  return true;
end

local function FlurryMsg(zone, gear, msgList)
	for mk,mv in pairs(msgList) do
		--print(mk, "-", GetSubZoneText() )
		if (string.find(zone, mk) or string.find(gear, mk)) then
			message(mv)
			break
		end
	end
end

local function EquipSet(zone, gear, secondCall, msgList)
	local setID = C_EquipmentSet.GetEquipmentSetID(gear)
	local name,_,_,isEquipped, numItems, numEquipped, numInInventory, numLost, numIgnored = C_EquipmentSet.GetEquipmentSetInfo(setID)
	local equippingOk = false
	--print(name.." "..setID.." is equipped:")
	--print(isEquipped);
	--print(numItems.." "..numEquipped.." "..numInInventory.." "..numLost.." "..numIgnored)
	if(not isEquipped) then
		equippingOk = C_EquipmentSet.UseEquipmentSet(setID)
		if equippingOk then
			print("Zone: "..zone.." - Equip: "..gear)
			FlurryMsg("", gear, msgList)
			if not secondCall then FlurryFrame:RegisterEvent("EQUIPMENT_SWAP_FINISHED") end
		else
			print("No equippent : '"..gear.."' for zone: '"..zone.."' found")
		end
	end
	return isEquipped, equippingOk
end

local function Flurry_setSpec(list, zoneName, secondCall, mainZoneEquipped, msgList)
	--print("setSpec called")
	local noConfig = true
	local isEquipped, equippingOk
	for k,v in pairs(list) do
		--print(k)
		if (string.find(zoneName, k)) then
			noConfig = false
			isEquipped, equippingOk = EquipSet(k, v, secondCall, msgList)
			break
		end
	end
	if not secondCall and not equippingOk then Flurry_setSpec(list, GetSubZoneText(), true, (isEquipped or equippingOk), msgList) end
	if secondCall and noConfig and not mainZoneEquipped then EquipSet("Standard", list["Standard"], zoneName, msgList) end
end

function Flurry_OnEvent(event, ...)
	--print(event)
	--print("MainZone: "..GetZoneText())
	--print("SubZone: "..GetSubZoneText())
	
	if (UnitAffectingCombat("player") or UnitIsDeadOrGhost("player")) then return; end
	
	local zoneName = GetZoneText()
	local secondCall = false
	local mainZoneEquipped = false
	
	if(event == "EQUIPMENT_SWAP_FINISHED") then
		--print(arg1)
		--print(arg2)
		zoneName = GetSubZoneText()
		secondCall = true
		mainZoneEquipped = true
		FlurryFrame:UnregisterEvent("EQUIPMENT_SWAP_FINISHED")
	end
	--print(SPEC2["Standart"])
	local spec = GetSpecialization()
	--print("Spec: "..spec)
	--print("ZoneName: "..zoneName)
	if(spec == 1) then
		FLURRY_wait(0.5, Flurry_setSpec, SPEC1, zoneName, secondCall, mainZoneEquipped, MSG1)
		FlurryMsg(GetSubZoneText(), "", MSG1)
	end
	
	if(spec == 2) then
		FLURRY_wait(0.5, Flurry_setSpec, SPEC2, zoneName, secondCall, mainZoneEquipped, MSG2)
		FlurryMsg(GetSubZoneText(), "", MSG2)
	end
	
	if(spec == 3) then
		FLURRY_wait(0.5, Flurry_setSpec, SPEC3, zoneName, secondCall, mainZoneEquipped, MSG3)
		FlurryMsg(GetSubZoneText(), "", MSG3)
	end
end