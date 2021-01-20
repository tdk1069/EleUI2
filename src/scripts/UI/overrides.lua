function json_to_value(eledata)
--display(eledata)
if string.find(eledata,"^%d+%.?%d*$") then
    return tonumber(eledata)
  elseif eledata:sub(3,5) == "_msg" then
    msg = {string.match(eledata,'{\"(.-)\": \"(.-)\", \"(.-)\": \" ?(.-)\", \"(.-)\": \"(.-)\", \"(.-)\": \"(.-)\", \"(%a-)\": \"(.-)\"}')}
    return yajl.to_value((string.format("{\"%s\": %q, \"%s\": \"%s\", \"%s\": \"%s\", \"%s\": %q, \"%s\": \"%s\" }",msg[1],msg[2],msg[3],msg[4],msg[5],msg[6],msg[7],msg[8],msg[9],msg[10])))
  elseif eledata:sub(3,7) == "_emote" then
    local emote = string.match(eledata,'{\"emote\": (.-),') or ""
    local who = string.match(eledata,'\"who\": \" (.-)\"') or "??"
    local channel = string.match(eledata,'\"channel\": \"(.-)\"') or ""
    local msg = string.match(eledata,'\"msg\": \"(.-)\", \"rawmsg')
    local rawmsg = string.match(eledata,'\"rawmsg\": \"(.-)\"}')
    local cleanraw = string.match(eledata:gsub("%%^.-%%^",""),'\"rawmsg\": .-] (.-)\"}') or ""
    return(yajl.to_value(string.format("{\"emote\": %d, \"who\": \"%s\", \"channel\": \"%s\", \"msg\": %q, \"rawmsg\": %q }",emote,who,channel,msg or cleanraw,rawmsg)))
  else
    return yajl.to_value(eledata)
  end
end


function speedwalktimer(walklist, walkdelay, show)
speedwalkDIR = walklist[1]
  if getDoors(eleMap.currentRoom)[walklist[1]] then 
    send(getRoomUserData(eleMap.currentRoom,"Exit_"..walklist[1])) 
  end
  send(walklist[1], show)
  table.remove(walklist, 1)
  if brax.STOP == true then walklist = {} end
  if #walklist > 0 then
    local spFudge = 1-(gmcp.Char.Vitals.sp/gmcp.Char.Vitals.maxsp)
    if spFudge>0.95 then spFudge = spFudge + 0.3 end  
    tempTimer(walkdelay+spFudge, function()
    speedwalktimer(walklist, walkdelay, show)
    end)
  end
end