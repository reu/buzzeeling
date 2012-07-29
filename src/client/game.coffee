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
    mouse    = new Mouse container
    keyboard = new Keyboard
    @player = new Bee new Vector(50, 50), keyboard, mouse, new Score("Giuffrida")

    @hive = new Hive new Vector(1024/2, 230)

    @waveManager = new WaveManager @canvas, @hive.position

    # Attaching events
    $(window).on "resize", @resize

  start: -> do @loop

  loop: =>
    requestAnimationFrame @loop
    do @update
    do @draw

  update: ->
    @player.update this
    @player.checkLimits @canvas
    @waveManager.update this

    for bullet, index in @player.bullets when bullet?
      position = bullet.position

      if position.x > @canvas.width or position.x < 0 or position.y > @canvas.height or position.y < 0
        delete @player.bullets.splice(index, 1)
      else
        for enemy, enemyIndex in @waveManager.enemies() when enemy?
          delta = Vector.sub position, enemy.position
          distance = delta.magSq()

          radii = bullet.radius + enemy.radius

          if distance <= radii * radii
            enemy.hit(bullet, @player)
            delete @player.bullets.remove(bullet)
            delete @waveManager.enemies().remove(enemy) if enemy.dead()

    for enemy in @waveManager.enemies() when enemy?
      delta = Vector.sub @hive.position, enemy.position
      distance = delta.magSq()
      radii = @hive.radius + enemy.radius

      if distance <= radii * radii
        targetX = @hive.position.x + ([1, -1, 1].sample() * 50)
        targetY = @hive.position.y + ([1, -1, 1].sample() * 50)

        enemy.target = new Vector targetX, targetY

  draw: ->
    do @clearScreen
    @hive.draw @context

    @player.draw @context
    @waveManager.draw @context

    @context.save()
    @context.beginPath()
    @context.fillStyle = "#000"
    @context.fillCircle(@player.mouse.position.x, @player.mouse.position.y, 10)
    @context.closePath()
    @context.restore()

  clearScreen: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height

  resize: =>
    @canvas.width  = window.innerWidth
    @canvas.height = window.innerHeight

window.Game = Game
