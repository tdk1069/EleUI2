function mapRecolour(old,new)
  local allRooms = getRooms()
  local changedRooms = 0
  local old = tonumber(old)
  local new = tonumber(new)
  echo("Changing "..old.." to "..new.."\n")
  echo("Total rooms "..#allRooms.."\n")
  for id, v in pairs(allRooms) do
    if (getRoomEnv(id) == old) then
      setRoomEnv(id,new)
      changedRooms = changedRooms + 1
    end
  end
  updateMap()
  echo("Changed "..changedRooms.." rooms\n")
end

function mapCurrentRoomInfo()
  echo("Current Room :"..getPlayerRoom().."\n")
  echo("Room Name: "..(getRoomName(getPlayerRoom()) or "<none>").."\n")
  echo("Current Colour code: "..getRoomEnv(getPlayerRoom()).."\n")
end

function mapperColours()
  local colourList = getCustomEnvColorTable()
  local eol = 0
  local eolReturn = math.floor(math.sqrt(table.size(getCustomEnvColorTable())))
  for id,rgb in spairs(colourList) do
    local r,g,b = unpack(rgb)
    decho("<"..r..","..g..","..b..">"..id.."  ")
    eol = eol +1
    if eol > eolReturn then
      echo("\n")
      eol = 0
    end
  end
  echo("\n")
end

if exists("map recolour","alias") == 0 then
  permAlias("map recolour","UI Aliases","^map recolour (\\d+) (\\d+)$",[[mapRecolour(matches[2],matches[3])]])
end
if exists("map roominfo","alias") == 0 then
  permAlias("map roominfo","UI Aliases","^map roominfo$",[[mapCurrentRoomInfo()]])
end
if exists("map colourlist","alias") == 0 then
  permAlias("map colourlist","UI Aliases","^map colourlist$",[[mapperColours()]])
end


