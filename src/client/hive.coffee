class Hive
  SPRITES = null
  MAX_HP = 200

  constructor: (@position) ->
    @hp = MAX_HP
    @radius = 50

    unless SPRITES
      SPRITES = for index in [0..10]
        Resources.images["colmeia#{index}"]

  hit: (enemy) ->
    @hp -= 1

  isDestroyed: -> @hp <= 0

  currentImage: ->
    index = parseInt(10 * (MAX_HP - @hp) / MAX_HP) - 1
    index = 0 if index < 0
    SPRITES[index] or SPRITES.last()

  draw: (context) ->
    sprite = @currentImage()

    context.save()
    context.translate @position.x - sprite.width / 2, @position.y - sprite.height / 2
    context.drawImage sprite, 0, 0
    context.restore()

window.Hive = Hive
