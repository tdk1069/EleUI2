function get_Cooldowns()

  myCooldowns = myCooldowns or {}
  myCooldownsTotal =   myCooldownsTotal or 0

--display(gmcp.Char.Cooldowns)

  local count = 0
  for spell,dur in pairs(gmcp.Char.Cooldowns) do
    if dur ~= 0 then
      local count = 0
      local frontCSS = [[
        border-style: outset;
        border-color: gray;
        border-width: 1px;
        border-radius: 4px;
        margin: 0px;
        padding: 0px;
        background-color: #1f6140;
]]
      for _ in pairs(myCooldowns) do count = count + 1 end
      myCooldownsTotal = count -1
      demonnic.anitimer:new("cd"..spell, {x = 0, y=myCooldownsTotal*25, height = 20, width = "100%"}, dur, {container = cooldownBox, showTime = true, timerCaption = spell,cssFront=frontCSS,hook = "aTimerEnd(\""..spell.."\")"})
      if cooldownBoxContainer.hidden == true then 
        demonnic.anitimer.timers["cd"..spell].gauge:hide(true) 
      end
      myCooldowns[spell] = demonnic.anitimer.timers["cd"..spell].current
    else 
      if demonnic.anitimer.timers["cd"..spell] then demonnic.anitimer.timers["cd"..spell].gauge:hide() end
      myCooldowns["cd"..spell] = null
      demonnic.anitimer:destroy("cd"..spell)
    end
  end
  
  local count = 0
  for _ in pairs(myCooldowns) do count = count + 1 end
  myCooldownsTotal = count

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

registerAnonymousEventHandler("gmcp.Char.Cooldowns","get_Cooldowns")