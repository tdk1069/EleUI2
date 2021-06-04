--
-- builds and maintains a table of items, inventory, bags, worn and wieleded.
-- ui locate <search substring> will let you look for and click to fetch from bag
-- but basically it's just a structure function ready for UI
--
function inventoryWindow()
  brax.invWindow = Adjustable.Container:new({adjLabelstyle=adjStyle, buttonstyle=btnStyle,x=500,y=10,name="invWidnow",titleText="",height="385px",width="285px"})
  brax.invWindow.adjLabel:setStyleSheet([[border-image: url(]]..getMudletHomeDir()..[[/EleUI2/imgs/UI_Inventory.png) ;]])
  brax.invWindow:setClickCallback("Adjustable.Container.onClick",brax.invWindow, brax.invWindow)
  brax.invWindow:setReleaseCallback("Adjustable.Container.onRelease",brax.invWindow, brax.invWindow.adjLabel)
  brax.invWindow:setMoveCallback("Adjustable.Container.onMove",brax.invWindow, brax.invWindow.adjLabel)
end

function showInventory()
  local btnStyle = [[QLabel{ border-radius: 7px; background-color: rgba(140,140,140,100%);}QLabel::hover{ background-color: rgba(160,160,160,50%);}]]
  local adjStyle = [[border: 6px solid transparent;border-image: url(]]..getMudletHomeDir()..[[/EleUI2/imgs/oga.png) round;]]
  invBoxContainer = invBoxContainer or Adjustable.Container:new({adjLabelstyle=adjStyle, buttonstyle=btnStyle,x=10,y=10,name="invBoxContainer",titleText="Inventory",height="200px"})
  invRow = {}
  for i=1,20,1 do 
      invRow[i] = invRow[i] or Geyser.Label:new({name = "invRow"..i, color = "black", x = 0, y = i*21, width = "100%", height = "20px"},invBoxContainer)
      invRow[i]:setStyleSheet([[border-image: url(]]..getMudletHomeDir()..[[/EleUI2/imgs/inv_row.png) ;]])
      invRow[i]:raise()
  end

  for i=1,20,1 do 
    local keyIndex = table.keys(brax.items.inventory)
    local iCol = brax.items.inventory[keyIndex[i]].colour or ""
  
    if type(brax.items.inventory[keyIndex[i]].worn) == "table" then
      itemState = " (Worn)"
    elseif type(brax.items.inventory[keyIndex[i]].wielded) == "table" then
      itemState = " (Wielded)"
    else
      itemState = ""
    end
    if brax.items.inventory[keyIndex[i]].type == "armour" then iCol = [[<span style="color:rgb(0,128,0);">]]
    elseif brax.items.inventory[keyIndex[i]].type == "weapon" then iCol = [[<p style="color:rgb(128,0,0);">]]
    else iCol = [[<p style="color:rgb(128,128,0);">]] end
    invRow[i]:decho(""..iCol.."&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"..brax.items.inventory[keyIndex[i]].name..itemState.."</span>")
  end

