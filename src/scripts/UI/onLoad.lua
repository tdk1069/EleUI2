eleMap = eleMap or {}
EleUI = EleUI or {}
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
  gmcp.Char.Attackers = gmcp.Char.Attackers or {}
  gmcp.Char.Attackers.Hunt = gmcp.Char.Attackers.Hunt or {}
  gmcp.Char.Attackers.Attack = gmcp.Char.Attackers.Attack or {}
  gmcp.Char.Target = gmcp.Char.Target or {}
  gmcp.Char.Target.Aggro = gmcp.Char.Target.Aggro or {}
    
  brax = brax or {}
  brax.loadSettings = EleUI:loadSettings()
    -- Starting delay for speedwalk
  brax.speedwalkDelay = brax.loadSettings.speedwalkDelay
    -- true will cause a audible sound to play when your name is mentioned, false wont
  brax.bell = brax.loadSettings.bell
    -- enables the All Tab in chat window
  brax.chatAllTab = brax.loadSettings.chatAllTab
  brax.AutoMapColour = brax.loadSettings.AutoMapColour
  brax.chatOnlyAll = false
  brax.name = brax.name or gmcp.Char.Status.fullname
  brax.level = brax.level or gmcp.Char.Status.level
  brax.map = brax.map or {}
  brax.map.mode = brax.map.mode or "read"
  brax.version = "Version: 1.86"
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
  setServerEncoding("UTF-8")

  local btnStyle = [[QLabel{ border-radius: 7px; background-color: rgba(0,0,140,100%);}QLabel::hover{ background-color: rgba(160,160,160,50%);}]]
  local adjStyle = [[border: 25px solid transparent;border-image: url(]] .. getMudletHomeDir() .. [[/EleUI2/imgs/UI_BG.png) round;padding-top:-20px;]]
  local containerTitleHex = "#A4A100"
  statBoxContainer =
    statBoxContainer or
    Adjustable.Container:new(
      {
        adjLabelstyle = adjStyle,
        buttonstyle = btnStyle,
        x = "0%",
        y = "71.4%",
        height = "19.5%",
        width = "12%",
        name = "statBoxContainer",
        titleText = "Vitals",
        titleTxtColor = containerTitleHex,
      }
    )
  statsBox =
    Geyser.Label:new(
      {name = "Stats", color = "black", x = 0, y = 0, width = "100%", height = "100%"},
      statBoxContainer
    )
  statsDetails =
    Geyser.Label:new(
      {name = "Details", color = "black", x = 0, y = "70", width = "100%", height = "40px"}, statsBox
    )
  statsBox:setStyleSheet([[background:rgba(0,0,0,0)]])
  statsDetails:setStyleSheet([[background:rgba(0,0,0,0)]])
  hpbar =
    Geyser.Gauge:new(
      {name = "hpbar", x = "0%", y = "5px", width = "100%", height = "20px"}, statsBox
    )
  statsDetails:setClickCallback("toggleXP")
  hpbar:setStyleSheet([[qproperty-alignment: 'AlignBottom';]])
  hpbar.front:setStyleSheet(
    [[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #f04141, stop: 0.1 #ef2929, stop: 0.49 #cc0000, stop: 0.5 #a40000, stop: 1 #cc0000);
      border-top: 1px black solid;
      border-left: 1px black solid;
      border-bottom: 1px black solid;
      border-radius: 7;
      padding: 3px;]]
  )
  hpbar.back:setStyleSheet(
    [[background-color: black;
      border-width: 1px;
      border-color: #f04141;
      border-style: solid;
      border-radius: 7;
      padding: 3px;]]
  )
  mpbar =
    Geyser.Gauge:new(
      {name = "mpbar", x = "0%", y = "26px", width = "100%", height = "20px"}, statsBox
    )
  mpbar.front:setStyleSheet(
    [[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #9841f0, stop: 0.1 #8c29f0, stop: 0.49 #6600cc, stop: 0.5 #5200a3, stop: 1 #6600cc);
      border-top: 1px black solid;
      border-left: 1px black solid;
      border-bottom: 1px black solid;
      border-radius: 7;
      padding: 3px;]]
  )
  mpbar.back:setStyleSheet(
    [[background-color: black;
      border-width: 1px;
      border-color: #9841f0;
      border-style: solid;
      border-radius: 7;
      padding: 3px;]]
  )
  spbar =
    Geyser.Gauge:new(
      {name = "spbar", x = "0%", y = "48px", width = "100%", height = "20px"}, statsBox
    )
  spbar.front:setStyleSheet(
    [[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #98f041, stop: 0.1 #8cf029, stop: 0.49 #66cc00, stop: 0.5 #52a300, stop: 1 #66cc00);
      border-top: 1px black solid;
      border-left: 1px black solid;
      border-bottom: 1px black solid;
      border-radius: 7;
      padding: 3px;]]
  )
  spbar.back:setStyleSheet(
    [[background-color: black;
      border-width: 1px;
      border-color: #98f041;
      border-style: solid;
      border-radius: 7;
      padding: 3px;]]
  )
  statBoxContainer:hide()
  buffBoxContainer =
    buffBoxContainer or
    Adjustable.Container:new(
      {
        adjLabelstyle = adjStyle,
        buttonstyle = btnStyle,
        x = "7.5%",
        y = "30.48%",
        height = "26.5%",
        width = "7.5%",
        name = "buffBoxContainer",
        titleText = "My (De)Buffs",
        titleTxtColor = containerTitleHex,
      }
    )
  buffBox =
    Geyser.Label:new(
      {name = "Buffs", color = "black", x = 0, y = 0, width = "100%", height = "100%"},
      buffBoxContainer
    )
  buffBox:setStyleSheet([[qproperty-alignment: 'AlignTop';]])
  buffBox:setStyleSheet([[background:rgba(0,0,0,0)]])
  bodyBoxContainer =
    bodyBoxContainer or
    Adjustable.Container:new(
      {
        adjLabelstyle = adjStyle,
        buttonstyle = btnStyle,
        name = "bodyBoxContainer",
        titleText = "Body Damage",
        x = "0%",
        y = "0%",
        width = "15%",
        height = "27%",
        titleTxtColor = containerTitleHex,
      }
    )
  bodyBox =
    Geyser.Label:new(
      {name = "Body", color = "black", x = 0, y = 0, width = "100%", height = "100%"},
      bodyBoxContainer
    )
  bodyBox:setStyleSheet([[qproperty-alignment: 'AlignTop';]])
  bodyBox:setStyleSheet([[background:rgba(0,0,0,0)]])
  cooldownBoxContainer =
    cooldownBoxContainer or
    Adjustable.Container:new(
      {
        adjLabelstyle = adjStyle,
        buttonstyle = btnStyle,
        x = "0%",
        y = "30.48%",
        height = "26.5%",
        width = "7.5%",
        name = "cooldownBoxContainer",
        titleText = "Cooldowns",
        titleTxtColor = containerTitleHex,
      }
    )
  cooldownBox =
    Geyser.Label:new(
      {name = "Cooldowns", color = "black", x = 0, y = 0, width = "100%", height = "100%"},
      cooldownBoxContainer
    )
  cooldownBox:setStyleSheet([[qproperty-alignment: 'AlignTop';]])
  cooldownBox:raise()
  cooldownBox:setStyleSheet([[background:rgba(0,0,0,0)]])
  mapBoxContainer =
    mapBoxContainer or
    Adjustable.Container:new(
      {
        adjLabelstyle = adjStyle,
        buttonstyle = btnStyle,
        x ="73.2%",
        y = "0%",
        width = "26.7%",
        height = "44%",
        name = "mapBoxContainer",
        titleText = "",
        titleTxtColor = containerTitleHex,
      }
    )
  worldMapIcon = Geyser.Label:new(
      {name = "worldMapIcon", color = "black", x = 10, y = 1, width = "20px", height = "20px"},
      mapBoxContainer.adjLabel
    )
  worldMapIcon:setStyleSheet([[background:rgba(0,0,0,0)]])
  worldMapIcon:echo("🗺")
  worldMapIcon:setClickCallback("worldMap")
  -- worldMapIcon
  chatBoxContainer =
    chatBoxContainer or
    Adjustable.Container:new(
      {
        adjLabelstyle = adjStyle,
        buttonstyle = btnStyle,
        x = "73.2%",
        y = "44%",
        width = "26.7%",
        height = "32%",
        name = "chatBoxContainer",
        titleText = "",
        titleTxtColor = containerTitleHex,
      }
    )
  local stylesheet =
    [[background-color: rgb(0,0,0,255); border-width: 1px; border-style: solid; border-color: gold; border-radius: 10px;]]
  local istylesheet =
    [[background-color: rgb(60,60,60,255); border-width: 1px; border-style: solid; border-color: gold; border-radius: 10px;]]
  local _stylesheet =
    [[
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
  local _istylesheet =
    [[
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
  local EMCO = require("EleUI2.EMCO")
  chatBox =
    EMCO:new(
      {
        x = "0",
        y = "0",
        width = "100%",
        height = "100%",
        gap = 2,
        allTab = brax.chatAllTab,
        allTabName = "All",
        consoles = {"All"},
        activeTabCSS = _stylesheet,
        inactiveTabCSS = _istylesheet,
      },
      chatBoxContainer
    )
  chatBox.tabBoxLabel:setStyleSheet([[background-color: rgba(0,0,0,0);]])
  chatBox:enableScrollbars()
  chatBox:enableBlink()
  castbarBoxContainer =
    castbarBoxContainer or
    Adjustable.Container:new(
      {
        adjLabelstyle = adjStyle,
        buttonstyle = btnStyle,
        x = "0%",
        y = "90.2%",
        height = "9.5%",
        width = "11.9%",
        name = "castbarBoxContainer",
        titleText = "Casting",
        titleTxtColor = containerTitleHex,
      }
    )
  partyContainer =
    partyContainer or
    Adjustable.Container:new(
      {
        adjLabelstyle = adjStyle,
        buttonstyle = btnStyle,
        x = "73.2%",
        y = "77%",
        width = "26.7%",
        height = "22%",
        name = "partyContainer",
        titleText = "Party",
        titleTxtColor = containerTitleHex,
      }
    )
  partyBox =
    Geyser.Label:new(
      {name = "Party", color = "black", x = 0, y = 0, width = "100%", height = "100%"},
      partyContainer
    )
  partyBox:setStyleSheet([[qproperty-alignment: 'AlignTop';]])
  partyBox:setStyleSheet([[background:rgba(0,0,0,0)]])
  -- Black's
  targetBoxContainer =
    targetBoxContainer or
    Adjustable.Container:new(
      {
        adjLabelstyle = adjStyle,
        buttonstyle = btnStyle,
        x = "0%",
        y = "52.5%",
        width = "15%",
        height = "20%",
        name = "targetBoxContainer",
        titleText = "Target Info",
        titleTxtColor = containerTitleHex,
      }
    )
  targetBar =
    targetBar or
    Geyser.Gauge:new(
      {name = "targetBar", x = "0%", y = "5px", width = "100%", height = "15px"}, targetBoxContainer
    )
  targetBox =
    targetBox or
    Geyser.Label:new(
      {name = "targetBox", color = "black", x = 0, y = "25px", width = "100%", height = "70%"},
      targetBoxContainer
    )
  targetBox:setStyleSheet([[qproperty-alignment: 'AlignTop';background-color:rgba(70,70,70,0%)]])

  Adjustable.Container.loadAll()
  echo("--------------------------------------")
  aggroBox()
  debuffWin()
  do_Config()
  uninstallPackage("generic_mapper")
  mudlet = mudlet or {};
  mudlet.mapper_script = true
  eleMap = eleMap or {}
  eleMap.mode = 0
  -- 1 = edit, 0=follow
  eleMap =
    Geyser.Mapper:new(
      {name = "eleMap", x = 0, y = 0, width = "100%", height = "100%"}, mapBoxContainer
    )
-- Check for update at launch
  GitUpdater({check = true})
end

function do_Config()
  local configCSS =
    [[QLabel{padding-left:25px;background:rgba(0,0,0,0);}QLabel::hover {background-image : url("]] ..
    getMudletHomeDir() ..
    [[/EleUI2/imgs/FF7Cursor.png"); background-repeat:no-repeat;};]]
  local btnStyle =
    [[QLabel{ border-radius: 7px; background-color: rgba(0,0,140,100%);}QLabel::hover{ background-color: rgba(160,160,160,50%);}]]
  local adjStyle = [[border: 25px solid transparent;border-image: url(]] .. getMudletHomeDir() .. [[/EleUI2/imgs/UI_BG.png) round;padding-top:-20px;]]
  local containerTitleHex = "#A4A100"
  configContainer =
    configContainer or
    Adjustable.Container:new(
      {
        adjLabelstyle = adjStyle,
        buttonstyle = btnStyle,
        name = "configContainer",
        titleText = "Config",
        titleTxtColor = containerTitleHex,
        width = "14%",
        height = "41.8%",
        x = "41%",
        y = "31.5%",
      }
    )
  configStats =
    configStats or
    Geyser.Label:new(
      {name = "configStats", color = "black", x = 0, y = 0, width = "100%", height = "20"},
      configContainer
    )
  configStats:setStyleSheet(configCSS)
  configStats:setClickCallback("toggleBox", statBoxContainer)
  local hiddenState = ""
  if (statBoxContainer.hidden == false) then
    hiddenState = "✔️"
  end
  configStats:echo("Stats Window " .. hiddenState)
  configBuffs =
    configBuffs or
    Geyser.Label:new(
      {name = "configBuffs", color = "black", x = 0, y = 20, width = "100%", height = "20"},
      configContainer
    )
  configBuffs:setStyleSheet(configCSS)
  configBuffs:setClickCallback("toggleBox", buffBoxContainer)
  local hiddenState = ""
  if (buffBoxContainer.hidden == false) then
    hiddenState = "✔️"
  end
  configBuffs:echo("Buffs/Debuffs Window " .. hiddenState)
  configBody =
    configBody or
    Geyser.Label:new(
      {name = "configBody", color = "black", x = 0, y = 40, width = "100%", height = "20"},
      configContainer
    )
  configBody:setStyleSheet(configCSS)
  configBody:setClickCallback("toggleBox", bodyBoxContainer)
  local hiddenState = ""
  if (bodyBoxContainer.hidden == false) then
    hiddenState = "✔️"
  end
  configBody:echo("Limb Damage Window " .. hiddenState)
  configCooldowns =
    configCooldowns or
    Geyser.Label:new(
      {name = "configCooldown", color = "black", x = 0, y = 60, width = "100%", height = "20"},
      configContainer
    )
  configCooldowns:setStyleSheet(configCSS)
  configCooldowns:setClickCallback("toggleBox", cooldownBoxContainer)
  local hiddenState = ""
  if (cooldownBoxContainer.hidden == false) then
    hiddenState = "✔️"
  end
  configCooldowns:echo("Cooldowns Window " .. hiddenState)
  chatCooldowns =
    chatCooldowns or
    Geyser.Label:new(
      {name = "chatCooldown", color = "black", x = 0, y = 80, width = "100%", height = "20"},
      configContainer
    )
  chatCooldowns:setStyleSheet(configCSS)
  chatCooldowns:setClickCallback("toggleBox", chatBoxContainer)
  local hiddenState = ""
  if (chatBoxContainer.hidden == false) then
    hiddenState = "✔️"
  end
  chatCooldowns:echo("Chat Window " .. hiddenState)
  configMap =
    configMap or
    Geyser.Label:new(
      {name = "configmap", color = "black", x = 0, y = 100, width = "100%", height = "20"},
      configContainer
    )
  configMap:setStyleSheet(configCSS)
  configMap:setClickCallback("toggleBox", mapBoxContainer)
  local hiddenState = ""
  if (mapBoxContainer.hidden == false) then
    hiddenState = "✔️"
  end
  configMap:echo("Map " .. hiddenState)
  configcastbar =
    configcastbar or
    Geyser.Label:new(
      {name = "configcastbar", color = "black", x = 0, y = 120, width = "100%", height = "20"},
      configContainer
    )
  configcastbar:setStyleSheet(configCSS)
  configcastbar:setClickCallback("toggleBox", castbarBoxContainer)
  local hiddenState = ""
  if (castbarBoxContainer.hidden == false) then
    hiddenState = "✔️"
  end
  configcastbar:echo("CastBar " .. hiddenState)
  partyInfo =
    partyInfo or
    Geyser.Label:new(
      {name = "partyInfo", color = "black", x = 0, y = 140, width = "100%", height = "20"},
      configContainer
    )
  partyInfo:setStyleSheet(configCSS)
  partyInfo:setClickCallback("toggleBox", partyContainer)
  local hiddenState = ""
  if (partyContainer.hidden == false) then
    hiddenState = "✔️"
  end
  partyInfo:echo("Party Info " .. hiddenState)
  targetInfo =
    targetInfo or
    Geyser.Label:new(
      {name = "targetInfo", color = "black", x = 0, y = 160, width = "100%", height = "20"},
      configContainer
    )
  targetInfo:setStyleSheet(configCSS)
  targetInfo:setClickCallback("toggleBox", targetBoxContainer)

  aggroConfig =
    aggroConfig or
    Geyser.Label:new(
      {name = "aggroConfig", color = "black", x = 0, y = 180, width = "100%", height = "20"},
      configContainer
    )
  aggroConfig:setStyleSheet(configCSS)
  aggroConfig:setClickCallback("toggleBox", aggroContainer)


  local hiddenState = ""
  if (targetBoxContainer.hidden == false) then
    hiddenState = "✔️"
  end
  targetInfo:echo("Target Info " .. hiddenState)

  local hiddenState = ""
  if (aggroContainer.hidden == false) then
    hiddenState = "✔️"
  end
  aggroConfig:echo("Aggro " .. hiddenState)
  
  partyInfo =
    partyInfo or
    Geyser.Label:new(
      {name = "partyInfo", color = "black", x = 0, y = 140, width = "100%", height = "20"},
      configContainer
    )
  partyInfo:setStyleSheet(configCSS)
  partyInfo:setClickCallback("toggleBox", partyContainer)

  debuffsConfig =
    debuffsConfig or
    Geyser.Label:new(
      {name = "debuffsConfig", color = "black", x = 0, y = 200, width = "100%", height = "20"},
      configContainer
    )
  debuffsConfig:setStyleSheet(configCSS)
  debuffsConfig:setClickCallback("toggleBox", debuffBoxContainer)
  local hiddenState = ""
  if (debuffBoxContainer.hidden == false) then
    hiddenState = "✔️"
  end
  debuffsConfig:echo("Buffs/Debuffs Window " .. hiddenState)


  configSave =
    configSave or
    Geyser.Label:new(
      {name = "configSave", color = "black", x = 0, y = 220, width = "100%", height = "20"},
      configContainer
    )
  configSave:setStyleSheet(configCSS)
  configSave:setClickCallback("saveWindows")
  configSave:echo("Save Layout")
  configLoad =
    configLoad or
    Geyser.Label:new(
      {name = "configLoad", color = "black", x = 0, y = 240, width = "100%", height = "20"},
      configContainer
    )
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
    get_Ready()
    for k, v in pairs(Geyser.windowList) do
      if v.type == "adjustablecontainer" then
        v:hide()
      end
    end
    bodyBoxContainer:show()
    bodyBoxContainer:attachToBorder("left")
    cooldownBoxContainer:show()
    buffBoxContainer:show()
    targetBoxContainer:show()
    statBoxContainer:show()
    mapBoxContainer:show()
    mapBoxContainer:attachToBorder("right")
    chatBoxContainer:show()
    partyContainer:show()
    debuffBoxContainer:hide()
    setWindowWrap("main",81)
    decho("<128,0,128>-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n")
    decho("ui help       - this page!\n")
    decho("ui save       - Saves current window layout!\n")
    decho("ui load       - Loads current window layout!\n")
    decho("ui config     - Displays the UI Config window!\n")
    decho("ui routes     - Show speedwalk menu\n")
    decho("ui routes <x> - Speedwalk to destination\n")
    decho("ui stop       - Kills speedwalking instantly\n")
    decho("ui mapmode    - Toggle Mapmode (Follow/Simple/Full) Current:"..brax.map.mode.."\n")
    decho("ui startmap   - Will Set mapmode to full, and create first room based on current location\n")
    decho("ui exitcmd    - Takes two commands, dir and command ie 'ui exitcmd ne open gate'\n")
    decho("              -  Used in speedwalking routes to auto open doors/gates etc\n")
    decho("ui note <x>   - Display any custom notes for current room\n")
    decho("ui clearnote  - Check for updates\n")
    decho("ui update     - Check for updates\n")
    decho("                UI "..brax.version.."\n")
    decho("<128,0,128>-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n")  end
    toggleBox(configContainer)
end

function getName()
  brax.name = gmcp.Char.Status.fullname
end

function getLevel()
  brax.level = gmcp.Char.Status.level
  if brax.name and brax.level then
    setDiscordDetail(brax.name .. " (" .. brax.level .. ")")
  end
end


registerAnonymousEventHandler("sysLoadEvent", "get_Ready")
registerAnonymousEventHandler("sysInstallPackage", "first_Install")
registerAnonymousEventHandler("gmcp.Char.Status.level", "getLevel")
registerAnonymousEventHandler("gmcp.Char.Status.fullname", "getName")