function castBar()
  if gmcp.Char.Cast.cast_time > 0 then
    demonnic.anitimer:new("cast"..gmcp.Char.Cast.spell, {x = 0, y=0, height = "100%", width = "100%"}, gmcp.Char.Cast.cast_time, {container = castbarBoxContainer, showTime = true, timerCaption = gmcp.Char.Cast.spell})
      if castbarBoxContainer.hidden == true then 
        demonnic.anitimer.timers["cast"..gmcp.Char.Cast.spell].gauge:hide(true) 
      end
  else
    demonnic.anitimer:destroy("cast"..gmcp.Char.Cast.spell)
  end
end

registerAnonymousEventHandler("gmcp.Char.Cast", "castBar")