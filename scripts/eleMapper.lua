-------------------------------------------------
--         Put your Lua functions here.        --
--                                             --
-- Note that you can also use external Scripts --
-------------------------------------------------
--
-- v1.55
--
-- eleMap.currentRoom = Mudlet room ID
--


function count_rooms()
	local count = 0
	for dir, id in pairs(getRooms()) do
		count = count +1
	end
	cecho("<cyan>[  MAP  ]<reset> Total Rooms: "..count.."\n")
end

function get_Colours()
	for c, id in pairs(getCustomEnvColorTable()) do
		setFgColor(id[1],id[2],id[3])
		print("setRoomEnv(ID,"..c..")")
	end
end


function add_room_neighbours(realID,exits)
if brax.map.mode == "read" then return end
if brax.map.mode == "simple" then
  for dir, exitHash in pairs(exits) do
    if not getRoomExits(realID)[dir] then
      setExitStub(realID,dir,true)
    end
  end
 return 
end
	local x,y,z = getRoomCoordinates(realID)
  for dir, exitHash in pairs(exits) do
		if not roomExists(getRoomIDbyHash(exitHash)) then
			local newx,newy,newz = calculate_Coordinates(x,y,z,dir)
			local newID = createRoomID()
      addRoom(newID)
      setRoomWeight(newID,10)
  		setRoomCoordinates(newID,newx,newy,newz)
  		setRoomArea(newID,getRoomArea(realID))
			setRoomIDbyHash(newID,exitHash)
		end
		if not getRoomExits(realID)[dir] then
  		if is_standard_exit(dir) then
  			setExit(realID,getRoomIDbyHash(exitHash),dir)
  			setExit(getRoomIDbyHash(exitHash),realID,reversemap[dir])
  		else
  			addSpecialExit(realID,getRoomIDbyHash(exitHash),dir)
  		end
    end
	end
	updateMap()
end

function is_standard_exit(dir)
	if dir == "north" then
		return true
	elseif dir == "northeast" then
		return true
	elseif dir == "east" then
		return true
	elseif dir == "southeast" then
		return true
	elseif dir == "south" then
		return true
	elseif dir == "southwest" then
		return true
	elseif dir == "west" then
		return true
	elseif dir == "northwest" then
		return true
	elseif dir == "up" then
		return true
	elseif dir == "down" then
		return true
	elseif dir == "in" then
		return true
	elseif dir == "out" then
		return true
	else
		return false
	end
end

function calculate_Coordinates(x,y,z,dir)
	if dir == "north" then
		y = y + 2
	elseif dir == "northeast" then
		x = x + 2
		y = y + 2
	elseif dir == "east" then
		x = x + 2
	elseif dir == "southeast" then
		x = x + 2
		y = y - 2
	elseif dir == "south" then
		y = y - 2
	elseif dir == "southwest" then
		x = x - 2
		y = y - 2
	elseif dir == "west" then
		x = x - 2
	elseif dir == "northwest" then
		x = x - 2
		y = y + 2
	elseif dir == "up" then
		z = z + 2
	elseif dir == "down" then
		z = z - 2
	else
		x = x + 1
		y = y + 1
	end
	return x,y,z
end

function find_room()
  gmcp.Room = gmcp.Room or {}
  if gmcp.Room.Id == nil then gmcp.Room.Id = "drakenwood.4.580481" end
	eleMap.lastRoom = eleMap.currentRoom
  eleMap.currentRoom = getRoomIDbyHash(gmcp.Room.Id)
	if roomExists(eleMap.currentRoom) then
		centerview(eleMap.currentRoom)
	else 
--		cecho("<cyan>[  MAP  ]<reset> No Room found for <red>"..gmcp.Room.Id.."<reset>\n")
	end
end

function add_exits()
  if mapBoxContainer then 
    local mTitle = properCase((gmcp.Room.Id):match("%w*"))
    if gmcp.Room.Terrain ~= 0  then mTitle = mTitle.." - "..properCase(gmcp.Room.Terrain) end
    mapBoxContainer:setTitle(mTitle) 
  end
  if brax.map.mode == "read" then return end
	local startMatrix = getStopWatchTime(mapMatrix)	
	local newID = createRoomID()
	if roomExists(eleMap.currentRoom) then
		add_room_neighbours(eleMap.currentRoom,gmcp.Room.Exits)
	else
		find_link(gmcp.Room.Exits)
	end
end

