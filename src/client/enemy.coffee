class Enemy extends Flier
  constructor: (@position, @speed = 5, @hp = 1, @score = 1) ->
    super @position, @speed
    @maxspeed = 1
    @maxforce = 0.1

  draw: (context) ->
    context.save()
    context.translate(@position.x - @offset.x, @position.y - @offset.y)
    offset = 50
    if @position.x < (1024 / 2) - offset
      context.translate(@offset.x * 2, 0)
      context.scale -1, 1
    @animation.draw(context)
    context.restore()

  applyForce: (force) -> @acceleration.add force

  update: (game) ->
    #targetX = 1024 / 2  + ([1, -1, 1].sample() * 50)
    #targetY = 768 / 2  + ([1, -1, 1].sample() * 50)
    @applySeek @target
    @lastPosition = @position.clone()
    @velocity.add @acceleration
    @position.add @velocity
    @acceleration = new Vector

  hit: (bullet, player) ->
    @hp -= bullet.damage
    player.score.addPoint @score if @dead()

  # Seekable
  applySeek: (target) ->
    force = @seek target
    @applyForce force

  seek: (target) ->
    desired = Vector.sub target, @position

    desired.normalize()
    desired.mult(@maxspeed)

    steering = Vector.sub desired, @velocity
    steering.limit(@maxforce)

    steering

  dead: -> @hp <= 0

window.Enemy = Enemy
