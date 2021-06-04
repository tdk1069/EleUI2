-- addDebuff("Name to appear on timer",How long to run)
function debuffWin()
  local btnStyle = [[QLabel{ border-radius: 7px; background-color: rgba(0,0,140,100%);}QLabel::hover{ background-color: rgba(160,160,160,50%);}]]
  local adjStyle = [[border: 25px solid transparent;border-image: url(]] .. getMudletHomeDir() .. [[/EleUI2/imgs/UI_BG.png) round;padding-top:-20px;]]
  local containerTitleHex = "#A4A100"

    local sortBox = require("EleUI2.sortbox")
    debuffBoxContainer =
      debuffBoxContainer or
      Adjustable.Container:new(
        {
          adjLabelstyle = adjStyle,
          buttonstyle = btnStyle,
          x = "64.6%",
          y = "71.5%",
          height = "26.5%",
          width = "7.5%",
          name = "debuffBoxContainer",
          titleText = "Target (De)Buffs",
          titleTxtColor = containerTitleHex,
        }
      )
    debuffBox =
      sortBox:new(
        {
          name = "Debuffs",
          x = 0,
          y = 0,
          height = "100%",
          width = "100%",
          sortFunction = "gaugeValue",
          timerSort = true,
          sortInterval = 50,
          autoSort = true,
        },
        debuffBoxContainer
      )

end
function addDebuff(debuff,time)
  brax = brax or {}
  brax.target = brax.target or {}
  brax.target.debuffs = brax.target.debuffs or {}
  local timerGauge = require("EleUI2.timergauge")
  local frontCSS =  [[
    border-style: outset;
    border-color: gray;
    border-width: 1px;
    border-radius: 4px;
    margin: 0px;
    padding: 0px;
    background-color: #1f6140;
  ]]

  if brax.target.debuffs[debuff] then
    brax.target.debuffs[debuff]:setTime(tonumber(time))
    brax.target.debuffs[debuff]:restart()
    brax.target.debuffs[debuff]:show2()
    brax.target.debuffs[debuff]:raiseAll()
  else
    brax.target.debuffs[debuff] = timerGauge:new({
    name = debuff,
    x=0,
    height = 20,
    width = "100%",
    time = tonumber(time),
    showTimer = true,
    timerCaption = " "..debuff,
    cssFront = frontCSS,
    cssBack = myCss1,
    cssText = baseCss,
    active = true,
    autoHide = true,
    manageContainer = true,
    v_policy = Geyser.Fixed,
    },debuffBox)
    brax.target.debuffs[debuff]:show()
    brax.target.debuffs[debuff]:raise()
  end
  debuffBox:raiseAll()
  debuffBox:organize()
end

function clearDebuffs()
  if type(brax.target.debuffs) == "nil" then return end
 for _,spell in pairs(table.keys(brax.target.debuffs)) do
  brax.target.debuffs[spell]:stop(true)
 end
end

function doDebuffEvent()
  --display(gmcp.Char.Target.Buffs)
  for spell, dur in pairs(gmcp.Char.Target.Buffs) do
    addDebuff(spell,dur[1])
    brax.target.debuffs[spell].text:setToolTip(dur[2])
    debuffBox:organize()
  end
  debuffBox:organize()
end

brax = brax or {}
brax.targetBuffEvent = registerAnonymousEventHandler("gmcp.Char.Target.Buffs","doDebuffEvent")
