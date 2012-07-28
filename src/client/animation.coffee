class Animation
  constructor: (@prefix, @count) ->
    @currentFrame = 1

    @frames = for index in [1..@count]
      image = new Image
      image.src = "images/#{@prefix}#{index}.png"
      image

  draw: (context) ->
    context.drawImage @frames[@currentFrame - 1], 0, 0, 70, 70

    if @currentFrame >= @count
      @currentFrame = 1
    else
      @currentFrame = @currentFrame + 1

window.Animation = Animation
