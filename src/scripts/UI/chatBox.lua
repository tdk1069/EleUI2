function incoming_tell()
  local tab = "Tell"
  local chat_msg = gmcp.Msg.Tell.msg
  local from = gmcp.Msg.Tell.from
  local to = gmcp.Msg.Tell.to
  if brax.chatOnlyAll then
    tab = "All"
  end
  if not table.contains(chatBox.consoles, tab) then
    chatBox:addTab(tab)
  end
  chatBox:cecho(tab, "<red>" .. from .. "<reset> > <red>" .. to .. "<reset>: " .. chat_msg .. "\n")
  if brax.bell then
    playSoundFile(getMudletHomeDir() .. [[/EleUI2/snd/FFXIV_Incoming_Tell_3.mp3]])
  end
  raiseEvent("EleUI.newTell")
end

function incoming_channel()
  local tab = gmcp.Msg.Chat.channel:gsub("%%^.-%%^", "")
  local chat_msg = gmcp.Msg.Chat.msg or ""
  local chat_who = gmcp.Msg.Chat.who or ""
  local ansicol =
    string.upper(
      string.match(
        gmcp.Msg.Chat.colour:gsub("%%^BOLD%%^", ""):gsub("%%^RESET%%^", ""), "^%%%^\(%a+)"
      ) or
      "|r"
    )
  ansicol = brax.eleColours[ansicol] or "#800080"
  if tab == "Party" then
    tab =
      string.match(string.match(gmcp.Msg.Chat.rawmsg .. " ", "%[(.-)]") .. " ", "(.-) ") or "Party"
  end
  local boxMsg
  if brax.chatOnlyAll then
    tab = "All"
  end
  if not table.contains(chatBox.consoles, tab) then
    chatBox:addTab(tab)
  end
  if gmcp.Msg.Chat.emote == 1 then
    boxMsg =
      ansicol ..
      "[" ..
      tab ..
      "]|r" ..
      chat_who ..
      " " ..
      chat_msg:gsub("%%^.-%%^", ""):gsub("^%[.-%] ", "") ..
      "\n"
  elseif gmcp.Msg.Chat.emote == 2 then
    boxMsg =
      ansicol ..
      "[" ..
      tab ..
      "]|r" ..
      " " ..
      chat_msg:gsub("%%^.-%%^", ""):gsub("^%[.-%] ", "") ..
      "\n"
  else
    if string.lower(chat_msg):find(string.lower(gmcp.Char.Status.name)) and brax.bell then
      playSoundFile(getMudletHomeDir() .. [[/EleUI2/snd/FFXIV_Incoming_Tell_3.mp3]])
    end
    boxMsg =
      ansicol ..
      "[" ..
      tab ..
      chat_who ..
      "]|r " ..
      chat_msg:gsub("%%^.-%%^", ""):gsub("^%[.-%] ", "") ..
      "\n"
  end
  if table.contains({"_Ip"}, tab) then
    deleteLine()
  end
  chatBox:hecho(tab, boxMsg)
  raiseEvent("EleUI.newChannel")
end

function removeTab(tab)
  if table.contains(chatBox.consoles, tab) then
    chatBox:clear(tab)
    chatBox:removeTab(tab)
  end
end

brax = brax or {}
brax.lineEvent = registerAnonymousEventHandler("gmcp.Msg.Chat", "incoming_channel")
brax.tellEvent = registerAnonymousEventHandler("gmcp.Msg.Tell", "incoming_tell")
