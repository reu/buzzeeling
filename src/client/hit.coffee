class Hit
  MAX_LIFE = 5
  SPRITE = null

  constructor: (@position) ->
    @position = @position.clone()
    @lifetime = MAX_LIFE
    SPRITE = Resources.images["hit"] unless SPRITE

  isDead: -> @lifetime <= 0

  draw: (context) ->
    @lifetime -= 1
    context.save()
    context.globalAlpha = @lifetime / MAX_LIFE
    context.drawImage SPRITE, @position.x - SPRITE.width / 2, @position.y - SPRITE.height / 2
    context.restore()

window.Hit = Hit
