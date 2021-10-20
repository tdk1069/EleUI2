-------------------------------------------------
--         Put your Lua functions here.        --
--                                             --
-- Note that you can also use external Scripts --
-------------------------------------------------
--
-- v1.8
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
    if getRoomExits(realID)[dir] ~= getRoomIDbyHash(exitHash) then
  		if is_standard_exit(dir) then
        setExit(realID,getRoomIDbyHash(exitHash),dir)
  			setExit(getRoomIDbyHash(exitHash),realID,reversemap[dir])
  		else
  			addSpecialExit(realID,getRoomIDbyHash(exitHash),dir)
  		end
    else
--      print("Exit linked already")
    end
	end
	updateMap()
end

function safeAdd(var,value)
  local value = value or 0
  local var = var or 0
  var = var + value
  return var
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
  x = x or 0
  y = y or 0
  z = z or 0
	if dir == "north" then
		y = safeAdd(y,2)
	elseif dir == "northeast" then
		x = safeAdd(x,2)
		y = safeAdd(y,2)
	elseif dir == "east" then
		x = safeAdd(x,2)
	elseif dir == "southeast" then
		x = safeAdd(x,2)
		y = safeAdd(y,-2)
	elseif dir == "south" then
		y = safeAdd(y,-2)
	elseif dir == "southwest" then
		x = safeAdd(x,-2)
		y = safeAdd(y,-2)
	elseif dir == "west" then
		x = safeAdd(x,-2)
	elseif dir == "northwest" then
		x = safeAdd(x,-2)
		y = safeAdd(y,2)
	elseif dir == "up" then
		z = safeAdd(z,2)
	elseif dir == "down" then
		z = safeAdd(z,-2)
	else
		x = safeAdd(x,1)
		y = safeAdd(y,1)
	end
	return x,y,z
end

function find_room()
--display(gmcp.Room)
  gmcp.Room = gmcp.Room or {}
  if gmcp.Room.Id == nil then gmcp.Room.Id = "drakenwood.4.580481" end
	if eleMap.currentRoom ~= -1 then eleMap.lastRoom = eleMap.currentRoom end
	if roomExists(getRoomIDbyHash(gmcp.Room.Id)) then
  eleMap.lastRoom = eleMap.currentRoom
    eleMap.currentRoom = getRoomIDbyHash(gmcp.Room.Id)
		centerview(eleMap.currentRoom)
	else 
--		cecho("<cyan>[  MAP  ]<reset> No Room found for <red>"..gmcp.Room.Id.."<reset>\n")
	end
end

function add_exits()
  if mapBoxContainer then 
    local mTitle = properCase((gmcp.Room.Id):match("%w*"))
    if gmcp.Room.Terrain ~= "0"  then mTitle = mTitle.." - "..properCase(gmcp.Room.Terrain) end
    mapBoxContainer:setTitle(mTitle,"#A4A100") 
  end
  if brax.map.mode == "read" then return end
	local newID = createRoomID()
	if roomExists(getRoomIDbyHash(gmcp.Room.Id)) then
--		add_room_neighbours(eleMap.currentRoom,gmcp.Room.Exits)
    add_room_neighbours(getRoomIDbyHash(gmcp.Room.Id),gmcp.Room.Exits)
	else
		find_link(gmcp.Room.Exits)
	end
  brax.exits = gmcp.Room.Exits
  gmcp.Room.Exits = {}
end

