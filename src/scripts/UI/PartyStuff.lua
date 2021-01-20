function do_Party()
  if gmcp.Party.Members == {} then 
    brax.party.Members = {}
  else
--  display(gmcp.Party.Members)
    brax.party.Members = gmcp.Party.Members
  end
  if next(gmcp.Party.Members) == {} then brax.party.Members[next(gmcp.Party.Members)] = nil end
  getParty()
  --updatePartyFrame()
end

function do_Party_Vitals()
  brax.party.Vitals = table.update(brax.party.Vitals,gmcp.Party.Vitals)
  getParty()
  --updatePartyFrame()
end

function getParty()
  local details = "<table><tr><th align='left'></th><th align='left'>HP</th><th align='left'>MP</th><th align='left'>SP</th></tr>"
  for i,v in pairs(brax.party.Members) do 
    brax.party.Vitals[i] = brax.party.Vitals[i] or {}
    brax.party.Vitals[i].hp = brax.party.Vitals[i].hp or 0
    brax.party.Vitals[i].mp = brax.party.Vitals[i].mp or 0
    brax.party.Vitals[i].sp = brax.party.Vitals[i].sp or 0
    details = details.."<tr><td width='25%'>"..properCase(i).."</td><td width='25%'>"..colStat(brax.party.Vitals[i].hp).."</td><td width='25%'>"..colStat(brax.party.Vitals[i].mp).."</td><td width='25%'>"..colStat(brax.party.Vitals[i].sp).."</td></tr>"
  end
  partyBox:echo(details)
end

function colStat(value)
  local stat = math.floor(value*100)
  local colour = ""
  if stat < 33 then
    colour = "red"
  elseif stat < 66 then
    colour = "yellow"
  else
    colour = "lightgreen"
  end
  return "<span style='color:"..colour..";'>"..stat.."%</span>"
end

registerAnonymousEventHandler("gmcp.Party.Members","do_Party")
registerAnonymousEventHandler("gmcp.Party.Vitals","do_Party_Vitals")
