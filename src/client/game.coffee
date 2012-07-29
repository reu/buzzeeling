class Game
  constructor: (container = $("#game"), width = 1024, height = 768) ->
    @canvas  = $("<canvas width='#{width}' height='#{height}' style='position:absolute'></canvas>").appendTo(container)[0]
    @canvasDebug  = $("<canvas width='#{width}' height='#{height}' style='position:absolute'></canvas>").appendTo(container)[0]
    @context = @canvas.getContext("2d")
    @contextDebug = @canvasDebug.getContext("2d")
    @contextDebug.fillStyle = '#FFF'

    # Preparing main player
    mouse    = new Mouse container
    keyboard = new Keyboard
    @player = new Bee new Vector(50, 50), keyboard, mouse, new Score("Giuffrida")

    @hive = new Hive new Vector(1024/2, 230)

    @waveManager = new WaveManager @canvas, @hive.position

    @hits = []
    @splashes = []
    @honeys = []

    # Attaching events
    $(window).on "resize", @resize

  start: ->
    do AudioManager.gamePlay.play
    do @loop

  loop: =>
    window.animationFrameID = requestAnimationFrame @loop
    do @update
    do @draw

  checkGameOver: ->
    if @hive.isDestroyed()
      do AudioManager.gamePlay.stop
      do AudioManager.bee.stop
      do AudioManager.gameOver.play

      cancelRequestAnimationFrame window.animationFrameID
      $('#game').hide()
      $('canvas').remove()
      $('#gameover').fadeIn()

  update: ->
    return if do @checkGameOver

    @player.update this
    @player.checkLimits @canvas
    @waveManager.update this

    if @collisionBetween @hive, @player
      @player.velocity.x *= -1
      @player.velocity.y *= -1

    for bullet, index in @player.bullets when bullet?
      position = bullet.position

      if position.x > @canvas.width or position.x < 0 or position.y > @canvas.height or position.y < 0
        delete @player.bullets.splice(index, 1)
      else if bullet.active and @collisionBetween @hive, bullet
        @addHit bullet.position
        do bullet.die
      else if bullet.active
        for enemy, enemyIndex in @waveManager.enemies() when enemy?
          if @collisionBetween bullet, enemy
            @addHit bullet.position
            enemy.hit(bullet, @player)
            do bullet.die
            if enemy.dead()
              @addSplash enemy.position
              delete @waveManager.enemies().remove(enemy)

    for enemy in @waveManager.enemies() when enemy?
      if @collisionBetween @hive, enemy
        @hive.hit enemy
        @addHoney enemy.position
        force = enemy.velocity.clone()
        force.x *= -1
        force.y *= -1
        force.mult 3
        enemy.applyForce force

    for honey in @honeys when honey and honey.hasEnded()
      delete @honeys.remove(honey)

    for splash in @splashes when splash and splash.hasEnded()
      delete @splashes.remove(splash)

    for hit in @hits when hit and hit.isDead()
      delete @hits.remove(hit)

  addHit: (position) ->
    hit = new Hit(position)
    @hits.push hit

  addHoney: (position) ->
    honey = new Honey(position)
    @honeys.push honey

  addSplash: (position) ->
    splash = new Splash(position)
    @splashes.push splash

  collisionBetween: (p1, p2) ->
    delta = Vector.sub p1.position, p2.position
    distance = delta.magSq()
    radii = p1.radius + p2.radius

    distance <= radii * radii

  draw: ->
    do @clearScreen
    @hive.draw @context
    @player.mouse.draw @context
    @player.draw @context
    @waveManager.draw @context


    honey.draw @context for honey in @honeys when honey?
    splash.draw @context for splash in @splashes when splash?
    hit.draw @context for hit in @hits when hit?


  clearScreen: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height

  resize: =>
    @canvas.width  = window.innerWidth
    @canvas.height = window.innerHeight

window.Game = Game
