class BeeLauncher extends Weapon
  constructor: (@player) ->
    super @player
    @clipSize = 10
    @army = []
    for index in [1..@clipSize]
      @army.push @generateBee()
    @ammo = @army.length

  performShot: ->
    super
    miniBee = do @consumeBee
    angle = Math.atan2(@player.mouse.position.y - miniBee.position.y, @player.mouse.position.x - miniBee.position.x)
    bullet = new BeeBullet miniBee.position.clone(), angle, 20
    @player.addBullet bullet

  reloadStarted: ->
    beesToBeAdded = @clipSize - @ammo
    beesToBeAdded.times =>
      @army.push @generateBee()

  generateBee: ->
    position = new Vector 1024 / 2 + Number.random(5), 250 + Number.random(10)
    new MiniBee(position)

  consumeBee: ->
    bee = @army.shift()
    bee

  update: ->
    super

    for bee in @army when bee?
      bee.applySeparation @army
      bee.applySeek @player.position
      do bee.update

  draw: (context) ->
    for bee in @army
      bee.draw context

class SuperBeeLauncher extends BeeLauncher
  constructor: (@player) ->
    super @player
    @clipSize = 80
    @rateOfFire = 2
    @timeToReload = 0

  performShot: ->
    super
    do @reload

class MiniBee extends Module
  @include Separable
  @include Seekable

  constructor: (@position) ->
    @acceleration = new Vector 0, 0
    @velocity     = new Vector 0, 0
    @animation = new Animation("minibee", 8)
    @radius   = 5
    @maxspeed = 15
    @maxforce = 0.9
    @approximation = 5

  approximate: => if @approximation < 4 then @approximation = 4 else @approximation -= 0.6
  spread:      => if @approximation > 8 then @approximation = 8 else @approximation += 0.2

  applyForce: (force) -> @acceleration.add force

  update: ->
    @velocity.add @acceleration
    @velocity.limit @maxspeed
    @position.add @velocity
    @acceleration = new Vector(0, 0)

  draw: (context) ->
    do context.save
    context.translate(@position.x, @position.y)
    @animation.draw(context)
    do context.restore

class BeeBullet extends Bullet
  constructor: ->
    super
    @animation = new Animation("minibee_attacking", 1)
    @offset = { x: 10, y: 17 }
    @radius = 12
    @acceleration = new Vector
    @gravity = new Vector 0, 0.3
    @active = true

  draw: (context) =>
    do context.save
    context.translate(@position.x - @offset.x, @position.y - @offset.y)
    @animation.draw(context)
    do context.restore

  update: ->
    @velocity.add @gravity unless @active
    super

  die: ->
    bounce = @velocity.clone()
    bounce.x *= -1 * 0.2
    bounce.y = -5

    @velocity = bounce

    @active = false

window.BeeLauncher = BeeLauncher
window.SuperBeeLauncher = SuperBeeLauncher
