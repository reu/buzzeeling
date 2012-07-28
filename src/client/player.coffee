class Player
  @COMMANDS:
    WALK_UP:      Keyboard.KEYS.W
    WALK_LEFT:    Keyboard.KEYS.A
    WALK_DOWN:    Keyboard.KEYS.S
    WALK_RIGHT:   Keyboard.KEYS.D
    USE_PISTOL:   Keyboard.KEYS.NUMBER1
    USE_DPISTOLS: Keyboard.KEYS.NUMBER2
    USE_SHOTGUN:  Keyboard.KEYS.NUMBER3

  constructor: (@keyboard, @mouse) ->
    @position = new Vector 50, 50
    @angle = 0
    @bullets = []
    @weapon = new Pistol(this)
    @speed = 2

  applyDirection: (force) -> @position.add force.mult(@speed)

  draw: (context) ->
    context.save()
    context.strokeStyle = context.fillStyle = "#fff"
    context.beginPath()
    context.translate(@position.x, @position.y)
    context.rotate @angle
    context.moveTo -8, -8
    context.lineTo 12, 0
    context.lineTo -8, 8
    context.closePath()
    context.stroke()
    context.restore()

    bullet.draw context for bullet in @bullets

  update: (game) ->
    @angle = Math.atan2(@mouse.position.y - @position.y, @mouse.position.x - @position.x)

    @applyDirection new Vector -1, 0 if @keyboard.isKeyPressed Player.COMMANDS.WALK_LEFT
    @applyDirection new Vector 1,  0 if @keyboard.isKeyPressed Player.COMMANDS.WALK_RIGHT
    @applyDirection new Vector 0, -1 if @keyboard.isKeyPressed Player.COMMANDS.WALK_UP
    @applyDirection new Vector 0,  1 if @keyboard.isKeyPressed Player.COMMANDS.WALK_DOWN

    @weapon = new Pistol(this)       if @keyboard.isKeyPressed Player.COMMANDS.USE_PISTOL
    @weapon = new DoublePistol(this) if @keyboard.isKeyPressed Player.COMMANDS.USE_DPISTOLS
    @weapon = new Shotgun(this)      if @keyboard.isKeyPressed Player.COMMANDS.USE_SHOTGUN

    do @weapon.update
    do @weapon.shot if @mouse.isPressed and @weapon.canFire

    do bullet.update for bullet in @bullets

  addBullet: (bullet) ->
    @bullets.push bullet

window.Player = Player
