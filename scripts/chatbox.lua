function incoming_tell()
  local tab = "Tell"
  local chat_msg = gmcp.Msg.Tell.msg
  local from = gmcp.Msg.Tell.from
  if not table.contains(chatBox.consoles,tab) then
    chatBox:addTab(tab)
  end
  chatBox:cecho(tab,"<red>"..from..":<reset> "..chat_msg.."\n")
end

function incoming_channel()
  local tab = gmcp.Msg.Chat.channel
  local chat_msg = gmcp.Msg.Chat.msg
  local chat_who = gmcp.Msg.Chat.who
  local ansicol = "<"..string.lower(string.match(gmcp.Msg.Chat.rawmsg,"^%%%^\(%a+)"))..">"
  local boxMsg
  if not table.contains(chatBox.consoles,tab) then
    chatBox:addTab(tab)
  end
  if gmcp.Msg.Chat.emote > 1 then
    chat_msg = chat_msg:match("%w*(.*)")
    boxMsg = ansicol.."["..chat_who.."]<reset>"..chat_msg:gsub("%%^.-%%^","").."\n"
  else
    boxMsg = ansicol.."["..chat_who.."]<reset> "..chat_msg:gsub("%%^.-%%^","").."\n"
  end
  chatBox:cecho(tab,boxMsg)
end

registerAnonymousEventHandler("gmcp.Msg.Chat", "incoming_channel")
registerAnonymousEventHandler("gmcp.Msg.Tell", "incoming_tell")
