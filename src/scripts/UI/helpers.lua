-------------------------------------------------
--         Put your Lua functions here.        --
--                                             --
-- Note that you can also use external scripts --
-------------------------------------------------
function aTimerEnd(spell)
  local timer = timer or ""
  if myCooldowns[spell] then 
    myCooldowns[spell] = nil
    demonnic.anitimer:destroy("cd"..spell)
  end 
  local tCooldowns = {}
  local tName = {}
  local pos = 0
  local timeLeft = 0
  for i,v in pairs(myCooldowns) do 
  if demonnic.anitimer.timers["cd"..i] then
    timeLeft = demonnic.anitimer.timers["cd"..i].current
    table.insert(tCooldowns,timeLeft)
    tName[timeLeft]=i
  end
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
  EleUI:saveSettings()
  cecho("<cyan>»»<reset>Layout Saved<cyan>««<reset>\n")
  saveProfile()
  saveMap()
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
  str = str or ""
  return string.gsub(" "..str, "%W%l", string.upper):sub(2)
end

function ui_Theme(theme)
  local adjLabelstyle
  adjLabelstyle = adjLabelstyle or [[
      background-color: rgba(0,0,0,100%);
      border: 4px double ]]..theme..[[;
      border-radius: 4px;]]
  adjLabelstyle = adjLabelstyle..[[ qproperty-alignment: 'AlignLeft | AlignTop';]]
--  adjLabelstyle = [[border: 6px solid transparent;border-image: url(C:/Users/tdk10/.config/mudlet/profiles/Brax/EleUI2/imgs/oga.png) round]]
  cont = cont or Geyser
  for  k,v in pairs(cont.windowList) do
    if v.type == "adjustablecontainer" then 
      v.adjLabel:setStyleSheet(adjLabelstyle)
    end
    Adjustable.Container.saveAll(v)
  end

end

function Geyser.Label:setCooldown(params)
    self.start = params.start or 0 --start value of stylesheet variable
    self.stop = params.stop or 1 -- stop value of stylesheet variable
    self.cval = params.start -- current value of stylesheet variable (dynamic)
    self.cdStyleSheet = params.styleSheet --stylesheet has %s in place of dynamic value
    self.framerate = params.framerate or 0.05 -- framerate as decimal: default 20fps
    self.cd_label = Geyser.Label:new({
        name = self.name_cd_label,
        x = 0,
        y = 0,
        height = '100%',
        width = '100%',
    }, self)
    self.cd_label:hide()
    
end

function Geyser.Label:startCooldown(time)
    self.time = time or 1
    self.increment = self.framerate / self.time
    self.cval = self.start
    self.cd_label:show()
    self.cd_label:setStyleSheet(string.format(self.cdStyleSheet, tostring(self.cval)))
    if self.cdtimer then killTimer(self.cdtimer) end

    self.cdtimer = tempTimer(self.framerate, function()
        self.cval = self.cval + self.increment 
--print(self.cval)
        if self.cval >= self.stop then
            self:stopCooldown()
        else
            self.cd_label:setStyleSheet(string.format(self.cdStyleSheet, tostring(self.cval)))
        end
    end,
    true --timer is repeating
    )
end

function Geyser.Label:stopCooldown()
    self.cval = self.start
    self.cd_label:setStyleSheet(string.format(self.cdStyleSheet, tostring(self.cval)))
    self.cd_label:hide()
    killTimer(self.cdtimer)
end

brax = brax or {}
brax.CDripple = [[
	background-color: qradialgradient(
		spread:pad, cx:0.5, cy:0.5, radius:%s, fx:0.5, fy:0.5, 
		stop:0.3 rgba(100, 100, 100, 180), 
		stop:0.6 rgba(100, 100, 100, 130), 
		stop:0.7 rgba(120, 120, 120, 0))
    ]]
brax.qconical = [[
  background-color: qconicalgradient(cx:0.5, cy:0.5, angle:90, stop:%s rgba(0, 0, 0, 200), stop:1 rgba(255, 255, 255, 0))]]


if not spairs then
  function spairs(tbl, order)
    local keys = table.keys(tbl)
    if order then
      table.sort(keys, function(a,b) return order(tbl, a, b) end)
    else
      table.sort(keys)
    end

    local i = 0
    return function()
      i = i + 1
      if keys[i] then
        return keys[i], tbl[keys[i]]
      end
    end
  end
end

function isNumber(n)
  if (type(n) == "string" and string.find(n,"^%d+%.?%d*$")) then
    return tonumber(n)
  else
    return n
  end
end