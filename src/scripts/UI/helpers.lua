-------------------------------------------------
--         Put your Lua functions here.        --
--                                             --
-- Note that you can also use external scripts --
-------------------------------------------------
function aTimerEnd(spell)
  local timer = timer or ""
  if myCooldowns[spell] then 
    myCooldowns[spell] = nil
    demonnic.anitimer:destroy("cd"..spell)
  end 
  local tCooldowns = {}
  local tName = {}
  local pos = 0
  local timeLeft = 0
  for i,v in pairs(myCooldowns) do 
  if demonnic.anitimer.timers["cd"..i] then
    timeLeft = demonnic.anitimer.timers["cd"..i].current
    table.insert(tCooldowns,timeLeft)
    tName[timeLeft]=i
  end
  end
  table.sort(tCooldowns)
  for i,v in pairs(tCooldowns) do 
    demonnic.anitimer.timers["cd"..tName[v]].gauge:move(0,pos*25)
    pos = pos +1
  end
end

function toggleBox(uiElement)
  if uiElement.hidden == true then
    uiElement:show()
  else
    uiElement:hide()
  end
  do_Config()
end

function saveWindows()
  Adjustable.Container.saveAll()
  EleUI:saveSettings()
  cecho("<cyan>»»<reset>Layout Saved<cyan>««<reset>\n")
  saveProfile()
  saveMap()
end

function loadWindows()
  Adjustable.Container.loadAll()
  cecho("<cyan>»»<reset>Layout Restored<cyan>««<reset>\n")
end

function SecondsToClock(seconds)
  local seconds = tonumber(seconds)
  if seconds <= 0 then
    return "00:00";
  else
    hours = string.format("%02.f", math.floor(seconds/3600));
    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
    return mins..":"..secs
  end
end

function properCase(str)
  str = str or ""
  return string.gsub(" "..str, "%W%l", string.upper):sub(2)
end

function ui_Theme(theme)
  local adjLabelstyle
  adjLabelstyle = adjLabelstyle or [[
      background-color: rgba(0,0,0,100%);
      border: 4px double ]]..theme..[[;
      border-radius: 4px;]]
  adjLabelstyle = adjLabelstyle..[[ qproperty-alignment: 'AlignLeft | AlignTop';]]
--  adjLabelstyle = [[border: 6px solid transparent;border-image: url(C:/Users/tdk10/.config/mudlet/profiles/Brax/EleUI2/imgs/oga.png) round]]
  cont = cont or Geyser
  for  k,v in pairs(cont.windowList) do
    if v.type == "adjustablecontainer" then 
      v.adjLabel:setStyleSheet(adjLabelstyle)
    end
    Adjustable.Container.saveAll(v)
  end

end

function Geyser.Label:setCooldown(params)
    self.start = params.start or 0 --start value of stylesheet variable
    self.stop = params.stop or 1 -- stop value of stylesheet variable
    self.cval = params.start -- current value of stylesheet variable (dynamic)
    self.cdStyleSheet = params.styleSheet --stylesheet has %s in place of dynamic value
    self.framerate = params.framerate or 0.05 -- framerate as decimal: default 20fps
    self.cd_label = Geyser.Label:new({
        name = self.name_cd_label,
        x = 0,
        y = 0,
        height = '100%',
        width = '100%',
    }, self)
    self.cd_label:hide()
    
end

function Geyser.Label:startCooldown(time)
    self.time = time or 1
    self.increment = self.framerate / self.time
    self.cval = self.start
    self.cd_label:show()
    self.cd_label:setStyleSheet(string.format(self.cdStyleSheet, tostring(self.cval)))
    if self.cdtimer then killTimer(self.cdtimer) end

    self.cdtimer = tempTimer(self.framerate, function()
        self.cval = self.cval + self.increment 
--print(self.cval)
        if self.cval >= self.stop then
            self:stopCooldown()
        else
            self.cd_label:setStyleSheet(string.format(self.cdStyleSheet, tostring(self.cval)))
        end
    end,
    true --timer is repeating
    )
