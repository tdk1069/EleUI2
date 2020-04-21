function update_statsBox()
    local prime,second = unpack(gmcp.Char.Status.class)
    brax.class.prime = prime or ""
    brax.class.second = second or ""
    if (brax.class.second == "") then brax.class.second = "" else brax.class.second =  "/" .. brax.class.second end
    brax.xp = gmcp.Char.Vitals.exp
    if brax.xpType == true then brax.xp = brax.xp - brax.curXP end  
    statsDetails:echo(
    [[<span style="style="font-family: 'Game Played';font-size:15px;"><center> ]] .. string.upper(brax.class.prime .. brax.class.second) ..[[</span>
    <br><span style="font-size:15px"><centerd>XP ]] .. comma_value(brax.xp) ..[[</span>]]
    )
    hpbar.text:echo([[<span style="font-family: 'Game Played';font-size:25px;">&nbsp;HP:]] .. gmcp.Char.Vitals.hp .. [[/<span style="font-size:15px">]] .. gmcp.Char.Vitals.maxhp ..[[</span>]])
    mpbar.text:echo([[<span style="font-family: 'Game Played';font-size:25px;">&nbsp;MP:]] .. gmcp.Char.Vitals.mp .. [[/<span style="font-size:15px">]] .. gmcp.Char.Vitals.maxmp ..[[</span>]])
    spbar.text:echo([[<span style="font-family: 'Game Played';font-size:25px;">&nbsp;SP:]] .. gmcp.Char.Vitals.sp .. [[/<span style="font-size:15px">]] .. gmcp.Char.Vitals.maxsp ..[[</span>]])
    hpbar:setValue(gmcp.Char.Vitals.hp,gmcp.Char.Vitals.maxhp)
    mpbar:setValue(gmcp.Char.Vitals.mp,gmcp.Char.Vitals.maxmp)
    spbar:setValue(gmcp.Char.Vitals.sp,gmcp.Char.Vitals.maxsp)
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
  brax.xpType = not brax.xpType
  update_statsBox()
end


registerAnonymousEventHandler("gmcp.Char.Vitals", "update_statsBox")