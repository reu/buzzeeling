class Battrick extends Enemy

  constructor: (@position) ->
    @speed = 7
    @hp = 5
    @score = 500
    super @position, @speed, @hp, @score
    @animation = new Animation("battrick", 8)
    @offset = { x: 60, y: 80 }
    @radius = 20

window.Battrick = Battrick
