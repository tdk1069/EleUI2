function setBorders(type)
  type = type:lower() or ""
  brax.left_container = brax.left_container or Geyser.Container:new({
    name = "brax.left_container",
    x=0, y=0,
    width = 0, height="100%",
  })
  brax.left_image = brax.left_image or Geyser.Label:new({
    name = "brax.left_image",
    x = "0%", y = "0%",
    width = "100%", height = "100%",
  },brax.left_container)
  brax.left_image:setBackgroundImage(getMudletHomeDir().."/imgs/texture.jpg")
  brax.left_container:hide()
  brax.right_container = brax.right_container or Geyser.Container:new({
    name = "brax.right_container",
    x=0, y=0,
    width = 0, height="100%",
  })
  brax.right_image = brax.right_image or Geyser.Label:new({
    name = "brax.right_image",
    x = "0%", y = "0%",
    width = "100%", height = "100%",
  },brax.right_container)
  brax.right_image:setBackgroundImage(getMudletHomeDir().."/imgs/texture.jpg")
  brax.right_container:hide()
  
  local fx, fy = calcFontSize()
  local winx, winy = getMainWindowSize()
  local newBorder = winx - fx*80
  if type == "right" then 
    brax.right_container:hide()
    brax.left_container:show()
    brax.left_container:resize(newBorder,nil)
    brax.left_container:move(winx-newBorder,nil)
    brax.left_image:lower()
    setBorderRight(newBorder) 
    setBorderLeft(0) 
  elseif type == "left" then 
    brax.left_container:hide()
    brax.right_container:show()
    brax.right_container:resize(newBorder,nil)
    brax.right_container:move(0,nil)
    brax.right_image:lower()
    setBorderLeft(newBorder) 
    setBorderRight(0) 
  elseif type == "center" then 
    setBorderLeft(newBorder/2) 
    setBorderRight(newBorder/2) 
    brax.right_container:resize(newBorder/2,nil)
    brax.right_container:move(0,nil)
    brax.left_container:resize(winx-newBorder + (newBorder/2),nil)
    brax.left_container:move(0,nil)
    brax.right_container:show()
    brax.left_container:show()
  end
end