function find_link(exits)
  for dir, id in pairs(exits) do
		local roomID = getRoomIDbyHash(id)
		if roomExists(roomID) then
			local x,y,z = getRoomCoordinates(roomID)
			local newx,newy,newz = calculate_Coordinates(x,y,z,exitmap[reversemap[dir]])
			add_room(gmcp.Room.Id,newx,newy,newz,getRoomArea(roomID))
--      setExit(eleMap.lastRoom,eleMap.currentRoom,gmcp.Char.Moved)
--			break 
		end
	end
	if not roomExists(getRoomIDbyHash(gmcp.Room.Id)) then
			local x,y,z = getRoomCoordinates(eleMap.lastRoom)
      local moved = gmcp.Char.Moved
			local newx,newy,newz = calculate_Coordinates(x,y,z,moved)
      if moved == "north" then
        y = y -2
      elseif moved == "northeast" then
        y = y +2
        x = x +2
      elseif moved == "east" then
        x = x +2
      elseif moved == "southeast" then
        y = y -2
        x = x +2
      elseif moved == "south" then
        y = y -2
      elseif moved == "southwest" then
        x = x -2
        y = y -2
      elseif moved == "west" then
        x = x -2
      elseif moved == "northwest" then
        x = x -2
        y = y +2
      elseif moved == "up" then
        z = z + 2
      elseif moved == "down" then
        z = z - 2
      else
        x = x +1
        y = y +1
      end
			cecho("<cyan>[  MAP  ]<reset> I didn't know where to put this room! ["..gmcp.Room.Id.."] please move it manually (New Zone?)\n")
      local newArea = (gmcp.Room.Id):match("(%w*)")
      if newArea == "aerdy" then newArea = 4
      elseif newArea == "drakenwood" then newArea = 1
      elseif newArea == "valena" then newArea = 2
      elseif newArea == "rosfarren" then newArea = 3
      elseif newArea == "dunglenderry" then newArea = 5
      else newArea = getRoomArea(eleMap.lastRoom) end
			add_room(eleMap.currentRoom,newx,newy,newz,newArea)
      if is_standard_exit(moved) then
      	setExit(getRoomIDbyHash(gmcp.Room.Id),eleMap.lastRoom,reversemap[moved])
      	setExit(eleMap.lastRoom,getRoomIDbyHash(gmcp.Room.Id),moved)
      else
--	addSpecialExit(realID,getRoomIDbyHash(exitHash),reversemap[moved])
end
	end
end

function onCharMove(moveDetails)
  local moved = gmcp.Char.Moved
  if brax.map.mode == "read" then return end
	if roomExists(eleMap.currentRoom) == false then
  		find_link(gmcp.Room.Exits)
  else
    if (is_standard_exit(moved) and brax.map.mode ~= "read") then
    	setExit(getRoomIDbyHash(gmcp.Room.Id),eleMap.lastRoom,reversemap[moved])
    	setExit(eleMap.lastRoom,getRoomIDbyHash(gmcp.Room.Id),moved)
    end
  end
  brax.moved = gmcp.Char.Moved
  gmcp.Char.Moved = nil
end

function add_room(hashID,x,y,z,area)
	local newID = createRoomID()
  local thisHash = hashID
  if thisHash == -1 then thisHash = gmcp.Room.Id end
	if hashId ~= -1 then
  	addRoom(newID)
    setRoomWeight(newID,10)
  	setRoomCoordinates(newID,x,y,z)
  	setRoomArea(newID,area)
  	setRoomIDbyHash(newID,thisHash)
  	centerview(newID)
--  	eleMap.lastRoom = eleMap.currentRoom
  	eleMap.currentRoom = newID
  	add_room_neighbours(newID,gmcp.Room.Exits)
	end
end

function purge_map()
	for id, room in pairs(getRooms()) do
		deleteRoom(id)
		print("<cyan>[  MAP  ]<reset> Deleting => "..id.."\n")
	end	
end

reversemap = {
  n = 6,
  north = 6,
  ne = 8,
  northeast = 8,
  nw = 7,
  northwest = 7,
  e = 5,
  east = 5,
  w = 4,
  west = 4,
  s = 1,
  south = 1,
  se = 3,
  southeast = 3,
  sw = 2,
  southwest = 2,
  u = 10,
  up = 10,
  d = 9,
  down = 9,
  ["in"] = 12,
  out = 11}
