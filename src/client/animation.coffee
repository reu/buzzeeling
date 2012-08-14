class Animation
  constructor: (@prefix, @count, @scale = 70) ->
    @currentFrame = 1

    @frames = for index in [1..@count]
      Resources.images["#{@prefix}#{index}"]

  draw: (context) ->
    context.drawImage @frames[@currentFrame - 1], 0, 0

    if @currentFrame >= @count
      @currentFrame = 1
    else
      @currentFrame = @currentFrame + 1

window.Animation = Animation
