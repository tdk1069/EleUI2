EleUI = EleUI or {}
function EleUI:saveSettings()
  settings = settings or {}
  local settingsPath = getMudletHomeDir().."/settings/"
  local saveTable = {}
  if not io.exists(settingsPath) then
    lfs.mkdir(settingsPath)
  end
  saveTable.bell = brax.bell
  saveTable.chatAllTab = brax.chatAllTab 
  saveTable.speedwalkDelay = brax.speedwalkDelay
  saveTable.chatOnlyAll = brax.chatOnlyAll
  return table.save(settingsPath.."EleUI.lua", saveTable)
end

function EleUI:loadSettings()
  local settingsPath = getMudletHomeDir().."/settings/"
  local loadTable = mytable or {}
  loadTable.bell = true 
  loadTable.chatAllTab = true 
  loadTable.speedwalkDelay = 0.5
  loadTable.chatOnlyAll = false
  loadTable.AutoMapColour = true

  if io.exists(settingsPath.."EleUI.lua") then
    table.load(settingsPath.."EleUI.lua", loadTable)
  end
  return loadTable
end
