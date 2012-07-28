class Score
  constructor: (name) ->
    @pName = name
    @points = 0

  draw: (context) ->
    context.font = "bold 20px arial"
    context.fillStyle = "#fff"
    context.fillText("#{@pName} SCORE:", 15, 30)

  update: (context) ->
    @points += 1
    context.font = "bold 20px arial"
    context.fillStyle = "#fff"
    context.fillText("#{@pName} SCORE: #{@points}", 15, 30)

window.Score = Score
