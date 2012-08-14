class Hit
  MAX_LIFE = 5

  constructor: (@position) ->
    @position = @position.clone()
    @lifetime = MAX_LIFE

  isDead: -> @lifetime <= 0

  draw: (context) ->
    @lifetime -= 1
    context.save()
    context.globalAlpha = @lifetime / MAX_LIFE
    context.drawImage Resources["hit"], @position.x - Resources["hit"].width / 2, @position.y - Resources["hit"].height / 2
    context.restore()

window.Hit = Hit
