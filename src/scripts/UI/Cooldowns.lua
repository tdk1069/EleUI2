function get_Cooldowns()

  myCooldowns = myCooldowns or {}
  myCooldownsTotal =   myCooldownsTotal or 0
  local _,dpiHeight = calcFontSize(8)
  local _,dpiGap = calcFontSize(10)

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
      demonnic.anitimer:new("cd"..spell, {x = 0, y=myCooldownsTotal*dpiGap, height = dpiHeight, width = "100%"}, dur, {container = cooldownBoxContainer, showTime = true, timerCaption = spell,cssFront=frontCSS,hook = "aTimerEnd(\""..spell.."\")"})
      if cooldownBoxContainer.hidden == true then 
        demonnic.anitimer.timers["cd"..spell].gauge:hide(true) 
      else
        demonnic.anitimer.timers["cd"..spell].gauge:show() 
      end
      myCooldowns[spell] = demonnic.anitimer.timers["cd"..spell].current
    else 
--      if demonnic.anitimer.timers["cd"..spell] then demonnic.anitimer.timers["cd"..spell].gauge:hide() end
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
    if demonnic.anitimer.timers["cd"..i] then
      timeLeft = demonnic.anitimer.timers["cd"..i].current
      table.insert(tCooldowns,timeLeft)
      tName[timeLeft]=i
    end
  end
  table.sort(tCooldowns)
  for i,v in pairs(tCooldowns) do 
    demonnic.anitimer.timers["cd"..tName[v]].gauge:move(0,pos*dpiGap)
    pos = pos +1
  end
  raiseEvent("EleUI.cooldown")

end

brax = brax or {}
brax.cooldownEvent = registerAnonymousEventHandler("gmcp.Char.Cooldowns","get_Cooldowns")
