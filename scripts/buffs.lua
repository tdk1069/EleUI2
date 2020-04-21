function get_Buffs()
  myBuffs = myBuffs or {}
  myBuffsTotal = myBuffsTotal or 0
--  display(gmcp.Char.Buffs)
  for spell, dur in pairs(gmcp.Char.Buffs) do
    if dur ~= 0 then
      local debuff = gmcp.Char.Buffs[spell][3]
      local count = 0
      local frontCSS =
        [[
        border-style: outset;
        border-color: gray;
        border-width: 1px;
        border-radius: 4px;
        margin: 0px;
        padding: 0px;
        background-color: #1f6140;
]]
      if debuff == 1 then
        frontCSS =
          [[
    border-style: outset;
    border-color: gray;
    border-width: 1px;
    border-radius: 4px;
    margin: 0px;
    padding: 0px;
    background-color: #800000;
]]
      end
      local dupeFix = 99999
      for spell,dupecheck in pairs(myBuffs) do
        count = count + 1
        if dupecheck >= dupeFix then dupeFix = dupecheck+1 end
      end
      myBuffsTotal = count - 1
      if dur[1] == 0 then 
        dur[1]=dupeFix
      end
      demonnic.anitimer:new(
        spell,
        {x = 0, y = myBuffsTotal * 25, height = 20, width = "100%"},
        dur[1],
        {container = buffBoxContainer, showTime = true, timerCaption = spell, cssFront = frontCSS}
      )
if dur[1] >= 99999 then 
  demonnic.anitimer:pause(spell)
  demonnic.anitimer.timers[spell].gauge.text:echo([[<span style="font-family: 'Game _Played';">]]..spell)
end
      demonnic.anitimer.timers[spell].gauge.text:setStyleSheet([[padding-left:2px]])
      demonnic.anitimer.timers[spell].gauge.text:setToolTip(dur[2])
      myBuffs[spell] = demonnic.anitimer.timers[spell].current
--hotbar
      for i = 1, 10 do
      brax.hotbar[i] = brax.hotbar[i] or {}
        if brax.hotbar[i].buff == spell then
          brax.hotbar[i].box:setStyleSheet(
            [[QLabel{background-color: red;border-width: 1px;border-style: solid;border-color: green;border-radius: 3px;}QLabel::hover {background-color:grey;}]]
          )
          --local css = [[QLabel{background-color: red;border-width: 1px;border-style: solid;border-color: green;border-radius: 3px;}]]
          tempTimer(
            dur[1],
            function()
              brax.hotbar[i].box:setStyleSheet(
                [[QLabel{background-color: black;border-width: 1px;border-style: solid;border-color: green;border-radius: 3px;}]]
              )
            end
          )
        end
      end
--end hotbar
    else
      demonnic.anitimer.timers[spell].gauge:hide()
      myBuffs[spell] = null
      demonnic.anitimer:destroy(spell)
      local count = 0
      for _ in pairs(myBuffs) do
        count = count + 1
      end
      myBuffsTotal = count
    end
  end
  local tBuff = {}
  local tName = {}
  local pos = 0
  local timeLeft = 0
  for i, v in pairs(myBuffs) do
    timeLeft = demonnic.anitimer.timers[i].current
    table.insert(tBuff, timeLeft)
    tName[timeLeft] = i
  end
  table.sort(tBuff)
  for i, v in pairs(tBuff) do
    demonnic.anitimer.timers[tName[v]].gauge:move(0, pos * 25)
    pos = pos + 1
  end
end

registerAnonymousEventHandler("gmcp.Char.Buffs", "get_Buffs")