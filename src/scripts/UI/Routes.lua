function uiRoutes(index)
  local path = ""
  local route = {}
  if io.exists(getMudletHomeDir().."/settings/Routes.lua") then
    table.load(getMudletHomeDir().."/settings/Routes.lua",route)
  end
  local menuIndex = tonumber(index)
  local thisRoomName
  if string.sub(index,1,3) == "add" then
    if #index > 3 then
      thisRoomName = string.sub(index,5)
    else
      thisRoomName = getRoomName(eleMap.currentRoom)
    end
    table.insert(route, {id = getRoomHashByID(eleMap.currentRoom), name = thisRoomName})
    table.save(getMudletHomeDir().."/settings/Routes.lua",route)
  elseif string.sub(index,1,3) == "del" then
    local thisIndex = string.sub(index,5)
    if thisIndex ~= "" then
      if table.remove(route,thisIndex) then
        table.save(getMudletHomeDir().."/settings/Routes.lua",route)
        echo(thisIndex.." deleted from routes")
      else
        echo("No such ID")
      end
    else
      echo("No Route ID given to delete")
    end
  elseif menuIndex == nil then
    decho(
      "<128,0,128>\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n"
    )
    for i, v in spairs(route) do
      print(i .. ") " .. v.name)
    end
    decho(
      "<128,0,128>\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n"
    )
  else
    if route[tonumber(index)].id then
      if
        getPath(getRoomIDbyHash(gmcp.Room.Id), getRoomIDbyHash(route[tonumber(index)].id))
      then
        brax.STOP = false
        if #speedWalkDir == 0 then return end
        speedwalktimer(speedWalkDir, brax.speedwalkDelay , false)
      else
        decho("Unable to find a path there!\n")
      end
    end
  end
end