end

function Geyser.Label:stopCooldown()
    self.cval = self.start
    self.cd_label:setStyleSheet(string.format(self.cdStyleSheet, tostring(self.cval)))
    self.cd_label:hide()
    killTimer(self.cdtimer)
end

brax = brax or {}
brax.CDripple = [[
	background-color: qradialgradient(
		spread:pad, cx:0.5, cy:0.5, radius:%s, fx:0.5, fy:0.5, 
		stop:0.3 rgba(100, 100, 100, 180), 
		stop:0.6 rgba(100, 100, 100, 130), 
		stop:0.7 rgba(120, 120, 120, 0))
    ]]
brax.qconical = [[
  background-color: qconicalgradient(cx:0.5, cy:0.5, angle:90, stop:%s rgba(0, 0, 0, 200), stop:1 rgba(255, 255, 255, 0))]]


if not spairs then
  function spairs(tbl, order)
    local keys = table.keys(tbl)
    if order then
      table.sort(keys, function(a,b) return order(tbl, a, b) end)
    else
      table.sort(keys)
    end

    local i = 0
    return function()
      i = i + 1
      if keys[i] then
        return keys[i], tbl[keys[i]]
      end
    end
  end
end

function isNumber(n)
  if (type(n) == "string" and string.find(n,"^%d+%.?%d*$")) then
    return tonumber(n)
  else
    return n
  end
end


