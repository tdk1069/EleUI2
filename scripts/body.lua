function get_Body()
  myLimbs = myLimbs or {}
  for limb,details in pairs(gmcp.Char.Limbs) do
    myLimbs[limb] = myLimbs[limb] or {}
    gmcp.Char.Limbs = gmcp.Char.Limbs or {}
    if gmcp.Char.Limbs[limb].hp then myLimbs[limb].hp = gmcp.Char.Limbs[limb].hp or details.hp end
    if gmcp.Char.Limbs[limb].maxhp then myLimbs[limb].maxhp = gmcp.Char.Limbs[limb].maxhp or details.maxhp end
    if gmcp.Char.Limbs[limb].severed then myLimbs[limb].severed = gmcp.Char.Limbs[limb].severed or details.severed end
    if gmcp.Char.Limbs[limb].bandaged then myLimbs[limb].bandaged = gmcp.Char.Limbs[limb].bandaged or details.bandaged end
    if myLimbs[limb].hp and myLimbs[limb].maxhp then
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
        bodyString = bodyString .. "<tr><td width='50%'>".. list[k] .. "</td><td>" .. tempLimb[list[k]] .. ("#"):rep(math.ceil(tempLimb[list[k]]/10)).."</td></tr>"
  end
  bodyBox:echo(bodyString)
end

registerAnonymousEventHandler("gmcp.Char.Limbs","get_Body")