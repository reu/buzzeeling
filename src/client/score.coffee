class Score
  constructor: (@pName) ->
    @points = [0]

  draw: (context) ->
    context.font = "bold 20px arial"
    context.fillStyle = "#fff"
    context.fillText("#{@pName} SCORE: #{@points.last()}", 15, 30)

  update: (context) ->
    totalPoints = @points.reduce (total, points)->
      total += points
    , 0
    @points = [totalPoints]

  addPoint: (points) ->
    @points.push points

window.Score = Score
