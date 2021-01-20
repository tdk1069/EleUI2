function incoming_tell()
  local tab = "Tell"
  local chat_msg = gmcp.Msg.Tell.msg
  local from = gmcp.Msg.Tell.from
  local to = gmcp.Msg.Tell.to
  if brax.chatOnlyAll then
    tab = "All"
  end
  if not table.contains(chatBox.consoles,tab) then
    chatBox:addTab(tab)
  end
  chatBox:cecho(tab,"<red>"..from.."<reset> > <red>"..to.."<reset>: "..chat_msg.."\n")
  if brax.bell then playSoundFile(getMudletHomeDir()..[[/EleUI2/snd/FFXIV_Incoming_Tell_3.mp3]]) end
  raiseEvent("EleUI.newTell")
end

function incoming_channel()
  local tab = gmcp.Msg.Chat.channel:gsub("%%^.-%%^","")
  local chat_msg = gmcp.Msg.Chat.msg or ""
  local chat_who = gmcp.Msg.Chat.who or ""
  local ansicol = "<"..string.lower(string.match(gmcp.Msg.Chat.rawmsg:gsub("%%^BOLD%%^",""),"^%%%^\(%a+)"))..">"
  local boxMsg
  if brax.chatOnlyAll then
    tab = "All"
  end
  if not table.contains(chatBox.consoles,tab) then
    chatBox:addTab(tab)
  end
  if gmcp.Msg.Chat.emote > 1 then
    chat_msg = chat_msg:match("%w*(.*)")
    boxMsg = ansicol.."["..tab.."]<reset>"..chat_who..""..chat_msg:gsub("%%^.-%%^","").."\n"
  else
    if string.lower(chat_msg):find(string.lower(gmcp.Char.Status.name)) and brax.bell then 
    playSoundFile(getMudletHomeDir()..[[/EleUI2/snd/FFXIV_Incoming_Tell_3.mp3]]) 
    end
    boxMsg = ansicol.."["..tab..chat_who.."]<reset> "..chat_msg:gsub("%%^.-%%^","").."\n"
  end
  if table.contains({"_Ip"},tab) then
    deleteLine()
  end
  chatBox:cecho(tab,boxMsg)
  raiseEvent("EleUI.newChannel")
end

registerAnonymousEventHandler("gmcp.Msg.Chat", "incoming_channel")
registerAnonymousEventHandler("gmcp.Msg.Tell", "incoming_tell")
