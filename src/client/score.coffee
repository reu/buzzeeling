class Score
  constructor: (@pName) ->
    @points = [0]
    @image = Resources.images["score"]

  draw: (context) ->

    context.save()
    context.translate(0, context.canvas.height - 144)
    context.drawImage @image, 0, 0
    context.font = "bold 20px arial"
    context.fillStyle = "#000"
    context.fillText("#{@points.last()}", 125, 44)
    context.restore()

  update: (context) ->
    totalPoints = @points.reduce (total, points)->
      total += points
    , 0
    @points = [totalPoints]

  addPoint: (points) ->
    @points.push points

window.Score = Score
