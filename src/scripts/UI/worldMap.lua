function worldMap()
  local mapPath = getMudletHomeDir() .. "/EleUI2/imgs/worldmaps/"
  local realm = (gmcp.Room.Id):match("(%w*)")
  worldMapWindow = worldMapWindow or EleUI:createWindow({name = "World Map", width = "70%",height="90%",x="9%",y="6%"})
  if worldMapWindow.hidden == false then
    worldMapWindow:hide()
    return
  end
  if not table.contains({"aerdy", "drakenwood", "rosfarren", "valena"}, realm) then
    realm = ({"aerdy", "drakenwood", "rosfarren", "valena"})[math.random(1, 4)]
  end
  worldMapWindow:setTitle("<center>" .. properCase(realm), "#A4A100")
  worldMapImage =
    worldMapImage or
    Geyser.Label:new(
      {name = "WorldMapImage", color = "black", x = "2%", y = "8%", width = "96%", height = "87%"},
      worldMapWindow
    )
  worldMapImage:setStyleSheet(
    [[border-image:url("]] ..
    getMudletHomeDir() ..
    [[/EleUI2/imgs/worldmaps/]] ..
    realm ..
    [[.png");]]
  )
  worldMapWindow:show()
  worldMapWindow:raiseAll()
end
