class Beezerk
  FRAMES = null

  constructor: (@position) ->
    @position = @position.clone()
    @currentFrame = 1
    @soundEffectPlayed = false
    @ended = false
    @count = 8

    unless FRAMES
      FRAMES = for index in [1..@count]
        image = new Image
        image.src = "images/beezerk#{index}.png"
        image

  hasEnded: -> @ended

  draw: (context) ->
    unless @soundEffectPlayed
      @soundEffectPlayed = true
      do AudioManager.yay.play

    image = FRAMES[@currentFrame - 1] || FRAMES.last()

    console.log @position.toString()

    if image
      context.drawImage image, @position.x - image.width / 2, @position.y - image.height / 2

    if @currentFrame >= 50
      @ended = true
    else
      @currentFrame += 1

window.Beezerk = Beezerk
