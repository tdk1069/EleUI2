function eleProfileReset()
  -- This will reset :
  -- Vitals
  -- Inventory
  -- Buffs/debuffs
  -- Cooldowns
  -- Target/Hunters/Attackers
  -- Limbs
  -- ChatTabs
  -- Skills/Stats

  brax.items = {}
  brax.items.inventory = {}
  brax.items.bagList = {}
  brax.items.baggedItems = {}
  gmcp.Char.Vitals.hp = 0
  gmcp.Char.Vitals.mp = 0
  gmcp.Char.Vitals.sp = 0
  gmcp.Char.Vitals.maxhp = 1
  gmcp.Char.Vitals.maxmp = 1
  gmcp.Char.Vitals.maxsp = 1
  brax.skills = {}
  brax.stats = {}
  myCooldowns = myCooldowns or {}
  myBuffs = myBuffs or {}
  
  for spell, dur in pairs(myBuffs) do
    demonnic.anitimer:destroy(spell)
    myBuffs[spell] = nil
  end
  myBuffsTotal = 0
  
  for spell, dur in pairs(myCooldowns) do
    demonnic.anitimer:destroy("cd"..spell)
    myCooldowns[spell] = nil
  end
  myCooldownsTotal = 0

  for tab,_ in pairs(chatBox.tabs) do
    removeTab(tab)
  end
  chatBox:addTab("All")
  chatBox:switchTab("All")
  
  brax.targetState.name = nil
  brax.targetState.hp = 1
  brax.targetState.Casting = nil
  targetBar:setValue(0, 1, "")
  targetBar:hide()
  targetBox:echo("")
  
  myLimbs = {}
  bodyBox:echo("")
  get_Body()
end
if (not brax.resetAlias) then 
  brax.resetAlias = permAlias("UI Reset ","UI Aliases","^ui reset$",[[eleProfileReset()]])
end
