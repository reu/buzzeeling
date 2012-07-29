class Mouse
  constructor: (container) ->
    @position = new Vector
    @animation = new Animation("target",1)

    @isPressed = false

    $(container).on "mousemove", @updatePosition
    $(container).on "mousedown", => @isPressed = true
    $(container).on "mouseup",   => @isPressed = false

  updatePosition: (event) =>
    [@position.x, @position.y] = [event.offsetX, event.offsetY]

   draw: (context) ->
     context.save()
     context.translate(@position.x, @position.y, 10)
     @animation.draw(context)
     context.restore()

window.Mouse = Mouse