function find_link(exits)
  for dir, id in pairs(exits) do
		local roomID = getRoomIDbyHash(id)
    if roomExists(roomID) then
			local x,y,z = getRoomCoordinates(roomID)
			local newx,newy,newz = calculate_Coordinates(x,y,z,exitmap[reversemap[dir]])
			add_room(gmcp.Room.Id,newx,newy,newz,getRoomArea(roomID))
      if is_standard_exit(gmcp.Char.Moved) then
        setExit(eleMap.lastRoom,eleMap.currentRoom,gmcp.Char.Moved)
        setExit(eleMap.currentRoom,eleMap.lastRoom,exitmap[reversemap[gmcp.Char.Moved]])
      else
        addSpecialExit(eleMap.lastRoom,eleMap.currentRoom,gmcp.Char.Moved)
      end
		end
	end
	if not roomExists(getRoomIDbyHash(gmcp.Room.Id)) then
			local x,y,z = getRoomCoordinates(eleMap.lastRoom)
      local moved = gmcp.Char.Moved
			local newx,newy,newz = calculate_Coordinates(x,y,z,moved)
			cecho("<cyan>[  MAP  ]<reset> No GMCP data, Guessing you went  [<yellow>"..(gmcp.Char.Moved or "nil").."<reset>]\n")
      local newArea = (gmcp.Room.Id):match("(%w*)")
      newArea = getArea(newArea)
			add_room(gmcp.Room.Id,newx,newy,newz,newArea)
      if is_standard_exit(moved) then
      	setExit(getRoomIDbyHash(gmcp.Room.Id),eleMap.lastRoom,reversemap[moved])
      	setExit(eleMap.lastRoom,getRoomIDbyHash(gmcp.Room.Id),moved)
      else
--	addSpecialExit(realID,getRoomIDbyHash(exitHash),reversemap[moved])
end
	end
end

function getArea(searchArea)
  local zoneID = ""
  for zone,id in pairs(getAreaTable()) do
    if string.lower(zone) == string.lower(searchArea) then
      zoneID = id
    end
  end
  if zoneID == "" then
    zoneID = addAreaName(properCase(searchArea))
  end
  return(zoneID)
end

function onCharMove(moveDetails)
  gmcp.Char.Moved = speedwalkDIR or brax.mapper.convertDir[command]
  speedwalkDIR = nil
  local moved = gmcp.Char.Moved
  brax.moved = gmcp.Char.Moved
  brax.exits = gmcp.Room.Exits
  if getRoomUserData(eleMap.currentRoom or 0,"roomCMD") ~= "" then
    send(getRoomUserData(eleMap.currentRoom,"roomCMD"))
  end 
  if brax.map.mode == "read" then 
    raiseEvent("charMoved")
    brax.exits = gmcp.Room.Exits
    gmcp.Room.Exits = {}
    return 
  end -- If read mode thats it!
  if brax.AutoMapColour then
    setRoomEnv(getRoomIDbyHash(gmcp.Room.Id),brax.mapper.terrain[gmcp.Room.Terrain] or -1)
    if gmcp.Room.Path then
      setRoomEnv(getRoomIDbyHash(gmcp.Room.Id),brax.mapper.terrain["path"])
      setRoomUserData(getRoomIDbyHash(gmcp.Room.Id),"Path",gmcp.Room.Path)
      gmcp.Room.Path = nil
    end
  end
  setRoomUserData(getRoomIDbyHash(gmcp.Room.Id),"Terrain",gmcp.Room.Terrain)
 	if roomExists(getRoomIDbyHash(gmcp.Room.Id)) == false then
		find_link(gmcp.Room.Exits)
  else
    if (is_standard_exit(moved) and brax.map.mode ~= "read") then
    	setExit(getRoomIDbyHash(gmcp.Room.Id),eleMap.lastRoom,reversemap[moved])
    	setExit(eleMap.lastRoom,getRoomIDbyHash(gmcp.Room.Id),moved)
    end
  end
  add_exits()
  brax.moved = gmcp.Char.Moved
  gmcp.Char.Moved = -1
  gmcp.Room.Exits = {}
  --find_room()
  raiseEvent("charMoved")
end

