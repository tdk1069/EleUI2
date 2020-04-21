function json_to_value(eledata)
--display(eledata)
  if string.find(eledata,"^%d*$") then
    return tonumber(eledata)
  elseif eledata:sub(3,5) == "msg" then
    msg = {string.match(eledata,'{\"(.-)\": \"(.-)\", \"(.-)\": \"(.-)\", \"(.-)\": \"(.-)\", \"(.-)\": \"(.-)\", \"(%a-)\": \"(.-)\"}')}
    return yajl.to_value((string.format("{\"%s\": %q, \"%s\": \"%s\", \"%s\": \"%s\", \"%s\": %q, \"%s\": \"%s\" }",msg[1],msg[2],msg[3],msg[4],msg[5],msg[6],msg[7],msg[8],msg[9],msg[10])))
  elseif eledata:sub(3,7) == "emote" then
    msg = {string.match(eledata,'{\"(%a-)\": (%d-), \"(%a-)\": \" (.-)\", \"(%a-)\": \"(%a-)\", \"(%a-)\": \"(.-)\", \"rawmsg\": \"(.*)\"')}
    return yajl.to_value((string.format("{\"%s\": %d, \"%s\": \"%s\", \"%s\": \"%s\", \"%s\": %q, \"rawmsg\": %q }",msg[1],msg[2],msg[3],msg[4],msg[5],msg[6],msg[7],msg[8],msg[9])))
  else
    return yajl.to_value(eledata)
  end
end

function Geyser.Container:_show (auto)
  auto = auto or false
  if auto then
    self.auto_hidden = false
  else
    self.hidden = false
  end
  if not self.hidden and not self.auto_hidden then
    self:show_impl()
  end
  for _, v in pairs(self.windowList) do
    if v.hidden == false then v:show(true) end
  end
end

function speedwalktimer(walklist, walkdelay, show)
  send(walklist[1], show)
  table.remove(walklist, 1)
  if brax.STOP == true then walklist = {} end
  if #walklist > 0 then
    local spFudge = 1-(gmcp.Char.Vitals.sp/gmcp.Char.Vitals.maxsp)
    tempTimer(walkdelay+spFudge, function()
      speedwalktimer(walklist, walkdelay, show)
    end)
  end
end