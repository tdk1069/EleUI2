function uiRoutes(index)
  local path = ""
  local route = {}
  table.insert(route, {id = "aerdy.144.37211", name = "High Pass North Gate"})
  table.insert(route, {id = "aerdy.179.461053", name = "High Pass - Communual Stores"})
  table.insert(route, {id = "aerdy.177.145107", name = "Erindar Stagecoach Office"})
  table.insert(route, {id = "aerdy.25.28344", name = "South Entrance to Sterford"})
  table.insert(route, {id = "aerdy.36.34523", name = "Nenrephi Fortress"})
  table.insert(route, {id = "aerdy.127.31021", name = "Moratherin - East Gate"})
  table.insert(route, {id = "aerdy.127.33012", name = "Moratherin - SouthEast Gate"})
  table.insert(route, {id = "aerdy.127.37304", name = "Grazendale - East Gate"})
  table.insert(route, {id = "aerdy.127.327007", name = "Dark and Twisted Forest"})
  table.insert(route, {id = "aerdy.136.37577", name = "Myconids"})
  table.insert(route, {id = "aerdy.144.41005", name = "Aerdy Entrance"})
  table.insert(route, {id = "valena.108.34030", name = "Brenhaven East Gate"})
  table.insert(route, {id = "drakenwood.104.748829", name = "The First Bank of Mirror Town"})
  local menuIndex = tonumber(index)
  if menuIndex == nil then
    decho(
      "<128,0,128>\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n"
    )
    for i, v in pairs(route) do
      path = getPath(getRoomIDbyHash(gmcp.Room.Id), getRoomIDbyHash(v.id))
      print(i .. ") " .. v.name .. " [" .. #speedWalkDir .. " steps]")
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
        speedwalk(table.concat(speedWalkDir, ", "), false, 0.4)
      end
    end
  end
end