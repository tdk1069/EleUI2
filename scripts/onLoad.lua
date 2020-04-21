function get_Ready()
  print(":: Getting stuff ready....")
  gmcp = gmcp or {}
  gmcp.Char = gmcp.Char or {}
  gmcp.Char.Vitals = gmcp.Char.Vitals or {}
  gmcp.Char.Vitals.hp = gmcp.Char.Vitals.hp or 0
  gmcp.Char.Vitals.mp = gmcp.Char.Vitals.mp or 0
  gmcp.Char.Vitals.sp = gmcp.Char.Vitals.sp or 0
  gmcp.Char.Vitals.maxhp = gmcp.Char.Vitals.maxhp or 1
  gmcp.Char.Vitals.maxmp = gmcp.Char.Vitals.maxmp or 1
  gmcp.Char.Vitals.maxsp = gmcp.Char.Vitals.maxsp or 1
  gmcp.Char.Status = gmcp.Char.Status or {}
  gmcp.Char.Status.class = gmcp.Char.Status.class or {}
  
  brax = brax or {}
  brax.name = brax.name or gmcp.Char.Status.fullname
  brax.level = brax.level or gmcp.Char.Status.level
  brax.map = brax.map or {}
  brax.map.mode = brax.map.mode or "read"
  brax.version = "Version: 1.54"
  brax.xp = brax.xp or 0
  brax.class = brax.class or {}
  brax.class.prime = brax.class.prime or ""
  brax.class.second = brax.class.second or ""
  brax.party = brax.party or {}
  brax.party.Members = brax.party.Members or {}
  brax.party.Vitals = brax.party.Vitals or {}
  brax.items = brax.items or {}
  brax.target = brax.target or {}  
  brax.hotbar = brax.hotbar or {}
  setDiscordApplicationID("689229426529140740")
  setDiscordLargeIcon("server-icon")
  setDiscordLargeIconText("Elephant MUD")
  setDiscordElapsedStartTime(os.time(os.date("*t")))
--  setDiscordDetail(brax.name.." ("..brax.level..")")

statBoxContainer = statBoxContainer or Adjustable.Container:new({x=10,y=10,name="statBoxContainer",titleText="Vitals"})
  statsBox = Geyser.Label:new({name = "Stats", color = "black", x = 0, y = 0, width = "100%", height = "100%"},statBoxContainer)
  statsDetails = Geyser.Label:new({name = "Details", color = "black", x = 0, y = 125, width = "100%", height = "40px"},statsBox)  
  hpbar = Geyser.Gauge:new({name="hpbar",x="0%", y="5px",width="100%", height="39px"},statsBox)
  statsDetails:setClickCallback("toggleXP")
  hpbar:setStyleSheet([[qproperty-alignment: 'AlignBottom';]])
  hpbar.front:setStyleSheet([[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #f04141, stop: 0.1 #ef2929, stop: 0.49 #cc0000, stop: 0.5 #a40000, stop: 1 #cc0000);
      border-top: 1px black solid;
      border-left: 1px black solid;
      border-bottom: 1px black solid;
      border-radius: 7;
      padding: 3px;]])
  hpbar.back:setStyleSheet([[background-color: black;
      border-width: 1px;
      border-color: #f04141;
      border-style: solid;
      border-radius: 7;
      padding: 3px;]])
  mpbar = Geyser.Gauge:new({name="mpbar",x="0%", y="45px",width="100%", height="35px"},statsBox)
  mpbar.front:setStyleSheet([[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #9841f0, stop: 0.1 #8c29f0, stop: 0.49 #6600cc, stop: 0.5 #5200a3, stop: 1 #6600cc);
      border-top: 1px black solid;
      border-left: 1px black solid;
      border-bottom: 1px black solid;
      border-radius: 7;
      padding: 3px;]])
  mpbar.back:setStyleSheet([[background-color: black;
      border-width: 1px;
      border-color: #9841f0;
      border-style: solid;
      border-radius: 7;
      padding: 3px;]])
  spbar = Geyser.Gauge:new({name="spbar",x="0%", y="85px",width="100%", height="35px"},statsBox)
  spbar.front:setStyleSheet([[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #98f041, stop: 0.1 #8cf029, stop: 0.49 #66cc00, stop: 0.5 #52a300, stop: 1 #66cc00);
      border-top: 1px black solid;
      border-left: 1px black solid;
      border-bottom: 1px black solid;
      border-radius: 7;
      padding: 3px;]])
  spbar.back:setStyleSheet([[background-color: black;
      border-width: 1px;
      border-color: #98f041;
      border-style: solid;
      border-radius: 7;
      padding: 3px;]])
statBoxContainer:hide()

buffBoxContainer = buffBoxContainer or Adjustable.Container:new({x=20,y=20,name="buffBoxContainer",titleText="Buffs / Debuffs Status"})
  buffBox = Geyser.Label:new({name = "Buffs", color = "black", x = 0, y = 0, width = "100%", height = "100%"},buffBoxContainer)
  buffBox:setStyleSheet([[qproperty-alignment: 'AlignTop';]])
