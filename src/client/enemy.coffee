class Enemy extends Flier

  constructor: (@position, @speed = 5) ->
    super @position, @speed
    @animation = new Animation "mosca", 4, 50

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

window.Enemy = Enemy
