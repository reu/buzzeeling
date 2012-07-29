class Hive
  constructor: (@position) ->
    @sprite = new Image
    @sprite.src = "images/hive.png"
    @radius = 50

  draw: (context) ->
    context.save()
    context.translate @position.x - @sprite.width / 2, @position.y - @sprite.height / 2
    context.drawImage @sprite, 0, 0
    context.restore()

window.Hive = Hive
