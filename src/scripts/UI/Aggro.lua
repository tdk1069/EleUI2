function aggroBox()
  local btnStyle = [[QLabel{ border-radius: 7px; background-color: rgba(0,0,140,100%);}QLabel::hover{ background-color: rgba(160,160,160,50%);}]]
  local adjStyle = [[border: 25px solid transparent;border-image: url(]] .. getMudletHomeDir() .. [[/EleUI2/imgs/UI_BG.png) round;padding-top:-20px;]]
  local containerTitleHex = "#A4A100"
  local sortBox = require("EleUI2.sortbox")
  local timerGauge = require("EleUI2.timergauge")
  local _,dpiHeight = calcFontSize(8)
  local _,dpiGap = calcFontSize(10)

  
  local aggroTable = gmcp.Char.Target.Aggro or {}
  local tank = nil
  
  local frontCSS =
  [[
  border-style: outset;
  border-color: gray;
  border-width: 1px;
  border-radius: 4px;
  margin: 0px;
  padding: 0px;
  ]]
--  background-color: #1f6140;

  local backCSS = 
  [[
  border-style: outset;
  border-color: gray;
  border-width: 1px;
  border-radius: 4px;
  margin: 0px;
  padding: 0px;
  background-color: black;
  ]]

local barCol = "background-color: #1f6140;"

  aggroContainer =
    aggroContainer or
    eleFrame:new(
      {
        adjLabelstyle = adjStyle,
        buttonstyle = btnStyle,
        x = "0%",
        y = "20.0%",
        height = "28%",
        width = "12%",
        name = "aggroBox",
        titleText = "Threat",
        titleTxtColor = containerTitleHex,
      }
    )
    aggroWindow = aggroWindow or 
      sortBox:new(
        {
          name = "Aggro",
          x = 0,
          y = 0,
          height = "100%",
          width = "100%",
          sortFunction = "reverseGaugeValue",
        },
        aggroContainer
      )

  brax.target.aggro = brax.target.aggro or {}
  for who,threat in spairs(aggroTable) do
    brax.target.aggro[who] = brax.target.aggro[who] or Geyser.Gauge:new({
      name=who,
      x="0",
      width="100%",
      height=dpiHeight,
      active = true,
      autoHide = true,
      manageContainer = true,
      v_policy = Geyser.Fixed,
    },aggroWindow)
    tank = who
    if threat < 100 then
     barCol = "background-color: #1f6140;"
    elseif threat == 100 then
      barCol = [[background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #f04141, stop: 0.1 #ef2929, stop: 0.49 #cc0000, stop: 0.5 #a40000, stop: 1 #cc0000);]]
    end
    if threat > 110 then threat = 110 end
    brax.target.aggro[who]:setValue(tonumber(threat),110,properCase(who)..":"..threat.."%")
    brax.target.aggro[who].front:setStyleSheet(frontCSS..barCol)
    brax.target.aggro[who].back:setStyleSheet(backCSS)
    brax.target.aggro[who].front:show()
    brax.target.aggro[who].back:show()
    brax.target.aggro[who].text:show()
    aggroWindow:raiseAll()
    aggroWindow:organize()
  end
--updatePartyFrame()
end

function clearAggroWindow()
  for who,_ in pairs(brax.target.aggro) do
    brax.target.aggro[who].front:hide()
    brax.target.aggro[who].back:hide()
    brax.target.aggro[who].text:hide()
  end
end

brax = brax or {}
brax.agBoxEvent = registerAnonymousEventHandler("gmcp.Char.Target.Aggro","aggroBox")