buffBoxContainer:hide()

bodyBoxContainer = bodyBoxContainer or Adjustable.Container:new({name="bodyBoxContainer",titleText="Body Damage"})
  bodyBox = Geyser.Label:new({name = "Body", color = "black", x = 0, y = 0, width = "100%", height = "100%"},bodyBoxContainer)
  bodyBox:setStyleSheet([[qproperty-alignment: 'AlignTop';]])
bodyBoxContainer:hide()

cooldownBoxContainer = cooldownBoxContainer or Adjustable.Container:new({x=30,y=30,name="cooldownBoxContainer",titleText="Outstanding Cooldowns"})
  cooldownBox = Geyser.Label:new({name = "Cooldowns", color = "black", x = 0, y = 0, width = "100%", height = "100%"},cooldownBoxContainer)
  cooldownBox:setStyleSheet([[qproperty-alignment: 'AlignTop';]])
cooldownBoxContainer:hide()

mapBoxContainer = mapBoxContainer or Adjustable.Container:new({x=40,y=40,name="mapBoxContainer",titleText="You Are Here!"})
mapBoxContainer:hide()

chatBoxContainer = chatBoxContainer or Adjustable.Container:new({x=50,y=50,name="chatBoxContainer",titleText="Chat"})
  local stylesheet = [[background-color: rgb(0,0,0,255); border-width: 1px; border-style: solid; border-color: gold; border-radius: 10px;]]
  local istylesheet = [[background-color: rgb(60,60,60,255); border-width: 1px; border-style: solid; border-color: gold; border-radius: 10px;]]
  local _stylesheet = [[
        QLabel{
				background-color: #4d0000;
				border-style: outset;
        border-width: 2px;
        border-color: "#996600";
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        margin-right: 1px;
        margin-left: 1px;
        qproperty-alignment: 'AlignCenter | AlignCenter';
				}				
				QLabel::hover{
				background-color: #b30000;
				border-style: outset;
        border-width: 2px;
        border-color: "#996600";
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        margin-right: 1px;
        margin-left: 1px;
        qproperty-alignment: 'AlignCenter | AlignCenter';
				}				
				]]
  local _istylesheet = [[
        QLabel{
				background-color: #b30000;
				border-style: outset;
        border-width: 2px;
        border-color: "#996600";
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        margin-right: 1px;
        margin-left: 1px;
        qproperty-alignment: 'AlignCenter | AlignCenter';
				}				
				QLabel::hover{
				background-color: #b30000;
				border-style: outset;
        border-width: 2px;
        border-color: "#996600";
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        margin-right: 1px;
        margin-left: 1px;
        qproperty-alignment: 'AlignCenter | AlignCenter';
				]]

  chatBox = EMCO:new({ x = "0", y = "0", width = "100%", height = "100%", gap = 2, consoles = {"Tell"},activeTabCSS = _stylesheet, inactiveTabCSS = _istylesheet},chatBoxContainer)
  chatBox:enableScrollbars()
  chatBox:enableBlink()
chatBoxContainer:hide()
  
castbarBoxContainer = castbarBoxContainer or Adjustable.Container:new({x=60,y=60,name="castbarBoxContainer",titleText="Casting"})
  castbarBox = Geyser.Label:new({name = "Casting", color = "black", x = 0, y = 0, width = "100%", height = "100%"},cooldownBoxContainer)
  castbarBox:setStyleSheet([[qproperty-alignment: 'AlignTop';]])
  castbarBoxContainer:resize(300,50)
castbarBoxContainer:hide()

partyContainer = partyContainer or Adjustable.Container:new({x=10,y=10,name="partyContainer",titleText="Party"})
  partyBox = Geyser.Label:new({name = "Party", color = "black", x = 0, y = 0, width = "100%", height = "100%"},partyContainer)

  do_Config()
-- 💾

Adjustable.Container.loadAll()

uninstallPackage("generic_mapper")
mudlet = mudlet or {}; mudlet.mapper_script = true
eleMap = eleMap or {}
eleMap.mode = 0 				-- 1 = edit, 0=follow

eleMap = Geyser.Mapper:new({
  name = "eleMap",
  x = 0, y = 0,
  width = "100%",
  height = "100%",
},mapBoxContainer)

end

function do_Config()
local configCSS = [[QLabel{padding-left:25px;}QLabel::hover {background-image : url("]]..getMudletHomeDir()..[[/EleUI2/imgs/FF7Cursor.png"); background-repeat:no-repeat;};]]
configContainer = configContainer or Adjustable.Container:new({name="configContainer",titleText="Config"})
  configStats = configStats or Geyser.Label:new({name = "configStats", color = "black", x = 0, y = 0, width = "100%", height = "20"},configContainer)
  configStats:setStyleSheet(configCSS)
  configStats:setClickCallback("toggleBox",statBoxContainer)
  local hiddenState = ""
  if (statBoxContainer.hidden == false) then hiddenState = "✔️" end
  configStats:echo("Stats Window "..hiddenState)

  configBuffs = configBuffs or Geyser.Label:new({name = "configBuffs", color = "black", x = 0, y = 20, width = "100%", height = "20"},configContainer)
  configBuffs:setStyleSheet(configCSS)
  configBuffs:setClickCallback("toggleBox",buffBoxContainer)
  local hiddenState = ""
  if (buffBoxContainer.hidden == false) then hiddenState = "✔️" end
  configBuffs:echo("Buffs/Debuffs Window "..hiddenState)

  configBody = configBody or Geyser.Label:new({name = "configBody", color = "black", x = 0, y = 40, width = "100%", height = "20"},configContainer)
  configBody:setStyleSheet(configCSS)
  configBody:setClickCallback("toggleBox",bodyBoxContainer)
  local hiddenState = ""
  if (bodyBoxContainer.hidden == false) then hiddenState = "✔️" end
  configBody:echo("Limb Damage Window "..hiddenState)

  configCooldowns = configCooldowns or Geyser.Label:new({name = "configCooldown", color = "black", x = 0, y = 60, width = "100%", height = "20"},configContainer)
  configCooldowns:setStyleSheet(configCSS)
  configCooldowns:setClickCallback("toggleBox",cooldownBoxContainer)
  local hiddenState = ""
  if (cooldownBoxContainer.hidden == false) then hiddenState = "✔️" end
  configCooldowns:echo("Cooldowns Window "..hiddenState)

  chatCooldowns = chatCooldowns or Geyser.Label:new({name = "chatCooldown", color = "black", x = 0, y = 80, width = "100%", height = "20"},configContainer)
  chatCooldowns:setStyleSheet(configCSS)
  chatCooldowns:setClickCallback("toggleBox",chatBoxContainer)
  local hiddenState = ""
  if (chatBoxContainer.hidden == false) then hiddenState = "✔️" end
  chatCooldowns:echo("Chat Window "..hiddenState)

  configMap = configMap or Geyser.Label:new({name = "configmap", color = "black", x = 0, y = 100, width = "100%", height = "20"},configContainer)
  configMap:setStyleSheet(configCSS)
  configMap:setClickCallback("toggleBox",mapBoxContainer)
  local hiddenState = ""
  if (mapBoxContainer.hidden == false) then hiddenState = "✔️" end
  configMap:echo("Map "..hiddenState)

  configcastbar = configcastbar or Geyser.Label:new({name = "configcastbar", color = "black", x = 0, y = 120, width = "100%", height = "20"},configContainer)
  configcastbar:setStyleSheet(configCSS)
  configcastbar:setClickCallback("toggleBox",castbarBoxContainer)
  local hiddenState = ""
  if (castbarBoxContainer.hidden == false) then hiddenState = "✔️" end
  configcastbar:echo("CastBar "..hiddenState)

  partyInfo = partyInfo or Geyser.Label:new({name = "partyInfo", color = "black", x = 0, y = 140, width = "100%", height = "20"},configContainer)
  partyInfo:setStyleSheet(configCSS)
  partyInfo:setClickCallback("toggleBox",partyContainer)
  local hiddenState = ""
  if (castbarBoxContainer.hidden == false) then hiddenState = "✔️" end
  partyInfo:echo("Party Info "..hiddenState)


  configSave = configSave or Geyser.Label:new({name = "configSave", color = "black", x = 0, y = 160, width = "100%", height = "20"},configContainer)
  configSave:setStyleSheet(configCSS)
  configSave:setClickCallback("saveWindows")
  configSave:echo("Save Layout")
  
  configLoad = configLoad or Geyser.Label:new({name = "configLoad", color = "black", x = 0, y = 180, width = "100%", height = "20"},configContainer)
  configLoad:setStyleSheet(configCSS)
  configLoad:setClickCallback("loadWindows")
  configLoad:echo("Load Layout")
end

map = {}
function map.eventHandler()
end

function first_Install(_, pkg)
  if pkg == "EleUI2" then
    uninstallPackage("generic_mapper")
--    mapper_Installed()
    cecho("<cyan>»»<reset>Ele Drag and Drop UI Installed<cyan>««<reset>\n")
    cecho("<cyan>»»<reset>Commands: <cyan>««<reset>\n")
    cecho("<cyan>»»<reset>ui config - shows config window<cyan>««<reset>\n")
    cecho("<cyan>»»<reset>ui installmap - Installs pre-filled map<cyan>««<reset>\n")
    get_Ready()
  for  k,v in pairs(Geyser.windowList) do
    if v.type == "adjustablecontainer" then 
      v:hide()
    end
  end
  end
end

function getName()
  brax.name = gmcp.Char.Status.fullname
end
function getLevel()
  brax.level = gmcp.Char.Status.level
  if brax.name and brax.level then
    setDiscordDetail(brax.name.." ("..brax.level..")")
  end
end

registerAnonymousEventHandler("sysLoadEvent", "get_Ready")
registerAnonymousEventHandler("sysInstallPackage", "first_Install")
registerAnonymousEventHandler("gmcp.Char.Status.level", "getLevel")
registerAnonymousEventHandler("gmcp.Char.Status.fullname", "getName")
