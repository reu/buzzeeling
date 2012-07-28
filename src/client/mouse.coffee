class Mouse
  constructor: (container) ->
    @position = new Vector

    @isPressed = false

    $(container).on "mousemove", @updatePosition
    $(container).on "mousedown", => @isPressed = true
    $(container).on "mouseup",   => @isPressed = false

  updatePosition: (event) =>
    [@position.x, @position.y] = [event.offsetX, event.offsetY]

window.Mouse = Mouse