end

  function updateInvWindow()
  if true then return end
  local btnStyle = [[QLabel{ border-radius: 7px; background-color: rgba(140,140,140,100%);}QLabel::hover{ background-color: rgba(160,160,160,50%);}]]
  local adjStyle = [[border: 6px solid transparent;border-image: url(]]..getMudletHomeDir()..[[/EleUI2/imgs/oga.png) round;]]
  invBoxContainer = invBoxContainer or Adjustable.Container:new({adjLabelstyle=adjStyle, buttonstyle=btnStyle,x=10,y=10,name="invBoxContainer",titleText="Inventory"})
  local _stylesheet = [[
        QLabel{
				background-color: #4d0000;
				border-style: outset;
        border-width: 2px;
        border-color: "#996600";
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        margin-right: 1px;
        margin-left: 1px;
        qproperty-alignment: 'AlignCenter | AlignCenter';
				}				
				QLabel::hover{
				background-color: #b30000;
				border-style: outset;
        border-width: 2px;
        border-color: "#996600";
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        margin-right: 1px;
        margin-left: 1px;
        qproperty-alignment: 'AlignCenter | AlignCenter';
				}				
				]]
  local _istylesheet = [[
        QLabel{
				background-color: #b30000;
				border-style: outset;
        border-width: 2px;
        border-color: "#996600";
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        margin-right: 1px;
        margin-left: 1px;
        qproperty-alignment: 'AlignCenter | AlignCenter';
				}				
				QLabel::hover{
				background-color: #b30000;
				border-style: outset;
        border-width: 2px;
        border-color: "#996600";
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        margin-right: 1px;
        margin-left: 1px;
        qproperty-alignment: 'AlignCenter | AlignCenter';
				]]

      invBox = EMCO:new({ x = "0", y = "0", width = "100%", height = "100%", gap = 2, allTab = false,consoles = {"Inventory"},activeTabCSS = _stylesheet, inactiveTabCSS = _istylesheet},invBoxContainer)
      invBox.tabBoxLabel:setStyleSheet([[background-color: rgba(0,0,0,0);]])
      invBox:disableScrollbars()
      invBox:disableBlink()
      invBox:setFontSize(13)
      invBox:clear("Inventory")

      for bagType,ids in pairs(brax.bagList) do
        if type(ids) == "table" then
          for id,bagID in pairs(ids) do
--            invBox:addTab(bagType.." "..id)
            for baggedID,baggedItem in pairs(brax.bags[bagID]) do
--            invBox:cecho(bagType.." "..id,baggedItem.name.."\n")
            end
          end
        end
      end
      
      for id,item in pairs(brax.items) do
        if item.wielded then
          invBox:cechoPopup("Inventory","<red>"..item.name.." (Wielded)<reset>\n",{[[send "look ]]..item.name..[["]],[[send "weigh "]]..item.name..[["]]},{"look","weigh"},true)
        end
      end
      for id,item in pairs(brax.items) do
        if item.worn then
          invBox:cechoPopup("Inventory","<green>"..item.name.." (Worn)<reset>\n",{[[send "look ]]..item.name..[["]],[[send "weigh "]]..item.name..[["]]},{[[look]]..item.name,[[weigh ]]..item.name},true)
        end
      end

      for bagType,ids in pairs(brax.bagList) do
        if type(ids) == "table" then
          for id,bagID in pairs(ids) do
          invBox:cechoPopup("Inventory","<cyan>"..bagType.." "..id.."<reset>\n",{[[send "look ]]..bagType.." "..id..[["]],[[send "weigh "]]..bagType.." "..id..[["]]},{[[look]]..bagType.." "..id,[[weigh ]]..bagType.." "..id},true)
--            invBox:addTab(bagType.." "..id)
          end
        end
      end

      for id,item in pairs(brax.items) do
        if item.worn == nil and item.wielded == nil and item.type ~= "Bag" then
          invBox:cechoPopup("Inventory","<yellow>"..item.name.."<reset>\n",{[[send "look ]]..item.name..[["]],[[send "weigh "]]..item.name..[["]]},{[[look]]..item.name,[[weigh ]]..item.name},true)
        end
      end



      for id,item in pairs(brax.items) do
        if item.type == "Bag" then
        end
      end
      invBoxContainer:show()
end

function charItems()
  brax = brax or {}
  brax.items = brax.items or {}
  brax.items.inventory = brax.items.inventory or {} -- Basic Inventory
  brax.items.bagList = brax.items.bagList or {} -- List of bags to get bag number by type
  brax.items.baggedItems = brax.items.baggedItems or {} -- Items inside bags
  for id,item in pairs(gmcp.Char.Items) do
    if isNumber(item) == 0 then -- Drop Item
      if brax.items.inventory[id] then
        if table.contains(brax.items.bagList[brax.items.inventory[id].name],id) then
          table.remove(brax.items.bagList[brax.items.inventory[id].name],table.index_of(brax.items.bagList[brax.items.inventory[id].name],id))
        end
        brax.items.inventory[id] = nil
      end
      if brax.items.baggedItems[id] then
        brax.items.baggedItems[id] = nil
      end
    elseif item.type == "bag" then -- new bag
      brax.items.inventory[id] = item
      if table.contains(brax.items.bagList,id) == false then -- Add bag to list if needed
        brax.items.bagList[item.name] = brax.items.bagList[item.name] or {} -- Create table if needed
        table.insert(brax.items.bagList[item.name],1,id) -- Add to top of list, shuffle down rest
      end
    elseif id == "Bag" then -- Deal with items inside bags
      local bagID, bagItem = next(item)
      local newID,newItem = next(bagItem)
      brax.items.baggedItems[bagID] = brax.items.baggedItems[bagID] or {}
      if isNumber(newItem) == 0 then -- Remove Item from Bag
        if brax.items.baggedItems[bagID][newID] then
          brax.items.baggedItems[bagID][newID] = nil
        end
      else -- add Item to Bag
        if table.contains(brax.items.baggedItems[bagID][newID],newItem) == false then
          brax.items.baggedItems[bagID][newID] = newItem
        end
      end
    else -- new normal items in inventory
--cecho("gmcp.Char.Items: "..id.." "..item.name.."\n")
      if table.contains(brax.items.inventory[id],item) == false then
        brax.items.inventory[id] = item
      end
    end -- end drop
  end
end

function buildBagList()
if true then return end
  local bagID, _ = next(gmcp.Char.Items.Bag)
  if not table.contains(brax.bagList, bagID) then
    brax.bagList[brax.items[bagID].name] = brax.bagList[brax.items[bagID].name] or {}
    table.insert(brax.bagList[brax.items[bagID].name], 1, bagID)
    brax.items[bagID].type = "Bag"
    brax.bags[bagID] = brax.bags[bagID] or {}
  end
  for id, bagItem in pairs(gmcp.Char.Items.Bag) do
    brax.bags[id] = brax.bags[id] or {}
    if isNumber(bagItem[next(bagItem)]) == 0 then
      local bagItemID, _ = next(bagItem)
      brax.bags[id][tonumber(bagItemID)] = nil
    else
      table.insert(brax.bags[id], next(bagItem), bagItem[next(bagItem)])
    end
  end
end

function addWornFlag()
  for id, worn in pairs(gmcp.Char.Worn) do
    if #worn == 0 then
      brax.items.inventory[id].worn = nil
    else
      brax.items.inventory[id].worn = worn
    end
  end
end

function addWieldedFlag()
  for id, wielded in pairs(gmcp.Char.Wielded) do
    if #wielded == 0 then
      brax.items.inventory[id].wielded = nil
    else
      brax.items.inventory[id].wielded = wielded
    end
  end
end

function itemTree(searchString)
  searchString = searchString or ""
  for id, item in pairs(brax.items) do
    local wornState = ""
    local bagNumber = ""
    if type(item.worn) == "table" then
      wornState = " (Worn)"
    elseif type(item.wielded) == "table" then
      wornState = " (Wielded)"
    elseif table.contains(brax.bagList,id) then
--      bagNumber = table.index_of(brax.bagList,id)
    end
    if item.name:lower():find(searchString:lower()) then
      if isNumber(item.subtype) == 0 then item.subtype = "" end
            if item.type == "armour" then item.colour = "<0,128,0>"
        elseif item.type == "weapon" then item.colour = "<128,0,0>"
        else item.colour = "<128,128,0>" end
      decho("["..id.."] "..item.colour..item.name ..wornState.."<192,192,192> "..bagNumber.." "..item.subtype.."\n")
      if table.contains(brax.bagList[brax.items[id].name],id) then
        for itemid, item in pairs(brax.bags[id]) do
        if isNumber(item.subtype) == 0 then item.subtype = "" end
            if item.type == "armour" then item.colour = "<0,128,0>"
        elseif item.type == "weapon" then item.colour = "<128,0,0>"
        else item.colour = "<128,128,0>" end
        decho("["..itemid.."] +--"..item.colour..item.name.."<192,192,192> in "..brax.items[id].name.." "..table.index_of(brax.bagList[brax.items[id].name],id).." "..item.subtype.."\n")
        end
      end
    end
  end
end


function locate(searchString)
  searchString = searchString or ""
  brax = brax or {}
  brax.items = brax.items or {}
  brax.items.inventory = brax.items.inventory or {}
  brax.items.baggedItems = brax.items.baggedItems or {}
  local rarity = {}
  rarity[0] = ""
  rarity[1] = "<0,128,0>Uncommon<192,192,192>"
  rarity[2] = "<0,153,255>Rare<192,192,192>"
  rarity[3] = "<255,102,0>Epic<192,192,192>"
  
  if gmcp.Char.Vitals.Capacity == nil then gmcp.Char.Vitals.Capacity = 0 end
  echo("["..string.rep("#",(gmcp.Char.Vitals.Capacity*100/2))..string.rep("-",50-(gmcp.Char.Vitals.Capacity*100/2)).."]\n")
  for id, item in pairs(brax.items.inventory) do
    local wornState = ""
    local bagNumber = ""
    if type(item.worn) == "table" then
      wornState = " (Worn)"
    elseif type(item.wielded) == "table" then
      wornState = " (Wielded)"
    elseif table.contains(brax.bagList,id) then
--      bagNumber = table.index_of(brax.bagList,id)
    end
    if item.name:lower():find(searchString:lower()) then
      if isNumber(item.subtype) == 0 then item.subtype = "" end
            if item.type == "armour" then item.colour = "<0,128,0>"
        elseif item.type == "weapon" then item.colour = "<128,0,0>"
        else item.colour = "<128,128,0>" end
      decho(item.colour..item.name ..wornState.."<192,192,192> "..bagNumber.." "..rarity[item.rarity].." ".. item.subtype .." ("..item.level..")\n")
    end
  end
  for bagID, bag in pairs(brax.items.baggedItems) do
    for id, item in pairs(bag) do
      if item.name:lower():find(searchString:lower()) and brax.items.inventory[bagID] ~= nil then
        if isNumber(item.subtype) == 0 then item.subtype = "" end
            if item.type == "armour" then item.colour = "<0,128,0>"
        elseif item.type == "weapon" then item.colour = "<128,0,0>"
        else item.colour = "<128,128,0>" end
        dechoLink("[<0,128,128>"..brax.items.inventory[bagID].name.." "..table.index_of(brax.items.bagList[brax.items.inventory[bagID].name],bagID).."<192,192,192>] "..item.colour..item.name.."<192,192,192>\n",
          [[send("get ]]..item.name:gsub(" ?%(.-%)","")..[[ from ]]..brax.items.inventory[bagID].name.." "..table.index_of(brax.items.bagList[brax.items.inventory[bagID].name],bagID)..[[")]], "Get Item", true)
      end
    end
  end
end

function invReset()
if 1 then return end
  brax.items = {}
  brax.items.inventory = {}
  brax.items.bagList = {}
  brax.items.baggedItems = {}
end

brax = brax or {}
brax.wieldedEvent = registerAnonymousEventHandler("gmcp.Char.Wielded", "addWieldedFlag")
brax.wornEvent = registerAnonymousEventHandler("gmcp.Char.Worn", "addWornFlag")
brax.itemsEvent = registerAnonymousEventHandler("gmcp.Char.Items", "charItems")
--registerAnonymousEventHandler("gmcp.Char.Items.Bag", "buildBagList")
brax.charResetEvent = registerAnonymousEventHandler("gmcp.Char.Reset","eleProfileReset")
