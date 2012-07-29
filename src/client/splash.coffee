class Splash
  FRAMES = null

  constructor: (@position) ->
    @position = @position.clone()
    @currentFrame = 1
    @ended = false
    @count = 8

    unless FRAMES
      FRAMES = for index in [1..@count]
        image = new Image
        image.src = "images/splash#{index}.png"
        image

  hasEnded: -> @ended

  draw: (context) ->
    image = FRAMES[@currentFrame - 1]

    if image
      context.drawImage image, @position.x - image.width / 2, @position.y - image.height / 2

    if @currentFrame >= @count
      @ended = true
    else
      @currentFrame += 1

window.Splash = Splash
