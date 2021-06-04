brax = brax or {}
brax.targetState = {name = nil, hp = 1, casting = nil}

function update_target_status()
  if (isNumber(gmcp.Char.Target) == 0 or next(gmcp.Char.Target) == nil) then
    clear_target()
  else
    if (gmcp.Char.Target.name ~= nil) then
      if (brax.targetState.name ~= gmcp.Char.Target.name) then
        brax.targetState.hp = 1
      end
      brax.targetState.name = gmcp.Char.Target.name
    else
      brax.targetState.name = brax.targetState.name
    end
    brax.targetState.name = brax.targetState.name or ""
    targetBar:setValue(
      brax.targetState.hp,
      1,
      string.format("&nbsp;%0.2f%%",brax.targetState.hp*100).. " ".. brax.targetState.name
    )
    targetBar.front:setStyleSheet(
      [[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #f04141, stop: 0.1 #ef2929, stop: 0.49 #cc0000, stop: 0.5 #a40000, stop: 1 #cc0000);
        border-top: 1px black solid;
        border-left: 1px black solid;
        border-bottom: 1px black solid;
        border-radius: 5;
        padding: 3px;]]
    )
    targetBar.back:setStyleSheet(
      [[background-color: black;
        border-width: 1px;
        border-color: #f04141;
        border-style: solid;
        border-radius: 5;
        padding: 3px;]]
    )
    targetBar:show()
  end
end

function update_target_vitals()
  brax.targetState.hp = gmcp.Char.Target.Vitals.hp or brax.targetState.hp
  if (brax.targetState.hp > 0) then
    targetBar:setValue(
      brax.targetState.hp,
      1,
      string.format("&nbsp;%0.2f%%",brax.targetState.hp*100).. " ".. brax.targetState.name
    )
    brax.TargetOldHP = gmcp.Char.Target.Vitals.hp
    targetBar:show()
  end
end

function update_target_cast()
  local duration = gmcp.Char.Target.Cast.cast_time
  if duration <= 0 then
    brax.targetState.casting = nil
  else
    brax.targetState.casting =
      {name = gmcp.Char.Target.Cast.spell, castTime = duration, timeLeft = duration}
    demonnic.anitimer:new(
      "T" .. brax.targetState.casting.name,
      {x = 0, y = 17, height = 15, width = "100%"},
      brax.targetState.casting.castTime,
      {
        container = targetBoxContainer,
        showTime = true,
        timerCaption = brax.targetState.casting.name,
        cssFront = frontCSS,
      }
    )
  end
end

function attackers_hunters()
  info = ""
  --display(gmcp.Char.Attackers.Attack)
  if next(gmcp.Char.Attackers.Attack) ~= nil then
    info = info .. "<br><b>*Attackers</b><br>"
    for i, who in pairs(gmcp.Char.Attackers.Attack) do
      info = info .. who .. "<br>"
    end
  end
  if next(gmcp.Char.Attackers.Hunt) ~= nil then
    info = info .. "<b>Hunters</b><br>"
    for i, who in pairs(gmcp.Char.Attackers.Hunt) do
      info = info .. who .. "<br>"
    end
  end
  targetBox:echo(info)
end

function clear_targetBoxContainer()
  targetBox:echo("")
  targetBar:hide()
  clear_target()
  clearDebuffs()
end

function clear_target()
  brax.targetState.name = nil
  brax.targetState.hp = 1
  brax.targetState.Casting = nil
  targetBar:setValue(0, 1, "")
  targetBar:hide()
  if clearAggroWindow then clearAggroWindow() end
  if debuffBoxContainer then clearDebuffs() end
end

brax = brax or {}
brax.targetEvent = registerAnonymousEventHandler('gmcp.Char.Target', 'update_target_status')
brax.targetVitalsEvent = registerAnonymousEventHandler("gmcp.Char.Target.Vitals", "update_target_vitals")
brax.targetCastEvent = registerAnonymousEventHandler('gmcp.Char.Target.Cast', 'update_target_cast')
brax.attackersEvent = registerAnonymousEventHandler("gmcp.Char.Attackers", "attackers_hunters")
brax.quitEvent = registerAnonymousEventHandler('gmcp.Char.Quit', 'clear_targetBoxContainer')
