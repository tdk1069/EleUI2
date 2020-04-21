function roomItems()
if true then return end
  --display(gmcp.Room.Items)
  --print(item)
  local id, item = next(gmcp.Room.Items)
--print(id)
  if item == 9980 then
    print("Remove")
    return
  end
  if gmcp.Room.Items.All then
  brax.roomItems = {}
      brax.roomItems = table.update(brax.roomItems,gmcp.Room.Items.All)
    for i, v in pairs(gmcp.Room.Items.All) do
      local _, item = next(v)
      print(item.name)
    end
  end
end

registerAnonymousEventHandler("gmcp.Room.Items", "roomItems")