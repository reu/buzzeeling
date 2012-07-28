class Game
  constructor: (container = $("#game"), width = window.innerWidth, height = window.innerHeight) ->
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
    @player = new Bee new Vector(50, 50), keyboard, mouse

    @enemies = []
    for i in [1..5]
      @enemies.push new Enemy new Vector((@canvas.width + 100), (@canvas.height / 2) + i * 30)
    @score = new Score "Player"

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

    @score.update @context

    for bullet, index in @player.bullets when bullet?
      position = bullet.position
      if position.x > @canvas.width or position.x < 0 or position.y > @canvas.height or position.y < 0
        delete @player.bullets.splice(index, 1)
      else
        for enemy, enemyIndex in @enemies when enemy?
          bulletResultVector = Vector.sub bullet.lastPosition, position
          bulletWidth = bulletResultVector.mag()

          enemyResultVector = Vector.sub enemy.lastPosition, enemy.position
          enemyWidth = enemyResultVector.mag()

          if @intersects enemy.lastPosition.x, enemy.lastPosition.y, enemyWidth, 5, bullet.lastPosition.x, bullet.lastPosition.y, bulletWidth, 10
            delete @player.bullets.splice(index, 1)
            delete @enemies.splice(enemyIndex, 1)

          if @intersects enemy.position.x, enemy.position.y, enemyWidth, 5, bullet.position.x, bullet.position.y, bulletWidth, 10
            delete @enemies.splice(enemyIndex, 1)
            delete @player.bullets.splice(index, 1)

    if @enemies.length == 0
      for i in [1..5]
        @enemies.push new Enemy new Vector((@canvas.width + 100), (@canvas.height / 2) + i * 30)

  intersects: (x1, y1, w1, h1, x2, y2, w2, h2) ->
    w2 += x2
    w1 += x1
    return false if x2 > w1 or x1 > w2
    h2 += y2
    h1 += y1
    return false if y2 > h1 or y1 > h2
    true

  draw: ->
    do @clearScreen
    @player.draw @context
    for enemy in @enemies when enemy?
      enemy.draw @context
    @score.draw @context

  clearScreen: ->
    @context.fillStyle = "#000"
    @context.fillRect 0, 0, @canvas.width, @canvas.height

  resize: =>
    @canvas.width  = window.innerWidth
    @canvas.height = window.innerHeight

window.Game = Game
