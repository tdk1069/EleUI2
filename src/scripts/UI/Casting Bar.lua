function castBar()
--display(gmcp.Char.Cast.cast_time)
  local timerGauge = require("EleUI2.timergauge")
  if gmcp.Char.Cast.cast_time > 0 then
    local csFront = [[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #f04141, stop: 0.1 #ef2929, stop: 0.49 #cc0000, stop: 0.5 #a40000, stop: 1 #cc0000);
        border-top: 1px black solid;
        border-left: 1px black solid;
        border-bottom: 1px black solid;
        border-radius: 5;
        padding: 3px;]]
    local csFront = [[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #775b28, stop: 0.1 #aa6c39, stop: 0.49 #775b28, stop: 0.5 #775b28, stop: 1 #aa6c39);
        border-top: 1px black solid;
        border-left: 1px black solid;
        border-bottom: 1px black solid;
        border-radius: 5;
        padding: 3px;]]
    local csBack = [[background-color: black;
        border-width: 1px;
        border-color: #aa6c39;
        border-style: solid;
        border-radius: 5;
        padding: 3px;]]

--    demonnic.anitimer:new("cast_"..gmcp.Char.Cast.spell, {x = 0, y=0, height = "100%", width = "100%"}, gmcp.Char.Cast.cast_time, {container = castbarBoxContainer, showTime = true, timerCaption = properCase(gmcp.Char.Cast.spell),cssFront = csFront,cssBack = csBack})
    if brax.castBar then
      brax.castBar.suffix = " "..properCase(gmcp.Char.Cast.spell)
      brax.castBar:setTime(tonumber(gmcp.Char.Cast.cast_time))
      brax.castBar:restart()
    else
      brax.castBar = brax.castBar or timerGauge:new({
      name = "cast_bar",
      x=0,
      y=0,
      height = "100%",
      width = "100%",
      time = tonumber(gmcp.Char.Cast.cast_time),
      showTimer = true,
      timerCaption = " "..properCase(gmcp.Char.Cast.spell),
      cssFront = csFront,
      cssBack = csBack,
      cssText = baseCss,
      active = true,
      autoHide = true,
      },castbarBoxContainer)
end
      if castbarBoxContainer.hidden == true then 
        brax.castBar:hide(true) 
      else
        brax.castBar:show2() 
        brax.castBar:raise()
        castbarBoxContainer:raiseAll()
      end
  else
    demonnic.anitimer:destroy("cast_"..gmcp.Char.Cast.spell)
  end
  raiseEvent("EleUI.casting")
end

registerAnonymousEventHandler("gmcp.Char.Cast", "castBar")