exitmap = {
  n = 1,
  north = 1,
  ne = 2,
  northeast = 2,
  nw = 3,
  northwest = 3,
  e = 4,
  east = 4,
  w = 5,
  west = 5,
  s = 6,
  south = 6,
  se = 7,
  southeast = 7,
  sw = 8,
  southwest = 8,
  u = 9,
  up = 9,
  d = 10,
  down = 10,
  ["in"] = 11,
  out = 12,
  [1] = "north",
  [2] = "northeast",
  [3] = "northwest",
  [4] = "east",
  [5] = "west",
  [6] = "south",
  [7] = "southeast",
  [8] = "southwest",
  [9] = "up",
  [10] = "down",
  [11] = "in",
  [12] = "out",
}	

function mapper_Installed(_, name)
  if next(getRooms()) == nil then
    gmcp = gmcp or {}
    gmcp.Room = gmcp.Room or {}
    gmcp.Room.Id = gmcp.Room.Id or ""
    eleMap.currentRoom = getRoomIDbyHash(gmcp.Room.Id)
    brax = brax or {}
    brax.map = brax.map or {}
    brax.map.mode = "full"
  	setAreaName(1,"Drakenwood")
  	setAreaName(2,"Valena")
  	setAreaName(3,"Rosfarren")
  	setAreaName(4,"Aerdy")
		setAreaName(5,"Dun Glenderry")
    local newArea = (gmcp.Room.Id):match("(%w*)")
  	cecho("<cyan>[  MAP  ]<reset> NEW MAP STARTED\n")
  	cecho("<cyan>[  MAP  ]<reset> Adding first room "..gmcp.Room.Id.." Assuming your in "..newArea..", Manually move to new zone if not!\n")
    if newArea == "aerdy" then newArea = 4
    elseif newArea == "drakenwood" then newArea = 1
    elseif newArea == "valena" then newArea = 2
    elseif newArea == "rosfarren" then newArea = 3
    elseif newArea == "dunglenderry" then newArea = 5
    else newArea = 1 end
		local newID = createRoomID()
  	addRoom(newID)
    setRoomWeight(newID,10)
  	setRoomCoordinates(newID,0,0,0)
  	setRoomArea(newID,newArea)
		setRoomIDbyHash(newID,gmcp.Room.Id)
  	centerview(newID)
    add_room_neighbours(newID,gmcp.Room.Exits)
  	updateMap()
  end
end

function doSpeedWalk()
    brax.STOP = false
		speedwalk(table.concat(speedWalkDir, ", "),false,0.3)
end

function onSymbol(...)
	local style = arg[2]
	local rooms = arg[3]
	if style == "Post Office" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"✉")
	  end -- ✉🛒💰🐴📖🍺💎⚔
	elseif style == "Store" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"🛒")
	  end
	elseif style == "Bank" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"💰")
	  end
	elseif style == "Stable" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"🐴")
	  end
	elseif style == "Book" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"📖")
	  end
	elseif style == "Bar" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"🍺")
	  end
	elseif style == "Swords" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"💎")
	  end
	elseif style == "Swords" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"⚔")
	  end
	elseif style == "Clear" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"")
	  end
	end
end

function convert_map_to_hash()
end

function mapWindowOpen()
	mapMatrix = mapMatrix or createStopWatch()
  addMapMenu("Add Symbol")
  addMapEvent("Post Office", "onSymbol","Add Symbol")
  addMapEvent("Store", "onSymbol","Add Symbol")
  addMapEvent("Stable", "onSymbol","Add Symbol")
  addMapEvent("Bank", "onSymbol","Add Symbol")
  addMapEvent("Book", "onSymbol","Add Symbol")
  addMapEvent("Swords", "onSymbol","Add Symbol")
  addMapEvent("Bar", "onSymbol","Add Symbol")
  addMapEvent("Gem", "onSymbol","Add Symbol")
  addMapEvent("Clear", "onSymbol","Add Symbol")
	find_room()
	if not mapAlias1 then tempAlias("^map count$",[[count_rooms()]]) end
	if not mapAlias2 then tempAlias("^map colours$",[[get_Colours()]]) end
	if not mapAlias3 then tempAlias("^map purge$",[[purge_map()]]) end
end

registerAnonymousEventHandler("mapOpenEvent", "mapWindowOpen")
registerAnonymousEventHandler("onSymbol", "onSymbol")
registerAnonymousEventHandler("gmcp.Room.Id", "find_room")
registerAnonymousEventHandler("gmcp.Room.Exits", "add_exits")
registerAnonymousEventHandler("gmcp.Char.Moved", "onCharMove")
