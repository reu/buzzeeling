class Battrick extends Enemy

  constructor: (@position) ->
    @speed = 7
    @hp = 5
    @score = 500
    super @position, @speed, @hp, @score
    @animation = new Animation("battrick", 8)

window.Battrick = Battrick
