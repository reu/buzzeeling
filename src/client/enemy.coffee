class Enemy extends Flier

  constructor: (@position, @speed = 5) ->
    super @position, @speed

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

  update: (game) ->
    @applyDirection new Vector -4, 0 unless @position.x  == (game.canvas.width / 2)

window.Enemy = Enemy
