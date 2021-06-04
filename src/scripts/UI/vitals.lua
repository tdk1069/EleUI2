function update_statsBox()
--display(gmcp.Char.Vitals)
    -- Destring vital numbers
    local _,padding = calcFontSize(12)
      for key,val in pairs(gmcp.Char.Vitals) do
        if string.find(val,"^%d+%.?%d*$") then gmcp.Char.Vitals[key] = tonumber(val) end
    end
    local prime,second = unpack(gmcp.Char.Status.class)
    brax.class.prime = prime or ""
    brax.class.second = second or ""
    if (brax.class.second == "") then brax.class.second = "" else brax.class.second =  "/" .. brax.class.second end
    brax.xp = gmcp.Char.Vitals.exp
    if brax.xpType == true then brax.xp = brax.xp - brax.curXP end  
    statsDetails:echo(
    [[<span style="style="font-family: 'Game Played';font-size:]]..padding..[[px;"><center> ]] .. string.upper(brax.class.prime .. brax.class.second) ..[[</span>
    <br><span style="font-size:]]..padding..[[px"><centerd>XP ]] .. comma_value(brax.xp) ..[[</span>]]
    )
    --
    -- Hacky fix for ele not sending new max values in vitals
    --
    gmcp.Char.Vitals.hp = tonumber(gmcp.Char.Vitals.hp)
    gmcp.Char.Vitals.maxhp = tonumber(gmcp.Char.Vitals.maxhp)
    gmcp.Char.Vitals.mp = tonumber(gmcp.Char.Vitals.mp)
    gmcp.Char.Vitals.maxmp = tonumber(gmcp.Char.Vitals.maxmp)
    gmcp.Char.Vitals.sp = tonumber(gmcp.Char.Vitals.sp)
    gmcp.Char.Vitals.maxsp = tonumber(gmcp.Char.Vitals.maxsp)
    if gmcp.Char.Vitals.hp > gmcp.Char.Vitals.maxhp then gmcp.Char.Vitals.maxhp = gmcp.Char.Vitals.hp end
    if gmcp.Char.Vitals.mp > gmcp.Char.Vitals.maxmp then gmcp.Char.Vitals.maxmp = gmcp.Char.Vitals.mp end
    if gmcp.Char.Vitals.sp > gmcp.Char.Vitals.maxsp then gmcp.Char.Vitals.maxsp = gmcp.Char.Vitals.sp end
    --
    hpbar.text:echo([[<span style="font-family: 'Game Played';font-size:]]..padding..[[px;">&nbsp;HP:]] .. gmcp.Char.Vitals.hp .. [[/<span style="font-size:]]..(padding/0.75)..[[px">]] .. gmcp.Char.Vitals.maxhp ..[[</span>]])
    mpbar.text:echo([[<span style="font-family: 'Game Played';font-size:]]..padding..[[px;">&nbsp;MP:]] .. gmcp.Char.Vitals.mp .. [[/<span style="font-size:]]..(padding/0.75)..[[px">]] .. gmcp.Char.Vitals.maxmp ..[[</span>]])
    spbar.text:echo([[<span style="font-family: 'Game Played';font-size:]]..padding..[[px;">&nbsp;SP:]] .. gmcp.Char.Vitals.sp .. [[/<span style="font-size:]]..(padding/0.75)..[[px">]] .. gmcp.Char.Vitals.maxsp ..[[</span>]])
    hpbar:setValue(gmcp.Char.Vitals.hp,gmcp.Char.Vitals.maxhp)
    mpbar:setValue(gmcp.Char.Vitals.mp,gmcp.Char.Vitals.maxmp)
    spbar:setValue(gmcp.Char.Vitals.sp,gmcp.Char.Vitals.maxsp)
    raiseEvent("EleUI.vitals")
end

function comma_value(amount)
if amount then
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
  else
    return ""
  end
end
function toggleXP()
  brax.xp = gmcp.Char.Vitals.exp
  brax.curXP = brax.xp
--  brax.XPH = nil
  brax.xpType = not brax.xpType
  update_statsBox()
  getXPH()
end

function testVitalsEvent(...)
  display(arg)
end

brax = brax or {}
brax.vitalEvent = registerAnonymousEventHandler("gmcp.Char.Vitals", "update_statsBox")

