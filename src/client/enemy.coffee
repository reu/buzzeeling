class Enemy extends Flier
  constructor: (@position, @speed = 5, @hp = 1) ->
    super @position, @speed
    @maxspeed = 1
    @maxforce = 10

  draw: (context) ->
    context.save()
    context.translate(@position.x, @position.y)
    @animation.draw(context)
    context.restore()

  applyForce: (force) -> @acceleration.add force

  update: (game) ->
    targetX = 1024 / 2  + ([1, -1, 1].sample() * 50)
    targetY = 768 / 2  + ([1, -1, 1].sample() * 50)
    @applySeek new Vector targetX, targetY
    @lastPosition = @position.clone()
    @velocity.add @acceleration
    @position.add @velocity
    @acceleration = new Vector

  hit: (bullet, player)->
    player.score.addPoint 1

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

window.Enemy = Enemy
