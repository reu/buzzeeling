class Hit
  SPRITE = null
  MAX_LIFE = 5

  constructor: (@position) ->
    @position = @position.clone()
    @lifetime = MAX_LIFE

    unless SPRITE
      SPRITE = new Image
      SPRITE.src = "images/hit.png"

  isDead: -> @lifetime <= 0

  draw: (context) ->
    @lifetime -= 1
    context.save()
    context.globalAlpha = @lifetime / MAX_LIFE
    context.drawImage SPRITE, @position.x - SPRITE.width / 2, @position.y - SPRITE.height / 2
    context.restore()

window.Hit = Hit
