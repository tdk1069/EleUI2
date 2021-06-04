function skillsChanged()
  brax.skills = gmcp.Char.Skills
  if scoreWindowBox then 
    scoreWindowBox:echo(sortSkills())
  end
end

function statsChanged()
  brax.stats = gmcp.Char.Stats
  if scoreWindowBox then 
    scoreWindowBox:echo(sortSkills())
  end
end

function sortSkills()
  local combat = {"armoury", "attack", "defence", "double wielding", "melee", "shields"}
  local weapons = {"blade", "blunt", "knife", "polearm", "projectile", "staff", "thrown", "whip"}
  local magic =
    {
      "conjuring",
      "chi",
      "faith",
      "healing",
      "insight",
      "magic attack",
      "magic defence",
      "woodcraft",
    }
  local other =
    {
      "application",
      "bargaining",
      "murder",
      "riding",
      "skullduggery",
      "stealing",
      "stealth",
      "swimming",
    }
  local c, m, w, o, skillString
  brax = brax or {}
  brax.skills = brax.skills or {}
  brax.skills.combat = {}
  brax.stats = brax.stats or {}
  testCombat = {}
  for _, skill in spairs(combat) do
    if brax.skills[skill] then
      table.insert(brax.skills.combat, {skill, brax.skills[skill]})
    end
  end
  brax.skills.weapons = {}
  for _, weapon in spairs(weapons) do
    if brax.skills[weapon] then
      table.insert(brax.skills.weapons, {weapon, brax.skills[weapon]})
    end
  end
  brax.skills.magic = {}
  for _, magic in spairs(magic) do
    if brax.skills[magic] then
      table.insert(brax.skills.magic, {magic, brax.skills[magic]})
    end
  end
  brax.skills.other = {}
  for _, other in spairs(other) do
    if brax.skills[other] then
      table.insert(brax.skills.other, {other, brax.skills[other]})
    end
  end
  skillString =
    [[<pre><span style="color: rgb(192,192,192)">You have the following physical traits:<br>]]
  skillString =
    skillString ..
    string.format(
      [[<span style="color: rgb(0,128,128)">Strength:<span style="color: rgb(192,192,192)">     %-2d   <span style="color: rgb(0,128,128)">Intelligence: <span style="color: rgb(192,192,192)">%-2d   <span style="color: rgb(0,128,128)">Wisdom:       <span style="color: rgb(192,192,192)">%-2d<br>]],
      brax.stats.strength or 0,
      brax.stats.intelligence or 0,
      brax.stats.wisdom or 0
    )
  skillString =
    skillString ..
    string.format(
      [[<span style="color: rgb(0,128,128)">Dexterity:<span style="color: rgb(192,192,192)">    %-2d   <span style="color: rgb(0,128,128)">Constitution: <span style="color: rgb(192,192,192)">%-2d   <span style="color: rgb(0,128,128)">Charisma:     <span style="color: rgb(192,192,192)">%-2d<br>]],
      brax.stats.dexterity or 0,
      brax.stats.constitution or 0,
      brax.stats.charisma or 0
    )
  skillString =
    skillString ..
    [[<span style="color: rgb(192,192,192)">You have the following learned attributes:<br>]]
  skillString =
    skillString ..
    [[<span style="color: rgb(128,0,128)">-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-<br>]]
  for row = 1, 10 do
    if brax.skills.combat[row] then
      c =
        string.format(
          [[<span style="color: rgb(0,128,128)">%-17s<span style="color: rgb(192,192,192)">%-3d]],
          properCase(brax.skills.combat[row][1] .. ":"),
          brax.skills.combat[row][2]
        )
    else
      c = string.format("%-20s", "")
    end
    if brax.skills.weapons[row] then
      w =
        string.format(
          [[<span style="color: rgb(0,128,128)">%-12s<span style="color: rgb(192,192,192)">%-3d]],
          properCase(brax.skills.weapons[row][1] .. ":"),
          brax.skills.weapons[row][2]
        )
    else
      w = string.format("%-15s", "")
    end
    if brax.skills.magic[row] then
      m =
        string.format(
          [[<span style="color: rgb(0,128,128)">%-15s<span style="color: rgb(192,192,192)">%-3d]],
          properCase(brax.skills.magic[row][1] .. ":"),
          brax.skills.magic[row][2]
        )
    else
      m = string.format("%-18s", "")
    end
    if brax.skills.other[row] then
      o =
        string.format(
          [[<span style="color: rgb(0,128,128)">%-14s<span style="color: rgb(192,192,192)">%-3d]],
          properCase(brax.skills.other[row][1] .. ":"),
          brax.skills.other[row][2]
        )
    else
      o = string.format("%-10s", "")
    end
    skillString = skillString .. c .. "  " .. w .. "  " .. m .. "  " .. o .. "<br>"
  end
  skillString =
    skillString ..
    [[<span style="color: rgb(128,0,128)">-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-<br>]]
  return skillString
end

function initStats()
  scoreWindow = scoreWindow or EleUI:createWindow(
      {
        x = "22%",
        y = "28.6%",
        name = "scoreWindow",
        titleText = "",
        height = "42%",
        width = "42%",
      }
    )
  if scoreWindow.hidden == false then
    scoreWindow:hide()
    return
  end
  scoreWindow:setTitle("<center>".."Physical and learned attributes","#A4A100") 
  --  scoreWindow:resize("65%",_)
  scoreWindowBox = scoreWindowBox or 
    Geyser.Label:new(
      {name = "ScoreWindow", color = "black", x = "3%", y = "10%", width = "94%", height = "82%"},
      scoreWindow
    )
  scoreWindowBox:setStyleSheet([[background:rgba(0,0,0,255)]])
  scoreWindowBox:echo(sortSkills())
  scoreWindowBox:raise()
  scoreWindow:show()
  scoreWindow:raiseAll()
end

brax = brax or {}
brax.skillsEvent = registerAnonymousEventHandler("gmcp.Char.Skills", "skillsChanged")
brax.statsEvent = registerAnonymousEventHandler("gmcp.Char.Stats", "statsChanged")