function add_room(hashID,x,y,z,area)
  if getRoomIDbyHash(hashID) > -1 then return end
	local newID = createRoomID()
  local thisHash = hashID
  if thisHash == -1 then thisHash = gmcp.Room.Id end
	if hashId ~= -1 then
  	addRoom(newID)
    setRoomWeight(newID,10)
  	setRoomCoordinates(newID,x,y,z)
  	setRoomArea(newID,area)
  	setRoomIDbyHash(newID,thisHash)
    if brax.AutoMapColour then
      setRoomEnv(newID,brax.mapper.terrain[gmcp.Room.Terrain] or -1)
    end
    setRoomUserData(newID,"Terrain",gmcp.Room.Terrain)
  	centerview(newID)
  	eleMap.lastRoom = eleMap.currentRoom
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
    brax = brax or {}
    brax.map = brax.map or {}
    brax.map.mode = "full"
  	setAreaName(1,"Drakenwood")
  	setAreaName(2,"Valena")
  	setAreaName(3,"Rosfarren")
  	setAreaName(4,"Aerdy")
    local newArea = (gmcp.Room.Id):match("(%w*)")
  	cecho("<cyan>[  MAP  ]<reset> NEW MAP STARTED\n")
  	cecho("<cyan>[  MAP  ]<reset> Adding first room "..gmcp.Room.Id.." Assuming your in "..newArea..", Manually move to new zone if not!\n")
    newArea = getArea(newArea)
		local newID = createRoomID()
  	addRoom(newID)
    setRoomWeight(newID,10)
  	setRoomCoordinates(newID,0,0,0)
  	setRoomArea(newID,newArea)
		setRoomIDbyHash(newID,gmcp.Room.Id)
  	centerview(newID)
    brax.exits = brax.exits or gmcp.Room.Exits
    add_room_neighbours(newID,brax.exits)
    eleMap.currentRoom = getRoomIDbyHash(gmcp.Room.Id)
  	updateMap()
  end
end

function doSpeedWalk()
    brax.STOP = false
    if #speedWalkDir == 0 then return end
--    decho("Starting speedwalking "..#speedWalkDir.." rooms. use <255,0,0>ui stop<reset> to stop\n")
    speedwalktimer(speedWalkDir, brax.speedwalkDelay, false)
    
end

function onSymbol(...)
	local style = arg[2]
	local rooms = arg[3]
	if style == "Post Office" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"📪")
	  end 
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
			setRoomChar(arg[i],"⚔️")
	  end
	elseif style == "Gem" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"💎")
	  end
	elseif style == "Food" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"🍖")
	  end
	elseif style == "Clothes" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"👚")
	  end
	elseif style == "Bottle" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"🏺")
	  end
	elseif style == "Skull" then
		for i = 3,arg['n'] do
			setRoomChar(arg[i],"💀")
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
  addMapEvent("Clothes", "onSymbol","Add Symbol")
  addMapEvent("Food", "onSymbol","Add Symbol")
  addMapEvent("Bottle", "onSymbol","Add Symbol")
  addMapEvent("Skull", "onSymbol","Add Symbol")
  addMapEvent("Clear", "onSymbol","Add Symbol")
	find_room()
	if not mapAlias1 then tempAlias("^map count$",[[count_rooms()]]) end
	if not mapAlias2 then tempAlias("^map colours$",[[get_Colours()]]) end
	if not mapAlias3 then tempAlias("^map purge$",[[purge_map()]]) end
end

brax.mapper = brax.mapper or {}
setCustomEnvColor(273,40,40,40,255) -- Paths -Custom colour
-- These colours below can be altered in Prefs > Mapper colours
brax.mapper.terrain = brax.loadSettings.terrain or {
  forest = 258,
  plains = 259,
  hills = 263,
  mountains = 272,
  town = -1,
  coast = 270,
  sea = 260,
  swamp = 262,
  jungle = 258,
  underwater = 260,
  desert = 267,
  river = 260,
  tundra = 271,
  snowplains = 271,
  treetops = 258,
  river = 260,
  lake = 260,
  path = 273
}

brax.mapper.convertDir = {
  n = "north",
  ne = "northeast",
  e = "east",
  se = "southeast",
  s = "south",
  sw = "southwest",
  w = "west",
  nw = "northwest",
  u = "up",
  d = "down"
}
  
  
function doRoomName()
  if brax.map.mode ~= "read" then 
    setRoomName(eleMap.currentRoom,gmcp.Room.Name)
  end
end

brax = brax or {}
brax.openMapEvent = registerAnonymousEventHandler("mapOpenEvent", "mapWindowOpen")
brax.mapSymbolEvent = registerAnonymousEventHandler("onSymbol", "onSymbol")
brax.roomIdEvent = registerAnonymousEventHandler("gmcp.Room.Id", "find_room")
--registerAnonymousEventHandler("gmcp.Room.Exits", "add_exits")
--registerAnonymousEventHandler("gmcp.Char.Moved", "onCharMove")
brax.roomExitsEvent = registerAnonymousEventHandler("gmcp.Room.Exits", "onCharMove")

brax.roomNameEvent = registerAnonymousEventHandler("gmcp.Room.Name","doRoomName")
