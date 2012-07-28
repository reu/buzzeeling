class BeeLauncher extends Weapon
  constructor: (@player) ->
    super @player
    @army = []
    for index in [1..25]
      @army.push @generateBee()

  shot: ->
    miniBee = do @consumeBee
    # TODO: nao é o player.angle, teriamos que calcular o angulo aqui
    bullet = new BeeBullet miniBee.position.clone(), @player.angle, 20
    @player.addBullet bullet

  generateBee: ->
    position = new Vector 1024 / 2, 768 / 2
    new MiniBee(position)

  consumeBee: ->
    bee = @army.shift()
    @army.push @generateBee()
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

class MiniBee extends Module
  @include Separable
  @include Seekable

  constructor: (@position) ->
    @acceleration = new Vector 0, 0
    @velocity     = new Vector 0, 0
    @animation = new Animation("minibee", 8, 30)
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
    @animation = new Animation("minibee_attacking", 1, 30)
  draw: (context) =>
    do context.save
    context.translate(@position.x, @position.y)
    @animation.draw(context)
    do context.restore

window.BeeLauncher = BeeLauncher
