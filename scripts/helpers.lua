-------------------------------------------------
--         Put your Lua functions here.        --
--                                             --
-- Note that you can also use external scripts --
-------------------------------------------------
function aTimerEnd(spell)
  local timer = timer or ""
  if myCooldowns[spell] then 
    myCooldowns[spell] = nil
  end 
local tCooldowns = {}
  local tName = {}
  local pos = 0
  local timeLeft = 0
  for i,v in pairs(myCooldowns) do 
    timeLeft = demonnic.anitimer.timers["cd"..i].current
    table.insert(tCooldowns,timeLeft)
    tName[timeLeft]=i
  end
  table.sort(tCooldowns)
  for i,v in pairs(tCooldowns) do 
    demonnic.anitimer.timers["cd"..tName[v]].gauge:move(0,pos*25)
    pos = pos +1
  end
end

function toggleBox(uiElement)
  if uiElement.hidden == true then
    uiElement:show()
  else
    uiElement:hide()
  end
  do_Config()
end

function saveWindows()
  Adjustable.Container.saveAll()
  cecho("<cyan>»»<reset>Layout Saved<cyan>««<reset>\n")
end

function loadWindows()
  Adjustable.Container.loadAll()
  cecho("<cyan>»»<reset>Layout Restored<cyan>««<reset>\n")
end

function SecondsToClock(seconds)
  local seconds = tonumber(seconds)
  if seconds <= 0 then
    return "00:00";
  else
    hours = string.format("%02.f", math.floor(seconds/3600));
    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
    return mins..":"..secs
  end
end

function properCase(str)
  return string.gsub(" "..str, "%W%l", string.upper):sub(2)
end

function ui_Theme(theme)
  local adjLabelstyle
  adjLabelstyle = adjLabelstyle or [[
      background-color: rgba(0,0,0,100%);
      border: 4px double ]]..theme..[[;
      border-radius: 4px;]]
  adjLabelstyle = adjLabelstyle..[[ qproperty-alignment: 'AlignLeft | AlignTop';]]
  cont = cont or Geyser
  for  k,v in pairs(cont.windowList) do
    if v.type == "adjustablecontainer" then 
      v.adjLabel:setStyleSheet(adjLabelstyle)
    end
    Adjustable.Container.saveAll(v)
  end

end

function Geyser.Container:raiseAll(container)
  container = container or self
  for i=1,#container.windows do
    local v = container.windows[i]
    container.windowList[v]:raise()
    container.windowList[v]:raiseAll(container.windowList[v])
  end
end

function Geyser.Container:lowerAll(container)
  container = container or self
  for i=#container.windows,1,-1 do
    local v = container.windows[i]
    container.windowList[v]:lower()
    container.windowList[v]:lowerAll(container.windowList[v])
  end
end