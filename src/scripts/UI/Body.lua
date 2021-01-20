function get_Body()
--display(gmcp.Char.Limbs)
  myLimbs = myLimbs or {}
  for limb,details in pairs(gmcp.Char.Limbs) do
   limb = limb or ""
    myLimbs[limb] = myLimbs[limb] or {}
    if type(gmcp.Char.Limbs[limb]) == "number" then
      hp = gmcp.Char.Limbs[limb]
      gmcp.Char.Limbs[limb] = {}
      gmcp.Char.Limbs[limb].maxhp = hp
      gmcp.Char.Limbs[limb].hp = gmcp.Char.Limbs[limb].maxhp
      gmcp.Char.Limbs[limb].severed = 0
      gmcp.Char.Limbs[limb].bandaged = 0
    end

    if isNumber(gmcp.Char.Limbs[limb].hp) == 0 and isNumber(gmcp.Char.Limbs[limb].severed) == 0 and isNumber(gmcp.Char.Limbs[limb].bandaged) == 0 then
       gmcp.Char.Limbs[limb].hp =  gmcp.Char.Limbs[limb].maxhp
    end
    gmcp.Char.Limbs = gmcp.Char.Limbs or {}
    thisLimb = gmcp.Char.Limbs[limb] or {}

    if thisLimb.hp then myLimbs[limb].hp = thisLimb.hp or details.hp end
    if thisLimb.maxhp then myLimbs[limb].maxhp = thisLimb.maxhp or details.maxhp end
															  
														
		   
	   
    if thisLimb.severed then myLimbs[limb].severed = thisLimb.severed or details.severed end
    if thisLimb.bandaged then myLimbs[limb].bandaged = thisLimb.bandaged or details.bandaged end

    if myLimbs[limb].hp and myLimbs[limb].maxhp then
	  if myLimbs[limb].hp > myLimbs[limb].maxhp then myLimbs[limb].hp = myLimbs[limb].maxhp end
      myLimbs[limb].pc = 100 - math.ceil((myLimbs[limb].hp/myLimbs[limb].maxhp)*100)
    end
  end

  tempLimb = {}
  for limb,details in pairs(myLimbs) do
      tempLimb[limb] = details.pc
  end
  list = {}
  for name,value in pairs(tempLimb) do
      list[#list+1] = name
  end
  function byval(a,b)
      return tempLimb[a] > tempLimb[b]
  end
  table.sort(list,byval)
  local bodyString = "<table>"
  for k=1,#list do
        bodyString = bodyString .. "<tr><td width='50%'>".. list[k] .. "</td><td>" .. tempLimb[list[k]] .. "</td><td>"..("#"):rep(math.ceil(tempLimb[list[k]]/10)).."</td></tr>"
  end
  bodyBox:echo(bodyString)
  raiseEvent("EleUI.body")
end

registerAnonymousEventHandler("gmcp.Char.Limbs","get_Body")