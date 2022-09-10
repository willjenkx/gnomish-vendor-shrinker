
local myname, ns = ...


local ICONSIZE, PADDING = 17, 2
local icons, texts = {}, {}
local indexes, ids = {}, {}


local function OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetMerchantCostItem(indexes[self], ids[self])
end


local function OnLeave()
	GameTooltip:Hide()
	ResetCursor()
end


function GetQtyOwned(item)
	local id = ns.ids[item]
	if id then
		return GetItemCount(id, true)
	end

	local currency = C_CurrencyInfo.GetCurrencyInfoFromLink(item)

	return currency.quantity
end


local function GetTextColor(price, link)
	if link and (GetQtyOwned(link) < price) then return "|cffff9999" end
	return ""
end


local function SetValue(self, i, j)
	indexes[self], ids[self] = i, j

	local texture, price, link, name = GetMerchantItemCostItem(i, j)
	icons[self]:SetTexture(texture)
	texts[self]:SetText(GetTextColor(price, (link or name)).. price)

	self:Show()
end


function ns.NewAltCurrencyItemFrame(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetSize(ICONSIZE, ICONSIZE)

	local text = frame:CreateFontString(nil, nil, "NumberFontNormalSmall")
	text:SetPoint("LEFT")
	texts[frame] = text

	local icon = frame:CreateTexture()
	icon:SetSize(ICONSIZE, ICONSIZE)
	icon:SetPoint("LEFT", text, "RIGHT", PADDING, 0)
	icons[frame] = icon

	frame.SetValue = SetValue
	frame.SizeToFit = ns.SizeToFit

	frame:EnableMouse(true)
	frame:SetScript("OnEnter", OnEnter)
	frame:SetScript("OnLeave", OnLeave)

	return frame
end
