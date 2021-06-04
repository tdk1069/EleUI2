eleFrame = eleFrame or {}

function eleFrame:new(con,parent)
  local con = con or {}
  local padding_x,padding_y = calcFontSize(7)
  local minBar,_ = calcFontSize(15)
  local btnStyle = [[QLabel{ border-radius: ]]..padding_x..[[px; background-color: rgba(0,0,140,100%);}QLabel::hover{ background-color: rgba(160,160,160,50%);}]]
  local adjStyle = [[border: 25px solid transparent;border-image: url(]] .. getMudletHomeDir() .. [[/EleUI2/imgs/UI_BG.png) round;padding-top:-20px;]]
  local containerTitleHex = "#A4A100"
  local newFrame =
    Adjustable.Container:new(
      {
        adjLabelstyle = adjStyle,
        buttonstyle = btnStyle,
        x = con.x or "30%",
        y = con.y or "30%",
        height = con.height or "30%",
        width = con.width or "30%",
        name = con.name or "newFrame",
        titleText = con.titleText or "New Frame",
        titleTxtColor = containerTitleHex,
        buttonsize = minBar
      },parent
    )
--  newFrame.exitLabel:resize(padding_y,padding_y)
--  newFrame.exitLabel:move(-(padding_y*2),padding_x)
--  newFrame.minimizeLabel:resize(padding_y,padding_y)
--  newFrame.minimizeLabel:move(-(padding_y*3.3),padding_x)
  newFrame.Inside:resize(_,-(padding_y*2))  
  newFrame:setPadding(padding_y)
  newFrame:save()
  return newFrame
end

function eleFrame:getBot(frame)
  return frame.get_y()+frame.get_height()
end

function eleFrame:getRight(frame)
  return frame.get_x()+frame.get_width()
end


