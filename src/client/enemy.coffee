class Enemy extends Flier
  constructor: (@position, @speed = 5, @hp = 1) ->
    super @position, @speed

  draw: (context) ->
    context.save()
    context.translate(@position.x, @position.y)
    @animation.draw(context)
    context.restore()

  update: (game) ->
    @applyDirection new Vector -1, 0 unless @position.x <= (game.canvas.width / 2)

    @velocity.add @acceleration
    @velocity.mult 0.93
    @velocity.limit @speed
    @lastPosition = @position.clone()
    @position.add @velocity
    @acceleration = new Vector

  hit: (bullet, player)->
    player.score.addPoint 1

window.Enemy = Enemy
