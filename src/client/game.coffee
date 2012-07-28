class Game
  constructor: (container = $("#game"), width = 1024, height = 768) ->
    @canvas  = $("<canvas width='#{width}' height='#{height}' style='position:absolute'></canvas>").appendTo(container)[0]
    @canvasDebug  = $("<canvas width='#{width}' height='#{height}' style='position:absolute'></canvas>").appendTo(container)[0]
    @context = @canvas.getContext("2d")
    @contextDebug = @canvasDebug.getContext("2d")
    @contextDebug.fillStyle = '#FFF'
    @snd = new Audio "sounds/abelha-bg.ogg"
    @snd.loop = true
    #@snd.play()

    # Preparing main player
    mouse    = new Mouse document
    keyboard = new Keyboard
    @player = new Bee new Vector(50, 50), keyboard, mouse, new Score("Giuffrida")

    @enemies = []
    for i in [1..5]
      @enemies.push new Flyghter new Vector((@canvas.width + 100), (@canvas.height / 2) + i * 30)

    # Attaching events
    $(window).on "resize", @resize

  start: -> do @loop

  loop: =>
    requestAnimationFrame @loop
    do @update
    do @draw

  update: ->
    @player.update this
    for enemy in @enemies when enemy?
      enemy.update this

    for bullet, index in @player.bullets when bullet?
      position = bullet.position

      if position.x > @canvas.width or position.x < 0 or position.y > @canvas.height or position.y < 0
        delete @player.bullets.splice(index, 1)
      else
        for enemy, enemyIndex in @enemies when enemy?
          delta = Vector.sub position, enemy.position
          distance = delta.magSq()

          radii = bullet.radius + enemy.radius

          if distance <= radii * radii
            enemy.hit(bullet, @player)
            delete @enemies.remove(enemy)
            delete @player.bullets.remove(bullet)

    if @enemies.length == 0
      for i in [1..5]
        @enemies.push new Flyghter new Vector((@canvas.width + 100), (@canvas.height / 2) + i * 30)

  draw: ->
    do @clearScreen
    @player.draw @context

    for enemy in @enemies when enemy?
      enemy.draw @context

  clearScreen: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height

  resize: =>
    @canvas.width  = window.innerWidth
    @canvas.height = window.innerHeight

window.Game = Game
