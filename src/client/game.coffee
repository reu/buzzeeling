class Game
  constructor: (container = $("#game"), width = window.innerWidth, height = window.innerHeight) ->
    @canvas  = $("<canvas width='#{width}' height='#{height}'></canvas>").appendTo(container)[0]
    @context = @canvas.getContext("2d")

    # Preparing main player
    mouse    = new Mouse @canvas
    keyboard = new Keyboard
    @player = new Bee new Vector(50, 50), keyboard, mouse

    # Attaching events
    $(window).on "resize", @resize

  start: -> do @loop

  loop: =>
    requestAnimationFrame @loop
    do @update
    do @draw

  update: ->
    @player.update this

    for bullet, index in @player.bullets when bullet?
      position = bullet.position
      if position.x > @canvas.width or position.x < 0 or position.y > @canvas.height or position.y < 0
        delete @player.bullets.splice(index, 1)

  draw: ->
    do @clearScreen
    @player.draw @context

  clearScreen: ->
    @context.fillStyle = "#000"
    @context.fillRect 0, 0, @canvas.width, @canvas.height

  resize: =>
    @canvas.width  = window.innerWidth
    @canvas.height = window.innerHeight

window.Game = Game
