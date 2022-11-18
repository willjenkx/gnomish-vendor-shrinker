
local myname, ns = ...


local function HasHeirloom(id)
	return C_Heirloom.IsItemHeirloom(id) and C_Heirloom.PlayerHasHeirloom(id)
end

local function ScanLeftText(id, validator)
	ns.scantip = C_TooltipInfo.GetItemByID(id)
	TooltipUtil.SurfaceArgs(ns.scantip)
	for _, line in ipairs(ns.scantip.lines) do
		TooltipUtil.SurfaceArgs(line)
		if line.leftText == validator then
			return true
		end
	end
end


local function IsKnown(id)
	return ScanLeftText(id, ITEM_SPELL_KNOWN)
end

ns.knowns = setmetatable({}, {
	__index = function(t, i)
		local id = ns.ids[i]
		if not id then return end
		if HasHeirloom(id) or IsKnown(id) then
			t[i] = true
			return true
		end
	end
})


-- "Requires Previous Rank"
local function NeedsRank(id)
	return ScanLeftText(id, TOOLTIP_SUPERCEDING_SPELL_NOT_KNOWN)
end

ns.unmet_requirements = setmetatable({}, {
	__index = function(t, i)
		local id = ns.ids[i]
		if not id then return end

		if NeedsRank(id) then
			t[i] = true
			return true
		end
	end
})

local function CanLearnAppearance(id)
	return ScanLeftText(id, TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN)
end

ns.can_learn_appearance = setmetatable({}, {
	__index = function(t, i)
		local id = ns.ids[i]
		if not id then return end
		if CanLearnAppearance(id) then
			t[i] = true
			return true
		end
	end
})

