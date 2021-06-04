EleUI = EleUI or {}

function EleUI:createWindow(params)
  local params = params or {}
  params.x = params.x or "10%"
  params.y = params.x or "10%"
  params.height = params.height or "80%"
  params.width = params.width or "80%"
  params.name = params.name or ""
  params.titleText = params.titleText or ""
  local newWindow
  newWindow =
    Adjustable.Container:new(
      {
        x = params.x,
        y = params.y,
        name = params.name,
        titleText = params.titleText,
        height = params.height,
        width = params.width,
      }
    )
  newWindow.adjLabel:setStyleSheet(
    [[
    border-top: 85px solid transparent;border-bottom:50px;border-left:115px;border-right:115px;border-image: url(]] ..
    getMudletHomeDir() ..
    [[/EleUI2/imgs/UI_Window.png) fill;padding-top:-95px;]]
  )
  return newWindow
end
