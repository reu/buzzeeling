class Wespa extends Enemy

  constructor: (@position) ->
    @speed = 10
    @hp = 3
    @score = 300
    super @position, @speed, @hp, @score
    @animation = new Animation("wespa", 8)

window.Wespa = Wespa
