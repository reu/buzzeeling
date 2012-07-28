class Bee extends Flier
  FRICTION = 0.93

  @COMMANDS:
    WALK_UP:      Keyboard.KEYS.W
    WALK_LEFT:    Keyboard.KEYS.A
    WALK_DOWN:    Keyboard.KEYS.S
    WALK_RIGHT:   Keyboard.KEYS.D
    USE_PISTOL:   Keyboard.KEYS.NUMBER1
    USE_DPISTOLS: Keyboard.KEYS.NUMBER2
    USE_SHOTGUN:  Keyboard.KEYS.NUMBER3

  constructor: (@position, @keyboard, @mouse) ->
    super @position, @speed = 20
    @angle = 0
    @bullets = []
    @weapon = new BeeLauncher(this)
    @animation = new Animation("giuffrida", 4)

  draw: (context) ->
    context.save()
    context.translate(@position.x, @position.y)
    @animation.draw(context)
    context.restore()

    @weapon.draw context
    bullet.draw context for bullet in @bullets

  update: (game) ->
    @angle = Math.atan2(@mouse.position.y - @position.y, @mouse.position.x - @position.x)

    if @position.x > 15 and @keyboard.isKeyPressed Bee.COMMANDS.WALK_LEFT
      @applyDirection new Vector -1, 0

    if @position.x < game.canvas.width - 30 and @keyboard.isKeyPressed Bee.COMMANDS.WALK_RIGHT
      @applyDirection new Vector 1,  0

    if @position.y > 15 and @keyboard.isKeyPressed Bee.COMMANDS.WALK_UP
      @applyDirection new Vector 0, -1

    if @position.y < game.canvas.height - 30 and @keyboard.isKeyPressed Bee.COMMANDS.WALK_DOWN
      @applyDirection new Vector 0,  1

    @weapon = new Pistol(this)       if @keyboard.isKeyPressed Bee.COMMANDS.USE_PISTOL
    @weapon = new DoublePistol(this) if @keyboard.isKeyPressed Bee.COMMANDS.USE_DPISTOLS
    @weapon = new Shotgun(this)      if @keyboard.isKeyPressed Bee.COMMANDS.USE_SHOTGUN

    @velocity.add @acceleration
    @velocity.mult FRICTION
    @velocity.limit @speed
    @position.add @velocity
    @acceleration = new Vector

    do @weapon.update
    do @weapon.shot if @mouse.isPressed and @weapon.canFire

    do bullet.update for bullet in @bullets

  addBullet: (bullet) ->
    @bullets.push bullet

window.Bee = Bee