brax = brax or {}
brax.eleColours = brax.eleColours or {}
  brax.eleColours["RED"] = "#800000"
  brax.eleColours["YELLOW"] = "#808000"
  brax.eleColours["GREEN"] = "#008000"
  brax.eleColours["CYAN"] = "#008080"
  brax.eleColours["MAGENTA"] = "#800080"
  brax.eleColours["CERULEAN"] = "#0087af"
  brax.eleColours["SONICSILVER"] = "#767676"
  brax.eleColours["BLUELAGOON"] = "#005f87"
  brax.eleColours["DEYORK"] = "#87d787"
  brax.eleColours["CORAL"] = "#ff875f"
  brax.eleColours["HOTPINK"] = "#ff5faf"
  brax.eleColours["PALEMAGENTA"] = "#ff87d7"
  brax.eleColours["VIOLETBLUE"] = "#af5faf"
  brax.eleColours["MEDIUMSPRINGGREEN"] = "#00ffaf"
  brax.eleColours["JADE"] = "#00af5f"
  brax.eleColours["INCHWORM"] = "#afd700"
  brax.eleColours["SPRAY"] = "#87d7d7"
  brax.eleColours["FERN"] = "#5faf5f"
  brax.eleColours["WHISPER"] = "#eeeeee"
  brax.eleColours["INDIGO"] = "#5f00af"
  brax.eleColours["ROSYBROWN"] = "#af8787"
  brax.eleColours["MEDIUMAQUAMARINE"] = "#5fd7af"
  brax.eleColours["LIGHTSLATEBLUE"] = "#8787ff"
  brax.eleColours["BLUESTONE"] = "#005f5f"
  brax.eleColours["HALFBAKED"] = "#5f8787"
  brax.eleColours["SELAGO"] = "#ffd7ff"
  brax.eleColours["JAZZBERRYJAM"] = "#af005f"
  brax.eleColours["GREY"] = "#808080"
  brax.eleColours["SANDYBEACH"] = "#ffd7af"
  brax.eleColours["KOBI"] = "#d787af"
  brax.eleColours["COPPER"] = "#d7875f"
  brax.eleColours["PSYCHEDELICPURPLE"] = "#d700ff"
  brax.eleColours["COSMOS"] = "#ffd7d7"
  brax.eleColours["AQUAMARINE"] = "#87ffd7"
  brax.eleColours["SEAPINK"] = "#d78787"
  brax.eleColours["TROPICALRAINFOREST"] = "#00875f"
  brax.eleColours["BANDICOOT"] = "#87875f"
  brax.eleColours["BITTERSWEET"] = "#ff5f5f"
  brax.eleColours["REEF"] = "#d7ffaf"
  brax.eleColours["PRIMGREEN"] = "#87ff5f"
  brax.eleColours["POLOBLUE"] = "#87afd7"
  brax.eleColours["SULU"] = "#d7ff87"
  brax.eleColours["EQUATOR"] = "#d7af5f"
  brax.eleColours["HAVELOCKBLUE"] = "#5f87d7"
  brax.eleColours["MAYABLUE"] = "#87afff"
  brax.eleColours["DARKTURQUOISE"] = "#00d7d7"
  brax.eleColours["GOLDENGLOW"] = "#ffd787"
  brax.eleColours["GOLD"] = "#ffd700"
  brax.eleColours["MEDIUMWOOD"] = "#af875f"
  brax.eleColours["BRINKPINK"] = "#ff5f87"
  brax.eleColours["OLIVEGREEN"] = "#afaf5f"
  brax.eleColours["VISTABLUE"] = "#87d7af"
  brax.eleColours["DARKMAGENTA"] = "#870087"
  brax.eleColours["CHARTREUSE"] = "#87ff00"
  brax.eleColours["ROMAN"] = "#d75f5f"
  brax.eleColours["MAGICMINT"] = "#afffd7"
  brax.eleColours["LIGHTWOOD"] = "#875f5f"
  brax.eleColours["MATTERHORN"] = "#4e4e4e"
  brax.eleColours["NIGHTRIDER"] = "#303030"
  brax.eleColours["NERO"] = "#262626"
  brax.eleColours["MAROON"] = "#5f0000"
  brax.eleColours["OPAL"] = "#00d7af"
  brax.eleColours["OLIVEDRAB"] = "#5f8700"
  brax.eleColours["MAUVE"] = "#d7afff"
  brax.eleColours["SINBAD"] = "#afd7d7"
  brax.eleColours["PUREWHITE"] = "#ffffff"
  brax.eleColours["NOBEL"] = "#9e9e9e"
  brax.eleColours["SAFETYORANGE"] = "#ff5f00"
  brax.eleColours["COMET"] = "#5f5f87"
  brax.eleColours["FIJIGREEN"] = "#5f5f00"
  brax.eleColours["LASERLEMON"] = "#ffff5f"
  brax.eleColours["MINDARO"] = "#d7ff5f"
  brax.eleColours["MEDIUMORCHID"] = "#af5fd7"
  brax.eleColours["BLUE"] = "#0055ff"
  brax.eleColours["TRENDYPINK"] = "#875f87"
  brax.eleColours["FUCHSIA"] = "#ff00ff"
  brax.eleColours["PALATINATEPURPLE"] = "#5f005f"
  brax.eleColours["RAZZMATAZZ"] = "#ff005f"
  brax.eleColours["EGGPLANT"] = "#87005f"
  brax.eleColours["ECLIPSE"] = "#3a3a3a"
  brax.eleColours["DEEPGREY"] = "#121212"
  brax.eleColours["CORNFLOWERBLUE"] = "#5f87ff"
  brax.eleColours["ORANGE"] = "#ffaf00"
  brax.eleColours["ORCHID"] = "#d75fd7"
  brax.eleColours["LONDONHUE"] = "#af87af"
  brax.eleColours["MANTIS"] = "#87d75f"
  brax.eleColours["CELADON"] = "#afffaf"
  brax.eleColours["BABYBLUE"] = "#5fffff"
  brax.eleColours["DIMGREY"] = "#6c6c6c"
  brax.eleColours["MINTGREEN"] = "#afff87"
  brax.eleColours["DARKRED"] = "#870000"
  brax.eleColours["ZIGGURAT"] = "#87afaf"
  brax.eleColours["DEEPMAGENTA"] = "#d700d7"
  brax.eleColours["MANATEE"] = "#8787af"
  brax.eleColours["CHELSEACUCUMBER"] = "#87af5f"
  brax.eleColours["ELECTRICBLUE"] = "#87ffff"
  brax.eleColours["LIME"] = "#00ff00"
  brax.eleColours["PERSIANGREEN"] = "#00af87"
  brax.eleColours["CHRISTI"] = "#5faf00"
  brax.eleColours["SHALIMAR"] = "#ffffaf"
  brax.eleColours["DARKGOLDENROD"] = "#af8700"
  brax.eleColours["TAPESTRY"] = "#af5f87"
  brax.eleColours["MALACHITE"] = "#00d75f"
  brax.eleColours["HELIOTROPE"] = "#d787ff"
  brax.eleColours["FEIJOA"] = "#afd787"
  brax.eleColours["MALIBU"] = "#5fafd7"
  brax.eleColours["ZAMBEZI"] = "#585858"
  brax.eleColours["PLUM"] = "#d787d7"
  brax.eleColours["LAVENDERGREY"] = "#afafd7"
  brax.eleColours["PINKSWAN"] = "#b2b2b2"
  brax.eleColours["LIGHTGREY"] = "#d0d0d0"
  brax.eleColours["PALETURQUOISE"] = "#afffff"
  brax.eleColours["MEDIUMVIOLETRED"] = "#d70087"
  brax.eleColours["LIGHTSKYBLUE"] = "#87d7ff"
  brax.eleColours["CHARTREUSEYELLOW"] = "#d7ff00"
  brax.eleColours["SPRINGBUD"] = "#afff00"
  brax.eleColours["CITRUS"] = "#afaf00"
  brax.eleColours["PASTELGREEN"] = "#5fd75f"
  brax.eleColours["SANTA"] = "#d70000"
  brax.eleColours["RAJAH"] = "#ffaf5f"
  brax.eleColours["RICHBLUE"] = "#5f5faf"
  brax.eleColours["DARKVIOLET"] = "#af00d7"
  brax.eleColours["SILVER"] = "#c6c6c6"
  brax.eleColours["CANARY"] = "#ffff87"
  brax.eleColours["DARKORANGE"] = "#ff8700"
  brax.eleColours["TAWNY"] = "#d75f00"
  brax.eleColours["CESOIR"] = "#875faf"
  brax.eleColours["TACAO"] = "#ffaf87"
  brax.eleColours["TICKLEMEPINK"] = "#ff87af"
  brax.eleColours["DARKSEAGREEN"] = "#87af87"
  brax.eleColours["AQUA"] = "#00ffff"
  brax.eleColours["PIXIEGREEN"] = "#afd7af"
  brax.eleColours["NEWMIDNIGHTBLUE"] = "#0000af"
  brax.eleColours["CLEARSKIES"] = "#afd7ff"
  brax.eleColours["IRISBLUE"] = "#00afd7"
  brax.eleColours["PEAR"] = "#afff5f"
  brax.eleColours["MEDIUMPURPLE"] = "#af5fff"
  brax.eleColours["GAINSBORO"] = "#dadada"
  brax.eleColours["HOLLYWOODCERISE"] = "#ff00af"
  brax.eleColours["FOUNTAINBLUE"] = "#5fafaf"
  brax.eleColours["SPRINGGREEN"] = "#00ff87"
  brax.eleColours["QUARTZ"] = "#d7d7ff"
  brax.eleColours["ELECTRICPURPLE"] = "#af00ff"
  brax.eleColours["LIGHTCORAL"] = "#ff8787"
  brax.eleColours["BRIGHTTURQUOISE"] = "#00ffd7"
  brax.eleColours["LAVENDERROSE"] = "#ffafff"
  brax.eleColours["PORTAGE"] = "#8787d7"
  brax.eleColours["HOPBUSH"] = "#d75faf"
  brax.eleColours["LAVENDERPINK"] = "#ffafd7"
  brax.eleColours["SUNDOWN"] = "#ffafaf"
  brax.eleColours["TANGERINE"] = "#d78700"
  brax.eleColours["PERANO"] = "#afafff"
  brax.eleColours["DARKGRAY"] = "#a8a8a8"
  brax.eleColours["DEEPPINK"] = "#ff0087"
  brax.eleColours["DARKGREEN"] = "#00af00"
  brax.eleColours["TARA"] = "#d7ffd7"
  brax.eleColours["LIGHTCYAN"] = "#d7ffff"
  brax.eleColours["EMERALD"] = "#5fd787"
  brax.eleColours["NAVY"] = "#00005f"
  brax.eleColours["CHARCOAL"] = "#444444"
  brax.eleColours["MEDIUMBLUE"] = "#0000d7"
  brax.eleColours["DARKPINK"] = "#d75f87"
  brax.eleColours["HIPPIEGREEN"] = "#5f875f"
  brax.eleColours["FRENCHLILAC"] = "#d7afd7"
  brax.eleColours["LAWNGREEN"] = "#87d700"
  brax.eleColours["SUVAGREY"] = "#8a8a8a"
  brax.eleColours["MANZ"] = "#d7d75f"
  brax.eleColours["LIGHTGREEN"] = "#87ff87"
  brax.eleColours["GOLDENBROWN"] = "#af5f00"
  brax.eleColours["HOTMAGENTA"] = "#ff00d7"
  brax.eleColours["BILOBAFLOWER"] = "#af87ff"
  brax.eleColours["PURPLE"] = "#8700ff"
  brax.eleColours["DECO"] = "#d7d787"
  brax.eleColours["SHAMROCK"] = "#00d700"
  brax.eleColours["OLIVE"] = "#878700"
  brax.eleColours["DANDELION"] = "#ffd75f"
  brax.eleColours["NEONPINK"] = "#ff5fd7"
  brax.eleColours["CORALTREE"] = "#af5f5f"
  brax.eleColours["TURQUOISEBLUE"] = "#5fd7ff"
  brax.eleColours["DARKCYAN"] = "#008787"
  brax.eleColours["DENIM"] = "#005faf"
  brax.eleColours["CREAM"] = "#ffffd7"
  brax.eleColours["OYSTERPINK"] = "#d7afaf"
  brax.eleColours["CALICO"] = "#d7af87"
  brax.eleColours["AIRFORCEBLUE"] = "#5f87af"
  brax.eleColours["GAMBOGE"] = "#d7af00"
  brax.eleColours["NAVYBLUE"] = "#005fff"
  brax.eleColours["SILVERTREE"] = "#5faf87"
  brax.eleColours["ELECTRICINDIGO"] = "#8700ff"
  brax.eleColours["BIRDFLOWER"] = "#d7d700"
  brax.eleColours["PACIFICBLUE"] = "#0087d7"
  brax.eleColours["DARKBLUE"] = "#000087"
  brax.eleColours["FUCHSIAPINK"] = "#ff87ff"
  brax.eleColours["ORINOCO"] = "#d7d7af"
  brax.eleColours["SLATEBLUE"] = "#5f5fd7"
  brax.eleColours["AZURE"] = "#0087ff"
  brax.eleColours["NEUTRALGREEN"] = "#afaf87"
  brax.eleColours["PINKFLAMINGO"] = "#ff5fff"
  brax.eleColours["BRIGHTGREEN"] = "#5fff00"
  brax.eleColours["DEEPSKYBLUE"] = "#00d7ff"
  brax.eleColours["NEONBLUE"] = "#5f5fff"
  brax.eleColours["TOTALBLACK"] = "#000000"
  brax.eleColours["ORIGINALBLUE"] = "#000080"
  brax.eleColours["WHITE"] = "#c0c0c0"
  brax.eleColours["BLACK"] = "#808080"
  brax.eleColours["BOLDRED"] = "#ff0000"
  brax.eleColours["BOLDGREEN"] = "#00ff00"
  brax.eleColours["BOLDYELLOW"] = "#ffff00"
  brax.eleColours["BOLDBLUE"] = "#0000ff"
  brax.eleColours["BOLDMAGENTA"] = "#ff00ff"
  brax.eleColours["BOLDCYAN"] = "#00ffff"
  brax.eleColours["BOLDWHITE"] = "#ffffff"
  brax.eleColours["BOLDBLACK"] = "#000000"
  brax.eleColours["FULLBLUE"] = "#0000ff"
  brax.eleColours["RANGERGREEN"] = "#005f00"
  brax.eleColours["CALMBLUE"] = "#005fd7"
  brax.eleColours["ARBOREALGREEN"] = "#008700"
  brax.eleColours["LIGHTIRISBLUE"] = "#00afaf"
  brax.eleColours["BRIGHTSKYBLUE"] = "#00afff"
  brax.eleColours["CARIBBEANGREEN"] = "#00d787"
  brax.eleColours["MALACHITEGREEN"] = "#00ff5f"
  brax.eleColours["PIGMENTINDIGO"] = "#5f0087"
  brax.eleColours["PURPLEIRIS"] = "#5f00d7"
  brax.eleColours["BLUEVIOLET"] = "#5f00ff"
  brax.eleColours["TAUPE"] = "#5f5f5f"
  brax.eleColours["ICEBLUE"] = "#5fafff"
  brax.eleColours["ROSFARRENGREEN"] = "#5fd700"
  brax.eleColours["VIKINGBLUE"] = "#5fd7d7"
  brax.eleColours["SCREAMINGGREEN"] = "#5fff5f"
  brax.eleColours["TIDALGREEN"] = "#5fff87"
  brax.eleColours["MOSSGREEN"] = "#5fffaf"
  brax.eleColours["POWDERBLUE"] = "#5fffd7"
  brax.eleColours["MULBERRY"] = "#8700af"
  brax.eleColours["VIOLET"] = "#8700d7"
  brax.eleColours["BROWNCOAT"] = "#875f00"
  brax.eleColours["TANANITE"] = "#875fd7"
  brax.eleColours["AMETHYST"] = "#875fff"
  brax.eleColours["MIDGREY"] = "#878787"
  brax.eleColours["CAMOFLAGEGREEN"] = "#87af00"
  brax.eleColours["SPROUT"] = "#87ffaf"
  brax.eleColours["SCARLET"] = "#af0000"
  brax.eleColours["FLIRTYVIOLET"] = "#af0087"
  brax.eleColours["VIOLETRED"] = "#af00af"
  brax.eleColours["LAVENDER"] = "#af87d7"
  brax.eleColours["BASEGREY"] = "#afafaf"
  brax.eleColours["CONIFER"] = "#afd75f"
  brax.eleColours["CRIMSON"] = "#d7005f"
  brax.eleColours["CERISE"] = "#d700af"
  brax.eleColours["WILDERBERRY"] = "#d75fff"
  brax.eleColours["GAINSBOROGREY"] = "#d7d7d7"
  brax.eleColours["CHERRY"] = "#ff0000"
  brax.eleColours["SKYFIRE"] = "#ffff00"
  brax.eleColours["NEARBLACK"] = "#080808"
  brax.eleColours["DARKGREY"] = "#1c1c1c"
  brax.eleColours["PACHYDERMGREY"] = "#606060"
  brax.eleColours["STEELGREY"] = "#949494"
  brax.eleColours["CLOUDGREY"] = "#bcbcbc"
  brax.eleColours["OFFWHITE"] = "#e4e4e4"
  brax.eleColours["|r"] = "|r"

