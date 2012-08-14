class Splash
  FRAMES = null

  constructor: (@position) ->
    @position = @position.clone()
    @currentFrame = 1
    @soundEffectPlayed = false
    @ended = false
    @count = 8

    unless FRAMES
      FRAMES = for index in [1..@count]
        Resources.images["splash#{index}"]

  hasEnded: -> @ended

  draw: (context) ->
    unless @soundEffectPlayed
      @soundEffectPlayed = true
      do AudioManager.splash.play

    image = FRAMES[@currentFrame - 1]

    if image
      context.drawImage image, @position.x - image.width / 2, @position.y - image.height / 2

    if @currentFrame >= @count
      @ended = true
    else
      @currentFrame += 1

window.Splash = Splash
