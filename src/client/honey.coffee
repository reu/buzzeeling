class Honey
  FRAMES = null

  constructor: (@position) ->
    @position = @position.clone()
    @currentFrame = 1
    @ended = false
    @count = 8

    unless FRAMES
      FRAMES = for index in [1..@count]
        image = new Image
        image.src = "images/mel#{index}.png"
        image

  hasEnded: -> @ended

  playCollision: ->
    collision = new Audio("sounds/hive_collision.ogg")
    collision.preload = 'auto'
    collision.volume = 0.4
    do collision.play

  draw: (context) ->
    image = FRAMES[parseInt(@currentFrame - 1)]

    if image
      context.drawImage image, @position.x - image.width / 2, @position.y - image.height / 2

    if @currentFrame >= @count
      @ended = true
    else
      @currentFrame += 0.5

window.Honey = Honey
