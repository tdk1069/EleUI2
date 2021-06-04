function get_Body()
--  display(gmcp.Char.Limbs)
  myLimbs = myLimbs or {}
  gmcp.Char.Limbs = gmcp.Char.Limbs or {}
  for limb, details in pairs(gmcp.Char.Limbs) do
    limb = limb or ""
    myLimbs[limb] = myLimbs[limb] or {}
    if gmcp.Char.Limbs[limb] == 0 then
      myLimbs[limb] = nil
    else
      gmcp.Char.Limbs = gmcp.Char.Limbs or {}
      thisLimb = gmcp.Char.Limbs[limb] or {}
      if thisLimb.hp then
        myLimbs[limb].hp = thisLimb.hp or details.hp
      end
      if thisLimb.maxhp then
        myLimbs[limb].maxhp = thisLimb.maxhp or details.maxhp
      end
      if thisLimb.severed then
        myLimbs[limb].severed = thisLimb.severed or details.severed
      end
      if thisLimb.bandaged then
        myLimbs[limb].bandaged = thisLimb.bandaged or details.bandaged
      end
      if thisLimb.broken then
        myLimbs[limb].broken = thisLimb.broken or details.broken
      end
      if myLimbs[limb].hp and myLimbs[limb].maxhp then
        if myLimbs[limb].hp > myLimbs[limb].maxhp then
          myLimbs[limb].hp = myLimbs[limb].maxhp
        end
        myLimbs[limb].pc = 100 - math.ceil((myLimbs[limb].hp / myLimbs[limb].maxhp) * 100)
      end
    end
  end
  tempLimb = {}
  for limb, details in pairs(myLimbs) do
    if details.severed == 1 then
      tempLimb[limb] = 300
    elseif details.broken == 1 then
      tempLimb[limb] = 200
    else
      tempLimb[limb] = details.pc
    end
  end
  local list = {}
  for name, value in pairs(tempLimb) do
    list[#list + 1] = name
  end

  function byval(a, b)
    return tempLimb[a] > tempLimb[b]
  end

  table.sort(list, byval)
  local bodyString = "<table>"
  for k = 1, #list do
    if myLimbs[list[k]].broken == 1 then
      bodyString =
        bodyString ..
        "<tr><td width='50%'>" ..
        list[k] ..
        "</td><td style='color:Orange;'>BROKEN</td><td>" ..
        "</td></tr>"
    elseif myLimbs[list[k]].severed == 1 then
      bodyString =
        bodyString ..
        "<tr><td width='50%'>" ..
        list[k] ..
        "</td><td style='color:Red;'>SEVERED</td><td>" ..
        "</td></tr>"
    else
      bodyString =
        bodyString ..
        "<tr><td width='50%'>" ..
        list[k] ..
        "</td><td>" ..
        tempLimb[list[k]] ..
        "</td><td>" ..
        ("#"):rep(math.ceil(tempLimb[list[k]] / 10)) ..
        "</td></tr>"
    end
  end
  bodyBox:echo(bodyString)
  raiseEvent("EleUI.body")
end

brax = brax or {}
brax.bodyEvent = registerAnonymousEventHandler("gmcp.Char.Limbs","get_Body")

